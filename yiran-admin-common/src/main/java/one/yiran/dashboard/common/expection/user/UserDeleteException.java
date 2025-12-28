package one.yiran.dashboard.common.expection.user;

public class UserDeleteException extends UserException {


    public static final int KEY = 400;

    public UserDeleteException() {
        super(KEY, "User deleted");
    }

    public UserDeleteException(String message) {
        super(KEY, message);
    }

    public static UserDeleteException withLoginName(String loginName){
        return new UserDeleteException("User deleted, loginName:" + loginName);
    }
}
