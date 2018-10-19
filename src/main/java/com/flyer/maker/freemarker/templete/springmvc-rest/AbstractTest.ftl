package ${projectPackage};

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
@ActiveProfiles("ut")
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/base/spring-bootstrap.xml"})
public class AbstractTest {

    protected Logger log = LoggerFactory.getLogger(getClass());

    private static boolean checkDBNameDone = false;

    @Before
    public void setUp() {
        if (!checkDBNameDone) {
            DBUtils.checkDBName();
            checkDBNameDone = true;
        }
    }

    @Test
    public void nothing() {
    }

}
