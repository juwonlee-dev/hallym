package hallym.club.clubmember.web;

import java.util.Date;
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
import hallym.club.clubmember.vo.ClubMemberVO;
import hallym.club.user.vo.UserVO;
import hallym.club.utils.CommonUtils;

@Controller
public class ClubMemberController {
	
	@Resource(name = "clubMemberService")
	private ClubMemberService clubMemberService;
	
	/*
	 * @RequestMapping(value="/clubSignUpForm.do")
	 * 동아리
	 * 동아리 가입 신청 양식
	 * @RequestParam club_id, club_nm
	*/
	@RequestMapping(value="/clubSignUpForm.do")
	public ModelAndView clubSignUpForm(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false) String club_id,
							 @RequestParam(value = "club_nm", required = false, defaultValue ="") String club_nm) throws Exception{
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
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
		
		System.err.println("[clubSignUpForm.do] club_nm: " + club_nm);
		mav.addObject("club_id", club_id);
		mav.addObject("club_nm", club_nm);
		mav.addObject("userVO", userVO);
		mav.setViewName("popup/clubSignUpForm");
		return mav;
	}
	
	
	/*
	 * @RequestMapping(value="/clubSignUpAction.do")
	 * 동아리
	 * 동아리 가입  신청 (동작)
	 * @RequestParam club_id, major, grade, name
	 * @RequestParam phone_no, email, plan
	 * @RequestParam hope, user_id
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
		Date today = new Date();
		params.put("join_dt", today);
		clubMemberService.joinApplicationClub(params);
		
		CommonUtils.windowClose(response, "정상처리 되었습니다.");
		return null;
	}

	
	/*
	 * @RequestMapping(value="/clubMemberInfo.do")
	 * 동아리
	 * 동아리 회원 정보
	 * @RequestParam club_id, student_id
	*/
	@RequestMapping(value="/clubMemberInfo.do")
 	public ModelAndView clubMemberInfo(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="0") String club_id,
							 @RequestParam(value = "student_id", required = false, defaultValue ="") String student_id )
	{
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		Map<String, Object> membersParams = new HashMap<String, Object>();
		membersParams.put("club_id", club_id);
		membersParams.put("join_cd", "008001");
		membersParams.put("opt", 1);
		membersParams.put("id", student_id);
		
		ClubMemberVO memberInfo = clubMemberService.getClubMember(membersParams).get(0);
		System.err.println("[clubMemberInfo.do] memberInfo: \n" + memberInfo);
		
		
		if (!memberInfo.getJoin_cd().equals("008001")) {
			CommonUtils.showAlert(response, "가입승인이 안된 동아리 입니다.", "index.do");
			return null;
		}
		
		
		if (student_id.equals(userVO.getId())) {
	   		CommonUtils.showAlert(response, "자신을 수정 할 수 없습니다..", "clubIntro.do?club_id=" + club_id);
			return null;
		} 
		ClubMemberVO president = clubMemberService.getClubPresident(membersParams);
		boolean isPresident = false;
		if(userVO.getId().equals(president.getStudent_id()))
			isPresident = true;
		
		membersParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(membersParams);
		
		boolean isStaff = false;
		if(staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;
		
		if(! isStaff) {
			CommonUtils.showAlert(response, "임원이상 이용하는한 서비스 입니다.", "clubIntro.do?club_id=" + club_id);
			return null;
		}
		
		mav.addObject("club_id", club_id);
		session.setAttribute("join_cd",  memberInfo.getJoin_cd());
		session.setAttribute("staff_cd",  memberInfo.getStaff_cd());
		mav.addObject("isPresident", isPresident);
		mav.addObject("memberInfo", memberInfo);
		mav.setViewName("popup/clubMemberInfo");
		return mav;
	}
	
	
	/*
	 * @RequestMapping(value="/clubStaffUpdateAction.do")
	 * 동아리
	 * 동아리 회원 직위 수정(동작)
	 * @RequestParam club_id, student_id
	 * @RequestParam staff(staff_cd), submit
	*/
	@RequestMapping(value="/clubStaffUpdateAction.do")
 	public ModelAndView clubStaffUpdateAction(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="0") String club_id,
							 @RequestParam(value = "student_id", required = false, defaultValue ="") String student_id,
							 @RequestParam(value = "staff_cd", required = false, defaultValue ="") String staff_cd,
							 @RequestParam(value = "submit", required = false, defaultValue ="") String submit)
	{
		if (club_id.equals("0")) {
			CommonUtils.showAlertHistoryBack(response, "오류 발생");
			return null;
		}
		
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		System.err.println("[clubStaffUpdateAction.do] club_id: " + club_id);
		System.err.println("[clubStaffUpdateAction.do] student_id: " + student_id);
		System.err.println("[clubStaffUpdateAction.do] staff_cd: " + staff_cd);
		System.err.println("[clubStaffUpdateAction.do] submit: " + submit);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", userVO.getId());
		params.put("club_id", club_id);
		String staff = clubMemberService.getStaffCD(params);
		boolean isStaff = false;
		if(staff.equals("004001") || staff.equals("004002"))
			isStaff = true;
		
		if(! isStaff) {
			CommonUtils.showAlert(response, "임원이상 이용하는한 서비스 입니다.", "clubIntro.do?club_id=" + club_id);
			return null;
		}
		if(submit.equals("직위변경")) {
			params.put("club_id", club_id);
			params.put("staff_cd", staff_cd);
			params.put("id", student_id);
			clubMemberService.updateClubMember(params);
			CommonUtils.showAlert(response, "정상 처리 되었습니다.", "/clubManageList.do?club_id=" + club_id);
			return null;
		} 
		else if (submit.equals("회장위임")) {
			params.put("club_id", club_id);
			params.put("staff_cd", "004004");
			params.put("id", userVO.getId());
			clubMemberService.updateClubMember(params);
			
			params.put("staff_cd", "004001");
			params.put("id", student_id);
			clubMemberService.updateClubMember(params);
			CommonUtils.showAlert(response, "정상 처리 되었습니다.", "/clubManageList.do?club_id=" + club_id);
			return null;
		} else {
			CommonUtils.showAlert(response, "오류 발생.", "/clubIntro.do?club_id=" + club_id);
			return null;
		}
		
	}


}