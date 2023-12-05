<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/admin/code/codeL.do'/>";
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
	location.href = "/admin/code/codeW.do";
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
function fnDetail(codeId){
	var varForm				 =document.listForm;
	varForm.action           = "<c:url value='/admin/code/codeV.do'/>";
	varForm.codeId.value     = codeId;
	varForm.submit();
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
							<li class="stitle">공통코드 관리</li>
						</ul>
					</div>
					<form name="listForm" action="<c:url value='/admin/code/codeL.do'/>" method="post">
						<input type=hidden name="codeId">
					<span class="stxt">공통코드를 등록, 수정, 목록조회, 상세조회를 제공합니다.</span>
	
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
											<select name="searchCondition" class="select" id="searchCondition">
											   <option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>><label for="searchCondition">코드ID</label></option>
											   <option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>><label for="searchCondition"></label>코드ID명</option>
										   </select>
										<span class="pL7"></span>
										<input name="searchKeyword" type="text" class="search_txt02"  size="35" value="${searchVO.searchKeyword}"  maxlength="35" id="searchCondition">
										<img class="cursorPointer" src="${imagePath}/admin/btn/btn_search02.gif" alt="검색" onclick="fnSearch(); return false;"/>
									</td>
								</tr>
							</tbody>
							</table>
		                    </div>
		                </fieldset>
		                <!-- 상단 검색창 끝 -->
		                
						<!-- 게시판 시작 -->
						<p class="th_stitle">공통코드 목록</p>
						<div class="boardList">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>공통코드</caption>
							<colgroup><col class="col5" /><col class="col40" /><col class="col250" /><col class="col90" /><col width="px" /><col class="col70" /><col class="col5" /></colgroup>
							<thead>
								<tr>
								<th class="th_left"></th>
								<th scope="col">순번</th>
								<th scope="col">분류명</th>
								<th scope="col">코드ID</th>
								<th scope="col">코드ID명</th>
								<th scope="col">사용여부</th>
								<th class="th_right"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
									<tr onclick="javascript:fnDetail('${resultInfo.codeId}');" class="cursorPointer"> 
										<td class="txt_center" colspan="2"><c:out value="${(searchVO.pageIndex - 1) * searchVO.pageSize + status.count}"/></td>
										<td class="txt_center">${resultInfo.clCodeNm}</td>
										<td class="txt_center">${resultInfo.codeId}</td>
										<td class="txt_center">${resultInfo.codeIdNm}</td>
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
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<!-- 하단 숫자 끝 -->
						
						<!-- 버튼 시작 -->
<!-- 		                <div class="btn_area">
		                	<img onclick="fnRegist();" class="cursorPointer" src="${imagePath}/admin/btn/btn_regist.gif"/>
		                </div>
 -->
		                <!-- 버튼 끝 -->	
							
					</div>
					</form>
					
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
