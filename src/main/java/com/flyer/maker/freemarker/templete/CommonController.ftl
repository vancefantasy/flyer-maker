package ${projectPackage}.web;

import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.LoggerContext;
import ${projectPackage}.common.BaseController;
import ${projectPackage}.common.BaseResponse;
import ${projectPackage}.common.exception.BizException;
import ${projectPackage}.constant.ErrorEnum;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Common Controller
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
@RestController
public class CommonController extends BaseController {

    /**
     * healthCheck
     *
     * @return
     */
    @GetMapping(value = "healthCheck")
    public BaseResponse healthCheck() {
        return BaseResponse.ok().build();
    }

    /**
     * set logger's level
     *
     * @param logger
     * @param level
     * @return
     */
    @GetMapping(value = "setLevel")
    public BaseResponse setLoggerLevel(String logger, String level) {
        if (StringUtils.isBlank(logger) || StringUtils.isBlank(level)) {
            BizException.throwOut(ErrorEnum.PARAMETER_ILLEGAL);
        }
        LoggerContext loggerContext = (LoggerContext) LoggerFactory.getILoggerFactory();
        loggerContext.getLogger(logger).setLevel(Level.valueOf(level));
        log.info("logger: {} was set to : {}", logger, level);
        return BaseResponse.ok().build();
    }

    /**
     * view the current level of logger
     * <p>
     * usage：
     * 1. /loggers for all logger
     * 2. /loggers/${projectPackage}.CommonController for specified logger
     *
     * @param name
     * @return
     */
    @GetMapping(value = {"loggers/{name:.+}", "loggers"})
    public BaseResponse loggers(@PathVariable(required = false) String name) {
        List<ch.qos.logback.classic.Logger> loggerList = new ArrayList<>();
        List<Map> list = new ArrayList();
        LoggerContext loggerContext = (LoggerContext) LoggerFactory.getILoggerFactory();
        if (StringUtils.isNotBlank(name)) {
            loggerList.add(loggerContext.getLogger(name));
        } else {
            loggerList = loggerContext.getLoggerList();
        }
        for (ch.qos.logback.classic.Logger logger : loggerList) {
            //filter user's logger
            if (!logger.getName().startsWith("${projectPackage}")) {
                continue;
            }
            list.add(new HashMap() {{
                put("logger", logger.getName());
                put("level", logger.getEffectiveLevel().levelStr);
            }});
        }
        return BaseResponse.ok(list).build();
    }

}
