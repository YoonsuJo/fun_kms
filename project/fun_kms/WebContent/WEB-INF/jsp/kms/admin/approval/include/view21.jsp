<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../include/ajax_inc.jsp"%>

<script>
 $(document).ready(function(){
	var data = ${specificVO};
	$('#salesDocViewD').generalSales({
						mode : "V",
						globalData : data
		});
		
	
 });
	
 </script>

<!-- 매출  -->
<p class="th_stitle2 mB10">매출</p>
<div class="boardWrite02 mB20" id="salesDocViewD">
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col120" />
		<col width="px" />
		<col class="col120" />
		<col width="px" />
	</colgroup>
	<tbody>
		<tr>
			<td class="title">구분</td>
			<td class="pL10" colspan="3">
				<span class="salesDoc.decideYn"></span>
				</td>
		</tr>
		<tr>
			<td class="title">매출건명</td>
			<td class="pL10" colspan="3">
				<span class="salesDoc.salesSj"></span>
				</td>
		</tr>
		<tr>
			<td class="title">프로젝트</td>
			<td class="pL10" colspan="3">
				<span class="salesDoc.sPrjNm"></span>
			</td>
		</tr>
		<tr>
			<td class="title">매출액</td>
			<td class="pL10">
				<span class="salesDoc.cost"></span>원
			</td>
			<td class="title">매출일</td>
			<td class="pL10">
				<span class="salesDoc.stDt"></span>
			</td>
		</tr>
	</tbody>
</table>
</div>

<!-- 사외매입  -->
<div class="boardWrite02 mB20" id="purchaseOutViewD">
<p class="th_stitle2 mB10">사외매입 </p>
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col120" />
		<col class="col150" />
		<col class="col120" />
		<col width="px" />
		<col class="col50" />
	</colgroup>
	<tbody>
	</tbody>
</table>
</div>

<!-- 사내매입  -->
<div class="boardWrite02 mB20" id="purchaseInGeneralViewD">
<p class="th_stitle2 mB10">사내매입</p>
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col70" />
		<col class="col150" />
		<col class="col50" />
		<col width="px" />
		<col class="col50" />
		<col class="col70" />
		<col class="col50" />
	</colgroup>
	<tbody>
	</tbody>
</table>
</div>

<!-- 영업경비  -->
<div class="boardWrite02 mB20" id="expenseViewD">
<p class="th_stitle2 mB10">영업경비</p>
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col120" />
		<col width="px" />
		<col class="col120" />
		<col width="px" />
	</colgroup>
	<tbody>
		<tr>
			<td class="title">영업경비</td>
			<td class="pL10"><span class="span_9 cost"></span>원</td>
			<td class="title">비고</td>
			<td class="pL10"><span class="span_9 ct" /></td>
		</tr>
	</tbody>
</table>
</div>

<!-- 종합  -->

<!-- 종합  -->
<div class="boardList02 mB20" id="summingUpViewD">
<p class="th_stitle2 mB10">종합 <span class="th_plus02">[단위 : 원]</span></p>
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
	</colgroup>
	<thead>
		<tr>
			<th>매출</th>
			<th>사외매입</th>
			<th>사내매입</th>
			<th>영업경비</th>
			<th class="td_last">매출이익<br/><span class="T11">(이익률)</span></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td class="txt_center salesSum">0</td>
			<td class="txt_center purchaseOutSum">0</td>
			<td class="txt_center purchaseInSum">0</td>
			<td class="txt_center expenseSum">0</td>
			<td class="td_last txt_center bG">
				<span class="operatingProfit">0</span>
				<br />
				(<span class="operatingProfitPercent T11">0</span>%)
			</td>
		</tr>
	</tbody>
</table>
</div>