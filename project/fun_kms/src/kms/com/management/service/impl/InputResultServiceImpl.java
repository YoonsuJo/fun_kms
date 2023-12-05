package kms.com.management.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.common.utils.CalendarUtil;
import kms.com.management.service.InputResultDept;
import kms.com.management.service.InputResultDeptVO;
import kms.com.management.service.InputResultPerson;
import kms.com.management.service.InputResultPersonVO;
import kms.com.management.service.InputResultProject;
import kms.com.management.service.InputResultProjectDetail;
import kms.com.management.service.InputResultProjectDetailVO;
import kms.com.management.service.InputResultProjectVO;
import kms.com.management.service.InputResultService;
import kms.com.management.service.ProjectInputPlanDaily;
import kms.com.management.service.ProjectInputPlanDailyVO;
import kms.com.management.service.ProjectInputPlanManagement;
import kms.com.management.service.ProjectInputPlanManagementVO;
import kms.com.management.service.SalesVO;
import kms.com.member.service.MemberVO;

@Service("KmsInputResultService")
public class InputResultServiceImpl implements InputResultService {
	
	@Resource(name="KmsInputResultDAO")
	private InputResultDAO irDAO;

	@Override
	public List<InputResultPersonVO> selectInputResultPerson(InputResultPerson inputResultPerson) throws Exception {
		List<InputResultPersonVO> resultList = new ArrayList<InputResultPersonVO>();
		
		List<InputResultPerson> irpList = irDAO.selectInputResultPerson(inputResultPerson);
		
		Integer userNo = 0;
		for (int i=0; i<irpList.size(); i++) {
			InputResultPerson irp = irpList.get(i);
			InputResultPersonVO irpVO = new InputResultPersonVO();
			
			if (userNo.equals(irp.getUserNo()) == false) {
				irpVO.setUserNo(irp.getUserNo());
				irpVO.setUserId(irp.getUserId());
				irpVO.setUserNm(irp.getUserNm());
				irpVO.setOrgnztId(irp.getOrgnztId());
				irpVO.setOrgnztNm(irp.getOrgnztNm());
				
				irp.setParentVO(irpVO);
				irpVO.addInputResultPersonList(irp);
				
				resultList.add(irpVO);
				userNo = irpVO.getUserNo();
			} else {
				irpVO = resultList.get(resultList.size() - 1);

				irp.setParentVO(irpVO);
				irpVO.addInputResultPersonList(irp);
			}
		}
		
		return resultList;
	}
	
	@Override
	public List<InputResultPersonVO> selectInputResultPlanPerson(InputResultPerson inputResultPerson) throws Exception {
		List<InputResultPersonVO> resultList = new ArrayList<InputResultPersonVO>();
		
		List<InputResultPerson> irpList = irDAO.selectInputResultPlanPerson(inputResultPerson);
		
		Integer userNo = 0;
		for (int i=0; i<irpList.size(); i++) {
			InputResultPerson irp = irpList.get(i);
			InputResultPersonVO irpVO = new InputResultPersonVO();
			
			if (userNo.equals(irp.getUserNo()) == false) {
				irpVO.setUserNo(irp.getUserNo());
				irpVO.setUserId(irp.getUserId());
				irpVO.setUserNm(irp.getUserNm());
				irpVO.setOrgnztId(irp.getOrgnztId());
				irpVO.setOrgnztNm(irp.getOrgnztNm());
				
				irp.setParentVO(irpVO);
				irpVO.addInputResultPersonList(irp);
				
				resultList.add(irpVO);
				userNo = irpVO.getUserNo();
			} else {
				irpVO = resultList.get(resultList.size() - 1);

				irp.setParentVO(irpVO);
				irpVO.addInputResultPersonList(irp);
			}
		}
		
		return resultList;
	}
	
	@Override
	public List<InputResultPersonVO> selectInputResultPlanPersonStatus(InputResultPerson inputResultPerson) throws Exception {
		List<InputResultPersonVO> resultList = new ArrayList<InputResultPersonVO>();
		
		List<InputResultPerson> irpList = irDAO.selectInputResultPlanPersonStatus(inputResultPerson);
		
		Integer userNo = 0;
		for (int i=0; i<irpList.size(); i++) {
			InputResultPerson irp = irpList.get(i);
			InputResultPersonVO irpVO = new InputResultPersonVO();
			
			if (userNo.equals(irp.getUserNo()) == false) {
				irpVO.setUserNo(irp.getUserNo());
				irpVO.setUserId(irp.getUserId());
				irpVO.setUserNm(irp.getUserNm());
				irpVO.setOrgnztId(irp.getOrgnztId());
				irpVO.setOrgnztNm(irp.getOrgnztNm());
				
				irp.setParentVO(irpVO);
				irpVO.addInputResultPersonList(irp);
				
				resultList.add(irpVO);
				userNo = irpVO.getUserNo();
			} else {
				irpVO = resultList.get(resultList.size() - 1);

				irp.setParentVO(irpVO);
				irpVO.addInputResultPersonList(irp);
			}
		}
		
		return resultList;
	}
	
