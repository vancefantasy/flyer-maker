package ${projectPackage};

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import uk.org.lidalia.sysoutslf4j.context.SysOutOverSLF4J;

/**
* Created by ${author} on ${.now?string('yyyy/MM/dd')}.
*/
@SpringBootApplication
@EnableAutoConfiguration
@MapperScan("${projectPackage}.dao")
@ComponentScan("${projectPackage}")
public class App extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(App.class, args);
        //console -> slf4j
        SysOutOverSLF4J.sendSystemOutAndErrToSLF4J();
    }
}
