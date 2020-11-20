package hallym.club.board.web;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Arrays;
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


import hallym.club.board.service.BoardService;
import hallym.club.user.service.UserService;
import hallym.club.board.vo.BoardVO;
import hallym.club.common.service.CommonService;
import hallym.club.file.service.FileService;
import hallym.club.file.vo.FileVO;
import hallym.club.user.vo.UserVO;
import hallym.club.utils.CommonUtils;

@Controller
public class BoardController {
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@Resource(name = "userService")
	private UserService userService;
	
	@Resource(name = "fileService")
	private FileService fileService;
	
	@Resource(name="commonService")
	private CommonService commonService;
	
	
	/*
	 * @RequestMapping(value="/BoardSearch.do")
	 * 게시판
	 * 게시판 찾기
	 * @RequestParam bdc, page, cdn
	*/
	@RequestMapping(value = "/BoardSearch.do", produces="text/plain;charset=UTF-8")
	public ModelAndView boardSearch(HttpServletRequest request, HttpServletResponse response, ModelAndView mav,
									@RequestParam(value = "bdc", required = false) String bdc,
									@RequestParam(value = "page", required = false, defaultValue = "1") String page,
									@RequestParam(value = "cdn", required = false, defaultValue = "") String cdn) throws UnsupportedEncodingException
	{
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		List<BoardVO> boardList = null;
		ArrayList<UserVO> writerList = new ArrayList<UserVO>();
		ArrayList<String> writerAuthList = new ArrayList<String>();
		
		int available = 1;
		String board_cd = null;
		int club_id = 1;
		
		System.err.println("[BoardSearch.do] bdc: " + bdc);
		if(bdc != null) {
			if(bdc.equals("007001"))
				club_id = 1;
			board_cd = bdc;
			session.setAttribute("board_cd", board_cd);
		}
		
		board_cd = (String) session.getAttribute("board_cd");
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
			writerList.add(userService.getUserVO(params2));
			writerAuthList.add(commonService.checkAuth(params2));
		}
		
		
		
		System.err.println("[BoardSearch.do] board_cd: " + (String) session.getAttribute("board_cd"));
		System.err.println("[BoardSearch.do] cdn: " + cdn);
//		System.err.println("[BoardSearch.do] boardList: " + boardList);
		
