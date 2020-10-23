package hallym.club.common.vo;

public class TermsVO {
	private String IDNO;
	private String TERMS_CD;
	private String NAME;
	private String AGREE_YN;
	private String AGREE_DATE;
	private String AGREE_IP;
	
	
	@Override
	public String toString() {
		return "TermsVO [IDNO=" + IDNO + ", TERMS_CD=" + TERMS_CD + ", NAME=" + NAME + ", AGREE_YN=" + AGREE_YN
				+ ", AGREE_DATE=" + AGREE_DATE + ", AGREE_IP=" + AGREE_IP + "]";
	}
	
	public String getIDNO() {
		return IDNO;
	}
	public void setIDNO(String iDNO) {
		IDNO = iDNO;
	}
	
	public String getTERMS_CD() {
		return TERMS_CD;
	}
	public void setTERMS_CD(String tERMS_CD) {
		TERMS_CD = tERMS_CD;
	}
	
	public String getNAME() {
		return NAME;
	}
	public void setNAME(String nAME) {
		NAME = nAME;
	}
	
	public String getAGREE_YN() {
		return AGREE_YN;
	}
	public void setAGREE_YN(String aGREE_YN) {
		AGREE_YN = aGREE_YN;
	}
	
	public String getAGREE_DATE() {
		return AGREE_DATE;
	}
	public void setAGREE_DATE(String aGREE_DATE) {
		AGREE_DATE = aGREE_DATE;
	}
	
	public String getAGREE_IP() {
		return AGREE_IP;
	}
	public void setAGREE_IP(String aGREE_IP) {
		AGREE_IP = aGREE_IP;
	}

}
