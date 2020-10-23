package hallym.club.user.interceptor;
 
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import hallym.club.utils.CommonUtils;

public class PermissionInterceptor extends HandlerInterceptorAdapter {

	// preHandle() : 컨트롤러보다 먼저 수행되는 메서드
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
    	
    	/* 
    	 * session : 세션 객체
    	 * isPass : 요청받은 컨트롤러로 이동을 허용하는가?
    	 * auth_code : 사용자의 권한 코드
    	 * allowAuth : 허용할 권한 코드 목록
    	 * isAllow : 권한이 충족하는가?
    	 * */
    	
    	HttpSession session = request.getSession();
    	boolean isPass = false;
    	String auth_code = (String) session.getAttribute("auth_code");
    	String[] allowAuth = {"010001", "010002", "010003"};
		boolean isAllow = Arrays.asList(allowAuth).contains(auth_code);
    	
		isPass = isAllow;
		if (!isAllow) {
        	CommonUtils.showAlert(response, "접근이 거부되었습니다.", "/index.do");
        }
        
        return isPass;
    }
 
    // 컨트롤러가 수행되고 화면이 보여지기 직전에 수행되는 메서드
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
        super.postHandle(request, response, handler, modelAndView);
    }
     
}
