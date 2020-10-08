package hallym.club.product.service;

import java.util.List;
import java.util.Map;

import hallym.club.product.vo.ProductVO;

public interface ProductService {


	public void insertProduct(Map<String, Object> params);
	public void deleteProduct(Map<String, Object> params);
	public List<ProductVO> getProducts(Map<String, Object> params);
}
