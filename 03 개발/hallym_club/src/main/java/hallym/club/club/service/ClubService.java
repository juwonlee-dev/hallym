package hallym.club.club.service;

import java.util.List;
import java.util.Map;

import hallym.club.club.vo.ClubVO;

public interface ClubService {

	public List<ClubVO> getIntroClub();
	public List<ClubVO> getIntroClubLogin(Map<String, Object> params) throws Exception;
	public List<ClubVO> getClubList(Map<String, Object> params);
	public int getClubListCnt(Map<String, Object> params);
	public int getTotalPageCnt(Map<String, Object> params);
	public List<ClubVO> getTopClub(Map<String, Object> params);
	public void createClub(Map<String, Object> params);
	public String getClubName(Map<String, Object> params);
}
