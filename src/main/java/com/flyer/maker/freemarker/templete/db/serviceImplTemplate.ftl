package ${projectPackage}.service.impl;

import ${projectPackage}.common.exception.BizException;
import ${projectPackage}.constant.ErrorEnum;
import ${projectPackage}.domain.${clazz.bclassName};
import ${projectPackage}.dao.${clazz.bclassName}Dao;
import ${projectPackage}.service.${clazz.bclassName}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
@Service
public class ${clazz.bclassName}ServiceImpl implements ${clazz.bclassName}Service {
	
	@Autowired
	private ${clazz.bclassName}Dao ${clazz.className}Dao;

	@Override
	public ${clazz.bclassName} save${clazz.bclassName}(${clazz.bclassName} ${clazz.className}) {
    	int result = ${clazz.className}Dao.save${clazz.bclassName}(${clazz.className});
		if(result == 0){
			BizException.throwOut(ErrorEnum.DB_FAIL);
		}
        return ${clazz.className};
	}

	@Override
	public Integer update${clazz.bclassName}(${clazz.bclassName} ${clazz.className}) {
		int result = ${clazz.className}Dao.update${clazz.bclassName}(${clazz.className});
		if(result == 0){
			BizException.throwOut(ErrorEnum.DB_FAIL);
		}
    	return result;
	}

	@Override
	public Integer remove${clazz.bclassName}(${clazz.idType} id) {
		int result = ${clazz.className}Dao.remove${clazz.bclassName}(id);
		if(result == 0){
			BizException.throwOut(ErrorEnum.DB_FAIL);
		}
    	return result;
	}

	@Override
	public ${clazz.bclassName} find${clazz.bclassName}ById(${clazz.idType} id) {
		${clazz.bclassName} ${clazz.className} = ${clazz.className}Dao.find${clazz.bclassName}ById(id);
		if (${clazz.className} == null) {
			BizException.throwOut(ErrorEnum.DB_FAIL);
		}
		return ${clazz.className};
	}
}
