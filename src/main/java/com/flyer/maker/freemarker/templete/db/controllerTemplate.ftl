package ${projectPackage}.web;

import ${projectPackage}.common.BaseController;
import ${projectPackage}.common.BaseResponse;
import ${projectPackage}.common.exception.BizException;
import ${projectPackage}.constant.ErrorEnum;
import ${projectPackage}.domain.${clazz.bclassName};
import ${projectPackage}.service.${clazz.bclassName}Service;
import ${projectPackage}.web.req.SaveOrUpdate${clazz.bclassName};
import com.vip.vjtools.vjkit.collection.MapUtil;
import jodd.bean.BeanCopy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

/**
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
@RestController
@RequestMapping("${clazz.resouceName}")
public class ${clazz.bclassName}Controller extends BaseController {
	
	@Autowired
	private ${clazz.bclassName}Service ${clazz.className}Service;

	@PostMapping(value = "add")
	public BaseResponse add${clazz.bclassName}(@RequestBody @Valid SaveOrUpdate${clazz.bclassName} saveOrUpdate${clazz.bclassName}Req,
		BindingResult result) {
		checkJSR303(result);
		${clazz.bclassName} ${clazz.className} = new ${clazz.bclassName}();
		BeanCopy.beans(saveOrUpdate${clazz.bclassName}Req, ${clazz.className}).copy();
		${clazz.className} = ${clazz.className}Service.save${clazz.bclassName}(${clazz.className});
		return BaseResponse.ok(MapUtil.newHashMap("id", ${clazz.className}.getId())).build();
	}

	@GetMapping(value = "remove")
	public BaseResponse remove${clazz.bclassName}(${clazz.idType} id) {
		if (id == null) {
			BizException.throwOut(ErrorEnum.PARAMETER_ILLEGAL);
		}
		${clazz.className}Service.remove${clazz.bclassName}(id);
		return BaseResponse.ok(MapUtil.newHashMap("id", id)).build();
	}

	@PostMapping(value = "edit")
	public BaseResponse edit${clazz.bclassName}(@RequestBody @Valid SaveOrUpdate${clazz.bclassName} saveOrUpdate${clazz.bclassName}Req,
		BindingResult result) {
		checkJSR303(result);
		${clazz.bclassName} ${clazz.className} = new ${clazz.bclassName}();
		BeanCopy.beans(saveOrUpdate${clazz.bclassName}Req, ${clazz.className}).copy();
		${clazz.className}Service.update${clazz.bclassName}(${clazz.className});
		return BaseResponse.ok(MapUtil.newHashMap("id", ${clazz.className}.getId())).build();
	}

	@GetMapping(value = "get")
	public BaseResponse get${clazz.bclassName}(${clazz.idType} id) {
		${clazz.bclassName} ${clazz.className} = ${clazz.className}Service.find${clazz.bclassName}ById(id);
		return BaseResponse.ok(${clazz.className}).build();
	}
}
