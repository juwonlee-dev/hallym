package hallym.club.club.web;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.jms.Session;
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
import hallym.club.budget.service.BudgetService;
import hallym.club.budget.vo.BudgetVO;
import hallym.club.club.service.ClubService;
import hallym.club.club.vo.ClubVO;
import hallym.club.clubmember.service.ClubMemberService;
import hallym.club.clubmember.vo.ClubMemberVO;
import hallym.club.common.service.CommonService;
import hallym.club.exception.ClubExistException;
import hallym.club.exception.ClubNotExistException;
import hallym.club.exception.UserNotExistException;
import hallym.club.file.service.FileService;
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

	
	/*
	 * 동아리 커뮤니티
	 * 동아리 - 소개
	 * @RequestMapping(value="/clubIntro.do")
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
		System.err.println("[clubIntro.do] Intro_save_file: " + clubVO.getIntro_save_file_nm());
		System.err.println("[clubIntro.do] poster_save_file: " + clubVO.getPoster_save_file_nm());
		System.err.println("[clubIntro.do] staff_cd: " + staff_cd);
		System.err.println("[clubIntro.do] isStaff: " + isStaff);
		
		/* clubPlatform */
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("open_dt", clubVO.getOpen_dt());
		mav.addObject("president_nm", clubVO.getPresident());
		mav.addObject("isStaff", isStaff);
		mav.addObject("club_intro", clubVO.getIntro_save_file_nm());
		mav.addObject("club_poster", clubVO.getPoster_save_file_nm());
		
		mav.setViewName("club/clubIntro");
		return mav;
	}
	
	/*
	 * 동아리 커뮤니티
	 * 동아리 - 물품목록
	 * 권한 - 총무 이상 이용 가능
	 * @RequestMapping(value="/clubProduct.do")
	 * @RequestParam club_id
	*/
	@RequestMapping(value="/clubProduct.do")
	public ModelAndView clubProduct(HttpServletRequest request, HttpServletResponse response,
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

		boolean isStaff = false;
		
		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}
		
		if(staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;
		System.err.println("[clubProduct.do] Intro_save_file: " + clubVO.getIntro_save_file_nm());
		System.err.println("[clubProduct.do] poster_save_file: " + clubVO.getPoster_save_file_nm());
		System.err.println("[clubProduct.do] staff_cd: " + staff_cd);
		System.err.println("[clubProduct.do] isStaff: " + isStaff);

		/* 물품목록 */
		Map<String, Object> productParams = new HashMap<String, Object>();
		productParams.put("club_id", club_id);
		List<ProductVO> productList = productService.getProducts(productParams);
		
		/* clubPlatform */
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("open_dt", clubVO.getOpen_dt());
		mav.addObject("president_nm", clubVO.getPresident());
		mav.addObject("isStaff", isStaff);
		mav.addObject("club_intro", clubVO.getIntro_save_file_nm());
		mav.addObject("club_poster", clubVO.getPoster_save_file_nm());
		
		/* clubProduct */
		mav.addObject("productList", productList);
		mav.setViewName("club/clubProduct");
		return mav;
	}
	
	/*
	 * 동아리 커뮤니티
	 * 동아리 - 물품목록 (동작)
	 * 권한 - 총무 이상 이용 가능
	 * @RequestMapping(value="/clubProductAction.do")
	 * @RequestParam club_id, product_nm, tot_cnt, product_cont
	*/
	@RequestMapping(value="/clubProductAction.do")
	public ModelAndView clubProductAction(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "product_nm", required = false) String[] product_nm,
							 @RequestParam(value = "tot_cnt", required = false) String[] tot_cnt,
							 @RequestParam(value = "product_cont", required = false) String[] product_cont) {
	
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
					productVO.setProductCont(product_nm[i]);
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
				productService.insertProduct(productParams);
			}
			
		}
		
		mav.setViewName("redirect:/clubProduct.do?club_id="+club_id);
		return mav;
	}
	
	/*
	 * 동아리 커뮤니티
	 * 동아리 - 예산 
	 * 권한 - 총무 이상 이용 가능
	 * @RequestMapping(value="/clubBudget.do")
	 * @RequestParam club_id, io_gb_cd
	*/
	@RequestMapping(value="/clubBudget.do")
 	public ModelAndView clubBudget(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "io_gb_cd", required = false, defaultValue ="009001") String io_gb_cd)
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
		System.err.println("[clubBudget.do] Intro_save_file: " + clubVO.getIntro_save_file_nm());
		System.err.println("[clubBudget.do] poster_save_file: " + clubVO.getPoster_save_file_nm());
		System.err.println("[clubBudget.do] staff_cd: " + staff_cd);
		System.err.println("[clubBudget.do] isStaff: " + isStaff);
		
		
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		params.put("io_gb_cd", io_gb_cd);
		params.put("opt", 0);
		List<BudgetVO> budgetList = budgetService.getBudget(params);
		String totalPrice = budgetService.getTotal(params);
		System.err.println("[clubBudget.do] io_gb_cd: " + io_gb_cd);
		for(BudgetVO budgetVO : budgetList) {
			System.err.println("[clubBudget.do]  budgetVO.getUse_dt(): " + budgetVO.getUse_dt());
			System.err.println("[clubBudget.do] budgetVO.getContents(): " + budgetVO.getContents());
			System.err.println("[clubBudget.do] budgetVO.getPrice(): " + budgetVO.getPrice());
		}
		
		System.err.println("[clubBudget.do] totalPrice: " + totalPrice);
		
		/* clubPlatform */
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("open_dt", clubVO.getOpen_dt());
		mav.addObject("president_nm", clubVO.getPresident());
		mav.addObject("isStaff", isStaff);
		mav.addObject("club_intro", clubVO.getIntro_save_file_nm());
		mav.addObject("club_poster", clubVO.getPoster_save_file_nm());
		
		/* clubBudget */
		session.setAttribute("budgetList", budgetList);
		session.setAttribute("totalPrice", totalPrice);
		mav.addObject("budgetList", budgetList);
		mav.addObject("totalPrice", totalPrice);
		mav.setViewName("club/clubBudget");
		return mav;
	}
	
	/*
	 * 동아리 커뮤니티
	 * 동아리 - 예산 
	 * 권한 - 총무 이상 이용 가능
	 * @RequestMapping(value="/clubBudgetAction.do")
	 * @RequestParam club_id, io_gb_cd, use_dt, contents, price
	*/
	@RequestMapping(value="/clubBudgetAction.do")
 	public ModelAndView clubBudgetAction(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "io_gb_cd", required = false) String io_gb_cd,
							 @RequestParam(value = "use_dt", required = false ) String[] use_dt,
							 @RequestParam(value = "contents", required = false) String[] contents,
							 @RequestParam(value = "price", required = false) String[] price)
	{
		System.err.println("[clubBudgetAction.do] io_gb_cd: " + io_gb_cd);

		try {

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
			System.err.println("[clubBudgetAction.do]  use_dt.length: " + use_dt.length);
			params.put("club_id", club_id);
			params.put("io_gb_cd", io_gb_cd);
			budgetService.deleteBudget(params);
			for (int i = 0; i < use_dt.length; i++) {
				System.err.println("[clubBudgetAction.do] use_dt[" + i + "] " + use_dt[i]);
			}
			for (int i = 0; i < price.length - 1; i++) {
				BudgetVO vo = new BudgetVO();
				if (use_dt[i] == "" || use_dt[i] == null)
					break;

				use_dt[i] = use_dt[i].replaceAll("\\-", "");
				vo.setUse_dt(use_dt[i]);
				if (price[i] == null || price[i].trim().equals("")) {
					break;
				}
				System.err.println("[clubBudgetAction.do] price[" + i + "]: " + price[i]);
				int tmp_price = Integer.parseInt(price[i].replaceAll("\\,", ""));
				vo.setPrice(tmp_price);
				vo.setContents(contents[i]);

				params.put("use_dt", vo.getUse_dt());
				params.put("contents", vo.getContents());
				params.put("price", vo.getPrice());
				budgetService.insertBudget(params);

			}

			CommonUtils.showAlert(response, "정상적으로 저장되었습니다.", "/clubBudget.do?club_id=" + club_id);
			return null;
		} catch (Exception e) {
			System.err.println("[clubBudgetAction.do] SAVE ERROR: " + e.getMessage());
			CommonUtils.showAlert(response, "저장에 실패했습니다.", "/clubBudget.do?club_id=" + club_id);
			return null;
		}
	}
	
	/*
	 * 동아리 커뮤니티
	 * 동아리 - 예산
	 * @RequestMapping(value="/clubBudgetTotal.do")
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
		String incomeTotalPrice = budgetService.getTotal(incomeParams);
		
		Map<String, Object> expenseParams = new HashMap<String, Object>();
		expenseParams.put("club_id", club_id);
		expenseParams.put("io_gb_cd", "009002");
		expenseParams.put("opt", 1);
		expenseParams.put("use_dt", use_dt);
		
		List<BudgetVO> expenseList = budgetService.getBudget(expenseParams);
		String expenseTotalPrice = budgetService.getTotal(expenseParams);
		
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
	 * 동아리 커뮤니티
	 * 동아리 - 회원목록
	 * @RequestMapping(value="/clubMemberList.do")
	 * @RequestParam club_id, category, search, page(pageNumber)
	*/
	@RequestMapping(value="/clubMemberList.do")
	public ModelAndView clubMemberList(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "category", required = false, defaultValue ="name") String category,
							 @RequestParam(value = "search", required = false, defaultValue ="") String search,
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
		params.put("category", category);
		params.put("search", search);
		params.put("limit", limit);
		params.put("search", search);
		System.err.println("[clubMemberList.do] search: " + search);
		
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
		params.put("category", category);
		params.put("search", search);
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
		System.err.println("[clubManageList.do] clubList: \n" + clubMemberList);
		System.err.println("[clubManageList.do] clubListCount: " + memberListCount);
		System.err.println("[clubManageList.do] totalPage: " + totalPage);
		
		
		/* clubPlatform */
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("open_dt", clubVO.getOpen_dt());
		mav.addObject("president_nm", clubVO.getPresident());
		mav.addObject("isStaff", isStaff);
		mav.addObject("club_intro", clubVO.getIntro_save_file_nm());
		mav.addObject("club_poster", clubVO.getPoster_save_file_nm());
		
		/* clubManageList */
		mav.addObject("search", search);
		mav.addObject("totalPage", totalPage);
		mav.addObject("prevPage", prevPage);
		mav.addObject("currPage", currPage);
		mav.addObject("nextPage", nextPage);
		mav.addObject("memberList", clubMemberList);
		mav.addObject("memberListCount", memberListCount);

		/*  clubMemberList */
		mav.addObject("memberList", clubMemberList);
		mav.setViewName("club/clubMemberList");
		return mav;
	}
	
	
	/*
	 * 동아리 커뮤니티
	 * 게시판 - 리스트
	 * @RequestMapping(value="/clubBoardList.do")
	 * @RequestParam club_id, board_cd(bdc), page, cdn
	*/
	@RequestMapping(value="/clubBoardList.do")
	public ModelAndView clubBoardList(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false) String club_id,
							 @RequestParam(value = "board_cd", required = false) String bdc,
							 @RequestParam(value = "page", required = false, defaultValue = "1") String page,
							 @RequestParam(value = "cdn", required = false, defaultValue = "") String cdn) {
		response.setContentType("text/html; charset=UTF-8");
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
		System.err.println("[clubBoardList.do] Intro_save_file: " + clubVO.getIntro_save_file_nm());
		System.err.println("[clubBoardList.do] poster_save_file: " + clubVO.getPoster_save_file_nm());
		System.err.println("[clubBoardList.do] staff_cd: " + staff_cd);
		System.err.println("[clubBoardList.do] isStaff: " + isStaff);
		
		/* 게시판  */
		List<BoardVO> boardList = null;
		ArrayList<UserVO> writerList = new ArrayList<UserVO>();
		ArrayList<String> writerAuthList = new ArrayList<String>();
		
		int available = 1;
		String board_cd = null;
		String headTitle = null;

		System.err.println("[clubBoardList.do] club_id: " + club_id);
		System.err.println("[clubBoardList.do] bdc: " + bdc);
		if(bdc != null) {
			board_cd = bdc;
			if(board_cd.equals("007001"))
				headTitle = "공지사항";
			else if(board_cd.equals("007002"))
				headTitle = "자유게시판";
			else if(board_cd.equals("007003"))
				headTitle = "사진";
			else if(board_cd.equals("007004"))
				headTitle = "일정";
			else
				headTitle = "ERROR";
			session.setAttribute("board_cd", board_cd);
		}
		
		board_cd = (String) session.getAttribute("board_cd");
		cdn = CommonUtils.getUTF8(cdn);
		String condition = cdn; // title
		
		int boardListCount = 1;
		int limit = 5;
		int currPage = Integer.parseInt(page);
		currPage = (currPage < 1)?1:currPage;
		int prevPage = 1;
		int nextPage = 1;
		int totalPage = 1;
		int startNum = 1; // 범위 시작
		int endNum = 1; // 범위 끝	
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("available", available);
		params.put("board_cd", board_cd);
		params.put("title", condition);
		params.put("club_id", club_id);
		params.put("limit", limit);
		
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
		mav.addObject("totalPage", totalPage);
		mav.addObject("prevPage", prevPage);
		mav.addObject("currPage", currPage);
		mav.addObject("nextPage", nextPage);
		mav.addObject("writerList", writerList);
		mav.addObject("writerAuthList", writerAuthList);
		mav.addObject("clubBoardList", boardList);
		mav.addObject("boardListCount", boardListCount);
		
		mav.setViewName("club/clubBoard");
		return mav;
	}
	
	
	/*
	 * 동아리 커뮤니티
	 * 게시판 - 읽기 폼
	 * @RequestMapping(value="/clubBoardReadForm.do")
	 * @RequestParam club_id, board_cd, board_no
	*/
	@RequestMapping(value = "/clubBoardReadForm.do")
	public ModelAndView clubBoardReadForm(ModelAndView mav,
									  HttpServletRequest request, HttpServletResponse response,
									  @RequestParam(value = "club_id", required = false) String club_id,
									  @RequestParam(value = "board_cd", required = false) String board_cd,
									  @RequestParam(value = "board_no", required = false) int board_no)
	{
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");

		session.setAttribute("board_cd", board_cd);
		board_cd = (String) session.getAttribute("board_cd");
		session.setAttribute("board_no", board_no);

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("board_cd", board_cd);
		params.put("board_no", board_no);
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
		if (staff_cd.equals("004001") || staff_cd.equals("004002"))
			isStaff = true;

		boolean isMyWrite = false;
		if (userVO.getId().equals(searchBoard.getInput_id()))
			isMyWrite = true;

		System.err.println("[clubBoardReadForm.do] Intro_save_file: " + clubVO.getIntro_save_file_nm());
		System.err.println("[clubBoardReadForm.do] poster_save_file: " + clubVO.getPoster_save_file_nm());
		System.err.println("[clubBoardReadForm.do] staff_cd: " + staff_cd);
		System.err.println("[clubBoardReadForm.do] isStaff: " + isStaff);
		System.err.println("[clubBoardReadForm.do] isMyWrite: " + isMyWrite);

		/* file x */

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
		mav.addObject("searchBoard", searchBoard);
		mav.addObject("club_id", club_id);
		mav.addObject("board_cd", board_cd);
		mav.addObject("writerName", writer.getName());
		mav.addObject("isMyWrite", isMyWrite);

		mav.setViewName("club/clubBoardReadForm");
		return mav;
	}

	
	/*
	 * 동아리 커뮤니티
	 * 게시판 - 일정
	 * @RequestMapping(value="/clubCalendar.do")
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
		
		String jsonInfo = null;
		JSONArray personArray = new JSONArray();
		JSONObject personInfo = new JSONObject();
		session.setAttribute("board_cd", board_cd);
		board_cd = (String) session.getAttribute("board_cd");

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
	
		mav.setViewName("club/clubCalendar");
		return mav;
	}
	
	
	/*
	 * 동아리 커뮤니티
	 * 게시판 - 작성 폼
	 * 권한 - 임원 이상만 공지사항, 일정 게시판 등록 가능
	 * @RequestMapping(value="/clubBoardWriteForm.do")
	 * @RequestParam club_id, board_cd(bdc)
	*/
	@RequestMapping(value="/clubBoardWriteForm.do")
	public ModelAndView clubBoardWriteForm(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false) String club_id,
							 @RequestParam(value = "board_cd", required = false) String bdc) {
		response.setContentType("text/html; charset=UTF-8");
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
		mav.addObject("board_cd", bdc);
		
		mav.setViewName("club/clubBoardWriteForm");
		return mav;
	}
	
	
	/*
	 * 동아리 커뮤니티
	 * 게시판 - 작성 (동작)
	 * 권한 - 임원 이상만 공지사항, 일정 게시판 등록 가능
	 * @RequestMapping(value="/clubBoardWriteAction.do")
	 * @RequestParam club_id, title, contents, start_date, 
	 * @RequestParam end_date, writer, board_cd
	*/
	@RequestMapping(value="/clubBoardWriteAction.do")
	public ModelAndView clubBoardWriteAction(HttpServletRequest request, HttpServletResponse response,
//							MultipartHttpServletRequest mulRequest,
										ModelAndView mav,
										@RequestParam(value = "club_id", required = false) String club_id,
										@RequestParam(value = "title",  required = false) String title,
										@RequestParam(value = "contents", required = false) String contents,
										@RequestParam(value = "start_date", required = false, defaultValue = "") String start_date,
										@RequestParam(value = "end_date", required = false, defaultValue = "") String end_date,
										@RequestParam(value = "writer", required = false, defaultValue = "") String writer,
										@RequestParam(value = "board_cd", required = false) String board_cd) {
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		if(title == null || contents == null) {
        	CommonUtils.showAlertHistoryBack(response, "필수 입력 항목을 입력해야 합니다.");
        	return null;
        }
        if(title.trim().equalsIgnoreCase("") || contents.trim().equalsIgnoreCase("")) {
        	CommonUtils.showAlertHistoryBack(response, "필수 입력 항목은 빈칸으로 둘 수 없습니다.");
        	return null;
        }
        System.err.println("[clubBoardWriteAction.do] club_id: " + club_id);
        System.err.println("[clubBoardWriteAction.do] board_cd: " + board_cd);
        System.err.println("[clubBoardWriteAction.do] title: " + title);
        System.err.println("[clubBoardWriteAction.do] contents: " + contents);
        
		Date today = new Date();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		params.put("board_cd", board_cd);
		params.put("title", title); // 게시글 제목
		params.put("contents", contents); // 게시글 내용
		params.put("fix_yn", "N");
		params.put("attach_yn", "N");
		if(start_date.equals(""))
			params.put("start_date", today);
		else
			params.put("start_date", start_date);
		
		if(end_date.equals(""))
			params.put("end_date", today);
		else
			params.put("end_date", end_date);
		
		params.put("input_id", (writer.isEmpty()) ? userVO.getId() : writer); // 게시글을 작성한 사용자 ID
		params.put("input_ip", CommonUtils.getClientIP(request));
		System.err.println("[clubBoardWriteAction.do] params: " + params);
		boardService.addBoard(params);
		
        try {
        	if(! board_cd.equals("007004")) {
				CommonUtils.showAlert(response, "정상적으로 등록되었습니다.", "/clubBoardList.do?club_id="+club_id +"&board_cd="+board_cd);
				return null;
        	}
        	else {
        		CommonUtils.showAlert(response, "정상적으로 등록되었습니다.", "/clubCalendar.do?club_id="+club_id +"&board_cd="+board_cd);
				return null;
        	}
        } catch(Exception e) {
			e.printStackTrace();
			CommonUtils.showAlert(response, "등록에 실패했습니다.", "/clubBoardList.do?club_id="+club_id +"&board_cd="+board_cd);
			return null;
		}
	}
	
	
	/*
	 * 동아리 커뮤니티
	 * 게시판 - 게시판 수정 폼
	 * 권한 - 임원 이상만 공지사항, 일정 게시판 수정 가능
	 * @RequestMapping(value="/clubBoardUpdateForm.do") #
	 * @RequestParam club_id, board_no, board_cd
	*/
	@RequestMapping(value = "/clubBoardUpdateForm.do")
	public ModelAndView clubBoardUpdateForm(HttpServletRequest request, HttpServletResponse response,
			 																	ModelAndView mav,
									@RequestParam(value = "club_id", required = false) int club_id,
									@RequestParam(value = "board_no", required = false) int board_no,
									@RequestParam(value = "board_cd", required = false) String board_cd)
	{
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		session.setAttribute("board_cd", board_cd);
		board_cd = (String) session.getAttribute("board_cd");
		session.setAttribute("board_no", board_no);

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("board_cd", board_cd);
		params.put("board_no", board_no);
		boardService.increaseOpenCnt(params);
		BoardVO searchBoard =  boardService.getBoard(params);
		
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
		/* clubPlatform */
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("open_dt", clubVO.getOpen_dt());
		mav.addObject("president_nm", clubVO.getPresident());
		mav.addObject("isStaff", isStaff);
		mav.addObject("club_intro", clubVO.getIntro_save_file_nm());
		mav.addObject("club_poster", clubVO.getPoster_save_file_nm());
		
		/* clubBoardUpdateForm*/
		mav.addObject("searchBoard", searchBoard);
		mav.addObject("club_id", club_id);
		mav.addObject("board_cd", board_cd);
		mav.addObject("writerName", writer.getName());
		mav.addObject("isMyWrite", isMyWrite);
		mav.setViewName("club/clubBoardUpdateForm");
		return mav;
	}
	
	
	/*
	 * 동아리 커뮤니티
	 * 게시판 - 게시판 수정 (동작)
	 * 권한 - 임원 이상만 공지사항, 일정 게시판 수정 가능
	 * @RequestMapping(value="/clubBoardUpdateAction.do")
	 * @RequestParam club_id, board_no, title
	 * @RequestParam contents, start_date, end_date, board_cd
	*/
	@RequestMapping(value = "/clubBoardUpdateAction.do")
	public ModelAndView clubBoardUpdateAction(HttpServletRequest request, HttpServletResponse response,
																				ModelAndView mav,
									@RequestParam(value = "club_id", required = false) int club_id,
									@RequestParam(value = "board_no", required = false) int board_no,
									@RequestParam(value = "title", required = false) String title,
									@RequestParam(value = "contents", required = false) String contents,
									@RequestParam(value = "start_date", required = false, defaultValue="") String start_date,
									@RequestParam(value = "end_date", required = false, defaultValue="") String end_date,
									@RequestParam(value = "board_cd", required = false) String board_cd)
	{
		response.setContentType("text/html; charset=UTF-8");
        
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		System.err.println("[clubBoardUpdateAction.do] board_no: " + board_no);
		System.err.println("[clubBoardUpdateAction.do] club_id: " + club_id);
		System.err.println("[clubBoardUpdateAction.do] board_cd: " + board_cd);
		Date today = new Date();
		Map<String, Object> params = new HashMap<String, Object>();
		/* updateBoard */
		params.put("board_cd", board_cd);
		params.put("board_no", board_no);
		params.put("title", title);
		params.put("contents", contents);
		params.put("fix_yn", "N"); //체크박스 선택 안하면 null이 넘어옴
		params.put("attach_yn", "N");
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
		boardService.updateBoard(params);
		mav.setViewName("redirect:/clubBoardReadForm.do?board_no=" + board_no + "&club_id=" + club_id + "&board_cd=" + board_cd);
		return mav;
	}
	
	
	/*
	 * 동아리 커뮤니티
	 * 게시판 - 삭제 (동작)
	 * @RequestMapping(value="/clubBoardDeleteAction.do")
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

		boardService.deleteBoard(params);
		CommonUtils.showAlert(response, "정상적으로 삭제하였습니다.",
				"/clubBoardList.do?club_id=" + club_id + "&board_cd=" + board_cd);
		return null;

	}
	
	
	/*	
	 * 동아리 커뮤니티
	 * 동아리 관리 - 동아리 회원 승인
	 * 권한 - 임원 이상
	 * @RequestMapping(value="/clubManage.do")
	 * @RequestParam club_id, rowIndex
	*/
	@RequestMapping(value="/clubManage.do")
 	public ModelAndView clubManage(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "rowIndex", required = false, defaultValue="0") String rowIndex)
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
		System.err.println("[clubManage.do] Intro_save_file: " + clubVO.getIntro_save_file_nm());
		System.err.println("[clubManage.do] poster_save_file: " + clubVO.getPoster_save_file_nm());
		System.err.println("[clubManage.do] staff_cd: " + staff_cd);
		System.err.println("[clubManage.do] isStaff: " + isStaff);

		Map<String, Object> membersParams = new HashMap<String, Object>();
		membersParams.put("club_id", club_id);
		membersParams.put("join_cd", "008003");
		List<ClubMemberVO> memberList = null;
		memberList = clubMemberService.getClubMember(membersParams);
		membersParams.put("opt", 1);
		int memberListCount = clubMemberService.getClubMemberCnt(membersParams);
		System.err.println("[clubManage.do] rowIndex: " + rowIndex);
		System.err.println("[clubManage.do] memberListCount: " + memberListCount);
		System.err.println("[clubManage.do] memberList: " + memberList);
		
		/* clubPlatform */
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("open_dt", clubVO.getOpen_dt());
		mav.addObject("president_nm", clubVO.getPresident());
		mav.addObject("isStaff", isStaff);
		mav.addObject("club_intro", clubVO.getIntro_save_file_nm());
		mav.addObject("club_poster", clubVO.getPoster_save_file_nm());
		
		/* clubManage */
		mav.addObject("memberListCount", memberListCount);
		mav.addObject("rowIndex", rowIndex);
		
		session.setAttribute("memberList", memberList);
		mav.addObject("memberList", memberList);
		mav.setViewName("club/clubManage");
		return mav;
	}
	
	
	/*	
	 * 동아리 커뮤니티
	 * 동아리 관리 - 동아리 회원 승인
	 * 권한 - 임원 이상
	 * @RequestMapping(value="/clubManageAction.do")
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
			clubMemberService.updateClubMember(params);
			CommonUtils.showAlert(response, "정상 처리 되었습니다.", "/clubManage.do?club_id=" + club_id);
			return null;
		} else if (submit.equals("거부")) {
			params.put("club_id", club_id);
			params.put("id", student_id);
			clubMemberService.leaveClub(params);
			CommonUtils.showAlert(response, "정상 처리 되었습니다.", "/clubManage.do?club_id=" + club_id);
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
	 * 동아리 커뮤니티
	 * 동아리 관리 - 동아리 회원 관리
	 * 권한 - 임원 이상
	 * @RequestMapping(value="/clubManageList.do")
	 * @RequestParam club_id, category, search, page(pageNumber)
	*/
	@RequestMapping(value="/clubManageList.do")
 	public ModelAndView clubManageList(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id,
							 @RequestParam(value = "category", required = false, defaultValue ="name") String category,
							 @RequestParam(value = "search", required = false, defaultValue ="") String search,
							 @RequestParam(value = "page", required = false, defaultValue = "1") String pageNumber) {
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		List<ClubMemberVO> clubMemberList = null;
	
		System.err.println("[clubManageList.do] club_id: " + club_id);
		System.err.println("[clubManageList.do] category: " + category);
		System.err.println("[clubManageList.do] search: " + search);
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
		params.put("category", category);
		params.put("search", search);
		params.put("limit", limit);
		params.put("search", search);
		System.err.println("[clubManageList.do] search: " + search);
		
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
		params.put("category", category);
		params.put("search", search);
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
		System.err.println("[clubManageList.do] clubList: \n" + clubMemberList);
		System.err.println("[clubManageList.do] clubListCount: " + memberListCount);
		System.err.println("[clubManageList.do] totalPage: " + totalPage);
		
		
		/* clubPlatform */
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("open_dt", clubVO.getOpen_dt());
		mav.addObject("president_nm", clubVO.getPresident());
		mav.addObject("isStaff", isStaff);
		mav.addObject("club_intro", clubVO.getIntro_save_file_nm());
		mav.addObject("club_poster", clubVO.getPoster_save_file_nm());
		
		/* clubManageList */
		mav.addObject("search", search);
		mav.addObject("totalPage", totalPage);
		mav.addObject("prevPage", prevPage);
		mav.addObject("currPage", currPage);
		mav.addObject("nextPage", nextPage);
		mav.addObject("memberList", clubMemberList);
		mav.addObject("memberListCount", memberListCount);
		mav.setViewName("club/clubManageList");
		return mav;
	}
	
	
	/*	
	 * 동아리 커뮤니티
	 * 동아리 관리 - 동아리 정보 수정
	 * 권한 - 임원 이상
	 * @RequestMapping(value="/clubUpdate.do")
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
		mav.setViewName("club/clubUpdate");
		return mav;
	}
	
	/*	
	 * 동아리 커뮤니티
	 * 동아리 관리 - 동아리 정보 수정 (동작)
	 * 권한 - 임원 이상
	 * @RequestMapping(value="/clubUpdateAction.do")
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
	 * 동아리 커뮤니티
	 * 탈퇴 하기 (동작)
	 * 회장 탈퇴 불가
	 * @RequestMapping(value="/leaveClubAction.do")
	 * @RequestParam club_id
	*/
	@RequestMapping(value="/leaveClubAction.do")
	public ModelAndView leaveClubAction(HttpServletRequest request, HttpServletResponse response,
			 ModelAndView mav,
			 @RequestParam(value = "club_id", required = false, defaultValue ="") String club_id)
	{
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
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
	 * 동아리
	 * 조회 및 가입
	 * @RequestMapping(value="/clubSearch.do")
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
		
		if(!search.isEmpty()) {
			search = CommonUtils.getUTF8(search);
		}
		if(at_cd.equals("") || at_cd.equals("002"))
			session.setAttribute("at_cd", "002");
		else 
			session.setAttribute("at_cd", at_cd);
		
		List<ClubVO> clubList = null;
		
		int clubListCount = 1;
		int limit = 5;
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
		System.err.println("[clubSearch.do] clubList: \n" + clubList);
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
	 * 동아리
	 * 우수동아리
	 * @RequestMapping(value="/getTopClub.do")
	 * @RequestParam gb_cd, at_cd
	*/
	@RequestMapping(value="/topClub.do")
	public ModelAndView getTopClub(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "gb_cd", required = false, defaultValue ="") String gb_cd,
							 @RequestParam(value = "at_cd", required = false, defaultValue ="") String at_cd) {
		HttpSession session = request.getSession();
		if(at_cd.equals("") || at_cd.equals("002"))
			session.setAttribute("at_cd", "002001");
		else 
			session.setAttribute("at_cd", at_cd);
		List<ClubVO> clubTopList = null;
		
		int opt  = 1;
		if(at_cd.equals("002002")) 
			opt = 2;
		
		if( gb_cd.equals(""))
			gb_cd="001001";
	
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("gb_cd", gb_cd);
		params.put("opt", opt);
		
		clubTopList = clubService.getTopClub(params);
		
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
		
		mav.addObject("clubList", clubTopList);
		mav.setViewName("hallym/topClub");
		
		return mav;
	}
	
	
	/*
	 * 동아리
	 * 개설
	 * @RequestMapping(value="/createClubView.do")
	 * 
	*/
	@RequestMapping(value="/createClub.do",  method = RequestMethod.GET)
	public ModelAndView createClubView(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav) {
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
	        
		mav.addObject("user_id", userVO.getId());
		mav.setViewName("hallym/createClub");

		return mav;
	}

	
	/*
	 * 동아리
	 * 개설 (동작)
	 * @RequestMapping(value="/createClubAction.do")
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
	
		club_nm = CommonUtils.getUTF8(club_nm);
		club_aim = CommonUtils.getUTF8(club_aim);
		club_active = CommonUtils.getUTF8(club_active);
		club_room = CommonUtils.getUTF8(club_room);
		
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
		String directory = multi.getSession().getServletContext().getRealPath("/upload/club/");
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
					mFile.transferTo(new File(directory + fileSaveName));
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
					mFile.transferTo(new File(directory + fileSaveName));
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
