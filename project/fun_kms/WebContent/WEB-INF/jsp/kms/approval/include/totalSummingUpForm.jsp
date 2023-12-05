<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../include/ajax_inc.jsp"%>

<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다." class="tableBottom15">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col120" />
     	<col width="px" />
     	<col width="px" />
     	<col width="px" />
     	<col width="px" />
     	<col width="px" />
     	<col width="px" />
     	<col width="px" />
     	<col width="px" />
     	<col width="px" />
     	<col width="px" />
     	<col width="px" />
     	<col width="px" />
     	<col width="px" />
	</colgroup>
	<thead>
		<tr>
			<th>&nbsp;</th>
			<th class="td_last expenseYearTh" colspan="13">2011년도</th>
		</tr>
		<tr>
			<th>&nbsp;</th>
			<th class="T11">1월</th>
			<th class="T11">2월</th>
			<th class="T11">3월</th>
			<th class="T11">4월</th>
			<th class="T11">5월</th>
			<th class="T11">6월</th>
			<th class="T11">7월</th>
			<th class="T11">8월</th>
			<th class="T11">9월</th>
			<th class="T11">10월</th>
			<th class="T11">11월</th>
			<th class="T11">12월</th>
			<th class="td_last T11">합계</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td class="txt_center">매출</td>
			<c:forEach begin="1" end="12" varStatus="var">
				<td class="T11 txt_center sales month${var.count}">-</td>
			</c:forEach>
			<td class="td_last txt_center sales horizonTotal T11">0</td>
		</tr>
		<tr>
			<td class="txt_center">사외매입</td>
			<c:forEach begin="1" end="12" varStatus="var">
				<td class="T11 txt_center purchaseOut month${var.count}">-</td>
			</c:forEach>
			<td class="td_last txt_center purchaseOut horizonTotal T11">0</td>
		</tr>
		<tr>
			<td class="txt_center">사내매입</td>
			<c:forEach begin="1" end="12" varStatus="var">
				<td class="T11 txt_center purchaseInGeneral month${var.count}">-</td>
			</c:forEach>
			<td class="td_last txt_center purchaseInGeneral horizonTotal T11">0</td>
		</tr>
		<tr>
			<td class="txt_center">수행인건비</td>
			<c:forEach begin="1" end="12" varStatus="var">
				<td class="T11 txt_center pPrjLabor month${var.count}">-</td>
			</c:forEach>
			<td class="td_last txt_center pPrjLabor horizonTotal T11">0</td>
		</tr>
		<tr>
			<td class="txt_center">수행경비</td>
			<c:forEach begin="1" end="12" varStatus="var">
				<td class="T11 txt_center pPrjExpense month${var.count}">-</td>
			</c:forEach>
			<td class="td_last txt_center pPrjExpense horizonTotal T11">0</td>
		</tr>
		<tr>
			<td class="txt_center">영업경비</td>
			<c:forEach begin="1" end="12" varStatus="var">
				<td class="T11 txt_center sPrjExpense month${var.count}">-</td>
			</c:forEach>
			<td class="td_last txt_center sPrjExpense horizonTotal T11">0</td>
		</tr>
		<tr>
			<td class="txt_center bG">매출이익</td>
			<c:forEach begin="1" end="12" varStatus="var">
				<td class="T11 txt_center bG profitOnSales month${var.count}">-</td>
			</c:forEach>
			<td class="td_last txt_center bG profitOnSales horizonTotal T11">0</td>
		</tr>
		<tr>
			<td class="txt_center bG">매출이익률</td>
			<c:forEach begin="1" end="12" varStatus="var">
				<td class="T11 txt_center bG"><span class="profitOnSalesPercent month${var.count}">-</span>%</td>
			</c:forEach>
			<td class="td_last txt_center bG T11"><span class="profitOnSalesPercent horizonTotal">0</span>%</td>
		</tr>
	
	</tbody>
</table>
