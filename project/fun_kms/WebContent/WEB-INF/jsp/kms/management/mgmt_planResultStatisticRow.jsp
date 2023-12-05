<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../include/ajax_inc.jsp"%>

<c:choose>
	<c:when test="${isSum}">
		<td class="txt_center">합계</td>
		<td class="txt_center">${result.salaryPlanPrint}</td>
		<td class="txt_center">
			<c:if test="${result.salaryPlan < result.salary}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
			${result.salaryPrint}
			<c:if test="${result.salaryPlan < result.salary}"><c:out value='</span>' escapeXml="false"/></c:if>
		</td>
		<td class="txt_center">${result.expensePlanPrint}</td>
		<td class="txt_center">
			<c:if test="${result.expensePlan < result.expense}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
			${result.expensePrint}
			<c:if test="${result.expensePlan < result.expense}"><c:out value='</span>' escapeXml="false"/></c:if>
		</td>
		<td class="txt_center">${result.salaryPlanAccPrint}</td>
		<td class="txt_center">
			<c:if test="${result.salaryPlanAcc < result.salaryAcc}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
			${result.salaryAccPrint}
			<c:if test="${result.salaryPlanAcc < result.salaryAcc}"><c:out value='</span>' escapeXml="false"/></c:if>
		</td>
		<td class="txt_center">${result.expensePlanAccPrint}</td>
		<td class="txt_center">
			<c:if test="${result.expensePlanAcc < result.expenseAcc}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
			${result.expenseAccPrint}
			<c:if test="${result.expensePlanAcc < result.expenseAcc}"><c:out value='</span>' escapeXml="false"/></c:if>
		</td>
		<td class="td_last txt_center">
			<c:if test="${result.overAcc > 0}">
			<span class="txt_red">${result.overAccPrint}<br/><span class="T11">(${result.overAccPercent}%)</span></span>
			</c:if>
			<c:if test="${result.overAcc <= 0}">-</c:if>
		</td>
	</c:when>
	<c:when test="${result.havingLeaf == false}">
		<td class="pL10"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}" length="18"/></td>
		<td class="txt_center"><a href="${rootPath}/management/prjPlanCostDetailList.do?searchPrjId=${result.prjId}&searchYear=${searchVO.searchYear}&searchMonth=${searchVO.searchMonth}&includeResult=${searchVO.includeResult}">${result.salaryPlanPrint}</a></td>
		<td class="txt_center">
			<a href="javascript:prjInput();">
				<c:if test="${result.salaryPlan < result.salary}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
				${result.salaryPrint}
				<c:if test="${result.salaryPlan < result.salary}"><c:out value='</span>' escapeXml="false"/></c:if>
			</a>
		</td>
		<td class="txt_center"><a href="${rootPath}/management/prjPlanCostDetailList.do?searchPrjId=${result.prjId}&searchYear=${searchVO.searchYear}&searchMonth=${searchVO.searchMonth}&includeResult=${searchVO.includeResult}">${result.expensePlanPrint}</a></td>
		<td class="txt_center">
			<a href="javascript:expenseDetail('${result.prjId}','${result.prjNm}')">
				<c:if test="${result.expensePlan < result.expense}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
				${result.expensePrint}
				<c:if test="${result.expensePlan < result.expense}"><c:out value='</span>' escapeXml="false"/></c:if>
			</a>
		</td>
		<td class="txt_center">${result.salaryPlanAccPrint}</td>
		<td class="txt_center">
			<c:if test="${result.salaryPlanAcc < result.salaryAcc}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
			${result.salaryAccPrint}
			<c:if test="${result.salaryPlanAcc < result.salaryAcc}"><c:out value='</span>' escapeXml="false"/></c:if>
		</td>
		<td class="txt_center">${result.expensePlanAccPrint}</td>
		<td class="txt_center">
			<c:if test="${result.expensePlanAcc < result.expenseAcc}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
			${result.expenseAccPrint}
			<c:if test="${result.expensePlanAcc < result.expenseAcc}"><c:out value='</span>' escapeXml="false"/></c:if>
		</td>
		<td class="td_last txt_center">
			<c:if test="${result.overAcc > 0}">
			<span class="txt_red">${result.overAccPrint}<br/><span class="T11">(${result.overAccPercent}%)</span></span>
			</c:if>
			<c:if test="${result.overAcc <= 0}">-</c:if>
		</td>
	</c:when>
	<c:otherwise>
		<td class="txt_center bG02">[${result.prjCd}] 소계</td>
		<td class="txt_center bG02">${result.salaryPlanPrint}</td>
		<td class="txt_center bG02">
			<c:if test="${result.salaryPlan < result.salary}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
			${result.salaryPrint}
			<c:if test="${result.salaryPlan < result.salary}"><c:out value='</span>' escapeXml="false"/></c:if>
		</td>
		<td class="txt_center bG02">${result.expensePlanPrint}</td>
		<td class="txt_center bG02">
			<c:if test="${result.expensePlan < result.expense}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
			${result.expensePrint}
			<c:if test="${result.expensePlan < result.expense}"><c:out value='</span>' escapeXml="false"/></c:if>
		</td>
		<td class="txt_center bG02">${result.salaryPlanAccPrint}</td>
		<td class="txt_center bG02">
			<c:if test="${result.salaryPlanAcc < result.salaryAcc}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
			${result.salaryAccPrint}
			<c:if test="${result.salaryPlanAcc < result.salaryAcc}"><c:out value='</span>' escapeXml="false"/></c:if>
		</td>
		<td class="txt_center bG02">${result.expensePlanAccPrint}</td>
		<td class="txt_center bG02">
			<c:if test="${result.expensePlanAcc < result.expenseAcc}"><c:out value='<span class="txt_red">' escapeXml="false"/></c:if>
			${result.expenseAccPrint}
			<c:if test="${result.expensePlanAcc < result.expenseAcc}"><c:out value='</span>' escapeXml="false"/></c:if>
		</td>
		<td class="td_last txt_center bG02">
			<c:if test="${result.overAcc > 0}">
			<span class="txt_red">${result.overAccPrint}<br/><span class="T11">(${result.overAccPercent}%)</span></span>
			</c:if>
			<c:if test="${result.overAcc <= 0}">-</c:if>
		</td>
	</c:otherwise>
</c:choose>
