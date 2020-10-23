package hallym.club.user.service.impl;

import java.util.HashMap;
import java.util.List;
//import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import hallym.club.user.dao.UserDAO;
import hallym.club.user.service.UserService;
import hallym.club.user.vo.UserVO;
import hallym.club.common.vo.TermsVO;
import hallym.club.board.dao.BoardDAO;
import hallym.club.common.dao.CommonDAO;

@Service("userService")
public class UserServiceImpl implements UserService{
	
	@Resource(name="userDAO")
	private UserDAO userDAO;

	@Resource(name="boardDAO")
	private BoardDAO boardDAO;
	
	@Resource(name="commonDAO")
	private CommonDAO commonDAO;
	
	@Override
	public String checkLogin(HttpSession session, Map<String, Object> params) {
		System.err.println("[UserServiceImpl] checkLogin");
		System.err.println("GBN : " + params.get("GBN"));
		System.err.println("ID : " + params.get("ID"));
		System.err.println("PASSWORD : " + new String(new char[params.get("PASSWORD").toString().length()]).replace("\0", "*"));
		
		String result = null;
		String requestLogin = userDAO.checkLogin(params); //로그인
		
		if(requestLogin.equalsIgnoreCase("true")) { //로그인 성공
			UserVO userVO = this.getUserVO(params);
			String authUserName = commonDAO.getAuthUserName(params);
			if(authUserName == null || authUserName.isEmpty()) {
				Map<String, Object> params2 = new HashMap<String, Object>();
				params2.put("ID", userVO.getId());
				params2.put("IDENTITYNAME", (userVO.getIdentity() == null)?"":userVO.getIdentity());
				params2.put("CONDITIONNAME", (userVO.getCondition() == null)?"":userVO.getCondition());
				params2.put("RESIDENTNO", (userVO.getResident() == null)?"":userVO.getResident());
				params2.put("NAME", (userVO.getName() == null)?"":userVO.getName());
				params2.put("UNIVNAME", (userVO.getUniv() == null)?"":userVO.getUniv());
				params2.put("DEPTNAME", (userVO.getDept() == null)?"":userVO.getDept());
				params2.put("MAJORNAME", (userVO.getMajor() == null)?"":userVO.getMajor());
				params2.put("MAJORNAME2", (userVO.getMajor2() == null)?"":userVO.getMajor2());
				params2.put("GRADE", (userVO.getGrade() == null)?"":userVO.getGrade());
				params2.put("SEMESTER", (userVO.getSemester() == null)?"":userVO.getSemester());
				params2.put("E_MAIL", (userVO.getE_mail() == null)?"":userVO.getE_mail());
				params2.put("PHONENUMBER", (userVO.getPhoneNumber() == null)?"":userVO.getPhoneNumber());
				params2.put("GENDER", (userVO.getGender() == null)?"":userVO.getGender());
				commonDAO.updateAuth2(params2);
			}
			
			String auth_code = commonDAO.checkAuth(params);
			session.setAttribute("userVO", userVO);
			session.setAttribute("auth_code", auth_code);
			
//			System.out.println("[UserServiceImpl]userVO: "+ userVO);
//			System.out.println("[UserServiceImpl](session) userVO: "+ (UserVO) session.getAttribute("userVO"));
			
			Map<String, Boolean> checkTermsList = new HashMap<String, Boolean>();
			checkTermsList.put("012001", false); // 개인정보 수집 이용 동의
			List<TermsVO> termsList = null;
			
			Map<String, Object> params3 = new HashMap<String, Object>();
			params3.put("IDNO", userVO.getId());
			params3.put("opt", 0);
			termsList = commonDAO.getTermsInfo(params3);
			if(termsList != null) {
				for(TermsVO v : termsList) {
					
					if(checkTermsList.containsKey(v.getTERMS_CD())) {
						checkTermsList.replace(v.getTERMS_CD(), true);
					}
				}
			}
			
			if(checkTermsList.containsValue(false)) {
				result = "redirect:terms.do";
			} else {
				session.setAttribute("agreeTerms", checkTermsList);
				result = "redirect:index.do";
			}
		}
		else if(requestLogin.equalsIgnoreCase("false")) { //로그인 실패
			result = "F";
		}
		else { //로그인 DB에서 오류 발생
			result = "E";
		}
		
		return result;
	}

	@Override
	public UserVO getUserVO(Map<String, Object> params) {
		return userDAO.getUserVO(params);
	}

}
