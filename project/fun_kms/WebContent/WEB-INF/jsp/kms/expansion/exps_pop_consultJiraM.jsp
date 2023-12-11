<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript">
function jiraUpdate() {
	
	document.frm.action = "<c:url value='${rootPath}/cooperation/updateConsultJira.do'/>";
	document.frm.submit();
}
</script>
</head>

<body><div id="pop_regist02">
 	<div id="pop_top">
 	   <ul>
			<li><img src="../images/inc/pop_bullet.gif" /></li>
			<li class="popTitle">지라등록</li>
		</ul>
 	</div>
 	<div class="pop_con08">
 		
 		<div class="pop_board mB20">
 		<form:form commandName="frm" name="frm" method="post">
 		<input type="hidden" name="consult_no" value="${result.consult_no }"/>
 		<table cellpadding="0" cellspacing="0">
 			<colgroup><col class="col100" /><col width="px"/></colgroup>
 			<tbody>
 				<tr>
 					<td class="title" >지라등록여부</td>
 					<td class="pL10">
 						<select name="jira_yn" class="select01">
 							<option value="" label="선택"/>		
             				<option value="Y" label="Y" <c:if test="${result.jira_yn=='Y' }"> selected="selected"</c:if>/>
             				<option value="N" label="N" <c:if test="${result.jira_yn=='N' }"> selected="selected"</c:if>/>
				      	</select>
 					</td>
 				</tr>
 				<tr>
 					<td class="title" >지라코드</td>
 					<td class="pL10">
 						<input type="text" name="jira_code" class="input01 span_5" value="${result.jira_code }"/>
 					</td>					
 				</tr>
 			</tbody>
 		</table>
 		</form:form>
 		</div>
 		
 		<div class="pop_btn_area">
            <a href="javascript:jiraUpdate()"><img src="${imagePath}/btn/btn_regist.gif"/></a>
            <img src="${imagePath}/btn/btn_close.gif" alt="창닫기" class="cursorPointer" onclick="window.close();">
        </div>
 		
 	</div>
</div>

</body>
</html>
