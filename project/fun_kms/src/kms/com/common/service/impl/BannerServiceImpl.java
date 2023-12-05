package kms.com.common.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import kms.com.common.service.Banner;
import kms.com.common.service.BannerService;
import kms.com.common.service.BannerVO;

@Service("KmsBannerService")
public class BannerServiceImpl implements BannerService {
	@Resource(name="KmsBannerDAO")
    private BannerDAO bannerDAO;

	@Resource(name="kmsBannerIdGnrService")
	private EgovIdGnrService idGnrService;
	
	@Override
	public List<BannerVO> selectAllBannerList(BannerVO bannerVO) throws Exception {
		return bannerDAO.selectAllBannerList(bannerVO);
	}

	@Override
	public int selectAllBannerListTotCnt(BannerVO bannerVO) throws Exception {
		return bannerDAO.selectAllBannerListTotCnt(bannerVO);
	}

	@Override
	public List<BannerVO> selectBannerList(BannerVO bannerVO) throws Exception {
		return bannerDAO.selectBannerList(bannerVO);
	}

	@Override
	public int selectBannerListTotCnt(BannerVO bannerVO) throws Exception {
		return bannerDAO.selectBannerListTotCnt(bannerVO);
	}

	@Override
	public BannerVO selectBanner(BannerVO bannerVO) throws Exception {
		return bannerDAO.selectBanner(bannerVO);
	}
	
	@Override
	public void insertBanner(Banner banner) throws Exception {
		String bnrId = idGnrService.getNextStringId();
		
		banner.setBnrId(bnrId);
		
		bannerDAO.insertBanner(banner);
	}

	@Override
	public void updateBanner(Banner banner) throws Exception {
		bannerDAO.updateBanner(banner);
	}

	@Override
	public void changeBannerOrder(Banner banner) throws Exception {
		bannerDAO.changeBannerOrder(banner);
	}
}
