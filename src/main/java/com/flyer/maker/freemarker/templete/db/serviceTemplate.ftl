package ${projectPackage}.service;

import ${projectPackage}.domain.${clazz.bclassName};

/**
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
public interface ${clazz.bclassName}Service {

	${clazz.bclassName} save${clazz.bclassName}(${clazz.bclassName} ${clazz.className});

	Integer remove${clazz.bclassName}(${clazz.idType} id);

	Integer update${clazz.bclassName}(${clazz.bclassName} ${clazz.className});

	${clazz.bclassName} find${clazz.bclassName}ById(${clazz.idType} id);
}
