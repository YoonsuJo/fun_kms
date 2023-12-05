package kms.com.common.service.impl;

import java.util.List;

import kms.com.common.service.Banner;
import kms.com.common.service.BannerVO;
import kms.com.common.service.Dining;
import kms.com.common.service.DiningVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("KmsDiningDAO")
public class DiningDAO extends EgovAbstractDAO {

	public List<DiningVO> selectAllDiningList(DiningVO diningVO) {
		return list("DiningDAO.selectAllDiningList", diningVO);
	}
	
	public int selectAllDiningListTotCnt(DiningVO diningVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("DiningDAO.selectAllDiningListTotCnt", diningVO);
	}
	
	public DiningVO selectDining(DiningVO diningVO) {
		return (DiningVO)selectByPk("DiningDAO.selectDining", diningVO);
	}
	
	public void insertDining(Dining dining) {
		insert("DiningDAO.insertDining", dining);
	}

	public void updateDining(Dining dining) {
		update("DiningDAO.updateDining", dining);
	}

}
