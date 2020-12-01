package hallym.club.activity.web;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import hallym.club.activity.service.ActivityService;
import hallym.club.activity.vo.ActivityVO;
import hallym.club.board.service.BoardService;
import hallym.club.club.service.ClubService;
import hallym.club.club.vo.ClubVO;
import hallym.club.clubmember.service.ClubMemberService;
import hallym.club.common.service.CommonService;
import hallym.club.exception.ClubNotExistException;
import hallym.club.file.service.FileService;
import hallym.club.file.service.ActFileService;
import hallym.club.file.vo.ActFileVO;
import hallym.club.user.service.UserService;
import hallym.club.user.vo.UserVO;
import hallym.club.utils.CommonUtils;

@Controller
public class ActivityController {

	@Resource(name = "userService")
	private UserService userService;

	@Resource(name = "clubService")
	private ClubService clubService;
	
	@Resource(name = "clubMemberService")
	private ClubMemberService clubMemberService;
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@Resource(name = "fileService")
	private FileService fileService;
	
	@Resource(name = "actFileService")
	private ActFileService actFileService;
	
	@Resource(name = "commonService")
	private CommonService commonService;
	
	@Resource(name = "activityService")
	private ActivityService activityService;
	
	/*
	 * @RequestMapping(value="/clubActivityList.do")
	 * 교내 활동
	 * 교내 활동 리스트
	 * @RequestParam 
	 * @RequestParam 
	*/
	@RequestMapping(value="/clubActivityList.do")
	public ModelAndView clubActivityList(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false) String club_id,
							 @RequestParam(value = "act_cd", required = false) String act_cd,
							 @RequestParam(value = "act_kind_cd", required = false, defaultValue="016") String act_kind_cd,
							 @RequestParam(value = "select", required = false, defaultValue="1") int select,
							 @RequestParam(value = "page", required = false, defaultValue="1") String page,
							 @RequestParam(value = "cdn", required = false, defaultValue="") String cdn) {
		
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
		
		int activityListCount = 1;
		int limit = 5;
		int currPage = Integer.parseInt(page);
		currPage = (currPage < 1)?1:currPage;
		int prevPage = 1;
		int nextPage = 1;
		int totalPage = 1;
		int startNum = 1; // 범위 시작
		int endNum = 1; // 범위 끝	
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		params.put("act_cd", act_cd);
		params.put("act_kind_cd",act_kind_cd);
		params.put("select", select);
		params.put("cdn", cdn);
		params.put("club_id", club_id);
		params.put("limit", limit);
		
		
		activityListCount = activityService.getActivityListCnt(params);
		totalPage = activityService.getTotalPageCnt(params); 
		
		/* 페이지 번호에 따른 가져올 게시글 범위 */
		if(totalPage <= 1) {
			startNum = 1;
			endNum = (activityListCount < limit) ? activityListCount:limit;
			currPage = 1;
			prevPage = currPage;
			nextPage = currPage;
		} else {
			startNum = (currPage * limit) - limit + 1;
			endNum = currPage * limit;
			prevPage = currPage - 1;
			prevPage = (prevPage < 1) ? 1: prevPage;
			nextPage = (activityListCount > endNum) ? (currPage+1):currPage;
		}
		
		params.put("startNum", startNum);
		params.put("endNum", endNum);
		
		List<ActivityVO> activityList = activityService.getActivityList(params);

		params = new HashMap<String, Object>();
		for(ActivityVO activityVO : activityList) {
			switch (activityVO.getAct_kind_cd()) {
			case "016001":
				activityVO.setAct_kind_cd("일반");
				break;
			case "016002":
				activityVO.setAct_kind_cd("수상");
				break;
			}
			params.put("club_id", club_id);
			params.put("act_cd", activityVO.getAct_cd());
			params.put("act_no", activityVO.getAct_no());
			params.put("opt", 2);
			
			if(actFileService.getFileListCnt(params) > 0)
				activityVO.setAttach_yn("Y");
			else
				activityVO.setAttach_yn("N");
			
		}
		mav.addObject("totalPage", totalPage);
		mav.addObject("activityListCount", activityListCount);

		mav.addObject("condition", cdn);
		mav.addObject("prevPage", prevPage);
		mav.addObject("currPage", currPage);
		mav.addObject("nextPage", nextPage);
		
		mav.addObject("isStaff", isStaff);
		mav.addObject("club_id", club_id);
		mav.addObject("club_name", clubVO.getClub_nm());
		mav.addObject("act_cd", act_cd);
		mav.addObject("act_kind_cd", act_kind_cd);
		mav.addObject("select", select);
		mav.addObject("activityList", activityList);
		mav.setViewName("community/activity/index");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/clubActivityRead.do")
	 * 교내 활동
	 * 교내 활동 
	 * @RequestParam 
	 * @RequestParam 
	*/
	@RequestMapping(value="/clubActivityRead.do")
	public ModelAndView clubActivityRead(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false) String club_id,
							 @RequestParam(value = "act_cd", required = false) String act_cd,
							 @RequestParam(value = "act_no", required = false) int act_no) {
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		if(club_id == null)
			club_id = (String) session.getAttribute("club_id");
		session.setAttribute("club_id", club_id);
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
		params.put("act_cd", act_cd);
		params.put("act_no", act_no);
		
		ActivityVO activityVO = activityService.getActivity(params);
		switch (activityVO.getAct_kind_cd()) {
		case "016001":
			activityVO.setAct_kind_cd("일반");
			break;
		case "016002":
			activityVO.setAct_kind_cd("수상");
			break;
		}
		
		boolean isMyWrite = false;
		if (userVO.getId().equals(activityVO.getInput_id()) || userVO.getId().equals(activityVO.getUpdate_id()))
			isMyWrite = true;

		params.put("act_no", act_no-1);
		ActivityVO prevActivityVO = activityService.getActivity(params);

		params.put("act_no", act_no+1);
		ActivityVO nextActivityVO = activityService.getActivity(params);
		
		/* file x */
		params.put("act_no", act_no);
		params.put("opt", 2);
		List<ActFileVO> originalFileList = null;
		List<ActFileVO> fileList = new ArrayList<ActFileVO>();
		int fileListCnt = actFileService.getFileListCnt(params);
		
		if(fileListCnt > 0) {
			originalFileList = actFileService.getFileList(params);
			
			for(ActFileVO v : originalFileList) {
				fileList.add(v);
			}
		}
		
		mav.addObject("fileList", fileList);
		mav.addObject("fileListCnt", fileListCnt);
		
		mav.addObject("isStaff", isStaff);
		mav.addObject("isMyWrite", isMyWrite);
		
		mav.addObject("club_id", club_id);
		mav.addObject("act_cd", act_cd);
		mav.addObject("act_no", act_no);
		mav.addObject("activityVO", activityVO);
		mav.addObject("prevActivityVO", prevActivityVO);
		mav.addObject("nextActivityVO", nextActivityVO);
		mav.setViewName("community/activity/activityRead");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/clubActivityWrite.do")
	 * 교내 활동
	 * 교내 활동 수정
	 * @RequestParam 
	 * @RequestParam 
	*/
	@RequestMapping(value="/clubActivityWrite.do")
	public ModelAndView clubActivityWrite(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false) String club_id,
							 @RequestParam(value = "act_cd", required = false) String act_cd) {
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		if(club_id == null)
			club_id = (String) session.getAttribute("club_id");
		session.setAttribute("club_id", club_id);
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}
		
		boolean isStaff = true;
		
		if(!(staff_cd.equals("004001") || staff_cd.equals("004002"))) {
			CommonUtils.showAlertHistoryBack(response, "권한이 없습니다.");
			isStaff = false;
			return null;
		}
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		params.put("act_cd", act_cd);
		
		mav.addObject("isStaff", isStaff);
		mav.addObject("club_id", club_id);
		mav.addObject("act_cd", act_cd);
		mav.setViewName("community/activity/activityWrite");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/clubActivityWriteAction.do")
	 * 교내 활동
	 * 교내 활동 수정
	 * @RequestParam 
	 * @RequestParam 
	*/
	@RequestMapping(value="/clubActivityWriteAction.do")
	public ModelAndView clubActivityWriteAction(MultipartHttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false) String club_id,
							 @RequestParam(value = "act_cd", required = false) String act_cd,
							 @RequestParam(value = "act_kind_cd", required = false) String act_kind_cd,
							 @RequestParam(value = "act_date", required = false) String act_date,
							 @RequestParam(value = "act_title", required = false) String act_title,
							 @RequestParam(value = "act_place", required = false) String act_place,
							 @RequestParam(value = "act_cnt", required = false) String act_cnt,
							 @RequestParam(value = "act_contents", required = false) String act_contents,
							 @RequestParam(value = "act_temp", required = false) String act_temp) {
		
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
		
		if(!(staff_cd.equals("004001") || staff_cd.equals("004002"))) {
			CommonUtils.showAlertHistoryBack(response, "권한이 없습니다.");
			return null;
		}
		
        List<ActFileVO> recentFiles = new ArrayList<ActFileVO>();
        ActivityVO recentBoard = null;
        // 넘어온 파일을 리스트로 저장
		List<MultipartFile> mpList = request.getFiles("attachFile"); // attachFile로 넘어온 파일을 가져옴
		boolean isExistThumbnail = false;
		try {
			if(mpList.size() < 1 || mpList.isEmpty()) {
				// 업로드할 파일 없음
			} else {
				int mpIndex = 0;
				for(MultipartFile multipartFile : mpList) {
					if(multipartFile.getOriginalFilename().equalsIgnoreCase("")) {
						continue;
					}
					
					String path = CommonUtils.SAVE_PATH;
					path += CommonUtils.getTimeBasePath();
					
					/* 업로드할 폴더 체크 */
					File dir = new File(path);
			        if (!dir.isDirectory()) { // 폴더가 없다면 생성
			            dir.mkdirs(); // 폴더 생성
			        }
					
	                String genId = CommonUtils.getRandomString(); // 파일명 중복 방지
	                String originalfileName = multipartFile.getOriginalFilename(); // 원본 파일명
	                String saveFileName = genId + "." + CommonUtils.getExtension(originalfileName); // 서버에 저장될 파일명
	                String savePath = path + "/" + saveFileName; // 서버에 저장된 파일 경로
	                String hash = CommonUtils.getSHA256(multipartFile.getBytes()); // SHA-256 해쉬 알고리즘
	                multipartFile.transferTo(new File(savePath)); // 서버에 파일 저장
	                
	                /* 무결성 검사 시작 */
	                boolean isIntegrity = false;
	                File up = new File(savePath);
	                if(up.exists()) {
	                	if(CommonUtils.getSHA256(Files.readAllBytes(up.toPath())).equals(hash)) {
	                		isIntegrity = true; // 무결성 확인 완료
	                	} else {
	                		up.delete(); // 손상된 파일 삭제
	                	}
	                }
	                
	            	if(isIntegrity) { // 무결성 체크 완료
		                Map<String, Object> params = new HashMap<String, Object>();
		    			params.put("club_id", club_id);
		    			params.put("act_cd", act_cd);
		    			params.put("act_no", 0);
						params.put("file_nm", originalfileName);
						params.put("file_save_nm", saveFileName);
						params.put("file_path", savePath);
						params.put("enclude_yn", "N");
						params.put("input_id", userVO.getId());
						params.put("input_ip", CommonUtils.getClientIP(request));
	//					params.put("hash", hash);
						actFileService.addFile(params);
						params.put("opt", 1);
						recentFiles.add(actFileService.getFile(params));
	                }
	            	mpIndex++;
				}
			}
			
			Map<String, Object> params = new HashMap<String, Object>();
			Date today = new Date();
			params.put("club_id", club_id);
			params.put("act_cd", act_cd);
			params.put("act_kind_cd", act_kind_cd);
			params.put("act_title", act_title);
			params.put("act_contents", act_contents);
			params.put("act_temp", act_temp);
			params.put("act_place", act_place);
			params.put("act_date", act_date);
			params.put("act_cnt", act_cnt);
			params.put("accept_cd", "017003");
			
			params.put("input_id", userVO.getId());
			params.put("input_ip", CommonUtils.getClientIP(request));
			params.put("input_date", today);
		
		
			activityService.addActivity(params);
			
			/* 첨부파일 등록 */
			params = new HashMap<String, Object>();
			params.put("club_id", club_id);
			params.put("act_cd", act_cd);
			params.put("opt", 1);

			recentBoard = activityService.getActivity(params);
			
			if(recentFiles != null && !recentFiles.isEmpty() && recentBoard != null) {
				for (ActFileVO f : recentFiles) {
					params.put("club_id", club_id);
					params.put("file_no", f.getFile_no());
					params.put("act_no", recentBoard.getAct_no());
					actFileService.attachFile(params);
				}
			}
			
			CommonUtils.showAlert(response, "정상적으로 작성되었습니다.",
					"/clubActivityList.do?club_id=" + club_id + "&act_cd=" + act_cd);
		}catch (Exception e) {
			System.err.println("[clubActivityWriteAction.do] err: " + e.getMessage());
			CommonUtils.showAlert(response, "오류가 발생했습니다.",
					"/clubActivityList.do?club_id=" + club_id + "&act_cd=" + act_cd);
		}
		return null;
	}
	
	/*
	 * @RequestMapping(value="/clubActivityUpdate.do")
	 * 교내 활동
	 * 교내 활동 수정
	 * @RequestParam 
	 * @RequestParam 
	*/
	@RequestMapping(value="/clubActivityUpdate.do")
	public ModelAndView clubActivityUpdate(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false) String club_id,
							 @RequestParam(value = "act_cd", required = false) String act_cd,
							 @RequestParam(value = "act_no", required = false) int act_no) {
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		/* 사용자 권한 */
		Map<String, Object> memberParams = new HashMap<String, Object>();
		if(club_id == null)
			club_id = (String) session.getAttribute("club_id");
		session.setAttribute("club_id", club_id);
		memberParams.put("club_id", club_id);
		memberParams.put("id", userVO.getId());
		String staff_cd = clubMemberService.getStaffCD(memberParams);

		if (staff_cd == null) {
			CommonUtils.showAlert(response, "가입된 동아리가 아닙니다.", "index.do");
			return null;
		}

		boolean isStaff = true;
		
		if(!(staff_cd.equals("004001") || staff_cd.equals("004002"))) {
			CommonUtils.showAlertHistoryBack(response, "권한이 없습니다.");
			isStaff = false;
			return null;
		}
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		params.put("act_cd", act_cd);
		params.put("act_no", act_no);
		
		ActivityVO activityVO = activityService.getActivity(params);

		switch (activityVO.getAct_kind_cd()) {
		case "016001":
			activityVO.setAct_kind_cd("일반");
			break;
		case "016002":
			activityVO.setAct_kind_cd("수상");
			break;
		}
		
		/* 파일 x */
		params.put("opt", 2);
		List<ActFileVO> originalFileList = null;
		List<ActFileVO> fileList = new ArrayList<ActFileVO>();
		int fileListCnt = actFileService.getFileListCnt(params);
		if(fileListCnt > 0) {
			originalFileList = actFileService.getFileList(params);
			
			for(ActFileVO v : originalFileList) {
				fileList.add(v);
			}
		}
		
		mav.addObject("club_id", club_id);
		mav.addObject("act_cd", act_cd);
		mav.addObject("act_no", act_no);
		mav.addObject("activityVO", activityVO);
		mav.addObject("isStaff", isStaff);
		
		mav.addObject("fileList", fileList);
		mav.addObject("fileListCnt", fileListCnt);
		mav.setViewName("community/activity/activityUpdate");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/clubActivityUpdateAction.do")
	 * 교내 활동
	 * 교내 활동 수정
	 * @RequestParam 
	 * @RequestParam 
	*/
	@RequestMapping(value="/clubActivityUpdateAction.do")
	public ModelAndView clubActivityUpdateAction(MultipartHttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false) String club_id,
							 @RequestParam(value = "act_cd", required = false) String act_cd,
							 @RequestParam(value = "act_no", required = false) int act_no,
							 @RequestParam(value = "act_kind_cd", required = false) String act_kind_cd,
							 @RequestParam(value = "act_date", required = false) String act_date,
							 @RequestParam(value = "act_title", required = false) String act_title,
							 @RequestParam(value = "act_place", required = false) String act_place,
							 @RequestParam(value = "act_cnt", required = false) String act_cnt,
							 @RequestParam(value = "act_contents", required = false) String act_contents,
							 @RequestParam(value = "act_temp", required = false) String act_temp,
							 @RequestParam(value = "deleteAttach", required = false) List<String> delAttachs) throws IOException {
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
		
		if(!(staff_cd.equals("004001") || staff_cd.equals("004002"))) {
			CommonUtils.showAlertHistoryBack(response, "권한이 없습니다.");
			return null;
		}
		
		try {
			Date today = new Date();
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("club_id", club_id);
			params.put("act_cd", act_cd);
			params.put("act_no", act_no);
			int cnt = actFileService.getFileListCnt(params);
			boolean isPhotoBoard = false;
			
			/* 첨부파일 삭제 */
			if(delAttachs != null) {
				for(String fn : delAttachs) {
					params.put("file_no", fn);

					ActFileVO fileVO = actFileService.getFile(params);
					File dir = new File(fileVO.getFile_path());
					if (!dir.isDirectory() && dir.exists()) { // 파일 존재 여부 확인
			            if(dir.delete()) {
			            	actFileService.deleteFile(params);
			            	cnt--;
			            } else {
			            	CommonUtils.showAlert(response, "파일 삭제 오류", "/clubActivityRead.do?club_id=" + club_id + "&act_cd=" + act_cd + "&act_no=" + act_no);
			            	return null;
			    		}
					} else {
						CommonUtils.showAlert(response, "잘못된 접근입니다.", "/clubActivityRead.do?club_id=" + club_id + "&act_cd=" + act_cd + "&act_no=" + act_no);
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
					path += CommonUtils.getTimeBasePath();
					
					/* 업로드할 폴더 체크 */
					File dir = new File(path);
			        if (!dir.isDirectory()) { // 폴더가 없다면 생성
			            dir.mkdirs(); // 폴더 생성
			        }
			        
	                String genId = CommonUtils.getRandomString(); // 파일명 중복 방지
	                String originalfileName = multipartFile.getOriginalFilename(); // 원본 파일명
	                String saveFileName = genId + "." + CommonUtils.getExtension(originalfileName); // 서버에 저장될 파일명
	                String savePath = path + "/" + saveFileName; // 서버에 저장된 파일 경로
	                String hash = CommonUtils.getSHA256(multipartFile.getBytes()); // SHA-256 해쉬 알고리즘
	                multipartFile.transferTo(new File(savePath)); // 서버에 파일 저장
	                
	                /* 무결성 검사 시작 */
	                boolean isIntegrity = false;
	                File up = new File(savePath);
	                if(up.exists()) {
	                	if(CommonUtils.getSHA256(Files.readAllBytes(up.toPath())).equals(hash)) {
	                		isIntegrity = true; // 무결성 확인 완료
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
						actFileService.addFile(params);
						
					}
	            	mpIndex++;
				}
			}
			
			params.put("act_kind_cd", act_kind_cd);
			params.put("act_title", act_title);
			params.put("act_contents", act_contents);
			params.put("act_temp", act_temp);
			params.put("act_place", act_place);
			params.put("act_date", act_date);
			params.put("act_cnt", act_cnt);
			
			params.put("update_id", userVO.getId());
			params.put("update_ip", CommonUtils.getClientIP(request));
			params.put("update_date", today);

		
			activityService.updateActivity(params);
			CommonUtils.showAlert(response, "정상적으로 수정되었습니다.",
					"/clubActivityRead.do?club_id=" + club_id + "&act_cd=" + act_cd + "&act_no=" + act_no);
		}catch (Exception e) {
			System.err.println("[clubActivityUpdateAction.do] err: " + e.getMessage());
			CommonUtils.showAlert(response, "오류로 인해 정상적으로 작성되지 못했습니다.",
					"/clubActivityList.do?club_id=" + club_id + "&act_cd=" + act_cd);
		}
		return null;
	}
	
	/*
	 * @RequestMapping(value="/clubActivityUpdateAction.do")
	 * 교내 활동
	 * 교내 활동 수정
	 * @RequestParam 
	 * @RequestParam 
	*/
	@RequestMapping(value="/clubActivityDeleteAction.do")
	public ModelAndView clubActivityDeleteAction(HttpServletRequest request, HttpServletResponse response,
							 ModelAndView mav,
							 @RequestParam(value = "club_id", required = false) String club_id,
							 @RequestParam(value = "act_cd", required = false) String act_cd,
							 @RequestParam(value = "act_no", required = false) int act_no) {
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
		
		if(!(staff_cd.equals("004001") || staff_cd.equals("004002"))) {
			CommonUtils.showAlertHistoryBack(response, "권한이 없습니다.");
			return null;
		}
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("club_id", club_id);
		params.put("act_cd", act_cd);
		params.put("act_no", act_no);
		
		try {
			activityService.deleteActivity(params);
			CommonUtils.showAlert(response, "정상적으로 삭제되었습니다.",
					"/clubActivityList.do?club_id=" + club_id + "&act_cd=" + act_cd);
		}catch (Exception e) {
			System.err.println("[clubActivityUpdateAction.do] err: " + e.getMessage());
			CommonUtils.showAlert(response, "오류로 인해 정상적 작동 되지 못했습니다.",
					"/clubActivityList.do?club_id=" + club_id + "&act_cd=" + act_cd);
		}
		return null;
	}
	

}
