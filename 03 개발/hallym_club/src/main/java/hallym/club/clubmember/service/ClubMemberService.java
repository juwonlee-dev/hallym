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
	public String getStaffCD(Map<String, Object> params);
	public List<ClubMemberVO> getAllClubMember(Map<String, Object> params);
	public void leaveClub(Map<String, Object> params);
	public void updateClubMember(Map<String, Object> params);
	public int getTotalPageCnt(Map<String, Object> params);
	public int getMemberListCnt(Map<String, Object> params);
	public List<ClubMemberVO> getClubMemberList(Map<String, Object> params);
}
