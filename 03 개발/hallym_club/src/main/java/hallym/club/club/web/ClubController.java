package hallym.club.club.web;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import hallym.club.board.service.BoardService;
import hallym.club.board.vo.BoardVO;
import hallym.club.file.vo.FileVO;
import hallym.club.file.service.FileService;
import hallym.club.budget.service.BudgetService;
import hallym.club.budget.vo.BudgetVO;
import hallym.club.club.service.ClubService;
import hallym.club.club.vo.ClubVO;
import hallym.club.activity.service.ActivityService;
import hallym.club.activity.vo.ActivityVO;
import hallym.club.clubmember.service.ClubMemberService;
import hallym.club.clubmember.vo.ClubMemberVO;
import hallym.club.common.service.CommonService;
import hallym.club.exception.ClubExistException;
import hallym.club.exception.ClubNotExistException;
import hallym.club.exception.UserNotExistException;
import hallym.club.product.service.ProductService;
import hallym.club.product.vo.ProductVO;
import hallym.club.user.service.UserService;
import hallym.club.user.vo.UserVO;
import hallym.club.utils.CommonUtils;

@Controller
public class ClubController {
	
	@Resource(name = "clubService")
	private ClubService clubService;
	
	@Resource(name = "userService")
	private UserService userService;
	
	@Resource(name = "clubMemberService")
	private ClubMemberService clubMemberService;
	
	@Resource(name = "productService")
	private ProductService productService;
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@Resource(name = "fileService")
	private FileService fileService;
	
	@Resource(name = "budgetService")
	private BudgetService budgetService;
	
	@Resource(name="commonService")
	private CommonService commonService;

	@Resource(name = "activityService")
	private ActivityService activityService;

	/*
	 * TODO 위치 변경 필요 ( profile.do )로 사용
	 * 검토후 삭제
	 * @RequestMapping(value="/clubMyInfo.do")
	 * 동아리 커뮤니티
	 * 동아리 - 소개
	 * @RequestParam club_id
	*/
	@RequestMapping(value="/clubMyInfo.do")
	public ModelAndView clubMyInfo(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id) {
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		session.setAttribute("club_id", club_id);
		
		/* 클럽 정보 */
		Map<String, Object> clubParams = new HashMap<String, Object>();
		clubParams.put("club_id", club_id);
		ClubVO clubVO = clubService.getClub(clubParams);
		
		if (clubVO == null) {
    		try {
    			throw new ClubNotExistException("존재 하지 않는 동아리 입니다.");
    		} catch (ClubNotExistException e) {
    			CommonUtils.showAlert(response, "존재 하지 않는 동아리 입니다.", "/index.do");
    			return null;
    		}
    	}
		
		/* 클럽 회장 */
		Map<String, Object> presidentParams = new HashMap<String, Object>();
		presidentParams.put("club_id", club_id);
		clubVO.setPresident(clubMemberService.getClubPresident(presidentParams).getName());
		
		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}
		
		boolean isStaff = false;
		if(staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;

		System.err.println("[clubMyInfo.do] Intro_save_file: " + clubVO.getIntro_save_file_nm());
		System.err.println("[clubMyInfo.do] poster_save_file: " + clubVO.getPoster_save_file_nm());
		System.err.println("[clubMyInfo.do] staff_cd: " + staff_cd);
		System.err.println("[clubMyInfo.do] isStaff: " + isStaff);
		
		
		memberParams.put("join_cd", "008001");
		ClubMemberVO clubMemberVO = clubMemberService.getClubMember(memberParams).get(0);
		
		/* clubPlatform */
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("open_dt", clubVO.getOpen_dt());
		mav.addObject("president_nm", clubVO.getPresident());
		mav.addObject("isStaff", isStaff);
		mav.addObject("club_intro", clubVO.getIntro_save_file_nm());
		mav.addObject("club_poster", clubVO.getPoster_save_file_nm());
		
		
		/* clubMyInfo */
		mav.addObject("club_nm", clubVO.getClub_nm());
		mav.addObject("userVO", userVO);
		mav.addObject("plan", clubMemberVO.getPlan());
		mav.addObject("hope", clubMemberVO.getHope());
		mav.setViewName("club/clubMyInfo");
		return mav;
	}
	
