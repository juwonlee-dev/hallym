package hallym.club.file.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import hallym.club.actfile.dao.ActFileDAO;
import hallym.club.file.service.ActFileService;
import hallym.club.file.vo.ActFileVO;


@Service("actFileService")
public class ActFileServiceImpl implements ActFileService{
	
	@Resource(name = "actFileDAO")
	private ActFileDAO actFileDAO;

	@Override
	public void addFile(Map<String, Object> params) {
		actFileDAO.addFile(params);
	}

	@Override
	public ActFileVO getFile(Map<String, Object> params) {
		return actFileDAO.getFile(params);
	}

	@Override
	public void attachFile(Map<String, Object> params) {
		actFileDAO.attachFile(params);		
	}

	@Override
	public int getFileListCnt(Map<String, Object> params) {
		return actFileDAO.getFileListCnt(params);
	}

	@Override
	public List<ActFileVO> getFileList(Map<String, Object> params) {
		return actFileDAO.getFileList(params);
	}

	@Override
	public void deleteFile(Map<String, Object> params) {
		actFileDAO.deleteFile(params);
	}

	@Override
	public void deleteClubFile(Map<String, Object> params) {
		actFileDAO.deleteClubFile(params);
	}

}
