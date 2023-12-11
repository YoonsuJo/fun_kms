<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
var interval;
$(document).ready(function() { 
	$.tablesorter.addParser({
        // set a unique id
         id: 'myDateFormat',
         is: function (s) {
             return false;
         },
         format: function (s) {
             var date = s.split('.');//Change the special character whatever you will be used in your date format like "/,or."
             return new Date('20'+date[0] , date[1], date[2]).getTime();
         },
         type: 'numeric'
     });
	
	$("#requestTable").tablesorter({
		  headers:
      {
          5: { sorter: "myDateFormat" },
          6: { sorter: "myDateFormat" }
      }
	});	
	
	var refreshCount = sessionStorage.getItem('refreshCount');
	
	if(refreshCount != "" && refreshCount != "undefined" && refreshCount != null){
		$("#refresh_length").val(refreshCount);
		interval = setInterval(function(){
			console.log(refreshCount*1000);
			search();
		}, refreshCount*1000);
	}
	
	$("#refresh_length").bind('change',function(){
		var selectVal = $(this).val();
		if(selectVal != ""){
			sessionStorage.setItem('refreshCount', selectVal);
			clearInterval(interval);
			interval = setInterval(function(){
				console.log(selectVal*1000);
				search();
			}, selectVal*1000);
		}else{
			sessionStorage.removeItem('refreshCount');
			clearInterval(interval);	
		}
	});
});


function searchRequestProcess(mode)
{
	document.fm.searchProcessMode.value = mode;
	search();
}
function search(pageNo) {

	if(pageNo == null) {
		document.fm.pageIndex.value = 1;
	} else {
		document.fm.pageIndex.value = pageNo;
	}
	
	document.fm.method="POST";
	document.fm.action = "<c:url value='${rootPath}/request/RequestList.do'/>";
	document.fm.submit();
}

function searchReqTask() {

	location.href = "/request/ReqTaskL.do";
}

function writeRequest() {
	var POP_NAME = "_REQUEST_WRITE_REQUEST_POP_";
	var target = document.fm.target;
	document.fm.method = "POST";
	document.fm.target = POP_NAME;
	document.fm.action = "/request/RequestWritePop.do";

	//var popup = window.showModalDialog('/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var option = "width=700px, height=700px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	var popup = window.open("about:blank", POP_NAME, option);
	document.fm.submit();
	popup.focus();
	document.fm.target = target;
}

function modifyRequest(no) {
	var POP_NAME = "_REQUEST_MODIFY_REQUEST_POP_";
	var target = document.fm.target;
	document.fm.method = "POST";
	document.fm.target = POP_NAME;
	document.fm.action = "/request/modifyRequestPop.do";

	//var popup = window.showModalDialog('/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var option = "width=700px, height=700px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	var popup = window.open("about:blank", POP_NAME, option);
	document.fm.no.value = no.toString();
	document.fm.submit();
	popup.focus();
	document.fm.target = target;
}
	
function viewRequest(no) {
	var POP_NAME = "_REQUEST_MODIFY_REQUEST_POP_";
	var target = document.fm.target;
	document.fm.method = "POST";
	document.fm.target = POP_NAME;
	document.fm.no.value = no;
	document.fm.action = "<c:url value='${rootPath}/request/RequestV.do'/>";
	
	//var popup = window.showModalDialog('/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var option = "width=700px, height=700px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	var popup = window.open("about:blank", POP_NAME, option);
	document.fm.submit();
	popup.focus();
	document.fm.target = target;
}

function searchRequestStat() {

	location.href = "/request/RequestStat.do";
}
function searchRequestList() {

	location.href = "/request/RequestL.do";
}

function moveDate(dateMove) {
	document.fm.dateMove.value = dateMove;
	search();
}

function toggleDateSearch(val) {
	$val = $(val);
	var type = $(val).data("type");
	if(type == "all"){
		document.fm.dueDateAll.value = "Y";
	}else{
		document.fm.dueDateAll.value = "N";
	}
	search();
	
}
</script>
</head>

<body>