		mav.addObject("board_cd", board_cd);
		mav.addObject("condition", condition);
		mav.addObject("totalPage", totalPage);
		mav.addObject("prevPage", prevPage);
		mav.addObject("currPage", currPage);
		mav.addObject("nextPage", nextPage);
		mav.addObject("writerList", writerList);
		mav.addObject("writerAuthList", writerAuthList);
		mav.addObject("boardList", boardList);
		mav.addObject("boardListCount", boardListCount);
		mav.setViewName("hallym/BoardListForm");
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/BoardReadForm.do")
	 * 게시판
	 * 게시글 폼
	 * @RequestParam bdc, num(board_no)
	*/
	@RequestMapping(value = "/BoardReadForm.do")
	public ModelAndView boardReadForm(ModelAndView mav, HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "bdc", required = false) String bdc,
			@RequestParam(value = "num", required = false) int board_no) {
		response.setContentType("text/html; charset=UTF-8");
		String redrt = "BoardReadForm";
		HttpSession session = request.getSession();

		String board_cd = null;
		if (bdc != null) {
			board_cd = bdc;
			session.setAttribute("board_cd", board_cd);
		}
		board_cd = (String) session.getAttribute("board_cd");
		System.err.println("[BoardReadForm.do] board_cd: " + (String) session.getAttribute("board_cd"));
		session.setAttribute("board_no", board_no);

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("board_cd", board_cd);
		params.put("board_no", board_no);
		params.put("club_id", 1);
		boardService.increaseOpenCnt(params);
		BoardVO searchBoard = boardService.getBoard(params);

		Map<String, Object> params2 = new HashMap<String, Object>();
		params2.put("ID", searchBoard.getInput_id());
		UserVO writer = userService.getUserVO(params2);
		String writerAuth = commonService.checkAuth(params2);

		String editorAuth = null;
		UserVO editor = null;
		if (searchBoard.getUpdate_id() != null && !searchBoard.getUpdate_id().isEmpty()) {
			params2.put("ID", searchBoard.getUpdate_id());
			editor = userService.getUserVO(params2);
			editorAuth = commonService.checkAuth(params2);
		}

		params.put("board_no", board_no - 1);
		BoardVO prevBoard = boardService.getBoard(params);

		params.put("board_no", board_no + 1);
		BoardVO nextBoard = boardService.getBoard(params);

		params.put("board_no", board_no);
		params.put("opt", 2);

		List<FileVO> originalFileList = null;
		List<FileVO> fileList = new ArrayList<FileVO>();
		FileVO thumbnailFile = null;
		boolean hasThumbnail = false;
		int fileListCnt = fileService.getFileListCnt(params);

		if (fileListCnt > 0) {
			originalFileList = fileService.getFileList(params);

			for (FileVO v : originalFileList) {
				if (v.getFile_save_nm().contains("thumbnail") && v.getFile_path().contains("thumbnail")) {
					thumbnailFile = v;
					hasThumbnail = true;
				} else {
					fileList.add(v);
				}
			}
		}
		
		
		
		mav.addObject("hasThumbnail", hasThumbnail);
		mav.addObject("thumbnailFile", thumbnailFile);
		mav.addObject("fileList", fileList);
		mav.addObject("fileListCnt", (hasThumbnail) ? fileListCnt - 1 : fileListCnt);

		mav.addObject("prevBoard", prevBoard);
		mav.addObject("nextBoard", nextBoard);
		mav.addObject("searchBoard", searchBoard);
		mav.addObject("writerName", writer.getName());
		mav.addObject("editorName", (editor == null) ? null : editor.getName());
		mav.addObject("writerAuth", writerAuth);
		mav.addObject("editorAuth", editorAuth);
		mav.setViewName("hallym/" + redrt);
		return mav;

	}
	
	/*
	 * @RequestMapping(value="/BoardWriteForm.do")
	 * 게시판
	 * 게시글 작성 폼
	*/
	@RequestMapping(value = "/BoardWriteForm.do")
	public ModelAndView boardWriteForm(HttpServletRequest request, HttpServletResponse response, ModelAndView mav)
	{
//		HttpSession session = request.getSession();
//		UserVO userVO = (UserVO) session.getAttribute("userVO");
//		if(userVO == null || userVO.getId().isEmpty()) {
//			CommonUtils.showAlert(response, "로그인이 필요한 서비스입니다.","login.do");
//			return null;
//		} 
		
		
		response.setContentType("text/html; charset=UTF-8");
		mav.setViewName("hallym/BoardWriteForm");
		return mav;
	}
	
	/*  
	 * @RequestMapping(value="/BoardWriteAction.do")
	 * 게시판
	 * 게시글 작성 (동작)
	 * @RequestParam title, contents, writer, fix_yn
	*/
	@RequestMapping(value = "/BoardWriteAction.do")
	public String boardWriteAction(MultipartHttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "title", required = false) String title,
			@RequestParam(value = "contents", required = false) String contents,
			@RequestParam(value = "writer", required = false, defaultValue = "") String writer,
			@RequestParam(value = "fix_yn", required = false) String fix_yn) {
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		String board_cd = (String) session.getAttribute("board_cd");
		// String[] banList = {"007001", "007002", "007003", "007004"};
		String[] photoBoardList = { "007003" };
		
		boolean isPhotoBoard = Arrays.stream(photoBoardList).anyMatch(board_cd::equals);
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		try {
			System.err.println("[BoardWriteAction.do] title: " + title);
			System.err.println("[BoardWriteAction.do] contents: " + contents);


			if (title == null || contents == null) {
				CommonUtils.showAlertHistoryBack(response, "필수 입력 항목을 입력해야 합니다.");
				return null;
			}
			if (title.trim().equalsIgnoreCase("") || contents.trim().equalsIgnoreCase("")) {
				CommonUtils.showAlertHistoryBack(response, "필수 입력 항목은 빈칸으로 둘 수 없습니다.");
				return null;
			}
			Date today = new Date();
			System.err.println("[BoardWriteAction.do] today: " + today);

			Map<String, Object> params = new HashMap<String, Object>();
			params.put("club_id", 1);
			params.put("board_cd", board_cd);
			params.put("title", title); // 게시글 제목
			params.put("contents", contents); // 게시글 내용
			params.put("fix_yn", (fix_yn == null) ? "N" : fix_yn); // 체크박스 선택 안하면 null이 넘어옴
			params.put("attach_yn", "N");
			params.put("start_date", today);
			params.put("end_date", today);
			params.put("input_id", (writer.isEmpty()) ? userVO.getId() : writer); // 게시글을 작성한 사용자 ID
			params.put("input_ip", CommonUtils.getClientIP(request));
			params.put("input_date", today);
			boardService.addBoard(params);

			List<FileVO> recentFiles = new ArrayList<FileVO>();
			BoardVO recentBoard = null;
			params.put("opt", 1);
			recentBoard = boardService.getBoard(params);
			System.err.println("[BoardWriteAction.do] recentBoard.getBoard_no(): " + recentBoard.getBoard_no());

			// 넘어온 파일을 리스트로 저장
			List<MultipartFile> mpList = request.getFiles("attachFile"); // attachFile로 넘어온 파일을 가져옴
			MultipartFile thumbnailFile = request.getFile("thumbnailFile"); // 썸네일 파일 용
			boolean isExistThumbnail = false;
			if (isPhotoBoard) {
				if (thumbnailFile != null && !thumbnailFile.isEmpty()
						&& !thumbnailFile.getOriginalFilename().equalsIgnoreCase("")) {
					mpList.add(0, thumbnailFile);
					isExistThumbnail = true;
				}
			}
			if (mpList.size() < 1 || mpList.isEmpty()) {
				// 업로드할 파일 없음
			} else {
				int mpIndex = 0;
				for (MultipartFile multipartFile : mpList) {
					if (multipartFile.getOriginalFilename().equalsIgnoreCase("")) {
						continue;
					}

					String path = CommonUtils.SAVE_PATH;

					System.err.println("[BoardWriteAction.do] path: " + path);
					String thumbPrefix = "";
					if (isPhotoBoard && mpIndex == 0 && isExistThumbnail) {
						thumbPrefix = "thumbnail_";
						// path = CommonUtils.SAVE_THUMBNAIL_PATH;
					}
					path += CommonUtils.getTimeBasePath();

					/* 업로드할 폴더 체크 */
					File dir = new File(path);
					if (!dir.isDirectory()) { // 폴더가 없다면 생성
						dir.mkdirs(); // 폴더 생성
					}

					String genId = CommonUtils.getRandomString(); // 파일명 중복 방지
					String originalfileName = multipartFile.getOriginalFilename(); // 원본 파일명
					String saveFileName = thumbPrefix + genId + "." + CommonUtils.getExtension(originalfileName); // 서버에
																													// 저장될
																													// 파일명
					String savePath = path + "/" + saveFileName; // 서버에 저장된 파일 경로
					String hash = CommonUtils.getSHA256(multipartFile.getBytes()); // SHA-256 해쉬 알고리즘
					multipartFile.transferTo(new File(savePath)); // 서버에 파일 저장

					System.err.println("[BoardWriteAction.do] savePath: " + savePath);

					/* 무결성 검사 시작 */
					boolean isIntegrity = false;
					File up = new File(savePath);
					if (up.exists()) {
						if (CommonUtils.getSHA256(Files.readAllBytes(up.toPath())).equals(hash)) {
							isIntegrity = true; // 무결성 확인 완료
							// if(isPhotoBoard && mpIndex == 0 && isExistThumbnail)
							// CommonUtils.createThumbnail(path, saveFileName);
						} else {
							up.delete(); // 손상된 파일 삭제
						}
					}

					if (isIntegrity) { // 무결성 체크 완료
						Map<String, Object> fileParams = new HashMap<String, Object>();
						fileParams.put("club_id", 1);
						fileParams.put("board_cd", board_cd);
						fileParams.put("board_no", recentBoard.getBoard_no());
						fileParams.put("file_nm", originalfileName);
						fileParams.put("file_save_nm", saveFileName);
						fileParams.put("file_path", savePath);
						fileParams.put("enclude_yn", "N");
						fileParams.put("input_id", (writer.isEmpty()) ? userVO.getId() : writer);
						fileParams.put("input_ip", CommonUtils.getClientIP(request));
						fileParams.put("input_date", today);
						fileService.addFile(fileParams);

						fileParams.put("opt", 1);
						recentFiles.add(fileService.getFile(fileParams));

						Map<String, Object> attachParams = new HashMap<String, Object>();
						attachParams.put("attach_yn", "Y");
						attachParams.put("club_id", 1);
						attachParams.put("board_cd", board_cd);
						attachParams.put("board_no", recentBoard.getBoard_no());
						boardService.updateAttach(attachParams);
					}
					mpIndex++;
				}

			}

			params.put("attach_yn", (recentFiles.size() > 0) ? "Y" : "N");
			/* 첨부파일 등록 */
			params = new HashMap<String, Object>();
			params.put("board_cd", board_cd);
			params.put("opt", 1);

			if (recentFiles != null && !recentFiles.isEmpty() && recentBoard != null) {
				for (FileVO f : recentFiles) {
					params.put("file_no", f.getFile_no());
					params.put("board_no", recentBoard.getBoard_no());
					fileService.attachFile(params);
				}
			}
			CommonUtils.showAlert(response, "정상적으로 등록되었습니다.", "/BoardSearch.do");
			return null;
			/*
			 * else { throw new Exception("DB Error : NullPointer"); }
			 */

		} catch (Exception e) {
			e.printStackTrace();
			CommonUtils.showAlert(response, "등록에 실패했습니다.", "/BoardSearch.do");
			return null;
		}
	}

	/*
	 * @RequestMapping(value="/BoardUpdateForm.do")
	 * 게시판
	 * 게시글 업데이트 폼
	 * @RequestParam num(board_no)
	*/
	@RequestMapping(value = "/BoardUpdateForm.do")
	public ModelAndView boardUpdateForm(ModelAndView mav,
			  							HttpServletRequest request, HttpServletResponse response,
			  							@RequestParam(value = "num", required = false) int board_no)
	{
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
        String board_cd = (String) session.getAttribute("board_cd");
		session.setAttribute("board_no", board_no);

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("board_cd", board_cd);
		params.put("board_no", board_no);
		params.put("club_id", 1);

		boardService.increaseOpenCnt(params);
		BoardVO searchBoard = boardService.getBoard(params);
		
		Map<String, Object> params2 = new HashMap<String, Object>();
		params2.put("ID", searchBoard.getInput_id());
		UserVO writer = userService.getUserVO(params2);
		String writerAuth = commonService.checkAuth(params2);
		
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
		
		mav.addObject("hasThumbnail", hasThumbnail);
		mav.addObject("thumbnailFile", thumbnailFile);
		mav.addObject("fileList", fileList);
		mav.addObject("fileListCnt", fileListCnt);
		mav.addObject("searchBoard", searchBoard);
		mav.addObject("writerName", writer.getName());
		mav.addObject("writerAuth", writerAuth);
		mav.setViewName("hallym/BoardUpdateForm");
		return mav;
	}
	
	// todo attach_yn 수정이 안됨
	/*
	 * @RequestMapping(value="/BoardUpdateAction.do")
	 * 게시판
	 * 게시글 업데이트 (동작)
	 * @RequestParam title, contents, writer
	 * @RequestParam fix_yn, start_date, end_date
	 * @RequestParam deleteThumail deleteAttach
	*/
	@RequestMapping(value = "/BoardUpdateAction.do")
	public String boardUpdateAction(MultipartHttpServletRequest request, HttpServletResponse response,
									@RequestParam(value = "title",  required = false) String title,
									@RequestParam(value = "contents", required = false) String contents,
									@RequestParam(value = "writer", required = false) String writer,
									@RequestParam(value = "fix_yn", required = false) String fix_yn,
									@RequestParam(value = "start_date", required = false) String start_date,
									@RequestParam(value = "end_date", required = false) String end_date,
									@RequestParam(value = "deleteThumbnail", required = false) String deleteThumbnail,
									@RequestParam(value = "deleteAttach", required = false) List<String> delAttachs) throws IOException
	{
		response.setContentType("text/html; charset=UTF-8");
        
		HttpSession session = request.getSession();
		
		String board_cd = (String) session.getAttribute("board_cd");
		String[] photoBoardList = {"007002", "007003"};
		
		int board_no = (int) session.getAttribute("board_no");
		System.err.println("[BoardUpdateAction.do] board_no: " +  board_no);
		boolean isPhotoBoard = Arrays.stream(photoBoardList).anyMatch(board_cd::equals);
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		
		if(board_no==0){
			CommonUtils.showAlert(response, "게시글 새션 종료 ", "BoardSearch.do?bdc=007001");
			return null;
		}
		else {
			
	        if(title == null || contents == null) {
	        	CommonUtils.showAlertHistoryBack(response, "필수 입력 항목을 입력해야 합니다.");
	        	return null;
	        }
	        if(title.trim().equalsIgnoreCase("") || contents.trim().equalsIgnoreCase("")) {
	        	CommonUtils.showAlertHistoryBack(response, "필수 입력 항목은 빈칸으로 둘 수 없습니다.");
	        	return null;
	        }
	        
			Date today = new Date();
			
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("board_cd", board_cd);
			params.put("board_no", board_no);
			params.put("club_id", 1);
			params.put("opt", 2);
			int cnt = fileService.getFileListCnt(params);
			
			/* 썸네일 파일VO 탐색 */
			FileVO oldThumbnailFile = null;
			boolean hasThumbnail = false;
			Map<String, Object> thumbDel = new HashMap<String, Object>();
			thumbDel.put("club_id", 1);
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
		            	CommonUtils.showAlert(response, "파일 삭제 오류", "/BoardReadForm.do?&num=" + board_no);
		            	return null;
		    		}
				} else {
					CommonUtils.showAlert(response, "잘못된 접근입니다.", "/BoardReadForm.do?&num=" + board_no);
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
			            	CommonUtils.showAlert(response, "파일 삭제 오류", "/BoardReadForm.do?&num=" + board_no);
			            	return null;
			    		}
					} else {
						CommonUtils.showAlert(response, "잘못된 접근입니다.", "/BoardReadForm.do?&num=" + board_no);
						return null;
					}
				}
			}
			
			/* 업로드할 폴더 체크 */
