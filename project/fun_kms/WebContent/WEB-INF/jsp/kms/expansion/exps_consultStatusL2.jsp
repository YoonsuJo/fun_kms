<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/cheditor.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/utils/imageUtil.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="BusiContact" staticJavascript="false" xhtml="true" cdata="false"/>
</head>
<script type="text/javascript">
$(document).ready(function() {
	initSearchDt();
});

function tableHide(typ, val){
	if(document.getElementsByName(typ+val)[0].style.display == 'none'){
		$('tr[name='+typ+val+']').show();
	}else{
		$('tr[name='+typ+val+']').hide();
		if(typ == 'errType'){
			for(var i=1;i<8;i++)
			$('tr[name=detType'+i+']').hide();
		}
	}
}

function search(pageNo){
	//document.frm.searchRegDtS.value=document.frm.curRegDtS.value;
	//document.frm.searchRegDtE.value=document.frm.curRegDtE.value;
	document.frm.pageIndex.value = pageNo;
	document.frm.submit();
}
function statusList(statusNo){
	document.frm.status.value=statusNo;
	document.frm.submit();
}
//상담관리 목록 이동
function view(col1, value1, col2, value2, col3, value3) {

	// checkbox에 조건값 bind
	if (value1!="") {
		$('#chkCol1').val(value1);
		if (col1=="error") $('#chkCol1').attr('name', 'searchErrorTyp');
		else if (col1=="service") $('#chkCol1').attr('name', 'searchServiceTyp');
	}

	if (value2!="") {
		$('#chkCol2').val(value2);
		if (col2=="typ" && value2!="") $('#chkCol2').attr('name', 'searchTyp');
		else if (col2=="state") $('#chkCol2').attr('name', 'searchState');
	}
	
	if(value3!=""){
		$('#chkCol3').val(value3);
		if (col3=="detail" && value3!="") $('#chkCol3').attr('name', 'searchDetailTyp');
	}
	
	if($('#searchUserNm').val()!=""){
		if($('#searchUserNm').val().indexOf("(") != -1){
			$('#searchDamNm').val($('#searchUserNm').val().substring(0, $('#searchUserNm').val().indexOf("(")));
		}
	}

	// 조건이 하나일 경우, ibatis format(String[])에 맞게 fakeValue를 저장하기 위한 작업.
	var div = $('<div style="display:none;"></div>');
	if (value1!="") {
		if (col1=="error") div.append('<input type="checkbox" name="searchErrorTyp" value="fakeValue" checked="checked" />');
		else if (col1=="service") div.append('<input type="checkbox" name="searchServiceTyp" value="fakeValue" checked="checked" />');
		else if (col1=="detail") div.append('<input type="checkbox" name="searchDetailTyp" value="fakeValue" checked="checked" />');
	}
	if (value2!="") {
		if (col2=="typ" && value2!="") div.append('<input type="checkbox" name="searchTyp" value="fakeValue" checked="checked" />');
		else if (col2=="state") div.append('<input type="checkbox" name="searchState" value="fakeValue" checked="checked" />');
	}
	if (value3!="") {
		if (col3=="detail") div.append('<input type="checkbox" name="searchDetailTyp" value="fakeValue" checked="checked" />');
	}
	div.appendTo('#searchDiv');



	document.frm.action = "${rootPath}/cooperation/selectConsultManageList.do";
	document.frm.submit();
}

//열람
function viewState(consultNo) {
	var popup = window.open("/cooperation/selectConsultRecieveList.do?consult_no=" + consultNo,"_POP_STATE_","width=360px,height=415px,scrollbars=yes");
	popup.focus();
}

var searchRegDtS;
var searchRegDtE;
var today = new Date();
var weekCnt= 0;
var monthCnt= 0;

