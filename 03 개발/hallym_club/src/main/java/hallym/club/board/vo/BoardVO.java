package hallym.club.board.vo;

public class BoardVO {
	private int club_id;
	private int board_no;
	private String board_cd;
	private String title;
	private String contents;
	private int open_cnt;
	private int bbsAvailable;
	private String start_date;
	private String end_date;
	private String agree_yn;
	private String input_id;
	private String input_ip;
	private String input_date;
	private String update_id;
	private String update_ip;
	private String update_date;
	private String board_fix;

	private int row_count;

	@Override
	public String toString() {
		return "BoardVO [club_id=" + club_id + ", board_no=" + board_no + ", board_cd=" + board_cd + ", title=" + title
				+ ", contents=" + contents + ", open_cnt=" + open_cnt + ", bbsAvailable=" + bbsAvailable
				+ ", start_date=" + start_date + ", end_date=" + end_date + ", agree_yn=" + agree_yn + ", input_id="
				+ input_id + ", input_ip=" + input_ip + ", input_date=" + input_date + ", update_id=" + update_id
				+ ", update_ip=" + update_ip + ", update_date=" + update_date + ", board_fix=" + board_fix
				+ ", row_count=" + row_count + "]";
	}

	public int getClub_id() {
		return club_id;
	}

	public void setClub_id(int club_id) {
		this.club_id = club_id;
	}

	public int getBoard_no() {
		return board_no;
	}

	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}

	public String getBoard_cd() {
		return board_cd;
	}

	public void setBoard_cd(String board_cd) {
		this.board_cd = board_cd;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getOpen_cnt() {
		return open_cnt;
	}

	public void setOpen_cnt(int open_cnt) {
		this.open_cnt = open_cnt;
	}

	public int getBbsAvailable() {
		return bbsAvailable;
	}

	public void setBbsAvailable(int bbsAvailable) {
		this.bbsAvailable = bbsAvailable;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getAgree_yn() {
		return agree_yn;
	}

	public void setAgree_yn(String agree_yn) {
		this.agree_yn = agree_yn;
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

	public String getBoard_fix() {
		if(board_fix == null)
			this.setBoard_fix("N");
		return board_fix;
	}

	public void setBoard_fix(String board_fix) {
		this.board_fix = board_fix;
	}

	public int getRow_count() {
		return row_count;
	}

	public void setRow_count(int row_count) {
		this.row_count = row_count;
	}

	
	
}