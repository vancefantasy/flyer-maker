package com.flyer.maker.freemarker;

import com.flyer.maker.base.Config;
import freemarker.template.Configuration;
import freemarker.template.TemplateModelException;

import java.io.IOException;
import java.util.Locale;

/**
 * freemarker配置初始化
 */
public class FreemarkerConfig {

    private static Configuration config;

    public static Configuration getConfiguration() throws IOException, TemplateModelException {
        if (config == null) {
            config = new Configuration(Configuration.VERSION_2_3_28);
            config.setClassForTemplateLoading(FreemarkerConfig.class, "templete");
            config.setLocale(Locale.CHINA);
            config.setDefaultEncoding("UTF-8");
            config.setSharedVariable("projectPackage", Config.projectPackage);
            config.setSharedVariable("author", Config.author);
            config.setSharedVariable("projectGroupId", Config.projectGroupId);
            config.setSharedVariable("projectArtifactId", Config.projectArtifactId);
            config.setSharedVariable("mysqlJdbcUrl", Config.mysqlJdbcUrl);
            config.setSharedVariable("mysqlUsername", Config.mysqlUsername);
            config.setSharedVariable("mysqlPassword", Config.mysqlPassword);
        }
        return config;
    }

}
