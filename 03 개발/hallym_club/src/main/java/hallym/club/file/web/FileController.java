package hallym.club.file.web;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import hallym.club.file.service.FileService;
import hallym.club.file.vo.FileVO;
import hallym.club.user.vo.UserVO;
import hallym.club.utils.CommonUtils;

@Controller
public class FileController {

	@Resource(name = "fileService")
	private FileService fileService;
	
	// 리눅스 기준으로 파일 경로를 작성 ( 루트 경로인 /으로 시작한다. )
	// 윈도우라면 workspace의 드라이브를 파악하여 JVM이 알아서 처리해준다.
	// 따라서 workspace가 C드라이브에 있다면 C드라이브에 폴더를 생성해 놓아야 한다.
	
	
	@RequestMapping(value = "/FileDownload.do")
	public void FileDownload(HttpServletRequest request, HttpServletResponse response,
								@RequestParam(value = "num", required = false) int file_no) throws IOException
	{
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
//		Map<String, Boolean> agreeTermsList = (HashMap<String, Boolean>) session.getAttribute("agreeTerms");
//        boolean isAgree = (agreeTermsList == null)?false:(!agreeTermsList.containsValue(false));
//        if(!isAgree) {
//        	CommonUtils.showAlert(response, "이용 약관에 동의해야합니다.", "/logout.do");
//        	return;
//        }
//        
		UserVO userVO = (UserVO) session.getAttribute("userVO");
		String board_cd = (String) session.getAttribute("board_cd");
		int board_no = (int) session.getAttribute("board_no");
		
		if(userVO.getId().isEmpty()) {
			CommonUtils.showAlert(response, "로그인이 필요한 서비스입니다.", "/login.do");
		} else {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("board_cd", board_cd);
			params.put("board_no", board_no);
			params.put("file_no", file_no);
			params.put("opt", 2);
			
			int fileListCnt = fileService.getFileListCnt(params);
			FileVO fileVO = null;
			if(fileListCnt > 0) {
				fileVO = fileService.getFile(params);
			
				byte fileByte[] = FileUtils.readFileToByteArray(new File(fileVO.getFile_path()));
				response.setContentType("application/octet-stream");
				response.setContentLength(fileByte.length);
				response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileVO.getFile_nm(),"UTF-8")+"\";");
				response.setHeader("Content-Transfer-Encoding", "binary");
				response.getOutputStream().write(fileByte);
				response.getOutputStream().flush();
				response.getOutputStream().close();
			} else {
				CommonUtils.showAlert(response, "잘못된 접근입니다.", "/BoardReadForm.do?&num=" + board_no);
			}
		}
		
	}
	
	
}
