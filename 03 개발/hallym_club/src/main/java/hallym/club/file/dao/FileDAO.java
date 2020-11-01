package hallym.club.file.dao;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import hallym.club.file.vo.FileVO;

@Mapper("fileDAO")
public interface FileDAO {
	public void addFile(Map<String, Object> params);
	public FileVO getFile(Map<String, Object> params);
	public void attachFile(Map<String, Object> params);
	public int getFileListCnt(Map<String, Object> params);
	public List<FileVO> getFileList(Map<String, Object> params);
	public void deleteFile(Map<String, Object> params);
	public void deleteClubFile(Map<String, Object> params);

}
