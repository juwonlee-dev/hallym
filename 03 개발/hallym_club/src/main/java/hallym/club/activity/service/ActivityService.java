package hallym.club.activity.service;

import java.util.List;
import java.util.Map;

import hallym.club.activity.vo.ActivityVO;

public interface ActivityService {
	public List<ActivityVO> getActivityList(Map<String, Object> params);
	public int getTotalPageCnt(Map<String, Object> params);
	public int getActivityListCnt(Map<String, Object> params);
	public ActivityVO getActivity(Map<String, Object> params);
	public void addActivity(Map<String, Object> params);
	public void updateActivity(Map<String, Object> params);
	public void deleteActivity(Map<String, Object> params);
	
	
}
