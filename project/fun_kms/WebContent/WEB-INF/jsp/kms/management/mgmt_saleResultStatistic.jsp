<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript">
function search(i) {
	document.frm.searchYear.value = new Number(document.frm.searchYear.value) + i;

	document.frm.submit();
}

var recalcYn = "${searchVO.searchRecalcYn}";

$(document).ready(function() {

	if (recalcYn == 'Y') {
		<c:forEach items="${resultList}" var="result" varStatus="c">
			$.post("/ajax/laborResultStatistic.do?searchYear=${searchVO.searchYear}&searchMonth=${searchVO.searchMonth}&sectorNo=${result.sectorNo}",
				function(data){
	
					var labor = jsAddComma(roundXL(data/1000000, 1));
					$('#labor_${result.sectorNo}').html(labor);
	
					var planSum = ${result.planSalesOut + result.planSalesIn - result.planPurchaseOut - result.planPurchaseIn - result.planLaborExpense - result.planExpense - result.planCommonExpense};
					var resultSum = ${result.salesIn + result.salesOut - result.purchaseOut - result.purchaseIn - result.expense - result.commonExpense};
					resultSum = parseInt(resultSum) - parseInt(data);
	
					var achv = 0;
					if(planSum != 0){
						achv = parseInt((resultSum/planSum)*100);
						achv = jsAddComma(achv);
						achv = achv + '%';
					}else if(resultSum != 0){
						achv = '-';
					}
					$('#achv_${result.sectorNo}').html(achv);
	
					var sales = ${result.salesIn + result.salesOut};
					var profit = ${result.salesIn + result.salesOut - result.purchaseOut - result.purchaseIn};
					var percent;
					if(sales != 0 && resultSum >= 0){
						percent = (profit / sales) * 100;
	
						// percent 글자 크기 조정
						// percent 천 단위로 콤마
						percent = "<br />" + "<span class='txtB_green2'>(" + roundXL(percent,1) + "%)</span>";
					}else{
						percent = '';
					}
	
					// resultSum 글자 크기 및 색상 조정
					var color = 'txtB_Black2';
					if (resultSum < 0)
						color = 'txtB_red2';
					resultSum = '<span class="' + color + '">' + jsAddComma(roundXL(resultSum/1000000,1)) + '</span>' + percent;
					$('#benf_${result.sectorNo}').html(resultSum);
				}
			);
		</c:forEach>
	}
});
</script>
</head>

