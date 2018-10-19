package ${projectPackage}.web.req;

/**
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
public class SaveOrUpdate${clazz.bclassName} {

    <#list clazz.fieldList as field>
    /**
    * ${field.desc}
    */
    private ${field.classType} ${field.name};
    </#list>

    <#list clazz.fieldList as field>
    public void set${field.bname}(${field.classType} ${field.name}) {
        this.${field.name} = ${field.name};
    }

    public ${field.classType} get${field.bname}() {
        return ${field.name};
    }

    </#list>
}
