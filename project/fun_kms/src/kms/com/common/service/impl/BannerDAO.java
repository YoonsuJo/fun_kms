package kms.com.common.service.impl;

import java.util.List;

import kms.com.common.service.Banner;
import kms.com.common.service.BannerVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("KmsBannerDAO")
public class BannerDAO extends EgovAbstractDAO {

	public List<BannerVO> selectAllBannerList(BannerVO bannerVO) {
		return list("BannerDAO.selectAllBannerList", bannerVO);
	}

	public int selectAllBannerListTotCnt(BannerVO bannerVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("BannerDAO.selectAllBannerListTotCnt", bannerVO);
	}

	public List<BannerVO> selectBannerList(BannerVO bannerVO) {
		return list("BannerDAO.selectBannerList", bannerVO);
	}

	public int selectBannerListTotCnt(BannerVO bannerVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("BannerDAO.selectBannerListTotCnt", bannerVO);
	}

	public BannerVO selectBanner(BannerVO bannerVO) {
		return (BannerVO)selectByPk("BannerDAO.selectBanner", bannerVO);
	}

	public void insertBanner(Banner banner) {
		insert("BannerDAO.insertBanner", banner);
	}

	public void updateBanner(Banner banner) {
		update("BannerDAO.updateBanner", banner);
	}
	
	public void changeBannerOrder(Banner banner) {
		update("BannerDAO.changeBannerOrder", banner);
	}

}
