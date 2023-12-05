<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../include/ajax_inc.jsp"%>

<c:choose>
	<c:when test="${isSum}">
		<td class="txt_center">합계</td>
		<td class="txt_center">${result.salesOutPrint}</td>
		<td class="txt_center">${result.salesInPrint}</td>
		<td class="txt_center">${result.purchaseOutPrint}</td>
		<td class="txt_center">${result.purchaseInPrint}</td>
		<td class="txt_center">
			<c:if test="${result.salesProfit < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
			${result.salesProfitPrint}
			<c:if test="${result.salesProfit < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
		</td>
		<td class="txt_center">${result.salaryPrint}</td>
		<td class="txt_center">${result.expensePrint}</td>
		<td class="txt_center">
			<c:if test="${result.busiProfit < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
			${result.busiProfitPrint}
			<c:if test="${result.busiProfit < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
		</td>
		<td class="td_last txt_center">
			<c:if test="${result.busiProfitAcc < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
			${result.busiProfitAccPrint}
			<c:if test="${result.busiProfitAcc < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
		</td>
	</c:when>
	<c:when test="${result.havingLeaf == false}">
		<td style="display:none;"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}" length="40"/></td>
		<td style="display:none;"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}" length="18"/></td>
		<td class="pL10"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}" length="18"/></td>
		<td class="txt_center"><a href="javascript:outSale();">${result.salesOutPrint}</a></td>
		<td class="txt_center"><a href="javascript:innerSale('Purchase','${result.prjId}','${result.prjNm}');">${result.salesInPrint}</a></td>
		<td class="txt_center"><a href="javascript:outSale();">${result.purchaseOutPrint}</a></td>
		<td class="txt_center"><a href="javascript:innerSale('Sales','${result.prjId}','${result.prjNm}');">${result.purchaseInPrint}</a></td>
		<td class="txt_center">
			<c:if test="${result.salesProfit < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
			${result.salesProfitPrint}
			<c:if test="${result.salesProfit < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
		</td>
		<td class="txt_center"><a href="javascript:prjInput();">${result.salaryPrint}</a></td>
		<td class="txt_center"><a href="javascript:expenseDetail('${result.prjId}','${result.prjNm}');">${result.expensePrint}</a></td>
		<td class="txt_center">
			<c:if test="${result.busiProfit < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
			${result.busiProfitPrint}
			<c:if test="${result.busiProfit < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
		</td>
		<td class="td_last txt_center">
			<c:if test="${result.busiProfitAcc < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
			${result.busiProfitAccPrint}
			<c:if test="${result.busiProfitAcc < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
		</td>
	</c:when>
	<c:otherwise>
       	<td style="display:none;"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}" length="37"/> 소계</td>
       	<td style="display:none;"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" bracket="Y" length="15"/> 소계</td>
       	<td class="txt_center bG02"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" bracket="Y" length="15"/> 소계</td>
		<td class="txt_center bG02">${result.salesOutPrint}</td>
		<td class="txt_center bG02">${result.salesInPrint}</td>
		<td class="txt_center bG02">${result.purchaseOutPrint}</td>
		<td class="txt_center bG02">${result.purchaseInPrint}</td>
		<td class="txt_center bG02">
			<c:if test="${result.salesProfit < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
			${result.salesProfitPrint}
			<c:if test="${result.salesProfit < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
		</td>
		<td class="txt_center bG02">${result.salaryPrint}</td>
		<td class="txt_center bG02">${result.expensePrint}</td>
		<td class="txt_center bG02">
			<c:if test="${result.busiProfit < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
			${result.busiProfitPrint}
			<c:if test="${result.busiProfit < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
		</td>
		<td class="td_last txt_center bG02">
			<c:if test="${result.busiProfitAcc < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
			${result.busiProfitAccPrint}
			<c:if test="${result.busiProfitAcc < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
		</td>
	</c:otherwise>
</c:choose>

