package ${projectPackage}.domain;

import java.io.Serializable;
/**
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
public class ${clazz.bclassName} implements Serializable {

	private static final long serialVersionUID = 1L;

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
