<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/cheditor.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/utils/imageUtil.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="meetingResult" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
var mtResultSaveOk = "${mtResultSaveOk}";
if(mtResultSaveOk == "mtResultSaveOk"){
	opener.location.href = "${rootPath}/cooperation/selectMeetingRoom.do?mtId=${mtId}";
	self.close();
}

function updateResult(){
	document.frm.mtResult.value = myeditor.outputBodyHTML();
	if (!validateMeetingResult(document.frm)) {
		return;
	}
	document.frm.submit();
}

function deleteResult(){
	document.frm.mtResult.value = "";
	document.frm.submit();
}
</script>
</head>

<body>
<form:form name="frm" commandName="MeetingRoom" action="${rootPath}/cooperation/updateMeetingResult.do">
<input type="hidden" name="mtId" value="${result.mtId}"/>
<div id="pop_regist06">
 	<div id="pop_top">
 	   <ul>
			<li><img src="../images/inc/pop_bullet.gif" /></li>
			<li class="popTitle">
			<c:choose>
				<c:when test="${inputType == 'Reg'}">회의결과 등록</c:when>
				<c:otherwise>회의결과 수정</c:otherwise>
			</c:choose>
			</li>
		</ul>
 	</div>
 	<div id="pop_con11">
 		<div class="print_board">
			<table cellpadding="0" cellspacing="0">
			<caption>회의결과 </caption>

			<tbody>
               	<tr>
                	<td>
						<textarea rows="9" cols="100" name="mtResult" id="mtResult"><c:out value="${result.mtResult}" escapeXml="false"/></textarea>
						<script type="text/javascript" language="javascript">
							var myeditor = new cheditor();
							myeditor.config.editorHeight = '400px';
							myeditor.config.editorWidth = '100%';
							myeditor.inputForm = 'mtResult';
							myeditor.run();
						</script>						
                	</td>
               	</tr>
			</tbody>
			</table>
 		</div>
 	</div>
	<div class="pop_btn_area05">
		<c:if test="${inputType == 'Reg'}">
			<a href="javascript:updateResult();"><img src="${imagePath}/btn/btn_regist.gif"/></a>
		</c:if>	
		<c:if test="${inputType == 'Mod'}">
			<a href="javascript:updateResult();"><img src="${imagePath}/btn/btn_modify.gif"/></a>
			<a href="javascript:deleteResult();"><img src="${imagePath}/btn/btn_delete.gif"/></a>
		</c:if>	
		<a href="javascript:self.close();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
	</div>
</div>
</form:form>
</body>
</html>
