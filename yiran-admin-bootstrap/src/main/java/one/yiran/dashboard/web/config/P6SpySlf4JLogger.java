package one.yiran.dashboard.web.config;

import com.p6spy.engine.logging.Category;
import com.p6spy.engine.spy.appender.FormattedLogger;
import one.yiran.dashboard.common.constants.Global;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class P6SpySlf4JLogger extends FormattedLogger {
    private static Logger log = LoggerFactory.getLogger(P6SpySlf4JLogger.class);

    private static Boolean show = Global.getBooleanConfig("dashboard.sql.show");
    private static Integer minEscape = Global.getIntegerConfig("dashboard.sql.minEscape");


    @Override
    public void logException(Exception e) {
        log.info("", e);
    }

    @Override
    public void logText(String text) {
        log.info(text);
    }

    @Override
    public void logSQL(int connectionId, String now, long elapsed,
                       Category category, String prepared, String sql, String url) {
        if (show != null && show.booleanValue()) {
            if (minEscape == null) {
                minEscape = -1;
            }
            if (elapsed > minEscape) {
                doLogSql(connectionId, now, elapsed, category, prepared, sql, url);
            }
        }
    }

    private void doLogSql(int connectionId, String now, long elapsed, Category category, String prepared, String sql, String url) {
        final String msg = strategy.formatMessage(connectionId, now, elapsed,
                category.toString(), prepared, sql, url);

        if (Category.ERROR.equals(category)) {
            log.error(msg);
        } else if (Category.WARN.equals(category)) {
            log.warn(msg);
        } else if (Category.DEBUG.equals(category)) {
            log.debug(msg);
        } else {
            log.info(msg);
        }
    }

    @Override
    public boolean isCategoryEnabled(Category category) {
        if (Category.ERROR.equals(category)) {
            return log.isErrorEnabled();
        } else if (Category.WARN.equals(category)) {
            return log.isWarnEnabled();
        } else if (Category.DEBUG.equals(category)) {
            return log.isDebugEnabled();
        } else {
            return log.isInfoEnabled();
        }
    }
}
