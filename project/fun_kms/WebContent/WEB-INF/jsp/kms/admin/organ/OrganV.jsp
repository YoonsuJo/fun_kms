<%
 /**
  * @Class Name  : OrganV.jsp
  * @Description : OrganV 화면
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>조직관리 상세조회</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 초기화
 ******************************************************** */
function fnInit(){
}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fnList(){
	location.href = "/admin/organ/OrganList.do";
}
/* ********************************************************
 * 수정화면으로  바로가기
 ******************************************************** */
function fnModify(){
	var varForm				 = document.all["Form"];
	varForm.action           = "<c:url value='/admin/organ/OrganModify.do'/>";
	varForm.orgnztId.value     = "${result.orgnztId}";
	varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){
	if (confirm("<spring:message code="common.delete.msg" />")) {
		var varForm				 = document.all["Form"];
		varForm.action           = "<c:url value='/admin/organ/OrganRemove.do'/>";
		varForm.orgnztId.value     = "${result.orgnztId}";
		varForm.submit();
	}
}
-->
</script>
</head>
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
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>조직등록</caption>
		                    <colgroup><col class="col150" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr> 
			                    	<td class="title">조직명</td>
			                    	<td class="pL10" >${result.orgnztNm}</td>
		                    	</tr>
		                    	<tr> 
			                    	<td class="title">조직약어</td>
			                    	<td class="pL10" >${result.orgnztSnm}</td>
		                    	</tr>
		                    	<tr> 
			                    	<td class="title">상위조직</td>
			                    	<td class="pL10" >${result.prntOrgnztNm}</td>
		                    	</tr>
								<tr>
								    <td class="title">조직코드</td>
									<td class="pL10" >${result.orgnztId}</td>
 								</tr>
 								<tr>
								    <td class="title">조직레벨</td>
									<td class="pL10" >${result.orgLv}</td>
 								</tr>
 								<tr>
								    <td class="title">조직정렬순서</td>
									<td class="pL10" >${result.ord}</td>
 								</tr>
 								<tr>
								    <td class="title">조직설명</td>
									<td class="pL10" >
									<textarea class="textarea"  cols="75" rows="14"  style="width:450px;" disabled="disabled" title="${result.orgnztDc}">${result.orgnztDc}</textarea>									
									</td>
 								</tr> 								
 								<tr>
								    <td class="title">사용여부</td>
									<td class="pL10">
										<select name="useAt" disabled="disabled" id="useAt">
											<option value="Y" <c:if test="${result.useYn == 'Y'}">selected="selected"</c:if> >Yes</option>
											<option value="N" <c:if test="${result.useYn == 'N'}">selected="selected"</c:if> >No</option>				
										</select>    	
									</td>								
 								</tr>
 								<tr>
								    <td class="title">부서장(보직)명칭</td>
									<td class="pL10">${result.postcpNm}</td>
 								</tr>
 								<tr>
								    <td class="title">부서장(보직)대행명칭</td>
									<td class="pL10">${result.postcpRnm}</td>
 								</tr>
		                    </tbody>
		                    </table>
						</div>
						
						<p class="th_stitle">수정이력</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>수정이력</caption>
							<colgroup><col class="col5" /><col class="col150" /><col width="px" /><col class="col150" /><col class="col150" /><col class="col150" /><col class="col5" /></colgroup>
							<thead>
								<tr>
								<th class="th_left"> </th>
								<th scope="col">처리</th>
								<th scope="col">사용자</th>
								<th scope="col">조직명</th>
								<th scope="col">사용여부</th>
								<th scope="col">날짜</th>
								<th class="th_right"> </th>
								</tr>
							</thead>
							<tbody> 
							
								<c:forEach items="${resultHis}" var="resultH" varStatus="status">							
								<tr>
									<td class="txt_center" colspan="2">${resultH.orgStat}</td>
									<td class="txt_center">${resultH.lastUpdusrId}</td>
									<td class="txt_center">${resultH.orgnztNm}</td>
									<td class="txt_center">
									<c:if test="${resultH.useYn eq 'Y'}">예</c:if>
									<c:if test="${resultH.useYn eq 'N'}">아니오</c:if>
									</td>
									<td colspan="2" class="txt_center">${resultH.lastUpdusrPnttm}</td>
								</tr>
								</c:forEach>
															

							</tbody>
							</table>
						</div>
						<!-- 게시판 끝  -->					
 
<table border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
  <td><a href="#noscript" onclick="fnModify(); return false;"><img src="${imagePath}/admin/btn/btn_modify.gif"/></a></td>
  <td width="10"></td>
  <td><a href="#noscript" onclick="fnDelete(); return false;"><img src="${imagePath}/admin/btn/btn_delete.gif"/></a></td>
  <td width="10"></td>  
  <td><a href="#noscript" onclick="fnList(); return false;"><img src="${imagePath}/admin/btn/btn_list.gif"/></a></td>
</tr>						
</table>

<form name="Form" method="post">
	<input name="orgnztId" type="hidden">
	<!-- input type="submit" id="invisible" class="invisible"/--> 
</form>


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