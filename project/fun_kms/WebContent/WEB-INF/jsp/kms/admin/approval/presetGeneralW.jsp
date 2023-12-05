	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="adminGenPreset" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
$(document).ready(function(){
	var form = $('#presetVO');
	var mode ="${mode}";
	$('#presetSaveB').click(function(){
		if(!validateAdminGenPreset(document.presetVO))
			return;		
		if(mode=="W")
			form.attr("action","/admin/approval/insertPreset.do");
		else
			form.attr("action","/admin/approval/updatePreset.do");	
		form.submit();
		
	});	

	$('#presetCancleB').click(function(){
		history.back(-1);
	});
	
});
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
							<li class="stitle">지출결의서 프리셋 <c:if test="${mode=='W'}">작성</c:if><c:if test="${mode=='M'}">수정</c:if></li>
						</ul>
					</div>
	
					<!-- S: section -->
					<form:form commandName="presetVO" name="presetVO" method="post" >
					<form:hidden path="presetId" />
					<form:hidden path="presetTyp" />
					<div class="section01">	
						
						<!-- 게시판 시작  -->
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>지출결의서 프리셋 등록</caption>
		                    <colgroup><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
 								<tr>
								    <td class="title">이름</td>
									<td class="pL10" >
										<form:input path="presetNm" cssClass="span_22" />
									</td>
 								</tr>  
 								<tr>
								    <td class="title">계정과목</td>
									<td class="pL10" >
										<form:input path="accNm" cssClass="span_6" readonly="readonly" onclick="accGen('accNm','accId',10);"/>
										<img src="${imagePath}/btn/btn_tree.gif" onclick="accGen('accNm','accId',10);" class="cursorPointer">
										<form:hidden path="accId" />
									</td>
 								</tr> 
 								<tr>
								    <td class="title">프로젝트</td>
									<td class="pL10" >
										<form:input path="prjFnm" cssClass="span_22" readonly="readonly" onclick="prjGen('prjFnm','prjId',1);"/>
										<form:hidden path="prjId" />
										<img src="${imagePath}/btn/btn_tree.gif" onclick="prjGen('prjFnm','prjId',1);" class="cursorPointer">
									</td>
 								</tr> 
		                    </tbody>
		                    </table>
						</div>
						<!-- 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<img src="${imagePath}/admin/btn/btn_save.gif" class="cursorPointer" id="presetSaveB"/>
		                	<img src="${imagePath}/admin/btn/btn_cancel.gif" class="cursorPointer" id="presetCancleB"/>
		                </div>
		                <!-- 버튼 끝 -->						
						
					</div>
					</form:form>
					<!-- E: section --
				
				
				<!-- E: center -->
			</div>
			<!-- E: centerBg -->		
		</div>
		<!-- E: contents -->
	</div>
</div>	
	<!-- E: container -->
<%@ include file="../include/admin_footer.jsp"%>
</div>
</body>
</html>
