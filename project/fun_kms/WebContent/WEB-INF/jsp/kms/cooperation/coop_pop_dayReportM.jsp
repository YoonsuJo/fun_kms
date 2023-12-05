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
<validator:javascript formName="dayReportRegist" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function update() {
	if (chk == false) {
		alert("해당 프로젝트에 투입되지 않았습니다.");
		return;
	}
	if (!validateDayReportRegist(document.frm)) {
		return;
	}
	if (document.frm.dayReportTm.value > 24) {
		alert("시간은 24보다 작거나 같은 값만 입력할 수 있습니다.");
		return;
	}
	document.frm.submit();					
}

var chk = true;
function projectInputAble() {
	var act = new yAjax("${rootPath}/ajax/projectInputAble.do", "POST");
	act.send = $("#frm").serialize();
	act.statechange = function(){
		var xml = act.getResXmlObject();
		var result = xml.getValue("result",0);
		if (result == "Y")
			chk = true;
		else
			chk = false;
	};
	act.action();
}

function fn_egov_check_file(flag) {
	if (flag=="Y") {
		document.getElementById('file_upload_posbl').style.display = "";
		document.getElementById('file_upload_imposbl').style.display = "none";			
	} else {
		document.getElementById('file_upload_posbl').style.display = "none";
		document.getElementById('file_upload_imposbl').style.display = "";
	}
}
</script>
</head>

<body>
<div id="pop_regist02">
	<div id="pop_top">
	<ul>
		<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
		<li class="popTitle">작업 진행내역 수정</li>
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
		
		<div class="pop_board mB20">
			<p class="th_stitle">진행내역</p>
			<form:form name="frm" id="frm" commandName="dayReportRegist" method="POST" action="${rootPath}/cooperation/updateDayReport.do" enctype="multipart/form-data">
			<input type="hidden" name="no" value="${dayReport.no}"/>
			<input type="hidden" name="prjId" value="${result.prjId}"/>
			<input type="hidden" name="taskId" value="${result.taskId}"/>
			<input type="hidden" name="userNo" value="${result.userNo}"/>
			<input type="hidden" name="cnt" value="1"/>
			<input type="hidden" name="attachFileId" value="${dayReport.attachFileId}"/>
			<input type="hidden" name="taskNm" value="${result.taskSjPrint}"/>
			<input type="hidden" name="prjNm" value="[${result.prjCd}]${result.prjNm}"/>
			
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
				</colgroup>
				<tbody id="tbody">
					<tr>
						<td class="title">날짜</td>
						<td class="pL10"><input type="text" class="span_5 calGen" name="dayReportDt" value="${dayReport.dayReportDt}" onchange="projectInputAble();"/></td>
						<td class="title">시간</td>
						<td class="pL10"><input type="text" class="span_3" name="dayReportTm" id="dayReportTm" value="${dayReport.dayReportTm}" onfocus="numGen('dayReportTm',0,24,5);" />시간</td>
					</tr>
					<tr>
						<td class="title">진행내역</td>
						<td class="pL10 pT5 pB5" colspan="3"><textarea name="dayReportCn" class="textarea span_28 height_70"><c:out value="${dayReport.dayReportCn}" escapeXml="false"/></textarea>
						</td>
					</tr>
					<tr>
						<td class="title">첨부파일</td>
						<td class="pL10 pT5 pB5" colspan="3">
							<c:if test="${not empty dayReport.attachFileId}">
								<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
									<c:param name="param_atchFileId" value="${dayReport.attachFileId}" />
								</c:import>
							</c:if>	
							<c:if test="${dayReport.attachFileId == ''}">
								<input type="hidden" name="fileListCnt" value="0" />
							</c:if>
							<div id="file_upload_posbl"  style="display:none;" >	
								<input type="file" name="file_1" id="egovComFileUploader"/>
								<div id="egovComFileList"></div>
							</div>
							<div id="file_upload_imposbl"  style="display:none;" >
								<spring:message code="common.imposbl.fileupload" />
							</div>

							<script type="text/javascript">
							var existFileNum = document.frm.fileListCnt.value;
							var maxFileNum = 3;
							
							if (existFileNum=="undefined" || existFileNum ==null) {
								existFileNum = 0;
							}
							var uploadableFileNum = maxFileNum - existFileNum;
							if (uploadableFileNum<0) {
								uploadableFileNum = 0;
							}
							if (uploadableFileNum != 0) {
								fn_egov_check_file('Y');
								var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum , '');
								multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
							} else {
								fn_egov_check_file('N');
							}
							</script>
						</td>
					</tr>
				</tbody>
			</table>
			</form:form>
		</div>
		
		<div class="pop_btn_area04">
			<a href="javascript:update();"><img src="${imagePath}/btn/btn_ok.gif" /></a>
			<a href="javascript:window.close();"><img src="${imagePath}/btn/btn_cancel.gif" /></a>
		</div>
	</div>
</div>

</body>
</html>
