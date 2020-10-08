package hallym.club.product.vo;

public class ProductVO {
	
	private int club_id;  // 클럽 아이디
	private String productNM; // 아이탬 명
	private String productCont; // 아이탬 설명
	private int totCnt; // 아이탬 총개수
	
	@Override
	public String toString() {
		return "ProductVO [club_id=" + club_id + ", productNM=" + productNM + ", productCont=" + productCont
				+ ", totCnt=" + totCnt + "]";
	}
	public String getProductNM() {
		return productNM;
	}
	public void setProductNM(String productNM) {
		this.productNM = productNM;
	}
	public String getProductCont() {
		return productCont;
	}
	public void setProductCont(String productCont) {
		this.productCont = productCont;
	}
	public int getTotCnt() {
		return totCnt;
	}
	public void setTotCnt(int totCnt) {
		this.totCnt = totCnt;
	}

	public int getClub_id() {
		return club_id;
	}

	public void setClub_id(int club_id) {
		this.club_id = club_id;
	}

	

}