	/*
	 * TODO 위치 변경 필요
	 * @RequestMapping(value="/clubMyInfoAction.do")
	 * 동아리 커뮤니티
	 * 동아리 - 소개
	 * @RequestParam club_id, plan, hope
	*/
	@RequestMapping(value="/clubMyInfoAction.do")
	public ModelAndView clubMyInfoAction(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "email", required = false, defaultValue ="") String email,
							 @RequestParam(value = "phone_no", required = false, defaultValue ="") String phone_no,
							 @RequestParam(value = "plan", required = false, defaultValue ="") String plan,
							 @RequestParam(value = "hope", required = false, defaultValue ="") String hope) {
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		params.put("id", userVO.getId());
		params.put("major", userVO.getMajor());
		if(userVO.getGender().equals("1"))
			params.put("gender_cd", "003001");
		else
			params.put("gender_cd", "003002");
		params.put("phone_no", phone_no);
		params.put("email", email);
		params.put("plan", plan);
		params.put("hope", hope);
		
		try {
			clubMemberService.updateMyInfo(params);
			CommonUtils.showAlert(response, "정상처리 되었습니다.", "profile.do");
		return null;
		} catch (Exception e) {
			System.err.println("[clubMyInfoAction.do] Err: " + e.getMessage());
			CommonUtils.showAlert(response, "에러 발생", "profile.do");
			return null;
		}
	}
	
	/*
	 * @RequestMapping(value="/clubIntro.do")
	 * 동아리 커뮤니티
	 * 동아리 - 소개
	 * @RequestParam club_id
	*/
	@RequestMapping(value="/clubIntro.do")
	public ModelAndView clubIntro(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id) {
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		session.setAttribute("club_id", club_id);
		
		/* 클럽 정보 */
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		ClubVO clubVO = clubService.getClub(params);
		
		if (clubVO == null) {
    		try {
    			throw new ClubNotExistException("존재 하지 않는 동아리 입니다.");
    		} catch (ClubNotExistException e) {
    			CommonUtils.showAlert(response, "존재 하지 않는 동아리 입니다.", "/index.do");
    			return null;
    		}
    	}
		
		/* 클럽 회장 */
		params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		clubVO.setPresident(clubMemberService.getClubPresident(params).getName());

		/* 사용자 권한 */
		params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		params.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(params);

		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}
		
		boolean isStaff = false;
		if(staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;
		System.err.println("[clubIntro.do] Intro_save_file: " + clubVO.getIntro_save_file_nm());
		System.err.println("[clubIntro.do] poster_save_file: " + clubVO.getPoster_save_file_nm());
		System.err.println("[clubIntro.do] staff_cd: " + staff_cd);
		System.err.println("[clubIntro.do] isStaff: " + isStaff);
		
		/*  */
		params = new HashMap<String, Object>();
		List<BoardVO> noticeList = null;
		List<BoardVO> generalList = null;
		params.put("club_id", club_id);
		params.put("board_cd", "007001");
		noticeList = boardService.getClubBoardList(params);
		params.replace("board_cd", "007002");
		generalList = boardService.getClubBoardList(params);
		
		params.put("club_id", club_id);
		params.put("act_cd", "015001");
		params.put("act_kind_cd", "016");
		params.put("select", 1);
		params.put("cdn", "");
		params.put("limit", 5);
		
		params.put("startNum", 1);
		params.put("endNum", 5);
		
		List<ActivityVO> inActList = activityService.getActivityList(params);
		params.put("act_cd", "015002");
		List<ActivityVO> outActList = activityService.getActivityList(params);
		
		/* clubPlatform */
		mav.addObject("clubVO", clubVO);
		mav.addObject("noticeList", noticeList); //공지사항 목록
		mav.addObject("generalList", generalList); //자유게시판 목록
		
		mav.addObject("inActList", inActList); //교내활동 목록
		mav.addObject("outActList", outActList); //교외활동 목록
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("open_dt", clubVO.getOpen_dt());
		mav.addObject("president_nm", clubVO.getPresident());
		mav.addObject("isStaff", isStaff);
		mav.addObject("club_intro", clubVO.getIntro_save_file_nm());
		mav.addObject("club_poster", clubVO.getPoster_save_file_nm());
		
//		mav.setViewName("club/clubIntro");
		mav.setViewName("community/index");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/clubIntroView.do")
	 * 동아리 커뮤니티
	 * 동아리 - 소개
	 * @RequestParam club_id, board_cd
	*/
	@RequestMapping(value="/clubIntroView.do")
	public ModelAndView clubIntroView(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "board_cd", required = false, defaultValue ="") String board_cd){
		HttpSession session = request.getSession();
		response.setContentType("text/html; charset=UTF-8");
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		System.err.println("[clubIntroView.do] board_cd: " + board_cd);
		if(board_cd == "" || board_cd.isEmpty()) board_cd = "007005";
		
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		ClubVO clubVO = clubService.getClub(params);
		
		params.put("join_cd", "008001");
		params.put("id", userVO.getId());
		params.put("opt", 1);
		String staff_cd = null;
		try {
			staff_cd = clubMemberService.getClubMember(params).get(0).getStaff_cd();
		} catch (Exception e) {
//			System.err.println("[" + userVO.getName() + "] 은(는) " + clubVO.getClub_nm() + "에 가입되지 않았습니다.");
			staff_cd = "0";
		}
		params.put("board_no", 1);
		params.put("board_cd", board_cd);
		BoardVO boardVO = boardService.getBoard(params);
		if(boardVO == null) boardVO = new BoardVO();
		
		ClubMemberVO clubMemberVO = clubMemberService.getClubPresident(params);
		 
		boolean isStaff = false;
		if((staff_cd.equals("004001") || staff_cd.equals("004002") )) {
			isStaff = true;
		} 
		System.err.println("[clubIntroView.do] staff_cd: " + isStaff);
		
		mav.addObject("email", clubMemberVO.getEmail());
		mav.addObject("clubVO", clubVO);
		mav.addObject("board_cd", board_cd);
		mav.addObject("boardVO", boardVO);
		mav.addObject("isStaff", isStaff);
		mav.setViewName("/club/clubIntroView");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/clubIntroUpdateForm.do")
	 * 동아리  소개
	 * 동아리  소개 
	 * @RequestParam club_id, board_cd
	*/
	@RequestMapping(value = "/clubIntroUpdateForm.do")
	public ModelAndView introUpdateForm(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav,
			@RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
			@RequestParam(value = "board_cd", required = false, defaultValue ="") String board_cd)
	{
		
		HttpSession session = request.getSession();
		response.setContentType("text/html; charset=UTF-8");
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		System.err.println("[clubIntroUpdateForm.do] club_id: " + club_id);
		System.err.println("[clubIntroUpdateForm.do] board_cd: " + board_cd);
		
		Map<String, Object> params1 = new HashMap<String, Object>();
		params1.put("club_id", club_id);	
		ClubVO clubVO = clubService.getClub(params1);
		
		params1.put("join_cd", "008001");
		params1.put("id", userVO.getId());
		params1.put("opt", 1);
		String staff_cd = clubMemberService.getClubMember(params1).get(0).getStaff_cd();
		
		if(board_cd == "") board_cd = "007005";
		boolean isStaff = false;
		if((staff_cd.equals("004001") || staff_cd.equals("004002") )) {
			isStaff = true;
		} 
		else {
			CommonUtils.showAlertNoClose(response, "회장/부회장 권한이 필요합니다.", "/clubIntroView.do?club_id=" + club_id);
			return null;
		}
		session.setAttribute("board_cd", board_cd);
		System.err.println("[clubIntroUpdateForm.do] isStaff: " + isStaff);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		params.put("board_no", 1);
		params.put("board_cd", board_cd);
		BoardVO boardVO = boardService.getBoard(params);
		if(boardVO == null) boardVO = new BoardVO();
		
		mav.addObject("board_cd", board_cd);
		mav.addObject("boardVO", boardVO);
		mav.addObject("clubVO", clubVO);
		mav.addObject("club_id", club_id);
		mav.addObject("isStaff", isStaff);
		mav.setViewName("/club/clubIntroUpdateForm");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/clubIntroUpdateAction.do")
	 * 동아리  소개
	 * 동아리  소개 
	 * @RequestParam club_id, board_cd
	*/
	@RequestMapping(value = "/clubIntroUpdateAction.do")
	public ModelAndView introUpdateAction(MultipartHttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav,
			@RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
			@RequestParam(value = "contents", required = false, defaultValue ="") String contents)
	{
		
		HttpSession session = request.getSession();
		response.setContentType("text/html; charset=UTF-8");
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		Map<String, Object> params1 = new HashMap<String, Object>();
		params1.put("club_id", club_id);		
		params1.put("join_cd", "008001");
		params1.put("id", userVO.getId());
		params1.put("opt", 1);
		String staff_cd = clubMemberService.getClubMember(params1).get(0).getStaff_cd();

		boolean isStaff = false;
		if((staff_cd.equals("004001") || staff_cd.equals("004002") )) {
			isStaff = true;
		} 
		else {
			CommonUtils.showAlertNoClose(response, "회장/부회장 권한이 필요합니다.","/clubIntroView.do?club_id=" + club_id);
			return null;
		}
		System.err.println("[clubIntroUpdateAction.do] isStaff: " + isStaff);
		System.err.println("[clubIntroUpdateAction.do] contents: \n" + contents);
		
		Map<String, Object> checkParams = new HashMap<String, Object>();
		checkParams.put("club_id", club_id);
		checkParams.put("board_no", 1);
		checkParams.put("board_cd", "007005");
		BoardVO boardVO = boardService.getBoard(checkParams);
		
		Date today = new Date();
		Map<String, Object> params = new HashMap<String, Object>();
//		if(board_cd.equals("007005"))
//			params.put("title", "동아리  소개");
//		else if(board_cd.equals("007006"))
//			params.put("title", "동아리방 배치도");
//		else if(board_cd.equals("007007"))
//			params.put("title", "동아리 회칙");
//		else if(board_cd.equals("007008"))
//			params.put("title", "동아리 세칙");
//		else
//			params.put("title", "동아리  소개");
		params.put("title", "동아리  소개");
		params.put("contents", contents);
		params.put("fix_yn", "N");
		params.put("attach_yn", "N");
		params.put("start_date", today);
		params.put("end_date", today);
		
		params.put("club_id", club_id);
		params.put("board_no", 1);
		params.put("board_cd", "007005");
		if (boardVO == null) {
			params.put("input_id", userVO.getId());
			params.put("input_ip", CommonUtils.getClientIP(request));
			params.put("input_date", today);
			try {
				System.err.println("[clubIntroUpdateAction.do] boardVO: null");
				boardService.addBoard(params);
				CommonUtils.showAlertNoClose(response, "정상처리 되었습니다.", "/clubIntroView.do?club_id=" + club_id);
			} catch (Exception e) {
				System.err.println("[clubIntroUpdateAction.do] ERR: \n" + e.getMessage());
				CommonUtils.showAlertNoClose(response, "요류가 발생했습니다.", "/clubIntroView.do?club_id=" + club_id);
			}

		} else {
			params.put("update_id", userVO.getId());
			params.put("update_ip", CommonUtils.getClientIP(request));
			params.put("update_date", today);
			try {
				System.err.println("[clubIntroUpdateAction.do] boardVO: Not null");
				boardService.updateBoard(params);
				CommonUtils.showAlertNoClose(response, "정상처리 되었습니다.", "/clubIntroView.do?club_id=" + club_id);
			} catch (Exception e) {
				System.err.println("[clubIntroUpdateAction.do] ERR: \n" + e.getMessage());
				CommonUtils.showAlertNoClose(response, "요류가 발생했습니다.", "/clubIntroView.do?club_id=" + club_id);
			}
		}
		return null;
	}
	
	/*
	 * @RequestMapping(value="/clubProduct.do")
	 * 동아리 커뮤니티
	 * 동아리 - 물품목록
	 * 권한 - 총무 이상 이용 가능
	 * @RequestParam club_id
	*/
	@RequestMapping(value="/clubProduct.do")
	public ModelAndView clubProduct(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "page", required = false, defaultValue = "1") String page,
							 @RequestParam(value = "select", required = false, defaultValue = "") String select,
							 @RequestParam(value = "cdn", required = false, defaultValue = "") String cdn) {
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		if(club_id == null)
			club_id = (String) session.getAttribute("club_id");
		session.setAttribute("club_id", club_id);
		
		/* 클럽 정보 */
		Map<String, Object> clubParams = new HashMap<String, Object>();
		clubParams.put("club_id", club_id);
		ClubVO clubVO = clubService.getClub(clubParams);
		
		if (clubVO == null) {
    		try {
    			throw new ClubNotExistException("존재 하지 않는 동아리 입니다.");
    		} catch (ClubNotExistException e) {
    			CommonUtils.showAlert(response, "존재 하지 않는 동아리 입니다.", "/index.do");
    			return null;
    		}
    	}
		
		List<ProductVO> productList = null;
		
//		int productListCount = 1;
//		int limit = 5;
//		int currPage = Integer.parseInt(page);
//		currPage = (currPage < 1)?1:currPage;
//		int prevPage = 1;
//		int nextPage = 1;
//		int totalPage = 1;
//		int startNum = 1; // 범위 시작
//		int endNum = 1; // 범위 끝	
//		
		Map<String, Object> params = new HashMap<String, Object>();
		if(select.equals("0"))  {
			params.put("product_nm", cdn);
			params.put("product_cont", "");
		}
		else {
			params.put("product_nm", "");
			params.put("product_cont", cdn);
		}
//		params.put("club_id", club_id);
//		params.put("limit", limit);
//
//		
//		productListCount = productService.getProductListCnt(params);
//		totalPage = productService.getTotalPageCnt(params); 
//		
//		/* 페이지 번호에 따른 가져올 게시글 범위 */
//		if(totalPage <= 1) {
//			startNum = 1;
//			endNum = (productListCount < limit) ? productListCount:limit;
//			currPage = 1;
//			prevPage = currPage;
//			nextPage = currPage;
//		} else {
//			startNum = (currPage * limit) - limit + 1;
//			endNum = currPage * limit;
//			prevPage = currPage - 1;
//			prevPage = (prevPage < 1) ? 1: prevPage;
//			nextPage = (productListCount > endNum) ? (currPage+1):currPage;
//		}
//		
//		params.put("startNum", startNum);
//		params.put("endNum", endNum);

//		productList = productService.getProductList(params);

		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		
		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}
		boolean isStaff = false;
		if(staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;

		/* 물품목록 */
		params.put("club_id", club_id);
		productList = productService.getProducts(params);
		
		/* clubProduct */
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("cdn", cdn);
		mav.addObject("select", select);
		mav.addObject("isStaff", isStaff);
//		mav.addObject("totalPage", totalPage);
//		mav.addObject("prevPage", prevPage);
//		mav.addObject("currPage", currPage);
//		mav.addObject("nextPage", nextPage);

		mav.addObject("productList", productList);
//		mav.addObject("productListCount", productListCount);
		
//		mav.setViewName("club/clubProduct");
		mav.setViewName("community/product/index");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/clubProductAction.do")
	 * 동아리 커뮤니티
	 * 동아리 - 물품목록 (동작)
	 * 권한 - 총무 이상 이용 가능
	 * @RequestParam club_id, product_nm, tot_cnt, product_cont
	*/
	@RequestMapping(value="/clubProductAction.do")
	public ModelAndView clubProductAction(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "product_nm", required = false) String[] product_nm,
							 @RequestParam(value = "tot_cnt", required = false) String[] tot_cnt,
							 @RequestParam(value = "product_cont", required = false) String[] product_cont,
							 @RequestParam(value = "seq_no", required = false) String[] seq_no) {
	
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		
		System.err.println("[clubProductAction.do] club_id: " + club_id);
		System.err.println("[clubProductAction.do] product_nm: " +product_nm);
		System.err.println("[clubProductAction.do] tot_cnt: " + tot_cnt);
		System.err.println("[clubProductAction.do] product_cont: " + product_cont);
		

		if (staff_cd.equals("004004")) {
			CommonUtils.showAlert(response, "총무 이상의 권한이 필요합니다.", "clubIntro.do?club_id="+club_id);
			return null;
		}
//		try {
			if(product_nm == null) {
				Map<String, Object> productParams = new HashMap<String, Object>();
				productParams.put("club_id", club_id);
				productService.deleteProduct(productParams);
			} 
			
			else {
				ArrayList<ProductVO> list = new ArrayList<ProductVO>();
				for(int i =0 ; i < product_nm.length; i++) {
					if (!(product_nm[i].equals("") || tot_cnt[i].equals("") || product_cont[i].equals(""))) {
						ProductVO productVO = new ProductVO();
						productVO.setProductNM(product_nm[i]);
						productVO.setProductCont(product_cont[i]);
						productVO.setTotCnt(Integer.parseInt(tot_cnt[i]));
						list.add(productVO);
					}
				}
				Map<String, Object> productParams = new HashMap<String, Object>();
				productParams.put("club_id", club_id);
				productService.deleteProduct(productParams);
				
				for(int i = 0; i<list.size(); i++) {
					productParams.put("club_id", club_id);
					productParams.put("seq_no", i);
					productParams.put("product_nm", list.get(i).getProductNM());
					productParams.put("product_cont", list.get(i).getProductCont());
					productParams.put("tot_cnt", list.get(i).getTotCnt());
					System.err.println("[clubProductAction.do] club_id: " + club_id);
					System.err.println("[clubProductAction.do] product_nm: " + list.get(i).getProductNM());
					System.err.println("[clubProductAction.do] tot_cnt: " + list.get(i).getTotCnt());
					System.err.println("[clubProductAction.do] product_cont: " + list.get(i).getProductCont());
					productService.insertProduct(productParams);
				}
				
			}
			CommonUtils.showAlert(response, "저장이 완료됬습니다.", "/clubProduct.do?club_id="+club_id);
			return null;
//		} catch(Exception e) {
//			CommonUtils.showAlert(response, "저장 실패.", "/clubProduct.do?club_id="+club_id);
//			System.out.println("[clubProductAction] err: " + e.getMessage());
//			return null;
//		}
		
		
	}
	
	/*
	 * @RequestMapping(value="/clubBudget.do")
	 * 동아리 커뮤니티
	 * 동아리 - 예산 
	 * 권한 - 총무 이상 이용 가능
	 * @RequestParam club_id, io_gb_cd
	*/
	@RequestMapping(value="/clubBudget.do")
 	public ModelAndView clubBudget(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "year", required = false, defaultValue ="") String year,
							 @RequestParam(value = "month", required = false, defaultValue ="") String month,
							 @RequestParam(value = "io_gb_cd", required = false, defaultValue ="009001") String io_gb_cd)
	{
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		/* 클럽 정보 */
		Map<String, Object> clubParams = new HashMap<String, Object>();
		if(club_id == null)
			club_id = (String) session.getAttribute("club_id");
		session.setAttribute("club_id", club_id);
		clubParams.put("club_id", club_id);
		ClubVO clubVO = clubService.getClub(clubParams);

		if (clubVO == null) {
    		try {
    			throw new ClubNotExistException("존재 하지 않는 동아리 입니다.");
    		} catch (ClubNotExistException e) {
    			CommonUtils.showAlert(response, "존재 하지 않는 동아리 입니다.", "/index.do");
    			return null;
    		}
    	}
		
		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}
		
		boolean isStaff = false;
		if(staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;
 
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		params.put("io_gb_cd", "009001");
		params.put("opt", 0);
		List<BudgetVO> incomeList = budgetService.getBudget(params);
		int incomeTotalPrice = budgetService.getTotal(params);
		
		params.put("io_gb_cd", "009002");
		List<BudgetVO> expenseList = budgetService.getBudget(params);
		int expenseTotalPrice = budgetService.getTotal(params);
		System.err.println("[clubBudget.do] io_gb_cd: " + io_gb_cd);
		
		if(year.equals("0"))
			year="";
		if(month.equals("0"))
			month="";
		String use_dt = year + month;
		
		Map<String, Object> incomeParams = new HashMap<String, Object>();
		incomeParams.put("club_id", club_id);
		incomeParams.put("io_gb_cd", "009001");
		incomeParams.put("opt", 1);
		incomeParams.put("use_dt", use_dt);
		
		List<BudgetVO> incomeList2 = budgetService.getBudget(incomeParams);
		int incomeTotalPrice2 = budgetService.getTotal(incomeParams);
		
		Map<String, Object> expenseParams = new HashMap<String, Object>();
		expenseParams.put("club_id", club_id);
		expenseParams.put("io_gb_cd", "009002");
		expenseParams.put("opt", 1);
		expenseParams.put("use_dt", use_dt);
		
		List<BudgetVO> expenseList2 = budgetService.getBudget(expenseParams);
		int expenseTotalPrice2 = budgetService.getTotal(expenseParams);

		DecimalFormat format = new DecimalFormat("###,###");
		for(BudgetVO budgetVO : incomeList) {
			SimpleDateFormat newFormat = new SimpleDateFormat("yyyy.MM.dd"); // String 타입을 Date 타입으로 변환
			SimpleDateFormat oldFormat = new SimpleDateFormat("yyyyMMdd");
	       	Date oldDate;
	       	try {
	       		oldDate = oldFormat.parse(budgetVO.getUse_dt());
	       		budgetVO.setUse_dt(newFormat.format(oldDate));
	       	} catch (Exception e) {
	       		continue;
			}
		}
		
		for (BudgetVO budgetVO : expenseList) {
			SimpleDateFormat newFormat = new SimpleDateFormat("yyyy.MM.dd"); // String 타입을 Date 타입으로 변환
			SimpleDateFormat oldFormat = new SimpleDateFormat("yyyyMMdd");
	       	Date oldDate;
	       	try {
	       		oldDate = oldFormat.parse(budgetVO.getUse_dt());
	       		budgetVO.setUse_dt(newFormat.format(oldDate));
	       	} catch (Exception e) {
	       		continue;
			}
		}
		for (BudgetVO budgetVO : incomeList2) {
			budgetVO.setStr_price(format.format(budgetVO.getPrice()));
			SimpleDateFormat newFormat = new SimpleDateFormat("yyyy.MM.dd"); // String 타입을 Date 타입으로 변환
			SimpleDateFormat oldFormat = new SimpleDateFormat("yyyyMMdd");
	       	Date oldDate;
	       	try {
	       		oldDate = oldFormat.parse(budgetVO.getUse_dt());
	       		budgetVO.setUse_dt(newFormat.format(oldDate));
	       	} catch (Exception e) {
	       		continue;
			}
		}
		for (BudgetVO budgetVO : expenseList2) {
			budgetVO.setStr_price(format.format(budgetVO.getPrice()));
			SimpleDateFormat newFormat = new SimpleDateFormat("yyyy.MM.dd"); // String 타입을 Date 타입으로 변환
			SimpleDateFormat oldFormat = new SimpleDateFormat("yyyyMMdd");
	       	Date oldDate;
	       	try {
	       		oldDate = oldFormat.parse(budgetVO.getUse_dt());
	       		budgetVO.setUse_dt(newFormat.format(oldDate));
	       	} catch (Exception e) {
	       		continue;
			}
		}

		System.err.println("[clubBudget.do] incomeTotalPrice: " + incomeTotalPrice);
		System.err.println("[clubBudget.do] incomeTotalPrice2: " + incomeTotalPrice2);
		System.err.println("[clubBudget.do] expenseTotalPrice2: " + expenseTotalPrice2);
		/* clubBudget */
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("io_gb_cd", io_gb_cd);
		mav.addObject("isStaff", isStaff);
		
		mav.addObject("incomeList", incomeList);
		mav.addObject("incomeTotalPrice",format.format(incomeTotalPrice));
		mav.addObject("expenseList", expenseList);
		mav.addObject("expenseTotalPrice", format.format(expenseTotalPrice));
		
		mav.addObject("incomeList2", incomeList2);
		mav.addObject("incomeTotalPrice2", format.format(incomeTotalPrice2));
		mav.addObject("expenseList2", expenseList2);
		mav.addObject("expenseTotalPrice2", format.format(expenseTotalPrice2));
//		Integer.parseInt(incomeTotalPrice2) - Integer.parseInt(expenseTotalPrice2)
		mav.addObject("totalPrice", format.format(incomeTotalPrice2 - expenseTotalPrice2));
		mav.setViewName("community/budget/index");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/clubBudgetAction.do")
	 * 동아리 커뮤니티
	 * 동아리 - 예산 
	 * 권한 - 총무 이상 이용 가능
	 * @RequestParam club_id, io_gb_cd, use_dt, contents, price
	*/
	@RequestMapping(value="/clubBudgetAction.do")
 	public ModelAndView clubBudgetAction(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "io_gb_cd", required = false) String io_gb_cd,
							 @RequestParam(value = "income_use_dt", required = false ) String[] income_use_dt,
							 @RequestParam(value = "income_contents", required = false) String[] income_contents,
							 @RequestParam(value = "income_price", required = false) String[] income_price,
							 @RequestParam(value = "expense_use_dt", required = false ) String[] expense_use_dt,
							 @RequestParam(value = "expense_contents", required = false) String[] expense_contents,
							 @RequestParam(value = "expense_price", required = false) String[] expense_price)
	{
		System.err.println("[clubBudgetAction.do] io_gb_cd: " + io_gb_cd);

//		

		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		if (staff_cd.equals("004004")) {
			CommonUtils.showAlert(response, "총무 이상의 권한이 필요합니다.", "clubIntro.do?club_id="+club_id);
			return null;
		}
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		params.put("io_gb_cd", "009001");
		
		try {
			System.err.println("[income_price.length]: income_price.length" + income_price.length);
			budgetService.deleteBudget(params);
		
			for (int i = 0; i < income_price.length; i++) {
				BudgetVO vo = new BudgetVO();
				if (income_use_dt[i] == "" || income_use_dt[i] == null)
					break;

				vo.setUse_dt(income_use_dt[i]);
				if (income_price[i] == null || income_price[i].trim().equals("")) {
					break;
				}
				vo.setPrice(Integer.parseInt(income_price[i]));
				vo.setContents(income_contents[i]);

				params.put("use_dt", vo.getUse_dt());
				params.put("contents", vo.getContents());
				params.put("price", vo.getPrice());
				budgetService.insertBudget(params);

			}
		} catch (Exception e) {
			System.err.println("[income_price.length]: err" );
		}
		try {
			params.put("io_gb_cd", "009002");
			System.err.println("[expense_price]: " + expense_price);
			System.err.println("[expense_price.length]: " + expense_price.length);
			budgetService.deleteBudget(params);
			for (int i = 0; i < expense_price.length; i++) {
				BudgetVO vo = new BudgetVO();
				if (expense_use_dt[i] == "" || expense_use_dt[i] == null)
					break;
	
				vo.setUse_dt(expense_use_dt[i]);
				if (expense_price[i] == null || expense_price[i].trim().equals("")) {
					break;
				}
				vo.setPrice(Integer.parseInt(expense_price[i]));
				vo.setContents(expense_contents[i]);
	
				params.put("use_dt", vo.getUse_dt());
				params.put("contents", vo.getContents());
				params.put("price", vo.getPrice());
				budgetService.insertBudget(params);
			}
			CommonUtils.showAlert(response, "정상적으로 저장되었습니다.", "/clubBudget.do?club_id=" + club_id);
			return null;
		} catch (Exception e) {
			System.err.println("[clubBudgetAction.do] SAVE ERROR: " + e.getMessage());
			CommonUtils.showAlert(response, "정상적으로 저장했습니다.", "/clubBudget.do?club_id=" + club_id);
			return null;
		}
	}
	
	/*
	 * @RequestMapping(value="/clubBudgetTotal.do")
	 * 동아리 커뮤니티
	 * 동아리 - 예산
	 * @RequestParam club_id, io_gb_cd, year, month
	*/
	@SuppressWarnings("static-access")
	@RequestMapping(value="/clubBudgetTotal.do")
 	public ModelAndView clubBudgetTotal(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "io_gb_cd", required = false, defaultValue ="009001") String io_gb_cd,
    						 @RequestParam(value = "year", required = false, defaultValue="-1") int year,
							 @RequestParam(value = "month", required = false, defaultValue="-1") int month)
	{
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		Calendar cal = Calendar.getInstance();
		if(year == -1)
			year = cal.get(cal.YEAR);
		if(month == -1)
			month = cal.get(cal.MONTH) + 1;
		String use_dt = "";
		
		if (year == 0)
			use_dt = use_dt + "____";
		else
			use_dt = use_dt + year;

		if (month == 0)
			use_dt = use_dt + "%";
		else {
			if (month < 10)
				use_dt = use_dt + "0" + month + '%';
			else
				use_dt = use_dt + month + "%";
		}

		/* 클럽 정보 */
		Map<String, Object> clubParams = new HashMap<String, Object>();
		clubParams.put("club_id", club_id);
		ClubVO clubVO = clubService.getClub(clubParams);

		if (clubVO == null) {
    		try {
    			throw new ClubNotExistException("존재 하지 않는 동아리 입니다.");
    		} catch (ClubNotExistException e) {
    			CommonUtils.showAlert(response, "존재 하지 않는 동아리 입니다.", "/index.do");
    			return null;
    		}
    	}
		
		/* 클럽 회장 */
		Map<String, Object> presidentParams = new HashMap<String, Object>();
		presidentParams.put("club_id", club_id);
		clubVO.setPresident(clubMemberService.getClubPresident(presidentParams).getName());
		
		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}
		
		boolean isStaff = false;
		if(staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;
		System.err.println("[clubBudgetTotal.do] Intro_save_file: " + clubVO.getIntro_save_file_nm());
		System.err.println("[clubBudgetTotal.do] poster_save_file: " + clubVO.getPoster_save_file_nm());
		System.err.println("[clubBudgetTotal.do] staff_cd: " + staff_cd);
		System.err.println("[clubBudgetTotal.do] isStaff: " + isStaff);
		
		Map<String, Object> incomeParams = new HashMap<String, Object>();
		incomeParams.put("club_id", club_id);
		incomeParams.put("io_gb_cd", "009001");
		incomeParams.put("opt", 1);
		incomeParams.put("use_dt", use_dt);
		
		List<BudgetVO> incomeList = budgetService.getBudget(incomeParams);
		int incomeTotalPrice = budgetService.getTotal(incomeParams);
		
		Map<String, Object> expenseParams = new HashMap<String, Object>();
		expenseParams.put("club_id", club_id);
		expenseParams.put("io_gb_cd", "009002");
		expenseParams.put("opt", 1);
		expenseParams.put("use_dt", use_dt);
		
		List<BudgetVO> expenseList = budgetService.getBudget(expenseParams);
		int expenseTotalPrice = budgetService.getTotal(expenseParams);
		
		/* clubPlatform */
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("open_dt", clubVO.getOpen_dt());
		mav.addObject("president_nm", clubVO.getPresident());
		mav.addObject("isStaff", isStaff);
		mav.addObject("club_intro", clubVO.getIntro_save_file_nm());
		mav.addObject("club_poster", clubVO.getPoster_save_file_nm());
		
		/* clubBudgetTotal */
		session.setAttribute("incomeList", incomeList);
		session.setAttribute("incomeTotalPrice", incomeTotalPrice);
		
		session.setAttribute("expenseList", expenseList);
		session.setAttribute("expenseTotalPrice", expenseTotalPrice);
//		mav.addObject("incomeList", incomeList);
//		mav.addObject("incomeTotalPrice", incomeTotalPrice);
//		mav.addObject("expenseList", expenseList);
//		mav.addObject("expenseTotalPrice", expenseTotalPrice);
		mav.setViewName("club/clubBudgetTotal");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/clubMemberList.do")
	 * 동아리 커뮤니티
	 * 동아리 - 회원목록
	 * @RequestParam club_id, category, search, page(pageNumber)
	*/
	@RequestMapping(value="/clubMemberList.do")
	public ModelAndView clubMemberList(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "select", required = false, defaultValue ="1") String select,
							 @RequestParam(value = "cdn", required = false, defaultValue ="") String cdn,
							 @RequestParam(value = "page", required = false, defaultValue = "1") String pageNumber){
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		session.setAttribute("club_id", club_id);
		Map<String, Object> clubParams = new HashMap<String, Object>();
		clubParams.put("club_id", club_id);
		ClubVO clubVO = clubService.getClub(clubParams);
		
		if (clubVO == null) {
    		try {
    			throw new ClubNotExistException("존재 하지 않는 동아리 입니다.");
    		} catch (ClubNotExistException e) {
    			CommonUtils.showAlert(response, "존재 하지 않는 동아리 입니다.", "/index.do");
    			return null;
    		}
    	}
		
		Map<String, Object> presidentParams = new HashMap<String, Object>();
		presidentParams.put("club_id", club_id);
		clubVO.setPresident(clubMemberService.getClubPresident(presidentParams).getName());
		
		Map<String, Object> memberParams = new HashMap<String, Object>();
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		boolean isStaff = false;
		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}
		
		if(staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;
	
		System.err.println("[clubMemberList.do] Intro_save_file: " + clubVO.getIntro_save_file_nm());
		System.err.println("[clubMemberList.do] poster_save_file: " + clubVO.getPoster_save_file_nm());
		System.err.println("[clubMemberList.do] staff_cd: " + staff_cd);
		System.err.println("[clubMemberList.do] isStaff: " + isStaff);
		
//		Map<String, Object> membersParams = new HashMap<String, Object>();
//		membersParams.put("club_id", club_id);
//		membersParams.put("join_cd", "008001");
		
		List<ClubMemberVO> clubMemberList = null;
		int memberListCount = 1;
		int limit = 7;
		int currPage = Integer.parseInt(pageNumber);
		currPage = (currPage < 1)?1:currPage;
		int prevPage = 1;
		int nextPage = 1;
		int totalPage = 1;
		int startNum = 1; // 범위 시작
		int endNum = 1; // 범위 끝	
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		params.put("join_cd", "008001");
		params.put("select", select);
		params.put("cdn", cdn);
		params.put("limit", limit);
		System.err.println("[clubMemberList.do] search: " + cdn);
		
		memberListCount = clubMemberService.getMemberListCnt(params); 
		totalPage = clubMemberService.getTotalPageCnt(params); 
		
		/* 페이지 번호에 따른 가져올 게시글 범위 */
		if(totalPage <= 1) {
			startNum = 1;
			endNum = (memberListCount < limit) ? memberListCount:limit;
			currPage = 1;
			prevPage = currPage;
			nextPage = currPage;
		} else {
			startNum = (currPage * limit) - limit + 1;
			endNum = currPage * limit;
			prevPage = currPage - 1;
			prevPage = (prevPage < 1) ? 1: prevPage;
			nextPage = (memberListCount > endNum) ? (currPage+1):currPage;
		}
		
		params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		params.put("join_cd", "008001");
		params.put("select", select);
		params.put("cdn", cdn);
		params.put("startNum", startNum);
		params.put("endNum", endNum);			
		
		clubMemberList = clubMemberService.getClubMemberList(params);	
		for (ClubMemberVO clubMemberVO : clubMemberList)
		{
			if (clubMemberVO.getStaff_cd().equals("004004"))
				clubMemberVO.setStaff_cd("회원");
			else if (clubMemberVO.getStaff_cd().equals("004003"))
				clubMemberVO.setStaff_cd("총무");
			else if (clubMemberVO.getStaff_cd().equals("004002"))
				clubMemberVO.setStaff_cd("부회장");
			else if (clubMemberVO.getStaff_cd().equals("004001"))
				clubMemberVO.setStaff_cd("회장");
		}
		System.err.println("[clubMemberList.do] clubList: \n" + clubMemberList);
		System.err.println("[clubMemberList.do] clubListCount: " + memberListCount);
		System.err.println("[clubMemberList.do] totalPage: " + totalPage);
		
		/* clubPlatform */
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("open_dt", clubVO.getOpen_dt());
		mav.addObject("president_nm", clubVO.getPresident());
		mav.addObject("isStaff", isStaff);
		mav.addObject("club_intro", clubVO.getIntro_save_file_nm());
		mav.addObject("club_poster", clubVO.getPoster_save_file_nm());
		

		/*  clubMemberList */
		mav.addObject("cdn", cdn);
		mav.addObject("select", select);
		mav.addObject("totalPage", totalPage);
		mav.addObject("prevPage", prevPage);
		mav.addObject("currPage", currPage);
		mav.addObject("nextPage", nextPage);
		mav.addObject("memberList", clubMemberList);
		mav.addObject("memberListCount", memberListCount);

		mav.addObject("memberList", clubMemberList);
//		mav.setViewName("club/clubMemberList");
		mav.setViewName("community/memberList/index");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/clubBoardList.do")
	 * 동아리 커뮤니티
	 * 게시판 - 리스트
	 * @RequestParam club_id, board_cd(bdc), page, cdn
	*/
	@RequestMapping(value="/clubBoardList.do")
	public ModelAndView clubBoardList(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false) String club_id,
							 @RequestParam(value = "board_cd", required = false) String bdc,
							 @RequestParam(value = "page", required = false, defaultValue = "1") String page,
							 @RequestParam(value = "opt", required = false, defaultValue = "0") String opt,
							 @RequestParam(value = "cdn", required = false, defaultValue = "") String cdn) {
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		if(club_id == null)
			club_id = (String) session.getAttribute("club_id");
		session.setAttribute("club_id", club_id);
		
		/* 클럽 정보 */
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		ClubVO clubVO = clubService.getClub(params);

		if (clubVO == null) {
    		try {
    			throw new ClubNotExistException("존재 하지 않는 동아리 입니다.");
    		} catch (ClubNotExistException e) {
    			CommonUtils.showAlert(response, "존재 하지 않는 동아리 입니다.", "/index.do");
    			return null;
    		}
    	}
		
		/* 클럽 회장 */
		clubVO.setPresident(clubMemberService.getClubPresident(params).getName());
		
		/* 사용자 권한 */
		params.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(params);

		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}
		
		boolean isStaff = false;
		if(staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;
		System.err.println("[clubBoardList.do] Intro_save_file: " + clubVO.getIntro_save_file_nm());
		System.err.println("[clubBoardList.do] poster_save_file: " + clubVO.getPoster_save_file_nm());
		System.err.println("[clubBoardList.do] staff_cd: " + staff_cd);
		System.err.println("[clubBoardList.do] isStaff: " + isStaff);
		
		/* 게시판  */
		List<BoardVO> boardList = null;
		ArrayList<UserVO> writerList = new ArrayList<UserVO>();
		ArrayList<String> writerAuthList = new ArrayList<String>();
		ArrayList<FileVO> thumbnailList = new ArrayList<FileVO>();
		
		int available = 1;
		String board_cd = null;
		String headTitle = null;

		System.err.println("[clubBoardList.do] club_id: " + club_id);
		System.err.println("[clubBoardList.do] bdc: " + bdc);
		
		if(bdc != null) {
			session.setAttribute("board_cd", bdc);
		}
		
		board_cd = (String) session.getAttribute("board_cd");

		if(board_cd.equals("007001"))
			headTitle = "공지사항";
		else if(board_cd.equals("007002"))
			headTitle = "자유게시판";
		else if(board_cd.equals("007003"))
			headTitle = "갤러리";
		else if(board_cd.equals("007004"))
			headTitle = "일정";
		else
			headTitle = "ERROR";
		
		String condition = cdn; // cdn
		
		int boardListCount = 1;
		int limit = 6;
		int currPage = Integer.parseInt(page);
		currPage = (currPage < 1)?1:currPage;
		int prevPage = 1;
		int nextPage = 1;
		int totalPage = 1;
		int startNum = 1; // 범위 시작
		int endNum = 1; // 범위 끝	
		
		params.put("available", available);
		params.put("board_cd", board_cd);
		params.put("opt", Integer.parseInt(opt));
		params.put("limit", limit);
		params.put("cdn", cdn);
		
		boardListCount = boardService.getBoardListCnt(params);
		totalPage = boardService.getTotalPageCnt(params); 
		
		/* 페이지 번호에 따른 가져올 게시글 범위 */
		if(totalPage <= 1) {
			startNum = 1;
			endNum = (boardListCount < limit) ? boardListCount:limit;
			currPage = 1;
			prevPage = currPage;
			nextPage = currPage;
		} else {
			startNum = (currPage * limit) - limit + 1;
			endNum = currPage * limit;
			prevPage = currPage - 1;
			prevPage = (prevPage < 1) ? 1: prevPage;
			nextPage = (boardListCount > endNum) ? (currPage+1):currPage;
		}
		
		params.put("startNum", startNum);
		params.put("endNum", endNum);
		boardList = boardService.getBoardList(params);
		System.err.println();
		for(BoardVO v : boardList) {
			Map<String, Object> params2 = new HashMap<String, Object>();
			params2.put("ID", v.getInput_id());
			UserVO writer = userService.getUserVO(params2);
			writerList.add(writer);
			writerAuthList.add(commonService.checkAuth(params2));
			v.setInput_id(writer.getName());
			
			if(board_cd.equals("007003")) {
				Map<String, Object> paramsF = new HashMap<String, Object>();
				paramsF.put("club_id", club_id);
				paramsF.put("board_cd", board_cd);
				paramsF.put("board_no", v.getBoard_no());
				paramsF.put("opt", 2);
				
				FileVO thumbnailFile = null; 
				int fileListCnt = fileService.getFileListCnt(paramsF);
				if(fileListCnt > 0) {
					List<FileVO> fileList = fileService.getFileList(paramsF);
					
					for(FileVO f : fileList) {
						if(f.getFile_save_nm().contains("thumbnail") && f.getFile_path().contains("thumbnail")) {
							thumbnailFile = f;
							break;
						}
					}
				}
				thumbnailList.add(thumbnailFile);
				mav.addObject("thumbnailList", thumbnailList);
			}
		}
		
		System.err.println("[clubBoardList.do] cdn: " + cdn);
		System.err.println("[clubBoardList.do] boardList: " + boardList);
		
		/* clubPlatform */
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("open_dt", clubVO.getOpen_dt());
		mav.addObject("president_nm", clubVO.getPresident());
		mav.addObject("isStaff", isStaff);
		mav.addObject("club_intro", clubVO.getIntro_save_file_nm());
		mav.addObject("club_poster", clubVO.getPoster_save_file_nm());
		
		/* clubBoard */
		mav.addObject("headTitle", headTitle);
		mav.addObject("board_cd", board_cd);
		mav.addObject("condition", condition);
		mav.addObject("opt", opt);
		mav.addObject("totalPage", totalPage);
		mav.addObject("prevPage", prevPage);
		mav.addObject("currPage", currPage);
		mav.addObject("nextPage", nextPage);
		mav.addObject("writerList", writerList);
		mav.addObject("writerAuthList", writerAuthList);
		mav.addObject("clubBoardList", boardList);
		mav.addObject("boardListCount", boardListCount);
		
//		mav.setViewName("club/clubBoard");
		mav.setViewName("community/board/index");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/clubBoardReadForm.do")
	 * 동아리 커뮤니티
	 * 게시판 - 읽기 폼
	 * @RequestParam club_id, board_cd, board_no
	*/
	@RequestMapping(value = "/clubBoardReadForm.do")
	public ModelAndView clubBoardReadForm(ModelAndView mav,
									  HttpServletRequest request, HttpServletResponse response,
									  @RequestParam(value = "club_id", required = false) String club_id,
									  @RequestParam(value = "board_cd", required = false) String board_cd,
									  @RequestParam(value = "board_no", required = false, defaultValue = "1") int board_no)
	{
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");

		String headTitle = null;
		if(club_id != null)
			session.setAttribute("club_id", club_id);
		club_id = (String) session.getAttribute("club_id");
		
		if(board_cd != null)
			session.setAttribute("board_cd", board_cd);
		board_cd = (String) session.getAttribute("board_cd");

		session.setAttribute("board_no", board_no);
		board_no = (int) session.getAttribute("board_no");
		
		if(board_cd.equals("007001"))
			headTitle = "공지사항";
		else if(board_cd.equals("007002"))
			headTitle = "자유게시판";
		else if(board_cd.equals("007003"))
			headTitle = "갤러리";
		else if(board_cd.equals("007004"))
			headTitle = "일정";
		else
			headTitle = "ERROR";

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("board_cd", board_cd);
		params.put("board_no", board_no);
		params.put("club_id", club_id);
		boardService.increaseOpenCnt(params);
		BoardVO searchBoard = boardService.getBoard(params);

		Map<String, Object> params2 = new HashMap<String, Object>();
		params2.put("ID", searchBoard.getInput_id());
		UserVO writer = userService.getUserVO(params2);
		if(searchBoard.getUpdate_id() != null) {
			params2.replace("ID", searchBoard.getUpdate_id());
			UserVO editor = userService.getUserVO(params2);
			mav.addObject("editorName", editor.getName());
		}
		
		/* 클럽 정보 */
		Map<String, Object> clubParams = new HashMap<String, Object>();
		clubParams.put("club_id", club_id);
		ClubVO clubVO = clubService.getClub(clubParams);

		if (clubVO == null) {
    		try {
    			throw new ClubNotExistException("존재 하지 않는 동아리 입니다.");
    		} catch (ClubNotExistException e) {
    			CommonUtils.showAlert(response, "존재 하지 않는 동아리 입니다.", "/index.do");
    			return null;
    		}
    	}
		
		/* 클럽 회장 */
		Map<String, Object> presidentParams = new HashMap<String, Object>();
		presidentParams.put("club_id", club_id);
		clubVO.setPresident(clubMemberService.getClubPresident(presidentParams).getName());

		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}

		boolean isStaff = false;
		if (staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;

		boolean isMyWrite = false;
		if (userVO.getId().equals(searchBoard.getInput_id()) || userVO.getId().equals(searchBoard.getUpdate_id()))
			isMyWrite = true;

		System.err.println("[clubBoardReadForm.do] Intro_save_file: " + clubVO.getIntro_save_file_nm());
		System.err.println("[clubBoardReadForm.do] poster_save_file: " + clubVO.getPoster_save_file_nm());
		System.err.println("[clubBoardReadForm.do] staff_cd: " + staff_cd);
		System.err.println("[clubBoardReadForm.do] isStaff: " + isStaff);
		System.err.println("[clubBoardReadForm.do] isMyWrite: " + isMyWrite);

		params.replace("board_no", board_no - 1);
		BoardVO prevBoard = boardService.getBoard(params);

		params.replace("board_no", board_no + 1);
		BoardVO nextBoard = boardService.getBoard(params);
		
		/* file x */
		params.put("club_id", club_id);
		params.put("board_no", board_no);
		params.put("opt", 2);
		List<FileVO> originalFileList = null;
		List<FileVO> fileList = new ArrayList<FileVO>();
		FileVO thumbnailFile = null;
		boolean hasThumbnail = false;
		int fileListCnt = fileService.getFileListCnt(params);
		
		if(fileListCnt > 0) {
			originalFileList = fileService.getFileList(params);
			
			for(FileVO v : originalFileList) {
				if(v.getFile_save_nm().contains("thumbnail") && v.getFile_path().contains("thumbnail")) {
					thumbnailFile = v;
					hasThumbnail = true;
				} else {
					fileList.add(v);
				}
			}
		}
		
		/* boardRead */
		/* clubPlatform */
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("headTitle", headTitle);
		mav.addObject("open_dt", clubVO.getOpen_dt());
		mav.addObject("president_nm", clubVO.getPresident());
		mav.addObject("club_intro", clubVO.getIntro_save_file_nm());
		mav.addObject("club_poster", clubVO.getPoster_save_file_nm());

		/* clubBoardReadForm */
		mav.addObject("hasThumbnail", hasThumbnail);
		mav.addObject("thumbnailFile", thumbnailFile);
		mav.addObject("fileList", fileList);
		mav.addObject("fileListCnt", (hasThumbnail)?fileListCnt-1:fileListCnt);
		mav.addObject("searchBoard", searchBoard);
		mav.addObject("start_date", searchBoard.getStart_date());
		mav.addObject("end_date", searchBoard.getEnd_date());
		mav.addObject("prevBoard", prevBoard);
		mav.addObject("nextBoard", nextBoard);
		mav.addObject("club_id", club_id);
		mav.addObject("board_cd", board_cd);
		mav.addObject("writerName", writer.getName());
		mav.addObject("isMyWrite", isMyWrite);
		mav.addObject("isStaff", isStaff);

//		mav.setViewName("club/clubBoardReadForm");
		mav.setViewName("community/board/ReadForm");
		return mav;
	}

	/*
	 * @RequestMapping(value="/clubCalendar.do")
	 * 동아리 커뮤니티
	 * 게시판 - 일정
	 * @RequestParam club_id, board_cd
	*/
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/clubCalendar.do")
	public ModelAndView clubCalendar(ModelAndView mav,
									  HttpServletRequest request, HttpServletResponse response,
									  @RequestParam(value = "club_id", required = false) String club_id,
									  @RequestParam(value = "board_cd", required = false) String board_cd)
	{
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		String headTitle = null;
		String jsonInfo = null;
		JSONArray personArray = new JSONArray();
		JSONObject personInfo = new JSONObject();
		
		if(club_id != null)
			session.setAttribute("club_id", club_id);
		club_id = (String) session.getAttribute("club_id");
		
		if(board_cd != null)
			session.setAttribute("board_cd", board_cd);
		board_cd = (String) session.getAttribute("board_cd");
		
		if(board_cd.equals("007001"))
			headTitle = "공지사항";
		else if(board_cd.equals("007002"))
			headTitle = "자유게시판";
		else if(board_cd.equals("007003"))
			headTitle = "갤러리";
		else if(board_cd.equals("007004"))
			headTitle = "일정";
		else
			headTitle = "ERROR";
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		List<BoardVO> boardList = boardService.getCalendar(params);

		for (BoardVO boardVO : boardList) {
			personInfo = new JSONObject();
			personInfo.put("title", boardVO.getTitle());
			personInfo.put("start", boardVO.getStart_date().substring(0, 10));
			personInfo.put("end", boardVO.getEnd_date().substring(0, 10) + " 04:00");
			personInfo.put("url", "clubBoardReadForm.do?board_no=" + boardVO.getBoard_no() + "&club_id=" + club_id
					+ "&board_cd=007004");
			personArray.add(personInfo);
		}
		jsonInfo = personArray.toJSONString();
		session.setAttribute("jsonInfo", jsonInfo);

		/* 클럽 정보 */
		Map<String, Object> clubParams = new HashMap<String, Object>();
		clubParams.put("club_id", club_id);
		ClubVO clubVO = clubService.getClub(clubParams);

		if (clubVO == null) {
    		try {
    			throw new ClubNotExistException("존재 하지 않는 동아리 입니다.");
    		} catch (ClubNotExistException e) {
    			CommonUtils.showAlert(response, "존재 하지 않는 동아리 입니다.", "/index.do");
    			return null;
    		}
    	}
		
		/* 클럽 회장 */
		Map<String, Object> presidentParams = new HashMap<String, Object>();
		presidentParams.put("club_id", club_id);
		clubVO.setPresident(clubMemberService.getClubPresident(presidentParams).getName());

		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}

		boolean isStaff = false;
		if (staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;

		System.err.println("[clubCalendar.do] Intro_save_file: " + clubVO.getIntro_save_file_nm());
		System.err.println("[clubCalendar.do] poster_save_file: " + clubVO.getPoster_save_file_nm());
		System.err.println("[clubCalendar.do] staff_cd: " + staff_cd);
		System.err.println("[clubCalendar.do] isStaff: " + isStaff);

		/* boardRead */
		/* clubPlatform */
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("open_dt", clubVO.getOpen_dt());
		mav.addObject("president_nm", clubVO.getPresident());
		mav.addObject("isStaff", isStaff);
		mav.addObject("club_intro", clubVO.getIntro_save_file_nm());
		mav.addObject("club_poster", clubVO.getPoster_save_file_nm());

		/* clubBoardReadForm */
		mav.addObject("calendar", jsonInfo);
		mav.addObject("club_id", club_id);
		mav.addObject("board_cd", board_cd);
		mav.addObject("headTitle", headTitle);
		
//		mav.setViewName("club/clubCalendar");
		mav.setViewName("community/board/index");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/clubBoardWriteForm.do")
	 * 동아리 커뮤니티
	 * 게시판 - 작성 폼
	 * 권한 - 임원 이상만 공지사항, 일정 게시판 등록 가능
	 * @RequestParam club_id, board_cd(bdc)
	*/
	@RequestMapping(value="/clubBoardWriteForm.do")
	public ModelAndView clubBoardWriteForm(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false) String club_id,
							 @RequestParam(value = "board_cd", required = false) String board_cd) {
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		String headTitle = null;
		if(club_id != null)
			session.setAttribute("club_id", club_id);
		club_id = (String) session.getAttribute("club_id");
		
		if(board_cd != null)
			session.setAttribute("board_cd", board_cd);
		board_cd = (String) session.getAttribute("board_cd");
		
		if(board_cd.equals("007001"))
			headTitle = "공지사항";
		else if(board_cd.equals("007002"))
			headTitle = "자유게시판";
		else if(board_cd.equals("007003"))
			headTitle = "갤러리";
		else if(board_cd.equals("007004"))
			headTitle = "일정";
		else
			headTitle = "ERROR";
		
		/* 클럽 정보 */
		Map<String, Object> clubParams = new HashMap<String, Object>();
		clubParams.put("club_id", club_id);
		ClubVO clubVO = clubService.getClub(clubParams);

		if (clubVO == null) {
    		try {
    			throw new ClubNotExistException("존재 하지 않는 동아리 입니다.");
    		} catch (ClubNotExistException e) {
    			CommonUtils.showAlert(response, "존재 하지 않는 동아리 입니다.", "/index.do");
    			return null;
    		}
    	}
		
		/* 클럽 회장 */
		Map<String, Object> presidentParams = new HashMap<String, Object>();
		presidentParams.put("club_id", club_id);
		clubVO.setPresident(clubMemberService.getClubPresident(presidentParams).getName());
		
		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}
		
		boolean isStaff = false;
		if(staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;
		System.err.println("[clubBoardList.do] Intro_save_file: " + clubVO.getIntro_save_file_nm());
		System.err.println("[clubBoardList.do] poster_save_file: " + clubVO.getPoster_save_file_nm());
		System.err.println("[clubBoardList.do] staff_cd: " + staff_cd);
		System.err.println("[clubBoardList.do] isStaff: " + isStaff);
		
		/* 게시판 작성  */
		/* clubPlatform */
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("open_dt", clubVO.getOpen_dt());
		mav.addObject("president_nm", clubVO.getPresident());
		mav.addObject("isStaff", isStaff);
		mav.addObject("club_intro", clubVO.getIntro_save_file_nm());
		mav.addObject("club_poster", clubVO.getPoster_save_file_nm());
		
		/* clubBoardWriteForm */
		mav.addObject("headTitle", headTitle);
		mav.addObject("board_cd", board_cd);
		mav.addObject("writer", userVO.getId());
		mav.addObject("writerName", userVO.getName());
		
//		mav.setViewName("club/clubBoardWriteForm");
		mav.setViewName("community/board/WriteForm");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/clubBoardWriteAction.do")
	 * 동아리 커뮤니티
	 * 게시판 - 작성 (동작)
	 * 권한 - 임원 이상만 공지사항, 일정 게시판 등록 가능
	 * @RequestParam club_id, title, contents, start_date, 
	 * @RequestParam end_date, writer, board_cd
	*/
	@RequestMapping(value="/clubBoardWriteAction.do")
	public ModelAndView clubBoardWriteAction(MultipartHttpServletRequest request, HttpServletResponse response,
//							MultipartHttpServletRequest mulRequest,
										ModelAndView mav,
										@RequestParam(value = "club_id", required = false) String club_id,
										@RequestParam(value = "title",  required = false) String title,
										@RequestParam(value = "contents", required = false) String contents,
										@RequestParam(value = "start_date", required = false, defaultValue = "") String start_date,
										@RequestParam(value = "end_date", required = false, defaultValue = "") String end_date,
										@RequestParam(value = "fix_yn", required = false, defaultValue = "N") String fix_yn,
										@RequestParam(value = "board_cd", required = false) String board_cd) {
		
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		if(club_id != null)
			session.setAttribute("club_id", club_id);
		club_id = (String) session.getAttribute("club_id");
		
		if(board_cd != null)
			session.setAttribute("board_cd", board_cd);
		board_cd = (String) session.getAttribute("board_cd");
		
		try {
			if(title == null || contents == null) {
	        	CommonUtils.showAlertHistoryBack(response, "필수 입력 항목을 입력해야 합니다.");
	        	return null;
	        }
	        if(title.trim().equalsIgnoreCase("") || contents.trim().equalsIgnoreCase("")) {
	        	CommonUtils.showAlertHistoryBack(response, "필수 입력 항목은 빈칸으로 둘 수 없습니다.");
	        	return null;
	        }
	        
	        /* New */
	        boolean isPhotoBoard = board_cd.equals("007003");
	        List<FileVO> recentFiles = new ArrayList<FileVO>();
	        BoardVO recentBoard = null;
	        // 넘어온 파일을 리스트로 저장
			List<MultipartFile> mpList = request.getFiles("attachFile"); // attachFile로 넘어온 파일을 가져옴
			MultipartFile thumbnailFile = request.getFile("thumbnailFile"); // 썸네일 파일 용
			boolean isExistThumbnail = false;
			if(isPhotoBoard) {
				if(thumbnailFile != null && !thumbnailFile.isEmpty() && !thumbnailFile.getOriginalFilename().equalsIgnoreCase("")) {
					mpList.add(0, thumbnailFile);
					isExistThumbnail = true;
				}
			}
			if(mpList.size() < 1 || mpList.isEmpty()) {
				// 업로드할 파일 없음
			} else {
				int mpIndex = 0;
				for(MultipartFile multipartFile : mpList) {
					if(multipartFile.getOriginalFilename().equalsIgnoreCase("")) {
						continue;
					}
					
					String path = CommonUtils.SAVE_PATH;
					String thumbPrefix = "";
					if(isPhotoBoard && mpIndex == 0 && isExistThumbnail) {
						thumbPrefix = "thumbnail_";
						path = CommonUtils.SAVE_THUMBNAIL_PATH;
					}
					path += CommonUtils.getTimeBasePath();
					
					/* 업로드할 폴더 체크 */
					File dir = new File(path);
			        if (!dir.isDirectory()) { // 폴더가 없다면 생성
			            dir.mkdirs(); // 폴더 생성
			        }
					
	                String genId = CommonUtils.getRandomString(); // 파일명 중복 방지
	                String originalfileName = multipartFile.getOriginalFilename(); // 원본 파일명
	                String saveFileName = thumbPrefix + genId + "." + CommonUtils.getExtension(originalfileName); // 서버에 저장될 파일명
	                String savePath = path + "/" + saveFileName; // 서버에 저장된 파일 경로
	                String hash = CommonUtils.getSHA256(multipartFile.getBytes()); // SHA-256 해쉬 알고리즘
	                multipartFile.transferTo(new File(savePath)); // 서버에 파일 저장
	                
	                /* 무결성 검사 시작 */
	                boolean isIntegrity = false;
	                File up = new File(savePath);
	                if(up.exists()) {
	                	if(CommonUtils.getSHA256(Files.readAllBytes(up.toPath())).equals(hash)) {
	                		isIntegrity = true; // 무결성 확인 완료
	                		if(isPhotoBoard && mpIndex == 0 && isExistThumbnail)
	                			CommonUtils.createThumbnail(path, saveFileName);
	                	} else {
	                		up.delete(); // 손상된 파일 삭제
	                	}
	                }
	                
	            	if(isIntegrity) { // 무결성 체크 완료
		                Map<String, Object> params = new HashMap<String, Object>();
		    			params.put("club_id", club_id);
						params.put("board_cd", board_cd);
						params.put("board_no", 0);
						params.put("file_nm", originalfileName);
						params.put("file_save_nm", saveFileName);
						params.put("file_path", savePath);
						params.put("enclude_yn", "N");
						params.put("input_id", userVO.getId());
						params.put("input_ip", CommonUtils.getClientIP(request));
	//					params.put("hash", hash);
						fileService.addFile(params);
						
						params.put("opt", 1);
						recentFiles.add(fileService.getFile(params));
	                }
	            	mpIndex++;
				}
			}
			/* New */
	        
	        System.err.println("[clubBoardWriteAction.do] club_id: " + club_id);
	        System.err.println("[clubBoardWriteAction.do] board_cd: " + board_cd);
	        System.err.println("[clubBoardWriteAction.do] title: " + title);
	        System.err.println("[clubBoardWriteAction.do] contents: " + contents);
	        System.err.println("[clubBoardWriteAction.do] start_date: " + start_date);
	        System.err.println("[clubBoardWriteAction.do] end_date: " + end_date);
	        
			Date today = new Date();
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("club_id", club_id);
			params.put("board_cd", board_cd);
			params.put("title", title); // 게시글 제목
			params.put("contents", contents); // 게시글 내용
			params.put("fix_yn", fix_yn);
			params.put("attach_yn", (recentFiles.size() > 0)?"Y":"N");
			if(start_date.equals(""))
				params.put("start_date", today);
			else
				params.put("start_date", start_date);
			
			if(end_date.equals(""))
				params.put("end_date", today);
			else
				params.put("end_date", end_date);
			
			params.put("input_id", userVO.getId()); // 게시글을 작성한 사용자 ID
			params.put("input_ip", CommonUtils.getClientIP(request));
			params.put("input_date", today);
			System.err.println("[clubBoardWriteAction.do] params: " + params);

        	boardService.addBoard(params);
        	
        	/* 첨부파일 등록 */
			params = new HashMap<String, Object>();
			params.put("club_id", club_id);
			params.put("board_cd", board_cd);
			params.put("opt", 1);

			recentBoard = boardService.getBoard(params);
			
			if(recentFiles != null && !recentFiles.isEmpty() && recentBoard != null) {
				for (FileVO f : recentFiles) {
					params.put("club_id", club_id);
					params.put("file_no", f.getFile_no());
					params.put("board_no", recentBoard.getBoard_no());
					fileService.attachFile(params);
				}
			}
			
        	String linkStr = "clubBoardList.do";
        	if(board_cd.equals("007004"))
        		linkStr = "clubCalendar.do";
			CommonUtils.showAlert(response, "정상적으로 등록되었습니다.", "/" + linkStr + "?club_id="+club_id +"&board_cd="+board_cd);
			return null;
        } catch(Exception e) {
			System.err.println("[clubBoardWriteAction.do] ERROR: \n" + e.getMessage());
			CommonUtils.showAlert(response, "등록에 실패했습니다.", "/clubBoardList.do?club_id="+club_id +"&board_cd="+board_cd);
			return null;
		}
	}
	
	/*
	 * @RequestMapping(value="/clubBoardUpdateForm.do") #
	 * 동아리 커뮤니티
	 * 게시판 - 게시판 수정 폼
	 * 권한 - 임원 이상만 공지사항, 일정 게시판 수정 가능
	 * @RequestParam club_id, board_no, board_cd
	*/
	@RequestMapping(value = "/clubBoardUpdateForm.do")
	public ModelAndView clubBoardUpdateForm(HttpServletRequest request, HttpServletResponse response,
			 																	ModelAndView mav,
									@RequestParam(value = "club_id", required = false) String club_id,
									@RequestParam(value = "board_no", required = false) String board_no,
									@RequestParam(value = "board_cd", required = false) String board_cd)
	{
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		String headTitle = null;
		if(club_id != null)
			session.setAttribute("club_id", club_id);
		club_id = (String) session.getAttribute("club_id");
		
		if(board_cd != null)
			session.setAttribute("board_cd", board_cd);
		board_cd = (String) session.getAttribute("board_cd");

		if(board_no != null)
			session.setAttribute("board_no", board_no);
		board_no = (String) session.getAttribute("board_no");
		
		if(board_cd.equals("007001"))
			headTitle = "공지사항";
		else if(board_cd.equals("007002"))
			headTitle = "자유게시판";
		else if(board_cd.equals("007003"))
			headTitle = "갤러리";
		else if(board_cd.equals("007004"))
			headTitle = "일정";
		else
			headTitle = "ERROR";
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("board_cd", board_cd);
		params.put("board_no", board_no);
		params.put("club_id", club_id);
		boardService.increaseOpenCnt(params);
		BoardVO searchBoard = boardService.getBoard(params);
		
		Map<String, Object> params2 = new HashMap<String, Object>();
		params2.put("ID", searchBoard.getInput_id());
		UserVO writer = userService.getUserVO(params2);

		/* 클럽 정보 */
		Map<String, Object> clubParams = new HashMap<String, Object>();
		clubParams.put("club_id", club_id);
		ClubVO clubVO = clubService.getClub(clubParams);

		if (clubVO == null) {
    		try {
    			throw new ClubNotExistException("존재 하지 않는 동아리 입니다.");
    		} catch (ClubNotExistException e) {
    			CommonUtils.showAlert(response, "존재 하지 않는 동아리 입니다.", "/index.do");
    			return null;
    		}
    	}
		
		/* 클럽 회장 */
		Map<String, Object> presidentParams = new HashMap<String, Object>();
		presidentParams.put("club_id", club_id);
		clubVO.setPresident(clubMemberService.getClubPresident(presidentParams).getName());
		
		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}
		
		boolean isStaff = false;
		if(staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;
		
		boolean isMyWrite = false;
		if(userVO.getId().equals(searchBoard.getInput_id()))
			isMyWrite = true;
		
		System.err.println("[clubBoardUpdateForm.do] Intro_save_file: " + clubVO.getIntro_save_file_nm());
		System.err.println("[clubBoardUpdateForm.do] poster_save_file: " + clubVO.getPoster_save_file_nm());
		System.err.println("[clubBoardUpdateForm.do] staff_cd: " + staff_cd);
		System.err.println("[clubBoardUpdateForm.do] isStaff: " + isStaff);
		System.err.println("[clubBoardUpdateForm.do] isMyWrite: " + isMyWrite);
		
		/* 파일 x */
		params.put("opt", 2);
		List<FileVO> originalFileList = null;
		List<FileVO> fileList = new ArrayList<FileVO>();
		FileVO thumbnailFile = null;
		boolean hasThumbnail = false;
		int fileListCnt = fileService.getFileListCnt(params);
		if(fileListCnt > 0) {
			originalFileList = fileService.getFileList(params);
			
			for(FileVO v : originalFileList) {
				if(v.getFile_save_nm().contains("thumbnail") && v.getFile_path().contains("thumbnail")) {
					thumbnailFile = v;
					hasThumbnail = true;
				} else {
					fileList.add(v);
				}
			}
		}
			
		/* clubPlatform */
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("open_dt", clubVO.getOpen_dt());
		mav.addObject("president_nm", clubVO.getPresident());
		mav.addObject("isStaff", isStaff);
		mav.addObject("club_intro", clubVO.getIntro_save_file_nm());
		mav.addObject("club_poster", clubVO.getPoster_save_file_nm());
		
		/* clubBoardUpdateForm*/
		mav.addObject("hasThumbnail", hasThumbnail);
		mav.addObject("thumbnailFile", thumbnailFile);
		mav.addObject("fileList", fileList);
		mav.addObject("fileListCnt", fileListCnt);
		mav.addObject("searchBoard", searchBoard);
		mav.addObject("start_date", searchBoard.getStart_date());
		mav.addObject("end_date", searchBoard.getEnd_date());
		mav.addObject("headTitle", headTitle);
		mav.addObject("board_cd", board_cd);
		mav.addObject("writerName", writer.getName());
		mav.addObject("isMyWrite", isMyWrite);
//		mav.setViewName("club/clubBoardUpdateForm");
		mav.setViewName("community/board/UpdateForm");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/clubBoardUpdateAction.do")
	 * 동아리 커뮤니티
	 * 게시판 - 게시판 수정 (동작)
	 * 권한 - 임원 이상만 공지사항, 일정 게시판 수정 가능
	 * @RequestParam club_id, board_no, title
	 * @RequestParam contents, start_date, end_date, board_cd
	*/
	@RequestMapping(value = "/clubBoardUpdateAction.do")
	public ModelAndView clubBoardUpdateAction(MultipartHttpServletRequest request, HttpServletResponse response,
																				ModelAndView mav,
									@RequestParam(value = "club_id", required = false) String club_id,
									@RequestParam(value = "board_no", required = false) int board_no,
									@RequestParam(value = "title", required = false) String title,
									@RequestParam(value = "contents", required = false) String contents,
									@RequestParam(value = "fix_yn", required = false, defaultValue = "N") String fix_yn,
									@RequestParam(value = "start_date", required = false, defaultValue="") String start_date,
									@RequestParam(value = "end_date", required = false, defaultValue="") String end_date,
									@RequestParam(value = "board_cd", required = false) String board_cd,
									@RequestParam(value = "deleteThumbnail", required = false) String deleteThumbnail,
									@RequestParam(value = "deleteAttach", required = false) List<String> delAttachs) throws IOException
	{
		response.setContentType("text/html; charset=UTF-8");
        
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		if(club_id != null)
			session.setAttribute("club_id", club_id);
		club_id = (String) session.getAttribute("club_id");
		
		if(board_cd != null)
			session.setAttribute("board_cd", board_cd);
		board_cd = (String) session.getAttribute("board_cd");
		
		System.err.println("[clubBoardUpdateAction.do] board_no: " + board_no);
		System.err.println("[clubBoardUpdateAction.do] club_id: " + club_id);
		System.err.println("[clubBoardUpdateAction.do] board_cd: " + board_cd);
		
		Date today = new Date();
		Map<String, Object> params = new HashMap<String, Object>();
		/* updateBoard */
		params.put("club_id", club_id);
		params.put("board_cd", board_cd);
		params.put("board_no", board_no);
		params.put("opt", 2);
		int cnt = fileService.getFileListCnt(params);
		boolean isPhotoBoard = board_cd.equals("007003");
		
		/* 썸네일 파일VO 탐색 */
		FileVO oldThumbnailFile = null;
		boolean hasThumbnail = false;
		Map<String, Object> thumbDel = new HashMap<String, Object>();
		thumbDel.put("club_id", club_id);
		if(cnt > 0) {
			List<FileVO> orginalFileList = fileService.getFileList(params);
			for(FileVO v : orginalFileList) {
				if(v.getFile_save_nm().contains("thumbnail") && v.getFile_path().contains("thumbnail")) {
					oldThumbnailFile = v;
					hasThumbnail = true;
					thumbDel.put("file_no", oldThumbnailFile.getFile_no());
					break;
				}
			}
		}
		
		/* 썸네일 파일 삭제 */
		params.put("opt", 0);
		if(deleteThumbnail != null) {
			params.put("file_no", deleteThumbnail);

			FileVO fileVO = fileService.getFile(params);
			File dir = new File(fileVO.getFile_path());
			if (!dir.isDirectory() && dir.exists()) { // 파일 존재 여부 확인
	            if(dir.delete()) {
	            	fileService.deleteFile(params);
	            	hasThumbnail = false;
	            } else {
	            	CommonUtils.showAlert(response, "파일 삭제 오류", "/clubBoardReadForm.do?board_no=" + board_no + "&club_id=" + club_id + "&board_cd=" + board_cd);
	            	return null;
	    		}
			} else {
				CommonUtils.showAlert(response, "잘못된 접근입니다.", "/clubBoardReadForm.do?board_no=" + board_no + "&club_id=" + club_id + "&board_cd=" + board_cd);
				return null;
			}
		}
		
		/* 첨부파일 삭제 */
		if(delAttachs != null) {
			for(String fn : delAttachs) {
				params.put("file_no", fn);

				FileVO fileVO = fileService.getFile(params);
				File dir = new File(fileVO.getFile_path());
				if (!dir.isDirectory() && dir.exists()) { // 파일 존재 여부 확인
		            if(dir.delete()) {
		            	fileService.deleteFile(params);
		            	cnt--;
		            } else {
		            	CommonUtils.showAlert(response, "파일 삭제 오류", "/clubBoardReadForm.do?&board_no=" + board_no + "&club_id=" + club_id + "&board_cd=" + board_cd);
		            	return null;
		    		}
				} else {
					CommonUtils.showAlert(response, "잘못된 접근입니다.", "/clubBoardReadForm.do?board_no=" + board_no + "&club_id=" + club_id + "&board_cd=" + board_cd);
					return null;
				}
			}
		}
		
		/* 업로드할 폴더 체크 */
//			String path = CommonUtils.SAVE_PATH + CommonUtils.getTimeBasePath();
//			File dir = new File(path);
//	        if (!dir.isDirectory()) { // 폴더가 없다면 생성
//	            dir.mkdirs(); // 폴더 생성
//	        }
        
        // 넘어온 파일을 리스트로 저장
		List<MultipartFile> mpList = request.getFiles("attachFile"); // attachFile로 넘어온 파일을 가져옴
		MultipartFile newThumbnailFile = request.getFile("thumbnailFile"); // 썸네일 파일 용
		boolean isExistThumbnail = false;
		if(isPhotoBoard) {
			if(newThumbnailFile != null && !newThumbnailFile.isEmpty() && !newThumbnailFile.getOriginalFilename().equalsIgnoreCase("")) {
				mpList.add(0, newThumbnailFile);
				isExistThumbnail = true;
        		/* 기존 썸네일 삭제 */
				if(hasThumbnail) {
					new File(oldThumbnailFile.getFile_path()).delete();
					fileService.deleteFile(thumbDel);
				}
			}
		}
		if(mpList.size() < 1 || mpList.isEmpty()) {
			// 업로드할 파일 없음
		} else {
			int mpIndex = 0;
			for(MultipartFile multipartFile : mpList) {
				if(multipartFile.getOriginalFilename().equalsIgnoreCase("")) {
					continue;
				}
				
				String path = CommonUtils.SAVE_PATH;
//				String path = request.getSession().getServletContext().getRealPath("/upload/club/files/");

				String thumbPrefix = "";
				if(isPhotoBoard && mpIndex == 0 && isExistThumbnail) {
					thumbPrefix = "thumbnail_";
					path = CommonUtils.SAVE_THUMBNAIL_PATH;
//					path = request.getSession().getServletContext().getRealPath("/upload/club/thumbnail/");
				}
				path += CommonUtils.getTimeBasePath();
				
				/* 업로드할 폴더 체크 */
				File dir = new File(path);
		        if (!dir.isDirectory()) { // 폴더가 없다면 생성
		            dir.mkdirs(); // 폴더 생성
		        }
		        
                String genId = CommonUtils.getRandomString(); // 파일명 중복 방지
                String originalfileName = multipartFile.getOriginalFilename(); // 원본 파일명
                String saveFileName = thumbPrefix + genId + "." + CommonUtils.getExtension(originalfileName); // 서버에 저장될 파일명
                String savePath = path + "/" + saveFileName; // 서버에 저장된 파일 경로
                String hash = CommonUtils.getSHA256(multipartFile.getBytes()); // SHA-256 해쉬 알고리즘
                multipartFile.transferTo(new File(savePath)); // 서버에 파일 저장
                
                /* 무결성 검사 시작 */
                boolean isIntegrity = false;
                File up = new File(savePath);
                if(up.exists()) {
                	if(CommonUtils.getSHA256(Files.readAllBytes(up.toPath())).equals(hash)) {
                		isIntegrity = true; // 무결성 확인 완료
                		if(isPhotoBoard && mpIndex == 0 && isExistThumbnail)
                			CommonUtils.createThumbnail(path, saveFileName);
                	} else {
                		up.delete(); // 손상된 파일 삭제
                	}
                }
                
            	if(isIntegrity) { // 무결성 체크 완료
            		cnt++;
					params.put("club_id", club_id);
					params.put("file_nm", originalfileName);
					params.put("file_save_nm", saveFileName);
					params.put("file_path", savePath);
					params.put("enclude_yn", "N");
					params.put("input_id", userVO.getId());
					params.put("input_ip", CommonUtils.getClientIP(request));
					params.put("input_date", today);
					fileService.addFile(params);
					
				}
            	mpIndex++;
			}
		}
		
		params.put("title", title);
		params.put("contents", contents);
		params.put("fix_yn", fix_yn); //체크박스 선택 안하면 null이 넘어옴
		params.put("attach_yn", (cnt > 0)?"Y":"N");
		if(start_date.equals(""))
			params.put("start_date", today);
		else
			params.put("start_date", start_date);
		
		if(end_date.equals(""))
			params.put("end_date", today);
		else
			params.put("end_date", end_date);
		params.put("update_id", userVO.getId());
		params.put("update_ip", CommonUtils.getClientIP(request));
		params.put("update_date", today);
		boardService.updateBoard(params);
		
//    	if(board_cd.equals("007004")) {
//    		CommonUtils.showAlert(response, "정상적으로 수정하였습니다.", "/clubCalendar.do?club_id=" + club_id + "&board_cd=" + board_cd);
//    		return null;
//    	}
//    	mav.setViewName("redirect:/" + linkStr + ".do?club_id=" + club_id + "&board_cd=" + board_cd);
    	mav.setViewName("redirect:/clubBoardReadForm.do?board_no=" + board_no + "&club_id=" + club_id + "&board_cd=" + board_cd);
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/clubBoardDeleteAction.do")
	 * 동아리 커뮤니티
	 * 게시판 - 삭제 (동작)
	 * @RequestParam club_id, board_no, board_cd
	*/
	@RequestMapping(value = "/clubBoardDeleteAction.do")
	public String clubBoardDeleteAction(HttpServletRequest request, HttpServletResponse response,
									@RequestParam(value = "club_id", required = false) int club_id,
									@RequestParam(value = "board_no", required = false) int board_no,
									@RequestParam(value = "board_cd", required = false) String board_cd)
	{
		response.setContentType("text/html; charset=UTF-8");

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("board_cd", board_cd);
		params.put("board_no", board_no);
		params.put("club_id", club_id);

		boardService.deleteBoard(params);
		if(!board_cd.equals("007004")) {
			CommonUtils.showAlert(response, "정상적으로 삭제하였습니다.",
					"/clubBoardList.do?club_id=" + club_id + "&board_cd=" + board_cd);
			return null;
		}
		else {
			CommonUtils.showAlert(response, "정상적으로 삭제하였습니다.",
					"/clubCalendar.do?club_id=" + club_id + "&board_cd=" + board_cd);
			return null;
		}

	}
	
	/*	
	 * @RequestMapping(value="/clubManage.do")
	 * 동아리 커뮤니티
	 * 동아리 관리 - 동아리 회원 승인
	 * 권한 - 임원 이상
	 * @RequestParam club_id, rowIndex
	*/
	@RequestMapping(value="/clubManage.do")
 	public ModelAndView clubManage(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "id", required = false, defaultValue="0") String id)
	{
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		/* 클럽 정보 */
		Map<String, Object> clubParams = new HashMap<String, Object>();
		clubParams.put("club_id", club_id);
		ClubVO clubVO = clubService.getClub(clubParams);

		if (clubVO == null) {
    		try {
    			throw new ClubNotExistException("존재 하지 않는 동아리 입니다.");
    		} catch (ClubNotExistException e) {
    			CommonUtils.showAlert(response, "존재 하지 않는 동아리 입니다.", "/index.do");
    			return null;
    		}
    	}
		
		/* 클럽 회장 */
		Map<String, Object> presidentParams = new HashMap<String, Object>();
		presidentParams.put("club_id", club_id);
		clubVO.setPresident(clubMemberService.getClubPresident(presidentParams).getName());
		
		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}
		
		if(id.equals(userVO.getId())){
			CommonUtils.showAlert(response, "자신을 수정 할 수 없습니다.", "clubManageList.do?club_id="+club_id);
			return null;
		}
		
		boolean isStaff = false;
		if(staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;
				
		if(! isStaff) {
			CommonUtils.showAlert(response, "임원이상 이용하는한 서비스 입니다.", "clubIntro.do?club_id=" + club_id);
			return null;
		}
		memberParams.put("id", id);
		ClubMemberVO president = clubMemberService.getClubPresident(memberParams);
		boolean isPresident = false;
		if(id.equals(president.getStudent_id()))
			isPresident = true;
		
		System.err.println("[clubManage.do] staff_cd: " + staff_cd);
		System.err.println("[clubManage.do] isStaff: " + isStaff);
		System.err.println("[clubManage.do] isPresident: " + isPresident);

		memberParams.put("opt", 1);
		memberParams.put("id", id);
		memberParams.put("join_cd", "008001");
		ClubMemberVO clubMemberVO = clubMemberService.getClubMember(memberParams).get(0);
		
		
		/* clubManage */
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("club_id", club_id);
		mav.addObject("join_cd", "008001");
		mav.addObject("isStaff", isStaff);
		mav.addObject("isPresident", isPresident);
		mav.addObject("staff_cd", staff_cd);
		mav.addObject("memberInfo", clubMemberVO);
		
//		mav.setViewName("club/clubManage");
		mav.setViewName("community/manage/item/clubManage");
		return mav;
	}
	
	/*	
	 * @RequestMapping(value="/clubApproval.do")
	 * 동아리 커뮤니티
	 * 동아리 관리 - 동아리 회원 승인
	 * 권한 - 임원 이상
	 * @RequestParam club_id, rowIndex
	*/
	@RequestMapping(value="/clubApproval.do")
 	public ModelAndView clubApproval(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "id", required = false, defaultValue="0") String id)
	{
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		/* 클럽 정보 */
		Map<String, Object> clubParams = new HashMap<String, Object>();
		clubParams.put("club_id", club_id);
		ClubVO clubVO = clubService.getClub(clubParams);

		if (clubVO == null) {
    		try {
    			throw new ClubNotExistException("존재 하지 않는 동아리 입니다.");
    		} catch (ClubNotExistException e) {
    			CommonUtils.showAlert(response, "존재 하지 않는 동아리 입니다.", "/index.do");
    			return null;
    		}
    	}
		
		/* 클럽 회장 */
		Map<String, Object> presidentParams = new HashMap<String, Object>();
		presidentParams.put("club_id", club_id);
		clubVO.setPresident(clubMemberService.getClubPresident(presidentParams).getName());
		
		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}
		
		
		boolean isStaff = false;
		if(staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;
				
		if(! isStaff) {
			CommonUtils.showAlert(response, "임원이상 이용하는한 서비스 입니다.", "clubIntro.do?club_id=" + club_id);
			return null;
		}
		System.err.println("[clubApproval.do] staff_cd: " + staff_cd);
		System.err.println("[clubApproval.do] isStaff: " + isStaff);

		memberParams.put("opt", 1);
		memberParams.put("id", id);
		memberParams.put("join_cd", "008003");
		ClubMemberVO clubMemberVO = clubMemberService.getClubMember(memberParams).get(0);
		
		
		/* clubApproval */
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("club_id", club_id);
		mav.addObject("join_cd", "008003");
		mav.addObject("isStaff", isStaff);
		mav.addObject("staff_cd", staff_cd);
		mav.addObject("memberInfo", clubMemberVO);
		
//		mav.setViewName("club/clubManage");
		mav.setViewName("community/approval/item/clubApproval");
		return mav;
	}
	
	/*	
	 * @RequestMapping(value="/clubManageAction.do")
	 * 동아리 커뮤니티
	 * 동아리 관리 - 동아리 회원 승인
	 * 권한 - 임원 이상
	 * @RequestParam club_id, student_id, submit
	*/
	@RequestMapping(value="/clubManageAction.do")
 	public ModelAndView clubManageAction(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="0") String club_id,
							 @RequestParam(value = "student_id", required = false, defaultValue ="") String student_id,
							 @RequestParam(value = "submit", required = false, defaultValue ="") String submit)
	{
		if (club_id.equals("0")) {
			CommonUtils.showAlertHistoryBack(response, "오류 발생");
			return null;
		}
		
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		Map<String, Object> params2 = new HashMap<String, Object>();
		params2.put("id", userVO.getId());
		params2.put("club_id", club_id);
		String staff = clubMemberService.getStaffCD(params2);
		boolean isStaff = false;
		if(staff.equals("004001") || staff.equals("004002"))
			isStaff = true;
		
		if(! isStaff) {
			CommonUtils.showAlert(response, "임원이상 이용하는한 서비스 입니다.", "clubIntro.do?club_id=" + club_id);
			return null;
		}
		System.err.println("[clubManageAction.do] submit: " + submit);
		Map<String, Object> params = new HashMap<String, Object>();
		if (submit.equals("승인")) {
			params.put("club_id", club_id);
			params.put("staff_cd", "004004");
			params.put("id", student_id);
			Date today = new Date();
			params.put("join_dt", today);
			params.put("if", 1);
			clubMemberService.updateClubMember(params);
			CommonUtils.showAlert(response, "정상 처리 되었습니다.", "/clubApprovalList.do?club_id=" + club_id);
			return null;
		} else if (submit.equals("거부")) {
			params.put("club_id", club_id);
			params.put("id", student_id);
			clubMemberService.leaveClub(params);
			CommonUtils.showAlert(response, "정상 처리 되었습니다.", "/clubApprovalList.do?club_id=" + club_id);
			return null;
		} else if (submit.equals("제명")) {
			
			if(userVO.getId().equals(student_id)) {
				CommonUtils.showAlert(response, "자신을 제명 할 수 없습니다.", "/clubManageList.do?club_id=" + club_id);
				return null;
			}
			
			/* 클럽 회장 */
			Map<String, Object> presidentParams = new HashMap<String, Object>();
			presidentParams.put("club_id", club_id);
			String president = clubMemberService.getClubPresident(presidentParams).getName();
			
			if(president.equals(student_id)) {
				CommonUtils.showAlert(response, "회장을 제명 할 수 없습니다.", "/clubManageList.do?club_id=" + club_id);
				return null;
			}
			
			params.put("club_id", club_id);
			params.put("id", student_id);
			clubMemberService.leaveClub(params);
			CommonUtils.showAlert(response, "정상 처리 되었습니다.", "/clubManageList.do?club_id=" + club_id);
			return null;
		} else {
			CommonUtils.showAlert(response, "오류 발생.", "/clubIntro.do?club_id=" + club_id);
			return null;
		}
		
		
	}
	
	/*	

	 * @RequestMapping(value="/clubApprovalList.do")
	 * 동아리 커뮤니티
	 * 동아리 관리 - 동아리 회원 관리
	 * 권한 - 임원 이상
	 * @RequestParam club_id, category, search, page(pageNumber)
	*/
	@RequestMapping(value="/clubApprovalList.do")
 	public ModelAndView clubApprovalList(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "page", required = false, defaultValue = "1") String pageNumber) {
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		List<ClubMemberVO> clubMemberList = null;
	
		System.err.println("[clubApprovalList.do] club_id: " + club_id);
		System.err.println("[clubApprovalList.do] pageNumber: " + pageNumber);
		/* 클럽 정보 */
		Map<String, Object> clubParams = new HashMap<String, Object>();
		clubParams.put("club_id", club_id);
		ClubVO clubVO = clubService.getClub(clubParams);

		if (clubVO == null) {
    		try {
    			throw new ClubNotExistException("존재 하지 않는 동아리 입니다.");
    		} catch (ClubNotExistException e) {
    			CommonUtils.showAlert(response, "존재 하지 않는 동아리 입니다.", "/index.do");
    			return null;
    		}
    	}
		
		/* 클럽 회장 */
		Map<String, Object> presidentParams = new HashMap<String, Object>();
		presidentParams.put("club_id", club_id);
		clubVO.setPresident(clubMemberService.getClubPresident(presidentParams).getName());
		
		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}
		
		boolean isStaff = false;
		if(staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;
		System.err.println("[clubApprovalList.do] staff_cd: " + staff_cd);
		System.err.println("[clubApprovalList.do] isStaff: " + isStaff);
		
		if(! isStaff) {
			CommonUtils.showAlert(response, "임원이상 이용하는한 서비스 입니다.", "clubIntro.do?club_id=" + club_id);
			return null;
		}
		
		
		int memberListCount = 1;
		int limit = 7;
		int currPage = Integer.parseInt(pageNumber);
		currPage = (currPage < 1)?1:currPage;
		int prevPage = 1;
		int nextPage = 1;
		int totalPage = 1;
		int startNum = 1; // 범위 시작
		int endNum = 1; // 범위 끝	
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		params.put("join_cd", "008003");
		params.put("select", 1);
		params.put("cdn", "");
		params.put("limit", limit);
		
		memberListCount = clubMemberService.getMemberListCnt(params); 
		totalPage = clubMemberService.getTotalPageCnt(params); 
		
		/* 페이지 번호에 따른 가져올 게시글 범위 */
		if(totalPage <= 1) {
			startNum = 1;
			endNum = (memberListCount < limit) ? memberListCount:limit;
			currPage = 1;
			prevPage = currPage;
			nextPage = currPage;
		} else {
			startNum = (currPage * limit) - limit + 1;
			endNum = currPage * limit;
			prevPage = currPage - 1;
			prevPage = (prevPage < 1) ? 1: prevPage;
			nextPage = (memberListCount > endNum) ? (currPage+1):currPage;
		}
		
		params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		params.put("join_cd", "008003");
		params.put("select", 1);
		params.put("cdn", "");
		params.put("startNum", startNum);
		params.put("endNum", endNum);			
		
		clubMemberList = clubMemberService.getClubMemberList(params);	
		
//		System.err.println("[clubApprovalList.do] clubList: \n" + clubMemberList);
		System.err.println("[clubApprovalList.do] clubListCount: " + memberListCount);
		System.err.println("[clubApprovalList.do] totalPage: " + totalPage);
		
		
		/* clubManageList */
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("club_id", club_id);
		mav.addObject("isStaff", isStaff);
		mav.addObject("totalPage", totalPage);
		mav.addObject("prevPage", prevPage);
		mav.addObject("currPage", currPage);
		mav.addObject("nextPage", nextPage);
		mav.addObject("memberList", clubMemberList);
		mav.addObject("memberListCount", memberListCount);
		mav.setViewName("community/approval/index");
		return mav;
	}
	
	/*	
	 * @RequestMapping(value="/clubManageList.do")
	 * 동아리 커뮤니티
	 * 동아리 관리 - 동아리 회원 관리
	 * 권한 - 임원 이상
	 * @RequestParam club_id, category, search, page(pageNumber)
	*/
	@RequestMapping(value="/clubManageList.do")
 	public ModelAndView clubManageList(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "select", required = false, defaultValue ="1") String select,
							 @RequestParam(value = "cdn", required = false, defaultValue ="") String cdn,
							 @RequestParam(value = "page", required = false, defaultValue = "1") String pageNumber) {
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		List<ClubMemberVO> clubMemberList = null;
	
		System.err.println("[clubManageList.do] club_id: " + club_id);
		System.err.println("[clubManageList.do] select: " + select);
		System.err.println("[clubManageList.do] cdn: " + cdn);
		System.err.println("[clubManageList.do] pageNumber: " + pageNumber);
		/* 클럽 정보 */
		Map<String, Object> clubParams = new HashMap<String, Object>();
		clubParams.put("club_id", club_id);
		ClubVO clubVO = clubService.getClub(clubParams);

		if (clubVO == null) {
    		try {
    			throw new ClubNotExistException("존재 하지 않는 동아리 입니다.");
    		} catch (ClubNotExistException e) {
    			CommonUtils.showAlert(response, "존재 하지 않는 동아리 입니다.", "/index.do");
    			return null;
    		}
    	}
		
		/* 클럽 회장 */
		Map<String, Object> presidentParams = new HashMap<String, Object>();
		presidentParams.put("club_id", club_id);
		clubVO.setPresident(clubMemberService.getClubPresident(presidentParams).getName());
		
		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}
		
		boolean isStaff = false;
		if(staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;
		System.err.println("[clubManageList.do] Intro_save_file: " + clubVO.getIntro_save_file_nm());
		System.err.println("[clubManageList.do] poster_save_file: " + clubVO.getPoster_save_file_nm());
		System.err.println("[clubManageList.do] staff_cd: " + staff_cd);
		System.err.println("[clubManageList.do] isStaff: " + isStaff);
		
		if(! isStaff) {
			CommonUtils.showAlert(response, "임원이상 이용하는한 서비스 입니다.", "clubIntro.do?club_id=" + club_id);
			return null;
		}
		
		
		int memberListCount = 1;
		int limit = 7;
		int currPage = Integer.parseInt(pageNumber);
		currPage = (currPage < 1)?1:currPage;
		int prevPage = 1;
		int nextPage = 1;
		int totalPage = 1;
		int startNum = 1; // 범위 시작
		int endNum = 1; // 범위 끝	
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		params.put("join_cd", "008001");
		params.put("select", select);
		params.put("cdn", cdn);
		params.put("limit", limit);
		
		memberListCount = clubMemberService.getMemberListCnt(params); 
		totalPage = clubMemberService.getTotalPageCnt(params); 
		
		/* 페이지 번호에 따른 가져올 게시글 범위 */
		if(totalPage <= 1) {
			startNum = 1;
			endNum = (memberListCount < limit) ? memberListCount:limit;
			currPage = 1;
			prevPage = currPage;
			nextPage = currPage;
		} else {
			startNum = (currPage * limit) - limit + 1;
			endNum = currPage * limit;
			prevPage = currPage - 1;
			prevPage = (prevPage < 1) ? 1: prevPage;
			nextPage = (memberListCount > endNum) ? (currPage+1):currPage;
		}
		
		params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		params.put("join_cd", "008001");
		params.put("select", select);
		params.put("cdn", cdn);
		params.put("startNum", startNum);
		params.put("endNum", endNum);			
		
		clubMemberList = clubMemberService.getClubMemberList(params);	
		for (ClubMemberVO clubMemberVO : clubMemberList)
		{
			if (clubMemberVO.getStaff_cd().equals("004004"))
				clubMemberVO.setStaff_cd("회원");
			else if (clubMemberVO.getStaff_cd().equals("004003"))
				clubMemberVO.setStaff_cd("총무");
			else if (clubMemberVO.getStaff_cd().equals("004002"))
				clubMemberVO.setStaff_cd("부회장");
			else if (clubMemberVO.getStaff_cd().equals("004001"))
				clubMemberVO.setStaff_cd("회장");
		}
//		System.err.println("[clubManageList.do] clubList: \n" + clubMemberList);
		System.err.println("[clubManageList.do] clubListCount: " + memberListCount);
		System.err.println("[clubManageList.do] totalPage: " + totalPage);
		
		
		/* clubManageList */
		mav.addObject("club_id", club_id);
		mav.addObject("isStaff", isStaff);
		mav.addObject("select", select);
		mav.addObject("cdn", cdn);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("totalPage", totalPage);
		mav.addObject("prevPage", prevPage);
		mav.addObject("currPage", currPage);
		mav.addObject("nextPage", nextPage);
		mav.addObject("memberList", clubMemberList);
		mav.addObject("memberListCount", memberListCount);
//		mav.setViewName("club/clubManageList");
		mav.setViewName("community/manage/index");
		return mav;
	}
	
	/*	
	 * @RequestMapping(value="/clubUpdate.do")
	 * 동아리 커뮤니티
	 * 동아리 관리 - 동아리 정보 수정
	 * 권한 - 임원 이상
	 * @RequestParam club_id
	*/
	@RequestMapping(value="/clubUpdate.do")
 	public ModelAndView clubUpdate(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id)
	{
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		/* 클럽 정보 */
		Map<String, Object> clubParams = new HashMap<String, Object>();
		clubParams.put("club_id", club_id);
		ClubVO clubVO = clubService.getClub(clubParams);

		if (clubVO == null) {
    		try {
    			throw new ClubNotExistException("존재 하지 않는 동아리 입니다.");
    		} catch (ClubNotExistException e) {
    			CommonUtils.showAlert(response, "존재 하지 않는 동아리 입니다.", "/index.do");
    			return null;
    		}
    	}
		
		/* 클럽 회장 */
		Map<String, Object> presidentParams = new HashMap<String, Object>();
		presidentParams.put("club_id", club_id);
		clubVO.setPresident(clubMemberService.getClubPresident(presidentParams).getName());
		
		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}
		
		boolean isStaff = false;
		if(staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;
		System.err.println("[clubUpdate.do] Intro_save_file: " + clubVO.getIntro_save_file_nm());
		System.err.println("[clubUpdate.do] poster_save_file: " + clubVO.getPoster_save_file_nm());
		System.err.println("[clubUpdate.do] staff_cd: " + staff_cd);
		System.err.println("[clubUpdate.do] isStaff: " + isStaff);
		
		/* clubPlatform */
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("open_dt", clubVO.getOpen_dt());
		mav.addObject("president_nm", clubVO.getPresident());
		mav.addObject("isStaff", isStaff);
		mav.addObject("club_intro", clubVO.getIntro_save_file_nm());
		mav.addObject("club_poster", clubVO.getPoster_save_file_nm());
		
		/* clubUpdate */
		mav.addObject("clubInfo", clubVO);
//		mav.setViewName("club/clubUpdate");
		mav.setViewName("community/manage/item/InfoUpdate");
		return mav;
	}
	
	/*	
	 * @RequestMapping(value="/clubUpdateAction.do")
	 * 동아리 커뮤니티
	 * 동아리 관리 - 동아리 정보 수정 (동작)
	 * 권한 - 임원 이상
	 * @RequestParam club_id, club_aim, club_active
	 * @RequestParam open_dt, club_room
	*/
	@RequestMapping(value="/clubUpdateAction.do")
 	public ModelAndView clubUpdateAction(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "club_aim", required = false, defaultValue ="") String club_aim,
							 @RequestParam(value = "club_active", required = false, defaultValue ="") String club_active,
							 @RequestParam(value = "open_dt", required = false, defaultValue ="") String open_dt,
							 @RequestParam(value = "club_room", required = false, defaultValue ="") String club_room)
	{
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		/* 클럽 정보 */
		Map<String, Object> clubParams = new HashMap<String, Object>();
		clubParams.put("club_id", club_id);
		ClubVO clubVO = clubService.getClub(clubParams);

		if (clubVO == null) {
    		try {
    			throw new ClubNotExistException("존재 하지 않는 동아리 입니다.");
    		} catch (ClubNotExistException e) {
    			CommonUtils.showAlert(response, "존재 하지 않는 동아리 입니다.", "/index.do");
    			return null;
    		}
    	}

		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}
		
		boolean isStaff = false;
		if(staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;
		System.err.println("[clubUpdateAction.do] isStaff: " + isStaff);
		if(! isStaff) {
			CommonUtils.showAlert(response, "임원 이상 이용가능한 서비스 입니다..", "clubIntro.do?club_id="+club_id);
			return null;
		}
		System.err.println("[clubUpdateAction.do] club_id: " + club_id);
		System.err.println("[clubUpdateAction.do] club_aim: " + club_aim);
		System.err.println("[clubUpdateAction.do] club_active: " + club_active);
		System.err.println("[clubUpdateAction.do] open_dt: " + open_dt);
		System.err.println("[clubUpdateAction.do] club_room: " + club_room);
		
		Map<String, Object> updateClubParams = new HashMap<String, Object>();
		updateClubParams.put("club_id", club_id);
		updateClubParams.put("club_aim", club_aim);
		updateClubParams.put("club_active", club_active);
		updateClubParams.put("open_dt", open_dt);
		updateClubParams.put("club_room", club_room);
		try {
			clubService.updateClub(updateClubParams);
			CommonUtils.showAlert(response, "정상적으로 변경 되었습니다.", "clubUpdate.do?club_id="+club_id);
			return null;
		} catch (Exception e) {
			System.err.println("[clubUpdateAction.do] err: " + e.getMessage());
			CommonUtils.showAlert(response, "업데이트중 오류 발생....", "clubUpdate.do?club_id="+club_id);
			return null;
		}
	}
	
	/*
	 * @RequestMapping(value="/leaveClubAction.do")
	 * 동아리 커뮤니티
	 * 탈퇴 하기 (동작)
	 * 회장 탈퇴 불가
	 * @RequestParam club_id
	*/
	@RequestMapping(value="/leaveClubAction.do")
	public ModelAndView leaveClubAction(HttpServletRequest request, HttpServletResponse response,
			 ModelAndView mav,
			 @RequestParam(value = "club_id", required = false) String club_id)
	{
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		if(club_id != null)
			session.setAttribute("club_id", club_id);
		club_id = (String) session.getAttribute("club_id");
		
		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}
		
		boolean isStaff = false;
		if(staff_cd.equals("004001")) {
			CommonUtils.showAlert(response, "회장은 탈퇴 할 수 없습니다.", "/clubIntro.do?club_id=" + club_id);
			return null;
		}
		
		System.err.println("[leaveClubAction.do] staff_cd: " + staff_cd);
		System.err.println("[leaveClubAction.do] isStaff: " + isStaff);
		
		clubMemberService.leaveClub(memberParams);
		CommonUtils.showAlert(response, "탈퇴 되었습니다.", "/index.do");
		return null;
		
	}
	
	/*
	 * @RequestMapping(value="/clubSearch.do")
	 * 동아리
	 * 조회 및 가입
	 * @RequestParam gb_cd, at_cd, search, page(pageNumber)
	*/
	@RequestMapping(value="/clubSearch.do")
 	public ModelAndView clubSearch(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "gb_cd", required = false, defaultValue ="") String gb_cd,
							 @RequestParam(value = "at_cd", required = false, defaultValue ="") String at_cd,
							 @RequestParam(value = "search", required = false, defaultValue ="") String search,
							 @RequestParam(value = "page", required = false, defaultValue = "1") String pageNumber) {
		HttpSession session = request.getSession();
		
		if(at_cd.equals("") || at_cd.equals("002"))
			session.setAttribute("at_cd", "002");
		else 
			session.setAttribute("at_cd", at_cd);
		
		List<ClubVO> clubList = null;
		
		int clubListCount = 1;
		int limit = 6;
		int currPage = Integer.parseInt(pageNumber);
		currPage = (currPage < 1)?1:currPage;
		int prevPage = 1;
		int nextPage = 1;
		int totalPage = 1;
		int startNum = 1; // 범위 시작
		int endNum = 1; // 범위 끝	
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("gb_cd", gb_cd);
		params.put("at_cd", at_cd);
		params.put("search", search);
		params.put("limit", limit);
		System.err.println("[clubSearch.do] gb_cd: " + gb_cd);
		System.err.println("[clubSearch.do] at_cd: " + at_cd);
		System.err.println("[clubSearch.do] search: " + search);
		
	
		try{ clubListCount = clubService.getClubListCnt(params); }
		catch (Exception e) { clubListCount=0; }
		try { totalPage = clubService.getTotalPageCnt(params); }
		catch (Exception e) { totalPage=0; }
		
		
		
		/* 페이지 번호에 따른 가져올 게시글 범위 */
		if(totalPage <= 1) {
			startNum = 1;
			endNum = (clubListCount < limit) ? clubListCount:limit;
			currPage = 1;
			prevPage = currPage;
			nextPage = currPage;
		} else {
			startNum = (currPage * limit) - limit + 1;
			endNum = currPage * limit;
			prevPage = currPage - 1;
			prevPage = (prevPage < 1) ? 1: prevPage;
			nextPage = (clubListCount > endNum) ? (currPage+1):currPage;
		}
		
		params = new HashMap<String, Object>();
		params.put("startNum", startNum);
		params.put("endNum", endNum);			
		params.put("gb_cd", gb_cd);
		params.put("at_cd", at_cd);
		params.put("search", search);	
		
		clubList = clubService.getClubList(params);			
		
//		System.err.println("[clubSearch.do] clubList: \n" + clubList); 
		System.err.println("[clubSearch.do] clubListCount: " + clubListCount);
		System.err.println("[clubSearch.do] totalPage: " + totalPage);
		
		for(ClubVO club : clubList) {
			Map<String, Object> cntParams = new HashMap<String, Object>();
			cntParams.put("club_id", club.getClub_id());
			cntParams.put("opt", 1);
			cntParams.put("join_cd", "008001");
			club.setCnt(clubMemberService.getClubMemberCnt(cntParams));
			
			Map<String, Object> presidentParams = new HashMap<String, Object>();
			presidentParams.put("club_id", club.getClub_id());
			club.setPresident(clubMemberService.getClubPresident(presidentParams).getName());
		}
		
		mav.addObject("at_cd", at_cd);
		mav.addObject("gb_cd", gb_cd);
		mav.addObject("search", search);
		mav.addObject("totalPage", totalPage);
		mav.addObject("prevPage", prevPage);
		mav.addObject("currPage", currPage);
		mav.addObject("nextPage", nextPage);
		mav.addObject("clubList", clubList);
		
		mav.addObject("clubListCount", clubListCount);
		mav.setViewName("hallym/clubSearch");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/topClub.do")
	 * 동아리
	 * 우수동아리
	 * @RequestParam gb_cd, at_cd
	 * TODO topClub 입력 방식 변경 필요
	*/
	@RequestMapping(value="/topClub.do")
	public ModelAndView getTopClub(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "gb_cd", required = false, defaultValue ="") String gb_cd,
							 @RequestParam(value = "at_cd", required = false, defaultValue ="") String at_cd,
							 @RequestParam(value = "year", required = false, defaultValue ="") String year) {
		HttpSession session = request.getSession();
		session.setAttribute("year", year);
		if(at_cd.equals("") || at_cd.equals("002"))
			session.setAttribute("at_cd", "002001");
		else 
			session.setAttribute("at_cd", at_cd);
		List<ClubVO> clubTopList = null;
		
		if(year == "" || year.isEmpty() || year == null) {
			year = new SimpleDateFormat("yyyy").format(new Date()).toString();
		}
		
		if(gb_cd.equals(""))
			gb_cd="001001";
	
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("gb_cd", gb_cd);
		params.put("at_cd", at_cd);
		params.put("year", year);
		if(at_cd.equals("002001"))
			params.put("opt", 1);
		else
			params.put("opt", 2);
			
		
		clubTopList = clubService.getTopClubList(params);
		
		for(ClubVO club : clubTopList) {
			Map<String, Object> cntParams = new HashMap<String, Object>();
			cntParams.put("club_id", club.getClub_id());
			cntParams.put("opt", 1);
			cntParams.put("join_cd", "008001");
			club.setCnt(clubMemberService.getClubMemberCnt(cntParams));
			
			Map<String, Object> presidentParams = new HashMap<String, Object>();
			presidentParams.put("club_id", club.getClub_id());
			club.setPresident(clubMemberService.getClubPresident(presidentParams).getName());
		}
		
		mav.addObject("at_cd", at_cd);
		mav.addObject("gb_cd", gb_cd);
		mav.addObject("year", year);
		mav.addObject("clubList", clubTopList);
		mav.setViewName("hallym/topClub");
		
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/createClub.do")
	 * 동아리
	 * 개설
	 * 
	*/
	@RequestMapping(value="/createClub.do",  method = RequestMethod.GET)
	public ModelAndView createClub(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav) {
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
	        
		System.err.println("[createClub.do] user_id: " + userVO.getId());
		mav.addObject("user_id", userVO.getId());
		mav.setViewName("hallym/createClub");

		return mav;
	}

	/*
	 * @RequestMapping(value="/createClubAction.do")
	 * 동아리
	 * 개설 (동작)
	 * @RequestParam club_nm, club_gb_cd, club_at_cd
	 * @RequestParam club_aim, club_active, club_room
	 * @RequestParam open_dt, user_id
	*/
	@RequestMapping(value="/createClubAction.do",  method = RequestMethod.POST)
	public ModelAndView createClubAction(HttpServletRequest request, HttpServletResponse response,
							 MultipartHttpServletRequest multi,
							 ModelAndView mav,
							 @RequestParam(value = "club_nm", required = false, defaultValue ="") String club_nm,
							 @RequestParam(value = "club_gb_cd", required = false, defaultValue ="") String club_gb_cd,
							 @RequestParam(value = "club_at_cd", required = false, defaultValue ="") String club_at_cd,
							 @RequestParam(value = "club_aim", required = false, defaultValue ="") String club_aim,
							 @RequestParam(value = "club_active", required = false, defaultValue ="") String club_active,
							 @RequestParam(value = "club_room", required = false, defaultValue ="") String club_room,
							 @RequestParam(value = "open_dt", required = false, defaultValue ="") String open_dt,
							 @RequestParam(value = "user_id", required = false, defaultValue ="") String user_id) {
	
		Map<String, Object> nameCheckParams = new HashMap<String, Object>();
		nameCheckParams.put("club_nm", club_nm);

		/* 클럽 이름이 이미 존재 하는지  체크 */
		if(club_nm.equals(clubService.getClubName(nameCheckParams))) {
			try {
				throw new ClubExistException("ClubExistException: 이미" + club_nm + " 은(는) 존재 합니다.");
			} catch (ClubExistException e) {
				System.err.println("[createClubAction.do] ClubExistException: " + e.getMessage());
				CommonUtils.showAlert(response, "이미 존재하는 동아리 입니다. [생성 오류]", "index.do");
				return null;
			}
		}
		
		Map<String, Object> userParams = new HashMap<String, Object>();
		userParams.put("ID", user_id);	
		System.err.println("[createClubAction.do] user_id: " + user_id);
		System.err.println("[createClubAction.do] club_nm: " + club_nm);
		System.err.println("[createClubAction.do] club_gb_cd: " + club_gb_cd);
		System.err.println("[createClubAction.do] club_at_cd: " + club_at_cd);
		System.err.println("[createClubAction.do] club_aim: " + club_aim);
		System.err.println("[createClubAction.do] club_active: " + club_active);
		System.err.println("[createClubAction.do] club_room: " + club_room);
		System.err.println("[createClubAction.do] open_dt: " + open_dt);
		UserVO userVO = userService.getUserVO(userParams);
		
		/* 유저 정보 확인 */
		if(userVO.getId() == null) {
			try {
				throw new UserNotExistException("UserNotExistException: " + user_id + "라는 user가 존재 하지 않습니다.");
			} catch (UserNotExistException e) {
				System.err.println("[createClubAction.do] UserNotExistException: " + e.getMessage());
				CommonUtils.showAlert(response, "유저 DB 오류 ", "index.do");
				return null;
			}
		}
		
		ClubVO clubVO = new ClubVO();
		// https://cofs.tistory.com/40 참고
		// https://powerku.tistory.com/12 참고
		// https://m.blog.naver.com/PostView.nhn?blogId=jxs2&logNo=110177957010&proxyReferer=https:%2F%2Fwww.google.com%2F 참고
//		String directory = multi.getSession().getServletContext().getRealPath("/upload/club/");
		String directory = CommonUtils.SAVE_PATH;
		System.err.println("[createClubAction.do] directory: " + directory);
		File upDir = new File(directory);
		if (!upDir.exists()) {
			upDir.mkdirs();
		}
		
		Iterator<String> fileNames = multi.getFileNames();
		String parameter = (String) fileNames.next();
		MultipartFile mFile = multi.getFile(parameter);
		System.err.println("[createClubAction.do] parmeter: " + parameter);
		String fileName = mFile.getOriginalFilename().toLowerCase();

		System.err.println("[createClubAction.do] fileName: " + fileName);
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
				CommonUtils.showAlert(response, "업로드할 수 없는 확장자입니다.", "createClubAction.do");
				return null;
				
			} else {
				try {
					mFile.transferTo(new File(directory + "/" + fileSaveName));
				} catch (IllegalStateException | IOException e) {
					System.err.println("[createClubAction.do] transferTo Error: " + e.getMessage());
					CommonUtils.showAlert(response, "클럽 생성 오류", "index.do");
					return null;
				}
				clubVO.setIntro_file_nm(fileName);
				clubVO.setIntro_save_file_nm(fileSaveName);
			}
		}

		parameter = (String) fileNames.next();
		mFile = multi.getFile(parameter);
		System.err.println("[createClubAction.do] parmeter2: " + parameter);
		fileName = mFile.getOriginalFilename().toLowerCase();
		System.err.println("[createClubAction.do] fileName2: " + fileName);
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
				CommonUtils.showAlert(response, "업로드할 수 없는 확장자입니다.", "createClubAction.do");
				return null;
			} else {
				try {
					mFile.transferTo(new File(directory + "/" + fileSaveName));
				} catch (IllegalStateException | IOException e) {
					System.err.println("[createClubAction.do] transferTo Error: " + e.getMessage());
					CommonUtils.showAlert(response, "클럽 생성 오류", "index.do");
					return null;
				}
				clubVO.setPoster_file_nm(fileName);
				clubVO.setPoster_save_file_nm(fileSaveName);
			}
		}		
		
		Map<String, Object> clubParams = new HashMap<String, Object>();
		clubParams.put("club_nm", club_nm);
		clubParams.put("club_gb_cd", club_gb_cd);
		clubParams.put("club_at_cd", club_at_cd);
		clubParams.put("club_cnt", 1);
		clubParams.put("club_aim", club_aim);
		clubParams.put("club_active", club_active);
		clubParams.put("club_room", club_room);
		clubParams.put("open_dt", open_dt);
		clubParams.put("intro_file_nm", clubVO.getIntro_file_nm());
		clubParams.put("intro_save_file_nm", clubVO.getIntro_save_file_nm());
		clubParams.put("poster_file_nm", clubVO.getPoster_file_nm());
		clubParams.put("poster_save_file_nm", clubVO.getPoster_save_file_nm());
		clubParams.put("register_cd", "008003");

		try {
			clubService.createClub(clubParams);
		} catch (Exception e) {
			System.err.println("[createClubAction.do] create club error :" + e.getMessage());
			CommonUtils.showAlert(response, "클럽 생성 오류", "index.do");
			return null;
		}
		
		Map<String, Object> memberParams = new HashMap<String, Object>();
		Date dt = new java.util.Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String today = sdf.format(dt);
		System.err.println("[createClubAction.do] today: " + today);
		System.err.println("[createClubAction.do] userVO.getGender(): " + userVO.getGender());
		
		memberParams.put("id", user_id);
		memberParams.put("staff_cd", "004001");
		memberParams.put("join_dt", today);
		memberParams.put("name", userVO.getName());
		memberParams.put("major", userVO.getMajor());
		memberParams.put("grade", userVO.getGrade());
		
		if(userVO.getGender().equals("1"))
			memberParams.put("gender_cd", "003001");
		else
			memberParams.put("gender_cd", "003002");
		
		/* 추후 제거 */
		if(userVO.getPhoneNumber() == null)
			memberParams.put("phone_no", "");
		else
			memberParams.put("phone_no", userVO.getPhoneNumber());
		
		if(userVO.getE_mail() == null)
			memberParams.put("email", "");
		else
			memberParams.put("email", userVO.getE_mail());
		
		try {
			clubMemberService.addClubMember(memberParams);
		} catch (Exception e) {
			System.err.println("[createClubAction.do] create clubmember error :" + e.getMessage());
			CommonUtils.showAlert(response, "clubmember 생성 오류", "index.do");
			return null;
		}
			
		CommonUtils.showAlert(response, "동아리 개설 신청 완료", "index.do");
		return null;
	}

}
