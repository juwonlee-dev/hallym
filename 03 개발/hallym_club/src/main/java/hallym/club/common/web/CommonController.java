package hallym.club.common.web;

import java.io.IOException;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import hallym.club.board.vo.BoardVO;
import hallym.club.club.service.ClubService;
import hallym.club.club.vo.ClubVO;
import hallym.club.user.vo.UserVO;
import hallym.club.utils.CommonUtils;
import hallym.club.common.service.CommonService;
import hallym.club.board.service.BoardService;

@Controller
public class CommonController {
	
	@Resource(name = "commonService")
	private CommonService commonService;
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@Resource(name = "clubService")
	private ClubService clubService;
	
	/*
	 * 메인
	 * 메인 페이지 
	 * @RequestMapping(value="/lndex.do")
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
	 * 이용 약관
	 * 이용 약관 동의 페이지 
	 * @RequestMapping(value="/terms.do")
	*/
	@RequestMapping(value = "/terms.do")
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
	 * 이용 약관
	 * 이용 약관 동의 페이지 (동작)
	 * @RequestMapping(value="/termsAgreeAction.do")
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

}
