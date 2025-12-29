package one.yiran.dashboard.common.expection;

import lombok.Getter;
import one.yiran.common.exception.BusinessException;

/**
 * 验证码错误异常类
 */
@Getter
public class GoogleAuthException extends BusinessException {
    private static final long serialVersionUID = 1L;

    private Object data;

    public GoogleAuthException(String msg) {
        super(598, msg);
    }

    public GoogleAuthException(String msg, Object data) {
        super(599, msg);
        this.data = data;
    }

    public static GoogleAuthException build(String msg) {
        return new GoogleAuthException(msg);
    }

    public static GoogleAuthException build(String msg, Object data) {
        return new GoogleAuthException(msg, data);
    }
}
