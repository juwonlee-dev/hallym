package hallym.club.user.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
import hallym.club.club.service.ClubService;
import hallym.club.club.vo.ClubVO;
import hallym.club.clubmember.service.ClubMemberService;
import hallym.club.clubmember.vo.ClubMemberVO;
import hallym.club.common.service.CommonService;
import hallym.club.user.service.UserService;
import hallym.club.user.vo.UserVO;
import hallym.club.utils.CommonUtils;

@Controller
public class UserController {

	@Resource(name = "userService")
	private UserService userService;

	@Resource(name = "clubService")
	private ClubService clubService;
	
	@Resource(name = "clubMemberService")
	private ClubMemberService clubMemberService;
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@Resource(name = "commonService")
	private CommonService commonService;
	
	/*
	 * @RequestMapping(value="/loginView.do")
	 * 유저
	 * 로그인 페이지
	*/
	@RequestMapping(value = "/loginView.do")
	public ModelAndView ViewLogin(HttpServletRequest request,
								  ModelAndView mav){
		mav.setViewName("hallym/Login");
		return mav;
	}

	/*
	 * @RequestMapping(value="/login.do", method = RequestMethod.GET)
	 * 유저
	 * 로그인 페이지
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
	 * @RequestMapping(value="/login.do", method = RequestMethod.POST)
	 * 유저
	 * 로그인 페이지 (동작)
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
			System.err.println("[login.do] 알 수 없는 오류가 발생했습니다.");
			CommonUtils.showAlert(response, "알 수 없는 오류가 발생했습니다.","login.do");
			return null;
		} 
		else if(result.equalsIgnoreCase("N")) {
			System.err.println("[login.do] 해당 학번/사번을 찾을 수 없습니다.");
			CommonUtils.showAlert(response, "해당 학번/사번을 찾을 수 없습니다.","login.do");
			return null;
		}
		else {
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
		Date today = new Date();
		params3.put("input_date", today);
		commonService.writeLog(params3);
		
		return result;
	}
	
	/*
	 * @RequestMapping(value="/logout.do")
	 * 유저
	 * 로그아웃 (동작)
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
	 * @RequestMapping(value="/profile.do")
	 * 마이페이지
	 * 마이페이지
	 * @RequestParam agreeTerm
	*/
	@RequestMapping(value="/profile.do")
	public ModelAndView profile(HttpServletRequest request,
							HttpServletResponse response,
							@RequestParam(value = "page_cd", required = false, defaultValue = "014003") String page_cd,
							ModelAndView mav) throws Exception {
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		List<ClubMemberVO> clubMemberList = null;
		
		switch (page_cd) {
		case "014001":
			Map<String, Object> waitJoinClubParams = new HashMap<String, Object>();
			waitJoinClubParams.put("id", userVO.getId());
			waitJoinClubParams.put("join_cd", "008003");
			List<ClubVO> waitJoinClub = clubService.getWaitJoinClub(waitJoinClubParams);
			for(ClubVO clubVO : waitJoinClub) {
				switch (clubVO.getClub_gb_cd()) {
				case "001001":
					clubVO.setClub_gb_cd("중앙동아리");
					break;
				case "001002":
					clubVO.setClub_gb_cd("과동아리");
				}
				
				switch (clubVO.getClub_at_cd()) {
				case "002001":
					clubVO.setClub_at_cd("공연");
					break;
				case "002002":
					clubVO.setClub_at_cd("학술");
					break;
				case "002003":
					clubVO.setClub_at_cd("취미예술");
					break;
				case "002004":
					clubVO.setClub_at_cd("종교");
					break;
				case "002005":
					clubVO.setClub_at_cd("체육");
					break;
				case "002006":
					clubVO.setClub_at_cd("봉사");
					break;
				case "002007":
					clubVO.setClub_at_cd("기타");
					break;
				}
				Map<String, Object> cntParams = new HashMap<String, Object>();
				cntParams.put("club_id", clubVO.getClub_id());
				cntParams.put("opt", 1);
				cntParams.put("join_cd", "008001");
				clubVO.setCnt(clubMemberService.getClubMemberCnt(cntParams));
				clubVO.setPresident(clubMemberService.getClubPresident(cntParams).getName());
				
               	SimpleDateFormat newFormat = new SimpleDateFormat("yyyy.MM.dd"); // String 타입을 Date 타입으로 변환
               	SimpleDateFormat oldFormat = new SimpleDateFormat("yyyyMMdd");
               	Date oldDate;
               	try {
               		oldDate = oldFormat.parse(clubVO.getOpen_dt());
               		clubVO.setOpen_dt(newFormat.format(oldDate));
               	} catch (Exception e) {
               		continue;
				}
			}
			System.err.println("[profile.do] waitJoinClub: " + waitJoinClub);
			mav.addObject("waitJoinClub", waitJoinClub);
			break;
		case "014002":
			Map<String, Object> waitRegisterClubParams = new HashMap<String, Object>();
			waitRegisterClubParams.put("id", userVO.getId());
			waitRegisterClubParams.put("register_cd", "008003");
			List<ClubVO> waitRegisterClubList = clubService.getWaitRegisterClub(waitRegisterClubParams);
			
			for(ClubVO clubVO : waitRegisterClubList) {
				switch (clubVO.getClub_gb_cd()) {
				case "001001":
					clubVO.setClub_gb_cd("중앙동아리");
					break;
				case "001002":
					clubVO.setClub_gb_cd("과동아리");
				}
				
				switch (clubVO.getClub_at_cd()) {
				case "002001":
					clubVO.setClub_at_cd("공연");
					break;
				case "002002":
					clubVO.setClub_at_cd("학술");
					break;
				case "002003":
					clubVO.setClub_at_cd("취미예술");
					break;
				case "002004":
					clubVO.setClub_at_cd("종교");
					break;
				case "002005":
					clubVO.setClub_at_cd("체육");
					break;
				case "002006":
					clubVO.setClub_at_cd("봉사");
					break;
				case "002007":
					clubVO.setClub_at_cd("기타");
					break;
				}
				waitRegisterClubParams.put("club_id", clubVO.getClub_id());
				clubVO.setPresident(clubMemberService.getClubPresident(waitRegisterClubParams).getName());
				
				SimpleDateFormat newFormat = new SimpleDateFormat("yyyy.MM.dd"); // String 타입을 Date 타입으로 변환
               	SimpleDateFormat oldFormat = new SimpleDateFormat("yyyyMMdd");
               	Date oldDate;
               	try {
               		oldDate = oldFormat.parse(clubVO.getOpen_dt());
               		clubVO.setOpen_dt(newFormat.format(oldDate));
               	} catch (Exception e) {
               		continue;
				}
			}
			System.err.println("[profile.do] waitRegisterClubList: " + waitRegisterClubList);
			mav.addObject("waitRegisterClubList", waitRegisterClubList);
			break;
		case "014003":
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("id", userVO.getId());
			clubMemberList = clubMemberService.getMyInfo(params);
			
			mav.addObject("phone_no", clubMemberList.get(0).getPhone_no());
			mav.addObject("email", clubMemberList.get(0).getEmail());
			break;

		}
		
		/* profile */
		session.setAttribute("page_cd", page_cd);
		mav.addObject("userVO", userVO);
		mav.setViewName("hallym/profile");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/applyClubDeleteAction.do")
	 * 마이페이지
	 * 마이페이지 - 동아리 가입신청 취소 (동작)
	 * @RequestParam club_id
	*/
	@RequestMapping(value="/applyClubDeleteAction.do")
	public ModelAndView applyClubDeleteAction(HttpServletRequest request,
							HttpServletResponse response,
							ModelAndView mav, 
							@RequestParam(value = "club_id", required = false, defaultValue ="") String club_id) {
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		Map<String, Object> leaveClubParams = new HashMap<String, Object>();
		leaveClubParams.put("id", userVO.getId());
		leaveClubParams.put("club_id", club_id);
		
		try {
			clubMemberService.leaveClub(leaveClubParams);
			CommonUtils.showAlert(response, "정상적으로 처리 되었습니다.", "profile.do");
			return null;
		} catch (Exception e) {
			System.err.println("[applyClubDeleteAction.do] ERR: " + e.getMessage());
			CommonUtils.showAlert(response, "오류 발생", "index.do");
			return null;
		}

	}
	
	/*
	 * @RequestMapping(value="/applyClubRegisterDeleteAction.do")
	 * 마이페이지
	 * 마이페이지 - 동아리 개설 신청 취소 (동작)
	 * @RequestParam club_id
	*/
	@RequestMapping(value="/applyClubRegisterDeleteAction.do")
	public ModelAndView applyClubRegisterDeleteAction(HttpServletRequest request,
							HttpServletResponse response,
							ModelAndView mav, 
							@RequestParam(value = "club_id", required = false, defaultValue ="") String club_id) {
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		Map<String, Object> leaveClubParams = new HashMap<String, Object>();

		leaveClubParams.put("club_id", club_id);
		leaveClubParams.put("id", userVO.getId());
		
		
		try {
			clubMemberService.leaveClub(leaveClubParams);
			clubService.deleteClub(leaveClubParams);
			CommonUtils.showAlert(response, "정상적으로 처리 되었습니다.", "profile.do");
			return null;
		} catch (Exception e) {
			System.err.println("[applyClubRegisterDeleteAction.do] ERR: " + e.getMessage());
			CommonUtils.showAlert(response, "오류 발생", "index.do");
			return null;
		}
		
		

	}

	
}
