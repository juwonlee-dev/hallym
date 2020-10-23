package hallym.club.clubmember.dao;

import java.util.List;
import java.util.Map;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import hallym.club.clubmember.vo.ClubMemberVO;

@Mapper("clubMemberDAO")
public interface ClubMemberDAO {
	
	public void addClubMember(Map<String, Object> params);
	public String checkJoinClub(Map<String, Object> params) throws Exception;
	public void joinApplicationClub(Map<String, Object> params);
	public List<ClubMemberVO> getClubMember(Map<String, Object> params);
	public ClubMemberVO getClubPresident(Map<String, Object> params);
	public int getClubMemberCnt(Map<String, Object> params) throws Exception;
	public String getStaffCD(Map<String, Object> params);
	public List<ClubMemberVO> getAllClubMember(Map<String, Object> params);
	public void leaveClub(Map<String, Object> params);
	public void updateClubMember(Map<String, Object> params);
	public int getTotalPageCnt(Map<String, Object> params) throws Exception;
	public int getMemberListCnt(Map<String, Object> params) throws Exception;
	public List<ClubMemberVO> getClubMemberList(Map<String, Object> params);
	
}
