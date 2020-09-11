package hallym.club.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import hallym.club.board.vo.BoardVO;

public interface BoardService {
	
	public List<BoardVO> getIntroNotice();
}
