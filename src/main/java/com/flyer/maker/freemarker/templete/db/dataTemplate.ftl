package ${projectPackage}.data;

import ${projectPackage}.domain.${clazz.bclassName};
import com.vip.vjtools.vjkit.number.RandomUtil;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
public class ${clazz.bclassName}Data {

    public static List<${clazz.bclassName}> generatList(int num, boolean withId) {
        List<${clazz.bclassName}> resultList = new ArrayList<>();
        for (int i = 0; i < num; i++) {
            resultList.add(generatOne(withId, null));
        }
        return resultList;
    }

    public static ${clazz.bclassName} generatOne(boolean withId) {
        return generatOne(withId, null);
    }

    public static ${clazz.bclassName} generatOneWithGivenId(${clazz.idType} withGivenId) {
        return generatOne(false, withGivenId);
    }

    private static ${clazz.bclassName} generatOne(boolean withId, ${clazz.idType} withGivenId) {
        ${clazz.bclassName} ${clazz.className}  = new ${clazz.bclassName}();
        if (withId) {
            ${clazz.className}.setId(RandomUtil.next${clazz.idTypeSimple}());
        } else {
            if (withGivenId != null) {
                ${clazz.className}.setId(withGivenId);
            }
        }
        <#list clazz.fieldList as field>
        <#if field.tname != "id">
        ${clazz.className}.set${field.bname}(<#compress><@calcLen f=field/></#compress>);
        </#if>
        </#list>
        return ${clazz.className};
    }
}

<#macro calcLen f>
    <#if f.classType == "String">
        <#if f.maxRandomLen gt 0>"${f.tname}_" + RandomUtil.randomStringFixLength(${f.maxRandomLen})
        <#else>RandomUtil.randomStringFixLength(${f.maxRandomLen?abs})
        </#if>
    <#elseif f.classType == "Long">RandomUtil.nextLong()
    <#elseif f.classType == "Integer">RandomUtil.nextInt(10)
    <#elseif f.classType == "Float">RandomUtil.nextDouble(200d);
    <#elseif f.classType == "Double">RandomUtil.nextDouble(200d);
    <#elseif f.classType == "java.math.BigDecimal">new java.math.BigDecimal(String.valueOf(RandomUtil.nextDouble(200d)))
    <#elseif f.classType == "java.util.Date">new Date()
    <#elseif f.classType == "java.sql.Timestamp">new java.sql.Timestamp()
    <#elseif f.classType == "java.sql.Clob">new java.sql.Clob()
    <#else>RandomUtil.randomStringFixLength(${f.maxRandomLen})</#if>
</#macro>
