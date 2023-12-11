<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/admin/codeDetail/codeL.do'/>";
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
function fnRegist(){
	location.href = "/admin/codeDetail/codeW.do";
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fnModify(){
	location.href = "";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fnDetail(codeId, code){
	document.listForm.action           = "<c:url value='/admin/codeDetail/codeV.do'/>";
	document.listForm.codeId.value     = codeId;
	document.listForm.code.value       = code;
	document.listForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){
	// 
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
							<li class="stitle">공통상세코드 관리 ${searchVO.mode }</li>
						</ul>
					</div>
					
					<span class="stxt">공통상세코드 관리는 공통상세코드를 등록, 수정, 목록조회, 상세조회를 제공합니다.</span>
					<form name="listForm" id="listForm" action="<c:url value='/admin/codeDetail/codeL.do'/>" method="post">
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<input type="hidden" name="codeId">
						<input type="hidden" name="code">
						<input type="hidden" name="mode" value="${searchVO.mode}">
					<!-- S: section -->
					<div class="section01">						
	
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<tbody>
								<tr>
									<td class="txt_center">
										<select name="searchCondition" class="select" title="searchCondition">
										  <option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>><label for="searchCondition">코드ID</label></option>
										  <option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>><label for="searchCondition">코드</label></option>
										  <option value='3' <c:if test="${searchVO.searchCondition == '3'}">selected="selected"</c:if>><label for="searchCondition">코드명</label></option>
										 </select>
										 <span class="pL7"></span>
										 <input  class="search_txt02" name="searchKeyword" type="text" size="35" value="${searchVO.searchKeyword}"  maxlength="35" id="searchCondition"> 
										<img class="cursorPointer" onclick="fnSearch();" src="${imagePath}/admin/btn/btn_search02.gif" alt="검색"/>
									</td>
								</tr>
							</tbody>
							</table>
		                    </div>
		                </fieldset>
		                <!-- 상단 검색창 끝 -->
		                
						<!-- 게시판 시작 -->
						<p class="th_stitle">공통상세코드 목록</p>
						<div class="boardList">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>공통상세코드</caption>
							<colgroup><col class="col5" /><col class="col40" /><col class="col150" /><col class="col150" /><col width="px" /><col class="col70" /><col class="col5" /></colgroup>
							<thead>
								<tr>
								<th class="th_left"></th>
								<th scope="col">순번</th>
								<th scope="col">코드ID</th>
								<th scope="col">코드</th>
								<th scope="col">코드명</th>
								<th scope="col">사용여부</th>
								<th class="th_right"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
									<tr class="cursorPointer" onclick="javascript:fnDetail('${resultInfo.codeId}','${resultInfo.code}');">
										<td class="txt_center" colspan="2"><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
										<td class="txt_center">${resultInfo.codeId}</td>
										<td class="txt_center">${resultInfo.code}</td>
										<td class="txt_center">${resultInfo.codeNm}</td>
										<td colspan="2" class="txt_center"><c:if test="${resultInfo.useAt == 'Y'}">사용</c:if><c:if test="${resultInfo.useAt == 'N'}">미사용</c:if></td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						<!-- 게시판 끝  -->
						
						<!-- 하단 숫자 시작 -->
						<div class="paginate">
	                		<ui:pagination paginationInfo = "${paginationInfo}"
								type="image"
								jsFunction="linkPage"
								/>
						</div>
						<!-- 하단 숫자 끝 -->
						
						<!-- 버튼 시작 -->
 <!-- 		              <div class="btn_area">
		                	<a href="#"><img class="cursorPointer" onclick="fnRegist(); return false;" src="${imagePath}/admin/btn/btn_regist.gif"/></a>
		                </div>
 -->
		                <!-- 버튼 끝 -->	
							
					</div>
					<!-- E: section -->
					</form>	
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
