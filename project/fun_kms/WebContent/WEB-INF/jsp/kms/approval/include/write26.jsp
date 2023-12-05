<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../../include/ajax_inc.jsp"%>
<script>
//지출결의서 write10.jsp 기준으로 개발
$(document).ready(function(){
	var mode = "${mode}";
	var templtId = "${approvalVO.templtId}";
	var cnt = ${fn:length(specificVOList)+1};
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

//프로젝트 잔액표시
function prjSelect(prjNmObj, prjIdObj){
	
	if(typeof(prjNmObj)=='object')
		prjNmObj = $(prjNmObj);
	else 
		prjNmObj = $('#' + prjNmObj);
	if(typeof(prjIdObj)=='object')
		prjIdObj = $(prjIdObj);
	else
		prjIdObj = $('#' + prjIdObj);
	var expDt = document.getElementById("expDt").value;
	//alert(prjIdObj.val() + prjNmObj.val());	
	if(prjIdObj.val() != '' && expDt != '') {
		$.post("/ajax/approval/selectApprovalTeamExpBudget.do?prjId=" + prjIdObj.val() + "&expDt=" + expDt, function(data){
			data = JSON.parse(data);	
			if(data.length>=1) {
				$.each(data,function(idx,elm){					
					//jsAddComma(elm.salesSum) + '원'
					if(elm.budget == 1000000000){
						document.getElementById("budget").innerHTML = "최상위";
						document.getElementById("spend").innerHTML = "-";
						document.getElementById("remain").innerHTML = "무한";
					} else {
						document.getElementById("budget").innerHTML = jsAddComma(elm.budget);
						document.getElementById("spend").innerHTML = jsAddComma(elm.spend);
						document.getElementById("remain").innerHTML = jsAddComma(elm.remain);
					}
					document.getElementById("remainI").value = elm.remain;
					
				});			
			} else {
				document.getElementById("budget").innerHTML = "0";
				document.getElementById("spend").innerHTML = "0";
				document.getElementById("remain").innerHTML = "0";
				document.getElementById("remainI").value = 0;
			}
		});
	}
};


//수령프로젝트 중복검사
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
				prjNmObj.val('');
				prjIdObj.val('');
				alert("수령프로젝트 중복선택 불가");				
				return false;
			}
			//alert('prjId = ' + prjId1 + ' count = ' + count);			
			//confirm = false;
			//return false;			
		});
	}
};
</script>
<p class="th_stitle2 mB10">매입/매출 프로젝트 및 기간</p>

	<div class="boardWrite02 mB10 expenseWriteDP">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>지급프로젝트</caption>
		<colgroup>
			<col class="col90" />
			<col width="px" />
			<col class="col70" />
			<col width="px" />
			<col class="col70" />
			<col width="px" />
			<col class="col70" />
			<col width="px" />			
		</colgroup>
		<tbody>				
			<tr>			
				<td class="title">지급프로젝트</td>
				<td class="pL10" colspan="7"> 
					<input type="text" class="span_12" name="expense[0].sPrjNm" id="prjNm" readonly="readonly" 
					onclick="prjGen('prjNm', 'prjId', 1, 'null', prjSelect)" onfocus="prjGen('prjNm', 'prjId', 1, null, prjSelect)" 
					value="<print:project prjId="${salesPrj.prjId}" prjCd="${salesPrj.prjCd}" prjNm="${salesPrj.prjNm}" link="N"/>" />
              		<input type="hidden" class="span_12" name="expense[0].sPrjId" id="prjId" value="${salesPrj.prjId}"/>
              		<input type="hidden" class="span_12" name="expense[0].remain" id="remainI" value="0"/>
              		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen('prjNm','prjId',1)" />
				</td>		
			</tr>
			<tr>
				<td class="title">지급월</td>
				<td class="pL10">
					<input type="text" name="expense[0].expDt" id="expDt" class="span_4 calGen" value="${salesPrj.expDt}" onchange="prjSelect('prjNm', 'prjId');"/>
				</td>
				<td class="title">수령금액</td>
				<td class="pL10" id="budget"></td>
				<td class="title">사용금액</td>
				<td class="pL10" id="spend"></td>
				<td class="title">수령잔액</td>
				<td class="pL10" id="remain"></td>
			</tr>
		</tbody>
	</table>
	</div>
	
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
				<td class="title">수령프로젝트</td>
				<td class="pL10" colspan="3" > 
					<input type="text" name="expense[${status.index+1}].prjNm" class="span_12" readonly="readonly" 
					value="<print:project prjId="${result.prjId}" prjCd="${result.prjCd}" prjNm="${result.prjNm}" link="N"/>" /> 
					<input type="hidden" name="expense[${status.index+1}].prjId" value="${result.prjId }"/>
					<img src="${imagePath}/btn/btn_tree.gif" class="expPrjTreeB cursorPointer">	
				</td>
				<td class="pic">
					<img src="${imagePath}/btn/btn_delete04.gif" class="cursorPointer deleteExpenseB">
				</td>
			</tr>
			<tr>
				<td class="title">팀장경비</td>
				<td class="pL10">
					<input type="text" name="expense[${status.index+1}].expSpend" class="span_6 currency" 
					value="<print:currency cost='${result.expSpend }'/>"/>					
				</td>
				<td class="title">비고</td>
				<td class="pL10 pT5 pB5" colspan="2">
					<textarea name="expense[${status.index+1}].expCt" class="span_17 height_35">${result.expCt}</textarea>
				</td>
			</tr>
		</tbody>
	</table>
	</div>
	
	</c:if>
</c:forEach>


<!-- 버튼 시작 -->
<div class="btn_area04 pB30"><img src="${imagePath}/btn/btn_add.gif" id="expenseAddB" class="cursorPointer" /></div>
<!-- 버튼 끝 -->

