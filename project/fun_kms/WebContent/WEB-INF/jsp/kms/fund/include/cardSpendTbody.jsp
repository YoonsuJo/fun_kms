<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../include/ajax_inc.jsp"%>

<c:forEach items="${resultList}" var="result">
	<tr>
		<td class="hidden companyCd">${result.companyCd}</td>
		<td class="txt_center"><label><input type="checkbox" name="checkList" value="${result.cardSpendNo }" class="check" /></label></td>
		<td class="txt_center cardId">${result.cardId}</td>
		<td class="txt_center cardId">${result.companyNm}</td>
		<td class="txt_center"><print:user userNm="${result.userNm}" userNo="${result.userNo}"/></td>
		<td class="txt_center approvalDt"><print:date date="${result.approvalDt}" />
		</td>
		<td class="txt_center approvedSpend"><print:currency cost="${result.approvedSpend}" /></td>
		<td class="txt_center approvalNo">${result.approvalNo}</td>
		<td class="td_last pL10 pR10 storeBusinessNm">${result.storeBusinessNm}</td>
	</tr>
</c:forEach>

