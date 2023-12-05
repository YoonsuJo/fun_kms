<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../include/ajax_inc.jsp"%>

<script>
	$(document).ready( function() {
		 var mode = "${mode}";

		$('#orgnztTreeB,#orgnztNm').click(function(){
			orgGen('orgnztNm','orgnztId',1);

		});
		$('#salesPrjTreeB, #salesPrjNm').click(function(){
			prjGen('salesPrjNm','salesPrjId',1);

		});
		$('#purchasePrjTreeB,#purchasePrjNm').click(function(){
			prjGen('purchasePrjNm','purchasePrjId',1);

		});

		$('#summingUpD').summingUp({
			salesPurchase : $('#salesPurchaseD')
			,laborExpense : $('#laborExpenseD')
			,common : $('#commonD')
			, mode : mode
		});
	});
</script>
<!-- 부서 및 사업기간  -->
<form:form commandName="specificVO" id="specificVO" name="specificVO" method="post" enctype="multipart/form-data" >
<p class="th_stitle2 mB10">부서 및 사업기간</p>
<div class="boardWrite02 mB20">
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col120" />
		<col width="px" />
	</colgroup>
	<tbody>
		<tr>
			<td class="title">부서</td>
			<td class="pL10">
				<input name="orgnztNm" id="orgnztNm" type="text" class="span_12" value="${specificVOList[0].orgnztNm}" readonly="readonly" />
				<input name="orgnztId" id="orgnztId" type="hidden" value="${specificVOList[0].orgnztId}"/>
				<img src="${imagePath}/btn/btn_tree.gif" id="orgnztTreeB" class="cursorPointer"></td>
		</tr>
		<tr>
			<td class="title">기간</td>
			<td class="pL10">
				<select name="year">
					<c:forEach items="${yearList}" var="result">  
						<option value="${result}" <c:if test="${specificVOList[0].year==result}">selected</c:if>>
							${result}
						</option>
					</c:forEach>
					
				</select>
			</td>
		</tr>
	</tbody>
</table>
</div>

<!-- 매출/매입계획  -->
<div id="salesPurchaseD">
<p class="th_stitle2 mB10">매출/매입계획<span class="th_plus02">[단위 : 천원]</span></p>
<div class="boardList02 mB20">
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col120" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
	</colgroup>
	<thead>
		<tr>
			<th></th>
			<th>1월</th>
			<th>2월</th>
			<th>3월</th>
			<th>4월</th>
			<th>5월</th>
			<th class="td_last">6월</th>
		</tr>
	</thead>
	<tfoot>
		<tr>
			<td class="txt_center">매출이익</td>
			<c:forEach begin="0" end="5" varStatus="status">
				<td class="txt_center month${status.current+1} <c:if test='${status.index==5 }'>td_last</c:if>">
					<print:currency cost='${specificVOList[status.index].profitOnSales}' divideBy='1000'/>
				</td>
			</c:forEach>
		</tr>
	</tfoot>
	<tbody>
		<tr>
			<td class="txt_center">매출</td>
			<c:forEach begin="0" end="5" varStatus="status">
				<td class="txt_center" <c:if test="${status.index==5}">td_last</c:if>>
					<input type="text" name="salesList" value ="<print:currency cost='${specificVOList[status.index].sales}' divideBy="1000" printCipher="false"/>"
					class="span_5 currency1000" />
				</td>
			</c:forEach>
			
		</tr>
		<tr>
			<td class="txt_center">매입(사외)</td>
			<c:forEach begin="0" end="5" varStatus="status">
				<td class="txt_center" <c:if test="${status.index==5}">td_last</c:if>
				><input type="text" name="purchaseOutList" value ="<print:currency cost='${specificVOList[status.index].purchaseOut}' divideBy="1000" printCipher="false"/>"
				class="span_5 currency1000" /></td>
			</c:forEach>
		</tr>
		<tr>
			<td class="txt_center">매입(사내)</td>
			<c:forEach begin="0" end="5" varStatus="status">
				<td class="txt_center" <c:if test="${status.index==5}">td_last</c:if>>
					<input type="text" name="purchaseInList" value ="<print:currency cost='${specificVOList[status.index].purchaseIn}' divideBy="1000" printCipher="false"/>"
					class="span_5 currency1000" />
				</td>
			</c:forEach>
		</tr>
	</tbody>
