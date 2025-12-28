package one.yiran.dashboard.common.expection.user;

public class UserBlockedException extends UserException {


    public static final int KEY = 400;

    public UserBlockedException() {
        super(KEY, "The user has been frozen. Contact the administrator");
    }

    public UserBlockedException(String message) {
        super(KEY, message);
    }

    public UserBlockedException(String message,String loginName) {
        super(KEY, message, loginName);
    }
}
