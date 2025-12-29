package one.yiran.dashboard.common.filter;

import one.yiran.dashboard.common.util.TraceUtil;
import org.springframework.stereotype.Component;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import java.io.IOException;

@Component
public class TraceIdFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        try {
            // 生成新的 traceId
            TraceUtil.initTrace();
            // 继续执行请求
            chain.doFilter(request, response);
        } finally {
            // 清理，避免线程复用导致污染
            TraceUtil.clearTrace();
        }
    }
}
