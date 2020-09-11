package hallym.club.club.web;

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

import hallym.club.club.service.ClubService;
import hallym.club.club.vo.ClubVO;

@Controller
public class ClubController {
	
	@Resource(name = "clubService")
	private ClubService clubService;
	
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
		System.err.println(clubList);
		System.err.println("clubListCount: " + clubListCount);
		System.err.println("totalPage: " + totalPage);
		
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
		
		mav.addObject("clubList", clubTopList);
		mav.setViewName("hallym/topClub");
		
		return mav;
	}
		
}
