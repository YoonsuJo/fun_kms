<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="taskRegist" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function update() {
	
	$('#taskCn').val($('#taskCn').val().trim());
	
	if (!validateTaskRegist(document.frm)) {
		return;
	}
	if (document.frm.taskDuedate.value != '' && document.frm.taskStartdate.value > document.frm.taskDuedate.value) {
		alert("시작일과 완료예정일을 확인해주세요.");
		return;
	}


	if($("#alwaysViewCheck").prop("checked")){
		document.frm.alwaysViewYn.value = 'Y';
	}else{
		document.frm.alwaysViewYn.value = 'N';
	}
	
	document.frm.submit();					
}
</script>
</head>

<body><div id="pop_regist03">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
			<li class="popTitle">작업 수정하기</li>
		</ul>
 	</div>
 	
 	<div class="pop_con10">
 		<form:form name="frm" commandName="taskRegist" method="POST" action="${rootPath}/cooperation/updateTask.do">
 		<input type="hidden" name="taskId" value="${result.taskId}"/>
 		<input type="hidden" name="writerNo" value="${user.no}"/>
		<input type="hidden" name="taskState" value="${result.taskState}" />
		
		<input type="hidden" name="alwaysViewYn"/>
				
 		<table cellpadding="0" cellspacing="0">
 			<colgroup>
 				<col class="col90" />
				<col class="col120" />
				<col class="col90" />
				<col class="col120" />
				<col class="col60" />
				<col class="px" />
 			</colgroup>
 			<tbody>
 				<tr>
 					<td class="title" >프로젝트</td>
 					<td class="pL10" colspan="5">
 						<input type="text" class="span_19" name="prjNm" id="prjNm" readonly="readonly" onclick="prjGen('prjNm','prjId',1);" value="${result.prjNm}" />
 						<img src="${imagePath}/btn/btn_tree.gif" onclick="prjGen('prjNm','prjId',1);" class="cursorPointer"/>
 						<input type="hidden" class="span_19" name="prjId" id="prjId" value="${result.prjId}" />
 					</td>
 				</tr>
 				<tr>
 					<td class="title" >작업명</td>
 					<td class="pL10" colspan="5"><input type="text" class="span_19" name="taskSj" value="${result.taskSjPrint}" /></td>
 				</tr>
 				<tr>
 					<td class="title" >담당자</td>
 					<td class="pL10" colspan="5">							
						<input type="text" class="userNameAuto userValidateCheckAuth" name="leaderMixes" id="leaderMixes" value="${result.userNm}(${result.userId})" />
						<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('leaderMixes',1);"/>		
 					</td>
 				</tr>
 				<tr>
 					<td class="title" >시작일</td>
 					<td class="pL10">
 					<input type="text" class="span_4 calGen" name="taskStartdate" value="${result.taskStartdate}"/>
 					<input type="text" class="span_15px" name="taskStarttime" id="taskStarttime" value="${result.taskStarttime}" onfocus="numGen('taskStarttime',9,18,5);"/> 시	
 					</td>
 					<td class="title" >완료예정일</td>
 					<td class="pL10">
 						<input type="text" class="span_4 calGen" name="taskDuedate" value="${result.taskDuedate}"/>
 						<input type="text" class="span_15px" name="taskDuetime" id="taskDuetime" value="${result.taskDuetime}" onclick="numGen('taskDuetime',9,18,5);"/> 시
 					</td>
 					 <td class="title cursorPointer" title="작업기간내 오늘의 업무에 계속 보여집니다." >계속보기</td>
 					<td class="pL10 cursorPointer" title="작업기간내 오늘의 업무에 계속 보여집니다." ><input type="checkbox" name="alwaysViewCheck" id="alwaysViewCheck" <c:if test="${result.alwaysViewYn == 'Y'}">checked="checked"</c:if>/></td>
 				</tr>
 				<tr>
 					<td class="title">등록자</td>
 					<td class="pL10"><print:user userNo="${user.no}" userNm="${user.userNm}"/></td>
 					<td class="title">진행상태</td>
 					<td class="pL10" colspan="3"><span class="txt_blue">${result.taskStatePrint}</span></td>
 				</tr>
 				<tr>
 					<td class="title" >내용</td>
 					<td class="pL10 pT5 pB5" colspan="5">
 						<textarea name="taskCn" id="taskCn" class="span_12 height_170"><c:out value="${result.taskCn}" escapeXml="false"/></textarea>
 					</td>
 				</tr>
 			</tbody>
 		</table>
 		</form:form>

 	    <div class="pop_btn_area">
            <a href="javascript:update();"><img src="${imagePath}/btn/btn_modify.gif"/></a>
            <a href="javascript:window.close();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
        </div>
 		
 	</div>
</div>

</body>
</html>
