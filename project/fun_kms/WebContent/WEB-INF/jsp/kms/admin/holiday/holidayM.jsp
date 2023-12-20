<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/cheditor.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/utils/imageUtil.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="commSche" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function update() {
	document.frm.scheCn.value = myeditor.outputBodyHTML();
	if (!validateCommSche(document.frm)) {
		return;
	}
	document.frm.action = '<c:url value="${rootPath}/admin/holiday/updateHoliday.do"/>';
	document.frm.submit();
}
function list() {
	location.href = "/admin/holiday/holidayList.do";
}
function fnDelete(){
	if (confirm("<spring:message code="common.delete.msg" />")) {
		var varForm				 = document.all["frm"];
		varForm.action           = "<c:url value='/admin/holiday/deleteHoliday.do'/>";
		varForm.scheId.value     = "${result.scheId}";
		varForm.submit();
	}
}
</script>
</head>

<body>
<div id="admin_wrap">
	<!-- S: container -->
	<div id="admin_container">
		<ul class="admin_container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="admin_contents">
		<%@ include file="../left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">휴일 등록</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">	
						<form:form commandName="commSche" name="frm" method="POST" action="${rootPath}/community/updateSchedule.do" enctype="multipart/form-data">
						<input type="hidden" name="scheId" value="${result.scheId}"/>
						<input type="hidden" name="scheTmTyp" value="0"/>
						<!-- 게시판 시작  -->
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>휴일</caption>
		                    <colgroup><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr> 
			                    	<td class="title">휴일일자</td>
			                    	<td class="pL10" ><input type="text" name="date" class="span_7 calGen" autocomplete="off" value="${result.scheYear}${result.scheMonth}${result.scheDate}"/></td>
		                    	</tr>
								<tr>
								    <td class="title">휴일명</td>
									<td class="pL10" ><input type="text" name="scheSj" class="span_23" value="${result.scheSj}"/></td>
 								</tr>
 								<tr>
								    <td class="title">휴일설명</td>
									<td class="pL10 pT5 pB5" >
			                    		<textarea rows="9" cols="100" name="scheCn" id="scheCn"><c:out value="${result.scheCn}" escapeXml="false"/></textarea>
			                    		<script type="text/javascript" language="javascript">
											var myeditor = new cheditor();
											myeditor.config.editorHeight = '400px';
											myeditor.config.editorWidth = '100%';
											myeditor.inputForm = 'scheCn';
											myeditor.run();
										</script>
									</td>
 								</tr>
 								<tr>
								    <td class="title">휴일구분</td>
									<td class="pL10">
										<select name="scheTyp">
											<option value="">--선택하세요--</option>
											<c:forEach items="${typeList}" var="typ">
												<option value="${typ.code}" <c:if test="${result.scheTyp == typ.code}">selected="selected"</c:if>>${typ.codeNm}</option>
											</c:forEach>
										</select>
									</td>
 								</tr>                    	
		                    </tbody>
		                    </table>
						</div>
						<!-- 게시판 끝  -->
						</form:form>
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="javascript:update();"><img src="${imagePath}/admin/btn/btn_save.gif"/></a>
							<a href="#noscript" onclick="fnDelete(); return false;"><img src="${imagePath}/admin/btn/btn_delete.gif"/></a>
		                	<a href="javascript:list();"><img src="${imagePath}/admin/btn/btn_list.gif"/></a>
		                <!-- 버튼 끝 -->						
						
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
<%@ include file="../include/admin_footer.jsp"%>
</div>
</body>
</html>
