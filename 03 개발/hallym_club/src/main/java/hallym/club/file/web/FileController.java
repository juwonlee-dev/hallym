package hallym.club.file.web;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import hallym.club.file.service.FileService;
import hallym.club.file.vo.FileVO;
import hallym.club.user.vo.UserVO;
import hallym.club.utils.CommonUtils;

@Controller
public class FileController {

	@Resource(name = "fileService")
	private FileService fileService;
	// 2018.08.20 todo
	// 리눅스 기준으로 파일 경로를 작성 ( 루트 경로인 /으로 시작한다. )
	// 윈도우라면 workspace의 드라이브를 파악하여 JVM이 알아서 처리해준다.
	// 따라서 workspace가 C드라이브에 있다면 C드라이브에 폴더를 생성해 놓아야 한다.
	
	/*
	 * @RequestMapping(value="/FileDownload.do")
	 * 게시판
	 * 파일 다운로드
	 * @RequestParam num(file_no)
	*/
	@RequestMapping(value = "/FileDownload.do")
	public void FileDownload(HttpServletRequest request, HttpServletResponse response,
								@RequestParam(value = "num", required = false) int file_no) throws IOException
	{
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();

        
		String board_cd = (String) session.getAttribute("board_cd");
		int board_no = (int) session.getAttribute("board_no");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("board_cd", board_cd);
		params.put("board_no", board_no);
		params.put("file_no", file_no);
		params.put("club_id", 1);
		params.put("opt", 2);

		int fileListCnt = fileService.getFileListCnt(params);
		FileVO fileVO = null;
		if (fileListCnt > 0) {
			fileVO = fileService.getFile(params);

			byte fileByte[] = FileUtils.readFileToByteArray(new File(fileVO.getFile_path()));
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition",
					"attachment; fileName=\"" + URLEncoder.encode(fileVO.getFile_nm(), "UTF-8") + "\";");
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} else {
			CommonUtils.showAlert(response, "잘못된 접근입니다.", "/BoardReadForm.do?&num=" + board_no);
		}
		
	}
	
	@RequestMapping(value = "/ImageUpload.do", method = RequestMethod.POST)
	public void FileUploadAction(MultipartHttpServletRequest request,
								HttpServletResponse response) throws IOException
	{
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		
		System.err.println("[ImageUpload.do] 이미지 업로드");
        
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		String board_cd = (String) session.getAttribute("board_cd");
		//int seq_no = (int) session.getAttribute("seq_no");
		int seq_no = -1; //CKEditor에서 업로드한 이미지 파일은 -1값으로 구분
		JsonObject json = new JsonObject();
		int uploaded = 0;
		String url = "";
		String fileName = "";
		String saveFileName = "";
		String savePath = "";
		
		/* 업로드할 폴더 체크 */
		String path =  request.getSession().getServletContext().getRealPath("/upload/club/files/");
		File dir = new File(path);
        if (!dir.isDirectory()) { // 폴더가 없다면 생성
            dir.mkdirs(); // 폴더 생성
        }
        
     // 넘어온 파일을 리스트로 저장
		List<MultipartFile> mpList = request.getFiles("upload"); // attachFile로 넘어온 파일을 가져옴
		if(mpList.size() < 1 || mpList.isEmpty()) {
			// 업로드할 파일 없음
		} else if(mpList.size() > 1) {
			// 여러 파일 업로드
		} else {
			for(MultipartFile multipartFile : mpList) {
				if(multipartFile.getOriginalFilename().equalsIgnoreCase("") || !multipartFile.getContentType().toLowerCase().startsWith("image/")) {
					continue; //파일명 없음, 파일 타입이 이미지가 아닌 경우
				}
				// 파일 중복명 처리
                String genId = CommonUtils.getRandomString();
                
                // 본래 파일명
                String originalfileName = multipartFile.getOriginalFilename();
                
                // 저장되는 파일 이름
                saveFileName = genId + "." + CommonUtils.getExtension(originalfileName);
                
                // 저장 될 파일 경로
                //local
//                savePath = path + saveFileName; 
                
                //server
                savePath = path + "/" + saveFileName; 
                
                // 해쉬 함수 사용
                String hash = CommonUtils.getSHA256(multipartFile.getBytes());
 
                multipartFile.transferTo(new File(savePath)); // 파일 저장
                
                /* 무결성 검사 시작 */
                boolean isIntegrity = false;
                File up = new File(savePath);
                if(up.exists()) {
                	if(CommonUtils.getSHA256(Files.readAllBytes(up.toPath())).equals(hash)) {
                		isIntegrity = true; // 무결성 확인 완료
                		uploaded = 1;
                	} else {
                		up.delete(); // 손상된 파일 삭제
                	}
                }
                
            	if(isIntegrity) { // 무결성 체크 완료
	                Map<String, Object> params = new HashMap<String, Object>();
	                params.put("club_id", 1);
					params.put("board_cd", board_cd);
					params.put("board_no", seq_no);
					params.put("file_nm", originalfileName);
					params.put("file_save_nm", saveFileName);
					params.put("file_path", savePath);
					params.put("enclude_yn", "Y");
					params.put("input_id", userVO.getId());
					params.put("input_ip", CommonUtils.getClientIP(request));
					params.put("input_date", new Date());
//						params.put("hash", hash);
					fileService.addFile(params);
					
					url = savePath;
					fileName = originalfileName;
                }
			}
		}
	        

		json.addProperty("uploaded", uploaded);
		System.err.println("[ImageUpload.do] fileName: " + fileName);
		System.err.println("[ImageUpload.do] saveFileName: " + saveFileName);
		System.err.println("[ImageUpload.do] savePath: " + savePath);
		System.err.println("[ImageUpload.do] url: " + url);
		
		if(uploaded == 1) {
			json.addProperty("fileName", fileName);
			
			// local
//			json.addProperty("url", "http://localhost:8098/upload/club/files/" + saveFileName);
			// server
			json.addProperty("url", "https://hclub.hallym.ac.kr:1443/upload/club/files/" + saveFileName);
			
		} else if(uploaded == 0) {
			JsonArray jsonArray = new JsonArray();
			JsonObject tmp = new JsonObject();
			tmp.addProperty("message", "파일 업로드 실패");
			jsonArray.add(tmp);
			json.add("error", jsonArray);
		} else {
			//error
			JsonArray jsonArray = new JsonArray();
			JsonObject tmp = new JsonObject();
			tmp.addProperty("message", "알수없는 오류");
			jsonArray.add(tmp);
			json.add("error", jsonArray);
		}
		PrintWriter pw = response.getWriter();
		response.setContentType("text/html");
		pw.println(json);
	}
	
	@RequestMapping(value = "/FileDelete.do")
	public void FileDeleteAction(HttpServletRequest request, HttpServletResponse response,
								@RequestParam(value = "num", required = false) int file_no) throws IOException
	{
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		
        
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		String board_cd = (String) session.getAttribute("board_cd");
		int seq_no = (int) session.getAttribute("seq_no");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("board_cd", board_cd);
		params.put("seq_no", seq_no);
		params.put("file_no", file_no);
		params.put("opt", 0);
		
		FileVO fileVO = fileService.getFile(params);
		File dir = new File(fileVO.getFile_path());
		if (!dir.isDirectory() && dir.exists()) { // 파일 존재 여부 확인
            if(dir.delete()) {
            	fileService.deleteFile(params);
            } else {
            	CommonUtils.showAlert(response, "파일 삭제 오류", "/BoardReadForm.do?&num=" + seq_no);
    		}
		} else {
			CommonUtils.showAlert(response, "잘못된 접근입니다.", "/BoardReadForm.do?&num=" + seq_no);
		}
		
	}
	
	
}
