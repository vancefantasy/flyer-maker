package ${projectPackage}.common.listener;

import ch.qos.logback.ext.spring.web.LogbackConfigListener;
import ch.qos.logback.ext.spring.web.WebLogbackConfigurer;
import org.apache.commons.lang3.StringUtils;
import uk.org.lidalia.sysoutslf4j.context.SysOutOverSLF4J;

import javax.servlet.ServletContextEvent;

/**
 * logback config listener
 * solve multiple spring profiles problems
 * <p>
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
public class LogbackProfileListener extends LogbackConfigListener {

    private static final String DEFAULT_PROFILE = "dev";
    private static final String LOGBACK_CONFIG_FILE_PATTERN = "classpath:%s/logback.xml";

    @Override
    public void contextInitialized(ServletContextEvent event) {
        String springProfile = System.getProperty("spring.profiles.active");
        //use 'dev' default
        if (StringUtils.isEmpty(springProfile)) {
            springProfile = DEFAULT_PROFILE;
        }
        String logConfigPath = String.format(LOGBACK_CONFIG_FILE_PATTERN, springProfile);
        //only supported servlet 3+
        event.getServletContext()
            .setInitParameter(WebLogbackConfigurer.CONFIG_LOCATION_PARAM, logConfigPath);

        super.contextInitialized(event);

        //console -> slf4j
        SysOutOverSLF4J.sendSystemOutAndErrToSLF4J();
    }
}
