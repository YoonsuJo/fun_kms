<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../include/ajax_inc.jsp"%>

 <script>
 $(document).ready(function(){
	 var mode = "${mode}";
	 if(mode!="W")
	 {
		 var data = ${specificVO};
		 $('#salesDocWriteD').totalSales({
			 	globalData : data,
				mode : mode
		 	});
	}
		
	$('#sPrjTreeGenB,#sPrjNm').click(function(){
		prjGen(
				$('#salesDocWriteD input[name=salesDoc\\.sPrjNm]'),
				$('#salesDocWriteD input[name=salesDoc\\.sPrjId]'),
				1,
				null,
				updateDoc
				);
	});
	$('#pPrjTreeGenB,#pPrjNm').click(function(){
		prjGen(
				$('#pPrjNm'),
				$('#pPrjId'),
				1,
				null,
				updateDoc
				);
	});

	
	$('#salesDocWriteD input').bind("keyup change",function (){
		jsMakeCurrency($('#salesDocWriteD input[name=salesDoc\\.deposit]').get(0));
		updateDoc();
	});
 });

 function updateDoc(){
	
	 	var mode = "${mode}";
		if($('#salesDocWriteD input[name=salesDoc\\.stDt]').val().length==8 
				&& $('#salesDocWriteD input[name=salesDoc\\.edDt]').val().length==8)
		{
			var stDt =  $('#salesDocWriteD input[name=salesDoc\\.stDt]').val();
			var edDt = $('#salesDocWriteD input[name=salesDoc\\.edDt]').val();
			if(edDt<stDt)
			{
				alert("계약 종료일은 계약 시작일보다 먼저일 수 없습니다.");
				$('#salesDocWriteD input[name=salesDoc\\.edDt]').val('');
				$('#salesDocWriteD input[name=salesDoc\\.edDt]').focus();
			}
			var deposit = jsDeleteComma($('#salesDocWriteD input[name=salesDoc\\.deposit]').val());
			var salesSj  = $('#salesDocWriteD input[name=salesDoc\\.salesSj]').val();
			var sPrjId =  $('#salesDocWriteD input[name=salesDoc\\.sPrjId]').val();
			var pPrjId =  $('#pPrjId').val();
			var decideYn = $('#salesDocWriteD input[name=salesDoc\\.decideYn]:checked').val();
			var maintenancePercent = $('#salesDocWriteD input[name=salesDoc\\.maintenancePercent]').val();
			$('#salesDocWriteD').totalSales({stDt : stDt,
								edDt :  edDt,
								deposit : parseInt(deposit),
								salesSj : salesSj,
								sPrjId : sPrjId,
								pPrjId : pPrjId,
								mode : mode,
								decideYn : decideYn,
								maintenancePercent : maintenancePercent
			});
		}
	}
 </script>
