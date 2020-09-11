package hallym.club.club.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import hallym.club.club.dao.ClubDAO;
import hallym.club.club.service.ClubService;
import hallym.club.club.vo.ClubVO;

@Service("clubService")
public class ClubServiceImpl implements ClubService{
	
	@Resource(name = "clubDAO")
	private ClubDAO clubDAO;

	@Override
	public List<ClubVO> getIntroClub(){
		return clubDAO.getIntroClub();
	}

	@Override
	public List<ClubVO> getIntroClubLogin(Map<String, Object> params) throws Exception {
		return clubDAO.getIntroClubLogin(params);
	}

	@Override
	public List<ClubVO> getClubList(Map<String, Object> params) {
		return clubDAO.getClubList(params);
	}

	@Override
	public int getClubListCnt(Map<String, Object> params) {
		return clubDAO.getClubListCnt(params);
	}

	@Override
	public int getTotalPageCnt(Map<String, Object> params) {
		return clubDAO.getTotalPageCnt(params);
	}

	@Override
	public List<ClubVO> getTopClub(Map<String, Object> params) {
		return clubDAO.getTopClub(params);
	}
	
	

}
