<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../../include/ajax_inc.jsp"%>
<script>
//지출결의서 write10.jsp 기준으로 개발
$(document).ready(function(){
	var mode = "${mode}";
	var templtId = "${approvalVO.templtId}";
	var cnt = 1;	
	var expenseWriteD = $('.expenseWriteD:eq(0)').clone();
	//첫번째 값을 받아 초기화.
	expenseWriteD.find('input[type=text],input[type=hidden],textarea').val('');
	expenseWriteD.find('textarea').html('');
	expenseWriteD.find('[name]').each(function(idx,elm){
		var name = $(elm).attr('name').substring($(elm).attr('name').indexOf(']')+1);
		$(this).attr('name',name);
	});	
	//재기안, 재상신 시작	
	{
		var expenseList = ${specificVOList}; 
		$('.expenseWriteD').each(function(idx,elm){
			$(this).data('nth',idx);
			initialize($(this));
			if(idx==0)
				;
			else
				cnt++;			
		});
	};//재기안, 재상신  끝	
	//추가 버튼 활성화
	$('#expenseAddB').click(function(){
		addExpense();		
	});
	//추가 버튼 기능
	function addExpense(){
		var addedDiv= expenseWriteD.clone();
		//이름 값 바꿔주기.
		addedDiv.find('[name]').each(function(idx,elm){
			var name = $(elm).attr('name');
			$(elm).attr('name',"expense[" + cnt + "]" + name); 
			
		});
		addedDiv.find('[name$=expSpend]').val('0');
		addedDiv.data("nth", cnt);
		addedDiv.insertAfter($('.expenseWriteD').last());
		cnt++;
		initialize(addedDiv);
		return addedDiv;
	}
	
	function initialize(target){
		
		target.find('.expPrjTreeB, input[name$=prjNm]').click(function(){
			prjGen($(this).parent().find("input[name$=prjNm]")
					, $(this).parent().find("input[name$=prjId]")
					//, 1);
					, 1, null, prjSelectR);		
		});
		
		target.find('input[name$=expSpend]').keyup(function(){
			jsMakeCurrency(this);
		});
		
		target.find('.deleteExpenseB').click(function(){
			if($('.expenseWriteD').length<=1) {
				alert("최소 한 개 이상은 작성하셔야 합니다.");
				return;
			}
			var deletedDiv = $(this).closest('div');
			deletedDiv.remove();
		});
	};
});

//예산배정 프로젝트 중복검사
function prjSelectR(prjNmObj, prjIdObj){
	
	if(typeof(prjNmObj)=='object')
		prjNmObj = $(prjNmObj);
	else 
		prjNmObj = $('#' + prjNmObj);
	if(typeof(prjIdObj)=='object')
		prjIdObj = $(prjIdObj);
	else
		prjIdObj = $('#' + prjIdObj);
	
	if(prjIdObj.val() != '') {
		$('.expenseWriteD').each(function(idx, elm){		
			var count = 0;
			var prjId1 = $(elm).find('[name$=prjId]').val();
			$('.expenseWriteD').each(function(idx, elm){
				var prjId2 = $(elm).find('[name$=prjId]').val();				
				if(prjId1 != '' && prjId1 == prjId2)
					count++;
			});

			if(count > 1){				
				//prjNmObj.val('');
				//prjIdObj.val('');
				//alert("수령프로젝트 중복선택 불가");				
				//return false;
			}
			//alert('prjId = ' + prjId1 + ' count = ' + count);			
			//confirm = false;
			//return false;			
		});
	}
};
</script>

<p class="th_stitle2 mB10">예산 배정 대상자 및 기간</p>
<c:forEach items="${specificVOList}" var="result" varStatus="status">
	<c:if test="${result.expSpend >= 0}">
	
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
				<td class="title">지급월</td>
				<td class="pL10" colspan="4">					
					<input type="text" name="expense[${status.index}].expDt" class="span_6 calGen" value="${result.expDt}"/>
				</td>
			</tr>
			<tr>
				<td class="title">배정프로젝트</td>
				<td class="pL10" colspan="3" > 
					<input type="text" name="expense[${status.index}].prjNm" class="span_12" readonly="readonly" 
					value="<print:project prjId="${result.prjId}" prjCd="${result.prjCd}" prjNm="${result.prjNm}" link="N"/>" /> 
					<input type="hidden" name="expense[${status.index}].prjId" value="${result.prjId }"/>
					<img src="${imagePath}/btn/btn_tree.gif" class="expPrjTreeB cursorPointer">	
				</td>
				<td class="pic">
					<img src="${imagePath}/btn/btn_delete04.gif" class="cursorPointer deleteExpenseB">
				</td>
			</tr>
			<tr>
				<td class="title">영업경비</td>
				<td class="pL10">
					<input type="text" name="expense[${status.index}].expSpend" class="span_6 currency" 
					value="<print:currency cost='${result.expSpend }'/>"/>					
				</td>
				<td class="title">비고</td>
				<td class="pL10 pT5 pB5" colspan="2">
					<textarea name="expense[${status.index}].expCt" class="span_17 height_35">${result.expCt}</textarea>
				</td>
			</tr>
		</tbody>
	</table>
	</div>
	
	</c:if>
</c:forEach>


<!-- 버튼 시작 -->
<div class="btn_area04 pB30"><img src="${imagePath}/btn/btn_add.gif"
	id="expenseAddB" class="cursorPointer" /></div>
<!-- 버튼 끝 -->