<!-- 매출  -->
<div id="salesDocWriteD">
	<div class="boardWrite02 mB20">
	<p class="th_stitle2 mB10">매출</p>
		<table id="salesDocWriteT" cellpadding="0" cellspacing="0"
			summary="각 게시물의 상세 내용을 볼 수 있습니다.">
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
					<td class="pL10" colspan="3"><input type="text"
						name="salesDoc.salesSj" class="span_12" /></td>
				</tr>
				<tr>
					<td class="title">프로젝트</td>
					<td class="pL10" colspan="3">
					<input type="text" name="salesDoc.sPrjNm" id="sPrjNm" class="span_12" readonly="readonly"/> 
						<input type="hidden" name="salesDoc.sPrjId" /> 
						<img src="${imagePath}/btn/btn_tree.gif" id="sPrjTreeGenB" class="cursorPointer">
					</td>
				</tr>
				<tr>
					<td class="title">계약금</td>
					<td class="pL10"><input type="text" name="salesDoc.deposit" class="span_9" value="0"/> 원</td>
					<td class="title">계약기간</td>
					<td class="pL10">
						<input type="text" name="salesDoc.stDt" class="span_5 calGen" />
						 ~ 
						 <input type="text" name="salesDoc.edDt" class="span_5 calGen" />
					</td>
				</tr>
				<tr>
					<td class="title">매출액/유지보수비</td>
					<td class="pL10" colspan="3">
						<span class="salesDoc.salesSum">0</span>원 / 
						<span class="salesDoc.maintenance">0</span>원  (계약금 *<input type="text" name="salesDoc.maintenancePercent" class="span_1" value="4.0"/>%)
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<!-- 사외매입  -->
	<div id="beforeSettingD" class="hidden">	
		<div class="boardWrite02 mB20" id="purchaseOutD">
		<p class="th_stitle2 mB10">사외매입 <img src="${imagePath}/btn/btn_OutPurchase.gif" id="purchaseOutAddB" class="cursorPointer"></p>
			<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다." id="purchseOutT">
				<caption>공지사항 보기</caption>
					<colgroup>
						<col class="col70" />
						<col class="col150" />
						<col class="col50" />
						<col width="px" />
						<col class="col50" />
						<col class="col120" />
						<col class="col11" />
					</colgroup>
				<tbody>
				</tbody>
		  </table>
		</div>
		
		<!-- 사내매입  -->
		<div class="boardWrite02 mB20" id="purchaseInGeneralD">
			<p class="th_stitle2 mB10">
				사내매입 <img src="${imagePath}/btn/btn_InPurchase.gif" id="purchaseInGeneralAddB" class="cursorPointer" />
			</p>
			<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
                <caption>공지사항 보기</caption>
                      <colgroup>
                   	<col class="col40" />
                   	<col class="col100" />
                   	<col class="col70" />
                   	<col width="px" />
                   	<col class="col50" />
                   	<col class="col120" />
                   	<col class="col40" />
                   	<col width="col120" />
                   	<col class="col11" />
                  	</colgroup>
                <tbody>
                </tbody>
             </table>
		</div>
	
		
		
		<!-- 수행 인건비/판관비 예산  -->
		<p class="th_stitle2 mB10">수행인력/수행경비 투입 프로젝트</p>
		<div class="boardWrite02 mB20">
			<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
                <caption>공지사항 보기</caption>
                <colgroup><col class="col120" /><col width="px" /></colgroup>
                <tbody>
                	<tr>
                 	<td class="title">수행프로젝트</td>
                 	<td class="pL10" >
	                 		<input type="text" id="pPrjNm" name="pPrjNm" class="span_12" readonly="readonly" />
	                 		<input type="hidden" id="pPrjId" name="pPrjId" />
	                 		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" id="pPrjTreeGenB">
                		</td>
                	</tr>
                </tbody>
           </table>
		</div>
		
		<div class="boardList02 mB20" id="pPrjLaborD">
			<p class="th_stitle2 mB10">수행인력
				<span class="th_plus03">
					<input type="text" class="laborUserNm userNamesAuto userValidateCheck" />
					<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer laborUserTreeB"/>
					<img src="${imagePath}/btn/btn_add03.gif" class="cursorPointer laborUserAddB">
				</span>
			</p>
		</div>
		
		
		<p class="th_stitle2 mB10">수행경비<span class="th_plus02">[단위 : 천원]</span></p>
		<div class="boardList02 mB20" id="pPrjExpenseD">
		</div>
		
		<p class="th_stitle2 mB10">영업경비<span class="th_plus02">[단위 : 천원]</span></p>
		<div class="boardList02 mB20" id="sPrjExpenseD">
		</div>
			
			<!-- 요약  -->
		<div class="boardList02 mB20" id="summingUpD">
		<p class="th_stitle2 mB10">요약 <span class="th_plus02">[단위 : 천원]</span></p>
		
			<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                <caption>공지사항 보기</caption>
		                <colgroup>
		                 	<col class="col10" />
		                	<col class="col10" />
		                	<col class="col10" />
		                	<col class="col10" />
		                	<col class="col10" />
		                	<col class="col10" />
		                	<col class="col10" />
		                	<col class="col10" />
		                	<col class="col10" />
		               	</colgroup>
		                <thead>
		                	<tr class="height_th">
		                		<th>계약금</th>
		                		<th>유지보수비</th>
		                		<th>매출액</th>
		                		<th>사외매입</th>
		                		<th>사내매입</th>
		                		<th>수행인건비</th>
		                		<th>수행경비</th>
		                		<th>영업경비</th>
		                		<th>매출이익 <br/><span class="T11">(이익률)</span></th>
		                	</tr>
		                </thead>
		                <tbody>
		                	<tr>
		                	<td class="txt_center deposit">0</td>
		                 	<td class="txt_center maintenance">0</td>
		                 	<td class="txt_center salesSum">0</td>
		                 	<td class="txt_center purchaseOutSum">0</td>
		                 	<td class="txt_center purchaseInSum">0</td>
		                 	<td class="txt_center laborCostSum">0</td>
		                 	<td class="txt_center pPrjExpenseSum">0</td>
		                 	<td class="txt_center sPrjExpenseSum">0</td>
		                 	<td class="txt_center bG td_last"><span class="profitOnSales">0</span> <br/>(<span class="T11 profitOnSalesPercent"></span>%)</td>
		                	</tr>                 			                    			                    	
		                </tbody>
		        </table>
		</div>
			
			<!-- 종합  -->
		<div class="boardList02 mB20" id="totalSummingUpD">
			<p class="th_stitle2 mB10">종합 <span class="th_plus02">[단위 : 천원]</span></p>
		</div>
	</div>
</div>