package kms.com.support.service;

import java.util.List;
import java.util.Map;

public interface ResourceService {

	List<CarVO> selectCarList(Map<String,Object> param) throws Exception;
	CarVO selectCarInfo(CarVO carVO) throws Exception;
	void insertCarInfo(CarVO carVO) throws Exception;
	void updateCarInfo(CarVO carVO) throws Exception;
	void deleteCarInfo(CarVO carVO) throws Exception;
	
	List<CarFixVO> selectCarFixList(CarFixVO carFixVO) throws Exception;
	CarFixVO selectCarFixInfo(CarFixVO carFixVO) throws Exception;
	void insertCarFixInfo(CarFixVO carFixVO) throws Exception;
	void updateCarFixInfo(CarFixVO carFixVO) throws Exception;
	void deleteCarFixInfo(CarFixVO carFixVO) throws Exception;

	List<CarReservationVO> selectCarReservationCalendar(CarReservation carRsv) throws Exception;
	List<CarReservation> selectCarReservationInfoList(CarReservation carRsv) throws Exception;
	int selectCarReservationInfoListTotCnt(CarReservation carRsv) throws Exception;
	CarReservation selectCarReservationInfo(CarReservation carRsv) throws Exception;
	void insertCarReservation(CarReservation carRsv) throws Exception;
	void updateCarReservation(CarReservation carRsv) throws Exception;
	void deleteCarReservation(CarReservation carRsv) throws Exception;

	List<EquipVO> selectEquipList(Map<String, Object> param) throws Exception;
	int selectEquipListTotCnt(Map<String, Object> param) throws Exception;
	EquipVO selectEquipInfo(EquipVO equipVO) throws Exception;
	EquipVO selectEquipInfoDetail(EquipVO equipVO) throws Exception;
	List<EquipVO> selectEquipHistoryList(EquipVO equipVO) throws Exception;

	void insertEquip(EquipVO equipVO) throws Exception;
	void updateEquip(EquipVO equipVO) throws Exception;
	void deleteEquip(EquipVO equipVO) throws Exception;

	void insertEquipDetail(EquipVO equipVO) throws Exception;
	void updateEquipDetail(EquipVO equipVO) throws Exception;
	void deleteEquipDetail(EquipVO equipVO) throws Exception;
	void updateEquipNotUsed(EquipVO equipVO) throws Exception;
	void updateEquipUser(EquipVO equipVO) throws Exception;

	String selectMaxIdx(EquipVO equipVO) throws Exception;
	
	void insertEquipRepair(EquipVO equipVO) throws Exception;
	void updateEquipRepair(EquipVO equipVO) throws Exception;
	void deleteEquipRepair(EquipVO equipVO) throws Exception;
	EquipVO selectEquipInfoRepair(EquipVO equipVO) throws Exception;
	List<EquipVO> selectEquipRepairHistoryList(EquipVO equipVO) throws Exception;
	
	List<EquipVO> selectEquipTypeList() throws Exception;
	EquipVO selectEquipTypeInfo(EquipVO equipVO) throws Exception;
	
	void insertEquipType(EquipVO equipVO) throws Exception;
	void updateEquipType(EquipVO equipVO) throws Exception;
	void deleteEquipType(EquipVO equipVO) throws Exception;
	
	// JisangK 20210616 : 사내 IP 관리
	List<IpVO> selectIpList(IpVO ipVO) throws Exception;
	IpVO selectIp(IpVO ipVO) throws Exception;
	IpVO selectIpInfo(IpVO ipVO) throws Exception;
	void insertIpInfo(IpVO ipVO) throws Exception;
	void updateIpInfo(IpVO ipVO) throws Exception;
	void deleteIpInfo(IpVO ipVO) throws Exception;
	
}
