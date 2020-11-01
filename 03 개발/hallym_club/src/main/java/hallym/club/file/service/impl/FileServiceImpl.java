package hallym.club.file.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import hallym.club.file.dao.FileDAO;
import hallym.club.file.service.FileService;
import hallym.club.file.vo.FileVO;

@Service("fileService")
public class FileServiceImpl implements FileService{
	
	@Resource(name = "fileDAO")
	private FileDAO fileDAO;

	@Override
	public void addFile(Map<String, Object> params) {
		fileDAO.addFile(params);
	}

	@Override
	public FileVO getFile(Map<String, Object> params) {
		return fileDAO.getFile(params);
	}

	@Override
	public void attachFile(Map<String, Object> params) {
		fileDAO.attachFile(params);		
	}

	@Override
	public int getFileListCnt(Map<String, Object> params) {
		return fileDAO.getFileListCnt(params);
	}

	@Override
	public List<FileVO> getFileList(Map<String, Object> params) {
		return fileDAO.getFileList(params);
	}

	@Override
	public void deleteFile(Map<String, Object> params) {
		fileDAO.deleteFile(params);
	}

	@Override
	public void deleteClubFile(Map<String, Object> params) {
		fileDAO.deleteClubFile(params);
	}

}
