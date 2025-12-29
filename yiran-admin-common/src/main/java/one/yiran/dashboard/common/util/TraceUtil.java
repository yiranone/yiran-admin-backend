package one.yiran.dashboard.common.util;

import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.MDC;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Map;
import java.util.UUID;

public class TraceUtil {
    public final static String TRACE_ID = "_traceId";

    public static String PREFIX = "";

    static {
        String prefix = System.getProperty("trace.prefix");
        if(StringUtils.isNotBlank(prefix) && prefix.length() >= 2){
            PREFIX = prefix.substring(0,2);
        }
    }

    public static void initTrace() {
        String traceId = generateTraceId();
        setTraceId(traceId);
    }

    public static void initTraceFrom(HttpServletRequest request) {

        String traceId;

        traceId = request.getParameter(TRACE_ID);
        if (StringUtils.isNotBlank(traceId)) {
            setTraceId(traceId);
            return;
        }

        traceId = (String) request.getAttribute(TRACE_ID);
        if (StringUtils.isNotBlank(traceId)) {
            setTraceId(traceId);
            return;
        }

        if (StringUtils.isNotBlank(traceId)) {
            setTraceId(traceId);
            return;
        }

        traceId = generateTraceId();
        setTraceId(traceId);
    }

    public static void initTraceFrom(JSONObject json) {
        String traceId = json.getString(TRACE_ID);
        if (traceId == null) {
            traceId = generateTraceId();
        }
        setTraceId(traceId);
    }

    @SuppressWarnings("rawtypes")
    public static void initTraceFrom(Map map) {
        String traceId = (String) map.get(TRACE_ID);
        if (traceId == null) {
            traceId = generateTraceId();
        }
        setTraceId(traceId);
    }

    public static void initTraceFrom(Method method) {
        String traceId = null;
        try {
            traceId = (String) method.invoke(TRACE_ID);
        } catch (Exception e) {
        }
        if (traceId == null) {
            traceId = generateTraceId();
        }
        setTraceId(traceId);
    }

    public static void putTraceInto(HttpServletRequest request) {
        String traceId = getTraceId();
        if (StringUtils.isNotBlank(traceId)) {
            request.setAttribute(TRACE_ID, traceId);
        }
    }

    @SuppressWarnings({"unchecked", "rawtypes"})
    public static void putTraceInto(Map map) {
        String traceId = getTraceId();
        if (traceId != null) {
            map.put(TRACE_ID, traceId);
        }
    }

    public static void putTraceInto(Method method) {
        String traceId = getTraceId();
        if (traceId != null) {
            try {
                method.invoke(TRACE_ID, traceId);
            } catch (Exception e) {
            }
        }
    }

    public static void clearTrace() {
        MDC.remove(TRACE_ID);
    }

    public static String getTraceId() {
        return MDC.get(TRACE_ID);
    }

    public static void setTraceId(String traceId) {
        if (StringUtils.isNotBlank(traceId)) {
            traceId = StringUtils.left(traceId, 36);
        }
        MDC.put(TRACE_ID, traceId);
    }

    public static void main(String[] args) {
//        System.out.println(StringUtils.left("1234567890", 30));
//        System.out.println(StringUtils.left("1234567890", 3));
        System.out.println(generateTraceId());
    }

    static private String generateTraceId() {
        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
        if(StringUtils.isNotBlank(PREFIX)){
            return PREFIX + uuid.substring(PREFIX.length(), uuid.length());
        }
        return uuid;
    }

}
