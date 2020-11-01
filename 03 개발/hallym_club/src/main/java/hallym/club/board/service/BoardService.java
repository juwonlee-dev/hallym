package hallym.club.board.service;

import java.util.List;
import java.util.Map;

import hallym.club.board.vo.BoardVO;

public interface BoardService {
	
	public List<BoardVO> getIntroNotice();
	public List<BoardVO> getBoardList(Map<String, Object> params);
	public int getTotalPageCnt(Map<String, Object> params);
	public int getBoardListCnt(Map<String, Object> params);
	public void increaseOpenCnt(Map<String, Object> params);
	public BoardVO getBoard(Map<String, Object> params);
	public void addBoard(Map<String, Object> params);
	public void updateAttach(Map<String, Object> params);
	public void deleteBoard(Map<String, Object> params);
	public void deleteBoardReal(Map<String, Object> params);
	public void updateBoard(Map<String, Object> params);
	public List<BoardVO> getCalendar(Map<String, Object> params);
	public void deleteClubBoard(Map<String, Object> params);
	
}
