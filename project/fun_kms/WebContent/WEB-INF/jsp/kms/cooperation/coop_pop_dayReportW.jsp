<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="print" uri="print" %>

<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="dayReportRegist" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
var chk = false;
var chkErrorChk = "";

function register(type) {

	document.frm.type.value = type;
	
	if(chkErrorChk != "") {
		alert("해당 프로젝트 투입 검사 예외 : result = " + chkErrorChk);
		return;
	}	
	if (chk == false) {
		alert("해당 프로젝트에 투입되지 않았습니다.");
		return;
	}	
	var cnt = document.frm.cnt.value;
	if (cnt == 0) {
		alert("등록할 진행내역이 없습니다.");
		return;
	}
	else if (cnt == 1) {
		if (!validateDayReportRegist(document.frm)) {
			return;
		}
		if (document.frm.dayReportTm.value > 24) {
			alert("시간은 24보다 작거나 같은 값만 입력할 수 있습니다.");
			return;
		}
	} else {
		for (var i=0; i<cnt; i++) {
			document.tmpFrm.dayReportTm.value = document.frm.dayReportTm[i].value;
			document.tmpFrm.dayReportDt.value = document.frm.dayReportDt[i].value;
			document.tmpFrm.dayReportCn.value = document.frm.dayReportCn[i].value;

			if (!validateDayReportRegist(document.tmpFrm)) {
				return;
			}
			if (isNaN(document.tmpFrm.dayReportTm.value)) {
				alert("시간에는 숫자를 입력해야합니다.");
				return;
			}
			if (document.tmpFrm.dayReportTm.value > 24) {
				alert("시간은 24보다 작거나 같은 값만 입력할 수 있습니다.");
				return;
			}
		}
	}


	if($("#overTimeCheck").prop("checked")){
		document.frm.wsTyp.value = 'N';
	}else{
		document.frm.wsTyp.value = '';
	}
	
	document.frm.submit();					
}
function addWork() {
	var cnt = document.frm.cnt.value;
	if (cnt >= 5) {
		alert('실적은 한번에 최대 5개까지만 등록할 수 있습니다.');
		return false;
	}
	
	var tbody = document.getElementById("tbody");
	var tr1 = document.createElement("tr");
	var tr2 = document.createElement("tr");
	var td1 = document.createElement("td");
	var td2 = document.createElement("td");
	var td3 = document.createElement("td");
	var td4 = document.createElement("td");
	var td5 = document.createElement("td");
	var td6 = document.createElement("td");
	var td7 = document.createElement("td");

	td1.className = "title";
	td1.innerHTML = "날짜";
	tr1.appendChild(td1);

	td2.className = "pL10";
	td2.innerHTML = "<input type=\"text\" class=\"span_5 calGen\" name=\"dayReportDt\" value=\"${searchVO.searchDate}\" onchange=\"projectInputAble();\" />";
	tr1.appendChild(td2);

	td3.className = "title";
	td3.innerHTML = "시간";
	tr1.appendChild(td3);

	td4.className = "pL10";
	td4.innerHTML = "<input type=\"text\" class=\"span_3\" name=\"dayReportTm\" id=\"dayReportTm\" onfocus=\"numGen(this,1,24,5);\" />시간";
	tr1.appendChild(td4);
	
	td5.className = "Lline pL10";
	td5.rowSpan = "2";
	td5.innerHTML = "<img src=\"${imagePath}/btn/btn_delete03.gif\" style=\"cursor:pointer;\" onclick=\"delWork(this.parentNode.parentNode)\" />";
	tr1.appendChild(td5);

	tbody.appendChild(tr1);

	td6.className = "title";
	td6.innerHTML = "진행내역";
	tr2.appendChild(td6);
	
	td7.className = "pL10 pT5 pB5";
	td7.colSpan = "3";
	td7.innerHTML = "<textarea name=\"dayReportCn\" class=\"span_28 height_70\"></textarea>";
	tr2.appendChild(td7);
	
	tbody.appendChild(tr2);

	$(document.frm.dayReportDt[document.frm.cnt.value]).datepicker();
	
	document.frm.cnt.value = new Number(document.frm.cnt.value) + 1;
	
	projectInputAble();
}
function delWork(obj) {
	var nextTr = $(obj).next();
	$(obj).remove();
	nextTr.remove();
	document.frm.cnt.value = new Number(document.frm.cnt.value) - 1;
	projectInputAble();
}
function projectInputAble() {
	var act = new yAjax("${rootPath}/ajax/projectInputAble.do", "POST");
	act.send = $("#frm").serialize();
	act.statechange = function(){
		var xml = act.getResXmlObject();
		var result = xml.getValue("result",0);
		if (result == "Y")
			chk = true;
		else if (result == "N")
			chk = false;
		else
			chkErrorChk = result;
	};
	act.action();
}
$(document).ready(new Function("projectInputAble()"));
$(document).ready(function() {
	// 야근 시간 초기화
	var wsBgnTm = $('#wsBgnTm').val();
	var wsHrCnt = wsBgnTm - 18;
	if (wsHrCnt < 0) wsHrCnt += 24;
	$('#wsHrCnt').val(wsHrCnt);
});

