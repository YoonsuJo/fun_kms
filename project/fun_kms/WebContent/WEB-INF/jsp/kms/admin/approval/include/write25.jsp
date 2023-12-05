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
				$('#salesDocWriteD input[name=salesDoc\\.pPrjNm]'),
				$('#salesDocWriteD input[name=salesDoc\\.pPrjId]'),
				1,
				null,
				updateDoc
				);
	});
	
	$('#salesDocWriteD input').bind("keyup change",function (){
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
			var pPrjId =  $('#salesDocWriteD input[name=salesDoc\\.pPrjId]').val();
			var sPrjId =  $('#salesDocWriteD input[name=salesDoc\\.sPrjId]').val();
			$('#salesDocWriteD').totalSales({stDt : stDt,
								edDt :  edDt,
								pPrjId : pPrjId,
								sPrjId : sPrjId,
								mode : mode
			});
		}
	}
 </script>
<!-- 매출  -->
<div id="salesDocWriteD">
	<div class="boardWrite02 mB20">
	<p class="th_stitle2 mB10">매입/매출 프로젝트 및 기간</p>
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
					<td class="title">매입프로젝트</td>
					<td class="pL10" colspan="3">
					<input type="text" name="salesDoc.sPrjNm" id="sPrjNm" class="span_12" readonly="readonly"/> 
						<input type="hidden" name="salesDoc.sPrjId" /> 
						<img src="${imagePath}/btn/btn_tree.gif" id="sPrjTreeGenB" class="cursorPointer">
					</td>
				</tr>
				<tr>
					<td class="title">매출프로젝트</td>
					<td class="pL10" colspan="3">
					<input type="text" name="salesDoc.pPrjNm" id="pPrjNm" class="span_12" readonly="readonly"/> 
						<input type="hidden" name="salesDoc.pPrjId" /> 
						<img src="${imagePath}/btn/btn_tree.gif" id="pPrjTreeGenB" class="cursorPointer">
					</td>
				</tr>
				<tr>
					<td class="title">기간</td>
					<td class="pL10" colspan="3">
						<input type="text" name="salesDoc.stDt" class="span_5 calGen" />
						 ~ 
						 <input type="text" name="salesDoc.edDt" class="span_5 calGen" />
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	
		
	<div id="beforeSettingD" class="hidden">
		
		<div class="boardList02 mB20" id="prjLaborD">
			<p class="th_stitle2 mB10">투입인력
				<span class="th_plus03">
					<input type="text" class="laborUserNm userNamesAuto userValidateCheck" />
					<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer laborUserTreeB"/>
					<img src="${imagePath}/btn/btn_add03.gif" class="cursorPointer laborUserAddB">
				</span>
			</p>
		</div>
		
		<p class="th_stitle2 mB10">판관비<span class="th_plus02">[단위 : 천원]</span></p>
		<div class="boardList02 mB20" id="prjExpenseD">
		</div>
		
			<!-- 종합  -->
		<div class="boardList02 mB20" id="totalSummingUpD">
			<p class="th_stitle2 mB10">종합 <span class="th_plus02">[단위 : 천원]</span></p>
		</div>
	</div>
</div>