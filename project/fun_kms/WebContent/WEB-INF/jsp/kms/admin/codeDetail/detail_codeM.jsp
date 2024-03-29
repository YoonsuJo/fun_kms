<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="cmmnDetailCode" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */

var mode = ${cmmnDetailCode.mode };  
function fn_egov_list_CmmnDetailCode(){
	if(mode == 2) {
		location.href = "/admin/codeDetail/codeL2.do";
	} else {
		location.href = "/admin/codeDetail/codeL.do";
	}
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_modify_CmmnDetailCode(form){
	if(confirm("<spring:message code='common.save.msg'/>")){
		if(!validateCmmnDetailCode(form)){ 			
			return;
		}else{
			form.cmd.value = "Modify";
			form.submit();
		}
	}
}
-->
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
							<li class="stitle">공통상세코드 수정  ${cmmnDetailCode.mode }</li>
						</ul>
					</div>
					<form:form commandName="cmmnDetailCode" name="cmmnDetailCode" method="post">
						<input name="cmd" type="hidden" value="Modify">
						<form:hidden path="codeId"/>
						<form:hidden path="code"/>
						<form:hidden path="mode"/>
					<!-- S: section -->
					<div class="section01">	
						
						<!-- 게시판 시작  -->
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공통상세코드</caption>
		                    <colgroup><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr> 
			                    	<td class="title">코드ID</td>
			                    	<td class="pL10" >${cmmnDetailCode.codeIdNm}</td>
		                    	</tr>
		                    	<tr> 
			                    	<td class="title">코드</td>
			                    	<td class="pL10" >${cmmnDetailCode.code}</td>
		                    	</tr>
								<tr>
								    <td class="title">코드명</td>
									<td class="pL10" > <form:input  cssClass="span_23" path="codeNm" size="60" maxlength="60" id="codeNm"/></td>
 								</tr>
 								<tr>
								    <td class="title">코드설명</td>
									<td class="pL10 pT5 pB5" ><form:textarea path="codeDc" cssClass="span_23 height_35" id="codeDc"/></td>
 								</tr>
 								<tr>
								    <td class="title">사용여부</td>
									<td class="pL10">
									<form:select path="useAt" id="useAt">
									      <form:option value="Y" label="Yes"/>
									      <form:option value="N" label="No"/>
								      </form:select>
									</td>
 								</tr>
 								<tr>
								    <td class="title">칼럼1</td>
									<td class="pL10" > <form:input  cssClass="span_23" id="column1" path="column1" size="60" maxlength="60" /></td>
 								</tr>                    	
 								<tr>
								    <td class="title">칼럼2</td>
									<td class="pL10" > <form:input  cssClass="span_23" id="column2" path="column2" size="60" maxlength="60" /></td>
 								</tr>                    	
 								<tr>
								    <td class="title">칼럼3</td>
									<td class="pL10" > <form:input  cssClass="span_23" id="column3" path="column3" size="60" maxlength="60" /></td>
 								</tr>                    	
 								<tr>
								    <td class="title">칼럼4</td>
									<td class="pL10" > <form:input  cssClass="span_23" id="column4" path="column4" size="60" maxlength="60" /></td>
 								</tr>                    	
 								<tr>
								    <td class="title">정렬순서</td>
									<td class="pL10" > <form:input  cssClass="span_23" id="ord" path="ord" size="60" maxlength="60" /></td>
 								</tr>                    	
		                    </tbody>
		                    </table>
						</div>
						<!-- 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<img class="cursorPointer" onclick="fn_egov_list_CmmnDetailCode(); return false;"  src="${imagePath}/admin/btn/btn_list.gif"/>
		                	<img class="cursorPointer" onclick="fn_egov_modify_CmmnDetailCode(document.cmmnDetailCode); return false;"  src="${imagePath}/admin/btn/btn_save.gif"/>
		                </div>
		                <!-- 버튼 끝 -->						
						
					</div>
					<!-- E: section -->	
					</form:form>
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
