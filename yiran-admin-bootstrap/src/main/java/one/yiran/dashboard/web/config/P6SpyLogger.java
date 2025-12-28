package one.yiran.dashboard.web.config;

import com.p6spy.engine.spy.appender.MessageFormattingStrategy;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class P6SpyLogger implements MessageFormattingStrategy {
    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss:SSS");
    public P6SpyLogger() {
    }

    @Override
    public String formatMessage(int connectionId, String now, long elapsed, String category, String prepared, String sql, String url) {
        StringBuffer buffer = new StringBuffer();
        return !"".equals(sql.trim()) ? buffer.append("/* ")
                .append(formatter.format(LocalDateTime.now()))
                .append(" | took ").append(elapsed)
                .append("ms | ").append(category)
                .append(" | connection ")
                .append(connectionId)
                .append(" */ \n ")
                .append(sql)
                .append(";")
                .toString() : "";
    }

}