function initSearchDt() {
	var tmpDateS = '${searchVO.searchRegDtS}';
	var tmpDateE= '${searchVO.searchRegDtE}';
	
	searchRegDtS = new Date(tmpDateS.substring(0,4), tmpDateS.substring(4,6) - 1, tmpDateS.substring(6,8));
	searchRegDtE = new Date(tmpDateE.substring(0,4), tmpDateE.substring(4,6) - 1, tmpDateE.substring(6,8));
	
	//console.log(searchRegDtS);
	
	//document.getElementById('searchRegDtS').value = "" + searchRegDtS.format("yyyyMMdd");
	//document.getElementById('searchRegDtE').value = "" + searchRegDtE.format("yyyyMMdd");
}

//조회기간 변경(Option> before1Week, before1Month, thisWeek, thisMonth)
function setSearchDt(workType) {
	switch (workType) {
		case 'before1Week':
			if (weekCnt == 0) {
				searchRegDtS.setYear(searchRegDtE.getFullYear());
				searchRegDtS.setMonth(searchRegDtE.getMonth());
				searchRegDtS.setDate(searchRegDtE.getDate() - 7);
			} else {
				searchRegDtS.setDate(searchRegDtS.getDate() - 7);
			}
			weekCnt++;
			monthCnt = 0;
			break;
		case 'before1Month':
			if (monthCnt == 0) {
				searchRegDtS.setYear(searchRegDtE.getFullYear());
				searchRegDtS.setMonth(searchRegDtE.getMonth());
				searchRegDtS.setDate(searchRegDtE.getDate() - 30);
			} else {
				searchRegDtS.setDate(searchRegDtS.getDate() - 30);
			}
			weekCnt = 0;
			monthCnt++;
			break;
		case 'thisWeek':
			searchRegDtS = new Date();
			var dayOfWeek = searchRegDtS.getDay();
			searchRegDtS.setDate(searchRegDtS.getDate() - dayOfWeek + 1);
			searchRegDtE = new Date();
			searchRegDtE.setDate(searchRegDtE.getDate() - dayOfWeek + 5);
			
			weekCnt = 0;
			monthCnt = 0;
			break;
		case 'thisMonth':
			searchRegDtS = new Date();
			searchRegDtS.setDate(1);
			searchRegDtE = new Date();
			searchRegDtE.setMonth(searchRegDtE.getMonth() + 1);
			searchRegDtE.setDate(0);
			
			weekCnt = 0;
			monthCnt = 0;
			break;
	}
	document.getElementById('searchRegDtS').value = "" + searchRegDtS.format("yyyyMMdd");
	document.getElementById('searchRegDtE').value = "" + searchRegDtE.format("yyyyMMdd");
}

//조회기간 텍스트가 변경될 때, date 객체 변경
function chngSearchDt() {
	var tmpDate = document.getElementById('searchRegDtS').value;
	var year = tmpDate.substring(0,4);
	var month = tmpDate.substring(4,6) - 1;
	var day = tmpDate.substring(6,8);
	searchRegDtS = new Date(year, month, day);

	tmpDate = document.getElementById('searchRegDtE').value;
	year = tmpDate.substring(0,4);
	month = tmpDate.substring(4,6) - 1;
	day = tmpDate.substring(6,8);
	searchRegDtE = new Date(year, month, day);
}

//상담등록 화면 이동
function consultRegister() {
	document.frm.action = "${rootPath}/cooperation/writeConsultManage.do";
	document.frm.submit();
}

