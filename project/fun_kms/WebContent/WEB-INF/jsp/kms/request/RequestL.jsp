<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
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
	
	$("#checkAll").prop("checked", true);
	for(var i=1;i<8;i++){
		if(!$("#status"+i).is(':checked')){
			$("#checkAll").prop("checked", false);
		}
	}
	
	$(".statusCheck").change(function(){
		if(!$("#"+this.id).is(":checked")){
			$("#checkAll").prop("checked", false);	
		}else{
			var count = 0;
			for(var i=1;i<8;i++){
				if($("#status"+i).is(':checked')){
					count++;
				}
			}
			if(count == 7){
				$("#checkAll").prop("checked", true);
			}
		}
	});
});

function search(pageNo) {

	if(pageNo == null) {
		document.fm.pageIndex.value = 1;
	} else {
		document.fm.pageIndex.value = pageNo;
	}
	
	document.fm.method="POST";
	document.fm.action = "<c:url value='${rootPath}/request/RequestL.do'/>";
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

function cleanInput(object){
	var input = document.getElementById(object);
	input.value = "";
}

function cleanDate(from, to){
	var from = document.getElementById(from);
	var to = document.getElementById(to);
	from.value = "";
	to.value = "";
}

function selectAll(){
	if($("#checkAll").is(':checked')){
		$(".statusCheck").prop('checked', true)
	}else{
		$(".statusCheck").prop('checked', false)
	}
}

function toFrom(obj){
	var from;
	if(obj.id == "searchSdate"){
		from = document.getElementById("searchEdate");
	}else if(obj.id == "searchSDuedate"){
		from = document.getElementById("searchEDuedate");
	}
	
	if(from.value == ""){
		from.value = obj.value;
	}else if(from.value < obj.value){
		from.value = obj.value;
	}
}

function fromTo(obj){
	var from;
	if(obj.id == "searchEdate"){
		from = document.getElementById("searchSdate");
	}else if(obj.id == "searchEDuedate"){
		from = document.getElementById("searchSDuedate");
	}
	
	if(from.value == ""){
		from.value = obj.value;
	}else if(from.value > obj.value){
		from.value = obj.value;
	}
}

function isChecked(obj){
	if(!obj.is(':checked')){
		$("#checkAll").prop("checked", false);
	}
}

function viewRequest(no) {

	document.fm.method = "POST";
	document.fm.no.value = no;
	document.fm.action = "<c:url value='${rootPath}/request/RequestV.do'/>";
	document.fm.submit();
}

function searchRequestStat() {
	location.href = "/request/RequestStat.do";
}
function searchRequestProcess() {
	location.href = "/request/RequestList.do";
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
							<li class="stitle">요구사항 목록</li>
							<li class="navi">요구사항 관리 > 요구사항 목록</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						<!-- <a href="javascript:searchReqTask();"><span class="th_plus03 txtB_grey pL10"> [작업목록] </span></a> -->
						<a href="javascript:searchRequestProcess();"><span class="th_plus03 txtB_grey pL10"> [요구사항 관리] </span></a>
						<p class="th_stitle">요구사항 검색</p>
						<div id="busiContactD">
						 <form name="fm" id="fm" methos="POST" >
							<input type="hidden" name="searchUseYn" id="searchUseYn" value="Y"/>
							<input type="hidden" name="no" id="no" value="0"/>
							<input type="hidden" name="param_returnUrl" id="param_returnUrl" value="<c:url value='/request/RequestL.do'/>"/>
							<input type="hidden" name="excel" value="N" />
							<input type="hidden" name="pageIndex" value="${fm.pageIndex}"/>
							<input type="hidden" name="pageUnit" value="${paginationInfo.recordCountPerPage}"/>
							<fieldset>
								<legend>상단 검색</legend>
								<div class="top_search07">
								<table cellpadding="0" cellspacing="0" >
								<caption>상단 검색</caption>
								<colgroup>
									<col class="col100"/>
									<col class="col500"/>
									<col class="col80"/>
									<col class="col200"/>
									<col class="col80"/>
								</colgroup>
								<tbody>
 									<tr>
										<th class="pT5 pR5 txtB_Black">처리상태</th>
										<td>
											<label><input type="checkbox" class="statusCheck" name="status1" id="status1" value="1" <c:if test="${fm.status1 == 1}">checked="checked"</c:if>/> 대기중</label>
											<label><input type="checkbox" class="statusCheck" name="status2" id="status2" value="2" <c:if test="${fm.status2 == 2}">checked="checked"</c:if>/> 설계중</label>
											<label><input type="checkbox" class="statusCheck" name="status3" id="status3" value="4" <c:if test="${fm.status3 == 4}">checked="checked"</c:if>/> 구현중</label>
											<label><input type="checkbox" class="statusCheck" name="status4" id="status4" value="8" <c:if test="${fm.status4 == 8}">checked="checked"</c:if>/> 검증중</label>
											<label><input type="checkbox" class="statusCheck" name="status5" id="status5" value="16" <c:if test="${fm.status5 == 16}">checked="checked"</c:if>/> 완료</label>
											<label><input type="checkbox" class="statusCheck" name="status6" id="status6" value="32" <c:if test="${fm.status6 == 32}">checked="checked"</c:if>/> 보류</label>
											<label><input type="checkbox" class="statusCheck" name="status7" id="status7" value="64" <c:if test="${fm.status7 == 64}">checked="checked"</c:if>/> 삭제</label>
											<label><input type="checkbox" id="checkAll" onclick='javascript:selectAll()'/> 전체체크</label>
										</td>

									</tr>
									<tr>
										<th class="pT5 pR5 txtB_Black">작성자</th>
										<td>
											<input type="text" class="search_txt02 w400 userNamesAuto" name="searchWriterMixes" id="searchWriterMixes" value="${fm.searchWriterMixes}"/>
											<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchWriterMixes',0,1);" />
											<img src="${imagePath}/egovframework/cmm/fms/icon/bu5_close.gif" class="cursorPointer" onclick="javascript:cleanInput('searchWriterMixes');" />
										</td>
										
										<th class="pT5 pR5 txtB_Black" style="white-space:nowrap;">처리예정일</th>
										<td >
											<input type="text" name="searchDateFrom" id="searchSdate" class="w70 txt_center calGen" value="${fm.searchDateFrom}" autocomplete="off" onchange="toFrom(this)"/> ~
											<input type="text" name="searchDateTo" id="searchEdate" class="w70 txt_center calGen" value="${fm.searchDateTo}"autocomplete="off" onchange="fromTo(this)" />
										</td>
										<td>
											<img src="${imagePath}/egovframework/cmm/fms/icon/bu5_close.gif" class="cursorPointer pL5" onclick="javascript:cleanDate('searchSdate', 'searchEdate')" />		                   				
										</td>
									<tr>
									</tr>
										<th class="pT5 pR5 txtB_Black">담당자</th>
										<td>
											<input type="text" class="search_txt02 w400 userNamesAuto userValidateCheckAuth" name="searchManagerMixes" id="searchManagerMixes" value="${fm.searchManagerMixes}"/>
											<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchManagerMixes', 0, null, null, '1');" />
											<img src="${imagePath}/egovframework/cmm/fms/icon/bu5_close.gif" class="cursorPointer" onclick="javascript:cleanInput('searchManagerMixes');" />
										</td>
										
										<th class="pT5 pR5 txtB_Black" style="white-space:nowrap;">완료예정일</th>
										<td >
											<input type="text" name="searchDueDateFrom" id="searchSDuedate" class="w70 txt_center calGen" value="${fm.searchDueDateFrom}" autocomplete="off" onchange="toFrom(this)"/> ~
											<input type="text" name="searchDueDateTo" id="searchEDuedate" class="w70 txt_center calGen" value="${fm.searchDueDateTo}" autocomplete="off" onchange="fromTo(this)"/>
										</td>
										<td>
											<img src="${imagePath}/egovframework/cmm/fms/icon/bu5_close.gif" class="cursorPointer pL5" onclick="javascript:cleanDate('searchSDuedate', 'searchEDuedate')" />		                   				
										</td>
										<%-- <th class="pT5 pR5 txtB_Black">완료일</th>
										<td >
											<input type="text" name="searchFinishDateFrom" id="searchFinishDateFrom" class="w70 txt_center calGen" value="${fm.searchFinishDateFrom}"/> ~
											<input type="text" name="searchFinishDateTo" id="searchFinishDateTo" class="w70 txt_center calGen" value="${fm.searchFinishDateTo}"/>		                   				
										</td> --%>
									</tr>
									<tr>
										<th class="pT5 pR5 txtB_Black">요구사항명</th>
										<td colspan="3">
											<input type="text" class="w400"  name="searchTitle" id="searchTitle" value="${fm.searchTitle}"/>
											<img src="${imagePath}/egovframework/cmm/fms/icon/bu5_close.gif" class="cursorPointer" onclick="javascript:cleanInput('searchTitle');" />
										</td>
										<td class="txt_center" rowspan="2">
											<input type="button" value="검색" class=" btn_gray w85" onclick="javascript:search();"/>
										</td>
									</tr>
								</tbody>
								</table>
								</div>
							</fieldset>
						</form>
						</div>
						</br>
						<input type="button" value="등록" class="fr btn_gray" onclick="javascript:writeRequest();"/>
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
						<p class="th_stitle">요구사항 목록</p>
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
									<th scope="col">주 담당자</th>
									<th scope="col">처리예정</th>
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
										<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((fm.pageIndex-1) * fm.recordCountPerPage + c.count) + 1}"/></td>
										<td class="txt_left" <c:if test="${vo.dayCheck eq 2 || vo.dayCheck eq 3}">style="font-weight:bold;"</c:if>><a href="javascript:viewRequest('${vo.no}');">${vo.title}</a></td>
										<td class="txt_center">
											<print:user userNo="${vo.writerNo}" userNm="${vo.writerName}" userId="${vo.writerId}" printId="false"/>
										</td>
										<td class="txt_center">
											<div title="${vo.managerNameList}">${vo.managerMixesMain}	</div>										
										</td>
										<td class="calGen txt_center" <c:if test="${vo.dayCheck eq 1}">style="color : #FF5A5A "</c:if>>${vo.regDatetime}</td>
										<td class="txt_center" <c:if test="${vo.dueDayCheck eq 1}">style="color : #FF5A5A "</c:if>>${vo.dueDate}</td>
										<td class="txt_center"><a href="javascript:modifyRequest('${vo.no}');">${vo.statusStr}</a></td>
										</td>
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


					<!-- 페이징 시작 -->
					<div class="paginate">
						<ui:pagination paginationInfo="${paginationInfo}" jsFunction="search" type="image"/>
					</div>
					<!-- 페이징 끝 -->

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
