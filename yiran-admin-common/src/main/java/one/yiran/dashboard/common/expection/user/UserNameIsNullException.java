package one.yiran.dashboard.common.expection.user;

public class UserNameIsNullException extends UserException {


    public static final int KEY = 400;

    public UserNameIsNullException() {
        super(KEY, "User name null");
    }

    public UserNameIsNullException(String message) {
        super(KEY, message);
    }
}
