package kms.com.equipInstall.service;

import java.util.List;

public interface EquipInstallService {
	int insertEquipInstall(EquipInstallVO equipinstallVO);
	
	EquipInstallVO getDetailView(EquipInstallVO equipinstallVO);
	
	List getDetailList(EquipInstallVO equipinstallVO);
	
	List getMasterList(EquipInstallVO equipinstallVO);
	
	List getEquipInstallList(EquipInstallVO equipinstallVO);
	
	int getEquipInstallListCount(EquipInstallVO equipinstallVO);
	
	void updateReadOk(EquipInstallVO equipinstallVO);
	
	List getEquipInstallFileName(EquipInstallVO equipinstallVO);
	
	String updateEquipInstallReceive(EquipInstallVO equipinstallVO);
	
	String deleteEquipInstall(EquipInstallVO equipinstallVO);
	
	String modifyEquipInstall(EquipInstallVO equipinstallVO);
	
	String insertEquipSolution(EquipInstallVO equipinstallVO);
	
	String deleteEquipSolution(EquipInstallVO equipinstallVO);
	
	String updateEquipSolution(EquipInstallVO equipinstallVO);
	
	List getEquipSolution();
	
	List getChgInstallHistory(EquipInstallVO equipinstallVO);
	
	int getChgInstallHistoryCount(EquipInstallVO equipinstallVO);
	
	String deleteEquipInstallDetail(EquipInstallVO equipinstallVO);
	
	EquipInstallVO getModifyDetailData(EquipInstallVO equipinstallVO);
	
	String updateEquipInstallDetailMP(EquipInstallVO equipinstallVO);
	
	List getDetailHistory(EquipInstallVO equipinstallVO);
	
	int getEquipSolutionCount();
	
	List getEquipSolutionPaging(EquipInstallVO equipinstallVO);
}