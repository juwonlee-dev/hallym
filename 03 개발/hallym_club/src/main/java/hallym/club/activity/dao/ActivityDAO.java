package hallym.club.activity.dao;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import hallym.club.activity.vo.ActivityVO;

@Mapper("activityDAO")
public interface ActivityDAO {
	
	public List<ActivityVO> getActivityList(Map<String, Object> params);
	public int getTotalPageCnt(Map<String, Object> params) throws Exception;
	public int getActivityListCnt(Map<String, Object> params) throws Exception;
	public ActivityVO getActivity(Map<String, Object> params);
	public void addActivity(Map<String, Object> params);
	public void updateActivity(Map<String, Object> params);
	public void deleteActivity(Map<String, Object> params);
	
}
