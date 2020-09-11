package hallym.club.user.vo;

public class UserVO {

	/*
	 * 		
	 * 
	 * 
	 * 
	 * IDNO, NAME, MAJORNAME, GRADE, GENDER, PHONENUMBER, E_MAIL, RESIDENTNO
	 * 
	 */
	private String id;
	private String identity;
	private String condition;
	private String resident;
	private String name;
	private String univ;
	private String dept;
	private String major;
	private String major2;
	private String grade;
	private String semester;
	private String e_mail;
	private String phoneNumber;
	private String gender;
	private String admin_cd;

	public String toString() {
		return "UserVO [id=" + id + ", identity=" + identity + ", condition=" + condition + ", resident=" + resident
				+ ", name=" + name + ", univ=" + univ + ", dept=" + dept + ", major=" + major + ", major2=" + major2
				+ ", grade=" + grade + ", semester=" + semester + ", e_mail=" + e_mail + ", phoneNumber=" + phoneNumber
				+ ", gender=" + gender + ", admin_cd=" + admin_cd +"]";
	}

	public String getAdmin_cd() {
		return admin_cd;
	}

	public void setAdmin_cd(String admin_cd) {
		this.admin_cd = admin_cd;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getIdentity() {
		return identity;
	}
	public void setIdentity(String identity) {
		this.identity = identity;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public String getResident() {
		return resident;
	}
	public void setResident(String resident) {
		this.resident = resident;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUniv() {
		return univ;
	}
	public void setUniv(String univ) {
		this.univ = univ;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getMajor2() {
		return major2;
	}
	public void setMajor2(String major2) {
		this.major2 = major2;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getSemester() {
		return semester;
	}
	public void setSemester(String semester) {
		this.semester = semester;
	}
	public String getE_mail() {
		return e_mail;
	}
	public void setE_mail(String e_mail) {
		this.e_mail = e_mail;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}



}
