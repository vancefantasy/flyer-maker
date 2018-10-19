package com.flyer.maker.parser.impl;

import com.flyer.maker.base.Clazz;
import com.flyer.maker.base.Config;
import com.flyer.maker.base.Field;
import com.flyer.maker.parser.Parser;
import com.flyer.maker.utils.DBUtil;
import com.flyer.maker.utils.FormatUtil;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * MySQL parser
 */
public class MySQLParser implements Parser {

    private final Logger log = LoggerFactory.getLogger(MySQLParser.class);

    private final static String driverClass = "com.mysql.jdbc.Driver";

    private Connection connection;

    public MySQLParser(String url, String user, String password)
        throws SQLException, ClassNotFoundException {
        connection = DBUtil.getConnection(driverClass, url, user, password);
    }

    @Override
    public List<Clazz> parseDatabase() throws SQLException {
        String database = connection.getCatalog();
        if (StringUtils.isBlank(database)) {
            throw new RuntimeException("please assign the db in db url");
        }
        Statement stmt = connection.createStatement();
        String tsql =
            "select table_name ,table_comment from information_schema.tables where table_schema = '"
                + database + "'";
        ResultSet rs = stmt.executeQuery(tsql);
        List<Clazz> clazzList = new ArrayList<Clazz>();
        String tableName;
        while (rs.next()) {
            tableName = rs.getString(1).toLowerCase();
            //白名单、黑名单过滤
            if (!Config.tableIncludeList.isEmpty()) {
                if (!Config.tableIncludeList.contains(tableName)) {
                    continue;
                }
            } else {
                if (!Config.tableExcludeList.isEmpty()) {
                    if (Config.tableExcludeList.contains(tableName)) {
                        continue;
                    }
                }
            }
            Clazz clazz = new Clazz();
            clazz.setTableName(tableName);
            clazz.setClassName(FormatUtil.formatClassName(tableName));
            clazz.setBclassName(FormatUtil.formatBClassName(tableName));
            clazz.setResouceName(FormatUtil.formatResource(tableName));
            clazz.setDesc(rs.getString(2));
            List<Field> fieldList = getField(database, tableName);
            clazzList.add(builder(clazz, fieldList));
        }
        DBUtil.closeConnection(connection);
        return clazzList;
    }

    private List<Field> getField(String database, String tableName) throws SQLException {
        String sql =
            ("select column_name,data_type,column_comment,character_maximum_length,extra from information_schema.columns where table_name = '"
                + tableName + "'" + " and table_schema = '" + database + "'");
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        List<Field> filedList = new ArrayList<>();
        while (rs.next()) {
            String columnName = rs.getString(1);
            if (Config.columnExcludeList.contains(columnName)) {
                continue;
            }
            Field filed = new Field();
            filed.setTname(columnName.toLowerCase());
            filed.setBname(FormatUtil.formatBField(columnName));
            filed.setName(FormatUtil.formatField(columnName));
            filed.setClassType(convertClass(rs.getString(2).toLowerCase()));
            filed.setDesc(rs.getString(3).toLowerCase());

            long len = 3;
            try {
                len = calMaxRandomLen(rs);
            } catch (Exception e) {
                log.error("table : {}, columnName : {} calMaxRandomLen error", tableName,
                    columnName);
            }
            filed.setMaxRandomLen((int)len);
            filed.setExtra(rs.getString(5).toLowerCase());
            filedList.add(filed);
        }
        return filedList;
    }

    private Clazz builder(Clazz clazz, List<Field> fieldList) {
        List<Field> insertfiledList = new ArrayList<Field>();
        List<Field> classfiledList = new ArrayList<Field>();
        for (Field field : fieldList) {
            if (field.getTname().equals("id") || field.getExtra().equalsIgnoreCase("auto_increment")) {
                clazz.setIdType(field.getClassType());
                clazz.setIdTypeSimple(
                    "Integer".equals(field.getClassType()) ? "Int" : field.getClassType());
            } else {
                insertfiledList.add(field);
            }
            classfiledList.add(field);
        }
        clazz.setTablefieldList(fieldList);
        clazz.setInsertfieldList(insertfiledList);
        clazz.setFieldList(classfiledList);
        return clazz;
    }

    public String convertClass(String fieldType) {
        if (fieldType.contains("char"))
            fieldType = "String";
        else if (fieldType.contains("bigint"))
            fieldType = "Long";
        else if (fieldType.contains("int"))
            fieldType = "Integer";
        else if (fieldType.contains("float"))
            fieldType = "Float";
        else if (fieldType.contains("double"))
            fieldType = "Double";
        else if (fieldType.contains("number"))
            fieldType = "java.math.BigDecimal";
        else if (fieldType.contains("decimal"))
            fieldType = "java.math.BigDecimal";
        else if (fieldType.contains("date"))
            fieldType = "java.util.Date";
        else if (fieldType.contains("time"))
            fieldType = "java.sql.Timestamp";
        else if (fieldType.contains("blob"))
            fieldType = "byte[]";
        else
            fieldType = "String";
        return fieldType;
    }

    private long calMaxRandomLen(ResultSet rs) throws SQLException {
        long maxLen = 0;
        String fieldMaxLen = rs.getString(4);
        if (StringUtils.isNotBlank(fieldMaxLen)) {
            maxLen = Long.parseLong(fieldMaxLen) - rs.getString(1).length() - 1;
            if (maxLen > 0 && maxLen >= 20) {
                maxLen = 20;
            }
            if (maxLen < 0) {
                maxLen = -Integer.parseInt(fieldMaxLen);
                if (maxLen < -20) {
                    maxLen = -20;
                }
            }
        }
        return maxLen;
    }

}
