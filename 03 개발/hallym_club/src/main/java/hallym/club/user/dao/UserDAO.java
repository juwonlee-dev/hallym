package hallym.club.user.dao;

import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import hallym.club.user.vo.UserVO;

@Mapper("userDAO")
public interface UserDAO {
	public String checkLogin(Map<String, Object> params);
	public UserVO getUserVO(Map<String, Object> params);
}
