package hallym.club.common.web;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import hallym.club.board.vo.BoardVO;
import hallym.club.budget.service.BudgetService;
import hallym.club.club.service.ClubService;
import hallym.club.club.vo.ClubVO;
import hallym.club.clubmember.service.ClubMemberService;
import hallym.club.clubmember.vo.ClubMemberVO;
import hallym.club.user.service.UserService;
import hallym.club.user.vo.UserVO;
import hallym.club.utils.CommonUtils;
import hallym.club.common.service.CommonService;
import hallym.club.file.service.FileService;
import hallym.club.product.service.ProductService;
import hallym.club.board.service.BoardService;

@Controller
public class CommonController {
	
	@Resource(name = "commonService")
	private CommonService commonService;
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@Resource(name = "clubService")
	private ClubService clubService;

	@Resource(name = "clubMemberService")
	private ClubMemberService clubMemberService;
	
	@Resource(name = "userService")
	private UserService userService;
	
	@Resource(name = "fileService")
	private FileService fileService;
	
	@Resource(name = "budgetService")
	private BudgetService budgetService;
	
	@Resource(name = "productService")
	private ProductService productService;
	
	/*
	 * @RequestMapping(value="/lndex.do")
	 * 메인
	 * 메인 페이지 
	*/
	@RequestMapping(value = "/index.do")
	public ModelAndView indexFormSetup(HttpServletRequest request,
							HttpServletResponse response,
							ModelAndView mav)
	{
		
		HttpSession session = request.getSession();
		UserVO userVO = null;
		if (session.getAttribute("userVO") != null) 
			userVO = (UserVO) session.getAttribute("userVO");
		
		List<BoardVO> boardList = null;
		List<ClubVO> clubList = null;
		
		boardList = boardService.getIntroNotice();		
		
		if(userVO == null) { clubList = clubService.getIntroClub(); }
		else {
			Map<String, Object> clubParams = new HashMap<String, Object>();
			clubParams.put("id", userVO.getId());
			try { clubList = clubService.getIntroClubLogin(clubParams); } 
			catch (Exception e) { System.out.println("[index.do getIntroClub(clubParams)] clublist Null Error"); }
		}
		mav.addObject("userVO", userVO);
		mav.addObject("boardList", boardList);
		mav.addObject("clubList", clubList);
		mav.setViewName("hallym/index");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/terms.do")
	 * 이용 약관
	 * 이용 약관 동의 페이지 
	*/
	@RequestMapping(value = "/terms.do")
	@SuppressWarnings("unchecked")
	public ModelAndView termsForm(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav)
	{
//		HttpSession session = request.getSession();
		response.setContentType("text/html; charset=UTF-8");
        
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		if(userVO == null || userVO.getId().isEmpty()) {
			CommonUtils.showAlert(response, "로그인이 필요한 서비스입니다.","login.do");
			return null;
		} 
		
		
		Map<String, Boolean> agreeTermsList = (HashMap<String, Boolean>) session.getAttribute("agreeTerms");
        boolean isAgree = (agreeTermsList == null)?false:(!agreeTermsList.containsValue(false));
        if(isAgree) {
        	CommonUtils.showAlert(response, "이미 이용 약관에 동의했습니다..", "/index.do");
        	return null;
        }
		
		mav.setViewName("hallym/Terms");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/termsAgreeAction.do")
	 * 이용 약관
	 * 이용 약관 동의 페이지 (동작)
	 * @RequestParam agreeTerm
	*/
	@RequestMapping(value = "/termsAgreeAction.do")
	public String termsAgreeAction(HttpServletRequest request, HttpServletResponse response,
									@RequestParam(value = "agreeTerm", required = false) List<String> agreeTerms) throws IOException
	{
		response.setContentType("text/html; charset=UTF-8");
        String redrt = "redirect:login.do";
        
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		if(userVO == null || userVO.getId().isEmpty()) {
			CommonUtils.showAlert(response, "로그인이 필요한 서비스입니다.");
		} else {
			if(agreeTerms == null || agreeTerms.size() < 1) {
				CommonUtils.showAlert(response, "이용 약관에 동의해야 서비스 이용이 가능합니다.", "/terms.do");
				return null;
			} else {
				for(String s : agreeTerms) {
					Map<String, Object> params = new HashMap<String, Object>();
					params.put("IDNO", userVO.getId());
					params.put("TERMS_CD", s);
					params.put("NAME", userVO.getName());
					params.put("AGREE_YN", "Y");
					params.put("AGREE_IP", CommonUtils.getClientIP(request));
					Date today = new Date();
					params.put("input_date", today);
					commonService.setTermsAgree(params);
				}
				
				Date todayDate = new Date();
				SimpleDateFormat todayFormat = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분 ss초");
				String todayStr = todayFormat.format(todayDate);
				String msg1 = "현재시각 [" + todayStr + "]\\n약관에 모두 동의하셨습니다.\\n다시 로그인해주세요.";
				CommonUtils.showAlert(response, msg1, "/logout.do");
				return null;
			}
		}
		return redrt;
	}
	
	/*
	 * @RequestMapping(value="/admin.do")
	 * 관리자
	 * 관리자 페이지 
	 * 권한 - 관리자, 학생처, 동아리연합회
	*/
	@RequestMapping(value = "/admin.do")
	public ModelAndView admin(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav)
	{
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		String auth_code = (String) session.getAttribute("auth_code");
		response.setContentType("text/html; charset=UTF-8");
        
		System.err.println("[admin.do] auth_code: " + auth_code);
		if(! (auth_code.equals("010001") || auth_code.equals("010002") || auth_code.equals("010003"))) {
			CommonUtils.showAlert(response, "관리자 권한이 필요한 서비스입니다.","index.do");
			return null;
		} 
		
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", userVO.getId());
		params.put("register_cd", "008003");
		List<ClubVO> waitRegisterClubList = clubService.getRegisterClub(params);
		params.put("register_cd", "008001");
		List<ClubVO> registerClubList = clubService.getRegisterClub(params);
		
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
			params.put("club_id", clubVO.getClub_id());
			ClubMemberVO clubMemberVO = clubMemberService.getClubPresident(params);
			clubVO.setPresident(clubMemberVO.getName());
			clubVO.setPresident_id(clubMemberVO.getStudent_id());
			
		}
		
		for(ClubVO clubVO : registerClubList) {
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
			params.put("club_id", clubVO.getClub_id());
			ClubMemberVO clubMemberVO = clubMemberService.getClubPresident(params);
			
			if(clubMemberVO != null) {
				clubVO.setPresident(clubMemberVO.getName());
				clubVO.setPresident_id(clubMemberVO.getStudent_id());
			} else {
				clubVO.setPresident("");
				clubVO.setPresident_id("");
			}
		}
		
		mav.addObject("waitRegisterClubList", waitRegisterClubList);
		mav.addObject("registerClubList", registerClubList);
		mav.setViewName("hallym/admin");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/clubInfo.do")
	 * 관리자
	 * 동아리 관리 페이지 
	 * 권한 - 관리자, 학생처, 동아리연합회
	*/
	@RequestMapping(value = "/clubInfo.do")
	public ModelAndView clubInfo(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav,
			@RequestParam(value = "club_id", required = false, defaultValue ="") String club_id)
	{
		
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		String auth_code = (String) session.getAttribute("auth_code");
		response.setContentType("text/html; charset=UTF-8");
        
		System.err.println("[clubInfo.do] auth_code: " + auth_code);
		if(! (auth_code.equals("010001") || auth_code.equals("010002") || auth_code.equals("010003"))) {
			CommonUtils.showAlert(response, "관리자 권한이 필요한 서비스입니다.","index.do");
			return null;
		} 
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		ClubVO clubVO = clubService.getClub(params);
		boolean isTopClub = false;
		if(clubVO.getTopClub_YN().equals("Y"))
			isTopClub=true;
		List<ClubMemberVO> clubMemberList = clubMemberService.getAllClubMember(params);
		
		
		System.err.println("[clubInfo.do] club_intro: " + clubVO.getIntro_save_file_nm());
		System.err.println("[clubInfo.do] club_poster: " + clubVO.getPoster_save_file_nm());
		mav.addObject("isTopClub", isTopClub);
		mav.addObject("clubRank", clubVO.getTopClub_rank());
		mav.addObject("club_id", club_id);
		mav.addObject("club_intro", clubVO.getIntro_save_file_nm());
		mav.addObject("club_poster", clubVO.getPoster_save_file_nm());
		mav.addObject("club_nm", clubVO.getClub_nm());
		mav.addObject("clubMemberList", clubMemberList);
		mav.setViewName("popup/clubInfo");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/registerUpdateAction.do")
	 * 관리자
	 * 동아리 개설 승인 (동작)  
	 * 권한 - 관리자, 학생처, 동아리연합회
	*/
	@RequestMapping(value = "/registerUpdateAction.do")
	public ModelAndView registerUpdateAction(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav,
			@RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
			@RequestParam(value = "submit", required = false, defaultValue ="") String submit)
	{
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		String auth_code = (String) session.getAttribute("auth_code");
		response.setContentType("text/html; charset=UTF-8");
        
		System.err.println("[registerUpdateAction.do] auth_code: " + auth_code);
		if(! (auth_code.equals("010001") || auth_code.equals("010002") || auth_code.equals("010003"))) {
			CommonUtils.showAlert(response, "관리자 권한이 필요한 서비스입니다.","index.do");
			return null;
		} 
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		
		if (submit.equals("수락")) {
			try {
				params.put("register_cd", "'008001'");
				clubService.updateRegister(params);
				CommonUtils.showAlert(response, "정상적으로 처리 되었습니다..","admin.do");
				return null;
			} catch (Exception e) {
				System.err.println("[registerUpdateAction.do] Err: " + e.getMessage());
				CommonUtils.showAlert(response, "에러 발생","index.do");
				return null;
			}
		}
		else if (submit.equals("거절")) {
			try {
				params.put("id", userVO.getId());
				clubMemberService.leaveClub(params);
				clubService.deleteClub(params);
				CommonUtils.showAlert(response, "정상적으로 처리 되었습니다.","admin.do");
				return null;
			}catch (Exception e) {
				System.err.println("[registerUpdateAction.do] Err: " + e.getMessage());
				CommonUtils.showAlert(response, "에러 발생","index.do");
				return null;
			}
			
		} else {
			System.err.println("[registerUpdateAction.do] Err: else");
			CommonUtils.showAlert(response, "에러 발생","index.do");
			return null;
		}
		
	}
	
	/*
	 * @RequestMapping(value="/clubDeleteAction.do")
	 * 관리자
	 * 동아리 삭제 (동작)
	 * 권한 - 관리자, 학생처, 동아리연합회
	*/
	@RequestMapping(value = "/clubDeleteAction.do")
	public ModelAndView clubDeleteAction(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav,
			@RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
			@RequestParam(value = "submit", required = false, defaultValue ="") String submit)
	{
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		String auth_code = (String) session.getAttribute("auth_code");
		response.setContentType("text/html; charset=UTF-8");
        
		System.err.println("[clubDeleteAction] auth_code: " + auth_code);
		if(! (auth_code.equals("010001") || auth_code.equals("010002") || auth_code.equals("010003"))) {
			CommonUtils.showAlert(response, "관리자 권한이 필요한 서비스입니다.","index.do");
			return null;
		} 
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		
		if (submit.equals("삭제")) {
			try {
				params.put("id", userVO.getId());
				clubMemberService.deleteClubMember(params);
				boardService.deleteClubBoard(params);
				fileService.deleteClubFile(params);
				params.put("io_gb_cd", "009001");
				budgetService.deleteBudget(params);
				params.put("io_gb_cd", "009002");
				budgetService.deleteBudget(params);
				productService.deleteProduct(params);
				clubService.deleteClub(params);
				
				CommonUtils.showAlert(response, "정상적으로 처리 되었습니다.","admin.do");
				return null;
			}catch (Exception e) {
				System.err.println("[clubDeleteAction.do] Err: " + e.getMessage());
				CommonUtils.showAlert(response, "에러 발생", "admin.do");
				return null;
			}
			
		} else {
			System.err.println("[clubDeleteAction.do] Err: else");
			CommonUtils.showAlert(response, "에러 발생","index.do");
			return null;
		}
		
	}
	
	/*
	 * @RequestMapping(value="/topClubAction.do")
	 * 관리자
	 * 우수 동아리 등록 및 해지 (동작)
	 * 권한 - 관리자, 학생처, 동아리연합회
	*/
	@RequestMapping(value = "/topClubAction.do")
	public ModelAndView topClubAction(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav,
			@RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
			@RequestParam(value = "at_cd", required = false, defaultValue ="") String at_cd,
			@RequestParam(value = "gb_cd", required = false, defaultValue ="") String gb_cd,
			@RequestParam(value = "submit", required = false, defaultValue ="") String submit)
	{
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		String auth_code = (String) session.getAttribute("auth_code");
		response.setContentType("text/html; charset=UTF-8");
        
		System.err.println("[topClubAction.do] auth_code: " + auth_code);
		if(! (auth_code.equals("010001") || auth_code.equals("010002") || auth_code.equals("010003"))) {
			CommonUtils.showAlert(response, "관리자 권한이 필요한 서비스입니다.","index.do");
			return null;
		} 
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		
		if (submit.equals("top in")) {
			try {
				params.put("topclub_yn", "Y");
				clubService.updateTopClubYN(params);
				CommonUtils.showAlert(response, "정상적으로 처리 되었습니다.","admin.do");
				return null;
			}catch (Exception e) {
				System.err.println("[topClubAction.do] Err: " + e.getMessage());
				CommonUtils.showAlert(response, "에러 발생","index.do");
				return null;
			}
			
		} 
		else if (submit.equals("top out")) {
			try {
				params.put("topclub_yn", "N");
				clubService.updateTopClubYN(params);
				CommonUtils.showAlert(response, "정상적으로 처리 되었습니다.","admin.do");
				return null;
			}catch (Exception e) {
				System.err.println("[topClubAction.do] Err: " + e.getMessage());
				CommonUtils.showAlert(response, "에러 발생","index.do");
				return null;
			}
		}
		else {
			System.err.println("[topClubAction.do] Err: else");
			CommonUtils.showAlert
			(response, "에러 발생","index.do");
			return null;
		}
	}
	
	/*
	 * @RequestMapping(value="/topClubRankAction.do")
	 * 동아리 관리
	 * 우수동이리 순위 (동작)
	 * 권한 - 관리자, 학생처, 동아리연합회
	*/
	@RequestMapping(value = "/topClubRankAction.do")
	public ModelAndView topClubRankAction(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav,
			@RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
			@RequestParam(value = "rank", required = false, defaultValue ="") String rank,
			@RequestParam(value = "submit", required = false, defaultValue ="") String submit)
	{
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		String auth_code = (String) session.getAttribute("auth_code");
		response.setContentType("text/html; charset=UTF-8");
        
		System.err.println("[topClubRankAction.do] auth_code: " + auth_code);
		if(! (auth_code.equals("010001") || auth_code.equals("010002") || auth_code.equals("010003"))) {
			CommonUtils.showAlert(response, "관리자 권한이 필요한 서비스입니다.","index.do");
			return null;
		} 
		if(rank.isEmpty()) {
			CommonUtils.showAlertNoClose(response, "순위를 입력해 주세요!!.", "clubInfo.do?club_id=" + club_id);
			return null;
		}
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);

		if (submit.equals("수정")) {
			try {
				
				params.put("topclub_rank", rank);
				clubService.updateTopClubRank(params);
				CommonUtils.showAlertNoClose(response, "정상적으로 처리 되었습니다.", "clubInfo.do?club_id=" + club_id);
				return null;
			} catch (Exception e) {
				System.err.println("[topClubRankAction.do] Err: " + e.getMessage());
				CommonUtils.showAlertNoClose(response, "에러 발생", "clubInfo.do?club_id=" + club_id);
				return null;
			}

		} else {
			CommonUtils.showAlertNoClose(response, "에러 발생", "clubInfo.do?club_id=" + club_id);
			return null;
		}
		
	}
	
	/*
	 * @RequestMapping(value="/clubPhotoChangeAction.do")
	 * 동아리 관리
	 * 동아리 프로필, 포스터 변경 (동작)
	 * 권한 - 관리자, 학생처, 동아리연합회
	*/
	@RequestMapping(value = "/clubPhotoChangeAction.do")
	public ModelAndView clubPhotoChangeAction(HttpServletRequest request, HttpServletResponse response, 
			 MultipartHttpServletRequest multi,
			ModelAndView mav,
			@RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
			@RequestParam(value = "submit", required = false, defaultValue ="") String submit)
	{
		submit = CommonUtils.getUTF8(submit);
		System.err.println("[clubPhotoChangeAction.do] submit: " + submit);
		
		if (submit.equals("업로드")) {
			
		
			ClubVO clubVO = new ClubVO();
			// https://cofs.tistory.com/40 참고
			// https://powerku.tistory.com/12 참고
			// https://m.blog.naver.com/PostView.nhn?blogId=jxs2&logNo=110177957010&proxyReferer=https:%2F%2Fwww.google.com%2F 참고
			String directory = multi.getSession().getServletContext().getRealPath("/upload/club/");
			System.err.println("[clubPhotoChangeAction.do] directory: " + directory);
			File upDir = new File(directory);
			if (!upDir.exists()) {
				upDir.mkdirs();
			}
			
	
			Iterator<String> fileNames = multi.getFileNames();		
			String parameter = (String) fileNames.next();
			MultipartFile mFile = multi.getFile(parameter);
			System.err.println("[clubPhotoChangeAction.do] parmeter: " + parameter);
			String fileName = mFile.getOriginalFilename().toLowerCase();
	
			System.err.println("[clubPhotoChangeAction.do] fileName: " + fileName);
			String fileSaveName = CommonUtils.uploadFile(fileName).toLowerCase();
			
			/* Intro */
			if (fileName == null || fileName.isEmpty()) {
				clubVO.setIntro_file_nm(fileName);
				clubVO.setIntro_save_file_nm(fileSaveName);
				
			} else {
				if (!fileName.toLowerCase().endsWith(".jpg") && !fileName.toLowerCase().endsWith(".png") && !fileName.toLowerCase().endsWith(".gif")
						&& !fileName.endsWith(".bmp")) {
					File file = new File(directory + fileSaveName);
					file.delete();
					CommonUtils.showAlertNoClose(response, "업로드할 수 없는 확장자입니다.", "clubInfo.do?club_id=" + club_id);
					return null;
					
				} else {
					try {
						mFile.transferTo(new File(directory + fileSaveName));
					} catch (IllegalStateException | IOException e) {
						System.err.println("[clubPhotoChangeAction.do] transferTo Error: " + e.getMessage());
						CommonUtils.showAlertNoClose(response, "업로드 오류", "clubInfo.do?club_id=" + club_id);
						return null;
					}
					clubVO.setIntro_file_nm(fileName);
					clubVO.setIntro_save_file_nm(fileSaveName);
				}
			}
	
			parameter = (String) fileNames.next();
			mFile = multi.getFile(parameter);
			System.err.println("[clubPhotoChangeAction.do] parmeter2: " + parameter);
			fileName = mFile.getOriginalFilename().toLowerCase();
			System.err.println("[clubPhotoChangeAction.do] fileName2: " + fileName);
			fileSaveName = CommonUtils.uploadFile(fileName).toLowerCase();
	
			/* Poster */
			if (fileName == null || fileName.isEmpty()) {
				clubVO.setPoster_file_nm(fileName);
				clubVO.setPoster_save_file_nm(fileSaveName);
			} else {
				if (!fileName.toLowerCase().endsWith(".jpg") && !fileName.toLowerCase().endsWith(".png") && !fileName.toLowerCase().endsWith(".gif")
						&& !fileName.endsWith(".bmp")) {
					File file = new File(directory + fileSaveName);
					file.delete();
					CommonUtils.showAlertNoClose(response, "업로드할 수 없는 확장자입니다.", "clubInfo.do?club_id=" + club_id);
					return null;
				} else {
					try {
						mFile.transferTo(new File(directory + fileSaveName));
					} catch (IllegalStateException | IOException e) {
						System.err.println("[clubPhotoChangeAction.do] transferTo Error: " + e.getMessage());
						CommonUtils.showAlertNoClose(response, "업로드 오류", "clubInfo.do?club_id=" + club_id);
						return null;
					}
					clubVO.setPoster_file_nm(fileName);
					clubVO.setPoster_save_file_nm(fileSaveName);
				}
			}		
			Map<String, Object> clubParams = new HashMap<String, Object>();
			clubParams.put("club_id", club_id);
			clubParams.put("intro_file_nm", clubVO.getIntro_file_nm());
			clubParams.put("intro_save_file_nm", clubVO.getIntro_save_file_nm());
			clubParams.put("poster_file_nm", clubVO.getPoster_file_nm());
			clubParams.put("poster_save_file_nm", clubVO.getPoster_save_file_nm());

			System.err.println("[clubPhotoChangeAction.do] intro_save_file_nm: " + clubVO.getIntro_save_file_nm());
			System.err.println("[clubPhotoChangeAction.do] poster_save_file_nm: " + clubVO.getPoster_save_file_nm());
			try {
				if(clubVO.getIntro_save_file_nm().isEmpty() &&
						clubVO.getPoster_save_file_nm().isEmpty()) { 
					CommonUtils.showAlertNoClose(response, "사진을 첨부해 주세요.", "clubInfo.do?club_id=" + club_id);
					return null;
				}
				
				if((clubVO.getIntro_save_file_nm() != null) &&
						(! clubVO.getIntro_save_file_nm().trim().equals(""))) {
					clubService.updateIntro(clubParams);
				}
				if((clubVO.getPoster_save_file_nm() != null) &&
						(! clubVO.getPoster_save_file_nm().trim().equals(""))) {
					clubService.updatePoster(clubParams);
				}
				CommonUtils.showAlertNoClose(response, "정상적으로 업로드 했습니다.", "clubInfo.do?club_id=" + club_id);
				return null;
			} catch (Exception e) {
				System.err.println("[clubPhotoChangeAction.do] Err: " + e.getMessage());
				CommonUtils.showAlertNoClose(response, "에러 발생", "clubInfo.do?club_id=" + club_id);
				return null;
			}
		} else if(submit.equals("프로필 삭제")){
			Map<String, Object> clubParams = new HashMap<String, Object>();
			clubParams.put("club_id", club_id);
			clubParams.put("intro_file_nm", "NULL");
			clubParams.put("intro_save_file_nm", "NULL");
			try {
				clubService.updateIntro(clubParams);
				CommonUtils.showAlertNoClose(response, "정상적으로 프로필을 삭제했습니다.", "clubInfo.do?club_id=" + club_id);
				return null;
			} catch (Exception e) {
				System.err.println("[clubPhotoChangeAction.do] Err: " + e.getMessage());
				CommonUtils.showAlertNoClose(response, "에러 발생", "clubInfo.do?club_id=" + club_id);
			}
			
			return null;
		} else if(submit.equals("포스터 삭제")) {
			Map<String, Object> clubParams = new HashMap<String, Object>();
			clubParams.put("club_id", club_id);
			clubParams.put("poster_file_nm", "NULL");
			clubParams.put("poster_save_file_nm", "NULL");
			try {
				clubService.updatePoster(clubParams);
				CommonUtils.showAlertNoClose(response, "정상적으로 포스터를 삭제했습니다.", "clubInfo.do?club_id=" + club_id);
				return null;
			} catch (Exception e) {
				System.err.println("[clubPhotoChangeAction.do] Err: " + e.getMessage());
				CommonUtils.showAlertNoClose(response, "에러 발생", "clubInfo.do?club_id=" + club_id);
				return null;
			}
			
		} else {
			System.err.println("[clubPhotoChangeAction.do] else Err: submit == " + submit);
			CommonUtils.showAlertNoClose(response, "에러 발생", "clubInfo.do?club_id=" + club_id);
			return null;
		}
	}
	
	/*
	 * @RequestMapping(value="/clubMemberAddAction.do")
	 * 동아리 관리
	 * 동아리 회원 추가 (동작)
	 * 권한 - 관리자, 학생처, 동아리연합회
	*/
	@RequestMapping(value = "/clubMemberAddAction.do")
	public ModelAndView clubMemberAddAction(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav,
			@RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
			@RequestParam(value = "student_id", required = false, defaultValue ="") String student_id,
			@RequestParam(value = "staff", required = false, defaultValue ="") String staff)
	{
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		String auth_code = (String) session.getAttribute("auth_code");
		response.setContentType("text/html; charset=UTF-8");
        
		System.err.println("[clubMemberAddAction.do] auth_code: " + auth_code);
		if(! (auth_code.equals("010001") || auth_code.equals("010002") || auth_code.equals("010003"))) {
			CommonUtils.showAlert(response, "관리자 권한이 필요한 서비스입니다.","index.do");
			return null;
		} 
		
		if(student_id.isEmpty()) {
			CommonUtils.showAlertNoClose(response, "학번을 입력해 주세요!!.", "clubInfo.do?club_id=" + club_id);
			return null;
		}
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("ID", student_id);
		UserVO joinUserVO = userService.getUserVO(params);
		if(joinUserVO.getId() == null) {
			CommonUtils.showAlertNoClose(response, "학번/사번 이 존재하지 않습니다.", "clubInfo.do?club_id=" + club_id);
			return null;
		}
		
		params.put("id", student_id);
		params.put("club_id", club_id);
		String join_cd = clubMemberService.getJoinCD(params);
		System.err.println("[clubMemberAddAction.do] join_cd: " + join_cd);
		
		if(join_cd.equals("008001")) {
			CommonUtils.showAlertNoClose(response, "이미 가입된 회원입니다.", "clubInfo.do?club_id=" + club_id);
			return null;
		}
		
		else if(join_cd.equals("008003") || join_cd.equals("008002")) {
			params.clear();
			params.put("club_id", club_id);
			params.put("staff_cd", staff);
			params.put("id", student_id);
			Date today = new Date();
			params.put("join_dt", today);
			try {
				clubMemberService.updateClubMember(params);
				CommonUtils.showAlertNoClose(response, "정상적으로 처리되었습니다.", "clubInfo.do?club_id=" + club_id);
				return null;
			} catch (Exception e) {
				System.err.println("[clubMemberAddAction.do] Err: " + e.getMessage());
				CommonUtils.showAlertNoClose(response, "에러 발생", "clubInfo.do?club_id=" + club_id);
				return null;
			}
		}
		
		params.clear();
		params.put("club_id", club_id);
		params.put("id", student_id);
		params.put("name", joinUserVO.getName());
		params.put("major", joinUserVO.getMajor());
		params.put("grade", joinUserVO.getGrade());
		if(joinUserVO.getGender().equals("1"))
			params.put("gender_cd", "003001");
		else
			params.put("gender_cd", "003002");
		params.put("phone_no", joinUserVO.getPhoneNumber());
		params.put("email", joinUserVO.getE_mail());
		params.put("join_cd", "008001");
		params.put("staff_cd", staff);
		Date today = new Date();
		params.put("join_dt", today);
		try {
			clubMemberService.insertClubMember(params);
			CommonUtils.showAlertNoClose(response, "정상적으로 처리 되었습니다.", "clubInfo.do?club_id=" + club_id);
			return null;
		} catch (Exception e) {
			System.err.println("[clubMemberAddAction.do] Err: " + e.getMessage());
			CommonUtils.showAlertNoClose(response, "에러 발생", "clubInfo.do?club_id=" + club_id);
			return null;
		}
		
	}
	
	/*
	 * @RequestMapping(value="/clubMemberDeleteAction.do")
	 * 동아리 관리
	 * 동아리 회원 삭제 (동작)
	 * 권한 - 관리자, 학생처, 동아리연합회
	*/
	@RequestMapping(value = "/clubMemberDeleteAction.do")
	public ModelAndView clubMemberDeleteAction(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav,
			@RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
			@RequestParam(value = "student_id", required = false, defaultValue ="") String student_id,
			@RequestParam(value = "submit", required = false, defaultValue ="") String submit)
	{
		
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		String auth_code = (String) session.getAttribute("auth_code");
		response.setContentType("text/html; charset=UTF-8");
        
		System.err.println("[clubMemberDeleteAction.do] auth_code: " + auth_code);
		if(! (auth_code.equals("010001") || auth_code.equals("010002") || auth_code.equals("010003"))) {
			CommonUtils.showAlert(response, "관리자 권한이 필요한 서비스입니다.","index.do");
			return null;
		} 
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		params.put("id", student_id);
		String staff_cd = clubMemberService.getStaffCD(params);
		System.err.println("[clubMemberDeleteAction.do] submit: " + submit);
		System.err.println("[clubMemberDeleteAction.do] staff_cd: " + staff_cd);
		if (submit.equals("삭제")) {
			if(staff_cd.equals("004001")) {
				CommonUtils.showAlertNoClose(response, "회장은 탈퇴 할 수 없습니다.", "clubInfo.do?club_id=" + club_id);
				return null;
			}
			try {
				clubMemberService.leaveClub(params);
				CommonUtils.showAlertNoClose(response, "정상적으로 처리 되었습니다.", "clubInfo.do?club_id=" + club_id);
				return null;
			} catch (Exception e) {
				System.err.println("[clubMemberDeleteAction.do] Err: " + e.getMessage());
				CommonUtils.showAlertNoClose(response, "에러 발생", "clubInfo.do?club_id=" + club_id);
				return null;
			}

		} else {
			CommonUtils.showAlertNoClose(response, "에러 발생", "clubInfo.do?club_id=" + club_id);
			return null;
		}
	}
	

	/*
	 * @RequestMapping(value="/introView.do")
	 * 동아리 연합회 소개
	 * 동아리 연합회 소개 
	*/
	@RequestMapping(value = "/introView.do")
	public ModelAndView introView(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav,
			@RequestParam(value = "board_cd", required = false, defaultValue ="") String board_cd)
	{
		
		HttpSession session = request.getSession();
		response.setContentType("text/html; charset=UTF-8");
		String auth_code = (String) session.getAttribute("auth_code");
		System.err.println("[introView.do] auth_code: " + auth_code);
		System.err.println("[introView.do] board_cd: " + board_cd);
		if(auth_code == null) auth_code = "0";
		if(board_cd == "" || board_cd.isEmpty()) board_cd = "007005";
		boolean isAdmin = false;
		if((auth_code.equals("010001") || auth_code.equals("010002") || auth_code.equals("010003"))) {
			isAdmin = true;
		} 
		System.err.println("[introView.do] isAdmin: " + isAdmin);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", 1);
		params.put("board_no", 1);
		params.put("board_cd", board_cd);
		BoardVO boardVO = boardService.getBoard(params);
		if(boardVO == null) boardVO = new BoardVO();
		
		mav.addObject("board_cd", board_cd);
	
		String contents = boardVO.getContents();
		
		String html = contents.replaceAll("&lt;", "<")
			.replaceAll("&gt;", ">")
			.replaceAll("&quot;", "\"")
			.replaceAll("&nbsp;", " ");
		
		mav.addObject("html", html);
		mav.addObject("boardVO", boardVO);
		mav.addObject("isAdmin", isAdmin);
		mav.setViewName("/hallym/intro");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/introUpdateForm.do")
	 * 동아리 연합회 소개
	 * 동아리 연합회 소개 
	*/
	@RequestMapping(value = "/introUpdateForm.do")
	public ModelAndView introUpdateForm(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav,
			@RequestParam(value = "board_cd", required = false, defaultValue ="") String board_cd)
	{
		
		HttpSession session = request.getSession();
		response.setContentType("text/html; charset=UTF-8");
		String auth_code = (String) session.getAttribute("auth_code");
		System.err.println("[introView.do] auth_code: " + auth_code);
		System.err.println("[introUpdateForm.do] board_cd: " + board_cd);

		if(auth_code == null) auth_code = "0";
		if(board_cd == "") board_cd = "007005";
		boolean isAdmin = false;
		if((auth_code.equals("010001") || auth_code.equals("010002") || auth_code.equals("010003"))) {
			isAdmin = true;
		} else {
			CommonUtils.showAlertNoClose(response, "관리자 권한이 필요합니다.", "/introView.do");
			return null;
		}
		session.setAttribute("board_cd", board_cd);
		System.err.println("[introUpdateForm.do] isAdmin: " + isAdmin);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", 1);
		params.put("board_no", 1);
		params.put("board_cd", board_cd);
		BoardVO boardVO = boardService.getBoard(params);
		if(boardVO == null) boardVO = new BoardVO();
//		System.err.println("[introUpdateForm.do] contents: " +  boardVO.getContents());
		
		mav.addObject("board_cd", board_cd);
		mav.addObject("boardVO", boardVO);
		mav.addObject("isAdmin", isAdmin);
		mav.setViewName("/hallym/introBoardUpdateForm");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/introUpdateAction.do")
	 * 동아리 연합회 소개
	 * 동아리 연합회 소개 
	*/
	@RequestMapping(value = "/introUpdateAction.do")
	public ModelAndView introUpdateAction(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav,
			@RequestParam(value = "contents", required = false, defaultValue ="") String contents,
			@RequestParam(value = "board_cd", required = false, defaultValue ="") String board_cd)
	{
		
		HttpSession session = request.getSession();
		response.setContentType("text/html; charset=UTF-8");
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		String auth_code = (String) session.getAttribute("auth_code");
		System.err.println("[introUpdateAction.do] auth_code: " + auth_code);
		System.err.println("[introUpdateAction.do] board_cd: " + board_cd);
		if(auth_code == null) auth_code = "0";
		boolean isAdmin = false;
		if((auth_code.equals("010001") || auth_code.equals("010002") || auth_code.equals("010003"))) {
			isAdmin = true;
		} else {
			CommonUtils.showAlertNoClose(response, "관리자 권한이 필요합니다.", "/introView.do");
			return null;
		}
		System.err.println("[introUpdateAction.do] isAdmin: " + isAdmin);
		System.err.println("[introUpdateAction.do] contents: \n" + contents);
		
		Date today = new Date();
		Map<String, Object> params = new HashMap<String, Object>();
		if(board_cd.equals("007005"))
			params.put("title", "동아리 연합회 소개");
		else if(board_cd.equals("007006"))
			params.put("title", "동아리방 배치도");
		else if(board_cd.equals("007007"))
			params.put("title", "동아리 회칙");
		else if(board_cd.equals("007008"))
			params.put("title", "동아리 세칙");
		else
			params.put("title", "동아리 연합회 소개");
		params.put("contents", contents);
		params.put("fix_yn", "N");
		params.put("attach_yn", "N");
		params.put("start_date", today);
		params.put("end_date", today);
		params.put("update_id", userVO.getId());
		params.put("update_ip", CommonUtils.getClientIP(request));
		params.put("update_date", today);
		
		params.put("club_id", 1);
		params.put("board_no", 1);
		params.put("board_cd", board_cd);
		
		try {
			boardService.updateBoard(params);
			CommonUtils.showAlertNoClose(response, "정상처리 되었습니다.", "/introView.do?board_cd="+board_cd);
		} catch (Exception e) {
			System.err.println("[introUpdateAction.do] ERR: \n" + e.getMessage());
			CommonUtils.showAlertNoClose(response, "요류가 발생했습니다.", "/introView.do?board_cd="+board_cd);
		}
		return null;
	}
	
}
