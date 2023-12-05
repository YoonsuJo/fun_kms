package kms.com.cooperation.service.impl;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kms.com.common.push.PushSender;
import kms.com.common.push.PushVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.community.service.Note;
import kms.com.community.service.NoteService;
import kms.com.cooperation.service.DayReport;
import kms.com.cooperation.service.DayReportDate;
import kms.com.cooperation.service.DayReportDetail;
import kms.com.cooperation.service.DayReportService;
import kms.com.cooperation.service.DayReportVO;
import kms.com.cooperation.service.DayReportWeek;
import kms.com.cooperation.service.ProjectVO;
import kms.com.cooperation.service.Task;
import kms.com.cooperation.service.TaskContent;
import kms.com.cooperation.service.TaskVO;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.impl.MemberDAO;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("KmsDayReportService")
public class DayReportServiceImpl implements DayReportService {

	@Resource(name = "KmsDayReportDAO")
	private DayReportDAO dayReportDAO;
	
	@Resource(name = "KmsMemberDAO")
	private MemberDAO memberDAO;
	
	@Resource(name = "NkmsDayReportDAO")
	private NkmsDayReportDAO nkmsDayReportDAO;
	
	@Resource(name = "kmsTaskIdGnrService")
	private EgovIdGnrService idGnrService;
	
	
	@Resource(name = "KmsMemberService")
	private MemberService memberService;
	