<body><div id="pop_regist04" style="width:1020px;height: auto">
 	<div id="pop_top">
 	   <ul>
			<li><img src="../images/inc/pop_bullet.gif" /></li>
			<li class="popTitle">사업부 실적분석</li>
		</ul>
 	</div>
 	<div class="pop_con0">
 		
 		<!-- 상단 검색창 시작 -->
		<form name="frm" action="${rootPath}/management/saleResultStatistic.do" method="POST" onsubmit="search(0); return false;">
		<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
		<input type="hidden" name="searchRecalcYn" value="${searchVO.searchRecalcYn}"/>
		<input type="hidden" name="searchOrgId" id="orgId" value=""/>
		<fieldset>
		<legend>상단 검색</legend>
			<div class="top_search07 mB20">
			<table cellpadding="0" cellspacing="0" >
			<caption>상단 검색</caption>
			<tbody>
				<tr>
					<td>
            	 		<a href="javascript:search(-1);"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
						${searchVO.searchYear}년
						<a href="javascript:search(1);" class="pR10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
					</td>
					<td>
						<c:forEach begin="1" end="12" var="mnth">
						<label><input type="radio" class="radio" name="searchMonth" value="${mnth}" 
							<c:if test="${mnth == searchVO.searchMonth}">checked="checked"</c:if>
							onclick="search(0);"> ${mnth}월</label>
						</c:forEach>
					</td>
				</tr>
			</tbody>
			</table>
            </div>
        </fieldset>
		</form>
       	<!-- 상단 검색창 끝 -->
 		
 		<p class="th_plus02">단위 : 백만원</p>
 		<div class="boardList02 mB20 T11">
		<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
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
        	<col width="px" />
        	<col width="px" />
       	</colgroup>
        <thead>
        	<tr>
        		<th rowspan="3" class="border-blackB border-black">구분</th>
        		<th colspan="7" class="border-blackB border-black">목표</th>
        		<th colspan="7" class="border-blackB border-black">실적</th>
        		<th rowspan="3" class="td_last border-blackB">달성율</th>
        	</tr>
        	<tr>
        		<th class="border-black">매출(외)</th>
        		<th class="border-black">매입(외)</th>
        		<th rowspan="2" class="border-black border-blackB">매출이익</th>
        		<th rowspan="2" class="border-blackB">인건비</th>
        		<th rowspan="2" class="border-blackB">판관비</th>
        		<th rowspan="2" class="border-black border-blackB">공통비</th>
        		<th rowspan="2" class="border-black border-blackB">영업이익<br />(이익율)</th>
        		<th class="border-black">매출(외)</th>
        		<th class="border-black">매입(외)</th>
        		<th rowspan="2" class="border-black border-blackB">매출이익</th>
        		<th rowspan="2" class="border-blackB">인건비</th>
        		<th rowspan="2" class="border-blackB">판관비</th>
        		<th rowspan="2" class="border-black border-blackB">공통비</th>
        		<th rowspan="2" class="border-black border-blackB">영업이익<br />(이익율)</th>
        	</tr>
        	<tr>
        		<th class="border-black border-blackB">매출(내)</th>
        		<th class="border-black border-blackB">매입(내)</th>
        		<th class="border-black border-blackB">매출(내)</th>
        		<th class="border-black border-blackB">매입(내)</th>
        	</tr>
        </thead>
        <tbody>
        	<c:forEach items="${resultList}" var="result" varStatus="c">
        		<tr id="tr_${result.sectorNo}" <c:if test="${result.colorTyp == 'A'}">class="TrBg5"</c:if><c:if test="${result.colorTyp == 'B'}">class="TrBg4"</c:if>>
		         	<td class="pL5 T13B border-black" rowspan="2">${result.sectorNm}</td>
		         	<td class="txt_center T13B"><print:currency divideBy="${divideBy}" printCipher="true" cost="${result.planSalesOut}"/></td>
		         	<td class="txt_center T13B border-black"><print:currency divideBy="${divideBy}" printCipher="true" cost="${result.planPurchaseOut}"/></td>
		         	<td class="txt_center T13B border-black" rowspan="2"><print:currency divideBy="${divideBy}" printCipher="true" cost="${result.planSalesProfit}"/></td>
		         	<td class="txt_center T13B bG" rowspan="2"><print:currency divideBy="${divideBy}" printCipher="true" cost="${result.planLaborExpense}"/></td>
		         	<td class="txt_center T13B" rowspan="2"><print:currency divideBy="${divideBy}" printCipher="true" cost="${result.planExpense}"/></td>
		         	<td class="txt_center T13B border-black" rowspan="2"><print:currency divideBy="${divideBy}" printCipher="true" cost="${result.planCommonExpense}"/></td>
		         	<!-- 
			         	글자 크기 및 색상 조정
			         	천 단위로 퍼센트 콤마
			         	<print:currency divideBy="${divideBy}" printCipher="true" cost="${result.planProfit}"/><br/>(${result.planProfitPercent}%)
		         	-->
		         	<td class="txt_center T13B bG04 border-black" rowspan="2">		         	      			         		
		         	
	       			    <c:choose>
	       					<c:when test="${result.planProfit >= 100000}">
	       						<span class="txtB_Black2">
			         			<print:currency divideBy="${divideBy}" printCipher="true" cost="${result.planProfit}"/>
			         			</span>			         			
	       					</c:when>
	       					<c:when test="${result.planProfit < 100000}">
	       						<spanclass="txtB_red2">
	       						<print:currency divideBy="${divideBy}" printCipher="true" cost="${result.planProfit}"/>
	       						</span>	       						
	       					</c:when>
	       					<c:otherwise>
	       						<print:currency divideBy="${divideBy}" printCipher="true" cost="${result.planProfit}"/>
	       						
	       					</c:otherwise>
	       				</c:choose>	         				
		         			    <c:if test="${result.planProfit > 100000}">
		         					<br/><span class="txtB_green2">(${result.planProfitPercent}%)</span>
		         				</c:if>
		         		        <c:if test="${result.planProfit <= 100000}">
		         					<br/><span class="txtB_green2">(0%)</span>
		         				</c:if>
		         		
	       				
	       				
		         		
		         	</td>
		         	<td class="txt_center T13B"><print:currency divideBy="${divideBy}" printCipher="true" cost="${result.salesOut}"/></td>
		         	<td class="txt_center T13B border-black"><print:currency divideBy="${divideBy}" printCipher="true" cost="${result.purchaseOut}"/></td>
		         	<td class="txt_center T13B border-black" rowspan="2"><print:currency divideBy="${divideBy}" printCipher="true" cost="${result.salesProfit}"/></td>
		         	<td class="txt_center T13B bG" rowspan="2" id="labor_${result.sectorNo}">
		         		<c:choose>
		         			<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
		         			<c:otherwise>
		         				<print:currency divideBy="${divideBy}" printCipher="true" cost="${result.salary}"/>
		         			</c:otherwise>
		         		</c:choose>
		         	</td>
		         	<td class="txt_center T13B" rowspan="2"><print:currency divideBy="${divideBy}" printCipher="true" cost="${result.expense}"/></td>
		         	<td class="txt_center T13B border-black" rowspan="2"><print:currency divideBy="${divideBy}" printCipher="true" cost="${result.commonExpense}"/></td>
		         	<td class="txt_center T13B bG04 border-black" rowspan="2" id="benf_${result.sectorNo}">
		         		<c:choose>
		         			<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
		         			<c:otherwise>
		         				<c:choose>
		         					<c:when test="${result.profit < 100000}">
		         						<span class="txtB_red2"><print:currency divideBy="${divideBy}" printCipher="true" cost="${result.profit}"/></span>
		         					</c:when>
		         					<c:otherwise>
		         						<span class="txtB_Black2"><print:currency divideBy="${divideBy}" printCipher="true" cost="${result.profit}"/></span>
		         					</c:otherwise>
		         				</c:choose>		         		
		         				<c:if test="${result.profit > 100000}">
		         					<br/><span class="txtB_green2">(${result.profitPercent}%)</span>
		         				</c:if>
		         		        <c:if test="${result.profit <= 100000}">
		         					<br/><span class="txtB_green2">(0%)</span>
		         				</c:if>
		         			</c:otherwise>
		         		</c:choose>
		         	</td>
		         	<td class="td_last txt_center T13B" rowspan="2" id="achv_${result.sectorNo}">		         		
		         		 <c:choose>
		         			<c:when test="${searchVO.searchRecalcYn == 'Y'}"><img src="${imagePath}/ico/ajax-loader.gif"/></c:when>
		         			<c:otherwise>
		         				<c:choose>
		         					<c:when test="${result.profit <= 100000 || result.planProfit <= 100000}">
		         						<span class="txt_red">0%</span>
		         					</c:when>
		         					<c:when test="${result.planProfit <= result.profit && result.planProfit < 100000}">
		         						<span class="txt_red">0%</span>
		         					</c:when>		         					
		         					<c:when test="${result.planProfit <= result.profit && result.planProfit >= 100000}">
		         						<span class="txt_blue">${result.achievePercent}%</span>
		         					</c:when>

		         					<c:otherwise>
		         						${result.achievePercent}%
		         					</c:otherwise>
		         				</c:choose>
		         			</c:otherwise>
		         		</c:choose>
		         	</td>
	        	</tr>
	        	<tr <c:if test="${result.colorTyp == 'A'}">class="TrBg5"</c:if><c:if test="${result.colorTyp == 'B'}">class="TrBg4"</c:if>>
		         	<td class="txt_center T13B"><print:currency divideBy="${divideBy}" printCipher="true" cost="${result.planSalesIn}"/></td>
		         	<td class="txt_center T13B border-black"><print:currency divideBy="${divideBy}" printCipher="true" cost="${result.planPurchaseIn}"/></td>
		         	<td class="txt_center T13B"><print:currency divideBy="${divideBy}" printCipher="true" cost="${result.salesIn}"/></td>
		         	<td class="txt_center T13B border-black"><print:currency divideBy="${divideBy}" printCipher="true" cost="${result.purchaseIn}"/></td>
	        	</tr>
        	</c:forEach>			                    			                    	
        </tbody>
        </table>
		</div>
	
 		<div class="pop_btn_area">
            <img src="../../images/btn/btn_close.gif" class="cursorPointer" onclick="window.close();"/>
        </div>
 		
 	</div>
</div>

</body>
</html>
