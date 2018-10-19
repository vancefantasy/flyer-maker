package com.flyer.maker.generator.impl;

import com.flyer.maker.base.Config;
import com.flyer.maker.utils.GU;
import freemarker.template.TemplateException;

import java.io.IOException;

/**
 * springbmvc-rest生成器
 */
public class MvcRestGenerator extends BaseGenerator {

    @Override
    public void makeCustom() throws IOException, TemplateException {
        GU.f(concat(basePackageDir, "common", "listener", "LogbackProfileListener.java"),
            "LogbackProfileListener");
        generatorResources();
        generatorTestResources();
        GU.f(concat(webInfDir, "web.xml"), concat(Config.projectType, "webxml"));
        GU.f(concat(webInfDir, "spring-servlet.xml"), concat(Config.projectType, "spring-servlet"));
    }

    private void generatorResources() throws IOException, TemplateException {
        GU.f(concat(resourcesDir, "base", "spring-bootstrap.xml"),
            concat(Config.projectType, "spring-bootstrap"));
        GU.f(concat(resourcesDir, "base", "spring-core.xml"),
            concat(Config.projectType, "spring-core"));
        GU.f(concat(resourcesDir, "base", "spring-dao.xml"),
            concat(Config.projectType, "spring-dao"));
        GU.f(concat(resourcesDir, "base", "spring-profile.xml"),
            concat(Config.projectType, "spring-profile"));

        GU.f(concat(resourcesDir, "dev", "config.properties"),
            concat(Config.projectType, "dev_config.properties"));
        GU.f(concat(resourcesDir, "dev", "logback.xml"), concat(Config.projectType, "dev_logback"));

        GU.f(concat(resourcesDir, "test", "config.properties"),
            concat(Config.projectType, "test_config.properties"));
        GU.f(concat(resourcesDir, "test", "logback.xml"),
            concat(Config.projectType, "test_logback"));

        GU.f(concat(resourcesDir, "stage", "config.properties"),
            concat(Config.projectType, "stage_config.properties"));
        GU.f(concat(resourcesDir, "stage", "logback.xml"),
            concat(Config.projectType, "stage_logback"));

        GU.f(concat(resourcesDir, "prod", "config.properties"),
            concat(Config.projectType, "prod_config.properties"));
        GU.f(concat(resourcesDir, "prod", "logback.xml"),
            concat(Config.projectType, "prod_logback"));
    }

    private void generatorTestResources() throws IOException, TemplateException {
        GU.f(concat(testResourcesDir, "config.properties"),
            concat(Config.projectType, "unit_config.properties"));
        GU.f(concat(testResourcesDir, "logback-test.xml"),
            concat(Config.projectType, "logback-test"));
    }

}
