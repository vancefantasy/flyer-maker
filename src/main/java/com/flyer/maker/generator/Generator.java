package com.flyer.maker.generator;

import java.io.IOException;

/**
 * generator interface
 */
public interface Generator {

    void init() throws IOException;

    void generate() throws IOException;

    void base() throws IOException;

    void clearIfFail();

}
