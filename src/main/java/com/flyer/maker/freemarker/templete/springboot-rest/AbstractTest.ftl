package ${projectPackage};

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
@ActiveProfiles("ut")
@SpringBootTest
@RunWith(SpringRunner.class)
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
