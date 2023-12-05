<%
 /**
  * @Class Name  : EgovCcmCmmnClCodeModify.jsp
  * @Description : EgovCcmCmmnClCodeModify 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.04.01   이중호              최초 생성
  *
  *  @author 공통서비스팀 
  *  @since 2009.04.01
  *  @version 1.0
  *  @see
  *  
  */
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<title>공통조직관리 수정</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="organ" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_CmmnClCode(){
	location.href = "/admin/organ/OrganList.do";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_modify_CmmnClCode(form){
	if(confirm("<spring:message code="common.save.msg" />")){
		if(!validateOrgan(form)){ 			
			return;
		}else{
			if($('#organ input[name=orgnztSnm]').val().indexOf("-")>0 || $('#organ input[name=orgnztSnm]').val().indexOf(".")>0)
			{
				alert("조직 약어에는 \'.\' 나 \'-\'가 들어갈수 없습니다.");
				$('#organ input[name=orgnztSnm]').focus(); 
				return;
			}	
			form.submit();
		
		}
	}
}


-->
</script>
</head>
<a name="noscript" id="noscript">
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
</a>
<body>
<form:form commandName="organ" name="organ" method="post">
<input name="cmd" type="hidden" value="Modify">
<form:hidden path="orgnztId"/>
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
							<li class="stitle">조직등록</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">						
	
						<!-- 게시판 시작  -->
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>조직등록</caption>
		                    <colgroup><col class="col150" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr> 
			                    	<td class="title">조직명</td>
			                    	<td class="pL10" >
								      <form:input  path="orgnztNm" size="60" maxlength="60" id="orgnztNm" cssClass="span_22"/>
								      <form:errors path="orgnztNm"/>			                    	
		                    	</tr>
		                    	<tr> 
			                    	<td class="title">조직약어</td>
			                    	<td class="pL10" >
								      <form:input  path="orgnztSnm" size="60" maxlength="60" id="orgnztNm" cssClass="span_22"/>
								      <form:errors path="orgnztSnm"/>
								   </td>			                    	
		                    	</tr>
		                    	<tr> 
			                    	<td class="title">상위조직</td>
			                    	<td class="pL10" >
								      <input type="hidden" name="bfrCompId" value="${organ.orgUp}" /> 
								      <form:input  path="prntOrgnztNm" cssClass="span_22" readonly="readonly"/> 
								      <form:hidden path="orgUp" /> 
								      <form:errors path="orgUp"/>	
								      <img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="orgGen('prntOrgnztNm','orgUp',1);">		                    	
			                    	</td>
		                    	</tr>
								<tr>
								    <td class="title">조직코드</td>
									<td class="pL10" >${organ.orgnztId}</td>
 								</tr>
 								<tr>
								    <td class="title">조직레벨</td>
									<td class="pL10" >
										<form:input  path="orgLv" size="60" maxlength="60" id="orgLv" cssClass="span_27"  readonly="readonly"/>
										<form:errors path="orgLv" />	
								    </td>								
 								</tr>
 								<tr>
								    <td class="title">조직정렬순서(3자리수)</td>
									<td class="pL10" >
										<form:input  path="ord" size="60" maxlength="60" id="ord" cssClass="span_27"  readonly="readonly"/>
										<form:errors path="ord" />
									</td>
 								</tr> 								
 								<tr>
								    <td class="title">조직설명</td>
									<td class="pL10" >
								      <form:textarea path="orgnztDc" rows="3" cols="60" id="orgnztDc"/>
								      <form:errors   path="orgnztDc"/>									
									</td>
 								</tr> 
 								<tr>
								    <td class="title">수정자</td>
									<td class="pL10">${organ.lastUpdusrId}</td>
 								</tr>  
 								<tr>
								    <td class="title">수정일</td>
									<td class="pL10">${organ.lastUpdusrPnttm}</td>
 								</tr> 
 								<tr>
								    <td class="title">사용여부</td>
									<td class="pL10">
								      <form:select path="useYn">
									      <form:option value="Y" label="Yes"/>
									      <form:option value="N" label="No"/>
								      </form:select>									
									 
									<!-- input type="radio" name="useYn" value="1" checked> 사용 <input type="radio" name="unused" value="2"> 사용안함</td-->
									</td>
 								</tr>
 								<tr>
								    <td class="title">부서장(보직)명칭</td>
									<td class="pL10">
								      <form:input  path="postcpNm" size="60" maxlength="60" id="postcpNm" cssClass="span_19"/>
								      <form:errors path="postcpNm"/>									
								    </td>
 								</tr>
 								<tr>
								    <td class="title">부서장(보직)대행명칭</td>
									<td class="pL10">
								      <form:input  path="postcpRnm" size="60" maxlength="60" id="postcpRnm" cssClass="span_19"/>
								      <form:errors path="postcpRnm"/>									
									</td>
 								</tr>
		                    </tbody>
		                    </table>
						</div>
						<!-- 게시판 끝  -->

						<!-- 목록/저장버튼  -->
						<table border="0" cellspacing="0" cellpadding="0" align="center">
						<tr>
						  <td ><a href="#noscript" onclick="fn_egov_list_CmmnClCode(); return false;"><img src="${imagePath}/admin/btn/btn_list.gif"  style="cursor:hand;"/></a></td>
						  <td width="10"></td>
						  <td><a href="#noscript" onclick="fn_egov_modify_CmmnClCode(document.organ); return false;"><img src="${imagePath}/admin/btn/btn_save.gif"  style="cursor:hand;"/></a></td>
						</tr>
						</table>
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
</form:form>
</body>
</html>