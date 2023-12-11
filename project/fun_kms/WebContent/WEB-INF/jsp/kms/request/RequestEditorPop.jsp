<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysNow"><fmt:formatDate value="${now}" pattern="yyyyMMdd" /></c:set> 

<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/cheditor.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/utils/imageUtil.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="RequestContact" staticJavascript="false" xhtml="true" cdata="false"/>
<script>

$(document).ready(function(){
	window.resizeTo(1200, 1000);
	
	window.onbeforeunload = function() {
		$.ajax({
			url: "/request/modifyerCloseAjax.do",
			data: {
				no: $("input[name=no]").val(),
			},
			type: "POST",
			async: false,
			dataType: "json",
			success: function(data) {
				if (data.RETURN.equals('OK')) {
					window.close();
				}
			},
			error: function(xhr, testStatus, errorThrown) {
				console.log("작업 처리에 실패하였습니다.");
	  	 	}
		});
	}

	
	/* $(window).bind("beforeunload", function (e){
	
	}); */
});

function modifyRequest() {
	document.fm.method = "POST";
	document.fm.action = "/request/modifyRequestPop.do";
	document.fm.submit();
}

function updateCompleteDemand(no , completeStatus , reqId) {
	var stateName ="";
	if(completeStatus == 1){
		stateName = "완료"
	}else{
		stateName = "미완료"
	}
	if(confirm(stateName +" 하시겠습니까?")){
		$.ajax({
			url: "/request/completeStatusAjax.do",
			data: {
				no: no,
				completeStatus: completeStatus,
				reqId: reqId
			},
			type: "POST",
			async: false,
			dataType: "json",
			success: function(data) {
				// 수행 프로젝트가 아닐 경우, 오류메시지
				if (!data.RETURN.equals('OK')) {
					alert('작업이 처리되지 못하였습니다');
					return false;
				}
				$("#complete_datetime_"+no).text(data.UPDATETIME);
			},
			error: function(xhr, testStatus, errorThrown) {
				alert("작업 처리에 실패하였습니다.");
	  	 	}
		});
	} else{
		return false;
	} 
}

function isModifyer(){
	$.ajax({
		url: "/request/isModifyUserAjax.do",
		data: {
			no: $("input[name=no]").val(),
		},
		type: "POST",
		async: false,
		dataType: "json",
		success: function(data){
			if (data.RETURN.equals('OK')) {
				document.fm.contents.value = myeditor.outputBodyHTML();
			 	if (!validateRequestContact(document.fm)) {
					return;
				}	
				if(checkValues() != true) {
					return;
				}	
				document.fm.action = '<c:url value="/request/saveRequest.do" />';	
				document.fm.submit();
			}else{
				if(confirm(data.MODIFYER+"님이 수정 중입니다. 그래도 저장하시겠습니까?")){
					document.fm.contents.value = myeditor.outputBodyHTML();
				 	if (!validateRequestContact(document.fm)) {
						return;
					}	
					if(checkValues() != true) {
						return;
					}	
					document.fm.action = '<c:url value="/request/saveRequest.do" />';	
					document.fm.submit();
				}
			}
		},
		error: function(xhr, testStatus, errorThrown) {
			console.log("작업 처리에 실패하였습니다.");
  	 	}
	});
}

function windowClose() {
	$.ajax({
		url: "/request/modifyerCloseAjax.do",
		data: {
			no: $("input[name=no]").val(),
		},
		type: "POST",
		async: false,
		dataType: "json",
		success: function(data) {
			if (data.RETURN.equals('OK')) {
				window.close();
			}
		},
		error: function(xhr, testStatus, errorThrown) {
			console.log("작업 처리에 실패하였습니다.");
  	 	}
	});
	
}

