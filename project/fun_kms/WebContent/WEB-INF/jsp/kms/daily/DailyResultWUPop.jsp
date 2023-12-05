<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>

<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="dayPlanRegist" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
var divIndex;
var divCount;

$(document).ready(function() {
	divIndex = parseInt($('#dailyResultVOListCnt').val()) + 1;
	divCount = divIndex;

	// 야근 시간 초기화
	var wsBgnTm = $('#wsBgnTm').val();
	var wsHrCnt = wsBgnTm - 18;
	if (wsHrCnt < 0) wsHrCnt += 24;
	$('#wsHrCnt').val(wsHrCnt);
/*
	if(($('#overTime').val() != null) && ($('#overTime').val() == "Y")){
		$('#registOvertime').show();
	}
	else {
		$('#registOvertime').hide();
	}
*/	

});

var chk = true;
var chkErrorChk = "";

function register() {
	if(!validcheck()) {
		return;
	}

	var form = $('#dailyResultFm');
	var dailyResultInputVO = $('#dailyResultFm').toObject({mode: 'first'})['dailyResultInputList'];
	form.find("input[name=jsonResultInputs]").val(escape(JSON.stringify(dailyResultInputVO)));
	
	document.dailyResultFm.action = '<c:url value="/daily/insertDailyResult.do" />';
	document.dailyResultFm.submit();
}

function validcheck() {

	for (var i = 0; i < divIndex; i++) {
		var strTmp = "#prjName_" + i;
		if($(strTmp).length > 0) {
			if( ($(strTmp).val() == null) || ($(strTmp).val() == "") )  {
				alert('업무실적관련 프로젝트를 선택해주세요.');
				$(strTmp).focus();
				return false;
			}
		}
	}
	for (var i = 0; i < divIndex; i++) {
		var strTmp = "#contents_" + i;
		if($(strTmp).length > 0) {
			if( ($(strTmp).val() == null) || ($(strTmp).val() == "") )  {
				alert('업무실적 내용을 입력해주세요.');
				$(strTmp).focus();
				return false;
			}
		}
	}
	return true;
}
function dailyCheck(val) {
	//prjId = $('#' + prjId);
	$(val).change(function(){
		var selectPrjNm = $(this).find(":selected").data("prjnm") 
		var selectPrjId = $(this).find(":selected").data("prjid");
		
		$(this).closest("table").find("tr:eq(1)").find("input:eq(0)").val(selectPrjNm);
		$(this).closest("table").find("tr:eq(1)").find("input:eq(1)").val(selectPrjId)
	});
}

function addDiv(){
	var html = "";
		html+= '</br><div id="dailyResultInputListDiv_' + divIndex + '">' 
		+ '<table cellpadding="0" cellspacing="0">'
		+ '<colgroup><col class="col100" /><col width="px" /><col class="col80" /><col class="col70" /></colgroup>'
		+ '<tbody id="tbody">'
		
		<c:if test="${(user.orgnztId == 'ORGAN_TOP_ORGAN_CODE') || (user.orgnztId == 'ORGAN_00000000000012') || (user.orgnztId == 'ORGAN_00000000000371') || (user.orgnztId == 'ORGAN_00000000000372')}">
		+ '<tr><td class="title">요구사항명	</td><td class="pA5" colspan="3">'
		+ '<select name="dailyResultInputList[' + divIndex + '].reqNo" id="reqNo_' + divIndex + '" class="select" style="width:100%" onclick="dailyCheck(this);">'
  		+ '<option value="">--선택하세요--</option>'
			<c:forEach items="${rtVOList}" var="rt" varStatus="c">
			html += '<option value ="${rt.no}" data-prjnm="${rt.prjNm}" data-prjid="${rt.prjId}"">${rt.prjNm} - ${fn:replace(rt.title, "'", "\\'")}</option>';
			</c:forEach>
			html += '</select></td></tr>'
		</c:if>
		+ '<tr><td class="title">프로젝트명</td><td class="pL5">'
		+ '<input type="text" class="w98p input01" id="prjName_' + divIndex + '" readonly="readonly" ' 
		+ ' onclick="prjGen(\'prjName_' + divIndex + '\', \'prjId_' + divIndex + '\', 1);" value=""/></td>'
		+ '<input type="hidden" name="dailyResultInputList[' + divIndex + '].prjId" id="prjId_' + divIndex + '"value="" />'
		+ '<td class="title">투입시간</td><td class="pL5">'
		+ '<input type="text" class="w20 input03" name="dailyResultInputList[' + divIndex + '].workHour" id="workHour_' + divIndex 
		+ '" value="1" onfocus="numGen(\'workHour_' + divIndex + '\', 0, 15, 4);"/> 시간</td></tr>'
		+ '<tr><td class="title">업무내역</br></br><a href="javascript:removeDiv(' + divIndex + ');">'
		+ '<img src="${imagePath}/editor/btn_delete.gif"/></a></td>'
		+ '<td class="pA5" colspan="3">'
		+ '<textarea class="w98p h200" name="dailyResultInputList[' + divIndex + '].contents" id="contents_' + divIndex + '"></textarea>' 
		+ '</td>	</tr></tbody></table></div>'
	var project = $(html);

//	var addBtn = $('#addResultBtn').clone();
//	$('#addResultBtn').remove();
	project.appendTo($('#dailyResultInputListTop'));
//	addBtn.appendTo($('#Results'));

	divIndex++;
	divCount++;
}

