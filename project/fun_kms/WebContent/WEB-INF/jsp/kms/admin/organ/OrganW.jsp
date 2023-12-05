<%
 /**
  * @Class Name  : OrganW.jsp
  * @Description : OrganW 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2011.09.07   민형식              최초 생성
  *
  *  @author 민형식 
  *  @since 2011.09.07
  *  @version 1.0
  *  @see
  *  
  */
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<title>조직관리 등록</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="organ" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_Organ(){
	location.href = "/admin/organ/OrganList.do";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
 function fn_egov_regist_Organ(form){
	if(!validateOrgan(form)){
		return;
	}else{
		if($('#organ input[name=orgnztSnm]').val().indexOf("-")>=0 ||$('#organ input[name=orgnztSnm]').val().indexOf(".")>=0)
		{
			alert("조직 약어에는 \'.\' 나 \'-\'가 들어갈수 없습니다.");
			$('#organ input[name=orgnztSnm]').focus(); 
			return;
		}
		form.submit();		
	}
}
  $(document).ready(function() {
  });
  
  /* ********************************************************
   * 페이징 처리 함수
   ******************************************************** */
  function linkPage(pageNo){
  	document.listForm.pageIndex.value = pageNo;
  	document.listForm.action = "<c:url value='/admin/organ/OrganList.do'/>";
     	document.listForm.submit();
  }
  /* ********************************************************
   * 조회 처리 
   ******************************************************** */
  function fnSearch(){
  	document.listForm.pageIndex.value = 1;
     	document.listForm.submit();
  }
  /* ********************************************************
   * 등록 처리 함수 
   ******************************************************** */
  function fnRegist(orgnztId,orgLv){
  		var varForm				 = document.all["Form"];
  		varForm.action           = "<c:url value='/admin/organ/OrganRegist.do'/>";
  		varForm.orgUp.value     = orgnztId;
  		varForm.orgnztId.value     = "";
  		varForm.submit();
  }
  /* ********************************************************
   * 수정 처리 함수
   ******************************************************** */
  function fnModify(orgnztId){

  	var varForm				 = document.all["Form"];
  	varForm.action           = "<c:url value='/admin/organ/OrganModify.do'/>";
  	varForm.orgnztId.value     = orgnztId;
  	varForm.submit();
  		
  }
  /* ********************************************************
   * 상세회면 처리 함수
   ******************************************************** */
  function fnDetail(orgnztId){
  	var varForm				 = document.all["Form"];
  	varForm.action           = "<c:url value='/admin/organ/OrganDetail.do'/>";
  	varForm.orgnztId.value     = orgnztId;
  	varForm.submit();
  }
  /* ********************************************************
   * 삭제 처리 함수
   ******************************************************** */
  function fnSelect(orgnztId,orgLv){
  	var varForm				 = document.all["organ"];
  	varForm.orgUp.value     = orgnztId;
  	varForm.orgLv.value     = orgLv+1;

  	$("#dialog").dialog( "close" );  	
  }
</script>
</head>

<body>
<a name="noscript" id="noscript">
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
</a>
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
						<form:form commandName="organ" name="organ" method="post">						
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>조직등록</caption>
		                    <colgroup><col class="col150" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr> 
			                    	<td class="title">조직명</td>
			                    	<td class="pL10" >
								      <form:input  path="orgnztNm" size="60" maxlength="60" id="orgnztNm" cssClass="span_22"/>
								    </td>		                    	
		                    	</tr>
		                    	<tr> 
			                    	<td class="title">조직약어</td>
			                    	<td class="pL10" >
								      <form:input  path="orgnztSnm" size="60" maxlength="60" id="orgnztNm" cssClass="span_22"/>
								   </td>			                    	
		                    	</tr>
		                    	<tr> 
			                    	<td class="title">상위조직</td>
			                    	<td class="pL10" >
								      <form:input  path="prntOrgnztNm" cssClass="span_22" readonly="true"/> 
								      <form:hidden  path="orgUp" /> 
								      <img src="${imagePath}/btn/btn_tree.gif" class="cursorPonter" onclick="orgGen('prntOrgnztNm','orgUp',1)"/>
			                    	</td>
		                    	</tr>
 								<tr>
								    <td class="title">조직설명</td>
									<td class="pL10" >
								      <form:textarea path="orgnztDc" rows="3" cols="60" id="orgnztDc" />
								      <form:errors   path="orgnztDc"/>									
									</td>
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
						<input name="cmd" type="hidden" value="<c:out value='save'/>"/>
						</form:form>		                    
						</div>
						<!-- 게시판 끝  -->
     
						<!-- 목록/저장버튼  -->						
						<table border="0" cellspacing="0" cellpadding="0" align="center">
						<tr>
						  <td ><a onclick="fn_egov_list_Organ(); return false;"><img src="${imagePath}/admin/btn/btn_list.gif"  /></a></td>
						  <td width="10"></td>
						  <td><a onclick="fn_egov_regist_Organ(document.organ);"><img src="${imagePath}/admin/btn/btn_save.gif"  /></a></td>
						</tr>						
						</table>
						<!-- 목록/저장버튼  끝-->

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
