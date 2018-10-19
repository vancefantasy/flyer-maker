package com.flyer.maker.utils;

/**
 * 字符串格式化工具
 */
public class FormatUtil {

    /**
     * 去除下划线，并大写下划线右边首字母(第一个字母小写)
     */
    public static String formatField(String field) {
        field = field.toLowerCase();
        String[] strs = field.split("_");
        field = strs[0];
        for (int i = 1; i < strs.length; i++) {
            String tempStr = strs[i].toLowerCase();
            tempStr =
                tempStr.substring(0, 1).toUpperCase() + tempStr.substring(1, tempStr.length());
            field = field + tempStr;
        }
        return field;
    }

    public static String formatBField(String field) {
        field = formatField(field);
        field = field.substring(0, 1).toUpperCase() + field.substring(1, field.length());
        return field;
    }

    /**
     * user_money ->userMoney
     */
    public static String formatClassName(String tableName) {
        tableName = tableName.toLowerCase();
        return formatField(tableName);
    }

    /**
     * user_money -> UserMoney
     */
    public static String formatBClassName(String tableName) {
        tableName = formatResource(tableName);
        tableName = formatField(tableName);
        tableName =
            tableName.substring(0, 1).toUpperCase() + tableName.substring(1, tableName.length());
        return tableName;
    }

    public static String formatResource(String tableName) {
        tableName = tableName.toLowerCase();
        return tableName;
    }
}
