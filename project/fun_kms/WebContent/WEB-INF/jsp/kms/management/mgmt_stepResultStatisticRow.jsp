<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../include/ajax_inc.jsp"%>

	<c:choose>
		<c:when test="${cnt == 1}">
			<td class=" T11B
				<c:if test="${result.typ == 'ORG'}">bul01</c:if>
				<c:if test="${result.typ == 'PRJ'}">bul03</c:if>
				">
				<c:if test="${result.typ == 'ORG'}"><print:org orgnztId="${result.id}" orgnztNm="${result.nm}"/></c:if>
				<c:if test="${result.typ == 'PRJ'}"><print:project prjId="${result.id}" prjNm="${result.nm}"/></c:if>
				전체
				<c:if test="${result.lv != 0}">
				<a href="javascript:back('${result.sn}','${result.lv}');"><img src="${imagePath}/btn/btn_arrow_prev_on.gif"/></a>
				</c:if>
			</td>
		</c:when>
		<c:otherwise>
			<td class="T11
				<c:if test="${result.typ == 'ORG'}">bul02</c:if>
				<c:if test="${prtTyp == 'ORG' && result.typ == 'PRJ'}">bul03</c:if>
				<c:if test="${prtTyp == 'PRJ' && result.typ == 'PRJ' && cnt == 2}">bul03</c:if>
				<c:if test="${prtTyp == 'PRJ' && result.typ == 'PRJ' && cnt > 2}">bul04</c:if>
				">
				<c:if test="${result.typ == 'ORG'}"><print:org orgnztId="${result.id}" orgnztNm="${result.nm}"/></c:if>
				<c:if test="${result.typ == 'PRJ'}"><print:project prjId="${result.id}" prjNm="${result.nm}"/></c:if>
				<c:if test="${result.havingLeaf}">
				<a href="javascript:view('${result.id}','${result.lv}');"><img src="${imagePath}/btn/btn_arrow_next_on.gif"/></a>
				</c:if>
			</td>
		</c:otherwise>
	</c:choose>
	<td class="txt_center  T11B">${result.salesOutPrint}</td>
	<td class="txt_center  T11B">${result.salesInPrint}</td>
	<td class="txt_center  T11B">${result.purchaseOutPrint}</td>
	<td class="txt_center  T11B">${result.purchaseInPrint}</td>
	<td class="txt_center  T11B bG04">
		<c:if test="${result.salesProfit < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
		${result.salesProfitPrint}
		<c:if test="${result.salesProfit < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
	</td>
	<td class="txt_center  T11B">${result.salaryPlanPrint}</td>
<!--	인건비실적-->
	<td class="txt_center  T11B bG">
		<c:if test="${result.salaryPlan < result.salary}"><c:out value='<span class="link">' escapeXml="false"/></c:if>
			<c:if test="${result.typ == 'PRJ'}"><a href="javascript:detail('${result.id}','${result.nm }','Y');"></c:if>
				${result.salaryPrint}
			<c:if test="${result.typ == 'PRJ'}"></a></c:if>
		<c:if test="${result.salaryPlan < result.salary}"><c:out value='</span>' escapeXml="false"/></c:if>
	</td>
	<td class="txt_center  T11B">${result.expensePlanPrint}</td>
	<td class="txt_center  T11B">
		<c:if test="${result.expensePlan < result.expense}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
		${result.expensePrint}
		<c:if test="${result.expensePlan < result.expense}"><c:out value='</span>' escapeXml="false"/></c:if>
	</td>
	<td class="txt_center  T11B bG04">
		<c:if test="${result.busiProfit < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
		${result.busiProfitPrint}
		<c:if test="${result.busiProfit < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
	</td>
	<td class="td_last  T11B txt_center">
		<c:if test="${result.busiProfitAcc < 0}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
		${result.busiProfitAccPrint}
		<c:if test="${result.busiProfitAcc < 0}"><c:out value='</span>' escapeXml="false"/></c:if>
	</td>
	
	
