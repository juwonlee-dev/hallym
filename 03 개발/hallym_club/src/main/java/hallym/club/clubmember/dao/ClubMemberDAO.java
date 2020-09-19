package hallym.club.clubmember.dao;

import java.util.List;
import java.util.Map;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("clubMemberDAO")
public interface ClubMemberDAO {
	
	public void addClubMember(Map<String, Object> params);

}
