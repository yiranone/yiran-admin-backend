package one.yiran.dashboard.common.expection.user;

public class UserPasswordNotMatchException extends UserException {


    public static final int KEY = 400;

    public UserPasswordNotMatchException() {
        super(KEY, "Incorrect password");
    }

    public UserPasswordNotMatchException(String message, String loginName) {
        super(KEY, message, loginName);
    }

    public UserPasswordNotMatchException(String message) {
        super(KEY, message);
    }
}
