<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../../include/ajax_inc.jsp"%>
<script>
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
		//프리셋 선택창 외에는 disable을 풀어줌.
		if(name.indexOf('presetIdSelector')<0)
			$(this).removeAttr('disabled');
		$(this).siblings('.companyPaidS').hide();
		$(this).siblings('.corporateCardS').hide();
		
	});

	/*추가 tr생성*/
	if(templtId == "12") {
		//부서 정보 기입란 생성
		var diningInfoUl = $('<li>'+
							'부서:&nbsp;&nbsp;'+
							'<input type="text" name="expense[${status.index}].expDiningOrgnztNm[]" class="span_9"  readonly="readonly"/>&nbsp;' +
							'<input type="hidden" name="expense[${status.index}].expDiningOrgnztId[]"/>' +
							'<img src="${imagePath}/btn/btn_tree.gif" class="expDiningOrgnztTreeB cursorPointer"> ' +   
							'금액 :&nbsp;&nbsp;' + 
							'<input type="text" name="expense[${status.index}].expDiningSpend[]" class="span_9 currency" value="0" />' +
						'</li>');
		
		//부서 추가 버튼 활성화
		$('.diningOrgnztAddB').live("click",function() {
			var addedDiningInfoUl= diningInfoUl.clone();
			var nth = $(this).closest('.expenseWriteD').data("nth");
			//name값을 적절히 변경
			addedDiningInfoUl.find("[name]").each(function(){
				$(this).attr("name","expense[" + nth + "]" + $(this).attr('name').substring($(this).attr('name').indexOf(']')+1));
			});
			addedDiningInfoUl.appendTo($(this).closest('div').find('.diningInfoUl'));
		});
	
		//부서 트리 버튼 활성화
		$('.expDiningOrgnztTreeB,[name*=expDiningOrgnztNm]').live("click",function() {
			orgGen($(this).parent().find("input[name*=expDiningOrgnztNm]"),
					$(this).parent().find("input[name*=expDiningOrgnztId]"),1);
		});

		$('[name*=expDiningSpend]').live("keyup",function() {
			jsMakeCurrency(this);
			if($(this).closest('.expenseWriteD').find('input[name$=expSpendTyp]:checked').val()!='CC') {
				var expenseSpendSum =0;
				$(this).closest('td').find('[name*=expDiningSpend]').each(function(){
					expenseSpendSum  += parseInt(jsDeleteComma($(this).val()));
				});
				
				$(this).closest('.expenseWriteD').find('[name$=expSpend]').val(jsAddComma(expenseSpendSum));
			}
			
		});
		$('[name$=expSpend]').attr("disabled","disabled");
	} 
	
	//재기안, 재상신 관련//	
	{
		var expenseList =${specificVOList}; 
		$('.expenseWriteD').each(function(idx,elm) {
			$(this).data('nth',idx);
			initialize($(this));
			if(idx==0)
				;
			else
				cnt++;

			if(templtId=="13") {
				prjSelect($(this).find('[name$=prjId]'),$(this).find('[name$=prjId]'),expenseList[idx]['column2']);
			}
		});
	};//재기안, 재상신 부분 종료.
	
	//추가 버튼 활성화
	$('#expenseAddB').click(function() {
		addExpense();		
	});

	function addExpense(){
		var addedDiv= expenseWriteD.clone();
		//이름 값 바꿔주기.
		addedDiv.find('[name]').each(function(idx,elm){
			var name = $(elm).attr('name');
			$(elm).attr('name',"expense[" + cnt + "]" + name);			
		});
		addedDiv.find('[name$=isPreset]:eq(0)').attr("checked","checked");
		addedDiv.find('[name$=presetIdSelector]').attr("disabled",true);
		addedDiv.find('[name$=presetIdSelector]').hide();
		addedDiv.find('[name$=presetIdSelector] > option:eq(0)').attr("selected",true);
		addedDiv.parent().parent().find('[type=hidden][name$=presetId]').val("");
		addedDiv.find('[name$=expSpendTyp]:eq(0)').attr("checked","checked");
		addedDiv.find('[name$=expSpendTyp]:eq(1)').removeAttr("checked");
		addedDiv.find('[name$=expSpendTyp]:eq(2)').removeAttr("checked");
		addedDiv.find('[name$=expSpend]').val('0');
		addedDiv.find('[name$=expDiningSpend\\[\\]]').val('0');
		addedDiv.find('[name$=companyCd]').html(expenseWriteD.find('[name$=companyCd]').html());
		addedDiv.data("nth",cnt);
		addedDiv.insertAfter($('.expenseWriteD').last());
		cnt++;
		initialize(addedDiv);
		return addedDiv;
	}

	function initialize(target){
		target.find('.expPrjTreeB,input[name$=prjFnm]').click(function(){
			if($(this).parent().parent().parent().find("select[name$=presetIdSelector]").val().length<20) {
				if(templtId=="10")
					prjGen($(this).parent().find("input[name$=prjFnm]"),$(this).parent().find("input[name$=prjId]"),1);
				else if(templtId=="13")
					prjGen($(this).parent().find("input[name$=prjFnm]"),$(this).parent().find("input[name$=prjId]"),1, null, prjSelect);
			}
		});
		
		target.find('.expAccTreeB, input[name$=accNm]').click(function(){
			if($(this).parent().parent().parent().find("select[name$=presetIdSelector]").val().length<20)
				accGen($(this).parent().find("input[name$=accNm]"),$(this).parent().find("input[name$=accId]"),parseInt(templtId));
		});

		target.find('input[name$=expSpend]').keyup(function(){
			jsMakeCurrency(this);
		});
		//
		
		//10번 업무경비 직접입력 빠른입력 선택
		target.find('input[name$=isPreset]').click(function(){
			var checkedValue = $(this).parent().children("input:checked").val();
			if(checkedValue=="Y") {
				$(this).siblings("select[name$=presetIdSelector]").removeAttr("disabled");
				$(this).siblings("select[name$=presetIdSelector]").show();
			} else {
				$(this).siblings("select[name$=presetIdSelector]").attr("disabled",true);
				$(this).siblings("select[name$=presetIdSelector]").hide();
				$(this).parent().find("select[name$=presetIdSelector] > option:eq(0)").attr("selected",true);
				$(this).parent().parent().parent().find("input[type=hidden][name$=presetId]").val("");
				$(this).parent().parent().parent().find("input[name$=prjFnm]").removeAttr("disabled");
				$(this).parent().parent().parent().find("input[name$=accNm]").removeAttr("disabled");
			}
		});

		//10번 업무경비 빠른입력 프리셋 선택
		target.find('select[name$=presetIdSelector]').change(function(){
			var checkedValue = $(this).find(":selected").val().split("/");
			var presetId = checkedValue[0];
			console.log(presetId.length);
			if(presetId.length ==20) {
				var prjId = checkedValue[1];
				var prjFnm = checkedValue[2];
				var accId = checkedValue[3];
				var accNm = checkedValue[4];
				$(this).closest('table').find("input[type=hidden][name$=presetId]").val(presetId);
				$(this).closest('table').find("input[name$=prjId]").val(prjId);
				$(this).closest('table').find("input[name$=prjFnm]").val(prjFnm).attr("disabled","true");
				$(this).closest('table').find("input[name$=accId]").val(accId);
				$(this).closest('table').find("input[name$=accNm]").val(accNm).attr("disabled","true");
			} else {
				$(this).parent().parent().parent().find("input[type=hidden][name$=presetId]").val("");
				$(this).parent().parent().parent().find("input[name$=prjFnm]").removeAttr("disabled");
				$(this).parent().parent().parent().find("input[name$=accNm]").removeAttr("disabled");
			}			
		});

		//결제구분 선택 시작
		target.find('input[name$=expSpendTyp]').change(function(){
			var checkedValue = $(this).parent().children("input:checked").val();
			//개인결제
			if(checkedValue=="PP") {
				$(this).siblings('.companyPaidS').hide();
				$(this).siblings('.corporateCardS').hide();
			}//체크카드	
			else if(checkedValue=="KK") {
				$(this).siblings('.companyPaidS').hide();
				$(this).siblings('.corporateCardS').hide();
			}
			//회사결제	
			else if(checkedValue=="CP") {
				$(this).siblings('.companyPaidS').show();
				$(this).siblings('.corporateCardS').hide();
			}//법인카드 CC
			else {
				var expenseDiv = $(this).closest('.expenseWriteD');
				$.post('/ajax/support/selectCardSpendList.do',function(data){
					var layer = $('<div id="projectInputL"></div>');
					layer.html(data);
					layer.dialog({
			 		    height: 500
			 		   ,width:1000 
			 		   ,closeOnEscape: true 
			 		   ,resizable: true 
			 		   ,draggable: true
			 		   ,modal :true
			 		   ,autoOpen: true 		
			 		   ,position : [50,100]   
			 		,close: function(event,ui){
							expenseDiv.find('input[name$=expSpendTyp][value="PP"]').attr("checked",true);
							expenseDiv.find('.companyPaidS').hide();
							expenseDiv.find('.corporateCardS').hide();
							layer.remove();
						}
					});
					
					layer.find('[name=searchUserNm]').val("${user.userNm}");
					search();

					layer.find('#checkAll').bind('change',function(){
						if($(this).attr("checked"))
							layer.find('[name=checkList]').attr("checked",true);
						else
							layer.find('[name=checkList]').removeAttr("checked");
					});
					layer.find('#searchYearPrev').bind('click',function(){
						var year = layer.find('[name=searchYear]').val();
						layer.find('[name=searchYear]').val(parseInt(year) - 1);
						layer.find('#searchYearStr').html(parseInt(year) - 1);
						search();
					});
					layer.find('#searchYearNext').bind('click',function(){
						var year = layer.find('[name=searchYear]').val();
						layer.find('[name=searchYear]').val(parseInt(year) + 1);
						layer.find('#searchYearStr').html(parseInt(year) + 1);
						search();
					});

					//법인카드 내역 send 버튼 선택 
					layer.find('#sendB').click(function(){
						if(layer.find('[name=checkList]:checked').length==0){
							alert("최소 한 개 이상은 선택하셔야 합니다");
							return false;
						}
						layer.find('[name=checkList]:checked').each(function(idx,elm){
							var expense;
							if(idx==0)
								expense = expenseDiv;
							else
								expense = addExpense();
						
							expense.find('input[name$=expSpend]').val($(this).closest('tr').find('.approvedSpend').html()).attr("disabled",true);
							var approvedDt = $(this).closest('tr').find('.approvalDt').html().replaceAll(".","").replaceAll(" ","").trimAll();
							expense.find('input[name$=expDt]').val(approvedDt).attr("disabled",true);
							var companyCd = $(this).closest('tr').find('.companyCd').html();
							expense.find('select[name$=companyCd] > option[value=' +companyCd +']').attr("selected",true);
							//expense.find('select[name$=companyCd] > option[value=' +companyCd +']').removeAttr("selected");
							expense.find('select[name$=companyCd]').attr("disabled",true);
							//expense.find('select[name$=companyCd]').removeAttr("disabled");
							expense.find('input[name$=cardSpendNo]').val($(this).val());
							expense.find('[name$=expCt]').val(
									$(this).closest('tr').find('.approvalNo').html() + ' ' + 
									$(this).closest('tr').find('.storeBusinessNm').html() );
							expense.find('.companyPaidS').hide();
							expense.find('.corporateCardS').show();
							expense.find('.corporateCardS .cardId').html($(this).closest('tr').find('.cardId').html());
							expense.find('input[name$=expSpendTyp][value=CC]').attr("checked", true);
							expense.find('input[name$=expSpendTyp]').attr("disabled", true);							
						});
						layer.dialog("destroy");
						layer.remove();
					});
					layer.find('#cancleB').click(function(){
						expenseDiv.find('input[name$=expSpendTyp][value="PP"]').attr("checked", true);
						expenseDiv.find('.companyPaidS').hide();
						expenseDiv.find('.corporateCardS').hide();
						layer.dialog("destroy");
						layer.remove();
					});
					//법인카드 내역 검색
					layer.find('#searchB').click(function(){
						search();
					});

					layer.find('input[type=text]').keydown(function(e) {
						if(e.keyCode == 13) {
							search();
						}
					});
					//cardSpendL.jsp 내부 내용 채우기
					function search (){
						$.post('/ajax/support/selectCardSpendListTbody.do',$('#searchVO').serialize(),function(data){
							layer.find('#cardSpendTbody').html(data);
						});								
					}; 
				});				
			}
		});
		//결제구분 선택 끝
		
		//13번 상품매입 양식 : 매입구분 선택 시작
		target.find('input[name$=column1]').change(function(){
			var checkedValue = $(this).parent().children("input:checked").val();
			// 외부매입
			if(checkedValue=="1") {
				// $(this).siblings('.companyPaidS').hide();
				// $(this).siblings('.corporateCardS').hide();
			} else { // 내부매입
				var expenseDiv = $(this).closest('.expenseWriteD');
				$.post('/ajax/support/stockL.do',function(data){
					var layer = $('<div id="projectInputL"></div>');
					layer.html(data);
					layer.dialog({
			 		    height: 500
			 		   ,width:1000 
			 		   ,closeOnEscape: true 
			 		   ,resizable: true 
			 		   ,draggable: true
			 		   ,modal :true
			 		   ,autoOpen: true 		
			 		   ,position : [50,100]   
			 		,close: function(event,ui){
							expenseDiv.find('input[name$=expSpendTyp][value="PP"]').attr("checked",true);
							expenseDiv.find('.companyPaidS').hide();
							expenseDiv.find('.corporateCardS').hide();
							layer.remove();
						}
					});
					
					layer.find('#checkAll').bind('change',function(){
						if($(this).attr("checked"))
							layer.find('[name=checkList]').attr("checked",true);
						else
							layer.find('[name=checkList]').removeAttr("checked");
					});

					//내부매입 send 버튼 선택(선택완료) 
					layer.find('#sendB').click(function(){
						if(layer.find('[name=checkList]:checked').length==0){
							alert("최소 한 개 이상은 선택하셔야 합니다");
							return false;
						}

						var expense = expenseDiv;

						/*
						layer.find('[name=checkList]:checked').each(function(idx,elm){
							if(idx==0)
								expense = expenseDiv;
							else
								expense = addExpense();
						});
						*/
					
						expense.find('input[name$=expSpend]').val(layer.find('#stockPriceTotalSumDisplay').html()).attr("disabled",true);

						var expCt = "";
						var checkList = layer.find('[name=checkList]:checked');
						for (var i = 0; i < checkList.length; i++) {
							expCt = expCt + $(checkList[i]).closest('tr').find('.itemName').html() + ' ';
							expCt = expCt + $(checkList[i]).closest('tr').find('.serialNo').html();
							expCt = expCt + '(' + $(checkList[i]).closest('tr').find('.inputDate').html() + ')';
							jsMakeCurrency($(checkList[i]).closest('tr').find('input[name=stockPrice]').get(0));
							expCt = expCt + ' ' + $(checkList[i]).closest('tr').find('input[name=stockPrice]').val() + '￦';
							expCt = expCt + '\n';
						}
						//expCt = expCt + "총계:" + $(this).find('#stockPriceTotalSumDisplay').html();
						expCt = expCt + "제품금액 : " + layer.find('#stockPriceSumDisplay').html() + '￦';
						expCt = expCt + "\n부가세 : " + layer.find('input[name=stockPriceTax]').val() + '￦';
						
						expense.find('[name$=expCt]').val(expCt);
						
						expense.find('input[name$=column1][value=2]').attr("checked",true);
						expense.find('input[name$=column1]').attr("disabled",true);

						var tmpSaveStockList = "";
						for (var i = 0; i < checkList.length; i++) {
							tmpSaveStockList = tmpSaveStockList + ',' + $(checkList[i]).val();
						}
						//expense.find('input[name$=column1]').closest('td').append('<input type="hidden" name="expense[' + '].tmpSaveStockList" value="' + tmpSaveStockList.substring(1) + '"/>');
						expense.find('input[name$=tmpSaveStockList]').val(tmpSaveStockList.substring(1));
						
						layer.dialog("destroy");
						layer.remove();
					});
					
					layer.find('#cancleB').click(function() {
						expenseDiv.find('input[name$=column1][value=1]').attr("checked",true);
						layer.dialog("destroy");
						layer.remove();
					});

					layer.find('[name=checkAll]').bind('change',function(){
						calculateSum();
					});
					
					layer.find('[name=checkList]').bind('change',function(){
						calculateSum();
					});
					
					function calculateSum() {
						var priceSum = 0;
						var checkList = layer.find('[name=checkList]');
						for (var i = 0; i < checkList.length; i++) {
							var tmp = $(checkList.get(i));
							if (tmp.attr("checked"))
								priceSum = priceSum + parseInt(tmp.closest('tr').find('#stockPrice').val());
						}
						
						layer.find('#stockPriceSum').val(priceSum);
						jsMakeCurrency(layer.find('#stockPriceSum').get(0));
						layer.find('#stockPriceSumDisplay').html(layer.find('#stockPriceSum').val());
						layer.find('#stockPriceSum').val(priceSum);

						layer.find('#stockPriceTax').val(parseInt(priceSum * 0.1));
						jsMakeCurrency(layer.find('#stockPriceTax').get(0));

						calculateTotalSum();
					}

					layer.find("#stockPriceTax").keyup(function(){
						if ($(this).val().length != 0)
							jsMakeCurrency(this);
						calculateTotalSum();
					});

					function calculateTotalSum() {
						var totalSum = parseInt(layer.find('#stockPriceSum').val()) + parseInt(layer.find('#stockPriceTax').val().replace(',', ''));
						layer.find('#stockPriceTotalSum').val(totalSum);
						jsMakeCurrency(layer.find('#stockPriceTotalSum').get(0));
						layer.find('#stockPriceTotalSumDisplay').html(layer.find('#stockPriceTotalSum').val());
						layer.find('#stockPriceTotalSum').val(totalSum);
					}
					
					layer.find('#searchB').click(function(){
						search();
					});					
					layer.find('input[type=text]').keydown(function(e) {
						if(e.keyCode == 13) {
							search();
						}
					});
					//cardSpendL.jsp 내부 내용 채우기
					function search (){
						$.post('/ajax/support/selectCardSpendListTbody.do',$('#searchVO').serialize(),function(data){
							layer.find('#cardSpendTbody').html(data);
						});
					};
				});
			}
		});
		//13번 상품매입 매입구분 선택 끝
		
		//회사결제 선지급 클릭
		target.find('input[name$=alreadyPaid]').click(function(){
			if($(this).is(":checked")) {
				$(this).parent().children("input[name$=payingDueDate]").val("");
				$(this).parent().children("input[name$=payingDueDate]").attr("disabled",true);
			} else
				$(this).parent().children("input[name$=payingDueDate]").attr("disabled",false);
		});
		
		//지출내역 삭제
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

//13번 문서관련. prj 선택시 sales값 업데이트.
function prjSelect(prjNmObj, prjIdObj, docId) {
	$.post("/ajax/approval/selectSaelsPurchaseOutList.do?prjId="+prjIdObj.val(),function(data){
		data = JSON.parse(data);
		var selector = prjIdObj.closest('.expenseWriteD').find('select[name$=column2]');
		if(data.length >= 1) {
			selector.html('<option value="" label="매출을 선택하세요."/>');
			selector.closest('.expenseWriteD').find('.salesInfoUl li').html('');
			$.each(data,function(idx,elm){
				var txtSales ='';
				if (elm.salesSum > 0) {
					txtSales = '(' + '매출액 : ' +jsAddComma(elm.salesSum) + '원)';
				}
				var option = $('<option value="'+elm.docId+'">'+
					'[' + elm.docDt+']' +' '+ elm.salesCt + 
					txtSales +  '</option>');
				//문서에 저장된 금액보다 1.1배 많게 저장함.
				option.data('purchaseOutSum', Math.round(elm.purchaseOutSum*1.1));
				option.data('alreadyPurchasedSum', elm.alreadyPurchasedSum);
				option.appendTo(selector);
			});
			if(typeof(docId) !='undefined') {
				selector.children('[value='+docId+']').attr("selected","selected");
				selectorChanged(selector);
			}
			selector.change(function() {
				selectorChanged($(this))
			});

			function selectorChanged(selector) {
				var option = selector.children(':selected');
				var li = selector.closest('.expenseWriteD').find('.salesInfoUl li');
				if(option.val()=="")
					li.html('');
				else {					
					li.html('총 사외매입금액 : ' + jsAddComma(option.data('purchaseOutSum')) +
							' /기 매입금액 : ' + jsAddComma(option.data('alreadyPurchasedSum')) +
							' /잔여 매입한도  : ' + jsAddComma(option.data('purchaseOutSum') - option.data('alreadyPurchasedSum'))
							);
				}				
			};
		} else {
			selector.html('<option value="" label="프로젝트를 먼저 선택하세요."/>');			
		}
	});
};

</script>
<p class="th_stitle2 mB10">지출내역</p>
<c:forEach items="${specificVOList}" var="result" varStatus="status">
<div class="boardWrite02 mB10 expenseWriteD">
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col70" />
		<col class="col150" />
		<col class="col70" />
		<col width="px" />
		<col class="col70" />
		<col class="col120" />
		<col class="col50" />
	</colgroup>
	<tbody>
		<tr <c:if test="${approvalVO.templtId != 10}">style="display:none;"</c:if>>
			<td class="pL10 pT5 pB5" colspan="6">				
				<input type="radio" name="expense[${status.index}].isPreset" value="N" 
				<c:if test="${empty result.presetId}">checked</c:if>> 
				직접입력 <span class="pL7"></span>
				<input name="expense[${status.index}].isPreset" type="radio" value="Y" 
				<c:if test="${not empty result.presetId}">checked</c:if>/> 
				빠른입력 <span class="pL7"></span>				 
				<select name="expense[${status.index}].presetIdSelector" class="span_9 
				<c:if test="${empty result.presetId}">hidden</c:if>" <c:if test="${empty result.presetId}">disabled</c:if>>
					<option value="">선택하세요</option>
					<c:forEach items="${presetList}" var="preset">
						<option value="${preset.presetId}/${preset.prjId}/${preset.prjFnm}/${preset.accId}/${preset.prntAccNm}(${preset.accNm})"
						<c:if test="${preset.presetId==result.presetId}">selected</c:if>>
							${preset.presetNm}
						</option>
					</c:forEach>
				</select>
				<input type="hidden" name="expense[${status.index}].presetId" value="${result.presetId}"/>
			</td>
			<c:if test="${approvalVO.templtId==10}">
				<td class="pic" rowspan="5">
					<img src="${imagePath}/btn/btn_delete04.gif" class="cursorPointer deleteExpenseB">
				</td>
			</c:if>
		</tr>
		<tr>
			<td class="title">결제구분</td>
			<td class="pL10" colspan="5">
				<input name="expense[${status.index}].expSpendTyp" type="radio" value="PP" 
				<c:if test="${result.expSpendTyp=='PP' }">checked</c:if> 
				<c:if test="${result.expSpendTyp=='CC' }">disabled</c:if>/> 개인결제
				<input name="expense[${status.index}].expSpendTyp" type="radio" value="CP" 
				<c:if test="${result.expSpendTyp=='CP' }">checked</c:if> 
				<c:if test="${result.expSpendTyp=='CC' }">disabled</c:if>/> 회사결제
				<input name="expense[${status.index}].expSpendTyp" type="radio" value="CC" 
				<c:if test="${result.expSpendTyp=='CC' }">checked</c:if> 
				<c:if test="${result.expSpendTyp=='CC' }">disabled</c:if>/> 법인카드
				<input name="expense[${status.index}].expSpendTyp" type="radio" value="KK" 
				<c:if test="${result.expSpendTyp=='KK' }">checked</c:if> 
				<c:if test="${result.expSpendTyp=='CC' }">disabled</c:if>/> 체크카드
				<span class="companyPaidS <c:if test="${result.expSpendTyp!='CP' }">hidden</c:if>">
					<span class="pL20"></span> 
					지급요청일 : 
					<input type="text" class="span_5 calGen" name="expense[${status.index}].payingDueDate" value="${result.payingDueDate }"/> 
					<span class="pL7"></span>
					<!-- 2013.09.02 선지급 디폴트 해지--> 
					<!-- <input type="checkbox" name="expense[${status.index}].alreadyPaid" <c:if test="${empty result.payingDueDate}">checked</c:if>/> 선지급  -->
					<input type="checkbox" name="expense[${status.index}].alreadyPaid"/> 선지급 
				
				</span> 
				<span class="corporateCardS <c:if test="${result.expSpendTyp!='CC' }">hidden</c:if>"> 
					<span class="pL20"></span>
					카드번호 : <span class="txt_blue cardId">${result.cardId }</span> 
					<input type="hidden" name="expense[${status.index}].cardSpendNo" value="${result.cardSpendNo }"/>
				</span>
			</td>
			<c:if test="${approvalVO.templtId==11}">
				<td class="pic" rowspan="5">
					<img src="${imagePath}/btn/btn_delete04.gif" class="cursorPointer deleteExpenseB">
				</td>
			</c:if>
			<c:if test="${approvalVO.templtId==13}">
				<td class="pic" rowspan="6">
					<img src="${imagePath}/btn/btn_delete04.gif" class="cursorPointer deleteExpenseB">
				</td>
			</c:if>
		</tr>
		<c:if test="${appTyp.templtId==12}">
       		<tr class="diningInfoTr">
				<td class="title">지출금액/부서</td> 
				<td class="pL10" colspan="5" > 
					<ul class="diningInfoUl" style="width : 90%;">
						<c:forEach items="${result.expDiningList}" var="result2" varStatus="status2">
							<li>
								부서 : 
								<input type="text" name="expense[${status.index}].expDiningOrgnztNm[]" class="span_9"  readonly="readonly" value="${result2.orgnztNm}"/>
								<input type="hidden" name="expense[${status.index}].expDiningOrgnztId[]" value="${result2.orgnztId}"/>
								<img src="${imagePath}/btn/btn_tree.gif" class="expDiningOrgnztTreeB cursorPointer">
								금액 :&nbsp;
								<input type="text" name="expense[${status.index}].expDiningSpend[]" class="span_9 currency" value="<print:currency cost='${result2.diningSpend}'/>" />
							</li>					
						</c:forEach>
					</ul>
					<ul style="float:right;">
						<li>
							<img src="${imagePath}/btn/btn_add.gif" class="diningOrgnztAddB cursorPointer"/>
						</li>
					</ul>
				</td>
			</tr>
       	</c:if> 
       	<c:if test="${appTyp.templtId==13}">
			<tr class="salesInfoTr">
				<td class="title">매입구분</td> 
				<td class="pL10" colspan="5" > 
					<input type="radio" name="expense[${status.index}].column1" value="1" <c:if test="${result.column1==1 }">checked</c:if>/> 외부매입
					&nbsp;&nbsp;&nbsp;
					<input type="radio" name="expense[${status.index}].column1" value="2" <c:if test="${result.column1==2 }">checked</c:if>/> 내부매입
					&nbsp;&nbsp;※재고를 출고하는 경우 내부매입을 선택해주세요.
					<input type="hidden" name="expense[${status.index}].tmpSaveStockList" />
				</td>
			</tr>
			<tr class="salesInfoTr">
				<td class="title">관련매출건</td> 
				<td class="pL10" colspan="5" > 
					<ul style="width : 100%;">
						<li>
						<select name="expense[${status.index}].column2">
							<option value="" label="프로젝트를 먼저 선택하세요.">
							</option>
						</select>
						</li>
					</ul>
					<ul class="salesInfoUl">
						<li></li>
					</ul>
				</td>
			</tr>
       	</c:if> 
		<tr>
			<td class="title">계정과목</td>
			<td class="pL10">
				<input type="text" name="expense[${status.index}].accNm" class="span_6" readonly="readonly"
				<c:choose>
					<c:when test="${empty result.accNm }">
					value=""
					</c:when>
					<c:otherwise>
					value="${result.prntAccNm}(${result.accNm})"
					</c:otherwise>
				</c:choose>
				<c:if test="${not empty result.presetId && approvalVO.templtId=='10'}"> disabled</c:if>
				/>
				<input type="hidden" name="expense[${status.index}].accId" value="${result.accId}" /> 
				<img src="${imagePath}/btn/btn_tree.gif" class="expAccTreeB cursorPointer">
			</td>
			<td class="title">프로젝트</td>
			<td class="pL10">
				<c:choose>
					<c:when test="${approvalVO.templtId=='11' || approvalVO.templtId=='12'}">
						<select name="expense[${status.index}].prjId">
							<c:forEach items="${presetPrjList}" var="result2">
								<option value="${result2.prjId}"
								<c:if test="${result2.prjId==result.prjId}">selected="selected"</c:if>>${result2.prjFnm}</option>
							</c:forEach>
						</select>
					</c:when>
					<c:otherwise>
						<input type="text" name="expense[${status.index}].prjFnm" class="span_6" readonly="readonly" 
						value="<print:project prjId="${result.prjId}" prjCd="${result.prjCd}" prjNm="${result.prjNm}" link="N"/>"
						<c:if test="${not empty result.presetId && approvalVO.templtId=='10'}"> disabled</c:if>
						/> 
						<input type="hidden" name="expense[${status.index}].prjId" value="${result.prjId }"/>
						<img src="${imagePath}/btn/btn_tree.gif" class="expPrjTreeB cursorPointer">	
					</c:otherwise>
				</c:choose>
			</td>
			<td class="title">회사구분</td>
			<td class="pL10">
				<select name="expense[${status.index}].companyCd" class="span_6"
				<c:if test="${result.expSpendTyp=='CC' }">disabled</c:if> >
				<c:set var="expCompanyCdSelected" value="0"/>
				<c:forEach items="${companyList}" var="company">
					<option
						value="${company.code}"
						<c:choose>
							<c:when test="${company.code==result.companyCd}">
								selected
								<c:set var="expCompanyCdSelected" value="1"/>
							</c:when>
							<c:otherwise>
								<c:if test="${company.code==user.expCompId && expCompanyCdSelected==0}">
									selected
								</c:if>
							</c:otherwise>
						</c:choose>
					>
						${company.codeNm}
					</option>
				</c:forEach>
			</select>
			</td>
		</tr>
		<tr>
			<td class="title">지출일자</td>
			<td class="pL10">
				<input type="text" name="expense[${status.index}].expDt" class="span_6 calGen" value="${result.expDt}"
				<c:if test="${result.expSpendTyp=='CC' }">disabled</c:if> />
			</td>
			<td class="title" rowspan="2">비고</td>
			<td class="pL10" rowspan="2" colspan="4">
				<textarea name="expense[${status.index}].expCt" class="span_17 height_70">${result.expCt}</textarea>
			</td>
		</tr>
		<tr>
			<td class="title">금액</td>
			<td class="pL10">
				<input type="text" name="expense[${status.index}].expSpend" class="span_6 currency" 
				value="<print:currency cost='${result.expSpend }'/>"
				<c:if test="${result.expSpendTyp=='CC' }">disabled</c:if> />
				
			</td>
		</tr>
	</tbody>
</table>
</div>
</c:forEach>


<!-- 버튼 시작 -->
<div class="btn_area04 pB30">
	<img src="${imagePath}/btn/btn_add.gif" id="expenseAddB" class="cursorPointer" />
</div>
<!-- 버튼 끝 -->

