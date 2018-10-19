package ${projectPackage}.common.exception;

import ${projectPackage}.constant.ErrorEnum;

/**
 * User-defined Exception
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
public class BizException extends RuntimeException {

    /**
     * error info
     */
    private ErrorEnum error;

    public BizException(ErrorEnum error) {
        this.error = error;
    }

    public ErrorEnum getError() {
        return error;
    }

    public static void throwOut(ErrorEnum error) {
        throw new BizException(error);
    }

}
