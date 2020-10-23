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

	@Override
	public List<BoardVO> getBoardList(Map<String, Object> params) {
		return boardDAO.getBoardList(params);
	}

	@Override
	public int getTotalPageCnt(Map<String, Object> params)  {
		int totalPageCnt = 0;
		
		try {
			totalPageCnt = boardDAO.getTotalPageCnt(params);
		} catch (Exception e) {
			System.err.println("[BoardServiceImpl] getTotalPageCnt ERR: " + e.getMessage());
		}
				
		return totalPageCnt;
	}

	@Override
	public int getBoardListCnt(Map<String, Object> params)  {
		int boardListCnt = 0;
		
		try {
			boardListCnt = boardDAO.getBoardListCnt(params);
		} catch (Exception e) {
			System.err.println("[BoardServiceImpl] getBoardListCnt ERR: " + e.getMessage());
		}
		
		
		return boardListCnt;
	}

	@Override
	public void increaseOpenCnt(Map<String, Object> params) {
		boardDAO.increaseOpenCnt(params);
	}

	@Override
	public BoardVO getBoard(Map<String, Object> params) {
		return boardDAO.getBoard(params);
	}

	@Override
	public void addBoard(Map<String, Object> params) {
		boardDAO.addBoard(params);
	}

	@Override
	public void updateAttach(Map<String, Object> params) {
		boardDAO.updateAttach(params);
	}

	@Override
	public void deleteBoard(Map<String, Object> params) {
		boardDAO.deleteBoard(params);
	}

	@Override
	public void deleteBoardReal(Map<String, Object> params) {
		boardDAO.deleteBoardReal(params);
	}

	@Override
	public void updateBoard(Map<String, Object> params) {
		boardDAO.updateBoard(params);
	}

	@Override
	public List<BoardVO> getCalendar(Map<String, Object> params) {
		return boardDAO.getCalendar(params);
	} 
	


}