//야근등록
function calcWsHrCnt(obj) {
	var year = new Date().getFullYear();
	var month = new Date().getMonth();	
	month++;
	var date = new Date().getDate();	
	if ((month + "").length == 1)
		month = "0" + month;	
	if ((date + "").length == 1)
		date = "0" + date;	
	var hour = new Date().getHours();
	var min = new Date().getMinutes();
	var sec = new Date().getSeconds();
	var today = year + "" + month + "" + date;
	var now = hour + ":" + min + ":" + sec ;		
	var wsBgnDe = $('#wsBgnDe').val();
	
	var wsBgnTm = obj.value;	
	var stoday = '현재시간: ' + year + '년 ' + month + '월 ' + date + '일 ' + hour + "시 " + min + "분 " + sec + "초";;
	var msg = '당일 등록시간 ~ 6시 이전에만 등록가능합니다\n6시 입력가능시간은 5:00:00~5:59:59\n' + stoday;
	wsBgnDe += ''; //String casting
	wsBgnDe *= 1; //int casting	
	 
	//AbsenceController.java 부분 활용
	if(today == wsBgnDe){
		if(hour > 21 && hour >= wsBgnTm){
		} else {
			alert(msg);
		}				
	} // 익일 등록
	else if(today == wsBgnDe + 1 || date == 1){
		if((hour < 6 && wsBgnTm > 21) || //22, 23, 24시
		   (hour < 6 && hour >= wsBgnTm) || //1, 2, 3, 4, 5시
		   (hour == 5 && wsBgnTm == 6)){ // 6시 야근등록은 5시~5:59:59까지 등록		
		} else {
			alert(msg);											
		}
	}	
	
	var wsHrCnt = obj.value - 18;
	if (wsHrCnt < 0) wsHrCnt += 24;

	$('#wsHrCnt').val(wsHrCnt);
	$('#wsBgnTm').val(obj.value);
}


</script>
</head>

