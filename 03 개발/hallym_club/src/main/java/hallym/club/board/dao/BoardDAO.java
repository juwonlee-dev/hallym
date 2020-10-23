package hallym.club.board.dao;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import hallym.club.board.vo.BoardVO;

@Mapper("boardDAO")
public interface BoardDAO {
	
	public List<BoardVO> getIntroNotice();
	public List<BoardVO> getBoardList(Map<String, Object> params);
	public int getTotalPageCnt(Map<String, Object> params) throws Exception;
	public int getBoardListCnt(Map<String, Object> params) throws Exception;
	
//	public String checkAuth(Map<String, Object> params);
	
	public void increaseOpenCnt(Map<String, Object> params);
	public BoardVO getBoard(Map<String, Object> params);
	public void addBoard(Map<String, Object> params);
	public void updateAttach(Map<String, Object> params);
	public void deleteBoard(Map<String, Object> params);
	public void deleteBoardReal(Map<String, Object> params);
	public void updateBoard(Map<String, Object> params);
	public List<BoardVO> getCalendar(Map<String, Object> params);
	
}
