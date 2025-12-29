package one.yiran.dashboard.security.service;

import com.warrenstrange.googleauth.GoogleAuthenticator;
import com.warrenstrange.googleauth.GoogleAuthenticatorConfig;
import com.warrenstrange.googleauth.GoogleAuthenticatorKey;
import com.warrenstrange.googleauth.GoogleAuthenticatorQRGenerator;
import lombok.extern.slf4j.Slf4j;
import one.yiran.dashboard.cache.DashboardCacheService;
import one.yiran.dashboard.cache.RedisCacheService;
import one.yiran.dashboard.common.expection.GoogleAuthException;
import one.yiran.dashboard.security.model.GoogleSecretBO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

@Slf4j
@Service
public class GoogleAuthService {

    @Autowired
    private DashboardCacheService redisCacheService;

    /**
     * 窗口大小
     */
    @Value("${dashboard.google.auth.window.size:3}")
    private Integer googleAuthWindowSize;

    /**
     * 窗口时间
     */
    @Value("${dashboard.google.auth.time.step:30}")
    private Integer timeStepSizeInSeconds;

    /**
     * 谷歌验证是否开启
     */
    @Value("${dashboard.google.auth.enabled:false}")
    private boolean authEnable;

    /**
     * 谷歌验证名字
     */
    @Value("${dashboard.google.auth.env:test}")
    private String env;

    /**
     * 谷歌验证器秘钥生成后过期时间（秒）,总共过期15分钟
     */
    private static final int GOOGLE_AUTH_TIME_OUT = 15;

    private String getGoogleAuthSecretKeyCacheKey(String userNo) {
        return "google:auth:" + userNo;
    }

    private String getGoogleAuthUrlCacheKey(String userNo) {
        return "google:authUrl:" + userNo;
    }

    public boolean isEnable() {
        return authEnable;
    }

    public GoogleSecretBO getGoogleAuth(String account) {
        return getGoogleAuthInfo(account, env, "");
    }

    private GoogleSecretBO getGoogleAuthInfo(String info, String issuer, String suffix) {
        //调用谷歌验证器 生成该用户的谷歌秘钥和认证路径
        GoogleAuthenticator googleAuthenticator = new GoogleAuthenticator();
        GoogleAuthenticatorKey googleAuthenticatorKey = googleAuthenticator.createCredentials();
        String googleSecret = googleAuthenticatorKey.getKey();
        String googleAuthURL = GoogleAuthenticatorQRGenerator.getOtpAuthTotpURL(issuer, info + suffix, googleAuthenticatorKey);
        //新生成的放入缓存
        redisCacheService.set(getGoogleAuthSecretKeyCacheKey(info), googleSecret, GOOGLE_AUTH_TIME_OUT * 60);
        redisCacheService.set(getGoogleAuthUrlCacheKey(info), googleAuthURL, GOOGLE_AUTH_TIME_OUT * 60);
        return new GoogleSecretBO().setGoogleSecret(googleSecret).setOtpURL(googleAuthURL);
    }

    public String getGoogleSecret(String info) {
        //从缓存中获取用户生成的密钥
        String googleSecret = redisCacheService.get(getGoogleAuthSecretKeyCacheKey(info));
        if (StringUtils.isBlank(googleSecret)) {
            throw GoogleAuthException.build("谷歌认证密钥过期，请重新获取");
        }
        return googleSecret;
    }

    /**
     *
     * @param googleSecret    -
     * @param googleCheckCode 由getGoogleAuthInfo返回的googleSecret用户生成的谷歌验证码
     * @return
     */
    public void checkGoogleCode(String googleSecret, String googleCheckCode) {
        // mock
        if (!authEnable && "000000".equals(googleCheckCode)) {
            log.info("mock google auth pass.");
            return;
        }
        //验证谷歌验证码
        GoogleAuthenticatorConfig.GoogleAuthenticatorConfigBuilder configBuilder =
                new GoogleAuthenticatorConfig.GoogleAuthenticatorConfigBuilder()
                        .setTimeStepSizeInMillis(TimeUnit.SECONDS.toMillis(timeStepSizeInSeconds))
                        .setWindowSize(googleAuthWindowSize);
        GoogleAuthenticator googleAuthenticator = new GoogleAuthenticator(configBuilder.build());
        boolean checkResult = googleAuthenticator.authorize(googleSecret, Integer.parseInt(googleCheckCode));
        if (!checkResult) {
            throw GoogleAuthException.build("谷歌验证码错误");
        }
    }
}
