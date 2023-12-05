
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../include/ajax_inc.jsp"%>
<form:form commandName="searchVO" id="searchVO" name="searchVO" method="post" enctype="multipart/form-data" >

<!-- 게시판 시작  -->
<div class="boardList02 mB20">
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col40" />
		<col class="col50" />
		<col class="col180" />
		<col class="col80" />
		<col class="col80" />
		<col class="col180" />
		<col class="col120" />
		<col width="px" />
	</colgroup>
	<thead>
		<tr>
			<th><label><input type="checkbox" class="check" id="checkAll" /></label></th>
			<th>구분</th>
			<th>품목</th>
			<th>입고일</th>
			<th>입고자</th>
			<th>시리얼넘버</th>
			<th>입고가</th>
			<th class="td_last">비고</th>
		</tr>
	</thead>
	
	<tbody id="cardSpendTbody">
		<c:forEach items="${resultList}" var="result">
			<tr>
				<td class="hidden companyCd">${result.companyCd}</td>
				<td class="txt_center"><label><input type="checkbox" name="checkList" value="${result.no }" class="check" /></label></td>
				<td class="txt_center cardId">
					<c:if test="${result.division == 'H'}">H/W</c:if>
					<c:if test="${result.division == 'S'}">S/W</c:if>
				</td>
				<td class="txt_center itemName">${result.itemName}</td>
				<td class="txt_center inputDate"><print:date date="${result.inputDate}" /></td>
				<td class="txt_center"><print:user userNm="${result.userNm}" userNo="${result.inputUserNo}"/></td>
				<td class="txt_center serialNo">${result.serialNo}</td>
				<td class="txt_center stockPrice"><print:currency cost="${result.expense}" /><input type="hidden" name="stockPrice" id="stockPrice" value="${result.expense}" /></td>
				<td class="td_last pL10 pR10 storeBusinessNm">${result.note}</td>
			</tr>
		</c:forEach>
			<tr>
				<td class="pL5" colspan="2">총 제품금액</td>
				<td class="pL5"><span id="stockPriceSumDisplay"></span><input type="hidden" name="stockPriceSum" id="stockPriceSum"/></td>
				<td class="pL5">부가세</td>
				<td class="pL5" colspan="2"><input type="text" name="stockPriceTax" id="stockPriceTax" /></td>
				<td class="pL5">합계</td>
				<td class="td_last pL5"><span id="stockPriceTotalSumDisplay"></span><input type="hidden" name="stockPriceTotalSum" id="stockPriceTotalSum"/></td>
			</tr>
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
