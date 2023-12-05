package kms.com.support.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kms.com.common.utils.CalendarUtil;
import kms.com.community.service.CalendarVO;
import kms.com.community.service.ScheduleVO;
import kms.com.support.service.CarFixVO;
import kms.com.support.service.CarReservation;
import kms.com.support.service.CarReservationVO;
import kms.com.support.service.CarVO;
import kms.com.support.service.EquipVO;
import kms.com.support.service.IpVO;
import kms.com.support.service.ResourceService;

@Service("KmsResourceService")
public class ResourceServiceImpl implements ResourceService {

	@Resource(name="KmsResourceDAO")
	private ResourceDAO resourceDAO;
	
	@Override
	public List<CarVO> selectCarList(Map<String,Object> param) throws Exception {
		return resourceDAO.selectCarList(param);
	}

	@Override
	public CarVO selectCarInfo(CarVO carVO) throws Exception {
		return resourceDAO.selectCarInfo(carVO);
	}

	@Override
	public void insertCarInfo(CarVO carVO) throws Exception {
		resourceDAO.insertCarInfo(carVO);
	}
	@Override
	public void updateCarInfo(CarVO carVO) throws Exception {
		resourceDAO.updateCarInfo(carVO);
	}
	
	@Override
	public void deleteCarInfo(CarVO carVO) throws Exception {
		resourceDAO.deleteCarInfo(carVO);
	}

	@Override
	public List<CarFixVO> selectCarFixList(CarFixVO carFixVO) throws Exception {
		return resourceDAO.selectCarFixList(carFixVO);
	}
	
	@Override
	public CarFixVO selectCarFixInfo(CarFixVO carFixVO) throws Exception {
		return resourceDAO.selectCarFixInfo(carFixVO);
	}
	
	@Override
	public void insertCarFixInfo(CarFixVO carFixVO) throws Exception {
		resourceDAO.insertCarFixInfo(carFixVO);
	}
	
	@Override
	public void updateCarFixInfo(CarFixVO carFixVO) throws Exception {
		resourceDAO.updateCarFixInfo(carFixVO);
	}
	
	@Override
	public void deleteCarFixInfo(CarFixVO carFixVO) throws Exception {
		resourceDAO.deleteCarFixInfo(carFixVO);
	}

	@Override
	public List<CarReservationVO> selectCarReservationCalendar(CarReservation carRsv) throws Exception {
		List<CarReservationVO> resultList = new ArrayList<CarReservationVO>();
		
		List<CarReservation> crList = resourceDAO.selectCarReservationList(carRsv);
		
		int lastDate = CalendarUtil.getLastDateOfMonth(carRsv.getSearchDate());
		for (int i=1; i<=lastDate; i++) {
			String dd = (i<10) ? "0" + i : String.valueOf(i);
			
			CarReservationVO vo = new CarReservationVO(carRsv.getSearchDate().substring(0,4), carRsv.getSearchDate().substring(4,6), dd);
			
			if (i == 1) vo.setFirstDate(true);
			if (i == lastDate) vo.setLastDate(true);
			
			for (int j=0; j<crList.size(); j++) {
				CarReservation cr = crList.get(j);
				
				if (Integer.parseInt(cr.getStDt()) <= Integer.parseInt(carRsv.getSearchDate().substring(0,6) + dd)
						&& Integer.parseInt(cr.getEdDt()) >= Integer.parseInt(carRsv.getSearchDate().substring(0,6) + dd)) {
					vo.addCarRsvList(cr);
				}
				
				if (cr.getEdDt().equals(carRsv.getSearchDate().substring(0,6) + dd)) {
					crList.remove(j);
					j--;
				}
			}
			resultList.add(vo);
		}
		
		return resultList;
	}

	@Override
	public List<CarReservation> selectCarReservationInfoList(CarReservation carRsv) throws Exception {
		return resourceDAO.selectCarReservationInfoList(carRsv);
	}

	@Override
	public int selectCarReservationInfoListTotCnt(CarReservation carRsv) throws Exception {
		return resourceDAO.selectCarReservationInfoListTotCnt(carRsv);
	}
	
	@Override
	public CarReservation selectCarReservationInfo(CarReservation carRsv) throws Exception {
		return resourceDAO.selectCarReservationInfo(carRsv);
	}
	
	@Override
	public void insertCarReservation(CarReservation carRsv) throws Exception {
		resourceDAO.insertCarReservation(carRsv);
	}
	
	@Override
	public void updateCarReservation(CarReservation carRsv) throws Exception {
		resourceDAO.updateCarReservation(carRsv);
	}
	
	@Override
	public void deleteCarReservation(CarReservation carRsv) throws Exception {
		resourceDAO.deleteCarReservation(carRsv);
	}
	
