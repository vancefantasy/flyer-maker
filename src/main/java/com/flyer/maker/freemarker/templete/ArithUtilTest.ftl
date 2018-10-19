package ${projectPackage}.utils;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import static org.junit.Assert.*;

/**
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
public class ArithUtilTest {

    private final static Logger log = LoggerFactory.getLogger(ArithUtilTest.class);

    @Test
    public void add() throws Exception {
        double d1 = 0.11d;
        double d2 = 0.1d;
        double res = ArithUtil.add(d1, d2);
        assertEquals(0.21d, res, 0);
        log.info("add res : {}", res);
    }

    @Test
    public void sub() throws Exception {
        double d1 = 0.11d;
        double d2 = 0.1d;
        double res = ArithUtil.sub(d1, d2);
        assertEquals(0.01d, res, 0);
        log.info("sub res : {}", res);
    }

    @Test
    public void mul() throws Exception {
        double d1 = 1.999999d;
        double d2 = 2.88888d;
        double res = ArithUtil.mul(d1, d2);
        log.info("mul res : {}", res);
    }

    @Test
    public void div() throws Exception {
        double d1 = 1.1;
        double d2 = 0.9;
        double res = ArithUtil.div(d1, d2);
        log.info("div res: {}", res);
    }

    @Test
    public void div1() throws Exception {
        double d1 = 1.1;
        double d2 = 0.9;
        double res = ArithUtil.div(d1, d2, 5);
        log.info("div1 res: {}", res);
    }

    @Test
    public void round() throws Exception {
        double d1 = 1.9999999999;
        double res = ArithUtil.round(d1, 5);
        log.info("round res: {}", res);
    }

}
