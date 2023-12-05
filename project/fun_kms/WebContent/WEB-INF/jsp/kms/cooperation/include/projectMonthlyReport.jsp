<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>


<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
<caption>월별실적</caption>
<colgroup>
	<col class="col100" />
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
	<col class="col55" />
</colgroup>
<thead>
	<tr>
		<th>구분</th>
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
		<th class="td_last T11">전체누계</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td class="txt_center">사외매출</td>
		<c:set var="sum" value="0"/>
		<c:forEach items="${resultList}" var="result" varStatus="status">
			<td class="txt_center T11">
				<print:currency cost="${result.salesOut }" divideBy="1000"/> 
				<c:set var="sum" value="${sum+result.salesOut}"/>
			</td>
		</c:forEach>
		<td class="txt_center T11">
			<print:currency cost="${sum}" divideBy="1000"/>
		</td>
		<td class="td_last txt_center T11">
			<print:currency cost="${sum+resultPreYearSum.salesOut}" divideBy="1000"/>
		</td>
	</tr>
	<tr>
		<td class="txt_center">사내매출</td>
		<c:set var="sum" value="0"/>
		<c:forEach items="${resultList}" var="result" varStatus="status">
			<td class="txt_center T11">
				<print:currency cost="${result.salesIn }" divideBy="1000"/> 
				<c:set var="sum" value="${sum+result.salesIn}"/>
			</td>
		</c:forEach>
		<td class="txt_center T11">
			<print:currency cost="${sum}" divideBy="1000"/>
		</td>
		<td class="td_last txt_center T11">
			<print:currency cost="${sum+resultPreYearSum.salesIn}" divideBy="1000"/>
		</td>
	</tr> 
	<tr>
		<td class="txt_center">사외매입</td>
		<c:set var="sum" value="0"/>
		<c:forEach items="${resultList}" var="result" varStatus="status">
			<td class="txt_center T11">
				<print:currency cost="${result.purchaseOut }" divideBy="1000"/> 
				<c:set var="sum" value="${sum+result.purchaseOut}"/>
			</td>
		</c:forEach>
		<td class="txt_center T11">
			<print:currency cost="${sum}" divideBy="1000"/>
		</td>
		<td class="td_last txt_center T11">
			<print:currency cost="${sum+resultPreYearSum.purchaseOut}" divideBy="1000"/>
		</td>
	</tr>
	<tr>
		<td class="txt_center">사내매입</td>
		<c:set var="sum" value="0"/>
		<c:forEach items="${resultList}" var="result" varStatus="status">
			<td class="txt_center T11">
				<print:currency cost="${result.purchaseIn }" divideBy="1000"/> 
				<c:set var="sum" value="${sum+result.purchaseIn}"/>
			</td>
		</c:forEach>
		<td class="txt_center T11">
			<print:currency cost="${sum}" divideBy="1000"/>
		</td>
		<td class="td_last txt_center T11">
			<print:currency cost="${sum+resultPreYearSum.purchaseIn}" divideBy="1000"/>
		</td>
	</tr> 
	<tr>
		<td class="txt_center bG">매출이익</td>
		<c:set var="sum" value="0"/>
		<c:forEach items="${resultList}" var="result" varStatus="status">
			<td class="txt_center bG T11">
				<print:currency cost="${result.salesProfit }" divideBy="1000"/> 
				<c:set var="sum" value="${sum+result.salesProfit}"/>
			</td>
		</c:forEach>
		<td class="txt_center bG T11">
			<print:currency cost="${sum}" divideBy="1000"/>
		</td>
		<td class="td_last txt_center bG T11">
			<print:currency cost="${sum+resultPreYearSum.salesProfit}" divideBy="1000"/>
		</td>
	</tr>
	<tr>
		<td class="txt_center">인건비</td>
		<c:set var="sum" value="0"/>
		<c:forEach items="${resultList}" var="result" varStatus="status">
			<td class="txt_center T11">
				<a href="${rootPath}/management/MonthLaborResultOfProject.do?searchYear=${result.searchYear}&searchMonth=${result.searchMonth}&searchPrjId=${searchVO.prjId}&searchPrjNm=${searchVO.prjNm}">
					<print:currency cost="${result.salary }" divideBy="1000"/> 
					<c:set var="sum" value="${sum+result.salary}"/>
				</a>
			</td>
		</c:forEach>
		<td class="txt_center T11">
			<print:currency cost="${sum}" divideBy="1000"/>
		</td>
		<td class="td_last txt_center T11">
			<print:currency cost="${sum+resultPreYearSum.salary}" divideBy="1000"/>
		</td>
	</tr> 
	<tr>
		<td class="txt_center">판관비</td>
		<c:set var="sum" value="0"/>
		<c:forEach items="${resultList}" var="result" varStatus="status">
			<td class="txt_center T11">
				<a href="${rootPath}/management/selectExpenseStatistic.do?searchPrjId=${searchVO.prjId}&searchYear=${result.searchYear}&searchCondition=3&includeCost=N&includeExp=Y">
					<print:currency cost="${result.expense }" divideBy="1000"/> 
					<c:set var="sum" value="${sum+result.expense}"/>
				</a>
			</td>
		</c:forEach>
		<td class="txt_center T11">
			<a href="javascript:selectExpenseStatistic(${resultList[0].searchYear});">
				<print:currency cost="${sum}" divideBy="1000"/>
			</a>
		</td>
		<td class="td_last txt_center T11">
			<print:currency cost="${sum+resultPreYearSum.expense}" divideBy="1000"/>
		</td>
	</tr> 
	<tr>
		<td class="txt_center bG">영업이익</td>
		<c:set var="sum" value="0"/>
		<c:forEach items="${resultList}" var="result" varStatus="status">
			<td class="txt_center bG T11">
				<print:currency cost="${result.busiProfit }" divideBy="1000"/> 
				<c:set var="sum" value="${sum+result.busiProfit}"/>
			</td>
		</c:forEach>
		<td class="txt_center bG T11">
			<print:currency cost="${sum}" divideBy="1000"/>
		</td>
		<td class="td_last txt_center bG T11">
			<print:currency cost="${sum+resultPreYearSum.busiProfit}" divideBy="1000"/>
		</td>
	</tr>			  																	
</tbody>
</table>