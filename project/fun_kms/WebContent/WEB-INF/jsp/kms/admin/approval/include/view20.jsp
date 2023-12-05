<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../include/ajax_inc.jsp"%>

 <script>

 $(document).ready(function(){
	 var data = ${specificVO};
		$('#salesDocViewD').totalSales({
			mode : "V",
			globalData : data
		});	
 });
 </script>
<!-- 매출  -->
<div id="salesDocViewD">
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
						<span class="salesDoc.decideYn span_12"></span>
					</td>
				</tr>
				<tr>
					<td class="title">매출건명</td>
					<td class="pL10" colspan="3">
						<span class="salesDoc.salesSj span_12"></span>
					</td>
				</tr>
				<tr>
					<td class="title">프로젝트</td>
					<td class="pL10" colspan="3">
							<span class="span_12 salesDoc.sPrjNm"></span> 
					</td>
				</tr>
				<tr>
					<td class="title">계약금</td>
					<td class="pL10">
						<span class="span_9 salesDoc.deposit" /></span>원</td>
					<td class="title">계약기간</td>
					<td class="pL10">
						<span class="span_5 salesDoc.stDt"> </span>
						 ~ 
						<span class="span_5 salesDoc.edDt"> </span>
					</td>
				</tr>
				<tr>
					<td class="title">유지보수비</td>
					<td class="pL10" colspan="3">
						<span class="span_5 salesDoc.maintenance">0</span>원 
						 (<span class="span_2 salesDoc.maintenancePercent">0</span>%)
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<!-- 사외매입  -->
	<div class="boardWrite02 mB20" id="purchaseOutD">
	<p class="th_stitle2 mB10">사외매입 </p>
		<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다." id="purchseOutT">
			<caption>공지사항 보기</caption>
			<colgroup><col class="col70" /><col class="col150" /><col class="col50" /><col width="px" /><col class="col50" /><col class="col120" /><col class="col50" /></colgroup>
			<tbody>
			</tbody>
	  </table>
	</div>
	
	<!-- 사내매입  -->
	<div class="boardWrite02 mB20" id="purchaseInGeneralD">
		<p class="th_stitle2 mB10">
			사내매입 
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
                 	<col width="px" />
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
                		<span class="salesDoc.pPrjNm" class="span_12"></span>
              		</td>
              	</tr>
              </tbody>
        </table>
	</div>
	
	<p class="th_stitle2 mB10">수행인력</p>
	<div class="boardList02 mB20" id="pPrjLaborD">
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
		                		<th class="td_last">매출이익 <br/><span class="T11">(이익률)</span></th>
		                	</tr>
		                </thead>
		                <tbody>
		                	<tr>
		                	<td class="txt_center deposit">0</td>
		                 	<td class="txt_center maintenance">0</td>
		                 	<td class="txt_center bG salesSum">0</td>
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