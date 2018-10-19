package com.flyer.maker.base;

/**
 * 对应表中的字段
 */
public class Field {
    /**
     * 表的字段名称(原名)
     */
    private String tname;
    /**
     * 字段名称(首字母小写)
     */
    private String name;
    /**
     * 字段名称(首字大小写)
     */
    private String bname;
    /**
     * 字段类型
     */
    private String classType;
    /**
     * 字段描述
     */
    private String desc;

    /**
     * EXTRA
     */
    private String extra;

    /**
     * 字段最大长度
     */
    private Integer maxRandomLen;

    public String getTname() {
        return tname;
    }

    public void setTname(String tname) {
        this.tname = tname;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBname() {
        return bname;
    }

    public void setBname(String bname) {
        this.bname = bname;
    }

    public String getClassType() {
        return classType;
    }

    public void setClassType(String classType) {
        this.classType = classType;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getExtra() {
        return extra;
    }

    public void setExtra(String extra) {
        this.extra = extra;
    }

    public Integer getMaxRandomLen() {
        return maxRandomLen;
    }

    public void setMaxRandomLen(Integer maxRandomLen) {
        this.maxRandomLen = maxRandomLen;
    }
}
