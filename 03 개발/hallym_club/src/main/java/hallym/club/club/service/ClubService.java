package hallym.club.club.service;

import java.util.List;
import java.util.Map;

import hallym.club.club.vo.ClubVO;
import hallym.club.clubmember.vo.ClubMemberVO;

public interface ClubService {

	public List<ClubVO> getIntroClub();
	public List<ClubVO> getIntroClubLogin(Map<String, Object> params) throws Exception;
	public List<ClubVO> getClubList(Map<String, Object> params);
	public int getClubListCnt(Map<String, Object> params);
	public int getTotalPageCnt(Map<String, Object> params);
	public int getRegisterClubListCnt(Map<String, Object> params);
	public int getRegisterTotalPageCnt(Map<String, Object> params);
	public List<ClubVO> getTopClubList(Map<String, Object> params);
	public void createClub(Map<String, Object> params);
	public String getClubName(Map<String, Object> params);
	public ClubVO getClub(Map<String, Object> params);
	public void updateClub(Map<String, Object> params);	
	public List<ClubVO> getWaitRegisterClub(Map<String, Object> params);
	public List<ClubVO> getWaitJoinClub(Map<String, Object> params);
	public void deleteClub(Map<String, Object> params);
	public List<ClubVO> getRegisterClub(Map<String, Object> params);
	public List<ClubVO> getRegisterClubList(Map<String, Object> params);
	public void updateRegister(Map<String, Object> params);
	public void updateTopClubYN(Map<String, Object> params);
	public void updateTopClubRank(Map<String, Object> params);
	public void updateIntro(Map<String, Object> params);
	public void updatePoster(Map<String, Object> params);
	public void deleteTopClub(Map<String, Object> params);
	public void insertTopClub(Map<String, Object> params);
	
}
