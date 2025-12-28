package one.yiran.dashboard.common.expection.user;

public class UserNotLoginException extends UserException {


    public static final int KEY = 401;

    public UserNotLoginException() {
        super(KEY, "User is not logged in");
    }

    public UserNotLoginException(String message) {
        super(KEY, message);
    }

    public UserNotLoginException(String message, String loginName) {
        super(KEY, message, loginName);
    }
}
