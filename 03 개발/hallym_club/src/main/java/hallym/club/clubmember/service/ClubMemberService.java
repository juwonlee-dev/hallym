package hallym.club.clubmember.service;

import java.util.List;
import java.util.Map;

import hallym.club.clubmember.vo.ClubMemberVO;

public interface ClubMemberService {

	public void addClubMember(Map<String, Object> params);
	public String checkJoinClub(Map<String, Object> params);
	public void joinApplicationClub(Map<String, Object> params);
	public List<ClubMemberVO> getClubMember(Map<String, Object> params);
	public ClubMemberVO getClubPresident(Map<String, Object> params);
	public int getClubMemberCnt(Map<String, Object> params);
	
}
