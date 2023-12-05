<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/ajax_inc.jsp"%>
<script>
var oldPrjNm = '';
var oldPrjId = '';

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
	
	if(mode=="RU" || mode=="RW" || mode=="M")
		checkPrjType();
		
	$('#sPrjTreeGenB,#sPrjNm').click(function(){
		oldPrjNm = $('#salesDocWriteD input[name=salesDoc\\.sPrjNm]').val();
		oldPrjId = $('#salesDocWriteD input[name=salesDoc\\.sPrjId]').val();
		prjGen(
			$('#salesDocWriteD input[name=salesDoc\\.sPrjNm]'),
			$('#salesDocWriteD input[name=salesDoc\\.sPrjId]'),
			1,
			null,
			checkPrjType
		);
	});
	
	$('#salesDocWriteD input').bind("keyup change",function (){
		updateDoc();
	});
});

var thisYear = new Date().getFullYear();
function updateDoc(){
	
	var sPrjId =  $('#salesDocWriteD input[name=salesDoc\\.sPrjId]').val();
	if (sPrjId == "") return false;
	
	var mode = "${mode}";
	if($('#salesDocWriteD input[name=salesDoc\\.stDt]').val().length==8 
			&& $('#salesDocWriteD input[name=salesDoc\\.edDt]').val().length==8) {
		
		var stDt =  $('#salesDocWriteD input[name=salesDoc\\.stDt]').val();
		var edDt = $('#salesDocWriteD input[name=salesDoc\\.edDt]').val();
		if(edDt<stDt) {
			alert("종료일은 시작일보다 먼저일 수 없습니다.");
			$('#salesDocWriteD input[name=salesDoc\\.edDt]').val('');
			$('#salesDocWriteD input[name=salesDoc\\.edDt]').focus();
			return false;
		}
		
		// 전년도 ~ 차년도 까지만 조절 가능.
		if ( parseInt(stDt.substring(0,4)) < (parseInt(thisYear) - 1) ) {
			alert('기간은 전년도 ~ 차년도까지만 선택 가능합니다.');
			$('#salesDocWriteD input[name=salesDoc\\.stDt]').val('');
			$('#salesDocWriteD input[name=salesDoc\\.stDt]').focus();
			return false;
		} else if ( parseInt(edDt.substring(0,4)) > (parseInt(thisYear) + 1) ) {
			alert('기간은 전년도 ~ 차년도까지만 선택 가능합니다.');
			$('#salesDocWriteD input[name=salesDoc\\.edDt]').val('');
			$('#salesDocWriteD input[name=salesDoc\\.edDt]').focus();
			return false;
		}
		
		$('#salesDocWriteD').totalSales({
			stDt : stDt,
			edDt : edDt,
			sPrjId : sPrjId,
			mode : mode
		});
	}
}

// 1. 프로젝트 타입을 체크하여 'P' 수행 구분인 경우에만 진행토록
// 2. 프로젝트 리더, 데이터 바인딩
function checkPrjType() {
	var prjId = $('#salesDocWriteD input[name=salesDoc\\.sPrjId]').val();
	
	// 프로젝트에 할당된 인건비, 수행경비 예산 가져옴
	$.ajax({
		url: "/ajax/selectProjectInfo.do",
		data: {
			prjId: prjId
		},
		type: "POST",
		async: false,
		dataType: "json",
		success: function(data) {
			// 수행 프로젝트가 아닐 경우, 오류메시지
			if (!data.PRJ_TYPE.equals('P')) {
				$('#salesDocWriteD input[name=salesDoc\\.sPrjNm]').val(oldPrjNm);
				$('#salesDocWriteD input[name=salesDoc\\.sPrjId]').val(oldPrjId);
				alert('구분이 [수행] 인 프로젝트만 선택할 수 있습니다.');
				return false;
			}
			$('#salesDocWriteD input[name=salesDoc\\.leaderMix]').val(data.leader_mix);
			updateDoc();
		},
		error: function(xhr, testStatus, errorThrown) {
			alert("프로젝트에 대한 데이터를 가져오는데 실패하였습니다.");
  	 	}
	});
}
</script>
<!-- 매출  -->
<div id="salesDocWriteD">
	<div class="boardWrite02 mB20">
	<p class="th_stitle2 mB10">매출이관 프로젝트 및 기간</p>
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
					<input type="text" name="salesDoc.sPrjNm" id="sPrjNm" class="span_12" readonly="readonly"/> 
						<input type="hidden" name="salesDoc.sPrjId" /> 
						<input type="hidden" name="salesDoc.leaderMix" /> 
						<img src="${imagePath}/btn/btn_tree.gif" id="sPrjTreeGenB" class="cursorPointer">
					</td>
				</tr>
				<tr>
					<td class="title">기간</td>
					<td class="pL10" colspan="3">
						<input type="text" name="salesDoc.stDt" class="span_4 calGen" />
						 ~ 
						 <input type="text" name="salesDoc.edDt" class="span_4 calGen" />
						 <span class="stxt_right"> * 기간은 오늘 기준으로 전년도와 차년도(최대 3년)까지 선택 가능합니다.</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	
	
	<div id="beforeSettingD" class="hidden">
		
		<div class="boardList02 mB20" id="prjLaborExpenseD">
			<p class="th_stitle2 mB10">매출이관 인건비 및 수행경비<span class="th_plus02">[단위 : 천원]</span></p>
		</div>
		
		<!-- 종합  -->
		<div class="boardList02 mB20" id="totalSummingUpD">
			<p class="th_stitle2 mB10">종합 <span class="th_plus02">[단위 : 천원]</span></p>
		</div>
	</div>
</div>