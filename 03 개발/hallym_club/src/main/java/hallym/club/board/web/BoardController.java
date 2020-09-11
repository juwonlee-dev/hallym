package hallym.club.board.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import hallym.club.board.service.BoardService;

@Controller
public class BoardController {
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	
	
	
	

}
