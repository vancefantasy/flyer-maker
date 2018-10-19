package com.flyer.maker.generator.impl;

import com.flyer.maker.base.Config;
import com.flyer.maker.base.Clazz;
import com.flyer.maker.generator.Generator;
import com.flyer.maker.parser.impl.MySQLParser;
import com.flyer.maker.parser.Parser;
import com.flyer.maker.utils.GU;
import freemarker.template.TemplateException;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 基础生成器
 */
public abstract class BaseGenerator implements Generator {

    private final Logger log = LoggerFactory.getLogger(getClass());

    protected String projectDir;
    protected String srcDir;
    protected String mainDir;
    protected String javaDir;
    protected String resourcesDir;
    protected String webappDir;
    protected String webInfDir;
    protected String basePackageDir;
    protected String testDir;
    protected String testJavaDir;
    protected String testResourcesDir;
    protected String testBasePackageDir;

    protected List<Clazz> clazzList;

    @Override
    public void init() throws IOException {
        projectDir = concat(Config.targetDir, Config.projectArtifactId);
        srcDir = concat(projectDir, "src");

        mainDir = concat(srcDir, "main");
        javaDir = concat(mainDir, "java");
        resourcesDir = concat(mainDir, "resources");
        webappDir = concat(mainDir, "webapp");
        webInfDir = concat(webappDir, "WEB-INF");
        basePackageDir = concat(javaDir, Config.projectPackage.split("\\."));

        testDir = concat(srcDir, "test");
        testJavaDir = concat(testDir, "java");
        testResourcesDir = concat(testDir, "resources");
        testBasePackageDir = concat(testJavaDir, Config.projectPackage.split("\\."));

        //parse table to clazzs
        try {
            Parser parser =
                new MySQLParser(Config.mysqlJdbcUrl, Config.mysqlUsername, Config.mysqlPassword);
            clazzList = parser.parseDatabase();
        } catch (Exception e) {
            log.error("parser error", e);
        }

        File file = new File(projectDir);
        if (file.exists()) {
            FileUtils.forceDelete(file);
            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {
            }
            log.debug("clean dir: {}", projectDir);
        }
    }

    abstract void makeCustom() throws IOException, TemplateException;

    @Override
    public void generate() throws IOException, TemplateException {
        init();
        base();
        makeCustom();
    }

    @Override
    public void base() throws IOException, TemplateException {
        GU.f(concat(projectDir, ".gitignore"), "gitIgnore");
        GU.f(concat(projectDir, "pom.xml"), concat(Config.projectType, "pom"));
        generatorJava();
        generatorTestJava();
    }

    @Override
    public void clearIfFail() {
        try {
            FileUtils.forceDelete(new File(projectDir));
        } catch (IOException e) {
            log.error("clearIfFail error", e);
        }
    }

    private void generatorJava() throws IOException, TemplateException {

        GU.f(concat(basePackageDir, "common", "BaseController.java"), "BaseController");

        GU.f(concat(basePackageDir, "common", "BaseResponse.java"), "BaseResponse");
        GU.f(concat(basePackageDir, "common", "BeanFactoryRegister.java"), "BeanFactoryRegister");

        GU.f(concat(basePackageDir, "common", "exception", "BizException.java"), "BizException");
        GU.f(concat(basePackageDir, "common", "exception", "GlobalExceptionHandler.java"),
            "GlobalExceptionHandler");

        GU.f(concat(basePackageDir, "common", "interceptor", "ControllerInterceptor.java"),
            "ControllerInterceptor");
        GU.f(concat(basePackageDir, "common", "interceptor", "HttpLog.java"), "HttpLog");
        GU.f(concat(basePackageDir, "common", "interceptor", "HttpLogHolder.java"),
            "HttpLogHolder");
        GU.f(concat(basePackageDir, "common", "interceptor", "LogResponseBodyAdvice.java"),
            "LogResponseBodyAdvice");

        GU.f(concat(basePackageDir, "constant", "ErrorEnum.java"), "ErrorEnum");

        GU.f(concat(basePackageDir, "utils", "ArithUtil.java"), "ArithUtil");
        GU.f(concat(basePackageDir, "utils", "DateUtil.java"), "DateUtil");

        GU.f(concat(basePackageDir, "web", "CommonController.java"), "CommonController");

        GU.f(concat(basePackageDir, "web", "resp", ".gitkeep"), "gitkeep");

        generatorByClazzList();
    }