	@Resource(name = "KmsNoteService")
	private NoteService noteService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "pushSender")
	private PushSender pushSender;
	
	@Resource(name="KmsProjectDAO")
	private ProjectDAO projectDAO;
	
	@Override
	public Map<String, Object> selectDayReportBrief(Map<String, Object> param) throws Exception {
		
		int searchUserNo = memberDAO.selectUserNo(param);
		param.put("searchUserNo", searchUserNo);
		
		String searchDate = (String)param.get("searchDate");
		
		int tmp = 2 - CalendarUtil.getDay(searchDate) > 0 ? - 5 - CalendarUtil.getDay(searchDate) : 2 - CalendarUtil.getDay(searchDate);
		
		param.put("sDate", CalendarUtil.getDate(searchDate, tmp));
		param.put("eDate", CalendarUtil.getDate(searchDate, tmp + 6));
		
		// param : sDate, eDate, searchUserNo
		List<TaskVO> taskList = dayReportDAO.selectTaskList(param);
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<DayReportWeek> processList = new ArrayList<DayReportWeek>(); // 미완료작업
		List<DayReportWeek> endList = new ArrayList<DayReportWeek>(); // 완료된 작업
		List<Integer> workTime = new ArrayList<Integer>(); // 투입시간합계
		for (int i=0; i<7; i++) {
			workTime.add(0);
		}
		List<Integer> leftTime = dayReportDAO.selectLeftTime(param);
		
		String[] taskIdArray = new String[taskList.size()];
		for (int i=0; i<taskList.size(); i++) {
			taskIdArray[i] = taskList.get(i).getTaskId();
		}
		
		param.put("taskIdArray", taskIdArray);
		List<DayReport> dayReportList = dayReportDAO.selectDayReportList(param); // taskIdArray, dayReportDt ASC
		List<TaskContent> taskContentList = dayReportDAO.selectTaskContentList(param); // taskIdArray, dayReportDt ASC

		String sDate = (String)param.get("sDate");
		
		for (int i=0; i<taskList.size(); i++) {
			Task task = taskList.get(i);
			DayReportWeek dayReportWeek = new DayReportWeek();
			
			for (int j=0; j<7; j++) {
				DayReportDate dayReportDate = new DayReportDate();
				dayReportDate.setDate(CalendarUtil.getDate(sDate, j));
				
				for (int k=0; k<dayReportList.size(); k++) {
					DayReport dayReport = dayReportList.get(k);
					
					if (dayReport.getTaskId().equals(task.getTaskId()) && dayReportDate.getDate().equals(dayReport.getDayReportDt())) {
						dayReportDate.addDayReportList(dayReport);
						
						dayReportList.remove(k);
						k--;
					}
				}
				dayReportDate.setSum();
				dayReportWeek.addDayReportDateList(dayReportDate);
			}
			
			for (int j=0; j<taskContentList.size(); j++) {
				TaskContent taskContent = taskContentList.get(j);
				
				if (taskContent.getTaskId().equals(task.getTaskId())) {
					dayReportWeek.addTaskContentList(taskContent);
					
					taskContentList.remove(j);
					j--;
				}
			}
			
			dayReportWeek.setTask(task);
			dayReportWeek.setSum();
			if (task.isProcess()) {
				processList.add(dayReportWeek);
			} else if (task.isComplete()) {
				endList.add(dayReportWeek);
			}
			for (int n=0; n<7; n++) {
				workTime.set(n, workTime.get(n) + dayReportWeek.getSumList().get(n));
			}
		}
		result.put("processList", processList);
		result.put("endList", endList);
		result.put("workTime", workTime);
		result.put("leftTime", leftTime);
		
		return result;
	}
	
	@Override
	public List<DayReportDetail> selectDayReportDetail(Map<String, Object> param) throws Exception {
		
		int searchUserNo = memberDAO.selectUserNo(param);
		param.put("searchUserNo", searchUserNo);
		String searchDate = (String)param.get("searchDate");
		int tmp = 2 - CalendarUtil.getDay(searchDate) > 0 ? - 5 - CalendarUtil.getDay(searchDate) : 2 - CalendarUtil.getDay(searchDate);
		
		param.put("sDate", CalendarUtil.getDate(searchDate, tmp));
		param.put("eDate", CalendarUtil.getDate(searchDate, tmp + 6));
		
		// param : sDate, eDate, searchUserNo
		List<TaskVO> taskList = dayReportDAO.selectTaskList(param);

		List<DayReportDetail> resultList = new ArrayList<DayReportDetail>();
		
		String[] taskIdArray = new String[taskList.size()];
		for (int i=0; i<taskList.size(); i++) {
			taskIdArray[i] = taskList.get(i).getTaskId();
		}
		
		param.put("taskIdArray", taskIdArray);
		
		List<DayReport> dayReportList = dayReportDAO.selectDayReportList(param); // taskIdArray, dayReportDt ASC
		List<TaskContent> taskContentList = dayReportDAO.selectTaskContentList(param); // taskIdArray, dayReportDt ASC
		
		String sDate = (String)param.get("sDate");
		
		for (int i=0; i<7; i++) {
			DayReportDetail dayReportDetail = new DayReportDetail();
			
			String date = CalendarUtil.getDate(sDate, i);
			
			dayReportDetail.setDate(date);

			for (int j=0; j<taskList.size(); j++) {
				TaskVO taskVO = new TaskVO();
				TaskVO tmpTask = taskList.get(j);
				
				taskVO.setPrjCd(tmpTask.getPrjCd());
				taskVO.setPrjId(tmpTask.getPrjId());
				taskVO.setPrjNm(tmpTask.getPrjNm());
				taskVO.setTaskCn(tmpTask.getTaskCn());
				taskVO.setTaskDuedate(tmpTask.getTaskDuedate());
				taskVO.setTaskEnddate(tmpTask.getTaskEnddate());
				taskVO.setTaskId(tmpTask.getTaskId());
				taskVO.setTaskRegdate(tmpTask.getTaskRegdate());
				taskVO.setTaskSj(tmpTask.getTaskSj());
				taskVO.setTaskStartdate(tmpTask.getTaskStartdate());
				taskVO.setTaskState(tmpTask.getTaskState());
				taskVO.setUserNo(tmpTask.getUserNo());
				taskVO.setUserNm(tmpTask.getUserNm());
				taskVO.setUserId(tmpTask.getUserId());
				taskVO.setWriterNo(tmpTask.getWriterNo());
				taskVO.setWriterNm(tmpTask.getWriterNm());
				taskVO.setWriterId(tmpTask.getWriterId());

				for (int k=0; k<taskContentList.size(); k++) {
					TaskContent taskContent = taskContentList.get(k);

					if (taskVO.getTaskId().equals(taskContent.getTaskId())) {
						taskVO.addTaskContentList(taskContent);
					}
				}
				
				for (int k=0; k<dayReportList.size(); k++) {
					DayReport dayReport = dayReportList.get(k);
					
					if (taskVO.getTaskId().equals(dayReport.getTaskId()) && date.equals(dayReport.getDayReportDt())) {
						taskVO.addDayReportList(dayReport);
						
						dayReportList.remove(k);
						k--;
					}
				}
				
				String sDt = taskVO.getTaskStartdate();
				String eDt = taskVO.getTaskEnddate();
				String dDt = taskVO.getTaskDuedate();
				if (sDt == null || sDt.equals("")) sDt = "10000101";
				if (eDt == null || eDt.equals("")) eDt = "99991231";
				if (dDt == null || dDt.equals("")) dDt = "99991231";
				
				String aeDt = "10000101"; // 실제 완료일 (마지막 실적 등록일)
				for (int m=0; m < taskVO.getDayReportList().size(); m++) {
					DayReport dayReport = taskVO.getDayReportList().get(m);
					if (CalendarUtil.getDateDiff(dayReport.getDayReportDt(), aeDt) >= 0)
					{
						aeDt = dayReport.getDayReportDt();
					}
				}

				boolean addList = false;
				if (taskVO.isProcess()) {
					if (CalendarUtil.getDateDiff(date, sDt) >= 0 &&
							(CalendarUtil.getDateDiff(dDt, date) >= 0 || CalendarUtil.getDateDiff(CalendarUtil.getToday(), date) >= 0)) {
						addList = true;
					}
				} else {
					if (CalendarUtil.getDateDiff(date, sDt) >= 0 && CalendarUtil.getDateDiff(dDt, date) >= 0 && CalendarUtil.getDateDiff(aeDt, date) >= 0) {
						addList = true;
					}
				}
				
				if (taskVO.getDayReportList().size() > 0) {
					addList = true;
				}
				
				if (addList) {
					dayReportDetail.addTaskList(taskVO);
				}
				
				/*
				if (taskVO.getDayReportList().size() > 0 ||
						( CalendarUtil.getDateDiff(date, sDt) >= 0 && CalendarUtil.getDateDiff(eDt, date) >= 0 &&
								( CalendarUtil.getDateDiff(dDt, date) >= 0 || CalendarUtil.getDateDiff(CalendarUtil.getToday(), date) >= 0 ) ) ) {
					dayReportDetail.addTaskList(taskVO);
				}
				*/
			}
			resultList.add(dayReportDetail);
		}		
		return resultList;
	}
	
	//나의 업부 S
	@Override
	public List<DayReport> selectDayReportMyList(Map<String, Object> param) throws Exception {
		return dayReportDAO.selectDayReportMyList(param);
	}
	
	@Override
	public int selectDayReportMyListTotCnt(Map<String, Object> param) throws Exception {
		return dayReportDAO.selectDayReportMyListTotCnt(param);
	}
	
	@Override
	public int selectDayReportMyListCompleteTotCnt(Map<String, Object> param) throws Exception {
		return dayReportDAO.selectDayReportMyListCompleteTotCnt(param);
	}
	
	public List<DayReport> selectDayReportOrderList(DayReportVO param) throws Exception {
		return dayReportDAO.selectDayReportOrderList(param);
	}
	
	@Override
	public int selectDayReportOrderListTotCnt(DayReportVO param) throws Exception {
		return dayReportDAO.selectDayReportOrderListTotCnt(param);
	}

	
	@Override
	public List<TaskVO> selectDayReportMyDList(DayReportVO param) throws Exception {	
	
		List<TaskVO> taskList = dayReportDAO.selectDayReportMyTList(param);
		
		String[] taskIdArray = new String[taskList.size()];
		for (int i=0; i<taskList.size(); i++) {
			taskIdArray[i] = taskList.get(i).getTaskId();
		}
		
		Map<String,Object> param2 = new HashMap<String,Object>();
		param2.put("taskIdArray", taskIdArray);
		List<DayReportVO> dayReportList =  dayReportDAO.selectDayReportMyDList(param); // taskIdArray, dayReportDt ASC

		List<TaskVO> resultList = new ArrayList<TaskVO>();
		
		for (int j=0; j<taskList.size(); j++) {
			TaskVO taskVO = new TaskVO();
			TaskVO tmpTask = taskList.get(j);
			
			taskVO.setPrjCd(tmpTask.getPrjCd());
			taskVO.setPrjId(tmpTask.getPrjId());
			taskVO.setPrjNm(tmpTask.getPrjNm());
			taskVO.setTaskCn(tmpTask.getTaskCn());
			taskVO.setTaskDuedate(tmpTask.getTaskDuedate());
			taskVO.setTaskEnddate(tmpTask.getTaskEnddate());
			taskVO.setTaskId(tmpTask.getTaskId());
			taskVO.setTaskRegdate(tmpTask.getTaskRegdate());
			taskVO.setTaskSj(tmpTask.getTaskSj());
			taskVO.setTaskStartdate(tmpTask.getTaskStartdate());
			taskVO.setTaskState(tmpTask.getTaskState());
			taskVO.setUserNo(tmpTask.getUserNo());
			taskVO.setUserNm(tmpTask.getUserNm());
			taskVO.setUserId(tmpTask.getUserId());
			taskVO.setWriterNo(tmpTask.getWriterNo());
			taskVO.setWriterNm(tmpTask.getWriterNm());
			taskVO.setWriterId(tmpTask.getWriterId());
		


			
			for (int k=0; k<dayReportList.size(); k++) {
				DayReport dayReport = dayReportList.get(k);
				
				if (taskVO.getTaskId().equals(dayReport.getTaskId())) {
					taskVO.addDayReportList(dayReport);
					
					dayReportList.remove(k);
					k--;
				}
			}
			
			
			resultList.add(taskVO);
		}
		return resultList;
	}
	
