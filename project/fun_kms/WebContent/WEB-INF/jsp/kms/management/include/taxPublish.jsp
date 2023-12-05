<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>

<div class="boardList02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>관련 매출건</caption>
	<colgroup>
		<c:if test="${mode=='LIST'}"><col class="col30" /></c:if>
		<col class="col100" />
		<col width="px" />
		<col class="col100" />
		<col class="col80" />
		<col class="col80" />
		<col class="col80" />
	</colgroup>
	<thead>
		<tr class="height_th">
			<c:if test="${mode=='LIST'}"><th>선택</th></c:if>
			<th>발행일</th>
			<th>업체명</th>
			<th>발행회사</th>
			<th>발행금액</th>
			<th>수금액<br/>(VAT 포함)</th>
			<th class="td_last">미수금액<br/>(VAT 포함)</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${taxPublishList}" var="result" varStatus="c">
		<tr>
			<c:if test="${mode=='LIST'}">
				<td class="txt_center"><input type="checkbox" name="bondPrjNo" value="${result.bondPrjNo}"/></td>
			</c:if>
			<td class="txt_center"><print:date date="${result.publishDate}"/></td>
			<td class="txt_center">${result.custNm}</td>
			<td class="txt_center">${result.companyNm} </td>
			<td class="txt_center"><print:currency cost="${result.sumExpense}"/></td>
			<td class="txt_center"><print:currency cost="${result.sumCollection}"/></td>
			<td class="txt_center"><print:currency cost="${result.noCollection}"/></td>
		</tr>
		</c:forEach>
	</tbody>
	</table>
</div>
<!--// 게시판 끝  -->

<!-- 버튼 시작 -->
<div class="btn_area">
<c:if test="${mode=='LIST'}">
	<input type="button" class="btn_gray fr" value="매핑 처리" onclick="saveMapping()"/>
	<input type="button" class="btn_gray fr mR10" value="매핑 추가" onclick="addMapping()"/>
</c:if>
<c:if test="${mode=='DETAIL'}">
	<input type="button" class="btn_gray fr" value="매핑 삭제" onclick="delMapping()"/>
</c:if>
</div>
<!-- 버튼 끝 -->