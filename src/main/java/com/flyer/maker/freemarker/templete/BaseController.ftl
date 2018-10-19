package ${projectPackage}.common;

import ${projectPackage}.common.exception.BizException;
import ${projectPackage}.constant.ErrorEnum;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;

import java.util.Iterator;

/**
 *
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
public class BaseController {

    protected Logger log = LoggerFactory.getLogger(getClass());

    public void checkJSR303(BindingResult result) {
        if (result.hasErrors()) {
            StringBuilder sb = new StringBuilder();
            Iterator<ObjectError> iterator = result.getAllErrors().iterator();
            while (iterator.hasNext()) {
                sb.append(iterator.next().getDefaultMessage());
                if (iterator.hasNext()) {
                    sb.append(",");
                }
            }
            log.warn("checkJSR303 fail, error: {}", sb.toString());
            BizException.throwOut(ErrorEnum.PARAMETER_ILLEGAL);
        }
    }

}
