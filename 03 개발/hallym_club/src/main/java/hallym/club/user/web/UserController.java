package hallym.club.user.web;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import hallym.club.board.service.BoardService;
import hallym.club.common.service.CommonService;
import hallym.club.user.service.UserService;
import hallym.club.user.vo.UserVO;
import hallym.club.utils.CommonUtils;

@Controller
public class UserController {

	@Resource(name = "userService")
	private UserService userService;
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@Resource(name = "commonService")
	private CommonService commonService;
	
	
	/*
	 * 유저
	 * 로그인 페이지
	 * @RequestMapping(value="/loginView.do")
	*/
	@RequestMapping(value = "/loginView.do")
	public ModelAndView ViewLogin(HttpServletRequest request,
								  ModelAndView mav){
		mav.setViewName("hallym/Login");
		return mav;
	}

	/*
	 * 유저
	 * 로그인 페이지
	 * @RequestMapping(value="/login.do", method = RequestMethod.GET)
	*/
	@RequestMapping(value="/login.do", method = RequestMethod.GET)
	public ModelAndView loginFormSetUp(HttpServletRequest request, HttpServletResponse response,
			  ModelAndView mav)
	{
		
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		System.out.println("[login.do] method = GET");
		System.out.println("[login.do] userVO: " + userVO);
		
		if(userVO == null || userVO.getId().isEmpty()) {
			mav.setViewName("hallym/Login");
		} else {
			CommonUtils.showAlert(response, "이미 로그인이 되어있습니다.");
			mav.setViewName("hallym/index");
		}
		System.out.println("[login.do] mav: " + mav);
		return mav;
	}
	
	
	/*
	 * 유저
	 * 로그인 페이지 (동작)
	 * @RequestMapping(value="/login.do", method = RequestMethod.POST)
	 * @RequestParam gbn(GBN), user_id(ID)
	 * @RequestParam password(PASSWORD) chk_id
	*/
	@RequestMapping(value="/login.do",  method=RequestMethod.POST)
	public String loginAction(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "gbn", required = false) String GBN,
							 @RequestParam(value = "user_id", required = false) String ID,
							 @RequestParam(value = "password", required = false) String PASSWORD,
							 @RequestParam(value = "chk_id", required = false) String chk_id) {
		HttpSession session = request.getSession();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("GBN", GBN);
		params.put("ID", ID);
		params.put("PASSWORD", PASSWORD);
		
		// 사용자 로그인 체크
		String result = userService.checkLogin(session, params);
//		Cookie cookie = null;
//		if(chk_id != null && !chk_id.isEmpty() && chk_id.equalsIgnoreCase("Y")) {
//			cookie = new Cookie("ID", ID);
//			cookie.setMaxAge(60*60*24*7); /* 7 days */
//			response.addCookie(cookie);
//			
//			cookie = new Cookie("GBN", GBN);
//			cookie.setMaxAge(60*60*24*7); /* 7 days */
//			response.addCookie(cookie);
//		} else {
//			cookie = new Cookie("ID", null);
//			cookie.setMaxAge(0);
//			response.addCookie(cookie);
//			
//			cookie = new Cookie("GBN", null);
//			cookie.setMaxAge(0);
//			response.addCookie(cookie);
//		}
		
		String logType = (result.equalsIgnoreCase("F"))?"011003":( (result.equalsIgnoreCase("E"))?"011004":"011001");
		if(result.equalsIgnoreCase("F")) {
			result = "hallym/Login";
			System.err.println("[login.do] 아이디 또는 비밀번호가 올바르지 않습니다.");
			CommonUtils.showAlert(response, "아이디 또는 비밀번호가 올바르지 않습니다.","login.do");
			return null;
		} else if(result.equalsIgnoreCase("E")) {
			result = "hallym/Login";
			System.err.println("[login.do] 알 수 없는 오류가 발생했습니다.");
			CommonUtils.showAlert(response, "알 수 없는 오류가 발생했습니다.","login.do");
			return null;
		} else {
			System.out.println("IP : " + CommonUtils.getClientIP(request));
			System.out.println("[UserController][login.do] (session) userVO: "+ (UserVO) session.getAttribute("userVO"));
		}
		
		/* 로그인 로그 남기기 */
		Map<String, Object> params3 = new HashMap<String, Object>();
		params3.put("IDNO", params.get("ID"));
		params3.put("PWD", params.get("PASSWORD"));
		params3.put("GBN", params.get("GBN"));
		params3.put("LOG_TYPE", logType);
		params3.put("LOG_IP", CommonUtils.getClientIP(request));
		params3.put("REASON", "");
		commonService.writeLog(params3);
		
		return result;
	}
	
	/*
	 * 유저
	 * 로그아웃 (동작)
	 * @RequestMapping(value="/logout.do")
	*/
	@RequestMapping(value="/logout.do")
	public ModelAndView logoutAction(HttpServletRequest request,
							HttpServletResponse response,
							ModelAndView mav) throws Exception {
		
		HttpSession session = request.getSession();
		session.setAttribute("LOG_TYPE", "011005"); // 직접 로그아웃(011005)
		session.invalidate();
		
		CommonUtils.showAlert(response, "로그아웃 되었습니다.", "/index.do");
    	return null;
	}
	
	/*
	 * 유저
	 * 마이페이지 
	 * @RequestMapping(value="/profile.do")
	*/
	@RequestMapping(value="/profile.do")
	public ModelAndView myPageFormSetUp(HttpServletRequest request,
							HttpServletResponse response,
							ModelAndView mav) throws Exception {
		
		HttpSession session = request.getSession();

		mav.setViewName("hallym/Login");
		
		response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('준비중입니다.')");
		//out.println("location.href='index.do'");
		out.println("history.go(-1);");
		out.println("window.close();");
		out.println("</script>");
        out.flush();

		return mav;
	}



}
