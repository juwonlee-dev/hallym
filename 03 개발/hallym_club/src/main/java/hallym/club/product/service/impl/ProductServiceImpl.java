package hallym.club.product.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import hallym.club.product.dao.ProductDAO;
import hallym.club.product.service.ProductService;
import hallym.club.product.vo.ProductVO;

@Service("productService")
public class ProductServiceImpl implements ProductService{

	
	@Resource(name = "productDAO")
	private ProductDAO productDAO;
	
	@Override
	public void insertProduct(Map<String, Object> params) {
		productDAO.insertProduct(params);
	}

	@Override
	public void deleteProduct(Map<String, Object> params) {
		productDAO.deleteProduct(params);
	}
	
	@Override
	public List<ProductVO> getProducts(Map<String, Object> params) {
		return productDAO.getProducts(params);
	}

	@Override
	public List<ProductVO> getProductList(Map<String, Object> params) {
		return productDAO.getProductList(params);
	}

	@Override
	public int getTotalPageCnt(Map<String, Object> params) {
		int totalPageCnt = 0;
		
		try {
			totalPageCnt = productDAO.getTotalPageCnt(params);
		} catch (Exception e) {
			System.err.println("[ProductServiceImpl] getTotalPageCnt ERR: " + e.getMessage());
		}
		return totalPageCnt;
	}

	@Override
	public int getProductListCnt(Map<String, Object> params) {
		int productListCnt = 0;
		
		try {
			productListCnt = productDAO.getProductListCnt(params);
		} catch (Exception e) {
			System.err.println("[ProductServiceImpl] getProductListCnt ERR: " + e.getMessage());
		}
		return productListCnt;
	}



	

}
