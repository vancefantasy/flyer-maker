package com.flyer.maker.generator;

import com.flyer.maker.base.Config;
import com.flyer.maker.generator.impl.BootPageGenerator;
import com.flyer.maker.generator.impl.BootRestGenerator;
import com.flyer.maker.generator.impl.MvcPageGenerator;
import com.flyer.maker.generator.impl.MvcRestGenerator;

/**
 * 生成器工厂类
 */
public class GeneratorFactory {

    public static Generator getGenerator() {
        switch (Config.projectType) {
            case "springmvc-rest":
                return new MvcRestGenerator();
            case "springboot-rest":
                return new BootRestGenerator();
            case "springmvc-page":
                return new MvcPageGenerator();
            case "springboot-page":
                return new BootPageGenerator();
        }
        return null;
    }
}