</script>
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
				<div id="center2">
					<div class="path_navi">
						<ul>
							<li class="stitle">통계</li>
							<li class="navi">홈 > 상담관리 > 통계</li>
						</ul>
					</div>
				<!-- S: section -->
				<div class="section01">
					<!-- 상단 검색창 시작 -->
						<form name="frm" method="POST" action="${rootPath}/cooperation/consultStatusList2.do" onsubmit="search(1); return false;">
						<input type="hidden" name="curRegDtS" />
						<input type="hidden" name="curRegDtE" />
						<input type="hidden" name="status" id="status" value="${searchVO.status }" />
						<input type="hidden" name="pageIndex" value="1"/>
						<input type="hidden" name="excel" value="N" />
						<input type="hidden" name="fromResultView" value="Y" />
						<input type="hidden" name="searchDamNm" id="searchDamNm"/>
						
						<div id="searchDiv" style="display:none;">
							<input type="checkbox" id="chkCol1" name="" value="" checked="checked"/>
							<input type="checkbox" id="chkCol2" name="" value="" checked="checked"/>
							<input type="checkbox" id="chkCol3" name="" value="" checked="checked"/>
						</div>
					<fieldset>
					<legend>상단 검색</legend>
						<div id="searchDiv" class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0">
								<caption>상단 검색</caption>
								<colgroup>
									<col class="col60" />
									<col class="col100"/><!-- <col width="35%" /> -->
									<col class="col300"/>
									<col class="col50" />
									<col class="col330"/><!-- <col width="35%" /> -->
									<col width="px" /><!-- <col class="col100" /> -->
								</colgroup>
								
								<tbody>
									<tr>
										<th class="fr pT5 pR5 txtB_Black">기간</th>
										<td class="pT5 pL5" colspan="2">
											<span class="option_txt"><input type="text" id="searchRegDtS" name="searchRegDtS" 
											value="<c:choose><c:when test="${searchVO.searchRegDtS==null }">${curRegDtS}</c:when><c:otherwise>${searchVO.searchRegDtS} </c:otherwise></c:choose>" 
											class="calGen" maxlength="8" style="width:55px;" onchange="javascript:chngSearchDt();" /></span>~
											<span class="option_txt"><input type="text" id="searchRegDtE" name="searchRegDtE" 
											value="<c:choose><c:when test="${searchVO.searchRegDtE==null }">${curRegDtE}</c:when><c:otherwise>${searchVO.searchRegDtE} </c:otherwise></c:choose>" 
											class="calGen" maxlength="8" style="width:55px;" onchange="javascript:chngSearchDt();" /></span>
											<span class="pL7"></span>
											<input type="button" value="1주일" class="btn_gray" onclick="javascript:setSearchDt('before1Week');"/>
											<input type="button" value="1달" class="btn_gray" onclick="javascript:setSearchDt('before1Month');"/>
											<input type="button" value="이번주" class="btn_gray" onclick="javascript:setSearchDt('thisWeek');"/>
											<input type="button" value="이번달" class="btn_gray" onclick="javascript:setSearchDt('thisMonth');"/>
										<th class="fr pT5 pR5 txtB_Black">처리자</th>
										<td class="pT5 pL5">
											<input type="text" class="span_90p input01 userNameAuto" name="searchUserNm" id="searchUserNm" value="${searchVO.searchUserNm}"/>
											<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchUserNm',1);">
										</td>
										<td><!-- 검색하기 버튼 -->
											<input type="image" src="/images/btn/btn_search02.gif" class="search_btn02 th_stitle_right cursorPointer" alt="검색" onclick="search(1); return false;"/>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</fieldset>
						</form>
							<!--// 상단 검색창 끝 -->
							
							<!-- 상담접수 버튼 -->	
							<div class="pop_btn_area">
								<a href="javascript:consultRegister();"><img src="${imagePath}/btn/btn_goConsul.gif"/></a>
							</div>

							<!-- 통계 테이블 -->
							<div class="boardList mB20">
							<p class="th_stitle" style="width:100%;text-align:left;">${searchVO.searchUserNm}</p>
							<br/>
							<table border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="${colWidth+4}%" />
							<c:forEach items="${typeList}" var="typ">
								<col width="${colWidth}%" />
							</c:forEach>
							<c:forEach items="${stateList}" var="stateType">
								<col width="${colWidth}%" />
							</c:forEach>
							<col width="${colWidth}%" />
						</colgroup>
						<thead>
							<tr>
								<th style="text-align:center;border:1px solid #666666;">구분</td>
								<c:forEach items="${typeList}" var="typ">
									<th style="text-align:center;border:1px solid #666666;">${typ.codeNm}</td>
								</c:forEach>
								<th style="text-align:center;border:1px solid #666666;background-color:#FDEADA;">소계</td>
								<c:forEach items="${stateList}" var="state">
									<th style="text-align:center;border:1px solid #666666;background-color:#EBF1DE;">${state.codeNm}</td>
								</c:forEach>
								<th style="text-align:center;border:1px solid #666666;background-color:#EBF1DE;">소요시간</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${serviceTypeList}" var="service" varStatus="c">
								<tr>
									<c:if test="${service.codeNm!='합계'}">
										<td <c:if test="${c.count == 1}">onclick="javascript:tableHide('errType', '');"</c:if> style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#DCE6F2;<c:if test="${c.count == 1}">cursor:pointer;</c:if>">
											${service.codeNm}
											<c:if test="${c.count == 1}">
												<img src="${imagePath}/btn/btn_arrow_next_on.gif">
											</c:if>
										</td>
									</c:if>
									<c:if test="${service.codeNm=='합계'}">
										<td <c:if test="${c.count == 1}">onclick="javascript:tableHide('errType', '');"</c:if> style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#FFFF00;<c:if test="${c.count == 1}">cursor:pointer;</c:if>">
											${service.codeNm}
											<c:if test="${c.count == 1}">
												<img src="${imagePath}/btn/btn_arrow_next_on.gif">
											</c:if>
										</td>
									</c:if>
									
									
									<c:set var="sum" value="0"/>
									<c:forEach items="${resultList3[c.count-1]}" var="result"  varStatus="status">
										<c:if test="${service.codeNm!='합계'}">
											<td style="text-align:center;border:1px solid #666666;background-color:#DCE6F2;">
											<c:if test="${result>0}">
												<a href="javascript:view('service', '${service.code}', 'typ', '${typeList[status.index].code}', '', '')">${result}</a>
											</c:if>
											</td>
										</c:if>
										<c:if test="${service.codeNm=='합계'}">
											<td style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#FFFF00;">
											<c:if test="${result>0}">
												<a href="javascript:view('service', '${service.code}', 'typ', '${typeList[status.index].code}', '', '')">${result}</a>
											</c:if>
											</td>
										</c:if>
										<c:set var="sum" value="${sum+result}"/>
									</c:forEach>
									
									<c:if test="${service.codeNm!='합계'}">
										<td style="text-align:center;border:1px solid #666666;background-color:#FDEADA;">
											<a href="javascript:view('service', '${service.code}', 'typ', '', '', '')"><b>${sum}</b></a>
										</td>
									</c:if>
									<c:if test="${service.codeNm=='합계'}">
										<td style="text-align:center;border:1px solid #666666;background-color:#FFFF00;">
											<a href="javascript:view('service', '${service.code}', 'typ', '', '', '')"><b>${sum}</b></a>
										</td>
									</c:if>
									
									
									<c:forEach items="${resultList4[c.count-1]}" var="result"  varStatus="status">
										<c:if test="${service.codeNm!='합계'}">
											<td style="text-align:center;border:1px solid #666666;background-color:#EBF1DE;">
											<c:if test="${result>0}">
												<a href="javascript:view('service', '${service.code}', 'state', '${stateList[status.index].code}', '', '')">${result}</a>
											</c:if>
											</td>
										</c:if>
										<c:if test="${service.codeNm=='합계'}">
											<td style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#FFFF00;">
											<c:if test="${result>0}">
												<a href="javascript:view('service', '${service.code}', 'state', '${stateList[status.index].code}', '', '')">${result}</a>
											</c:if>
											</td>
										</c:if>
											
										<c:set var="sum" value="${sum+result}"/>
									</c:forEach>
									<c:if test="${service.codeNm!='합계'}">
										<td style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#EBF1DE;">
											<c:forEach items="${compDurationService}" var="serDuration" varStatus="ser">
												<c:if test="${serDuration.serviceTyp == service.code}">
													${serDuration.compDuration} 분
												</c:if>
											</c:forEach>
										</td>
									</c:if>
									<c:if test="${service.codeNm=='합계'}">
										<td style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#FFFF00;">
											${compDurationTotal[0].compDuration} 분
										</td>
									</c:if>
								</tr>
								<c:if test="${c.count==1}">
									<c:forEach items="${errorTypeList}" var="error" varStatus="e">
										<tr name="errType" style="display:none;">
											<td name="errType" onclick="javascript:tableHide('detType', '${e.count}');" style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#D7D7D7;cursor:pointer;">
												${error.codeNm}
												<img src="${imagePath}/btn/btn_arrow_next_on.gif">
											</td>
											<c:set var="errSum" value="0"/>
											<c:forEach items="${resultList1[e.count-1]}" var="errResult1" varStatus="errStatus1">
												<td style="text-align:center;border:1px solid #666666;">
													<c:if test="${errResult1>0}">
														<a href="javascript:view('error', '${error.code}', 'typ', '${typeList[errStatus1.index].code}', '', '')">${errResult1}</a>
													</c:if>
												</td>
												<c:set var="errSum" value="${errSum+errResult1}"/>
											</c:forEach>
											<td style="text-align:center;border:1px solid #666666;background-color:#FDEADA;">
												<a href="javascript:view('error', '${error.code}', 'typ', '')"><b>${errSum}</b></a>
											</td>
											<c:forEach items="${resultList2[e.count-1]}" var="errResult2" varStatus="errStatus2">
												<td style="text-align:center;border:1px solid #666666;background-color:#EBF1DE;">
													<c:if test="${errResult2>0}">
														<a href="javascript:view('error', '${error.code}', 'state', '${stateList[errStatus2.index].code}', '', '')">${errResult2}</a>
													</c:if>
												</td>
											</c:forEach>
											<td style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#EBF1DE;">
												<c:forEach items="${compDurationError}" var="errDuration" varStatus="err">
													<c:if test="${errDuration.errorTyp == error.code}">
														${errDuration.compDuration} 분
													</c:if>
												</c:forEach>
											</td>
										</tr>
										<c:if test="${e.count==1}">
										<c:forEach items="${detailList}" var="detail" varStatus="d">
											<tr name="detType${e.count}" style="display:none;">
												<td style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#FDE6F6;">${detail.codeNm}</td>
												<c:set var="detSum" value="0"/>
												<c:forEach items="${resultList5[d.count-1]}" var="detResult1" varStatus="detStatus1">
												<td style="text-align:center;border:1px solid #666666;">
													<c:if test="${detResult1>0}">
														<a href="javascript:view('error', '${error.code}', 'typ', '${typeList[detStatus1.index].code}', 'detail', '${detail.code}')">${detResult1}</a>
													</c:if>
												</td>
												<c:set var="detSum" value="${detSum+detResult1}"/>
											</c:forEach>
											<td style="text-align:center;border:1px solid #666666;background-color:#FDEADA;">
												<a href="javascript:view('error', '${error.code}', 'typ', '', 'detail', '${detail.code}')"><b>${detSum}</b></a>
											</td>
											<c:forEach items="${resultList6[d.count-1]}" var="detResult2" varStatus="detStatus2">
												<td style="text-align:center;border:1px solid #666666;background-color:#EBF1DE;">
													<c:if test="${detResult2>0}">
														<a href="javascript:view('error', '${error.code}', 'state', '${stateList[detStatus2.index].code}', 'detail', '${detail.code}')">${detResult2}</a>
													</c:if>
												</td>
											</c:forEach>
											<td style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#EBF1DE;">
												<c:forEach items="${compDurationDetail}" var="detDuration" varStatus="det">
													<c:if test="${detDuration.errorTyp == error.code && detDuration.detailTyp == detail.code}">
														${detDuration.compDuration} 분
													</c:if>
												</c:forEach>
											</td>
											</tr>
										</c:forEach>
										</c:if>
										<c:if test="${e.count==2}">
										<c:forEach items="${detailList}" var="detail" varStatus="d">
											<tr name="detType${e.count}" style="display:none;">
												<td style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#FDE6F6;">${detail.codeNm}</td>
												<c:set var="detSum" value="0"/>
												<c:forEach items="${resultList7[d.count-1]}" var="detResult1" varStatus="detStatus1">
												<td style="text-align:center;border:1px solid #666666;">
													<c:if test="${detResult1>0}">
														<a href="javascript:view('error', '${error.code}', 'typ', '${typeList[detStatus1.index].code}', 'detail', '${detail.code}')">${detResult1}</a>
													</c:if>
												</td>
												<c:set var="detSum" value="${detSum+detResult1}"/>
											</c:forEach>
											<td style="text-align:center;border:1px solid #666666;background-color:#FDEADA;">
												<a href="javascript:view('error', '${error.code}', 'typ', '', 'detail', '${detail.code}')"><b>${detSum}</b></a>
											</td>
											<c:forEach items="${resultList8[d.count-1]}" var="detResult2" varStatus="detStatus2">
												<td style="text-align:center;border:1px solid #666666;background-color:#EBF1DE;">
													<c:if test="${detResult2>0}">
														<a href="javascript:view('error', '${error.code}', 'state', '${stateList[detStatus2.index].code}', 'detail', '${detail.code}')">${detResult2}</a>
													</c:if>
												</td>
											</c:forEach>
											<td style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#EBF1DE;">
												<c:forEach items="${compDurationDetail}" var="detDuration" varStatus="det">
													<c:if test="${detDuration.errorTyp == error.code && detDuration.detailTyp == detail.code}">
														${detDuration.compDuration} 분
													</c:if>
												</c:forEach>
											</td>
											</tr>
										</c:forEach>
										</c:if>
										<c:if test="${e.count==3}">
										<c:forEach items="${detailList}" var="detail" varStatus="d">
											<tr name="detType${e.count}" style="display:none;">
												<td style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#FDE6F6;">${detail.codeNm}</td>
												<c:set var="detSum" value="0"/>
												<c:forEach items="${resultList9[d.count-1]}" var="detResult1" varStatus="detStatus1">
												<td style="text-align:center;border:1px solid #666666;">
													<c:if test="${detResult1>0}">
														<a href="javascript:view('error', '${error.code}', 'typ', '${typeList[detStatus1.index].code}', 'detail', '${detail.code}')">${detResult1}</a>
													</c:if>
												</td>
												<c:set var="detSum" value="${detSum+detResult1}"/>
											</c:forEach>
											<td style="text-align:center;border:1px solid #666666;background-color:#FDEADA;">
												<a href="javascript:view('error', '${error.code}', 'typ', '', 'detail', '${detail.code}')"><b>${detSum}</b></a>
											</td>
											<c:forEach items="${resultList10[d.count-1]}" var="detResult2" varStatus="detStatus2">
												<td style="text-align:center;border:1px solid #666666;background-color:#EBF1DE;">
													<c:if test="${detResult2>0}">
														<a href="javascript:view('error', '${error.code}', 'state', '${stateList[detStatus2.index].code}', 'detail', '${detail.code}')">${detResult2}</a>
													</c:if>
												</td>
											</c:forEach>
											<td style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#EBF1DE;">
												<c:forEach items="${compDurationDetail}" var="detDuration" varStatus="det">
													<c:if test="${detDuration.errorTyp == error.code && detDuration.detailTyp == detail.code}">
														${detDuration.compDuration} 분
													</c:if>
												</c:forEach>
											</td>
											</tr>
										</c:forEach>
										</c:if>
										<c:if test="${e.count==4}">
										<c:forEach items="${detailList}" var="detail" varStatus="d">
											<tr name="detType${e.count}" style="display:none;">
												<td style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#FDE6F6;">${detail.codeNm}</td>
												<c:set var="detSum" value="0"/>
												<c:forEach items="${resultList11[d.count-1]}" var="detResult1" varStatus="detStatus1">
												<td style="text-align:center;border:1px solid #666666;">
													<c:if test="${detResult1>0}">
														<a href="javascript:view('error', '${error.code}', 'typ', '${typeList[detStatus1.index].code}', 'detail', '${detail.code}')">${detResult1}</a>
													</c:if>
												</td>
												<c:set var="detSum" value="${detSum+detResult1}"/>
											</c:forEach>
											<td style="text-align:center;border:1px solid #666666;background-color:#FDEADA;">
												<a href="javascript:view('error', '${error.code}', 'typ', '', 'detail', '${detail.code}')"><b>${detSum}</b></a>
											</td>
											<c:forEach items="${resultList12[d.count-1]}" var="detResult2" varStatus="detStatus2">
												<td style="text-align:center;border:1px solid #666666;background-color:#EBF1DE;">
													<c:if test="${detResult2>0}">
														<a href="javascript:view('error', '${error.code}', 'state', '${stateList[detStatus2.index].code}', 'detail', '${detail.code}')">${detResult2}</a>
													</c:if>
												</td>
											</c:forEach>
											<td style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#EBF1DE;">
												<c:forEach items="${compDurationDetail}" var="detDuration" varStatus="det">
													<c:if test="${detDuration.errorTyp == error.code && detDuration.detailTyp == detail.code}">
														${detDuration.compDuration} 분
													</c:if>
												</c:forEach>
											</td>
											</tr>
										</c:forEach>
										</c:if>
										<c:if test="${e.count==5}">
										<c:forEach items="${detailList}" var="detail" varStatus="d">
											<tr name="detType${e.count}" style="display:none;">
												<td style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#FDE6F6;">${detail.codeNm}</td>
												<c:set var="detSum" value="0"/>
												<c:forEach items="${resultList13[d.count-1]}" var="detResult1" varStatus="detStatus1">
												<td style="text-align:center;border:1px solid #666666;">
													<c:if test="${detResult1>0}">
														<a href="javascript:view('error', '${error.code}', 'typ', '${typeList[detStatus1.index].code}','detail', '${detail.code}')">${detResult1}</a>
													</c:if>
												</td>
												<c:set var="detSum" value="${detSum+detResult1}"/>
											</c:forEach>
											<td style="text-align:center;border:1px solid #666666;background-color:#FDEADA;">
												<a href="javascript:view('error', '${error.code}', 'typ', '', 'detail', '${detail.code}')"><b>${detSum}</b></a>
											</td>
											<c:forEach items="${resultList14[d.count-1]}" var="detResult2" varStatus="detStatus2">
												<td style="text-align:center;border:1px solid #666666;background-color:#EBF1DE;">
													<c:if test="${detResult2>0}">
														<a href="javascript:view('error', '${error.code}', 'state', '${stateList[detStatus2.index].code}', 'detail', '${detail.code}')">${detResult2}</a>
													</c:if>
												</td>
											</c:forEach>
											<td style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#EBF1DE;">
												<c:forEach items="${compDurationDetail}" var="detDuration" varStatus="det">
													<c:if test="${detDuration.errorTyp == error.code && detDuration.detailTyp == detail.code}">
														${detDuration.compDuration} 분
													</c:if>
												</c:forEach>
											</td>
											</tr>
										</c:forEach>
										</c:if>
										<c:if test="${e.count==6}">
										<c:forEach items="${detailList}" var="detail" varStatus="d">
											<tr name="detType${e.count}" style="display:none;">
												<td style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#FDE6F6;">${detail.codeNm}</td>
												<c:set var="detSum" value="0"/>
												<c:forEach items="${resultList15[d.count-1]}" var="detResult1" varStatus="detStatus1">
												<td style="text-align:center;border:1px solid #666666;">
													<c:if test="${detResult1>0}">
														<a href="javascript:view('error', '${error.code}', 'typ', '${typeList[detStatus1.index].code}', 'detail', '${detail.code}')">${detResult1}</a>
													</c:if>
												</td>
												<c:set var="detSum" value="${detSum+detResult1}"/>
											</c:forEach>
											<td style="text-align:center;border:1px solid #666666;background-color:#FDEADA;">
												<a href="javascript:view('error', '${error.code}', 'typ', '', 'detail', '${detail.code}')"><b>${detSum}</b></a>
											</td>
											<c:forEach items="${resultList16[d.count-1]}" var="detResult2" varStatus="detStatus2">
												<td style="text-align:center;border:1px solid #666666;background-color:#EBF1DE;">
													<c:if test="${detResult2>0}">
														<a href="javascript:view('error', '${error.code}', 'state', '${stateList[detStatus2.index].code}', 'detail', '${detail.code}')">${detResult2}</a>
													</c:if>
												</td>
											</c:forEach>
											<td style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#EBF1DE;">
												<c:forEach items="${compDurationDetail}" var="detDuration" varStatus="det">
													<c:if test="${detDuration.errorTyp == error.code && detDuration.detailTyp == detail.code}">
														${detDuration.compDuration} 분
													</c:if>
												</c:forEach>
											</td>
											</tr>
										</c:forEach>
										</c:if>
										<c:if test="${e.count==7}">
										<c:forEach items="${detailList}" var="detail" varStatus="d">
											<tr name="detType${e.count}" style="display:none;">
												<td style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#FDE6F6;">${detail.codeNm}</td>
												<c:set var="detSum" value="0"/>
												<c:forEach items="${resultList17[d.count-1]}" var="detResult1" varStatus="detStatus1">
												<td style="text-align:center;border:1px solid #666666;">
													<c:if test="${detResult1>0}">
														<a href="javascript:view('error', '${error.code}', 'typ', '${typeList[detStatus1.index].code}', 'detail', '${detail.code}')">${detResult1}</a>
													</c:if>
												</td>
												<c:set var="detSum" value="${detSum+detResult1}"/>
											</c:forEach>
											<td style="text-align:center;border:1px solid #666666;background-color:#FDEADA;">
												<a href="javascript:view('error', '${error.code}', 'typ', '', 'detail', '${detail.code}')"><b>${detSum}</b></a>
											</td>
											<c:forEach items="${resultList18[d.count-1]}" var="detResult2" varStatus="detStatus2">
												<td style="text-align:center;border:1px solid #666666;background-color:#EBF1DE;">
													<c:if test="${detResult2>0}">
														<a href="javascript:view('error', '${error.code}', 'state', '${stateList[detStatus2.index].code}', 'detail', '${detail.code}')">${detResult2}</a>
													</c:if>
												</td>
											</c:forEach>
											<td style="text-align:center;border:1px solid #666666;font-weight:bold;background-color:#EBF1DE;">
												<c:forEach items="${compDurationDetail}" var="detDuration" varStatus="det">
													<c:if test="${detDuration.errorTyp == error.code && detDuration.detailTyp == detail.code}">
														${detDuration.compDuration} 분
													</c:if>
												</c:forEach>
											</td>
											</tr>
										</c:forEach>
										</c:if>
										
									</c:forEach>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
					
					</div>
					<!-- //통계 테이블 -->
								
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
