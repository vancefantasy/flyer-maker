package ${projectPackage}.common.interceptor;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
public class ControllerInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest,
        HttpServletResponse httpServletResponse, Object o) throws Exception {
        long begin = System.currentTimeMillis();
        HttpLog httpLog = new HttpLog();
        httpLog.setGeneral(buildGeneral(httpServletRequest, begin));
        httpLog.setParameters(buildParameter(httpServletRequest));
        httpLog.setRequestBody(IOUtils.toString(httpServletRequest.getInputStream(), "utf-8"));
        HttpLogHolder.set(httpLog);
        return true;
    }

    private Map buildGeneral(HttpServletRequest request, long begin) {
        Map map = new HashMap();
        map.put("URI", request.getRequestURI());
        map.put("method", request.getMethod());
        map.put("queryString", request.getQueryString() == null ? "" : request.getQueryString());
        map.put("requestTime", begin);
        return map;
    }

    private Map buildParameter(HttpServletRequest request) {
        Map<String, String[]> map = request.getParameterMap();
        Map resultMap = new HashMap();
        for (Map.Entry<String, String[]> entry : map.entrySet()) {
            resultMap.put(entry.getKey(), StringUtils.join(entry.getValue(), ","));
        }
        return resultMap;
    }

}