<body>
<div id="pop_regist02">
	<div id="pop_top">
	<ul>
		<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
		<li class="popTitle">작업 진행내역 등록</li>
	</ul>
	</div>
	<div class="pop_con08">
	
		<div class="pop_board mB20">
			<p class="th_stitle">작업 개요</p>
			<table cellpadding="0" cellspacing="0">
				<colgroup>
					<col class="col90" />
					<col class="col170" />
					<col class="col90" />
					<col width="px" />
				</colgroup>
				<tbody>
					<tr>
						<td class="title">프로젝트</td>
						<td class="pL10" colspan="3"><span class="txtB_grey">[${result.prjCd}]</span>${result.prjNm}</td>
					</tr>
					<tr>
						<td class="title">작업명</td>
						<td class="pL10" colspan="3">${result.taskSjPrint}</td>
					</tr>
					<tr>
						<td class="title">담당자</td>
						<td class="pL10"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
						<td class="title">완료예정일</td>
						<td class="pL10">${result.taskDuedatePrint}</td>
					</tr>
					<tr>
						<td class="title">등록자</td>
						<td class="pL10"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
						<td class="title">진행상태</td>
						<td class="pL10"><span class="txt_blue">${result.taskStatePrint}</span></td>
					</tr>
					<tr>
						<td class="title">내용</td>
						<td class="pL10 pT5 pB5" colspan="3">${result.taskCnPrint}</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<c:set var="wsOverDate" value="${fn:replace(thisTime,'.','')}"/>
		<c:set var="wsOverDate" value="${fn:substring(wsOverDate,0,8)}"/>
		<c:set var="thisTime" value="${fn:substring(thisTime,11,13)}"/>	
		<c:if test="${thisTime == '00' || thisTime == '01' || thisTime == '02' ||thisTime == '03' ||thisTime == '04' ||thisTime == '05' || thisTime == '06'}">
			<c:set var="wsOverDate" value="${yesterday}"/>
		</c:if>
		
		<div class="pop_board">
			<p class="th_stitle">진행내역</p>
			<form:form name="frm" id="frm" commandName="dayReportRegist" method="POST" action="${rootPath}/cooperation/insertDayReport.do" enctype="multipart/form-data">
			<input type="hidden" name="prjId" value="${result.prjId}"/>
			<input type="hidden" name="taskId" value="${result.taskId}"/>
			<input type="hidden" name="userNo" value="${result.userNo}"/>
			<input type="hidden" name="cnt" value="1"/>
			<input type="hidden" name="type"/>

			<input type="hidden" name="wsTyp" value=""/>			

			<input type="hidden" name="wsBgnTm"  id="wsBgnTm" value="${thisTime}"/> 
			<input type="hidden" name="wsBgnDe" id="wsBgnDe"  value="${wsOverDate}" />
			<input type="hidden" name="wsHrCnt" id="wsHrCnt" value="" />
			<input type="hidden" name="prjNm" value="[${result.prjCd}]${result.prjNm}"/>
			<input type="hidden" name="taskNm" value="${result.taskSjPrint}"/>
			
			<c:if test="${!empty headList}">
				<table cellpadding="0" cellspacing="0">
					<colgroup>
						<col class="col90" />
						<col width="px" />
						<col class="col90" />
						<col width="px" />
						<col class="col90" />
					</colgroup>
					<tbody id="tbody">
						<tr>
							<td class="title">푸쉬 보고 대상</td>
							<td class="pL10" colspan="3">
								<c:forEach items="${headList}" var="head" varStatus="status">
									<label>
										<input type="checkbox" name="headMoblphonNo" value="${head.moblphonNo}" 
											<c:if test="${status.index==0}">checked="checked"</c:if> /><span class="pR10">${head.userNm}</span>
									</label>
								</c:forEach>
							</td>
						</tr>
				</table>
			</c:if>
			
			<table cellpadding="0" cellspacing="0">
				<colgroup>
					<col class="col90" />
					<col width="px" />
					<col class="col90" />
					<col width="px" />
					<col class="col90" />
				</colgroup>
				<tbody id="tbody">
					<tr>
						<td class="title">날짜</td>
						<td class="pL10">						
						<c:choose>
							<c:when test="${searchVO.searchDate == ''}">												
							<input type="text" class="span_5 calGen" name="dayReportDt" value="${today}" onchange="projectInputAble();" />
							</c:when>										
							<c:otherwise>
							<input type="text" class="span_5 calGen" name="dayReportDt" value="${searchVO.searchDate}" onchange="projectInputAble();" />										
							</c:otherwise>
							</c:choose>
						</td>
						<td class="title">시간</td>
						<td class="pL10"><input type="text" class="span_3" name="dayReportTm" id="dayReportTm" onfocus="numGen(this,0,24,5);"/>시간</td>
						<td class="Lline pL10" rowspan="3"><img src="${imagePath}/btn/btn_delete03.gif" style="cursor:pointer;" onclick="delWork(this.parentNode.parentNode)"/></td>
					</tr>
					<tr>
						<td class="title">진행내역</td>
						<td class="pL10 pT5 pB5" colspan="3">
							<textarea name="dayReportCn" class="span_28 height_70"></textarea>
						</td>
					</tr>
					<tr>
						<td class="title">첨부파일</td>
                    	<td class="pL10 pT5 pB5" colspan="3">
							<input name="file_1" id="egovComFileUploader" type="file"/>
							<div id="egovComFileList"></div>
							<script type="text/javascript">
								var maxFileNum = 3;
								var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum , '');
								multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
							</script>
							<span>※ 첨부파일의 최대 용량은 70MB입니다.</span>
						</td>
					</tr>
				</tbody>
			</table>
			</form:form>
			<p class="txt_center mT10"><img src="${imagePath}/btn/btn_add03.gif" style="cursor:pointer" onclick="addWork();"/></p>
		</div>	
		<!-- 야근등록  -->
			<c:choose>
				<c:when test="${user.isInnerNetworkPrint == '본사' && (thisTime == '22' || thisTime == '23' || thisTime == '00' || thisTime == '01' ||thisTime == '02' || thisTime == '03' || thisTime == '04' || thisTime == '05' || thisTime == '06')}">
					<div class="pop_board mB20" style="display: block">
				</c:when>
				<c:otherwise>
					<div class="pop_board mB20" style="display: none">		
				</c:otherwise>
			</c:choose>
			<p class="th_stitle">연장근무 등록</p>
			<table cellpadding="0" cellspacing="0">
				<colgroup>
					<col class="col90" />
					<col width="124px" />
					<col class="col90" />
					<col width="px" />
				</colgroup>
				<tr>
					<td class="title">근무종료시각</td>
					<td class="pL10">
                        <select name="wsOverTm" id="wsOverTm" onchange="javascript:calcWsHrCnt(this);">
                            <c:choose>
	                            <c:when test="${thisTime == '22'}">
	                            	<option value="22" selected="selected">22시</option>
	                            </c:when>
                                <c:when test="${thisTime == '23'}">
                                <option value="22" <c:if test="${thisTime == '22'}">selected="selected"</c:if>>22시</option>
                                <option value="23" <c:if test="${thisTime == '23'}">selected="selected"</c:if>>23시</option>
                                </c:when>
                                <c:when test="${thisTime == '00'}">
                                <option value="22" <c:if test="${thisTime == '22'}">selected="selected"</c:if>>22시</option>
                                <option value="23" <c:if test="${thisTime == '23'}">selected="selected"</c:if>>23시</option>
                                <option value="24" <c:if test="${thisTime == '00'}">selected="selected"</c:if>>24시</option>
                                </c:when>
                                <c:when test="${thisTime == '01'}">
                                <option value="22" <c:if test="${thisTime == '22'}">selected="selected"</c:if>>22시</option>
                                <option value="23" <c:if test="${thisTime == '23'}">selected="selected"</c:if>>23시</option>
                                <option value="24" <c:if test="${thisTime == '00'}">selected="selected"</c:if>>24시</option>
                                <option value="01" <c:if test="${thisTime == '01'}">selected="selected"</c:if>>01시</option>
                                </c:when>
                                <c:when test="${thisTime == '02'}">
                                <option value="22" <c:if test="${thisTime == '22'}">selected="selected"</c:if>>22시</option>
                                <option value="23" <c:if test="${thisTime == '23'}">selected="selected"</c:if>>23시</option>
                                <option value="24" <c:if test="${thisTime == '00'}">selected="selected"</c:if>>24시</option>
                                <option value="01" <c:if test="${thisTime == '01'}">selected="selected"</c:if>>01시</option>
                                <option value="02" <c:if test="${thisTime == '02'}">selected="selected"</c:if>>02시</option>
                                </c:when>
                                <c:when test="${thisTime == '03'}">
                                <option value="22" <c:if test="${thisTime == '22'}">selected="selected"</c:if>>22시</option>
                                <option value="23" <c:if test="${thisTime == '23'}">selected="selected"</c:if>>23시</option>
                                <option value="24" <c:if test="${thisTime == '00'}">selected="selected"</c:if>>24시</option>
                                <option value="01" <c:if test="${thisTime == '01'}">selected="selected"</c:if>>01시</option>
                                <option value="02" <c:if test="${thisTime == '02'}">selected="selected"</c:if>>02시</option>
                                <option value="03" <c:if test="${thisTime == '03'}">selected="selected"</c:if>>03시</option>
                                </c:when>
                                <c:when test="${thisTime == '04'}">
                                <option value="22" <c:if test="${thisTime == '22'}">selected="selected"</c:if>>22시</option>
                                <option value="23" <c:if test="${thisTime == '23'}">selected="selected"</c:if>>23시</option>
                                <option value="24" <c:if test="${thisTime == '00'}">selected="selected"</c:if>>24시</option>
                                <option value="01" <c:if test="${thisTime == '01'}">selected="selected"</c:if>>01시</option>
                                <option value="02" <c:if test="${thisTime == '02'}">selected="selected"</c:if>>02시</option>
                                <option value="03" <c:if test="${thisTime == '03'}">selected="selected"</c:if>>03시</option>
                                <option value="04" <c:if test="${thisTime == '04'}">selected="selected"</c:if>>04시</option>
                                </c:when>
                                <c:when test="${thisTime == '05'}">
                                <option value="22" <c:if test="${thisTime == '22'}">selected="selected"</c:if>>22시</option>
                                <option value="23" <c:if test="${thisTime == '23'}">selected="selected"</c:if>>23시</option>
                                <option value="24" <c:if test="${thisTime == '00'}">selected="selected"</c:if>>24시</option>
                                <option value="01" <c:if test="${thisTime == '01'}">selected="selected"</c:if>>01시</option>
                                <option value="02" <c:if test="${thisTime == '02'}">selected="selected"</c:if>>02시</option>
                                <option value="03" <c:if test="${thisTime == '03'}">selected="selected"</c:if>>03시</option>
                                <option value="04" <c:if test="${thisTime == '04'}">selected="selected"</c:if>>04시</option>
                                <option value="05" <c:if test="${thisTime == '05'}">selected="selected"</c:if>>05시</option>
                                </c:when>
                                <c:when test="${thisTime == '06'}">
                                <option value="22" <c:if test="${thisTime == '22'}">selected="selected"</c:if>>22시</option>
                                <option value="23" <c:if test="${thisTime == '23'}">selected="selected"</c:if>>23시</option>
                                <option value="24" <c:if test="${thisTime == '00'}">selected="selected"</c:if>>24시</option>
                                <option value="01" <c:if test="${thisTime == '01'}">selected="selected"</c:if>>01시</option>
                                <option value="02" <c:if test="${thisTime == '02'}">selected="selected"</c:if>>02시</option>
                                <option value="03" <c:if test="${thisTime == '03'}">selected="selected"</c:if>>03시</option>
                                <option value="04" <c:if test="${thisTime == '04'}">selected="selected"</c:if>>04시</option>
                                <option value="05" <c:if test="${thisTime == '05'}">selected="selected"</c:if>>05시</option>
                                <option value="06" <c:if test="${thisTime == '06'}">selected="selected"</c:if>>06시</option>
                                </c:when>
                                <c:otherwise>
                                <option value="22" <c:if test="${thisTime == '22'}">selected="selected"</c:if>>22시</option>
                                <option value="23" <c:if test="${thisTime == '23'}">selected="selected"</c:if>>23시</option>
                                <option value="24" <c:if test="${thisTime == '00'}">selected="selected"</c:if>>24시</option>
                                <option value="01" <c:if test="${thisTime == '01'}">selected="selected"</c:if>>01시</option>
                                <option value="02" <c:if test="${thisTime == '02'}">selected="selected"</c:if>>02시</option>
                                <option value="03" <c:if test="${thisTime == '03'}">selected="selected"</c:if>>03시</option>
                                <option value="04" <c:if test="${thisTime == '04'}">selected="selected"</c:if>>04시</option>
                                <option value="05" <c:if test="${thisTime == '05'}">selected="selected"</c:if>>05시</option>
                                <option value="06" <c:if test="${thisTime == '06'}">selected="selected"</c:if>>06시</option>
                                </c:otherwise>
                            </c:choose>
                        </select>
						</td>
						<td class="title">등록</td>
						<td class="pL10"><input type="checkbox" name="overTimeCheck"  id="overTimeCheck" <c:if test="${user.isInnerNetworkPrint == '본사' && (thisTime == '22' || thisTime == '23' || thisTime == '00' || thisTime == '01' ||thisTime == '02' || thisTime == '03' || thisTime == '04' || thisTime == '05' || thisTime == '06')}">checked="checked"</c:if>></td>						
					</tr>
			 </table>
		</div>
		
		
		<div class="pop_btn_area04">
			<a href="javascript:register('');"><img src="${imagePath}/btn/btn_task_continue.gif"/></a>
			<a href="javascript:register('end');"><img src="${imagePath}/btn/btn_complete.gif"/></a>
			<a href="javascript:window.close();"><img src="${imagePath}/btn/btn_reg_cancel.gif"/></a>
		</div>
		<form:form name="tmpFrm" commandName="dayReportRegist">
			<input type="hidden" name="dayReportDt"/>
			<input type="hidden" name="dayReportTm"/>
			<input type="hidden" name="dayReportCn"/>
		</form:form>
	</div>
</div>

</body>
</html>
