package hallym.club.board.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import hallym.club.board.service.BoardService;
import hallym.club.board.vo.BoardVO;
import hallym.club.board.dao.BoardDAO;

@Service("boardService")
public class BoardServiceImpl implements BoardService{

	@Resource(name = "boardDAO")
	private BoardDAO boardDAO;

	@Override
	public List<BoardVO> getIntroNotice(){
		/* 메인화면 공지 조회 */
		return boardDAO.getIntroNotice();
	}
	


}
