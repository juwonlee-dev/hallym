package hallym.club.common.service;

import java.util.List;
import java.util.Map;

import hallym.club.common.vo.TermsVO;

public interface CommonService {

	void writeLog(Map<String, Object> params);
	List<TermsVO> getTermsInfo(Map<String, Object> params);
	void setTermsAgree(Map<String, Object> params);
	void updateTermsAgree(Map<String, Object> params);
	public String checkAuth(Map<String, Object> params);
	public void updateAuth2(Map<String, Object> params);
	public String getAuthUserName(Map<String, Object> params); 
}
