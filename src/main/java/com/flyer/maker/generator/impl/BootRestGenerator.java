package com.flyer.maker.generator.impl;

import com.flyer.maker.base.Config;
import com.flyer.maker.utils.GU;
import freemarker.template.TemplateException;

import java.io.IOException;

/**
 * springboot-rest生成器
 */
public class BootRestGenerator extends BaseGenerator {

    @Override
    public void makeCustom() throws IOException, TemplateException {
        GU.f(concat(basePackageDir, "App.java"), concat(Config.projectType, "App.java"));
        GU.f(concat(basePackageDir, "common", "WebMvcConfig.java"),
            concat(Config.projectType, "WebMvcConfig"));
        generatorResources();
        generatorTestResources();
    }

    private void generatorTestResources() throws IOException, TemplateException {
        GU.f(concat(testResourcesDir, "application.properties"),
            concat(Config.projectType, "unit_application.properties"));
        GU.f(concat(testResourcesDir, "logback-test.xml"),
            concat(Config.projectType, "logback-test"));
    }

    private void generatorResources() throws IOException, TemplateException {
        GU.f(concat(resourcesDir, "application.properties"),
            concat(Config.projectType, "application.properties"));
        GU.f(concat(resourcesDir, "application-dev.properties"),
            concat(Config.projectType, "application-dev.properties"));
        GU.f(concat(resourcesDir, "application-prod.properties"),
            concat(Config.projectType, "application-prod.properties"));
        GU.f(concat(resourcesDir, "application-stage.properties"),
            concat(Config.projectType, "application-stage.properties"));
        GU.f(concat(resourcesDir, "application-test.properties"),
            concat(Config.projectType, "application-test.properties"));
        GU.f(concat(resourcesDir, "logback-spring.xml"),
            concat(Config.projectType, "logback-spring"));
    }
}
