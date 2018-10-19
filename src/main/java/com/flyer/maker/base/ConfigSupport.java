package com.flyer.maker.base;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 解析配置
 */
public class ConfigSupport {

    private final static Logger log = LoggerFactory.getLogger(ConfigSupport.class);

    public static Properties properties = null;

    public static void loadConfigFromClasspath() {
        try {
            Properties prop = new Properties();
            InputStream in =
                ConfigSupport.class.getClassLoader().getResourceAsStream("application.properties");
            prop.load(in);
            properties = prop;
            print();
            init();
        } catch (IOException e) {
            log.error("load config error", e);
        }
    }

    public static void loadConfigFromFile(File file) {
        try {
            InputStream inStream = new FileInputStream(file);
            Properties prop = new Properties();
            prop.load(inStream);
            properties = prop;
            print();
            init();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void print() {
        if (properties != null) {
            for (String key : properties.stringPropertyNames()) {
                log.debug("key: {}, value : {}", key, properties.getProperty(key));
            }
        }
    }

    private static void init() {
        String author = properties.getProperty("author");
        String targetDir = properties.getProperty("target.dir");
        String projectType = properties.getProperty("project.type");
        String projectGroupId = properties.getProperty("project.groupId");
        String projectArtifactId = properties.getProperty("project.artifactId");
        String projectPackage = properties.getProperty("project.package");
        String mysqlJdbcUrl = properties.getProperty("mysql.jdbc.url");
        String mysqlUsername = properties.getProperty("mysql.username");
        String mysqlPassword = properties.getProperty("mysql.password");

        if (StringUtils.isNotBlank(projectType)) {
            Config.projectType = projectType;
        } else {
            throw new RuntimeException("project.type is null");
        }

        if (StringUtils.isNotBlank(projectGroupId)) {
            Config.projectGroupId = projectGroupId;
        } else {
            throw new RuntimeException("project.groupId is null");
        }
        if (StringUtils.isNotBlank(projectArtifactId)) {
            Config.projectArtifactId = projectArtifactId;
        } else {
            throw new RuntimeException("project.artifact is null");
        }
        if (StringUtils.isNotBlank(projectPackage)) {
            Config.projectPackage = projectPackage;
        } else {
            throw new RuntimeException("project.package is null");
        }
        if (StringUtils.isNotBlank(mysqlJdbcUrl)) {
            Config.mysqlJdbcUrl = mysqlJdbcUrl;
        } else {
            throw new RuntimeException("mysql.jdbc.url is null");
        }
        if (StringUtils.isNotBlank(mysqlUsername)) {
            Config.mysqlUsername = mysqlUsername;
        } else {
            throw new RuntimeException("mysql.username is null");
        }
        if (StringUtils.isNotBlank(mysqlPassword)) {
            Config.mysqlPassword = mysqlPassword;
        } else {
            throw new RuntimeException("mysql.password is null");
        }
        if (StringUtils.isNotBlank(author)) {
            Config.author = author;
        }
        if (StringUtils.isNotBlank(targetDir)) {
            Config.targetDir = targetDir;
        }
        String mysqlTableInclude = properties.getProperty("mysql.table.include");
        String mysqlTableExclude = properties.getProperty("mysql.table.exclude");
        String mysqlColumnExclude = properties.getProperty("mysql.column.exclude");

        if (StringUtils.isNotBlank(mysqlTableInclude)) {
            for (String table : mysqlTableInclude.split(",")) {
                if (StringUtils.isNotBlank(table)) {
                    Config.tableIncludeList.add(table);
                }
            }
        }

        if (StringUtils.isNotBlank(mysqlTableExclude)) {
            for (String table : mysqlTableExclude.split(",")) {
                if (StringUtils.isNotBlank(table)) {
                    Config.tableExcludeList.add(table);
                }
            }
        }

        Config.columnExcludeList.add("_timestamp");
        if (StringUtils.isNotBlank(mysqlColumnExclude)) {
            for (String table : mysqlColumnExclude.split(",")) {
                if (StringUtils.isNotBlank(table)) {
                    Config.columnExcludeList.add(table);
                }
            }
        }
    }

}
