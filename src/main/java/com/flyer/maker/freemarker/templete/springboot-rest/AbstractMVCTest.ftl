package ${projectPackage};

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.MockitoAnnotations;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

/**
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
@ActiveProfiles("ut")
@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment= SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureMockMvc
public class AbstractMVCTest {

    protected Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    protected MockMvc mockMvc;

    private static boolean checkDBNameDone = false;

    @Before
    public void setUp() {
        if (!checkDBNameDone){
            DBUtils.checkDBName();
            checkDBNameDone = true;
        }
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void nothing() {
    }

}
