package hallym.club.file.service;

import java.util.List;
import java.util.Map;
import hallym.club.file.vo.FileVO;


public interface FileService {
	public void addFile(Map <String, Object> params);
	public FileVO getFile(Map<String, Object> params);
	public void attachFile(Map<String, Object> params);
	public int getFileListCnt(Map<String, Object> params);
	public List<FileVO> getFileList(Map<String, Object> params);
	public void deleteFile(Map<String, Object> params);

}
