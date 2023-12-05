<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../include/ajax_inc.jsp"%>

<script>

 $(document).ready(function(){
	 var mode = "${mode}";
	 if(mode!="W")
	 {
		 var data = ${specificVO};
		 $('#salesDocWriteD').generalSales({
			 	globalData : data,
				mode : mode
		 	});
	}
		
	function updateDoc (){
		if($('#salesDocWriteD input[name=salesDoc\\.stDt]').val().length==8)
		{
			var stDt =  $('#salesDocWriteD input[name=salesDoc\\.stDt]').val().substr(0,8);
			var cost = jsDeleteComma($('#salesDocWriteD input[name=salesDoc\\.cost]').val());
			var sPrjId =  $('#salesDocWriteD input[name=salesDoc\\.sPrjId]').val();
			var salesSj  = $('#salesDocWriteD input[name=salesDoc\\.salesSj]').val();
			var decideYn = $('#salesDocWriteD input[name=salesDoc\\.decideYn]:checked').val();
			$('#salesDocWriteD').generalSales({stDt : stDt,
								cost : parseInt(cost),
								sPrjId : sPrjId,
								salesSj : salesSj,
								mode : mode,
								decideYn : decideYn
			});
		}
	
	};
	
	$('#salesDoc\\.prjTreeB, [name=salesDoc\\.sPrjNm]').click(function(){
		prjGen($('[name=salesDoc\\.sPrjNm]'),$('[name=salesDoc\\.sPrjId]'),1,null,updateDoc);
	});
		
	$('#salesDocWriteD input').bind("keyup change",function (){
		jsMakeCurrency($('#salesDocWriteD input[name=salesDoc\\.cost]').get(0));
		updateDoc();
	});

 });
	
 </script>

<!-- 매출  -->
<div id="salesDocWriteD">
	<p class="th_stitle2 mB10">매출</p>
	<div class="boardWrite02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>공지사항 보기</caption>
		<colgroup>
			<col class="col120" />
			<col width="px" />
			<col class="col120" />
			<col width="px" />
		</colgroup>
		<tbody>
			<tr>
				<td class="title">구분</td>
				<td class="pL10" colspan="3">
					<input type="radio" name="salesDoc.decideYn" value="N" /> 예상
					<input type="radio" name="salesDoc.decideYn" value="Y" checked/> 확정
				</td>
			</tr>
			<tr>
				<td class="title">매출건명</td>
				<td class="pL10" colspan="3"><input type="text" name="salesDoc.salesSj"
					class="span_12" /></td>
			</tr>
			<tr>
				<td class="title">프로젝트</td>
				<td class="pL10" colspan="3">
					<input type="text" name="salesDoc.sPrjNm" class="span_12" readonly="readonly"/>
					<input type="hidden" name="salesDoc.sPrjId"/>
					 <img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" id="salesDoc.prjTreeB" >
				</td>
			</tr>
			<tr>
				<td class="title">매출액</td>
				<td class="pL10"><input type="text" name="salesDoc.cost" class="span_9" value="0"/>
				원</td>
				<td class="title">매출일</td>
				<td class="pL10"><input type="text" name="salesDoc.stDt"
					class="span_9 calGen" /></td>
			</tr>
		</tbody>
	</table>
	</div>
	<div id="beforeSettingD" class="hidden">	
		<!-- 사외매입  -->
		<div class="boardWrite02 mB20" id="purchaseOutWriteD">
		<p class="th_stitle2 mB10">사외매입 <img src="${imagePath}/btn/btn_OutPurchase.gif" id="purchaseOutAddB" class="cursorPointer"></p>
		<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			<caption>공지사항 보기</caption>
			<colgroup>
				<col class="col120" />
				<col class="col150" />
				<col class="col120" />
				<col width="px" />
				<col class="col50" />
			</colgroup>
			<tbody>
			</tbody>
		</table>
		</div>
		
		<!-- 사내매입  -->
		<div class="boardWrite02 mB20" id="purchaseInGeneralWriteD">
		<p class="th_stitle2 mB10">
			사내매입 <img src="${imagePath}/btn/btn_InPurchase.gif" id="purchaseInGeneralAddB" class="cursorPointer" />
		</p>
		<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			<caption>공지사항 보기</caption>
			<colgroup>
				<col class="col70" />
				<col class="col150" />
				<col class="col50" />
				<col width="px" />
				<col class="col50" />
				<col class="col70" />
				<col class="col50" />
			</colgroup>
			<tbody>
			</tbody>
		</table>
		</div>
		
		<!-- 영업경비  -->
		<div class="boardWrite02 mB20" id="expenseWriteD">
		<p class="th_stitle2 mB10">영업경비</p>
		<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			<caption>공지사항 보기</caption>
			<colgroup>
				<col class="col120" />
				<col width="px" />
				<col class="col120" />
				<col width="px" />
			</colgroup>
			<tbody>
				<tr>
					<td class="title">영업경비</td>
					<td class="pL10"><input type="text" name="expense.cost" class="span_9" value="0"/>
					원</td>
					<td class="title">비고</td>
					<td class="pL10"><input type="text" name="expense.ct" class="span_9" /></td>
				</tr>
			</tbody>
		</table>
		</div>
		
		<!-- 종합  -->
		<div class="boardList02 mB20" id="summingUpWriteD">
		<p class="th_stitle2 mB10">종합 <span class="th_plus02">[단위 : 원]</span></p>
			<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
				<caption>공지사항 보기</caption>
				<colgroup>
					<col class="col16" />
					<col class="col16" />
					<col class="col16" />
					<col class="col16" />
					<col class="col16" />
				</colgroup>
				<thead>
					<tr>
						<th>매출</th>
						<th>사외매입</th>
						<th>사내매입</th>
						<th>영업경비</th>
						<th class="td_last">매출이익<br/><span class="T11">(이익률)</span></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="txt_center salesSum">0</td>
						<td class="txt_center purchaseOutSum">0</td>
						<td class="txt_center purchaseInSum">0</td>
						<td class="txt_center expenseSum">0</td>
						<td class="td_last txt_center bG">
							<span class="operatingProfit">0</span>
							<br />
							(<span class="operatingProfitPercent T11">0</span>%)
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>