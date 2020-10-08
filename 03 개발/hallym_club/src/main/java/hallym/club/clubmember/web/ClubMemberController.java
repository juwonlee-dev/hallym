package hallym.club.clubmember.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import hallym.club.clubmember.service.ClubMemberService;
import hallym.club.user.vo.UserVO;
import hallym.club.utils.CommonUtils;

@Controller
public class ClubMemberController {
	
	@Resource(name = "clubMemberService")
	private ClubMemberService clubMemberService;
	
	/*
	 * 동아리원
	 * 동아리 가입
	 * @RequestMapping(value="/clubSignUpForm.do")
	*/
	@RequestMapping(value="/clubSignUpForm.do")
	public ModelAndView clubSignUpForm(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false) String club_id,
							 @RequestParam(value = "club_nm", required = false, defaultValue ="") String club_nm) throws Exception{
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");

		if(userVO == null) {
			CommonUtils.showAlert(response, "로그인이 필요한 서비스입니다.", "login.do");
			return null;
		} 
		club_nm = CommonUtils.getUTF8(club_nm);
		
		System.err.println("[clubSignUpForm.do] club_id: " + club_id);
		System.err.println("[clubSignUpForm.do] userVO.getId(): " + userVO.getId());
		Map<String, Object> checkJoinClubparams = new HashMap<String, Object>();
		checkJoinClubparams.put("club_id", club_id);
		checkJoinClubparams.put("id", userVO.getId());
		String join_cd = clubMemberService.checkJoinClub(checkJoinClubparams);
		System.err.println("[clubSignUpForm.do] join_cd: " + join_cd);
		
		if(join_cd.equals("008003")) {
			CommonUtils.windowClose(response, "이미 신청한 동아리입니다.");
			return null;
		} else if(join_cd.equals("008001")) {
			CommonUtils.windowClose(response, "이미 가입된 동아리입니다.");
			return null;
		}
		
		mav.addObject("club_id", club_id);
		mav.addObject("club_nm", club_nm);
		mav.addObject("userVO", userVO);
		mav.setViewName("popup/clubSignUpForm");
		return mav;
	}
	
	/*
	 * 동아리원
	 * 동아리 가입 (동작)
	 * @RequestMapping(value="/clubSignUpAction.do")
	*/
	@RequestMapping(value="/clubSignUpAction.do")
	public ModelAndView clubSignUpAction(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "major", required = false, defaultValue ="") String major,
							 @RequestParam(value = "grade", required = false, defaultValue ="") String grade,
							 @RequestParam(value = "name", required = false, defaultValue ="") String name,
							 @RequestParam(value = "phone_no", required = false, defaultValue ="") String phone_no,
							 @RequestParam(value = "email", required = false, defaultValue ="") String email,
							 @RequestParam(value = "plan", required = false, defaultValue ="") String plan,
							 @RequestParam(value = "hope", required = false, defaultValue ="") String hope,
							 @RequestParam(value = "user_id", required = false, defaultValue ="") String user_id) throws Exception{
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");

		if(userVO == null) {
			CommonUtils.showAlert(response, "로그인이 필요한 서비스입니다.", "login.do");
			return null;
		} 
		
		System.err.println("[clubSignUpAction.do] club_id: " + club_id);
		System.err.println("[clubSignUpAction.do] major: " + major);
		System.err.println("[clubSignUpAction.do] grade: " + grade);
		System.err.println("[clubSignUpAction.do] name: " + name);
		System.err.println("[clubSignUpAction.do] phone_no: " + phone_no);
		System.err.println("[clubSignUpAction.do] email: " + email);
		System.err.println("[clubSignUpAction.do] plan: " + plan);
		System.err.println("[clubSignUpAction.do] hope: " + hope);
		System.err.println("[clubSignUpAction.do] user_id: " + user_id);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		params.put("id", user_id);
		params.put("name", name);
		params.put("major", major);
		params.put("grade", grade);
		if(userVO.getGender().equals("1"))
			params.put("gender_cd", "003001");
		else
			params.put("gender_cd", "003002");
		params.put("phone_no", phone_no);
		params.put("email", email);
		params.put("plan", plan);
		params.put("hope", hope);
		clubMemberService.joinApplicationClub(params);
		
		CommonUtils.windowClose(response, "정상처리 되었습니다.");
		return null;
	}

}