/*
	@Override
	public List<DayReportVO> selectDayReportMyDList(DayReportVO param) throws Exception {	
		return dayReportDAO.selectDayReportMyDList(param);	
	}
*/	
	@Override
	public int selectDayReportMyTListTotCnt(DayReportVO dayReportVO) throws Exception {
		return dayReportDAO.selectDayReportMyTListTotCnt(dayReportVO);
	}
	
	
	//나의 업무 E	
	@Override
	public List<DayReportDetail> selectDayReportDetailUser(Map<String, Object> param) throws Exception {
		
		// 검색조건 변경 searchDate -> searchDateFrom, searchDateTo // searchUserNo 커맨드맵 조건 추가 : 전달값 안들어오면 0
		int searchUserNo = Integer.parseInt( (String)param.get("searchUserNo") );
		if(searchUserNo == 0)
			searchUserNo = memberDAO.selectUserNo(param);
		param.put("searchUserNo", searchUserNo);
		String searchDateFrom = (String)param.get("searchDateFrom");
		String searchDateTo = (String)param.get("searchDateTo");
		String myOrgId = (String)param.get("myOrgId");
		String myOrgIdSec = (String)param.get("myOrgIdSec");
		
		DayReportVO dayReportVO = new DayReportVO();
		dayReportVO.setSearchDateFrom(searchDateFrom);
		dayReportVO.setSearchDateTo(searchDateTo);
		dayReportVO.setSearchCondition("2");
		dayReportVO.setSearchUserNo(searchUserNo);
		dayReportVO.setMyOrgId(myOrgId);
		dayReportVO.setMyOrgIdSec(myOrgIdSec);
		List<EgovMap> resultList1 = selectDayReportUserList(dayReportVO);
		EgovMap egovMap = new EgovMap();
		if(resultList1.size()>0)
			egovMap = resultList1.get(0);
		String allDate = (String) egovMap.get("allDate");
		String normalDate = (String) egovMap.get("normalDate");
		String overDate = (String) egovMap.get("overDate");
		String lateDate = (String) egovMap.get("lateDate");
		String noinputDate = (String) egovMap.get("noinputDate");
		String[] dateList = {""};
		
		String mode = (String)param.get("mode");
		if(mode.equals("0") && allDate != null)
			dateList = allDate.split(",");		
		else if(mode.equals("1") && normalDate != null)
			dateList = normalDate.split(",");
		else if(mode.equals("2") && overDate != null)
			dateList = overDate.split(",");
		else if(mode.equals("3") && lateDate != null)
			dateList = lateDate.split(",");
		else if(mode.equals("4") && noinputDate != null)
			dateList = noinputDate.split(",");
		
		param.put("mode", mode);
		param.put("dateList", dateList);
		param.put("sDate", searchDateFrom);
		param.put("eDate", searchDateTo);
		
		// param : sDate, eDate, searchUserNo, option(normal, over, late, noinput)
		List<TaskVO> taskList = dayReportDAO.selectTaskList(param);
		List<DayReportDetail> resultList = new ArrayList<DayReportDetail>();
		
		String[] taskIdArray = new String[taskList.size()];
		for (int i=0; i<taskList.size(); i++) {
			taskIdArray[i] = taskList.get(i).getTaskId();
		}		
		param.put("taskIdArray", taskIdArray);
		
		List<DayReport> dayReportList = dayReportDAO.selectDayReportList(param); // taskIdArray, dayReportDt ASC
		List<TaskContent> taskContentList = dayReportDAO.selectTaskContentList(param); // taskIdArray, dayReportDt ASC
		
		String sDate = (String)param.get("sDate");
		
		if(dateList.length == 1 && dateList[0].equals("")){
			//결과값 없음
		} else			
		for (int i=0; i < dateList.length; i++) { //여기가 포인트네 7일치만 집어넣는거
			DayReportDetail dayReportDetail = new DayReportDetail();
			
			//여기가 포인트. 7일치만 집어넣는 기존 루틴 수정
			//아래쪽에서  dayReportList.remove(k);로 인해 뒤로 갈수록 누락되는 문제 해결해야함
			//String date = dayReportList.get(i).getDayReportDt(); //CalendarUtil.getDate(sDate, i);	
			String date = dateList[i];
			dayReportDetail.setDate(date);

			for (int j=0; j < taskList.size(); j++) {
				TaskVO taskVO = new TaskVO();
				TaskVO tmpTask = taskList.get(j);
				
				taskVO.setPrjCd(tmpTask.getPrjCd());
				taskVO.setPrjId(tmpTask.getPrjId());
				taskVO.setPrjNm(tmpTask.getPrjNm());
				taskVO.setTaskCn(tmpTask.getTaskCn());
				taskVO.setTaskDuedate(tmpTask.getTaskDuedate());
				taskVO.setTaskEnddate(tmpTask.getTaskEnddate());
				taskVO.setTaskId(tmpTask.getTaskId());
				taskVO.setTaskRegdate(tmpTask.getTaskRegdate());
				taskVO.setTaskSj(tmpTask.getTaskSj());
				taskVO.setTaskStartdate(tmpTask.getTaskStartdate());
				taskVO.setTaskState(tmpTask.getTaskState());
				taskVO.setUserNo(tmpTask.getUserNo());
				taskVO.setUserNm(tmpTask.getUserNm());
				taskVO.setUserId(tmpTask.getUserId());
				taskVO.setWriterNo(tmpTask.getWriterNo());
				taskVO.setWriterNm(tmpTask.getWriterNm());
				taskVO.setWriterId(tmpTask.getWriterId());

				for (int k=0; k < taskContentList.size(); k++) {
					TaskContent taskContent = taskContentList.get(k);
					if (taskVO.getTaskId().equals(taskContent.getTaskId())) {
						taskVO.addTaskContentList(taskContent);
					}
				}
				
				for (int k=0; k < dayReportList.size(); k++) {
					DayReport dayReport = dayReportList.get(k);
					
					if (taskVO.getTaskId().equals(dayReport.getTaskId()) && date.equals(dayReport.getDayReportDt())) {
						taskVO.addDayReportList(dayReport);
						dayReportList.remove(k); //하루에 여러개 업무일지 작성시 같은날짜 중복해서 표시되는 문제 해결
						k--;
					}
				}
				
				String sDt = taskVO.getTaskStartdate();
				String eDt = taskVO.getTaskEnddate();
				String dDt = taskVO.getTaskDuedate();
				if (sDt == null || sDt.equals("")) 
					sDt = "10000101";
				if (eDt == null || eDt.equals(""))
					eDt = "99991231";
				if (dDt == null || dDt.equals("")) 
					dDt = "99991231";
				
				String aeDt = "10000101"; // 실제 완료일 (마지막 실적 등록일) actual end date
				for (int m=0; m < taskVO.getDayReportList().size(); m++) {
					DayReport dayReport = taskVO.getDayReportList().get(m);
					if (CalendarUtil.getDateDiff(dayReport.getDayReportDt(), aeDt) >= 0) {
						aeDt = dayReport.getDayReportDt();
					}
				}

				boolean addList = false;
				if (taskVO.isProcess()) {
					if (CalendarUtil.getDateDiff(date, sDt) >= 0 &&
							(CalendarUtil.getDateDiff(dDt, date) >= 0 || CalendarUtil.getDateDiff(CalendarUtil.getToday(), date) >= 0)) {
						addList = true;
					}
				} else if (CalendarUtil.getDateDiff(date, sDt) >= 0 && CalendarUtil.getDateDiff(dDt, date) >= 0 && CalendarUtil.getDateDiff(aeDt, date) >= 0) {
						addList = true;
				}				
				if (taskVO.getDayReportList().size() > 0) {
					addList = true;
				}
				
				if (addList) {
					dayReportDetail.addTaskList(taskVO);
				}
				
				/*
				if (taskVO.getDayReportList().size() > 0 ||
						( CalendarUtil.getDateDiff(date, sDt) >= 0 && CalendarUtil.getDateDiff(eDt, date) >= 0 &&
								( CalendarUtil.getDateDiff(dDt, date) >= 0 || CalendarUtil.getDateDiff(CalendarUtil.getToday(), date) >= 0 ) ) ) {
					dayReportDetail.addTaskList(taskVO);
				}
				*/
			}
			resultList.add(dayReportDetail);
		}		
		return resultList;
	}

	@Override
	public TaskVO selectTaskInfo(Map<String, Object> param) throws Exception {
		TaskVO result = dayReportDAO.selectTask(param);
		result.setTaskContentList(dayReportDAO.selectTaskContentList(param));
		param.put("userNo", null);	//2014019, 팀원들의 정보도 조회하기 위해 수정
		result.setDayReportList(dayReportDAO.selectDayReportList(param));
		
		return result;
	}

	

	
	@Override
	public List<TaskVO> selectTaskList(Map<String, Object> param) throws Exception {
		return dayReportDAO.selectTaskList(param);
	}
	
	public List<DayReport> selectDayReportList(Map<String, Object> param) throws Exception {
		return dayReportDAO.selectDayReportList(param);
	}
	
	public List<EgovMap> selectDayReportUserList(DayReportVO param) throws Exception {
		return dayReportDAO.selectDayReportUserList(param);
	}
	
	public List<EgovMap> selectDayReportUserList1(DayReportVO param) throws Exception {
		return dayReportDAO.selectDayReportUserList1(param);
	}
	
	public List<EgovMap> selectDayReportUserList2(DayReportVO param) throws Exception {
		return dayReportDAO.selectDayReportUserList2(param);
	}

	@Override
	public String insertTask(Task task) throws Exception {
		for (int i=0; i<task.getUserMixList().length; i++) {
			String taskId = idGnrService.getNextStringId();
			task.setTaskId(taskId);
			task.setUserNm(task.getUserMixList()[i]);
			dayReportDAO.insertTask(task);
			
			List<String> userMixList = CommonUtil.makeValidIdListArray(task.getUserNm());
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("userMixList", userMixList);
			param.put("alarmUserList", 0);
			List<MemberVO> memberList = memberService.selectMemberListById(param);
			if(!memberList.get(0).getUserNo().equals(task.getWriterNo())){

				Note note = new Note();
				note.setRecieverIdList(new String[]{memberList.get(0).getUserId()});
				note.setSenderNo(task.getWriterNo());

				String msg = "[업무지시 알림] \n";
				msg += "지시자 : "+task.getWriterNm()+ "\n";
				msg += "담당자 : "+memberList.get(0).getUserNm()+ "\n";
				msg += "시작일 : "+task.getTaskStartdatePrint2()+" "+task.getTaskStarttimePrint()+"\n";
				msg += "완료예정일 : "+task.getTaskDuedatePrint2()+" "+task.getTaskDuetimePrint()+"\n";
				msg += "내용 : \n";
				msg += task.getTaskCn()+"\n";
				msg += " \n";
				msg += "[문서정보] \n";
				msg += "작업명 : "+task.getTaskSj()+ "\n";
				msg += task.getRootUrl()+"/cooperation/selectTaskInfo.do?taskId="+task.getTaskId()+ "\n";
				
				note.setNoteCn(msg);
				
				List<String> rPhoneList = new ArrayList<String>();
				String toPhoneNo = memberList.get(0).getMoblphonNo().replace("-", "");
		
				if(toPhoneNo != null && !toPhoneNo.equals("")){
					rPhoneList.add(toPhoneNo);
					
					MemberVO senderVO = new MemberVO();
					senderVO.setNo(task.getWriterNo());
					senderVO = memberService.selectMemberBasic(senderVO);
					
					PushVO pushVO = new PushVO();
					pushVO.setSenderVO(senderVO);
					pushVO.setrPhoneList(rPhoneList);
					pushVO.setMsg(msg);
					
					// 푸쉬 발송
					String type = "note";
					String pushResult = pushSender.sendMessage(type, pushVO);
				}
				noteService.sendNote(note);
			}
		}
		return "success";
	}

	@Override
	public void updateTask(Task task) throws Exception {
		dayReportDAO.updateTask(task);
	}

	@Override
	public void updateTaskState(Task task) throws Exception {
		dayReportDAO.updateTaskState(task);
	}


	@Override
	public String insertTaskStateHistory(Task task) throws Exception {
			dayReportDAO.insertTaskStateHistory(task);
		return "success";
	}
	@Override
	public void deleteTask(Task task) throws Exception {
		TaskContent taskContent = new TaskContent();
		DayReport dayReport = new DayReport();
		
		taskContent.setTaskId(task.getTaskId());
		dayReport.setTaskId(task.getTaskId());
		
		dayReportDAO.deleteTaskContent(taskContent);
		dayReportDAO.deleteDayReport(dayReport);
		dayReportDAO.deleteTask(task);
	}

	@Override
	public DayReport selectDayReport(Map<String, Object> param) throws Exception {
		return dayReportDAO.selectDayReport(param);
	}
	
	@Override
	public void insertDayReport(List<DayReport> dayReportList) throws Exception {
		for (int i=0; i<dayReportList.size(); i++) {
			dayReportDAO.insertDayReport(dayReportList.get(i));
			updateDayReportTotalTm(dayReportList.get(i));
		}
	}
	
	@Override
	public void insertDayReport(DayReport dayReport) throws Exception {
		int no = dayReportDAO.insertDayReport(dayReport);
		
		updateDayReportTotalTm(dayReport);
		
		// 프로젝트 마지막 실적등록일 갱신
		ProjectVO projectVO = new ProjectVO();
		projectVO.setPrjId(dayReport.getPrjId());
		projectVO.setLastReportNo(no);
		projectDAO.updateProjectLastReport(projectVO);
	}
	
	@Override
	public void updateDayReport(DayReport dayReport) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("no", dayReport.getNo());
		DayReport dr = dayReportDAO.selectDayReport(param);		
		dayReportDAO.updateDayReport(dayReport);
		if(dayReport.getDayReportDt().equals(dr.getDayReportDt()) == false){
			updateDayReportTotalTm(dr);			
		}
		updateDayReportTotalTm(dayReport);
	}
	
	@Override
	public void updateDayReportTotalTm(DayReport dayReport) throws Exception {
		//매우 중요한 기능으로 FN_GET_LABOR 에서 사용하는 그 달의 총 업무시간을 업데이트한다
		//FN_GET_LABOR 관련 전체 쿼리 속도를 400배 이상 높여주는 중요한 기능
		dayReportDAO.updateDayReportTotalTm(dayReport);
	}

	@Override
	public void deleteDayReport(DayReport dayReport) throws Exception {
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("no", dayReport.getNo());
		DayReport dr = dayReportDAO.selectDayReport(param);
		dayReportDAO.deleteDayReport(dayReport);
		updateDayReportTotalTm(dr); //rowLock 걸려서 다른 프로세스로 분리
	}
	
	@Override
	public void insertTaskContent(TaskContent taskContent) throws Exception {
		dayReportDAO.insertTaskContent(taskContent);
	}
	
	@Override
	public void updateTaskContent(TaskContent taskContent) throws Exception {
		dayReportDAO.updateTaskContent(taskContent);
	}
	
	@Override
	public void deleteTaskContent(TaskContent taskContent) throws Exception {
		dayReportDAO.deleteTaskContent(taskContent);
	}

	@Override
	public List<DayReportVO> searchDayReportList(DayReportVO dayReportVO) throws Exception {
		return dayReportDAO.searchDayReportList(dayReportVO);
	}

	@Override
	public int searchDayReportListTotCnt(DayReportVO dayReportVO) throws Exception {
		return dayReportDAO.searchDayReportListTotCnt(dayReportVO);
	}

	@Override
	public List<Task> selectTaskListByPrjId(Map<String, Object> param)
			throws Exception {
		return dayReportDAO.selectTaskListByPrjId(param);
	}

	@Override
	public int selectTaskListByPrjIdTotCnt(Map<String, Object> param)
			throws Exception {
		return dayReportDAO.selectTaskListByPrjIdTotCnt(param);
	}

	@Override
	public List<Task> selectPostTaskList(Map<String, Object> param)
			throws Exception {
		return dayReportDAO.selectPostTaskList(param);
	}

	@Override
	public List<EgovMap> selectDayReportTmSum(Map<String, Object> param) throws Exception {
		List<String> dateList = (List<String>)param.get("dateList");
		
		List<EgovMap> resultList = dayReportDAO.selectDayReportTmSum(param);
		
		for (int i=0; i<resultList.size(); i++) {
			EgovMap result = resultList.get(i);
			
			String[] tmList = ((String)result.get("tmList")).split(",");
			
			for (int j=0; j<tmList.length; j++) {
				result.put(dateList.get(j), tmList[j]);
			}
		}
		 
		return resultList;
	}

	@Override
	public List<Task> selectTaskHistoryList(Map<String, Object> param)
			throws Exception {
		return dayReportDAO.selectTaskHistoryList(param);
	}
	
	/**
	 * 팀장별 나의 업무 미작성 인력 목록 추출
	 */
	@Override
	public List<EgovMap> selectNoInputList(Map<String, Object> param) throws Exception {
		return dayReportDAO.selectNoInputList(param);
	}

}
