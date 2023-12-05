package kms.com.product.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

import kms.com.product.service.ProductOutputInfoVO;
import kms.com.product.service.ProductOutputVO;
import kms.com.product.service.ProductRequestCommentVO;
import kms.com.product.service.ProductRequestHistoryVO;
import kms.com.product.service.ProductRequestVO;
import kms.com.product.vo.ProductVO;
import kms.com.product.vo.PartVO;
import kms.com.product.vo.VersionVO;
import kms.com.product.vo.RelationVO;
import kms.com.product.fm.PartFm;


@Repository("KmsProductDAO")
public class ProductDAO extends EgovAbstractDAO {
	Logger logT = Logger.getLogger("TENY");

	//////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////
	// 제품 관련 SQL
	// TENY_170529 제품 추가 SQL
	public int selectProductMaxSortNo() {
		// TODO Auto-generated method stub
		return (Integer)getSqlMapClientTemplate().queryForObject("ProductDAO.selectProductMaxSortNo");
	}

	public void insertProduct(ProductVO formVO) {
		logT.debug("START");
		formVO.setSortNo(selectProductMaxSortNo());
		insert("ProductDAO.insertProduct", formVO);
	}

	// TENY_170529 제품 조회 SQL
	public ProductVO selectProduct(int no) {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", no);
		return (ProductVO)selectByPk("ProductDAO.selectProduct", map);
	}
	// TENY_170529 제품 수정 SQL
	public void updateProduct(ProductVO formVO) {
		logT.debug("START");
		update("ProductDAO.updateProduct", formVO);
	}
	
	// TENY_170529 제품 목록 조회 SQL
	public List<ProductVO> selectProductList(ProductVO formVO) {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("useAt", formVO.getUseAt());
		return list("ProductDAO.selectProductList", map);
	}
	
	public void updateProductSortNoUp(ProductVO formVO) {
		// TODO Auto-generated method stub
		update("ProductDAO.updateProductSortNoUpStep1", formVO);
		update("ProductDAO.updateProductSortNoUpStep2", formVO);
	}
	
	public void updateProductSortNoDn(ProductVO formVO) {
		// TODO Auto-generated method stub
		update("ProductDAO.updateProductSortNoDnStep1", formVO);
		update("ProductDAO.updateProductSortNoDnStep2", formVO);
	}

	//////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////
	// 구성품 관련 SQL
	// TENY_170529 구성품 추가 SQL
	public int selectPartMaxSortNo(PartVO formVO) {
		// TODO Auto-generated method stub
		return (Integer)getSqlMapClientTemplate().queryForObject("ProductDAO.selectPartMaxSortNo", formVO);
	}

	public void insertPart(PartVO formVO) {
		logT.debug("START");
		formVO.setSortNo(selectPartMaxSortNo(formVO));
		insert("ProductDAO.insertPart", formVO);
	}

	public PartVO selectPart(int no) {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", no);
		return (PartVO)selectByPk("ProductDAO.selectPart", no);
	}

	public void updatePart(PartVO formVO) {
		update("ProductDAO.updatePart", formVO);
	}
	
	public List<PartVO> selectPartList(PartFm fm) {
		logT.debug("START");

		return list("ProductDAO.selectPartList", fm);
	}

	// TENY_170709  한 제품이 갖는 구성품 목록 조회 SQL
	public List<PartVO> selectPartListOfProduct(int productNo) {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productNo", productNo);

		return list("ProductDAO.selectPartListOfProduct", map);
	}

	// TENY_170704  하위 구성품(모듈)을 선택하기 제공하는 구성품 목록 조회 SQL
	// 이미 선택되어 있는 구성품은 제외한다.
	public List<PartVO> selectPartListForChoice(PartFm fm) {
		logT.debug("START");

		return list("ProductDAO.selectPartListForChoice", fm);
	}
	
	// TENY_170704 한모듈이 사용하는 하위 구성품(모듈) 목록 조회 SQL
	public List<PartVO> selectSubPartList(PartFm fm) {
		logT.debug("START");

		return list("ProductDAO.selectSubPartList", fm);
	}
	
	public void updatePartSortNo(PartVO vo) {
		// TODO Auto-generated method stub
		update("ProductDAO.updatePartSortNo", vo);
	}
	
	public void deletePart(PartVO vo) {
		logT.debug("START");
		update("ProductDAO.deletePart", vo);
	}
	
	
	//////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////
	// 버젼 관련 SQL
	// TENY_170529 버전 추가 SQL
	public void insertVersion(VersionVO formVO) {
		logT.debug("START");
		insert("ProductDAO.insertVersion", formVO);
	}

	public VersionVO selectVersion(int no) {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", no);
		return (VersionVO)selectByPk("ProductDAO.selectVersion", map);
	}

	public void updateVersion(VersionVO formVO) {
		logT.debug("START");
		update("ProductDAO.updateVersion", formVO);
	}
	
	public void deleteVersion(VersionVO formVO) {
		logT.debug("START");
		update("ProductDAO.deleteVersion", formVO);
	}
	
	public List<VersionVO> selectVersionList(int partNo) {
		logT.debug("START");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("partNo", partNo);

		return list("ProductDAO.selectVersionList", map);
	}
	
	//////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////
	// 관계 관련 SQL
	// TENY_170704 버전 추가 SQL
	public void insertRelation(RelationVO vo) {
		logT.debug("START");
		
		insert("ProductDAO.insertRelation", vo);
	}
	
	public void deleteRelation(RelationVO vo) {
		logT.debug("START");
		
		insert("ProductDAO.deleteRelation", vo);
	}
	
}