	@Override
	public List<InputResultPersonVO> selectInputResultPlanProject(InputResultPerson inputResultPerson) throws Exception {
		
		List<InputResultPersonVO> resultList = new ArrayList<InputResultPersonVO>();
		
		List<InputResultPerson> irpList = irDAO.selectInputResultPlanProject(inputResultPerson);
		
		String prjCd = "";
		
		for (int i=0; i<irpList.size(); i++) {
			InputResultPerson irp = irpList.get(i);
			InputResultPersonVO irpVO = new InputResultPersonVO();
			
			if (prjCd.equals(irp.getPrjCd()) == false) {
				irpVO.setPrjCd(irp.getPrjCd());
				irpVO.setPrjId(irp.getPrjId());
				irpVO.setPrjNm(irp.getPrjNm());
				irpVO.setUserNo(irp.getUserNo());
				irpVO.setUserId(irp.getUserId());
				irpVO.setUserNm(irp.getUserNm());
				irpVO.setOrgnztId(irp.getOrgnztId());
				irpVO.setOrgnztNm(irp.getOrgnztNm());
				irp.setParentVO(irpVO);
				irpVO.addInputResultPersonList(irp);
				
				resultList.add(irpVO);
				prjCd = irpVO.getPrjCd();
			} else {
				irpVO = resultList.get(resultList.size() - 1);
				irp.setParentVO(irpVO);
				irpVO.addInputResultPersonList(irp);			
			}
			
			
		}
		
		return resultList;		
	}
		