<div id="wrap">
	<%@ include file="../common/menu/head.jsp"%>
	<!-- S: container -->
	<div id="container">
		<ul class="container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="contents">
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">요구사항 관리</li>
							<li class="navi">요구사항 > 요구사항 관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						<!-- <a href="javascript:searchReqTask();"><span class="th_plus03 txtB_grey pL10"> [작업목록] </span></a> -->
						<a href="javascript:searchRequestStat();"><span class="th_plus03 txtB_grey pL10"> [요구사항 처리통계] </span></a>
						<a href="javascript:searchRequestList();"><span class="th_plus03 txtB_grey pL10"> [요구사항검색] </span></a>
						
						<p class="th_stitle">요구사항 처리현황  
						<c:choose>
							<c:when test="${mode =='null' }"> &nbsp;[전체]</c:when>
							<c:otherwise>
							 &nbsp;[${user.userNm }]
							</c:otherwise>
						</c:choose>
						</p>
						<form name="fm" id="fm" methos="POST" >
						<div id="busiContactD">
							<input type="hidden" name="searchUseYn" id="searchUseYn" value="Y"/>
							<input type="hidden" name="no" id="no" value="0"/>
							<input type="hidden" name="param_returnUrl" id="param_returnUrl" value="<c:url value='/request/RequestL.do'/>"/>
							<input type="hidden" name="pageIndex" value="${fm.pageIndex}"/>
							<input type="hidden" name="pageUnit" value="${paginationInfo.recordCountPerPage}"/>
							<input type="hidden" name="searchProcessMode" id="searchProcessMode" value="${fm.searchProcessMode}"/>
							<input type="hidden" name="mode" id="mode" value="${mode}"/>
							<input type="hidden" name="dateMove" value="0"/>
							<input type="hidden" name="dueDateAll" value="${dueDateAll}"/>
							<fieldset>
								<legend>상단 검색</legend>
								<div class="top_search07">
									<table cellpadding="0" cellspacing="0" >
									<caption>상단 검색</caption>
									<colgroup>
										<col class="col100"/>
										<col class="col135"/>
										<col class="col135"/>
										<col class="col135"/>
										<col class="col135"/>
										<col class="col135"/>
										<col class="col135"/>
										<col class="col135"/>
										<col class="col135"/>
										<!-- <col class="col150"/> -->
									</colgroup>
									<tbody>
