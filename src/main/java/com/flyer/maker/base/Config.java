package com.flyer.maker.base;

import java.util.HashSet;
import java.util.Set;

/**
 * 配置项
 */
public class Config {

    //properties begin
    public static String author = "flyermaker";
    public static String targetDir = System.getProperty("user.dir");

    public static String projectType = null;
    public static String projectGroupId = null;
    public static String projectArtifactId = null;
    public static String projectPackage = null;

    public static String mysqlJdbcUrl = null;
    public static String mysqlUsername = null;
    public static String mysqlPassword = null;
    //properties end

    public static Set<String> tableIncludeList = new HashSet<>();
    public static Set<String> tableExcludeList = new HashSet<>();
    public static Set<String> columnExcludeList = new HashSet<>();


}
