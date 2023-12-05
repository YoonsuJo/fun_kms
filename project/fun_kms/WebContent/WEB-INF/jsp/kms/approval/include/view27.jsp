<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/ajax_inc.jsp"%>
<script>
$(document).ready(function(){
	var templtId = "${appTyp.templtId}";
	var expenseCnt = "${specificVOCnt}";

	//프리셋 정보 숨기기
	$('.expenseViewD').find("tr:eq(0)").hide();
	
	var expenseViewD = $('.expenseViewD:eq(0)').clone();
	var expenseList = eval(${specificVOList});
});
</script>
	
<p class="th_stitle2 mB10">예산 배정 대상자 및 기간</p>
<c:forEach items="${specificVOList}" var="result" varStatus="status">
	<c:if test="${result.expSpend >= 0}">
	
	<div class="boardWrite02 mB10 expenseWriteD">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>수령프로젝트</caption>
		<colgroup>
			<col class="col90" />
			<col class="col150" />
			<col class="col90" />
			<col width="px" />
			<col class="col50" />
		</colgroup>
		<tbody>				
			<tr>
				<td class="title">지급월</td>
				<td class="pL10" colspan="3">
					${result.expDt}
				</td>
			</tr>
			<tr>
				<td class="title">배정프로젝트</td>
				<td class="pL10" colspan="3" >
					<print:project prjId="${result.prjId}" prjCd="${result.prjCd}" prjNm="${result.prjNm}" />					
				</td>
			</tr>
			<tr>
				<td class="title">영업경비</td>
				<td class="pL10">
					<print:currency cost='${result.expSpend }'/>					
				</td>
				<td class="title">비고</td>
				<td class="pL10 pT5 pB5" colspan="2">
					<print:textarea text="${result.expCt}"/>
				</td>
			</tr>
		</tbody>
	</table>
	</div>
	
	</c:if>
</c:forEach>



