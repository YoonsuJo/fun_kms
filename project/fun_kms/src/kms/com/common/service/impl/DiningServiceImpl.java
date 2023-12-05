package kms.com.common.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import kms.com.common.service.Banner;
import kms.com.common.service.BannerService;
import kms.com.common.service.BannerVO;
import kms.com.common.service.Dining;
import kms.com.common.service.DiningService;
import kms.com.common.service.DiningVO;

@Service("KmsDiningService")
public class DiningServiceImpl implements DiningService {
	@Resource(name="KmsDiningDAO")
    private DiningDAO diningDAO;
	
	@Override
	public List<DiningVO> selectAllDiningList(DiningVO diningVO) throws Exception {
		return diningDAO.selectAllDiningList(diningVO);
	}
	
	@Override
	public int selectAllDiningListTotCnt(DiningVO diningVO) throws Exception {
		return diningDAO.selectAllDiningListTotCnt(diningVO);
	}
	
	@Override
	public DiningVO selectDining(DiningVO diningVO) throws Exception {
		return diningDAO.selectDining(diningVO);
	}
	
	@Override
	public void insertDining(Dining dining) throws Exception {
		diningDAO.insertDining(dining);
	}

	@Override
	public void updateDining(Dining dining) throws Exception {
		diningDAO.updateDining(dining);
	}
}
