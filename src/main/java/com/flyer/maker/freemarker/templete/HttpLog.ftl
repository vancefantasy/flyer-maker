package ${projectPackage}.common.interceptor;

import ${projectPackage}.common.BaseResponse;

import java.util.Map;

/**
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
public class HttpLog {

    private Map general;

    private Map parameters;

    private String requestBody;

    private BaseResponse responseBody;

    public Map getParameters() {
        return parameters;
    }

    public void setParameters(Map parameters) {
        this.parameters = parameters;
    }

    public Map getGeneral() {
        return general;
    }

    public void setGeneral(Map general) {
        this.general = general;
    }

    public String getRequestBody() {
        return requestBody;
    }

    public void setRequestBody(String requestBody) {
        this.requestBody = requestBody;
    }

    public BaseResponse getResponseBody() {
        return responseBody;
    }

    public void setResponseBody(BaseResponse responseBody) {
        this.responseBody = responseBody;
    }
}
