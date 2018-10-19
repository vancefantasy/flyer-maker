package ${projectPackage}.constant;

/**
 * Errors
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
public enum ErrorEnum {
    //4XX
    PARAMETER_ILLEGAL(400, "参数不合法"),
    NOT_FOUND(404, "资源未找到"),
    RESOURCE_CONFLICT(409, "资源已存在"),

    //5XX
    INTERNAL_SERVER_ERROR(500, "内部错误"),
    INTERNAL_SYSTEM_TIMEOUT(502, "内部系统调用超时"),
    DB_FAIL(516, "查询/操作数据库失败"),
    DB_ERROR(517, "查询/操作数据库错误"),
    ;

    public final int code;
    public final String message;

    ErrorEnum(int code, String message) {
        this.code = code;
        this.message = message;
    }

}
