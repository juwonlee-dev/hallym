package hallym.club.club.vo;

public class ClubVO {
	private int club_id;
	private String club_nm;
	private String club_gb_cd;
	private String club_at_cd;
	private int cnt;
	private String club_aim;
	private String club_active;
	private String club_room;
	private String open_dt;
	private String intro_cont;
	private String intro_file_nm;
	private String intro_save_file_nm;
	private String intro_file_path;
	private String input_id;
	private String input_ip;
	private String input_date;
	private String poster_file_nm;
	private String poster_save_file_nm;
	private String register_cd;
	private String topClub_YN;
	private String topClub_rank;
	
	private String gb_nm;
	private String at_nm;
	
	private String president;
	
	
	private int row_count;
	@Override
	public String toString() {
		return "ClubVO [club_id=" + club_id + ", club_nm=" + club_nm + ", club_gb_cd=" + club_gb_cd + ", club_at_cd="
				+ club_at_cd + ", cnt=" + cnt + ", club_aim=" + club_aim + ", club_active=" + club_active
				+ ", club_room=" + club_room + ", open_dt=" + open_dt + ", intro_cont=" + intro_cont
				+ ", intro_file_nm=" + intro_file_nm + ", intro_save_file_nm=" + intro_save_file_nm
				+ ", intro_file_path=" + intro_file_path + ", input_id=" + input_id + ", input_ip=" + input_ip
				+ ", input_date=" + input_date + ", poster_file_nm=" + poster_file_nm + ", poster_save_file_nm="
				+ poster_save_file_nm + ", register_cd=" + register_cd + ", topClub_YN=" + topClub_YN
				+ ", topClub_rank=" + topClub_rank + ", gb_nm=" + gb_nm + ", at_nm=" + at_nm + ", row_count="
				+ row_count + "]";
	}

	public String getGb_nm() {
		return gb_nm;
	}

	public void setGb_nm(String gb_nm) {
		this.gb_nm = gb_nm;
	}

	public String getAt_nm() {
		return at_nm;
	}

	public void setAt_nm(String at_nm) {
		this.at_nm = at_nm;
	}

	public String getTopClub_YN() {
		return topClub_YN;
	}

	public void setTopClub_YN(String topClub_YN) {
		this.topClub_YN = topClub_YN;
	}

	public String getTopClub_rank() {
		return topClub_rank;
	}

	public void setTopClub_rank(String topClub_rank) {
		this.topClub_rank = topClub_rank;
	}

	public String getRegister_cd() {
		return register_cd;
	}

	public void setRegister_cd(String register_cd) {
		this.register_cd = register_cd;
	}

	public ClubVO() {
	}

	public String getIntro_save_file_nm() {
		return intro_save_file_nm;
	}

	public void setIntro_save_file_nm(String intro_save_file_nm) {
		this.intro_save_file_nm = intro_save_file_nm;
	}

	public String getIntro_file_path() {
		return intro_file_path;
	}

	public void setIntro_file_path(String intro_file_path) {
		this.intro_file_path = intro_file_path;
	}

	public int getClub_id() {
		return club_id;
	}

	public void setClub_id(int club_id) {
		this.club_id = club_id;
	}

	public String getClub_nm() {
		return club_nm;
	}

	public void setClub_nm(String club_nm) {
		this.club_nm = club_nm;
	}

	public String getClub_gb_cd() {
		return club_gb_cd;
	}

	public void setClub_gb_cd(String club_gb_cd) {
		this.club_gb_cd = club_gb_cd;
	}

	public String getClub_at_cd() {
		return club_at_cd;
	}

	public void setClub_at_cd(String club_at_cd) {
		this.club_at_cd = club_at_cd;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getClub_aim() {
		return club_aim;
	}

	public void setClub_aim(String club_aim) {
		this.club_aim = club_aim;
	}

	public String getClub_active() {
		return club_active;
	}

	public void setClub_active(String club_active) {
		this.club_active = club_active;
	}

	public String getClub_room() {
		return club_room;
	}

	public void setClub_room(String club_room) {
		this.club_room = club_room;
	}

	public String getOpen_dt() {
		return open_dt;
	}

	public void setOpen_dt(String open_dt) {
		this.open_dt = open_dt;
	}

	public String getIntro_cont() {
		return intro_cont;
	}

	public void setIntro_cont(String intro_cont) {
		this.intro_cont = intro_cont;
	}

	public String getIntro_file_nm() {
		return intro_file_nm;
	}

	public void setIntro_file_nm(String intro_file_nm) {
		this.intro_file_nm = intro_file_nm;
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

	public String getPoster_file_nm() {
		return poster_file_nm;
	}

	public void setPoster_file_nm(String poster_file_nm) {
		this.poster_file_nm = poster_file_nm;
	}

	public String getPoster_save_file_nm() {
		return poster_save_file_nm;
	}

	public void setPoster_save_file_nm(String poster_save_file_nm) {
		this.poster_save_file_nm = poster_save_file_nm;
	}

	public int getRow_count() {
		return row_count;
	}

	public void setRow_count(int row_count) {
		this.row_count = row_count;
	}

	public String getPresident() {
		return president;
	}

	public void setPresident(String president) {
		this.president = president;
	}
}
