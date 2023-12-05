package kms.com.management.service;

import java.util.List;

import kms.com.member.service.MemberVO;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface InputResultService {

	List<InputResultPersonVO> selectInputResultPerson(InputResultPerson inputResultPerson) throws Exception;
	
	List<InputResultPersonVO> selectInputResultPlanPerson(InputResultPerson inputResultPerson) throws Exception;
	
	List<InputResultPersonVO> selectInputResultPlanPersonStatus(InputResultPerson inputResultPerson) throws Exception;
	
	List<InputResultPersonVO> selectInputResultPlanProject(InputResultPerson inputResultPerson) throws Exception;
	
	List<InputResultProjectVO> selectInputResultProject(InputResultProject inputResultProject) throws Exception;
	
	List<InputResultProject> selectInputResultSum(InputResultProject inputResultProject) throws Exception;
	
	List<InputResultProjectDetailVO> selectInputResultProjectDetail(InputResultProjectDetail inputResultProjectDetail) throws Exception;

	InputResultDeptVO selectInputResultDept(InputResultDeptVO inputResultDeptVO) throws Exception;
	
	
	List<ProjectInputPlanManagementVO> selectProjectInputPlanManagementList(ProjectInputPlanManagementVO searchVO) throws Exception;

	List<ProjectInputPlanDailyVO> selectProjectInputPlanDailyList(ProjectInputPlanManagementVO searchVO) throws Exception;

	ProjectInputPlanManagementVO selectProjectInputPlanManagement(ProjectInputPlanManagementVO searchVO) throws Exception;

	void insertProjectInputPlan(ProjectInputPlanManagement projectInputPlanManagement) throws Exception;

	void updateProjectInputPlan(ProjectInputPlanManagement projectInputPlanManagement) throws Exception;

	void deleteProjectInputPlan(ProjectInputPlanManagement projectInputPlanManagement) throws Exception;

	List<MemberVO> selectNotInputMemberList(ProjectInputPlanManagementVO searchVO) throws Exception;

	List<MemberVO> selectInputResultPersonNotInput(InputResultPerson inputResultPerson) throws Exception;
	
	List<MemberVO> selectInputResultPersonNotInputStatus(InputResultPerson inputResultPerson) throws Exception;
}
