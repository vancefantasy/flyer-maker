package com.flyer.maker.generator;

import freemarker.template.TemplateException;

import java.io.IOException;

/**
 * generator interface
 */
public interface Generator {

    void init() throws IOException;

    void generate() throws IOException, TemplateException;

    void base() throws IOException, TemplateException;

    void clearIfFail();

}