	@Override
	public List<EquipVO> selectEquipList(Map<String, Object> param) throws Exception {
		return resourceDAO.selectEquipList(param);
	}

	@Override
	public int selectEquipListTotCnt(Map<String, Object> param) throws Exception {
		return resourceDAO.selectEquipListTotCnt(param);
	}

	@Override
	public EquipVO selectEquipInfo(EquipVO equipVO) throws Exception {
		return resourceDAO.selectEquipInfo(equipVO);
	}

	@Override
	public EquipVO selectEquipInfoDetail(EquipVO equipVO) throws Exception {
		return resourceDAO.selectEquipInfoDetail(equipVO);
	}

	@Override
	public List<EquipVO> selectEquipHistoryList(EquipVO equipVO) throws Exception {
		return resourceDAO.selectEquipHistoryList(equipVO);
	}

	@Override
	public void insertEquip(EquipVO equipVO) throws Exception {
		resourceDAO.insertEquip(equipVO);
	}
	
	@Override
	public void updateEquip(EquipVO equipVO) throws Exception {
		resourceDAO.updateEquip(equipVO);
	}
	
	@Override
	public void deleteEquip(EquipVO equipVO) throws Exception {
		resourceDAO.deleteEquip(equipVO);
	}
	
	@Override
	public void insertEquipDetail(EquipVO equipVO) throws Exception {
		resourceDAO.insertEquipDetail(equipVO);
	}
	
	@Override
	public void updateEquipDetail(EquipVO equipVO) throws Exception {
		resourceDAO.updateEquipDetail(equipVO);
	}

	@Override
	public void deleteEquipDetail(EquipVO equipVO) throws Exception {
		resourceDAO.deleteEquipDetail(equipVO);
	}

	@Override
	public void updateEquipNotUsed(EquipVO equipVO) throws Exception {
		resourceDAO.updateEquipNotUsed(equipVO);
	}

	@Override
	public void updateEquipUser(EquipVO equipVO) throws Exception {
		resourceDAO.updateEquipUser(equipVO);
	}

	@Override
	public String selectMaxIdx(EquipVO equipVO) throws Exception {
		return resourceDAO.selectMaxIdx(equipVO);
	}
	
	//장비수리 시작
	@Override
	public void insertEquipRepair(EquipVO equipVO) throws Exception {
		resourceDAO.insertEquipRepair(equipVO);
	}
	
	@Override
	public void updateEquipRepair(EquipVO equipVO) throws Exception {
		resourceDAO.updateEquipRepair(equipVO);
	}

	@Override
	public void deleteEquipRepair(EquipVO equipVO) throws Exception {
		resourceDAO.deleteEquipRepair(equipVO);
	}
	@Override
	public EquipVO selectEquipInfoRepair(EquipVO equipVO) throws Exception {
		return resourceDAO.selectEquipInfoRepair(equipVO);
	}

	@Override
	public List<EquipVO> selectEquipRepairHistoryList(EquipVO equipVO) throws Exception {
		return resourceDAO.selectEquipRepairHistoryList(equipVO);
	}
	//장비수리이력 끝	
	
	@Override
	public List<EquipVO> selectEquipTypeList() throws Exception {
		return resourceDAO.selectEquipTypeList();
	}

	@Override
	public EquipVO selectEquipTypeInfo(EquipVO equipVO) throws Exception {
		return resourceDAO.selectEquipTypeInfo(equipVO);
	}

	@Override
	public void insertEquipType(EquipVO equipVO) throws Exception {
		resourceDAO.insertEquipType(equipVO);
	}
	
	@Override
	public void updateEquipType(EquipVO equipVO) throws Exception {
		resourceDAO.updateEquipType(equipVO);
	}
	
	@Override
	public void deleteEquipType(EquipVO equipVO) throws Exception {
		resourceDAO.deleteEquipType(equipVO);
	}
	
	// JisangK 20210616 : 사내 IP 관리
	@Override
	public List<IpVO> selectIpList(IpVO ipVO) throws Exception{
		return resourceDAO.selectIpList(ipVO);
	}
	
	@Override
	public IpVO selectIp(IpVO ipVO) throws Exception{
		return resourceDAO.selectIp(ipVO);
	}
	
	@Override
	public IpVO selectIpInfo(IpVO ipVO) throws Exception{
		return resourceDAO.selectIpInfo(ipVO);
	}
	
	@Override
	public void insertIpInfo(IpVO ipVO) throws Exception{
		resourceDAO.insertIpInfo(ipVO);
	}
	
	@Override
	public void updateIpInfo(IpVO ipVO) throws Exception{
		resourceDAO.updateIpInfo(ipVO);
	}
	
	@Override
	public void deleteIpInfo(IpVO ipVO) throws Exception{
		resourceDAO.deleteIpInfo(ipVO);
	}
}
