package com.flyer.maker.utils;

import com.flyer.maker.freemarker.FreemarkerConfig;
import freemarker.template.Template;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.util.Map;

/**
 * Generator Utils
 */
public class GU {

    private final static Logger log = LoggerFactory.getLogger(GU.class);

    /**
     * create a dir
     *
     * @param path
     */
    public static void d(String path) {
        if (StringUtils.isNotBlank(path)) {
            try {
                FileUtils.forceMkdir(new File(path));
            } catch (IOException e) {
                log.error("create dir {} error", path, e);
            }
            log.debug("create dir {}", path);
        }
    }

    /**
     * create more than one dir
     *
     * @param paths
     */
    public static void d(String... paths) {
        if (paths != null) {
            for (String path : paths) {
                d(path);
            }
        }
    }

    /**
     * generate file with freemarker template file
     * @param file target file path
     * @param templeteFile
     */
    public static void f(String file, String templeteFile) {
        f(file, templeteFile, null);
    }

    /**
     * generate file with freemarker template file
     * @param file target file path
     * @param templeteFile freemarker template file
     * @param data
     */
    public static void f(String file, String templeteFile, Map<String, Object> data) {
        generateFile(templeteFile, file, data);
    }

    private static void generateFile(String templateFileName, String fileNamePath,
        Map<String, Object> data) {
        try {
            FileUtils.forceMkdir(new File(fileNamePath).getParentFile());
            Template template = FreemarkerConfig.getConfiguration().getTemplate(templateFileName + ".ftl");
            Writer out = new OutputStreamWriter(new FileOutputStream(fileNamePath), "UTF-8");
            template.process(data, out);
            out.close();
        } catch (Exception e) {
            log.error("freemarker template.process error", e);
        }
    }
}