function removeDiv(index) {
	$('#dailyResultInputListDiv_' + index ).remove();
	divCount--;

}

function viewTask(no, taskId, taskTitle) {
	executeCopy("+ " + "[" + taskId + "] " + taskTitle);

	var s_width = screen.width;
	var s_height = screen.height;
	var left = -1000;
	var top = 100;
	
	var url = "/request/ReqTaskV.do?no=" + no;
	var title = "_REQUEST_TASK_WRITE_";
	var option = "width=700px, height=500px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	
	var popup = window.open(url, title, option);
	//	popup.moveTo( ( ( (s_width -500)/2* (-1)) ), ((s_height-570)/2));
	//	popup.moveTo(200, 200);
	popup.focus();

}

function executeCopy(text) {
	var input = document.createElement('textarea');
	document.body.appendChild(input);
	input.value = (text);
	input.focus();
	input.select();
	document.execCommand('Copy');
	input.remove();
}

</script>
</head>

<body>
<div id="#pop_regist06">
	<div id="pop_top">
		<c:set var = "year" value = "${fn:substring(writeDate, 0, 4)}" />
		<c:set var = "month" value = "${fn:substring(writeDate, 4, 6)}" />
		<c:set var = "date" value = "${fn:substring(writeDate, 6, 8)}" />
		<ul>
			<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
			<li class="popTitle">실적 등록  [${year}년 ${month}월 ${date}일]</li>
		</ul>
	</div>
	<div class="pop_con16">
	
		<form:form name="dailyResultFm" id="dailyResultFm" commandName="dailyResultFm" method="POST" >
		<div class="pop_board" id="dailyResultInputListTop">
			<input type="hidden" name="writerNo" value="${writerNo}"/>
			<input type="hidden" name="writeDate" value="${writeDate}"/>
			<input type="hidden" name="jsonResultInputs" id="jsonResultInputs" value=""/>
			<input type="hidden" id="dailyResultVOListCnt" value="${fn:length(dailyResultVOList)}" />
			<input type="hidden" id="overTime" value="${registTime}" />

			<%-- <c:if test="${(user.orgnztId == 'ORGAN_00000000000012') ||  
			(user.orgnztId == 'ORGAN_00000000000371') || (user.orgnztId == 'ORGAN_00000000000372')}">
			<c:if test="${(user.orgnztId == 'ORGAN_00000000000012') }">
				<c:if test="${fn:length(rtVOList) > 0}" >
				<p class="th_stitle">작업목록</p>
				<table cellpadding="0" cellspacing="0" >
					<colgroup>
						<col width="col80" />
						<col class="col400" />
						<col class="px" />
					</colgroup>
					<tbody>
					<c:forEach items="${rtVOList}" var="vo" varStatus="c">
						<tr>
							<td class="pL10 txt_left"><a href="javascript:viewTask('${vo.no}', '${vo.taskId}', '${vo.title}');">+ [${vo.taskId}] ${vo.title}</a></td>
							<td class="txt_center">${vo.writerName}</td>
							<td class="txt_center"> ${vo.regDatetime}</td>
							<td class="txt_center">${vo.priorityStr}</td>
							<td class="pL10 txt_left">${vo.prjNm }</td>
							<td class="txt_center"><a href="javascript:dailyCheck('${vo.prjId}', '${vo.prjNm}', '${vo.reviewContents}');">${vo.title}</a></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				<br/>
				</c:if>
			</c:if> --%>

			<p class="th_plus04">${goodBye} </p>
			<p class="th_plus03 textarea1">글머리기호 ( <a href="javascript:executeCopy('# ');">#</a> <a href="javascript:executeCopy('+ ');">+</a> <a href="javascript:executeCopy('- ');">-</a> <a href="javascript:executeCopy('• ');">•</a> <a href="javascript:executeCopy('* ');">*</a> <a href="javascript:executeCopy('※ ');">※</a> ) </p>
			<c:if test="${empty dailyResultVOList}">
			<div id="dailyResultInputListDiv_0">
				<table cellpadding="0" cellspacing="0">
					<colgroup>
						<col class="col100" />
						<col width="px" />
						<col class="col80" />
						<col class="col70" />
					</colgroup>
					<tbody id="tbody">
						<c:if test="${(user.orgnztId == 'ORGAN_TOP_ORGAN_CODE') || (user.orgnztId == 'ORGAN_00000000000012') || (user.orgnztId == 'ORGAN_00000000000371') || (user.orgnztId == 'ORGAN_00000000000372')}">
						<tr>
							<td class="title">요구사항명
							</td>
							<td class="pA5" colspan="3">
							<select name="dailyResultInputList[0].reqNo" id="reqNo_0" class="select" style="width:100%" onclick="dailyCheck(this);">
					  		   <option value="">--선택하세요--</option>
					  		   <c:forEach items="${rtVOList}" var="rt" varStatus="c">
									<option value ="${rt.no}" data-prjnm='${rt.prjNm}' data-prjid='${rt.prjId}'>${rt.prjNm} - ${rt.title }</option>
					  		   
					  		   </c:forEach>
					  	   </select>
							</td>
						</tr>
						</c:if>
						<tr>
							<td class="title">프로젝트명</td>
							<td class="pL5"><input type="text" class="w98p input01" id="prjName_0" 
									readonly="readonly" onclick="prjGen('prjName_0', 'prjId_0', 1);" value=""/></td>
							<input type="hidden" name="dailyResultInputList[0].prjId" id="prjId_0" value="" />
							<td class="title">투입시간</td>
							<td class="pL5"><input type="text" class="w20 input03" name="dailyResultInputList[0].workHour" id="workHour_0" value="1" 
									onfocus="numGen('workHour_0', 0, 15, 4);"/> 시간
							</td>
						</tr>
						<tr>
							<td class="title">업무내역</br></br><a href="javascript:removeDiv(0);"><img src="${imagePath}/editor/btn_delete.gif"/></a>
							</td>
							<td class="pA5" colspan="3"><textarea class="w98p h200" name="dailyResultInputList[0].contents" id="contents_0" value=""></textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			</c:if>
			
			<c:forEach items="${dailyResultVOList}" var="vo" varStatus="s">
			</br><div id="dailyResultInputListDiv_${s.index}">
				<table cellpadding="0" cellspacing="0">
					<colgroup>
						<col class="col100" />
						<col width="px" />
						<col class="col80" />
						<col class="col70" />
					</colgroup>
					<tbody id="tbody">
						<c:if test="${(user.orgnztId == 'ORGAN_TOP_ORGAN_CODE') || (user.orgnztId == 'ORGAN_00000000000012') || (user.orgnztId == 'ORGAN_00000000000371') || (user.orgnztId == 'ORGAN_00000000000372')}">
						<tr>
							<td class="title">요구사항명
							</td>
							<td class="pA5" colspan="3">
							<select name="dailyResultInputList[${s.index}].reqNo" id="reqNo_${s.index}" class="select" style="width:100%" onclick="dailyCheck(this);">
					  		   <option value="" <c:if test="${rt.reqNo == vo.reqNo}">selected="selected"</c:if>>--선택하세요--</option>
					  		   <c:forEach items="${rtVOList}" var="rt" varStatus="c">
									<option value ="${rt.no}" data-prjnm='${rt.prjNm}' data-prjid='${rt.prjId}' <c:if test="${rt.no == vo.reqNo}">selected="selected"</c:if>>${rt.prjNm} - ${rt.title }</option>
					  		   
					  		   </c:forEach>
					  	   </select>
							</td>
						</tr>
						</c:if>
						<tr>
							<td class="title">프로젝트명</td>
							<td class="pL5"><input type="text" class="w98p input01" id="prjName_${s.index}" 
									readonly="readonly" onclick="prjGen('prjName_${s.index}','prjId_${s.index}', 1);" value="${vo.prjName}"/></td>
							<input type="hidden" name="dailyResultInputList[${s.index}].prjId" id="prjId_${s.index}" value="${vo.prjId}" />
							<td class="title">투입시간</td>
							<td class="pL5"><input type="text" class="w20 input03" name="dailyResultInputList[${s.index}].workHour" id="workHour_${s.index}" value="${vo.workHour}"
									onfocus="numGen('workHour_${s.index}', 0, 15, 4);"/> 시간
							</td>
						</tr>
						<tr>
							<td class="title">업무내역</br></br><a href="javascript:removeDiv(${s.index});"><img src="${imagePath}/editor/btn_delete.gif"/></a>
							</td>
							<td class="pA5" colspan="3"><textarea class="w98p h200" name="dailyResultInputList[${s.index}].contents"  id="contents_${s.index}" >${vo.contents }</textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			</c:forEach>
		</div>	<!--  id dailyResultInputListTop  -->

		<div class="btn_area02 mB10" id="btn_area" >
			<input type="image" src="${imagePath}/editor/btn_cancel.gif" class="fr" onclick="javascript:window.close();"/>
			<input type="image" src="${imagePath}/editor/btn_regist.gif" class="fr" onclick="javascript:register(); return false;"/>
			<p class="th_plus04"><a href="javascript:addDiv();"><img src="${imagePath}/editor/btn_add.gif"/></a>
		</div>

		<div class="pop_board" id="registOvertime" style="display:none;">
			<table cellpadding="0" cellspacing="0">
				<colgroup>
					<col class="col100" />
					<col width="px" />
					<col class="col80" />
					<col class="col70" />
				</colgroup>
				<tbody id="tbody">
				<tr>
					<td class="title">야근등록 <input type="checkbox"  name="overWork" id="overWork" check="checked" value="Y"/></td>
					<td class="pL10" ><input type="text" class="input03 w20" name="toTime" id="toTime" /> 시 </td>
				</tr>
				</tbody>
			</table>
		<div>
		</form:form>
		
	</div>
</div>

</body>
</html>
