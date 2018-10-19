package com.flyer.maker.parser;

import com.flyer.maker.base.Clazz;

import java.sql.SQLException;
import java.util.List;

/**
 * parser
 */
public interface Parser {

    List<Clazz> parseDatabase() throws SQLException;
}