</table>
</div>

<div class="boardList02 mB20">
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col120" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
	</colgroup>
	<thead>
		<tr>
			<th></th>
			<th>7월</th>
			<th>8월</th>
			<th>9월</th>
			<th>10월</th>
			<th>11월</th>
			<th class="td_last">12월</th>
		</tr>
	</thead>
	<tfoot>
		<tr>
			<td class="txt_center">매출이익</td>
			<c:forEach begin="6" end="11" varStatus="status">
				<td class="txt_center month${status.current+1} <c:if test='${status.index==11 }'>td_last</c:if>">
					<print:currency cost='${specificVOList[status.index].profitOnSales}' divideBy='1000'/>
				</td>
			</c:forEach>
		</tr>
	</tfoot>
	<tbody>
		<tr>
			<td class="txt_center">매출</td>
			<c:forEach begin="6" end="11" varStatus="status">
				<td class="txt_center" <c:if test="${status.index==11}">td_last</c:if>>
					<input type="text" name="salesList" value ="<print:currency cost='${specificVOList[status.index].sales}' divideBy="1000" printCipher="false"/>"
					class="span_5 currency1000" />
				</td>
			</c:forEach>
		</tr>
		<tr>
			<td class="txt_center">매입(사외)</td>
			<c:forEach begin="6" end="11" varStatus="status">
				<td class="txt_center" <c:if test="${status.index==11}">td_last</c:if>>
					<input type="text" name="purchaseOutList" value ="<print:currency cost='${specificVOList[status.index].purchaseOut}' divideBy="1000" printCipher="false"/>"
					class="span_5 currency1000" />
				</td>
			</c:forEach>
		</tr>
		<tr>
			<td class="txt_center">매입(사내)</td>
			<c:forEach begin="6" end="11" varStatus="status">
				<td class="txt_center" <c:if test="${status.index==11}">td_last</c:if>>
					<input type="text" name="purchaseInList" value ="<print:currency cost='${specificVOList[status.index].purchaseIn}' divideBy="1000" printCipher="false"/>"
					class="span_5 currency1000" />
				</td>
			</c:forEach>
		</tr>
	</tbody>
</table>
</div>
</div>

<!-- 인건비/판관비 계획  -->
<div id="laborExpenseD">
<p class="th_stitle2 mB10">인건비/판관비 계획<span class="th_plus02">[단위 : 천원]</span></p>
<div class="boardList02 mB20">
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col120" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
	</colgroup>
	<thead>
		<tr>
			<th></th>
			<th>1월</th>
			<th>2월</th>
			<th>3월</th>
			<th>4월</th>
			<th>5월</th>
			<th class="td_last">6월</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td class="txt_center">인건비</td>
			<c:forEach begin="0" end="5" varStatus="status">
				<td class="txt_center" <c:if test="${status.index==5}">td_last</c:if>>
					<input type="text" name="laborList" value ="<print:currency cost='${specificVOList[status.index].labor}' divideBy="1000" printCipher="false"/>"
					class="span_5 currency1000" />
				</td>
			</c:forEach>
			
		</tr>
		<tr>
			<td class="txt_center">판관비</td>
			<c:forEach begin="0" end="5" varStatus="status">
				<td class="txt_center" <c:if test="${status.index==5}">td_last</c:if>
				><input type="text" name="expenseList" value ="<print:currency cost='${specificVOList[status.index].expense}' divideBy="1000" printCipher="false"/>"
				class="span_5 currency1000" /></td>
			</c:forEach>
		</tr>
	</tbody>
</table>
</div>
<div class="boardList02 mB20">
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col120" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
	</colgroup>
	<thead>
		<tr>
			<th></th>
			<th>7월</th>
			<th>8월</th>
			<th>9월</th>
			<th>10월</th>
			<th>11월</th>
			<th class="td_last">12월</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td class="txt_center">인건비</td>
			<c:forEach begin="6" end="11" varStatus="status">
				<td class="txt_center" <c:if test="${status.index==11}">td_last</c:if>>
					<input type="text" name="laborList" value ="<print:currency cost='${specificVOList[status.index].labor}' divideBy="1000" printCipher="false"/>"
					class="span_5 currency1000" />
				</td>
			</c:forEach>
			
		</tr>
		<tr>
			<td class="txt_center">판관비</td>
			<c:forEach begin="6" end="11" varStatus="status">
				<td class="txt_center" <c:if test="${status.index==11}">td_last</c:if>
				><input type="text" name="expenseList" value ="<print:currency cost='${specificVOList[status.index].expense}' divideBy="1000" printCipher="false"/>"
				class="span_5 currency1000" /></td>
			</c:forEach>
		</tr>
	</tbody>
