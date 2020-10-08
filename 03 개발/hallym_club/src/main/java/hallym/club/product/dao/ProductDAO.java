package hallym.club.product.dao;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import hallym.club.product.vo.ProductVO;

@Mapper("productDAO")
public interface ProductDAO {
	
	public void insertProduct(Map<String, Object> params);
	public void deleteProduct(Map<String, Object> params);
	public List<ProductVO> getProducts(Map<String, Object> params);
	
}
