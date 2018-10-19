package ${projectPackage}.common.interceptor;

import org.springframework.core.NamedThreadLocal;

/**
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
public class HttpLogHolder {
    private static NamedThreadLocal<HttpLog> threadLocal =
        new NamedThreadLocal<>("HttpLogHolder");

    public static void set(HttpLog httpLog) {
        threadLocal.set(httpLog);
    }

    public static HttpLog get() {
        return threadLocal.get();
    }

    public static void clean() {
        threadLocal.remove();
    }
}
