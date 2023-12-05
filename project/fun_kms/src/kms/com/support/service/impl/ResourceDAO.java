package kms.com.support.service.impl;

import java.util.List;
import java.util.Map;

import kms.com.support.service.CarFixVO;
import kms.com.support.service.CarReservation;
import kms.com.support.service.CarVO;
import kms.com.support.service.CardVO;
import kms.com.support.service.EquipVO;
import kms.com.support.service.IpVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("KmsResourceDAO")
public class ResourceDAO extends EgovAbstractDAO{

	public List<CarVO> selectCarList(Map<String,Object> param) {
		return list("KmsResourceDAO.selectCarList", param);
	}

	public CarVO selectCarInfo(CarVO carVO) {
		return (CarVO)selectByPk("KmsResourceDAO.selectCarInfo", carVO);
	}

	public void insertCarInfo(CarVO carVO) {
		insert("KmsResourceDAO.insertCarInfo", carVO);
	}

	public void updateCarInfo(CarVO carVO) {
		update("KmsResourceDAO.updateCarInfo", carVO);
	}

	public void deleteCarInfo(CarVO carVO) {
		update("KmsResourceDAO.deleteCarInfo", carVO);
	}

	public List<CarFixVO> selectCarFixList(CarFixVO carFixVO) {
		return list("KmsResourceDAO.selectCarFixList", carFixVO);
	}
	
	public CarFixVO selectCarFixInfo(CarFixVO carFixVO) {
		return (CarFixVO)selectByPk("KmsResourceDAO.selectCarFixInfo", carFixVO);
	}

	public void insertCarFixInfo(CarFixVO carFixVO) {
		insert("KmsResourceDAO.insertCarFixInfo", carFixVO);
	}

	public void updateCarFixInfo(CarFixVO carFixVO) {
		update("KmsResourceDAO.updateCarFixInfo", carFixVO);
	}

	public void deleteCarFixInfo(CarFixVO carFixVO) {
		update("KmsResourceDAO.deleteCarFixInfo", carFixVO);
	}

	public List<CarReservation> selectCarReservationList(CarReservation carRsv) {
		return list("KmsResourceDAO.selectCarReservationList", carRsv);
	}

	public List<CarReservation> selectCarReservationInfoList(
			CarReservation carRsv) {
		return list("KmsResourceDAO.selectCarReservationInfoList", carRsv);
	}
	
	public int selectCarReservationInfoListTotCnt(CarReservation carRsv) {
		return (Integer)getSqlMapClientTemplate().queryForObject("KmsResourceDAO.selectCarReservationInfoListTotCnt", carRsv);
	}

	public CarReservation selectCarReservationInfo(CarReservation carRsv) {
		return (CarReservation)selectByPk("KmsResourceDAO.selectCarReservationInfo", carRsv);
	}

	public void insertCarReservation(CarReservation carRsv) {
		insert("KmsResourceDAO.insertCarReservation", carRsv);
	}

	public void updateCarReservation(CarReservation carRsv) {
		update("KmsResourceDAO.updateCarReservation", carRsv);		
	}

	public void deleteCarReservation(CarReservation carRsv) {
		delete("KmsResourceDAO.deleteCarReservation", carRsv);
	}

	public List<EquipVO> selectEquipList(Map<String, Object> param) {
		return list("KmsResourceDAO.selectEquipList", param);
	}

	public int selectEquipListTotCnt(Map<String, Object> param) {
		return (Integer)getSqlMapClientTemplate().queryForObject("KmsResourceDAO.selectEquipListTotCnt", param);
	}

	public EquipVO selectEquipInfo(EquipVO equipVO) {
		return (EquipVO)selectByPk("KmsResourceDAO.selectEquipInfo", equipVO);
	}

	public EquipVO selectEquipInfoDetail(EquipVO equipVO) {
		return (EquipVO)selectByPk("KmsResourceDAO.selectEquipInfoDetail", equipVO);
	}

