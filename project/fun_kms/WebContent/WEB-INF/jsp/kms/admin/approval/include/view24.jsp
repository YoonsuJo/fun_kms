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
	<p class="th_stitle2 mB10">예산 승인 대상 프로젝트 및 기간</p>
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
					<td class="title">프로젝트</td>
					<td class="pL10" colspan="3">
						<span class="span_12 salesDoc.prjNm"></span> 
					</td>
				</tr>
				<tr>
					<td class="title">기간</td>
					<td class="pL10" colspan="3">
						<span class="span_5 salesDoc.stDt"> </span>
						 ~ 
						<span class="span_5 salesDoc.edDt"> </span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	
	<p class="th_stitle2 mB10">인력 계획</p>
	<div class="boardList02 mB20" id="prjLaborD">
	</div>
	
	
	<p class="th_stitle2 mB10">판관비 계획<span class="th_plus02">[단위 : 천원]</span></p>
	<div class="boardList02 mB20" id="prjExpenseD">		
	</div>
		
		
		
		<!-- 종합  -->
	<div class="boardList02 mB20" id="totalSummingUpD">
		<p class="th_stitle2 mB10">종합 <span class="th_plus02">[단위 : 천원]</span></p>
	
		
	</div>
</div>