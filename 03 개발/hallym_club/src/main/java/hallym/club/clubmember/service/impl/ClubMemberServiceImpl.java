package hallym.club.clubmember.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import hallym.club.clubmember.dao.ClubMemberDAO;
import hallym.club.clubmember.service.ClubMemberService;
import hallym.club.clubmember.vo.ClubMemberVO;

@Service("clubMemberService")
public class ClubMemberServiceImpl implements ClubMemberService{
	
	@Resource(name = "clubMemberDAO")
	private ClubMemberDAO clubMemberDAO;
	
	@Override
	public void addClubMember(Map<String, Object> params) {
		clubMemberDAO.addClubMember(params);
	}

	@Override
	public String checkJoinClub(Map<String, Object> params) {
		String join_cd = null;
		try {
			join_cd = clubMemberDAO.checkJoinClub(params);
		} catch (Exception e) {
			System.err.println("[checkJoinClub] join_cd null");
		}
		if(join_cd == null) join_cd = "null";
		return join_cd;
	}

	@Override
	public void joinApplicationClub(Map<String, Object> params) {
		clubMemberDAO.joinApplicationClub(params);
	}

	@Override
	public List<ClubMemberVO> getClubMember(Map<String, Object> params) {
		return clubMemberDAO.getClubMember(params);
	}

	@Override
	public int getClubMemberCnt(Map<String, Object> params) {
		int cnt = 0;
		try {
			cnt = clubMemberDAO.getClubMemberCnt(params);
		} catch (Exception e) {
			System.err.println("[getClubMemberCnt] err: " + e.getMessage());
		}
		return cnt;
	}

	@Override
	public ClubMemberVO getClubPresident(Map<String, Object> params) {
		return clubMemberDAO.getClubPresident(params);
	}

	@Override
	public String getStaffCD(Map<String, Object> params) {
		return clubMemberDAO.getStaffCD(params);
	}

	@Override
	public List<ClubMemberVO> getAllClubMember(Map<String, Object> params) {
		return clubMemberDAO.getAllClubMember(params);
	}

	@Override
	public void leaveClub(Map<String, Object> params) {
		clubMemberDAO.leaveClub(params);
	}

	@Override
	public void updateClubMember(Map<String, Object> params) {
		clubMemberDAO.updateClubMember(params);
	}

	@Override
	public int getTotalPageCnt(Map<String, Object> params) {
		int cnt = 0;
		try {
			cnt = clubMemberDAO.getTotalPageCnt(params);
		} catch (Exception e) {
			System.err.println("[getTotalPageCnt] err: " + e.getMessage());
		}
		return cnt;
	}

	@Override
	public int getMemberListCnt(Map<String, Object> params) {
		int cnt = 0;
		try {
			cnt = clubMemberDAO.getMemberListCnt(params);
		} catch (Exception e) {
			System.err.println("[getMemberListCnt] err: " + e.getMessage());
		}
		return cnt;
	}

	@Override
	public List<ClubMemberVO> getClubMemberList(Map<String, Object> params) {
		return clubMemberDAO.getClubMemberList(params);
	}

	@Override
	public void insertClubMember(Map<String, Object> params) {
		clubMemberDAO.insertClubMember(params);
	}

	@Override
	public String getJoinCD(Map<String, Object> params) {
		String str = "";
		try {
			str = clubMemberDAO.getJoinCD(params);
			if(str.isEmpty())
				str = "";
		} catch (Exception e) {
			str = "";
		}
		return str;
	}

	@Override
	public void updateMyInfo(Map<String, Object> params) {
		clubMemberDAO.updateMyInfo(params);
	}

	@Override
	public void deleteClubMember(Map<String, Object> params) {
		clubMemberDAO.deleteClubMember(params);
	}


}
