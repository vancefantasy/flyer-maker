package ${projectPackage}.dao;

import ${projectPackage}.domain.${clazz.bclassName};
import org.springframework.stereotype.Repository;

/**
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
@Repository
public interface ${clazz.bclassName}Dao {

    Integer save${clazz.bclassName}(${clazz.bclassName} ${clazz.className});

    Integer remove${clazz.bclassName}(${clazz.idType} id);

    Integer update${clazz.bclassName}(${clazz.bclassName} ${clazz.className});

	${clazz.bclassName} find${clazz.bclassName}ById(${clazz.idType} id);
}
