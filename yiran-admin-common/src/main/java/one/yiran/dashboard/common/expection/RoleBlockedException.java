package one.yiran.dashboard.common.expection;

import one.yiran.common.exception.BusinessException;

public class RoleBlockedException extends BusinessException {

    public static final int KEY = 400;

    public RoleBlockedException() {
        super(KEY, "Role disabled");
    }

    public RoleBlockedException(String message) {
        super(KEY, message);
    }
}
