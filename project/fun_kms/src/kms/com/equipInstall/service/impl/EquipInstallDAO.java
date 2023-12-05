package kms.com.equipInstall.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import kms.com.equipInstall.service.EquipInstallVO;

@Repository("EquipInstallDAO")
public class EquipInstallDAO extends EgovAbstractDAO  {
	
	public int insertEquipInstall(EquipInstallVO equipinstallVO){
		insert("EquipInstallDAO.insertEquipInstall", equipinstallVO);
		//insert("EquipInstallDAO.insertEquipInstallDetail", equipinstallVO);
		
		return equipinstallVO.getInstallNo();
	}
	
	public EquipInstallVO getDetailView(EquipInstallVO equipinstallVO){
		EquipInstallVO eiVO = (EquipInstallVO) selectByPk("EquipInstallDAO.getDetailView", equipinstallVO);
		
		return eiVO;
	}
	
	public List getDetailList(EquipInstallVO equipinstallVO){
		return list("EquipInstallDAO.getDetailList", equipinstallVO);
	}
	
	public List getMasterList(EquipInstallVO equipinstallVO){
		return list("EquipInstallDAO.getMasterList", equipinstallVO);
	}
	
	public List getEquipInstallList(EquipInstallVO equipinstallVO){
		return list("EquipInstallDAO.getEquipInstallList", equipinstallVO);
	}
	
	public int getEquipInstallListCount(EquipInstallVO equipinstallVO){
		return (Integer) selectByPk("EquipInstallDAO.getCountEquipInstallList", equipinstallVO);
	}
	
	public void updateReadOk(EquipInstallVO equipinstallVO){
		int count = 0;
		count = (Integer)selectByPk("EquipInstallDAO.getReadCount", equipinstallVO);
		
		if(count == 0) insert("EquipInstallDAO.updateReadOk", equipinstallVO);
	}
	
	public List getEquipInstallFileName(EquipInstallVO equipinstallVO){
		return list("EquipInstallDAO.getEquipInstallFileName", equipinstallVO);
	}
	
	public String updateEquipInstallReceive(EquipInstallVO equipinstallVO){
		int count1 = 0;
		int count2 = 0;
		String result = "Y";
		
		count1 = update("EquipInstallDAO.updateEquipInstallReceive", equipinstallVO);
		if( count1 > 0){
			count2 = (Integer) insert("EquipInstallDAO.insertEquipInstallReceive1", equipinstallVO);
		}
		if(count2 == 0){
			result = "N"; 
		}
		
		return result;
	}
	
	public String deleteEquipInstall(EquipInstallVO equipinstallVO){
		String result = "Y";
		int count = 0;
		
		count = update("EquipInstallDAO.deleteEquipInstall", equipinstallVO);
		
		if(count == 0) result = "N";
		
		return result;
	}
	
	public String modifyEquipInstall(EquipInstallVO equipinstallVO){
		String result = "Y";
		int count1 = 0;
		
		EquipInstallVO eiVO = (EquipInstallVO) selectByPk("EquipInstallDAO.getHistoryData", equipinstallVO);
		
		count1 = update("EquipInstallDAO.modifyEquipInstall", equipinstallVO);
		insert("EquipInstallDAO.modifyEquipInstallHistory", eiVO);
		
		if(count1 > 0)	result = "Y";
		else			result = "N";
		
		return result;
	}
	
	
	public String insertEquipSolution(EquipInstallVO equipinstallVO){
		String result = "Y";
		int count = 0;
		int check = 0;
		
		check = (Integer) selectByPk("EquipInstallDAO.checkSameSolution", equipinstallVO);
		if(check > 0){
			return "S";
		}
		
		count = (Integer) insert("EquipInstallDAO.insertEquipSolution", equipinstallVO);
		
		if(count > 0) result = "Y";
		else		  result = "N";
		
		return result;
	}
	
	public String deleteEquipSolution(EquipInstallVO equipinstallVO){
		String result = "Y";
		int check = 0;
		int count = 0;
		
		check = (Integer) selectByPk("EquipInstallDAO.countUseSolution", equipinstallVO);
		
		if(check > 0){
			result =  "U";
		}else{
			count = (Integer) delete("EquipInstallDAO.deleteSolution", equipinstallVO);
			
			if(count > 0) result = "Y";
			else		  result = "N";
		}
		
		return result;
	}
	public String updateEquipSolution(EquipInstallVO equipinstallVO){
		String result = "Y";
		int count = 0;
		
		count = (Integer) update("EquipInstallDAO.updateSolution", equipinstallVO);
		
		if(count > 0) result = "Y";
		else		  result = "N";
		
		return result;
	}
	
	public List getEquipSolution(){
		return list("EquipInstallDAO.getEquipSolution", null);
	}
	
	
	public List getChgInstallHistory(EquipInstallVO equipinstallVO){
		return list("EquipInstallDAO.getChgInstallHistory", equipinstallVO);
	}
	
	public int getChgInstallHistoryCount(EquipInstallVO equipinstallVO){
		return (Integer) selectByPk("EquipInstallDAO.getChgInstallHistoryCount", equipinstallVO);
	}
	
	public String deleteEquipInstallDetail(EquipInstallVO equipinstallVO){
		String result = "Y";
		int count = 0;
		
		count = update("EquipInstallDAO.updateEquipInstallDetail", equipinstallVO);
		update("EquipInstallDAO.updateEquipInstallMaster", equipinstallVO);
		
		if(count > 0)	result = "Y";
		else			result = "N";
		
		return result;
	}
	
	public EquipInstallVO getModifyDetailData(EquipInstallVO equipinstallVO){
		return (EquipInstallVO) selectByPk("EquipInstallDAO.getModifyDetailData", equipinstallVO);
	}
	
	
	public String updateEquipInstallDetailMP(EquipInstallVO equipinstallVO){
		String result = "Y";
		int count1 = 0;
		
//		EquipInstallVO eivo = (EquipInstallVO) selectByPk("EquipInstallDAO.getDetailMngId", equipinstallVO);
		
		count1 = update("EquipInstallDAO.updateEquipInstallDetailMP", equipinstallVO);
		
		
		if(count1 > 0){
			//insert("EquipInstallDAO.insertDetailHistory", eivo);
			result = "Y";
		}
		else			result = "N";
		
		return result;
	}
	
	public List getDetailHistory(EquipInstallVO equipinstallVO){
		return list("EquipInstallDAO.getDetailHistory", equipinstallVO);
	}
	
	
	public List getEquipSolutionPaging(EquipInstallVO equipinstallVO){
		return list("EquipInstallDAO.getEquipSolutionPaging", equipinstallVO);
	}
	public int getEquipSolutionCount(){
		return (Integer) selectByPk("EquipInstallDAO.getEquipSolutionCount", null); 
	}
}