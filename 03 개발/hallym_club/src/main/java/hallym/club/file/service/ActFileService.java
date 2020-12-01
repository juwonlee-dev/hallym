package hallym.club.file.service;

import java.util.List;
import java.util.Map;

import hallym.club.file.vo.ActFileVO;


public interface ActFileService {
	public void addFile(Map <String, Object> params);
	public ActFileVO getFile(Map<String, Object> params);
	public void attachFile(Map<String, Object> params);
	public int getFileListCnt(Map<String, Object> params);
	public List<ActFileVO> getFileList(Map<String, Object> params);
	public void deleteFile(Map<String, Object> params);
	public void deleteClubFile(Map<String, Object> params);

}
