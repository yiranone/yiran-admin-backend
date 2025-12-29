package one.yiran.dashboard.web.filter;


import lombok.extern.slf4j.Slf4j;
import one.yiran.common.exception.BusinessException;
import one.yiran.dashboard.common.expection.GoogleAuthException;
import one.yiran.dashboard.common.expection.user.UserException;
import one.yiran.dashboard.common.expection.user.UserHasNotPermissionException;
import one.yiran.common.domain.ResponseContainer;
import one.yiran.dashboard.common.util.TraceUtil;
import one.yiran.dashboard.interceptor.HttpLogPrinter;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.hibernate.exception.ConstraintViolationException;
import org.springframework.core.annotation.Order;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Component;
import org.springframework.validation.BindException;
import org.springframework.validation.ObjectError;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import javax.persistence.PersistenceException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;

@Slf4j
@Component
@Order(0)
public class ExceptionFilter implements HandlerExceptionResolver {

    @Override
    public ModelAndView resolveException(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) {

        //httpServletResponse.getWriter().write("wrong" + e.getMessage());
        //httpServletResponse.flushBuffer();

        int code = ResponseContainer.FAIL_CODE;
        String msg = "System error, please try again later";
        Object data = null;
        if (e instanceof UserHasNotPermissionException) {
            UserHasNotPermissionException ce = (UserHasNotPermissionException) e;
            if (StringUtils.isNotBlank(ce.getPermission())) {
                msg = String.format("No permissions[%s]", ce.getPermission());
            } else {
                msg = ce.getMessage();
            }
        } else if (e instanceof HttpRequestMethodNotSupportedException) {
            msg = String.format("The system does not support the request[%s]", e.getMessage());
        } else if (e instanceof UserException) {
            UserException uexp = (UserException) e;
            log.error("Request {} exception, user:{},{}",e.getClass().getSimpleName(),uexp.getLoginName(),uexp.getMessage());
            code = uexp.getCode();
            msg = uexp.getMessage();
        } else if (e instanceof GoogleAuthException) {
            GoogleAuthException ex = (GoogleAuthException) e;
            code = ex.getCode();
            msg = ex.getMessage();
            data = ex.getData();
        } else if (e instanceof BusinessException) {
            log.error("Request BusinessException exception", e);
            BusinessException bexp = (BusinessException) e;
            code = bexp.getCode();
            msg = bexp.getMessage();
        } else if (e instanceof MethodArgumentNotValidException) {
            MethodArgumentNotValidException ex = (MethodArgumentNotValidException) e;
            log.info("Parameter check exception:{}", ex.getBindingResult());
            msg = ex.getBindingResult().getAllErrors().get(0).getDefaultMessage();
        } else if(e instanceof BindException){
            BindException ex = (BindException)e;
            List<ObjectError> errors = ex.getAllErrors();
            ObjectError error = errors.get(0);
            msg = error.getDefaultMessage();
        } else if(e instanceof NoHandlerFoundException){
            NoHandlerFoundException ex = (NoHandlerFoundException)e;
            msg = "The requested resource does not exist:" + ex.getRequestURL();
        }  else if(e instanceof PersistenceException){
            PersistenceException ex = (PersistenceException)e;
            if(ex.getCause() instanceof ConstraintViolationException) {
                ConstraintViolationException sqlice = (ConstraintViolationException) e.getCause();
                msg = "The system is abnormal. Contact the administrator." + sqlice.getSQLException().getMessage();
            } else {
                log.error("Persistent exception", e);
                msg = "The system is abnormal. Contact the administrator. Persistent exception";
            }
        } else if(e instanceof DuplicateKeyException){
            DuplicateKeyException ex = (DuplicateKeyException)e;
            String errDetail = ex.getMessage();
            log.error("Primary key conflict", e);
            msg = "The system is abnormal. Contact the administrator. Primary key conflict";
        } else {
            if (StringUtils.containsIgnoreCase(ExceptionUtils.getRootCauseMessage(e), "Broken pipe")) {   //(2)
                return null;
            }
            log.error("Request failed, unknown exception", e);
            String message = e.getMessage();
            log.error("stack: {}", ExceptionUtils.getStackTrace(e));
            log.error("stack-2: {}", Arrays.toString(e.getStackTrace()));
            if (StringUtils.isNotBlank(message))
                msg = message;
        }

        ModelAndView v = new ModelAndView(new MappingJackson2JsonView());
        v.addObject("code", code);
        v.addObject("msg", msg);
        v.addObject("traceId", TraceUtil.getTraceId());
        if (data != null) {
            v.addObject("data", data);
        }

        HttpLogPrinter.print(httpServletRequest,v.getModel());

        return v;
    }
}