function checkValues() {
	/* TENY_170522  각 필드값을 확인한다 */
	/* TENY_170522  제목 필드값을 확인한다. 비었으면 포커스 맞추고 종료 */
 /* 	var strTmp = "#title";
	if($(strTmp).val().length <= 0){
		alert("제목은 필수입력사항입니다");
		$(strTmp).focus();
		return false;
	}
	strTmp = "#prjNm";
	if($(strTmp).val().length <= 0){
		alert("프로젝트는 필수입력사항입니다");
		$(strTmp).focus();
		return false;
	}  */
	if($("#dueDate").val().length <=0){
		alert("완료요청일은 필수입력사항입니다");
		$("#dueDate").focus();
		return false;
	}
	
	return true; 
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
<div id="pop_board1">
	<div id="pop_top">
	<ul>
		<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
		<c:choose>
			<c:when test="${(rVO.no == null) || (rVO.no == 0)}">
				<li class="popTitle">요구사항 등록</li>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${edit}">
						<li class="popTitle">요구사항 수정</li>
					</c:when>
					<c:otherwise>
						<li class="popTitle">요구사항 조회</li>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
	</ul>
	</div>
	<div class="pop_con16">
		<div class="pop_board1 mB20">
			<c:choose>
				<c:when test="${edit}">
					<input type="button" value="취소" class="mL10 fr btn_gray" onclick="javascript:windowClose();"/>
					<input type="button" value="저장" class="mL10 fr btn_gray" onclick="javascript:isModifyer();"/>
				</c:when>
				<c:otherwise>
					<input type="button" value="수정" class="mL10 fr btn_gray" onclick="javascript:modifyRequest();"/>
				</c:otherwise>
			</c:choose>
			<div style="display:flex;">
				<div>
					<p class="th_stitle">요구사항</p>
				</div>
				<c:if test="${edit && (rVO.modifyerNo ne null) && (rVO.modifyerNo ne 0) && (user.no ne rVO.modifyerNo)}">
					<div class="mL20 T_red">
						* ${rVO.modifyerName}님이 수정 중입니다.
					</div>
				</c:if>
			</div>
			<form:form name="fm" id="fm" commandName="RequestContact" method="POST"  enctype="multipart/form-data">
		<c:choose>
			<c:when test="${(rVO.no == null) || (rVO.no == 0)}" >
				<input type="hidden" name="no" value="0"/>
			</c:when>
			<c:otherwise>
				<input type="hidden" name="no" value="${rVO.no}"/>
			</c:otherwise>
		</c:choose>
			<input type="hidden" name="reqId" value="${rVO.reqId}"/>

			<table cellpadding="0" cellspacing="0">
			<colgroup>
				<col class="col80" />
				<col class="col200" />
				<col class="col80" />
				<col class="col200" />
				<col class="col80" />
				<col class="col200" />
			</colgroup>
				<tbody id="tbody">
					<tr>
						<td class="title">요구명</td>
						<td class="pL5" colspan="5">
							<c:choose>
								<c:when test="${edit}">
									<input type="text" class="w500 pL5" name="title" id="title" value="${rVO.title}"/>
									<span class="fr mR10"><input type="radio" name="reqType" id="reqType" value="4" checked="checked"/>오류</span>
									<span class="fr mR10"><input type="radio" name="reqType" id="reqType" value="2" checked="checked"/>요구</span>
									<span class="fr mR10"><input type="radio" name="reqType" id="reqType" value="1" checked="checked"/>과제</span>
								</c:when>
								<c:otherwise>
									${rVO.title}
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td class="title">작성자</td>
						<td class="pL5 txt_center">
							<c:choose>
								<c:when test="${edit}">
									<c:choose>
										<c:when test="${fn:length(rVO.writerMixes) < 1}" >
											<input type="text" class="w150 pL5 userNameAuto userValidateCheck" name="writerMixes" id="writerMixes" value="${user.userNm}(${user.userId})"/>
										</c:when>
										<c:otherwise>
											<input type="text" class="w150 pL5 userNameAuto userValidateCheck" name="writerMixes" id="writerMixes" value="${rVO.writerMixes}"/>
										</c:otherwise>
									</c:choose>
									<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('writerMixes',1)"/>
								</c:when>
								<c:otherwise>
									<print:user userNo="${rVO.writerNo}" userNm="${rVO.writerName}"/>
								</c:otherwise>
							</c:choose>
						</td>
						<td class="title">작성일</td>
						<td class="pL5 txt_center">
							<input type="hidden" name="regDatetime" id="regDatetime" value="${rVO.regDatetime}"/>
							${rVO.regDatetime}
						</td>
						<td class="title">완료요청일</td>
						<td class="pL5 txt_center">
							<c:choose>
								<c:when test="${edit}">
									<c:choose>
										<c:when test="${fn:length(rVO.dueDate) < 1}">
											<input type="text" name="dueDate" id="dueDate" class="w150 calGen txt_center" value="" autocomplete="off"/>
										</c:when>
										<c:otherwise>
											<input type="text" name="dueDate" id="dueDate" class="w150 calGen txt_center" value="${rVO.dueDate}" autocomplete="off" <c:if test="${user.no ne rVO.mainManagerNo && user.no ne rVO.writerNo}">disabled</c:if>/>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									${rVO.dueDate}
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					
					<%-- 등록인 경우 숨김 처리 --%>
					<c:if test="${(rVO.no == null) || (rVO.no == 0)}">
						<input type="hidden" name="status" id="status" value="1"/>
					</c:if>
					<c:if test="${(rVO.no != null) && (rVO.no != 0)}">
					<tr>
						<td class="title">관리자</td>
						<td class="pL5 txt_center">
							<c:choose>
								<c:when test="${edit}">
									<c:choose>
										<c:when test="${fn:length(reqUserList) < 0}" >
											<input type="text" class="w150 pL5 userNameAuto userValidateCheck" name="managerMixesMain" id="managerMixesMain" value=""/>
										</c:when>
										<c:otherwise>
												<input type="text" class="w150 pL5 userNameAuto userValidateCheck" name="managerMixesMain" id="managerMixesMain" value="${rVO.managerMixesMain}"/>
										</c:otherwise>
									</c:choose>  
									<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('managerMixesMain',1)"/>
								</c:when>
								<c:otherwise>
									${rVO.managerMixesMain}
								</c:otherwise>
							</c:choose>					
						</td>
						<td class="title">시작일</td>
						<td class="pL5 txt_center">
							<c:choose>
								<c:when test="${edit}">
									<c:choose>
										<c:when test="${fn:length(rVO.startDate) < 1}">
											<input type="text" name="startDate" id="startDate" class="w150 calGen txt_center" value="" autocomplete="off"/>
										</c:when>
										<c:otherwise>
											<input type="text" name="startDate" id="startDate" class="w150 calGen txt_center" value="${rVO.startDate}" autocomplete="off" <c:if test="${user.no ne rVO.mainManagerNo && user.no ne rVO.writerNo}">disabled</c:if>/>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									${rVO.startDate}
								</c:otherwise>
							</c:choose>
						</td>
						<td class="title">완료예정일</td>
						<td class="pL5 txt_center">
							<c:choose>
								<c:when test="${edit}">
									<c:choose>
										<c:when test="${fn:length(rVO.endDate) < 1}">
											<input type="text" name="endDate" id="endDate" class="w150 calGen txt_center" value="" autocomplete="off"/>
										</c:when>
										<c:otherwise>
											<input type="text" name="endDate" id="endDate" class="w150 calGen txt_center" value="${rVO.endDate}" autocomplete="off" <c:if test="${user.no ne rVO.mainManagerNo && user.no ne rVO.writerNo}">disabled</c:if>/>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									${rVO.endDate}
								</c:otherwise>
							</c:choose>
						</td>
					</tr>						
					<tr>
						<td class="title">처리자</td>
						<td class="pL5" colspan="5">
							<c:choose>
								<c:when test="${edit}">
									<input type="text" style="width:95% !important;" class="pL5 userNamesAuto userValidateCheck" name="managerMixes" id="managerMixes"
											value="<c:forEach items="${reqUserList}" var="req">${req.userNm}(${req.userId}), </c:forEach>" />						
									<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('managerMixes',0)"/>
								</c:when>
								<c:otherwise>
									<c:forEach items="${reqUserList}" var="req" varStatus="c">
										<c:if test="${c.count != 1}"></br></c:if>
										<print:user userNo="${req.userNo}" userNm="${req.userNm}"/>
										&nbsp;&nbsp;
										(미완료 <input type="radio" name="completeDemand_${req.no}" value="0" onclick="return updateCompleteDemand('${req.no}','0','${req.reqId}')" <c:if test="${req.completeStatus eq 0}">checked</c:if>> 
										완료 <input type="radio" name="completeDemand_${req.no}" value="1" onclick="return updateCompleteDemand('${req.no}','1','${req.reqId}')" <c:if test="${req.completeStatus eq 1}">checked</c:if>> 
										<span id="complete_datetime_${req.no}">${req.completeDateTime }</span>)
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td class="title">진행상태</td>
						<td class="pL5" colspan="5">
							<c:choose>
								<c:when test="${edit}">
									<c:if test="${rVO.no ne null && rVO.no ne 0 && user.no ne rVO.mainManagerNo && user.no ne rVO.writerNo}">
										<input type="hidden" name="status" id="status" value="${rVO.status}">
									</c:if>
									<input type="radio" name="status" id="status" value="1" <c:if test="${(rVO.no == null) || (rVO.no == 0) || (rVO.status == 1)}">checked</c:if><c:if test="${rVO.no ne null && rVO.no ne 0 && user.no ne rVO.mainManagerNo && user.no ne rVO.writerNo}"> disabled</c:if>/>대기중
									<input type="radio" name="status" id="status" value="2" <c:if test="${rVO.status == 2}">checked</c:if><c:if test="${rVO.no ne null && rVO.no ne 0 && user.no ne rVO.mainManagerNo && user.no ne rVO.writerNo}"> disabled</c:if>/>설계중
									<input type="radio" name="status" id="status" value="4" <c:if test="${rVO.status == 4}">checked</c:if><c:if test="${rVO.no ne null && rVO.no ne 0 && user.no ne rVO.mainManagerNo && user.no ne rVO.writerNo}"> disabled</c:if>/>구현중
									<input type="radio" name="status" id="status" value="8" <c:if test="${rVO.status == 8}">checked</c:if><c:if test="${rVO.no ne null && rVO.no ne 0 && user.no ne rVO.mainManagerNo && user.no ne rVO.writerNo}"> disabled</c:if>/>검증중 
									<input type="radio" name="status" id="status" value="16" <c:if test="${rVO.status == 16}">checked</c:if><c:if test="${rVO.no ne null && rVO.no ne 0 && user.no ne rVO.mainManagerNo && user.no ne rVO.writerNo}"> disabled</c:if>/>완료
									<input type="radio" name="status" id="status" value="32" <c:if test="${rVO.status == 32}">checked</c:if><c:if test="${rVO.no ne null && rVO.no ne 0 && user.no ne rVO.mainManagerNo && user.no ne rVO.writerNo}"> disabled</c:if>/>보류
									<input type="radio" name="status" id="status" value="64" <c:if test="${rVO.status == 64}">checked</c:if><c:if test="${rVO.no ne null && rVO.no ne 0 && user.no ne rVO.mainManagerNo && user.no ne rVO.writerNo}"> disabled</c:if>/>삭제
								</c:when>
								<c:otherwise>
									${rVO.statusStr}
								</c:otherwise>
							</c:choose>
						
						</td>
					</tr>
					</c:if>
					
					<tr>
						<td class="title">첨부파일</td>
						<td class="pL5" colspan="5">
							<c:choose>
								<c:when test="${edit}">
									<c:if test="${not empty rVO.atchFileId}">
										<c:import url="${rootPath}/selectFileInfsForUpdateRequest.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${rVO.atchFileId}" />
										</c:import>
									</c:if>
									<c:if test="${empty rVO.atchFileId}">
										<input type="hidden" name="fileListCnt" value="0" />
									</c:if>
									<div id="file_upload_posbl"  style="display:none;" >	
										<input type="file" name="file_1" id="egovComFileUploader" class="write_input12"/>
										<div id="egovComFileList"></div>
									</div>
									<div id="file_upload_imposbl"  style="display:none;" >
										<spring:message code="common.imposbl.fileupload" />
									</div>			
	
									<script type="text/javascript">
									var existFileNum = document.fm.fileListCnt.value;
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
										var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum , 'write_input');
										multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
									} else {
										fn_egov_check_file('N');
									}
									</script>
									<span>※ 첨부파일의 최대 용량은 70MB입니다. 첨부파일은 3개까지 첨부 가능합니다.</span>
								</c:when>
								<c:otherwise>
									<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${rVO.atchFileId}" />
									</c:import>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td class="pL5 pT5 pB5 " colspan="6">
							<c:choose>
								<c:when test="${edit}">
									<%-- <textarea  class="w98p h400" name="contents" rows="30" style="resize:both">${rVO.contents }</textarea> --%>
									<textarea rows="30" name="contents" id="contents"><c:out value="${rVO.contents}" escapeXml="false"/></textarea>
		                    		<script type="text/javascript" language="javascript">
										var myeditor = new cheditor();
										myeditor.config.editorHeight = '500px';
										myeditor.config.editorWidth = '100%';
										myeditor.inputForm = 'contents';
										myeditor.run();
									</script>
								</c:when>
								<c:otherwise>
									<p class="textarea1"><c:out value="${rVO.contents}" escapeXml="false" /></p>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</tbody>
			</table>
			</form:form>
		</div>	
		<!-- 검토목록 시작 -->
		<!-- LYS_20180716_ 검토목록을 작업 목록으로 수정 -->
		<c:if test="${!edit}">
			<p class="th_stitle">작업내역</p>
						<div class="boardWrite02 mB20">
						 <form name="reviewfm" id="reviewfm" methos="POST" >
							<table cellpadding="0" cellspacing="0" >
							<colgroup>
								<col class="col60" />
								<col width="px" />
								<col class="col100" />
								<col class="col60" />
							</colgroup>
							<tbody>
								<tr>
									<td class="title">번호</td>
									<td class="title">내용</td>
									<td class="title">작성일</td>
									<td class="title">작성자</td>
								</tr>
							<c:forEach items="${rvVOList}" var="vo" varStatus="c">
								<tr>
									<td class="txt_center" > ${c.count}</td>
									<td class="write_info2 pA5">
										<p class="textarea1">${vo.contents}</p>
										<%-- <a href="javascript:modifyReview('${vo.no}')"><p class="textarea1">${vo.contents}</p></a> --%>
									</td>

									<td class="txt_center"> ${vo.regDatetime}</td>
									<td class="txt_center">
									<print:user userNo="${vo.writerNo }" userNm="${vo.writerName }"/>
									</td>
								</tr>
							</c:forEach>
							</tbody>
							</table>
						</form>
						</div>
						<!-- 검토목록 끝 -->
						<!-- LYS_20180716_작업 목록 안씀 (검토목록을 작업 목록으로 대체)  -->
						<input type="button" value="등록" class="fr btn_gray" onclick="javascript:writeReqTask();" style="display:none;"/>
						<p class="th_stitle" style="display:none;">작업목록</p>
						<div class="boardWrite02 mB20" style="display:none;">
						 <form name="taskfm" id="taskfm" methos="POST" >
							<input type="hidden" name="no" id="no" value="0"/>
							<input type="hidden" name="reqNo" id="reqNo" value="${rVO.no}"/>
							<input type="hidden" name="reqId" id="reqId" value="${rVO.reqId}"/>
							<input type="hidden" name="reqTitle" id="reqTitle" value="${rVO.title}"/>
							<table cellpadding="0" cellspacing="0" >
							<colgroup>
								<col class="col80" />
								<col width="px" />
								<col class="col60" />

								<col class="col60" />
								<col class="col60" />
			
								<col class="col60" />
								<col class="col50" />
							</colgroup>
							<tbody>
								<tr>
									<td class="title">작업번호</td>
									<td class="title">작업명</td>
									<td class="title">우선순위</td>

									<td class="title">작성자</td>
									<td class="title">생성일</td>

									<td class="title">담당자</td>
									<td class="title">상태</td>
								</tr>
							<c:forEach items="${rtVOList}" var="vo" varStatus="c">
								<tr>
									<td class="txt_center" ><a href="javascript:modifyReqTask('${vo.no}')">${vo.taskId}</a></td>
									<td class="pL10 txt_left"><a href="javascript:viewReqTask('${vo.no}')">${vo.title}</a></td>
									<td class="txt_center">${vo.priorityStr}</td>

									<td class="txt_center">${vo.writerName}</td>
									<td class="txt_center"> ${vo.regDatetime}</td>

									<td class="txt_center"> ${vo.workerName}</td>
									<td class="txt_center"> ${vo.statusStr}</td>
								</tr>
							</c:forEach>
							</tbody>
							</table>
						</form>
						</div>
		</c:if>
	</div>
</div>

</body>
</html>
