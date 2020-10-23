package hallym.club.common.interceptor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import hallym.club.utils.CommonUtils;

public class TermsInterceptor extends HandlerInterceptorAdapter {


	// preHandle() : 컨트롤러보다 먼저 수행되는 메서드
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		/*
		 * session : 세션 객체 isPass : 요청받은 컨트롤러로 이동을 허용하는가? isTermsPage : 약관 동의 view,
		 * action 페이지인가? agreeTermsList : 약관 코드들의 동의 여부 목록 isAgree : 필수 약관에 동의하였는가?
		 */

		HttpSession session = request.getSession();
		boolean isPass = true;
		boolean isTermsPage = (request.getRequestURI().equalsIgnoreCase("/terms.do")
				|| request.getRequestURI().equalsIgnoreCase("/termsAgreeAction.do"));
		Map<String, Boolean> agreeTermsList = (HashMap<String, Boolean>) session.getAttribute("agreeTerms");
		boolean isAgree = (agreeTermsList == null) ? false : (!agreeTermsList.containsValue(false));

		if (!isAgree) {
			CommonUtils.showAlert(response, "이용 약관에 동의해야합니다.", "/terms.do");
			isPass = false;
		} else if (isTermsPage) {
			CommonUtils.showAlert(response, "이미 이용 약관에 동의하였습니다.", "/index.do");
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
