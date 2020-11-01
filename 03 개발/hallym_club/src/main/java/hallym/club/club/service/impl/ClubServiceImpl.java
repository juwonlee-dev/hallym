package hallym.club.club.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import hallym.club.club.dao.ClubDAO;
import hallym.club.club.service.ClubService;
import hallym.club.club.vo.ClubVO;
import hallym.club.clubmember.vo.ClubMemberVO;

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
	public List<ClubVO> getTopClubList(Map<String, Object> params) {
		return clubDAO.getTopClubList(params);
	}

	@Override
	public void createClub(Map<String, Object> params) {
		clubDAO.createClub(params);
	}

	@Override
	public String getClubName(Map<String, Object> params) {
		return clubDAO.getClubName(params);
	}

	@Override
	public ClubVO getClub(Map<String, Object> params) {
		return clubDAO.getClub(params);
	}

	@Override
	public void updateClub(Map<String, Object> params) {
		clubDAO.updateClub(params);
	}

	@Override
	public List<ClubVO> getWaitRegisterClub(Map<String, Object> params) {
		return clubDAO.getWaitRegisterClub(params);
	}

	@Override
	public List<ClubVO> getWaitJoinClub(Map<String, Object> params) {
		return clubDAO.getWaitJoinClub(params);
	}

	@Override
	public void deleteClub(Map<String, Object> params) {
		clubDAO.deleteClub(params);
	}

	@Override
	public List<ClubVO> getRegisterClub(Map<String, Object> params) {
		return clubDAO.getRegisterClub(params);
	}

	@Override
	public void updateRegister(Map<String, Object> params) {
		clubDAO.updateRegister(params);
	}

	@Override
	public void updateTopClubYN(Map<String, Object> params) {
		clubDAO.updateTopClubYN(params);
	}

	@Override
	public void updateTopClubRank(Map<String, Object> params) {
		clubDAO.updateTopClubRank(params);
	}

	@Override
	public void updateIntro(Map<String, Object> params) {
		clubDAO.updateIntro(params);
	}

	@Override
	public void updatePoster(Map<String, Object> params) {
		clubDAO.updatePoster(params);
	}



}