</table>
</div>
</div>


<!-- 공통비 계획 -->
<div id="commonD">
<p class="th_stitle2 mB10">공통비 계획<span class="th_plus02 mB5">[단위 : 천원]</span></p>
<div class="boardWrite02 mB20">
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col150" />
		<col width="px" />
	</colgroup>
	<tbody>
		<tr>
			<td class="title">공통비 부담 프로젝트</td>
			<td class="pL10">
				<input name="salesPrjNm" id="salesPrjNm" class="span_17" readonly="true" value="${specificVOList[0].salesPrjNm}"/>
				<input type="hidden" name="salesPrjId" value="${specificVOList[0].salesPrjId}" id="salesPrjId"/>
				<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" id="salesPrjTreeB"> 
				<!-- <span class="txt_right T11">부서에서 지출하는 공통비는 이 프로젝트의 비용으로처리됩니다.</span> -->
			</td>
		</tr>
		<tr>
			<td class="title">공통비 사용 프로젝트</td>
			<td class="pL10">
				<input name="purchasePrjNm" id="purchasePrjNm" class="span_17" readonly="true" value="${specificVOList[0].purchasePrjNm}"/>
				<input type="hidden" name="purchasePrjId" value="${specificVOList[0].purchasePrjId}" id="purchasePrjId"/>
				<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" id="purchasePrjTreeB">
				<!--  <span class="txt_right T11">회사가 부서로부터 받은 공통비는 이 프로젝트의 수익으로 처리됩니다.</span> -->
			</td>
		</tr>
	</tbody>
</table>
</div>

<div class="boardList02">
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col120" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
	</colgroup>
	<thead>
		<tr>
			<th></th>
			<th>1월</th>
			<th>2월</th>
			<th>3월</th>
			<th>4월</th>
			<th>5월</th>
			<th class="td_last">6월</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td class="txt_center">금액</td>
			<c:forEach begin="0" end="5" varStatus="status">
				<td class="txt_center" <c:if test="${status.index==11}">td_last</c:if>>
					<input type="text" name="purchaseInCommonList" value ="<print:currency cost='${specificVOList[status.index].purchaseInCommon}' divideBy="1000" printCipher="false"/>"
					class="span_5 currency1000" />
				</td>
			</c:forEach>
		</tr>
	</tbody>
</table>
</div>
<div class="boardList02 mB20">
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col120" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
		<col class="col16" />
	</colgroup>
	<thead>
		<tr>
			<th>6월</th>
			<th>7월</th>
			<th>8월</th>
			<th>9월</th>
			<th>10월</th>
			<th>11월</th>
			<th class="td_last">12월</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td class="txt_center">금액</td>
			<c:forEach begin="6" end="11" varStatus="status">				<td class="txt_center" <c:if test="${status.index==11}">td_last</c:if>>
					<input type="text" name="purchaseInCommonList" value ="<print:currency cost='${specificVOList[status.index].purchaseInCommon}' divideBy="1000" printCipher="false"/>"
					class="span_5 currency1000" />
				</td>
			</c:forEach>
		</tr>
	</tbody>
</table>
</div>
</div>

