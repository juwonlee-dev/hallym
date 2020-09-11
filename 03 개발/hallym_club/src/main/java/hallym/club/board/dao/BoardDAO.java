package hallym.club.board.dao;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import hallym.club.board.vo.BoardVO;

@Mapper("boardDAO")
public interface BoardDAO {
	
	public List<BoardVO> getIntroNotice();

}
