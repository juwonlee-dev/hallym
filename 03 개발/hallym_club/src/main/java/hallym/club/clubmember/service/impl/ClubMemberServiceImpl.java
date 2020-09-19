package hallym.club.clubmember.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import hallym.club.clubmember.dao.ClubMemberDAO;
import hallym.club.clubmember.service.ClubMemberService;

@Service("clubMemberService")
public class ClubMemberServiceImpl implements ClubMemberService{
	
	@Resource(name = "clubMemberDAO")
	private ClubMemberDAO clubMemberDAO;
	
	@Override
	public void addClubMember(Map<String, Object> params) {
		clubMemberDAO.addClubMember(params);
	}

}
