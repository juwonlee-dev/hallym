package hallym.club.common.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import hallym.club.board.vo.BoardVO;
import hallym.club.club.service.ClubService;
import hallym.club.club.vo.ClubVO;
import hallym.club.user.vo.UserVO;
import hallym.club.board.service.BoardService;

@Controller
public class CommonController {
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@Resource(name = "clubService")
	private ClubService clubService;
	
	
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

}
