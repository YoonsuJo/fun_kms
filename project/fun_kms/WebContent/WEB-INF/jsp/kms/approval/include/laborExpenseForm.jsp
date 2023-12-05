<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../include/ajax_inc.jsp"%>

<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다." class="tableBottom15">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col60" />
		<col class="col60" />
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
     	<col width="px" />
	</colgroup>
	<thead>
		<tr>
			<th rowspan="2" colspan="2">구분</th>
			<th class="td_last laborExpenseYearTh" colspan="14">2011년도</th>
		</tr>
		<tr>
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
			<th class="T11">합계</th>
			<th class="td_last T11">총합계</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td class="txt_center" rowspan="3">인건비</td>
			<td class="txt_center">기존매출</td>
			<c:forEach begin="1" end="12" varStatus="var">
				<td class="T11 txt_center laborExist month${var.count} plan">-</td>
			</c:forEach>
			<td class="T11 txt_center laborExist horizonTotal">0</td>
			<td class="T11 td_last txt_center laborExist horizonWholeTotal">0</td>
		</tr>

		<tr>
			<td class="txt_center">이관매출</td>
			<c:forEach begin="1" end="12" varStatus="var">
				<td class="T11 txt_center laborInput month${var.count}">-</td>
			</c:forEach>
			<td class="T11 txt_center laborInput horizonTotal">0</td>
			<td class="T11 td_last txt_center laborInput horizonWholeTotal">0</td>
		</tr>
		
		<tr>
			<td class="txt_center bG">소계</td>
			<c:forEach begin="1" end="12" varStatus="var">
				<td class="T11 txt_center bG laborSum month${var.count}">-</td>
			</c:forEach>
			<td class="T11 txt_center bG laborSum horizonTotal">0</td>
			<td class="T11 td_last txt_center bG laborSum horizonWholeTotal">0</td>
		</tr>

		<tr>
			<td class="txt_center" rowspan="3">수행경비</td>
			<td class="txt_center">기존매출</td>
			<c:forEach begin="1" end="12" varStatus="var">
				<td class="T11 txt_center expenseExist month${var.count} plan">-</td>
			</c:forEach>
			<td class="T11 txt_center expenseExist horizonTotal">0</td>
			<td class="T11 td_last txt_center expenseExist horizonWholeTotal">0</td>
		</tr>
		<tr>
			<td class="txt_center">이관매출</td>
			<c:forEach begin="1" end="12" varStatus="var">
				<td class="T11 txt_center expenseInput month${var.count}">-</td>
			</c:forEach>
			<td class="T11 txt_center expenseInput horizonTotal">0</td>
			<td class="T11 td_last txt_center expenseInput horizonWholeTotal">0</td>
		</tr>
		<tr>
			<td class="txt_center bG">소계</td>
			<c:forEach begin="1" end="12" varStatus="var">
				<td class="T11 txt_center bG expenseSum month${var.count}">-</td>
			</c:forEach>
			<td class="T11 txt_center bG expenseSum horizonTotal">0</td>
			<td class="T11 td_last txt_center bG expenseSum horizonWholeTotal">0</td>
		</tr>
	
	</tbody>
</table>
