package hallym.club.common.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import hallym.club.common.dao.CommonDAO;
import hallym.club.common.service.CommonService;
import hallym.club.common.vo.TermsVO;

@Service("commonService")
public class CommonServiceImpl implements CommonService{

	@Resource(name="commonDAO")
	private CommonDAO commonDAO;

	
	@Override
	public void writeLog(Map<String, Object> params) {
		commonDAO.writeLog(params);
	}

	@Override
	public List<TermsVO> getTermsInfo(Map<String, Object> params) {
		return commonDAO.getTermsInfo(params);
	}

	@Override
	public void setTermsAgree(Map<String, Object> params) {
		commonDAO.setTermsAgree(params);
	}

	@Override
	public void updateTermsAgree(Map<String, Object> params) {
		commonDAO.updateTermsAgree(params);
	}
	
	@Override
	public String checkAuth(Map<String, Object> params) {
		return commonDAO.checkAuth(params);
	}
	

	@Override
	public void updateAuth2(Map<String, Object> params) {
		commonDAO.updateAuth2(params);
		
	}

	@Override
	public String getAuthUserName(Map<String, Object> params) {
		return commonDAO.getAuthUserName(params);
	}


}