//				String path = CommonUtils.SAVE_PATH + CommonUtils.getTimeBasePath();
//				File dir = new File(path);
//		        if (!dir.isDirectory()) { // 폴더가 없다면 생성
//		            dir.mkdirs(); // 폴더 생성
//		        }
	        
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
//					String path = request.getSession().getServletContext().getRealPath("/upload/club/files/");

					String thumbPrefix = "";
					if(isPhotoBoard && mpIndex == 0 && isExistThumbnail) {
						thumbPrefix = "thumbnail_";
						path = CommonUtils.SAVE_THUMBNAIL_PATH;
//						path = request.getSession().getServletContext().getRealPath("/upload/club/thumbnail/");
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
						params.put("club_id", 1);
						params.put("file_nm", originalfileName);
						params.put("file_save_nm", saveFileName);
						params.put("file_path", savePath);
						params.put("enclude_yn", "N");
						params.put("input_id", (writer.isEmpty())?userVO.getId():writer);
						params.put("input_ip", CommonUtils.getClientIP(request));
						params.put("input_date", today);
						fileService.addFile(params);
						
					}
                	mpIndex++;
				}
			}
			
			System.err.println("[BoardUpdateAction.do] cnt: " + cnt);
			System.err.println("[BoardUpdateAction.do] today: " + today);
			
			params.put("club_id", 1);
			params.put("opt", 0);
			params.put("title", title);
			params.put("contents", contents);
			params.put("fix_yn", (fix_yn == null)?"N":fix_yn); //체크박스 선택 안하면 null이 넘어옴
			params.put("attach_yn", (cnt > 0)?"Y":"N");
			params.put("start_date", today);
			params.put("end_date", today);
			params.put("update_id", (writer.isEmpty())?userVO.getId():writer);
			params.put("update_ip", CommonUtils.getClientIP(request));
			params.put("update_date", today);
			boardService.updateBoard(params);
			
			CommonUtils.showAlert(response, "정상적으로 수정되었습니다.", "/BoardReadForm.do?&num=" + board_no);
			return null;
		}
	}
	
	/*
	 * @RequestMapping(value="/BoardDeleteAction.do")
	 * 게시판
	 * 게시글 삭제 (동작)
	 * @RequestParam num(board_no)
	*/
	@RequestMapping(value = "/BoardDeleteAction.do")
	public String boardDeleteAction(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "num", required = false) int board_no) {
		response.setContentType("text/html; charset=UTF-8");

		HttpSession session = request.getSession();
		String board_cd = (String) session.getAttribute("board_cd");

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("board_cd", board_cd);
		params.put("board_no", board_no);
		params.put("club_id", 1);

		boardService.deleteBoard(params);

		params.put("opt", 2);
		int fileListCnt = fileService.getFileListCnt(params);
		if (fileListCnt > 0) {
			List<FileVO> fileList = fileService.getFileList(params);

			for (FileVO fileVO : fileList) {
				File del = new File(fileVO.getFile_path());
				if (del.exists() && !del.isDirectory()) {
					del.delete();
				}
			}
			fileService.deleteFile(params);
		}

		CommonUtils.showAlert(response, "정상적으로 삭제하였습니다.", "/BoardSearch.do");
		return null;

	}

	
}