<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="cmmnCode" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_CmmnCode(){
	location.href = "/sym/ccm/cca/EgovCcmCmmnCodeList.do";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
 function fn_egov_modify_CmmnCode(form){
	if(confirm("<spring:message code='common.save.msg'/>")){
		if(!validateCmmnCode(form)){ 			
			return;
		}else{
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
							<li class="stitle">공통코드 수정</li>
						</ul>
					</div>
					<form:form commandName="cmmnCode" name="cmmnCode" method="post">
					<input name="cmd" type="hidden" value="Modify">
					<form:hidden path="clCode"/>
					<form:hidden path="codeId"/>
					<input name="searchCondition" type="hidden" value="${searchVO.searchCondition}" />
					<input name="searchKeyword" type="hidden" value="${searchVO.searchKeyword}"/>
					<input name="pageIndex" type="hidden" value="${searchVO.pageIndex}"/>
					<!-- S: section -->
					<div class="section01">	
						
						<!-- 게시판 시작  -->
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공통코드</caption>
		                    <colgroup><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr> 
			                    	<td class="title">분류코드</td>
			                    	<td class="pL10" >${cmmnCode.clCodeNm}</td>
		                    	</tr>
		                    	<tr> 
			                    	<td class="title">코드ID</td>
			                    	<td class="pL10" >${cmmnCode.codeId}</td>
		                    	</tr>
								<tr>
								    <td class="title">코드ID명</td>
									<td class="pL10" >
										  <form:input  path="codeIdNm" size="60" maxlength="60" id="codeIdNm"/>
									</td>
 								</tr>
 								<tr>
								    <td class="title">코드ID설명</td>
									<td class="pL10 pT5 pB5" >
										<form:textarea path="codeIdDc" rows="3" cols="60" id="codeIdDc"/>
									</td>
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
		                    </tbody>
		                    </table>
						</div>
						<!-- 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<img class="cursorPointer" onclick="fn_egov_list_CmmnCode(); return false;" src="${imagePath }/admin/btn/btn_list.gif"/>
		                	<img class="cursorPointer" onclick="fn_egov_modify_CmmnCode(document.cmmnCode); return false;" src="${imagePath }/admin/btn/btn_save.gif"/>
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
