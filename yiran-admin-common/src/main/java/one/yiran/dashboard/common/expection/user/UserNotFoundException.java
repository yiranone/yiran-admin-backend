package one.yiran.dashboard.common.expection.user;

public class UserNotFoundException extends UserException {


    public static final int KEY = 400;

    public UserNotFoundException() {
        super(KEY, "User does not exist");
    }

    public UserNotFoundException(String loginName) {
        super(KEY, "User does not exist，Login name:" + loginName,loginName);
    }

    public UserNotFoundException(Long userId) {
        super(KEY, "User does not exist，User ID:" + userId);
    }
}