<%-- 									<tr>
										<td class="txt_center">현황 </td>
										<th class="pT5 pR5 txtB_Black">담당자</th>
										<td colspan="3">
											<label><input type="checkbox" name="managerType1" id="managerType1" value="1" <c:if test="${fm.managerType == 1}">checked="checked"</c:if>/> 개인</label>
											<label><input type="checkbox" name="managerType2" id="managerType2" value="2" <c:if test="${fm.managerType == 2}">checked="checked"</c:if>/> 팀</label>
											<label><input type="checkbox" name="managerType3" id="managerType3" value="3" <c:if test="${fm.managerType == 3}">checked="checked"</c:if>/> 전체</label>
										</td>
										<td class="txt_center">
											<input type="button" value="미처리건" class="btn_gray w70" onclick="javascript:searchToDo();"/>
										</td>
									</tr>
 --%>									<tr>
	 									<tr>
											<td class="txt_center">현황 </td>
											<td><a href="javascript:searchRequestProcess(1);">미처리 : ${ReqPlan.notDone}</a></td>
											<td><a href="javascript:searchRequestProcess(3);">금주잔여 : ${ReqPlan.weekTodo}</a></td>
											<td><a href="javascript:searchRequestProcess(2);">금주완료 : ${ReqPlan.weekDone}</a></td>
											<td><a href="javascript:searchRequestProcess(5);">금월잔여 : ${ReqPlan.monthTodo}</a></td>
											<td><a href="javascript:searchRequestProcess(4);">금월완료 : ${ReqPlan.monthDone}</a></td>
											<td><a href="javascript:searchRequestProcess(6);">다음달계획 : ${ReqPlan.nextMonthTodo}</a></td>
											<td><a href="javascript:searchRequestProcess(7);">추후개발 : ${ReqPlan.nextTodo}</a></td>
											<td><a href="javascript:searchRequestProcess(17);">개발완료 : ${ReqPlan.completeTodo}</a></td>
											<%-- <td><a href="javascript:searchRequestProcess(8);">미정 : ${ReqPlan.unknown}</a></td> --%>
										</tr>
										<%-- <tr style="display:none;">
											<td class="txt_center">구분 </td>
											<td>총건수 : ${ReqStat.stTotal}</td>
											<td><a href="javascript:searchRequestProcess(11);">접수 : ${ReqStat.stRequest}</a></td>
											<td><a href="javascript:searchRequestProcess(12);">검토중 : ${ReqStat.stReview}</a></td>
											<td><a href="javascript:searchRequestProcess(13);">처리중 : ${ReqStat.stProcess}</a></td>
											<td><a href="javascript:searchRequestProcess(14);">완료 : ${ReqStat.stComplete}</a></td>
											<td><a href="javascript:searchRequestProcess(15);">보류 : ${ReqStat.stDefer}</a></td>
											<td><a href="javascript:searchRequestProcess(16);">삭제 : ${ReqStat.stDelete}</a></td>
										</tr> --%>
									</tbody>
									</table>
								</div>
							</fieldset>
						</div>
						<c:if test="${empty status}">
							<div class="top_search">
								<table cellpadding="0" cellspacing="0">
									<caption>상단 검색</caption>
									<colgroup>
										<col width="px">
									</colgroup>
									<tbody>
										<tr>
											<td> 
												<c:if test="${dueDateAll eq 'N'}">
													<span>완료예정 기준일 : </span>
													<a href="javascript:moveDate(-7);"><img src="${imagePath}/btn/btn_prev.gif"></a>
													<input type="text" class="calGen w70 input03" name="atDate" value="${searchAtDate}" readonly="readonly" onchange="javascript:moveDate(0);"/>
													<a href="javascript:moveDate(7);"><img src="${imagePath}/btn/btn_next.gif"></a>
													<span style="margin-left:5px;"> 조회 날짜 : <input type="text" value="${searchDueDateStart} 월" class="w90 input03" readonly="readonly"> ~
													<input type="text" value="${searchDueDateEnd} 일" class="w90 input03" readonly="readonly"></span>
												</c:if>
												<c:choose>
													<c:when test="${dueDateAll eq 'N'}">
														<input type="button" value="전체목록 보기" class="fr btn_gray pL10" data-type="all" onclick="javascript:toggleDateSearch(this);"/>
													</c:when>
													<c:otherwise>
														<input type="button" value="완료예정 기준일 보기" class="fr btn_gray pL10" data-type="due" onclick="javascript:toggleDateSearch(this);"/>
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</c:if>
						</form>

						<div style="text-align: right; margin-top: 5px;">
							새로고침 : 
							<select id="refresh_length" name="refresh_length" class="form-control mr-3" style="width:140px !important;">
								<optgroup label="자동새로고침">
									<option value="">안함</option>
									<option value="10">10초</option>
									<option value="20">20초</option>
									<option value="30">30초</option>
								</optgroup>
							</select>
						</div>
						</br>
						<input type="button" value="등록" class="fr btn_gray pL10" onclick="javascript:writeRequest();"/>
						<span class="fr pL10">&nbsp;</span>
						<input type="button" value="요구사항 등록 샘플" class="fr btn_gray pL10" onclick="javascript:viewRequest('1171');"/>
						<span class="fr pL10">&nbsp;</span>
						<div class="board_option" style="float: right; font-weight: bold; margin-bottom: 10px;">
							(<div style="background-color: #dcebff; width: 20px; height: 10px; border: 1px solid gray; display: inline-block; margin-left: 10px;"></div>
							설계중
							<div style="background-color: #d2ffcd; width: 20px; height: 10px; border: 1px solid gray; display: inline-block; margin-left: 10px;"></div>
							구현중
							<div style="background-color: #ffff9c; width: 20px; height: 10px; border: 1px solid gray; display: inline-block; margin-left: 10px;"></div>
							검증중)
						</div>
						<p class="th_stitle">요구사항 목록 
						
						<c:choose>
							<c:when test="${status == '1'}"> &nbsp;[미처리]</c:when>
							<c:when test="${status == '2'}"> &nbsp;[금주완료]</c:when>
							<c:when test="${status == '3'}"> &nbsp;[금주잔여]</c:when>
							<c:when test="${status == '4'}"> &nbsp;[금월완료]</c:when>
							<c:when test="${status == '5'}"> &nbsp;[금월잔여]</c:when>
							<c:when test="${status == '6'}"> &nbsp;[다음달계획]</c:when>
							<c:when test="${status == '7'}"> &nbsp;[추후개발]</c:when>
							<c:when test="${status == '8'}"> &nbsp;[미정]</c:when>
							<c:when test="${status == '11'}"> &nbsp;[접수]</c:when>
							<c:when test="${status == '12'}"> &nbsp;[검토중]</c:when>
							<c:when test="${status == '13'}"> &nbsp;[처리중]</c:when>
							<c:when test="${status == '14'}"> &nbsp;[완료]</c:when>
							<c:when test="${status == '15'}"> &nbsp;[보류]</c:when>
							<c:when test="${status == '16'}"> &nbsp;[삭제]</c:when>
							<c:when test="${status == '17'}"> &nbsp;[개발완료]</c:when>
							<c:when test="${status == '18'}"> &nbsp;[14일 이내 잔여]</c:when>
							<c:when test="${status == '19'}"> &nbsp;[30일 이내 잔여]</c:when>
						</c:choose>
						</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" id="requestTable" class="tablesorter">
							<colgroup>
								<col class="col50" />
								<col width="px"/>
								<col class="col70" />
								<col class="col90" />
								<col class="col80" />
								<col class="col80" />
								<col class="col60" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">요구명</th>
	
									<th scope="col">작성자</th>
									<th scope="col">관리자</th>
									<th scope="col">시작예정</th>
									<th scope="col">완료예정</th>
									<th scope="col">상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${rVOList}" var="vo" varStatus="c">
									<c:choose>
										<c:when test="${vo.status eq 2}">
											<tr style="background : #dcebff; ">
										</c:when>
										<c:when test="${vo.status eq 4}">
											<tr style="background : #d2ffcd; ">
										</c:when>
										<c:when test="${vo.status eq 8}">
											<tr style="background : #ffff9c; ">
										</c:when>
										<c:otherwise>
											<tr>
										</c:otherwise>
									</c:choose>
									
										<td class="txt_center">${vo.no}</td>
										<td class="txt_left" style="font-weight:bold"><a href="javascript:viewRequest('${vo.no}');">${vo.title}</a></td>
										<td class="txt_center">
											<print:user userNo="${vo.writerNo}" userNm="${vo.writerName}" userId="${vo.writerId}" printId="false"/>
										</td>
										<td class="txt_center">
											<div title="${vo.managerNameList}">${vo.managerMixesMain}	</div>
										</td>
										<td class="txt_center" <c:if test="${vo.dayCheck eq 1}">	style="color : #FF5A5A "</c:if>>${vo.startDate}</td>
										<td class="txt_center" <c:if test="${vo.dueDayCheck eq 1}">		style="color : #FF5A5A "</c:if>>${vo.endDate}</td>
										<td class="txt_center"><a href="javascript:modifyRequest('${vo.no}');">${vo.statusStr}</a></td>
									</tr>
								</c:forEach>
								<c:if test="${empty rVOList}">
									<tr>
										<td class="txt_center td_last" colspan="7">검색된  요구사항건이 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
							</table>
						</div>

						<!-- 페이징 시작 
						<div class="paginate">
							<ui:pagination paginationInfo="${paginationInfo}" jsFunction="search" type="image"/>
						</div>
						 페이징 끝 -->

					</div>
					<!-- E: section -->
				</div>
				<!-- E: center -->
			</div>	
			<!-- E: centerBg -->
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
