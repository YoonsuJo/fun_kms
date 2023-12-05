package kms.com.product.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import kms.com.product.dao.ProductDAO;
import kms.com.product.service.ProductService;
import kms.com.product.vo.PartVO;
import kms.com.product.vo.ProductVO;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("KmsProductService")
public class ProductService {

	@Resource(name = "KmsProductDAO")
	private ProductDAO productDAO;
	
	public void insertProduct(ProductVO formVO) throws Exception {
		productDAO.insertProduct(formVO);
	}

	public List<ProductVO> selectProductList(ProductVO formVO) {
		
		List<ProductVO> productList = productDAO.selectProductList(formVO);
		List<ProductVO> productInfoList = new ArrayList<ProductVO>();
		
		return productInfoList;
	}

	
	public void updateProduct(ProductVO formVO) {
		// TODO Auto-generated method stub
		productDAO.updateProduct(formVO);
	}
	
	public void updateProductSortNoUp(ProductVO formVO) {
		// TODO Auto-generated method stub
		productDAO.updateProductSortNoUp(formVO);
	}
	
	public void updateProductSortNoDn(ProductVO formVO) {
		// TODO Auto-generated method stub
		productDAO.updateProductSortNoDn(formVO);
	}
	
	public void insertPart(PartVO formVO) throws Exception {
	}

	public void updatePart(PartVO formVO) {
		// TODO Auto-generated method stub
		productDAO.updatePart(formVO);
	}
	
}
