package kms.com.management.service.impl;

import java.util.List;

import kms.com.management.service.InputResultPerson;
import kms.com.management.service.InputResultProject;
import kms.com.management.service.InputResultProjectDetail;
import kms.com.management.service.InputResultDept;
import kms.com.management.service.InputResultDeptVO;
import kms.com.management.service.ProjectInputPlanDaily;
import kms.com.management.service.ProjectInputPlanDailyVO;
import kms.com.management.service.ProjectInputPlanManagement;
import kms.com.management.service.ProjectInputPlanManagementVO;
import kms.com.member.service.MemberVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("KmsInputResultDAO")
public class InputResultDAO extends EgovAbstractDAO {

	public List<InputResultPerson> selectInputResultPerson(InputResultPerson inputResultPerson) throws Exception {
		return list("InputResultDAO.selectInputResultPerson", inputResultPerson);
	}

	public List<InputResultPerson> selectInputResultPlanPerson(InputResultPerson inputResultPerson) throws Exception {
		return list("InputResultDAO.selectInputResultPlanPerson", inputResultPerson);
	}
	
	public List<InputResultPerson> selectInputResultPlanPersonStatus(InputResultPerson inputResultPerson) throws Exception {
		return list("InputResultDAO.selectInputResultPlanPersonStatus", inputResultPerson);
	}	

	public List<InputResultPerson> selectInputResultPlanProject(InputResultPerson inputResultPerson) throws Exception {
		return list("InputResultDAO.selectInputResultPlanProject", inputResultPerson);
	}

	public List<InputResultProject> selectInputResultProject(InputResultProject inputResultProject) {
		return list("InputResultDAO.selectInputResultProject", inputResultProject);
	}
	
	public List<InputResultProject> selectInputResultSum(InputResultProject inputResultProject) {
		return list("InputResultDAO.selectInputResultSum", inputResultProject);
	}

	public List<InputResultProjectDetail> selectInputResultProjectDetail(InputResultProjectDetail inputResultProjectDetail) {
		return list("InputResultDAO.selectInputResultProjectDetail", inputResultProjectDetail);
	}

	public List<InputResultDept> selectInputResultDept(InputResultDeptVO inputResultDeptVO) {
		return list("InputResultDAO.selectInputResultDept", inputResultDeptVO);
	}

	public List<ProjectInputPlanManagementVO> selectProjectInputPlanManagementList(ProjectInputPlanManagementVO searchVO) {
		return list("InputResultDAO.selectProjectInputPlanManagementList", searchVO);
	}

	public List<ProjectInputPlanDaily> selectProjectInputPlanDailyList(ProjectInputPlanManagementVO searchVO) {
		return list("InputResultDAO.selectProjectInputPlanDailyList", searchVO);
	}

	public ProjectInputPlanManagementVO selectProjectInputPlanManagement(ProjectInputPlanManagementVO searchVO) {
		return (ProjectInputPlanManagementVO)selectByPk("InputResultDAO.selectProjectInputPlanManagement", searchVO);
	}

	public void insertProjectInputPlan(ProjectInputPlanManagement projectInputPlanManagement) {
		insert("InputResultDAO.insertProjectInputPlan", projectInputPlanManagement);
	}

	public void updateProjectInputPlan(ProjectInputPlanManagement projectInputPlanManagement) {
		update("InputResultDAO.updateProjectInputPlan", projectInputPlanManagement);
	}

	public void deleteProjectInputPlan(ProjectInputPlanManagement projectInputPlanManagement) {
		update("InputResultDAO.deleteProjectInputPlan", projectInputPlanManagement);
	}

	public List<MemberVO> selectNotInputMemberList(ProjectInputPlanManagementVO searchVO) {
		return list("InputResultDAO.selectNotInputMemberList", searchVO);
	}

	public List<MemberVO> selectInputResultPersonNotInput(InputResultPerson inputResultPerson) {
		return list("InputResultDAO.selectInputResultPersonNotInput", inputResultPerson);
	}
	
	public List<MemberVO> selectInputResultPersonNotInputStatus(InputResultPerson inputResultPerson) {
		return list("InputResultDAO.selectInputResultPersonNotInputStatus", inputResultPerson);
	}	
	
}
