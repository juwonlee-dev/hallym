package hallym.club.activity.service.impl;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import hallym.club.activity.dao.ActivityDAO;
import hallym.club.activity.service.ActivityService;
import hallym.club.activity.vo.ActivityVO;

@Service("activityService")
public class ActivityServiceImpl implements ActivityService{

	@Resource(name = "activityDAO")
	private ActivityDAO activityDAO;
	
	@Override
	public List<ActivityVO> getActivityList(Map<String, Object> params) {
		return activityDAO.getActivityList(params);
	}

	@Override
	public int getTotalPageCnt(Map<String, Object> params) {
		int totalPageCnt = 0;
		
		try {
			totalPageCnt = activityDAO.getTotalPageCnt(params);
		} catch (Exception e) {
			System.err.println("[ActivityServiceImpl] getTotalPageCnt ERR: " + e.getMessage());
		}
		return totalPageCnt;
	}

	@Override
	public int getActivityListCnt(Map<String, Object> params) {
		int activityListCnt = 0;
		
		try {
			activityListCnt = activityDAO.getActivityListCnt(params);
		} catch (Exception e) {
			System.err.println("[ActivityServiceImpl] getTotalPageCnt ERR: " + e.getMessage());
		}
		return activityListCnt;
	}

	@Override
	public ActivityVO getActivity(Map<String, Object> params) {
		return activityDAO.getActivity(params);
	}

	@Override
	public void addActivity(Map<String, Object> params) {
		activityDAO.addActivity(params);
	}

	@Override
	public void updateActivity(Map<String, Object> params) {
		activityDAO.updateActivity(params);
	}

	@Override
	public void deleteActivity(Map<String, Object> params) {
		activityDAO.deleteActivity(params);
	}

}
