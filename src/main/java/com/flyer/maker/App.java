package com.flyer.maker;

import com.flyer.maker.base.Config;
import com.flyer.maker.base.ConfigSupport;
import com.flyer.maker.generator.Generator;
import com.flyer.maker.generator.GeneratorFactory;
import org.apache.commons.cli.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;

/**
 * flyermaker入口函数
 */
public class App {

    private final static Logger log = LoggerFactory.getLogger(App.class);

    private static boolean resolveConfig = false;

    private final static String version = "0.0.1";

    public static void main(String[] args) {
        String isCli = System.getProperty("cli");
        if (Boolean.valueOf(isCli)) {
            resolveCli(args);
        } else {
            ConfigSupport.loadConfigFromClasspath();
            resolveConfig = true;
        }

        if (resolveConfig) {
            long begin = System.currentTimeMillis();
            Generator generator = GeneratorFactory.getGenerator();
            if (generator == null) {
                log.error("generator is null");
                return;
            }
            try {
                generator.generate();
                log.info("flyermaker completed in {} ms", System.currentTimeMillis() - begin);
                log.info("target dir : {}", Config.targetDir);
            } catch (Exception e) {
                log.error("generate error", e);
                //失败时清理目录
                generator.clearIfFail();
            }

        }
    }

    private static void resolveCli(String[] args) {
        CommandLineParser parser = new DefaultParser();
        CommandLine line = null;
        Option fileOption =
            Option.builder("f").hasArg().argName("file").desc("config properties file").build();
        Option versionOption = Option.builder("v").desc("print product version").build();
        Option helpOption = Option.builder("h").desc("print this help message").build();
        Options options = new Options();
        options.addOption(fileOption);
        options.addOption(versionOption);
        options.addOption(helpOption);
        try {
            line = parser.parse(options, args);
            if (line.hasOption(helpOption.getOpt())) {
                printHelp(options);
                return;
            }
            if (line.hasOption(versionOption.getOpt())) {
                System.out.println("flyermaker version : " + version);
                System.out.println(
                    "build by vance, to learn more about flyermaker, see https://github.com/vancefantasy/flyer-maker");
                return;
            }
            if (!line.hasOption(fileOption.getOpt())) {
                System.out.println("Missing argument for option: " + fileOption.getOpt());
                printHelp(options);
                return;
            }
            String configFile = line.getOptionValue(fileOption.getOpt());
            File file = new File(configFile);
            if (!file.exists()) {
                System.out.println("config file [" + configFile + "] is not exists");
                return;
            }
            ConfigSupport.loadConfigFromFile(file);
            resolveConfig = true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            printHelp(options);
        }
    }

    private static void printHelp(Options options) {
        HelpFormatter formatter = new HelpFormatter();
        formatter.printHelp("flyermaker [-f <file>] [-h] [-v]", options);
    }
}
