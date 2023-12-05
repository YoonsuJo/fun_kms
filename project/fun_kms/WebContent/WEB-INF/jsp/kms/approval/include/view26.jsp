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
<!-- 매입  -->
<div class="boardWrite02 mB10 expenseWriteDP">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>지급프로젝트</caption>
		<colgroup>
			<col class="col90" />
			<col width="px" />
			<col class="col50" />
		</colgroup>
		<tbody>				
			<tr>			
				<td class="title">지급프로젝트</td>
				<td class="pL10"> 					
              		<print:project prjId="${salesPrj.prjId}" prjCd="${salesPrj.prjCd}" prjNm="${salesPrj.prjNm}" />
				</td>		
			</tr>
			<tr>
				<td class="title">지급월</td>
				<td class="pL10">
					${salesPrj.expDt}
				</td>
			</tr>
		</tbody>
	</table>
</div>
<!-- 매출  -->	
<c:forEach items="${specificVOList}" var="result" varStatus="status">
		
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
				<td class="title">수령프로젝트</td>
				<td class="pL10" colspan="3" > 
					<print:project prjId="${result.prjId}" prjCd="${result.prjCd}" prjNm="${result.prjNm}" />
				</td>
				<td class="pic">					
				</td>
			</tr>
			<tr>
				<td class="title">팀장경비</td>
				<td class="pL10">
					<print:currency cost='${result.expSpend }'/>
				</td>
				<td class="title">비고</td>
				<td class="pL10 pT5 pB5" colspan="2">
					<span class="span_17 expCt">
						<print:textarea text="${result.expCt}"/>
					</span>					
				</td>
			</tr>
		</tbody>
	</table>
	</div>

</c:forEach>

