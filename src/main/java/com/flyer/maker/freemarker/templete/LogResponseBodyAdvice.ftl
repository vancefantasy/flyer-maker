package ${projectPackage}.common.interceptor;

import ${projectPackage}.common.BaseResponse;
import com.vip.vjtools.vjkit.mapper.JsonMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

/**
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
@ControllerAdvice
public class LogResponseBodyAdvice implements ResponseBodyAdvice<BaseResponse> {

    private Logger log = LoggerFactory.getLogger(getClass());

    @Override
    public boolean supports(MethodParameter returnType, Class converterType) {
        return true;
    }

    @Override
    public BaseResponse beforeBodyWrite(BaseResponse body, MethodParameter returnType,
        MediaType selectedContentType, Class selectedConverterType, ServerHttpRequest request,
        ServerHttpResponse response) {
        try {
            long end = System.currentTimeMillis();
            HttpLog httpLog = HttpLogHolder.get();
            if (httpLog != null) {
                httpLog.getGeneral()
                    .put("latency", end - (long) httpLog.getGeneral().get("requestTime"));
                httpLog.setResponseBody(body);
                log.info(JsonMapper.INSTANCE.toJson(httpLog));
            } else {
                log.warn("HttpLogHolder error");
            }
            return body;
        } finally {
            HttpLogHolder.clean();
        }
    }
}
