
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../include/ajax_inc.jsp"%>
<form:form commandName="searchVO" id="searchVO" name="searchVO" method="post" enctype="multipart/form-data" >
<form:hidden path="searchYear" />
<!-- 상단 검색창 시작 -->
<fieldset>
<legend>상단 검색</legend>
<div class="top_search04 mB20">
<table cellpadding="0" cellspacing="0">
	<caption>상단 검색</caption>
	<tbody>
		<tr>
			<td class="pT5">
				<img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지" class="cursorPointer" id="searchYearPrev"/> 
				<span id="searchYearStr">${searchVO.searchYear}년</span> 
				<img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지" class="cursorPointer" id="searchYearNext" /> &nbsp;
				<input id="searchMonth0" name="searchMonth" type="radio" value="0"
					<c:if test="${searchMonth == 0}">checked="checked"</c:if>
				>
				<label for="searchMonth0">전체</label>
				<c:forEach begin="1" end="12" varStatus="status">
					<input id="searchMonth${status.count}" name="searchMonth" type="radio" value="${status.count}"
						<c:if test="${searchMonth == status.count}">checked="checked"</c:if>
					>
					<label for="searchMonth${status.count}">${status.count}월</label>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td class="pT5 search_right">
				<label>카드번호</label> <form:input path="searchCardId" cssClass="input01 span_5" /> 
				<label>사용자</label>
			<form:input path="searchUserNm" cssClass="input01 span_5" />
			<!-- <img  src="${imagePath}/btn/btn_tree.gif" class="search_btn02" /> --> 
				<img src="${imagePath}/btn/btn_search02.gif" class="search_btn02 cursorPointer" alt="검색" id="searchB" /> 
				<!-- <img src="${imagePath}/btn/btn_allview.gif" class="search_btn02 cursorPointer" alt="전체보기" id="showAllB" /> -->
			</td>
		</tr>
	</tbody>
</table>
</div>

</fieldset>
<!--// 상단 검색창 끝 -->

<!-- 게시판 시작  -->
<div class="boardList02 mB20">
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col40" />
		<col class="co50" />
		<col class="col00" />
		<col class="col80" />
		<col class="col80" />
		<col class="col80" />
		<col class="col80" />
		<col width="px" />
	</colgroup>
	<thead>
		<tr>
			<th><label><input type="checkbox" class="check" id="checkAll" /></label></th>
			<th>카드번호</th>
			<th>회사구분</th>
			<th>소유자</th>
			<th>승인일자</th>
			<th>승인금액</th>
			<th>승인번호</th>
			<th class="td_last">가맹점명</th>
		</tr>
	</thead>
	
	<tbody id="cardSpendTbody">
	</tbody>
</table>
</div>
<!--// 게시판 끝  -->
<!-- 버튼 시작 -->
<div class="btn_area">
	<img src="${imagePath}/btn/btn_selectComp.gif" class="cursorPointer" id="sendB" />
	<img src="${imagePath}/btn/btn_close.gif" class="cursorPointer" id="cancleB" />
</div>
<!-- 버튼 끝 -->
</form:form>
