package one.yiran.dashboard.common.expection.user;

public class UserPasswordRetryLimitExceedException extends UserException {


    public static final int KEY = 400;

    public UserPasswordRetryLimitExceedException() {
        super(KEY, "If the number of incorrect password entries exceeds the limit, contact the administrator");
    }

    public UserPasswordRetryLimitExceedException(String message) {
        super(KEY, message);
    }

    public UserPasswordRetryLimitExceedException(long count) {
        super(KEY, "If the number of incorrect passwords exceeds " + count + ", contact the administrator");
    }
}