    private void generatorTestJava() throws IOException, TemplateException {
        GU.f(concat(testBasePackageDir, "common", "BeanFactoryRegisterTest.java"),
            "BeanFactoryRegisterTest");

        GU.f(concat(testBasePackageDir, "utils", "ArithUtilTest.java"), "ArithUtilTest");

        GU.f(concat(testBasePackageDir, "web", "CommonControllerTest.java"),
            "CommonControllerTest");

        GU.f(concat(testBasePackageDir, "DBUtils.java"), "DBUtils");
        GU.f(concat(testBasePackageDir, "AbstractTest.java"),
            concat(Config.projectType, "AbstractTest"));
        GU.f(concat(testBasePackageDir, "AbstractMVCTest.java"),
            concat(Config.projectType, "AbstractMVCTest"));
    }

    private void generatorByClazzList() throws IOException, TemplateException {
        for (Clazz clazz : clazzList) {
            Map<String, Object> data = new HashMap<>();
            data.put("clazz", clazz);

            String mapperPath =
                concat(resourcesDir, "base", "mapper", clazz.getBclassName() + "-mapper.xml");
            if (Config.projectType.indexOf("springboot") != -1) {
                mapperPath = concat(resourcesDir, "mapper", clazz.getBclassName() + "-mapper.xml");
            }
            GU.f(mapperPath, concat("db", "mapperTemplate"), data);

            GU.f(concat(basePackageDir, "domain", clazz.getBclassName() + ".java"),
                concat("db", "entityTemplate"), data);
            GU.f(concat(basePackageDir, "dao", clazz.getBclassName() + "Dao.java"),
                concat("db", "daoTemplate"), data);
            GU.f(concat(basePackageDir, "service", clazz.getBclassName() + "Service.java"),
                concat("db", "serviceTemplate"), data);
            GU.f(concat(basePackageDir, "service", "impl",
                clazz.getBclassName() + "ServiceImpl.java"), concat("db", "serviceImplTemplate"),
                data);
            GU.f(concat(basePackageDir, "web", clazz.getBclassName() + "Controller.java"),
                concat("db", "controllerTemplate"), data);
            GU.f(concat(basePackageDir, "web", "req",
                "SaveOrUpdate" + clazz.getBclassName() + ".java"),
                concat("db", "saveOrUpdateReqTemplate"), data);

            GU.f(concat(testBasePackageDir, "dao", clazz.getBclassName() + "DaoTest.java"),
                concat("db", "daoTestTemplate"), data);

            GU.f(concat(testBasePackageDir, "data", clazz.getBclassName() + "Data.java"),
                concat("db", "dataTemplate"), data);

            GU.f(concat(testBasePackageDir, "service", "impl",
                clazz.getBclassName() + "ServiceImplTest.java"),
                concat(Config.projectType, "serviceImplTestTemplate"), data);

            GU.f(concat(testBasePackageDir, "web", clazz.getBclassName() + "ControllerTest.java"),
                concat("db", "controllerTestTemplate"), data);
        }
    }

    protected static String concat(String baseName, String... appendName) {
        if (appendName.length == 0) {
            return baseName;
        } else {
            StringBuilder concatName = new StringBuilder();
            if (baseName.endsWith(File.separator)) {
                concatName.append(baseName).append(appendName[0]);
            } else {
                concatName.append(baseName).append(File.separator).append(appendName[0]);
            }
            if (appendName.length > 1) {
                for (int i = 1; i < appendName.length; ++i) {
                    concatName.append(File.separator).append(appendName[i]);
                }
            }

            return concatName.toString();
        }
    }

}
