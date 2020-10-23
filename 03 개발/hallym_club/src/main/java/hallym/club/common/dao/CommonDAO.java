package hallym.club.common.dao;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import hallym.club.common.vo.TermsVO;


@Mapper("commonDAO")
public interface CommonDAO {
	public void writeLog(Map<String, Object> params);
	public List<TermsVO> getTermsInfo(Map<String, Object> params);
	public void setTermsAgree(Map<String, Object> params);
	public void updateTermsAgree(Map<String, Object> params);
	public String checkAuth(Map<String, Object> params);
	public void updateAuth2(Map<String, Object> params);
	public String getAuthUserName(Map<String, Object> params); 
	
	
}
