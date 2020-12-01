package hallym.club.product.service;

import java.util.List;
import java.util.Map;

import hallym.club.board.vo.BoardVO;
import hallym.club.product.vo.ProductVO;

public interface ProductService {


	public void insertProduct(Map<String, Object> params);
	public void deleteProduct(Map<String, Object> params);
	public List<ProductVO> getProducts(Map<String, Object> params);
	

	public List<ProductVO> getProductList(Map<String, Object> params);
	public int getTotalPageCnt(Map<String, Object> params);
	public int getProductListCnt(Map<String, Object> params);
}