	public List<InputResultProjectVO> selectInputResultProject(InputResultProject inputResultProject) throws Exception {
		
		List<InputResultProjectVO> resultList = new ArrayList<InputResultProjectVO>();		
		List<InputResultProject> irpList = irDAO.selectInputResultProject(inputResultProject);
		
		try {
			
		
		// 투입시간, 인건비, 휴일근무일수, 휴일근무수당 0인 프로젝트 제거
		int maxDepth = 5;
		int prePrjLvl = maxDepth;	// 이전 프로젝트 레벨
		boolean preLvlFlag[] = {false, false, false, false, false, false};	// 0,1,2,3,4,5 레벨 남은프로제트 존재여부
		for (int i=irpList.size()-1; i>=0; i--) {
			InputResultProject irp = irpList.get(i);
			int curPrjLvl = irp.getPrjLvl();	// 현재 프로젝트 레벨
			
			if ( prePrjLvl == curPrjLvl ) {	// 동급레벨 프로젝트의 비교_무조건 0값 비교
				if (irp.getDrTm()==0 && irp.getDrSalary()==0 && irp.getHolTm()==0 && irp.getHolSalary()==0) {
					irpList.remove(i);
				} else {
					preLvlFlag[curPrjLvl] = true;	// 현재레벨에 남은 프로젝트가 있음.
				}
			} else if ( prePrjLvl > curPrjLvl ) {	// 하위레벨과 상위레벨 프로젝트의 비교_하위레벨의 남은 프로젝트 존재여부 체크
				if ( !preLvlFlag[prePrjLvl] && (irp.getDrTm()==0 && irp.getDrSalary()==0 && irp.getHolTm()==0 && irp.getHolSalary()==0) ) {
					irpList.remove(i);
				} else {
					preLvlFlag[curPrjLvl] = true;	// 현재레벨에 남은 프로젝트가 있음.
				}
			} else if (prePrjLvl < curPrjLvl) {	// 상위레벨과 하위레벨의 비교_무조건 0값 비교
				if ( irp.getDrTm()==0 && irp.getDrSalary()==0 && irp.getHolTm()==0 && irp.getHolSalary()==0 ) {
					irpList.remove(i);
				}
			}
			
			// 하위 남은 프로젝트 플래그 초기화
			for(int j=curPrjLvl+1; j<=maxDepth; j++)
				preLvlFlag[j] = false;
			
			// 이전 프로젝트 레벨 초기화
			if (curPrjLvl == 0) {
				prePrjLvl = maxDepth;
			} else {
				prePrjLvl = curPrjLvl;
			}
		}
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 소계 계산 및 resultList 재생성
		for (int i=0; i<irpList.size(); i++) {
			InputResultProject irp = irpList.get(i);
			if (irp.getPrjLvl() == 0) {
				InputResultProjectVO vo = new InputResultProjectVO();
				
				vo.setOrgnztId(irp.getOrgnztId());
				vo.setOrgnztNm(irp.getOrgnztNm());
				vo.addInputResultProjectList(irp);
				
				resultList.add(vo);
			}
			else {
				InputResultProjectVO vo = resultList.get(resultList.size() - 1);
				
				vo.addInputResultProjectList(irp);
			}
		}
		
		return resultList;
	}
	
	@Override
	public List<InputResultProject> selectInputResultSum(
			InputResultProject inputResultProject) throws Exception {
		
		List<InputResultProject> resultSum = new ArrayList<InputResultProject>() ;
		List<InputResultProject> irpSum = irDAO.selectInputResultSum(inputResultProject);
		
		String preOrgnztUpNm = "";
		// 부서별합계
		int drTm = 0;
		int drSalary = 0;
		double holTm = 0;
		int holSalary = 0;
		// 총합계
		int totalDrTm = 0;
		int totalDrSalary = 0;
		double totalHolTm = 0;
		int totalHolSalary = 0;
		
		InputResultProject upInputResultProject = new InputResultProject();
		InputResultProject totalInputResultProject = new InputResultProject();
		
		for(InputResultProject tmpVO: irpSum) {
			
			// 상위부서 삽입
			if ( !"".equals(preOrgnztUpNm) && !preOrgnztUpNm.equals(tmpVO.getOrgnztUpNm()) ) {
				// 상위부서값 갱신
				upInputResultProject = new InputResultProject();
				upInputResultProject.setOrgnztNm(preOrgnztUpNm + " 소계");
				upInputResultProject.setDrTm(drTm);
				upInputResultProject.setDrSalary(drSalary);
				upInputResultProject.setHolTm(holTm);
				upInputResultProject.setHolSalary(holSalary);
				upInputResultProject.setPrjId("up");
				resultSum.add(upInputResultProject);
				
				drTm = 0;
				drSalary = 0;
				holTm = 0;
				holSalary = 0;
			}
			
			tmpVO.setOrgnztNm(tmpVO.getOrgnztNm() + " 소계");
			resultSum.add(tmpVO);	// 삽입
			
			// 합계 계산
			drTm += tmpVO.getDrTm();
			drSalary += tmpVO.getDrSalary();
			holTm += tmpVO.getHolTm();
			holSalary += tmpVO.getHolSalary();
			
			totalDrTm += tmpVO.getDrTm();
			totalDrSalary += tmpVO.getDrSalary();
			totalHolTm += tmpVO.getHolTm();
			totalHolSalary += tmpVO.getHolSalary();
			
			preOrgnztUpNm = tmpVO.getOrgnztUpNm();
		}
		
		// 마지막 상위부서 삽입
		upInputResultProject = new InputResultProject();
		upInputResultProject.setOrgnztNm(preOrgnztUpNm + " 소계");
		upInputResultProject.setDrTm(drTm);
		upInputResultProject.setDrSalary(drSalary);
		upInputResultProject.setHolTm(holTm);
		upInputResultProject.setHolSalary(holSalary);
		upInputResultProject.setPrjId("up");
		resultSum.add(upInputResultProject);
		
		// 합계 삽입
		totalInputResultProject = new InputResultProject();
		totalInputResultProject.setOrgnztNm("합계");
		totalInputResultProject.setDrTm(totalDrTm);
		totalInputResultProject.setDrSalary(totalDrSalary);
		totalInputResultProject.setHolTm(totalHolTm);
		totalInputResultProject.setHolSalary(totalHolSalary);
		totalInputResultProject.setPrjId("up");
		resultSum.add(totalInputResultProject);
		
		/* Trace
		for (InputResultProject tmpVO2: resultSum) {
				System.out.println(tmpVO2.getOrgnztNm());
			}
			System.out.println("------------------------------");
		*/
		
		return resultSum;
	}
	
	public List<InputResultProjectDetailVO> selectInputResultProjectDetail(InputResultProjectDetail inputResultProjectDetail) throws Exception {
		
		List<InputResultProjectDetailVO> resultList = new ArrayList<InputResultProjectDetailVO>();		
		List<InputResultProjectDetail> irpdList = irDAO.selectInputResultProjectDetail(inputResultProjectDetail);
		
		String prjId = "";
		for (int i=0; i<irpdList.size(); i++) {
			InputResultProjectDetail irpd = irpdList.get(i);
			if (irpd.getDrTm() != 0 || irpd.getHolTm() != 0.0) {
				if (prjId.equals(irpd.getPrjId()) == false) {
					InputResultProjectDetailVO vo = new InputResultProjectDetailVO();					
					vo.setPrjId(irpd.getPrjId());
					vo.setPrjNm(irpd.getPrjNm());
					vo.setPrjCd(irpd.getPrjCd());
					vo.addInputResultProjectDetailList(irpd);
					
					resultList.add(vo);					
					prjId = irpd.getPrjId();
				} else {
					InputResultProjectDetailVO vo = resultList.get(resultList.size() - 1);					
					vo.addInputResultProjectDetailList(irpd);
				}
			}
		}
		
		return resultList;
	}

	public InputResultDeptVO selectInputResultDept(InputResultDeptVO inputResultDeptVO) throws Exception {
		InputResultDeptVO vo = new InputResultDeptVO();
		
		List<InputResultDept> irddList = irDAO.selectInputResultDept(inputResultDeptVO);
		
		for (int i = 0; i < irddList.size(); i++) {
			InputResultDept ird = irddList.get(i);
			vo.addInputResultDept(ird);
		}
		
		return vo;
	}

	@Override
	public List<ProjectInputPlanManagementVO> selectProjectInputPlanManagementList(ProjectInputPlanManagementVO searchVO) throws Exception {
		return irDAO.selectProjectInputPlanManagementList(searchVO);
	}

	@Override
	public List<ProjectInputPlanDailyVO> selectProjectInputPlanDailyList(ProjectInputPlanManagementVO searchVO) throws Exception {
		
		List<ProjectInputPlanDailyVO> resultList = new ArrayList<ProjectInputPlanDailyVO>();
		
		List<ProjectInputPlanDaily> list = irDAO.selectProjectInputPlanDailyList(searchVO);
		
		Integer userNo = 0;
		String orgnztId = "";
		for (int i=0; i<list.size(); i++) {
			ProjectInputPlanDaily tmp = list.get(i);
			
			if(userNo.equals(0) || userNo.equals(tmp.getUserNo()) == false) {
				
				ProjectInputPlanDailyVO vo = new ProjectInputPlanDailyVO();
				
				vo.setUserNo(tmp.getUserNo());
				vo.setUserId(tmp.getUserId());
				vo.setUserNm(tmp.getUserNm());
				vo.setNoInput(tmp.getNoInput());
				
				vo.addInputPercentList(tmp.getInputPercent());
				
				if (!tmp.getOrgnztId().equals(orgnztId) && tmp.getNoInput().equals("Y")) {
					orgnztId = tmp.getOrgnztId();
					ProjectInputPlanDailyVO org = new ProjectInputPlanDailyVO();
					org.setOrgnztId(tmp.getOrgnztId());
					org.setOrgnztNm(tmp.getOrgnztNm());
					org.setOrgnztRow("Y");
					resultList.add(org);
				}
				
				if (!tmp.getNoInput().equals("Y"))
					vo.increaseNoInputCnt();
				
				resultList.add(vo);
				
				userNo = tmp.getUserNo();
			}
			else {
				ProjectInputPlanDailyVO vo = resultList.get(resultList.size() - 1);

				vo.addInputPercentList(tmp.getInputPercent());
				if (!tmp.getNoInput().equals("Y"))
					vo.increaseNoInputCnt();
			}
			
		}
		
		for (int i=0; i<resultList.size(); i++) {
			ProjectInputPlanDailyVO resultVO = resultList.get(i);
			
			if (resultVO.getOrgnztRow().equals("") && resultVO.getInputPercentList().size() == resultVO.getNoInputCnt()) {
				resultList.remove(i);
				i--;
			}
		}
		
		return resultList;
	}
	
	


	@Override
	public ProjectInputPlanManagementVO selectProjectInputPlanManagement(ProjectInputPlanManagementVO searchVO) throws Exception {
		return irDAO.selectProjectInputPlanManagement(searchVO);
	}

	@Override
	public void insertProjectInputPlan(ProjectInputPlanManagement projectInputPlanManagement) throws Exception {
		irDAO.insertProjectInputPlan(projectInputPlanManagement);
	}

	@Override
	public void updateProjectInputPlan(ProjectInputPlanManagement projectInputPlanManagement) throws Exception {
		irDAO.updateProjectInputPlan(projectInputPlanManagement);
		
	}

	@Override
	public void deleteProjectInputPlan(ProjectInputPlanManagement projectInputPlanManagement) throws Exception {
		irDAO.deleteProjectInputPlan(projectInputPlanManagement);
		
	}

	@Override
	public List<MemberVO> selectNotInputMemberList(ProjectInputPlanManagementVO searchVO) throws Exception {
		return irDAO.selectNotInputMemberList(searchVO);
	}

	@Override
	public List<MemberVO> selectInputResultPersonNotInput(InputResultPerson inputResultPerson) throws Exception {
		return irDAO.selectInputResultPersonNotInput(inputResultPerson);
	}
	
	@Override
	public List<MemberVO> selectInputResultPersonNotInputStatus(InputResultPerson inputResultPerson) throws Exception {
		return irDAO.selectInputResultPersonNotInputStatus(inputResultPerson);
	}
	
}
