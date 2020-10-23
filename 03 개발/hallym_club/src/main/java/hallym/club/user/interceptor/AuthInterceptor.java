package hallym.club.user.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import hallym.club.user.vo.UserVO;
import hallym.club.utils.CommonUtils;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	// preHandle() : 컨트롤러보다 먼저 수행되는 메서드
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
    	
    	/* 
    	 * session : 세션 객체
    	 * isPass : 요청받은 컨트롤러로 이동을 허용하는가?
    	 * userVO : 로그인한 사용자의 정보
    	 * isLoginPage : 로그인 페이지인가?
    	 * isLogoutPage : 로그아웃 페이지인가?
    	 * isAuth : 로그인이 되어있는가?
    	 * */

    	HttpSession session = request.getSession();
		boolean isPass = true;
    	UserVO userVO = (UserVO) session.getAttribute("userVO");
    	boolean isLoginPage = (request.getRequestURI().equalsIgnoreCase("/login.do"));
        boolean isLogoutPage = (request.getRequestURI().equalsIgnoreCase("/logout.do"));
        boolean isAuth = !(userVO == null || userVO.getId().isEmpty());
		
		if(!isAuth) { // 비로그인일 경우
			if(!isLoginPage && !isLogoutPage) { // 로그인, 로그아웃 페이지가 아님
				CommonUtils.showAlert(response, "로그인이 필요한 서비스입니다.", "/login.do");
				isPass = false;
			} else if(isLogoutPage) { // 로그아웃 페이지일 경우
				CommonUtils.showAlert(response, "먼저 로그인해야 합니다.", "/login.do");
				isPass = false;
			}
		} else if(isLoginPage) { // 로그인이 되어있고 로그인 페이지인 경우
			CommonUtils.showAlert(response, "이미 로그인이 되어있습니다.", "/index.do");
			isPass = false;
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
