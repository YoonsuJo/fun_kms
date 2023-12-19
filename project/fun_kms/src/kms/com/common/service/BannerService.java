package kms.com.common.service;

import java.util.List;

public interface BannerService {

	List<BannerVO> selectAllBannerList(BannerVO bannerVO) throws Exception;
	int selectAllBannerListTotCnt(BannerVO bannerVO) throws Exception;
	
//	User main
	List<BannerVO> selectBannerList(BannerVO bannerVO) throws Exception;
	int selectBannerListTotCnt(BannerVO bannerVO) throws Exception;
	
	BannerVO selectBanner(BannerVO bannerVO) throws Exception;
	
	void insertBanner(Banner banner) throws Exception;
	void updateBanner(Banner banner) throws Exception;
	void changeBannerOrder(Banner banner) throws Exception;
}
