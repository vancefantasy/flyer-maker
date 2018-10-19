package ${projectPackage}.dao;

import ${projectPackage}.AbstractTest;
import ${projectPackage}.DBUtils;
import ${projectPackage}.data.${clazz.bclassName}Data;
import ${projectPackage}.domain.${clazz.bclassName};
import com.vip.vjtools.vjkit.mapper.JsonMapper;
import org.junit.AfterClass;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static org.junit.Assert.*;

/**
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
public class ${clazz.bclassName}DaoTest extends AbstractTest {

    @Autowired
    private ${clazz.bclassName}Dao ${clazz.className}Dao;

    @AfterClass
    public static void clean() {
        DBUtils.truncateTable("${clazz.className}");
    }

    @Test
    public void save${clazz.bclassName}() throws Exception {
        ${clazz.bclassName} ${clazz.className} = ${clazz.bclassName}Data.generatOne(false);
        ${clazz.className}Dao.save${clazz.bclassName}(${clazz.className});
        assertNotNull("${clazz.className} id is null", ${clazz.className}.getId());
        log.warn("save${clazz.bclassName} run res : {}", JsonMapper.INSTANCE.toJson(${clazz.className}));
    }

    @Test
    public void remove${clazz.bclassName}() throws Exception {
        ${clazz.bclassName} ${clazz.className} = ${clazz.bclassName}Data.generatOne(false);
        ${clazz.className}Dao.save${clazz.bclassName}(${clazz.className});
        assertNotNull("${clazz.className} id is null", ${clazz.className}.getId());
        ${clazz.className}Dao.remove${clazz.bclassName}(${clazz.className}.getId());
        ${clazz.bclassName} null${clazz.bclassName} = ${clazz.className}Dao.find${clazz.bclassName}ById(${clazz.className}.getId());
        assertNull("${clazz.className} is remove", null${clazz.bclassName});
    }

    @Test
    public void update${clazz.bclassName}() throws Exception {
        ${clazz.bclassName} ${clazz.className} = ${clazz.bclassName}Data.generatOne(false);
        ${clazz.className}Dao.save${clazz.bclassName}(${clazz.className});
        ${clazz.bclassName} update${clazz.bclassName} = ${clazz.bclassName}Data.generatOne(false);
        update${clazz.bclassName}.setId(${clazz.className}.getId());
        ${clazz.className}Dao.update${clazz.bclassName}(update${clazz.bclassName});
        ${clazz.bclassName} select${clazz.bclassName} = ${clazz.className}Dao.find${clazz.bclassName}ById(${clazz.className}.getId());
        assertEquals("must equals", select${clazz.bclassName}.getId(), update${clazz.bclassName}.getId());
    }

    @Test
    public void find${clazz.bclassName}ById() throws Exception {
        ${clazz.bclassName} ${clazz.className} = ${clazz.bclassName}Data.generatOne(false);
        ${clazz.className}Dao.save${clazz.bclassName}(${clazz.className});

        ${clazz.bclassName} select${clazz.bclassName} = ${clazz.className}Dao.find${clazz.bclassName}ById(${clazz.className}.getId());
        assertNotNull("${clazz.className}Id should not be null", select${clazz.bclassName}.getId());
        assertNotNull("${clazz.className} should not be null", select${clazz.bclassName});
        log.warn("find${clazz.bclassName}ById res : {}", JsonMapper.INSTANCE.toJson(${clazz.className}));
    }

}