	public List<EquipVO> selectEquipHistoryList(EquipVO equipVO) {
		return list("KmsResourceDAO.selectEquipHistoryList", equipVO);
	}

	public void insertEquip(EquipVO equipVO) {
		insert("KmsResourceDAO.insertEquip", equipVO);
	}

	public void updateEquip(EquipVO equipVO) {
		update("KmsResourceDAO.updateEquip", equipVO);
	}

	public void deleteEquip(EquipVO equipVO) {
		delete("KmsResourceDAO.deleteEquip", equipVO);
	}

	public void insertEquipDetail(EquipVO equipVO) {
		insert("KmsResourceDAO.insertEquipDetail", equipVO);
	}

	public void updateEquipDetail(EquipVO equipVO) {
		update("KmsResourceDAO.updateEquipDetail", equipVO);
	}

	public void deleteEquipDetail(EquipVO equipVO) {
		delete("KmsResourceDAO.deleteEquipDetail", equipVO);
	}

	public void updateEquipNotUsed(EquipVO equipVO) {
		update("KmsResourceDAO.updateEquipNotUsed", equipVO);
	}

	public void updateEquipUser(EquipVO equipVO) {
		update("KmsResourceDAO.updateEquipUser", equipVO);
	}

	public String selectMaxIdx(EquipVO equipVO) {
		return (String)getSqlMapClientTemplate().queryForObject("KmsResourceDAO.selectMaxIdx", equipVO);
	}

	//장비사용이력 시작
	public void insertEquipRepair(EquipVO equipVO) {
		insert("KmsResourceDAO.insertEquipRepair", equipVO);
	}

	public void updateEquipRepair(EquipVO equipVO) {
		update("KmsResourceDAO.updateEquipRepair", equipVO);
	}

	public void deleteEquipRepair(EquipVO equipVO) {
		delete("KmsResourceDAO.deleteEquipRepair", equipVO);
	}
	public EquipVO selectEquipInfoRepair(EquipVO equipVO) {
		return (EquipVO)selectByPk("KmsResourceDAO.selectEquipInfoRepair", equipVO);
	}
	public List<EquipVO> selectEquipRepairHistoryList(EquipVO equipVO) {
		return list("KmsResourceDAO.selectEquipRepairHistoryList", equipVO);
	}
	//장비사용이력 끝
	
	public List<EquipVO> selectEquipTypeList() {
		return list("KmsResourceDAO.selectEquipTypeList", null);
	}

	public EquipVO selectEquipTypeInfo(EquipVO equipVO) {
		return (EquipVO)selectByPk("KmsResourceDAO.selectEquipTypeInfo", equipVO);
	}

	public void insertEquipType(EquipVO equipVO) {
		insert("KmsResourceDAO.insertEquipType", equipVO);
	}

	public void updateEquipType(EquipVO equipVO) {
		update("KmsResourceDAO.updateEquipType", equipVO);
	}

	public void deleteEquipType(EquipVO equipVO) {
		delete("KmsResourceDAO.deleteEquipType", equipVO);
	}
	
	// JisangK 20210616 : 사내 IP 관리
	public List<IpVO> selectIpList(IpVO ipVO) {
		return list("KmsResourceDAO.selectIpList", ipVO);
	}
	
	IpVO selectIp(IpVO ipVO) {
		return (IpVO) selectByPk("KmsResourceDAO.selectIp", ipVO);
	}
	
	public IpVO selectIpInfo(IpVO ipVO) {
		return (IpVO)selectByPk("KmsResourceDAO.selectIpInfo", ipVO);
	}

	public void insertIpInfo(IpVO ipVO) {
		insert("KmsResourceDAO.insertIpInfo", ipVO);
	}

	public void updateIpInfo(IpVO ipVO) {
		update("KmsResourceDAO.updateIpInfo", ipVO);
	}

	public void deleteIpInfo(IpVO ipVO) {
		update("KmsResourceDAO.deleteIpInfo", ipVO);
	}
}