<div id="summingUpD">
<p class="th_stitle2 mB10">종합 <span class="th_plus02">[단위 : 백만원]</span></p>
<div class="boardList02 mB20">
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col width="px" />
		<col class="col40" />
		<col class="col40" />
		<col class="col40" />
		<col class="col40" />
		<col class="col40" />
		<col class="col40" />
		<col class="col40" />
		<col class="col40" />
		<col class="col40" />
		<col class="col40" />
		<col class="col40" />
		<col class="col40" />
		<col class="col50" />
	</colgroup>
	<thead>
		<tr>
			<th>&nbsp;</th>
			<th class="td_last" colspan="13"><span class="year">2011</span>년도</th>
		</tr>
		<tr>
			<th>&nbsp;</th>
			<th>1월</th>
			<th>2월</th>
			<th>3월</th>
			<th>4월</th>
			<th>5월</th>
			<th>6월</th>
			<th>7월</th>
			<th>8월</th>
			<th>9월</th>
			<th>10월</th>
			<th>11월</th>
			<th>12월</th>
			<th class="td_last">합계</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td class="txt_center">매출</td>
			<c:forEach begin="0" end="11" varStatus="status">
				<td class="txt_center sales month${status.count }">
					<print:currency cost='${specificVOList[status.index].sales}' divideBy='1000000'/>
				</td>
			</c:forEach>
			<td class="td_last txt_center sales horizonTotal">
				<print:currency cost="${specificVOSum.sales}" divideBy="1000000"/>
			</td>
		</tr>
		<tr>
			<td class="txt_center">매입(사외)</td>
			<c:forEach begin="0" end="11" varStatus="status">
				<td class="txt_center purchaseOut month${status.count }">
					<print:currency cost='${specificVOList[status.index].purchaseOut}' divideBy='1000000'/>
				</td>
			</c:forEach>
			<td class="td_last txt_center purchaseOut horizonTotal">
				<print:currency cost="${specificVOSum.purchaseOut}" divideBy="1000000"/>
			</td>
		</tr>
		<tr>
			<td class="txt_center">매입(사내)</td>
			<c:forEach begin="0" end="11" varStatus="status">
				<td class="txt_center purchaseIn month${status.count }">
					<print:currency cost='${specificVOList[status.index].purchaseIn}' divideBy='1000000'/>
				</td>
			</c:forEach>
			<td class="td_last txt_center purchaseIn horizonTotal">
				<print:currency cost="${specificVOSum.purchaseIn}" divideBy="1000000"/>
			</td>
		</tr>
		<tr>
			<td class="txt_center bG">매출이익</td>
			<c:forEach begin="0" end="11" varStatus="status">
				<td class="txt_center profitOnSales month${status.count } bG">
					<print:currency cost='${specificVOList[status.index].profitOnSales}' divideBy='1000000'/>
				</td>
			</c:forEach>
			<td class="td_last txt_center profitOnSales horizonTotal bG">
				<print:currency cost="${specificVOSum.profitOnSales}" divideBy="1000000"/>
			</td>
		</tr>
		<tr>
			<td class="txt_center">인건비</td>
			<c:forEach begin="0" end="11" varStatus="status">
				<td class="txt_center labor month${status.count }">
					<print:currency cost='${specificVOList[status.index].labor}' divideBy='1000000'/>
				</td>
			</c:forEach>
			<td class="td_last txt_center labor horizonTotal">
				<print:currency cost="${specificVOList[status.index].labor}" divideBy="1000000"/>
			</td>
		</tr>
		<tr>
			<td class="txt_center">판관비</td>
			<c:forEach begin="0" end="11" varStatus="status">
				<td class="txt_center expense month${status.count }">
					<print:currency cost='${specificVOList[status.index].expense}' divideBy='1000000'/>
				</td>
			</c:forEach>
			<td class="td_last txt_center expense horizonTotal">
				<print:currency cost="${specificVOSum.expense}" divideBy="1000000"/>
			</td>
		</tr>
		<tr>
			<td class="txt_center">공통비</td>
			<c:forEach begin="0" end="11" varStatus="status">
				<td class="txt_center common month${status.count }">
					<print:currency cost="${specificVOList[status.index].purchaseInCommon}" divideBy="1000000"/>
				</td>
			</c:forEach>
			<td class="td_last txt_center common horizonTotal">
				<print:currency cost="${specificVOSum.purchaseInCommon}" divideBy="1000000"/>
			</td>
		</tr>
		<tr>
			<td class="txt_center bG">영업이익</td>
			<c:forEach begin="0" end="11" varStatus="status">
				<td class="txt_center operatingProfit month${status.count} bG">
					<print:currency cost='${specificVOList[status.index].operatingProfit}' divideBy='1000000'/>
				</td>
			</c:forEach>
			<td class="td_last txt_center operatingProfit horizonTotal bG">
				<print:currency cost="${specificVOSum.operatingProfit}" divideBy="1000000"/>
			</td>
		</tr>
	</tbody>
</table>
</div>
</div>
</form:form>