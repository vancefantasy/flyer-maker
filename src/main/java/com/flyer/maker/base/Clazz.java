package com.flyer.maker.base;

import java.util.List;

/**
 * 对应一张表
 */
public class Clazz {
    /**
     * 表名称
     */
    private String tableName;
    /**
     * 表名称(去前缀，全小写)
     */
    private String resouceName;
    /**
     * 类名称(首字母小写)
     */
    private String className;
    /**
     * 类描述
     */
    private String desc;
    /**
     * 类名称(首字母大写)
     */
    private String bclassName;

    private String idType;

    private String idTypeSimple;
    /**
     * 类字段列表（用于生成entity属性）
     */
    private List<Field> fieldList;
    /**
     * 类字段列表（用于生成mybatis sql，表所有字段）
     */
    private List<Field> tablefieldList;
    /**
     * 类字段列表（用于生成mybatis sql，去除id的所有字段）
     */
    private List<Field> insertfieldList;

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getResouceName() {
        return resouceName;
    }

    public void setResouceName(String resouceName) {
        this.resouceName = resouceName;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getBclassName() {
        return bclassName;
    }

    public void setBclassName(String bclassName) {
        this.bclassName = bclassName;
    }

    public String getIdType() {
        return idType;
    }

    public void setIdType(String idType) {
        this.idType = idType;
    }

    public List<Field> getFieldList() {
        return fieldList;
    }

    public void setFieldList(List<Field> fieldList) {
        this.fieldList = fieldList;
    }

    public List<Field> getTablefieldList() {
        return tablefieldList;
    }

    public void setTablefieldList(List<Field> tablefieldList) {
        this.tablefieldList = tablefieldList;
    }

    public List<Field> getInsertfieldList() {
        return insertfieldList;
    }

    public void setInsertfieldList(List<Field> insertfieldList) {
        this.insertfieldList = insertfieldList;
    }

    public String getIdTypeSimple() {
        return idTypeSimple;
    }

    public void setIdTypeSimple(String idTypeSimple) {
        this.idTypeSimple = idTypeSimple;
    }
}
