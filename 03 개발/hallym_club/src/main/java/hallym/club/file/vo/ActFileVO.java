package hallym.club.file.vo;

public class ActFileVO {
	private int club_id;
	private int act_no;
	private int file_no;
	private String act_cd;
	private String file_nm;
	private String file_save_nm;
	private String file_path;
	private String enclude_yn;
	private String input_id;
	private String input_ip;
	private String input_date;
	private String update_id;
	private String update_ip;
	private String update_date;

	@Override
	public String toString() {
		return "ActFileVO [club_id=" + club_id + ", act_no=" + act_no + ", file_no=" + file_no + ", file_nm=" + file_nm
				+ ", file_save_nm=" + file_save_nm + ", file_path=" + file_path + ", input_id=" + input_id
				+ ", input_ip=" + input_ip + ", input_date=" + input_date + ", update_id=" + update_id + ", update_ip="
				+ update_ip + ", update_date=" + update_date + "]";
	}

	public String getEnclude_yn() {
		return enclude_yn;
	}

	public void setEnclude_yn(String enclude_yn) {
		this.enclude_yn = enclude_yn;
	}

	public int getClub_id() {
		return club_id;
	}

	public void setClub_id(int club_id) {
		this.club_id = club_id;
	}

	public int getFile_no() {
		return file_no;
	}

	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}

	public String getFile_nm() {
		return file_nm;
	}

	public void setFile_nm(String file_nm) {
		this.file_nm = file_nm;
	}

	public String getFile_save_nm() {
		return file_save_nm;
	}

	public void setFile_save_nm(String file_save_nm) {
		this.file_save_nm = file_save_nm;
	}

	public String getFile_path() {
		return file_path;
	}

	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}

	public String getInput_id() {
		return input_id;
	}

	public void setInput_id(String input_id) {
		this.input_id = input_id;
	}

	public String getInput_ip() {
		return input_ip;
	}

	public void setInput_ip(String input_ip) {
		this.input_ip = input_ip;
	}

	public String getInput_date() {
		return input_date;
	}

	public void setInput_date(String input_date) {
		this.input_date = input_date;
	}

	public String getUpdate_id() {
		return update_id;
	}

	public void setUpdate_id(String update_id) {
		this.update_id = update_id;
	}

	public String getUpdate_ip() {
		return update_ip;
	}

	public void setUpdate_ip(String update_ip) {
		this.update_ip = update_ip;
	}

	public String getUpdate_date() {
		return update_date;
	}

	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}

	public int getAct_no() {
		return act_no;
	}

	public void setAct_no(int act_no) {
		this.act_no = act_no;
	}

	public String getAct_cd() {
		return act_cd;
	}

	public void setAct_cd(String act_cd) {
		this.act_cd = act_cd;
	}
}
