package ${projectPackage}.web;

import ${projectPackage}.AbstractMVCTest;
import ${projectPackage}.common.BaseResponse;
import ${projectPackage}.data.${clazz.bclassName}Data;
import ${projectPackage}.domain.${clazz.bclassName};
import ${projectPackage}.service.${clazz.bclassName}Service;
import com.vip.vjtools.vjkit.mapper.JsonMapper;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.http.MediaType;

import javax.inject.Inject;

import static org.mockito.Matchers.any;
import static org.mockito.Matchers.anyInt;
import static org.mockito.Matchers.anyLong;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
public class ${clazz.bclassName}ControllerTest extends AbstractMVCTest {

    @Mock
    private ${clazz.bclassName}Service ${clazz.className}Service;

    @Inject
    @InjectMocks
    private ${clazz.bclassName}Controller ${clazz.className}Controller;

    @Test
    public void add${clazz.bclassName}() throws Exception {

        ${clazz.bclassName} post${clazz.bclassName} = ${clazz.bclassName}Data.generatOne(false);

        when(${clazz.className}Service.save${clazz.bclassName}(any(${clazz.bclassName}.class))).thenReturn(${clazz.bclassName}Data.generatOne(true));

        this.mockMvc.perform(post("/${clazz.className}/add").contentType(MediaType.APPLICATION_JSON_UTF8)
            .content(JsonMapper.INSTANCE.toJson(post${clazz.bclassName}))).andExpect(status().isOk())
            .andDo(print()).andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8))
            .andExpect(jsonPath("code").value(BaseResponse.CODE_SUCCESS));
    }

    @Test
    public void get${clazz.bclassName}() throws Exception {

        when(${clazz.className}Service.find${clazz.bclassName}ById(any${clazz.idTypeSimple}())).thenReturn(${clazz.bclassName}Data.generatOne(true));

        this.mockMvc.perform(get("/${clazz.className}/get").param("id", "1")).andExpect(status().isOk())
            .andDo(print()).andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8))
            .andExpect(jsonPath("code").value(BaseResponse.CODE_SUCCESS));
    }

    @Test
    public void edit${clazz.bclassName}() throws Exception {
        ${clazz.bclassName} edit${clazz.bclassName} = ${clazz.bclassName}Data.generatOne(true);

        when(${clazz.className}Service.update${clazz.bclassName}(any(${clazz.bclassName}.class))).thenReturn(1);

        this.mockMvc.perform(post("/${clazz.className}/edit").contentType(MediaType.APPLICATION_JSON_UTF8)
            .content(JsonMapper.INSTANCE.toJson(edit${clazz.bclassName}))).andExpect(status().isOk())
            .andDo(print()).andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8))
            .andExpect(jsonPath("code").value(BaseResponse.CODE_SUCCESS));
    }

    @Test
    public void remove${clazz.bclassName}() throws Exception {
        ${clazz.bclassName} remove${clazz.bclassName} = ${clazz.bclassName}Data.generatOne(true);

        when(${clazz.className}Service.remove${clazz.bclassName}(remove${clazz.bclassName}.getId())).thenReturn(1);

        this.mockMvc.perform(get("/${clazz.className}/remove").param("id", String.valueOf(remove${clazz.bclassName}.getId())))
            .andExpect(status().isOk()).andDo(print())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8))
            .andExpect(jsonPath("code").value(BaseResponse.CODE_SUCCESS));
    }

}
