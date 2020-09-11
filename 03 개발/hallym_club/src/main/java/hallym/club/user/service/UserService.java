package hallym.club.user.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import hallym.club.user.vo.UserVO;

public interface UserService {
	public String checkLogin(HttpSession session, Map<String, Object> params);
	public UserVO getUserVO(Map<String, Object> params);
}
