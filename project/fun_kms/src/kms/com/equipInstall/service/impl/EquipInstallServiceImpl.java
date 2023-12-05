package kms.com.equipInstall.service.impl;

import java.util.List;

import javax.annotation.Resource;

import kms.com.equipInstall.service.EquipInstallService;
import kms.com.equipInstall.service.EquipInstallVO;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("EquipInstallService")
public class EquipInstallServiceImpl extends AbstractServiceImpl implements EquipInstallService{
	
	@Resource(name="EquipInstallDAO")
	private EquipInstallDAO eiDAO;
	
	
	/**
	 * 요청 상세내용 뷰
	 * @param equipinstallVO
	 * @return equipinstallVO
	 */
	@Override
	public EquipInstallVO getDetailView(EquipInstallVO equipinstallVO){
		EquipInstallVO eiVO = eiDAO.getDetailView(equipinstallVO); 
		return eiVO;
	}
	
	@Override
	public List getDetailList(EquipInstallVO equipinstallVO){
		return eiDAO.getDetailList(equipinstallVO);
	}
	
	@Override
	public List getMasterList(EquipInstallVO equipinstallVO){
		return eiDAO.getMasterList(equipinstallVO);
	}
	
	/**
	 * 요청 게시글
	 * @param equipinstallVO
	 * @return List
	 */
	@Override
	public List getEquipInstallList(EquipInstallVO equipinstallVO){
		return eiDAO.getEquipInstallList(equipinstallVO);
	}
	
	/**
	 * 요청 게시글 리스트 갯수
	 * @param equipinstallVO
	 * @return Int
	 */
	@Override
	public int getEquipInstallListCount(EquipInstallVO equipinstallVO){
		return eiDAO.getEquipInstallListCount(equipinstallVO);
	}
	
	
	/**
	 * 요청 읽음 업데이트
	 * @param equipinstallVO
	 */
	@Override
	public void updateReadOk(EquipInstallVO equipinstallVO){
		eiDAO.updateReadOk(equipinstallVO);
	}
	
	/**
	 * 요청 내용 입력 프로세스
	 * @param equipinstallVO
	 * @return int
	 */
	@Override
	public int insertEquipInstall(EquipInstallVO equipinstallVO){
		int result = eiDAO.insertEquipInstall(equipinstallVO); 
		return result;
	}
	
	@Override
	public List getEquipInstallFileName(EquipInstallVO equipinstallVO){
		return eiDAO.getEquipInstallFileName(equipinstallVO);
	}
	
	/**
	 * 요청 접수 프로세스
	 * @param equipinstallVO
	 * @return String
	 */
	@Override
	public String updateEquipInstallReceive(EquipInstallVO equipinstallVO){
		return eiDAO.updateEquipInstallReceive(equipinstallVO);	
	}
	
	/**
	 * 요청 삭제 프로세스
	 * @param equipinstallVO
	 * @return String
	 */
	@Override
	public String deleteEquipInstall(EquipInstallVO equipinstallVO){
		return eiDAO.deleteEquipInstall(equipinstallVO);
	}
	
	/**
	 * 요청 수정 프로세스
	 * @param equipinstallVO
	 * @return String
	 */
	@Override
	public String modifyEquipInstall(EquipInstallVO equipinstallVO){
		return eiDAO.modifyEquipInstall(equipinstallVO);
	}
	
	/**
	 * 솔루션 입력
	 * @param equipinstallVO
	 */
	@Override
	public String insertEquipSolution(EquipInstallVO equipinstallVO){
		return eiDAO.insertEquipSolution(equipinstallVO);
	}
	
	/**
	 * 솔루션 삭제
	 * @param equipinstallVO
	 */
	@Override
	public String deleteEquipSolution(EquipInstallVO equipinstallVO){
		return eiDAO.deleteEquipSolution(equipinstallVO);
	}
	
	/**
	 * 솔루션 수정
	 * @param equipinstallVO
	 */
	@Override
	public String updateEquipSolution(EquipInstallVO equipinstallVO){
		return eiDAO.updateEquipSolution(equipinstallVO);
	}
	
	/**
	 * 솔루션 입력
	 * @param equipinstallVO
	 */
	@Override
	public List getEquipSolution(){
		return eiDAO.getEquipSolution();
	}
	
	
	/**
	 * 솔루션 입력
	 * @param equipinstallVO
	 */
	@Override
	public List getChgInstallHistory(EquipInstallVO equipinstallVO){
		return eiDAO.getChgInstallHistory(equipinstallVO);
	}
	
	@Override
	public int getChgInstallHistoryCount(EquipInstallVO equipinstallVO){
		return eiDAO.getChgInstallHistoryCount(equipinstallVO);
	}	
	
	/**
	 * 
	 * @param equipinstallVO
	 */
	@Override
	public String deleteEquipInstallDetail(EquipInstallVO equipinstallVO){
		return eiDAO.deleteEquipInstallDetail(equipinstallVO);
	}
	
	
	/**
	 * 
	 * @param equipinstallVO
	 */
	@Override
	public EquipInstallVO getModifyDetailData(EquipInstallVO equipinstallVO){
		return eiDAO.getModifyDetailData(equipinstallVO);
	}
	
	
	
	public String updateEquipInstallDetailMP(EquipInstallVO equipinstallVO){
		return eiDAO.updateEquipInstallDetailMP(equipinstallVO);
	}
	
	public List getDetailHistory(EquipInstallVO equipinstallVO){
		return eiDAO.getDetailHistory(equipinstallVO);
	}
	
	public List getEquipSolutionPaging(EquipInstallVO equipinstallVO){
		return eiDAO.getEquipSolutionPaging(equipinstallVO);
	}
	public int getEquipSolutionCount(){
		return eiDAO.getEquipSolutionCount();
	}
}