<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../include/ajax_inc.jsp"%>

<script>
$(document).ready(function(){
	var templtId = "${appTyp.templtId}";
	var expenseCnt = "${specificVOCnt}";

	//프리셋 정보 숨기기
//	if(templtId!="10")
//	{
		$('.expenseViewD').find("tr:eq(0)").hide();
//	}
	
	var expenseViewD = $('.expenseViewD:eq(0)').clone();
	var expenseList = eval(${specificVOList});
});

</script>
<p class="th_stitle2 mB10">지출총액</p>
<div class="boardWrite02 mB20">
	<table cellpadding="0" cellspacing="0" summary="결제 총액/개인결제 총액을 볼 수 있습니다.">
		<caption>총액 보기</caption>
		<colgroup><col class="col120" /><col width="px" /></colgroup>
		<tbody>
			<tr>
				<td class="title">총 액</td>
				<td class="txt_center txtB_grey"><print:currency cost="${specificVOSum.expSum}"/> 원</td>
			</tr>
			<tr>
				<td class="title">개인결제 총액</td>
				<td class="txt_center txtB_grey"><print:currency cost="${specificVOSum.expSumPP}"/> 원</td>
			</tr>
		</tbody>
	</table>
</div>

<p class="th_stitle2 mB10">상세내역</p>
<!-- 직접입력-회사결제  -->
<c:forEach items="${specificVOList}" var="result" varStatus="status">
<div class="boardWrite02 mB20 expenseViewD">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
                <caption>공지사항 보기</caption>
    <colgroup>
    	<col class="col70" />
    	<col class="col150" />
    	<col class="col70" />
    	<col width="px" />
    	<col class="col70" />
    	<col class="col120" />
   	</colgroup>
   <tbody>
 	   <tr>
        	<td class="pL10 pT5 pB5" colspan="6" >
        	<input disabled="disabled" type="radio" name="expense[${status.index}].presetId" 
        	<c:if test="${empty result.presetId }"> checked</c:if> /> 직접입력
    		<span class="pL7"></span>
    			<input disabled="disabled" name="expense[${status.index}].presetId" type="radio" 
    				<c:if test="${not empty result.presetId }"> checked</c:if>
    			/> 빠른입력
    			<c:if test="${not empty result.presetId }">
	        		<span class="presetNm">
	        			- ${result.presetNm }
	        		</span>
        		</c:if>
        	</td>
       	</tr>
       	<c:if test="${appTyp.templtId==12}">
       		<tr class="diningInfoTr">
				<td class="title">지출금액/부서</td> 
				<td class="pL10" colspan="5" > 
					<ul class="diningInfoUl" style="width : 100%;">
						<c:forEach items="${result.expDiningList}" var="result2" varStatus="status2">
							<li>
								부서명 : ${result2.orgnztNm}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								사용금액 : <print:currency cost="${result2.diningSpend}"/> 
							</li>					
						</c:forEach>
					</ul>
				</td>
			</tr>
       	</c:if> 
       	<c:if test="${appTyp.templtId==13}">
       			<tr class="salesInfoTr">
					<td class="title">매입구분</td> 
					<td class="pL10" colspan="5" > 
						<span class="column1">
							<c:choose>
								<c:when test="${result.column1==1}">외부매입</c:when>
								<c:when test="${result.column1==2}">내부매입</c:when>
							</c:choose>
						</span>
					</td>
				</tr>
				<tr class="salesInfoTr">
					<td class="title">관련매출건</td> 
					<td class="pL10" colspan="5" > 
						<ul style="width : 100%;">
							<a href="${rootPath}/approval/approvalV.do?docId=${result.docId}">
								[${result.docDt}] ${result.salesCt} 
								매출액 :  <print:currency cost="${result.salesSum}"/> 원&nbsp;&nbsp;
							</a>
						</ul>
						<ul class="salesInfoUl">
							<li></li> 
							총 사외매입금액 : <print:currency cost="${result.purchaseOutSum * 1.1}"/>&nbsp;&nbsp; 
						</ul>
						<ul class="salesInfoUl">
							<li></li> 
							기 매입금액 : <print:currency cost="${result.alreadyPurchasedSum}"/>&nbsp;&nbsp; 
						</ul>
						<ul class="salesInfoUl">
							<li></li> 
							※ 기 매입금액은 현재 문서의 금액들을 포함한 금액입니다.(저장, 반려된 문서의 경우 제외) 
						</ul>
					</td> 
				</tr>
       	</c:if> 
       	<tr>
        	<td class="title">결제구분</td>
        	<td class="pL10"  colspan="5">
        		<c:choose>
        			<c:when test="${result.expSpendTyp=='PP'}">개인결제</c:when>
        			<c:when test="${result.expSpendTyp=='CP'}">회사결제</c:when>
        			<c:when test="${result.expSpendTyp=='CC'}">법인카드</c:when>
        			<c:when test="${result.expSpendTyp=='KK'}">체크카드</c:when>
        		</c:choose>
        		<span class="companyPaidS <c:if test="${result.expSpendTyp!='CP'}">hidden</c:if>">
	        		<span class="pL20"></span>
	        			<span class="span_5 payingDueDate txt_blue">지급요청일 : 
	        				<c:choose>
	        					<c:when test="${not empty result.payingDueDate}">
	        						<print:date date="${result.payingDueDate }"/>
	        					</c:when>	
	        					<c:otherwise>
	        						선지급
	        					</c:otherwise>
	        				</c:choose>
	        			</span>
	        		<span class="pL7"></span>
	        	</span>
	        	
	        	<span class="corporateCardS <c:if test="${result.expSpendTyp!='CC'}">hidden</c:if>">
	        		<span class="pL20"></span>카드번호 : <span class="txt_blue cardId">${result.cardId }</span>
	        	</span>
        	</td>
       	</tr>
       	<tr>
        	<td class="title">계정과목</td>
        	<td class="pL10" >
        		<span class="span_6 accNm">
        			${result.prntAccNm}(${result.accNm })
        		</span>
        		
        	</td>
        	<td class="title">프로젝트</td>
        	<td class="pL10" >
        		<span class="prjFnm span_6">
        			<print:project prjId="${result.prjId}" prjNm="${result.prjNm}" prjCd="${result.prjCd}"/>
        		</span>
        	</td>
        	<td class="title">회사구분</td>
        	<td class="pL10" >
        		<span  class="companyNm span_6">
        			${result.companyNm }
        		</span>
        	</td>
       	</tr>
       	<tr>
        	<td class="title">지출일자</td>
        	<td class="pL10" >
        		<span class="span_6 expDt">
        			<print:date date="${result.expDt}"/>
        		</span>
        		<c:if test="${result.expiredDate == 'Y'}">
       				<span class="txt_red">(기한초과)</span>
       			</c:if>
        	</td>
        	<td class="title" rowspan="2">내용</td>
        	<td class="pL10 pT5 pB5" rowspan="2" colspan="3">
        		<span class="span_17 expCt">
        			<print:textarea text="${result.expCt}"/>
        		</span>
        	</td>
       	</tr>
       	<tr>
        	<td class="title">금액</td>
        	<td class="pL10" >
        		<span class="expSpend span_6">
        			<print:currency  cost="${result.expSpend}"/>
        		</span>
       			<c:if test="${result.exceedManage == 'Y'}">
       				<span class="txt_red">(판관비초과)</span>
       			</c:if>
        	</td>
       	</tr>
   		 </tbody>
    </table>
</div>
</c:forEach>
