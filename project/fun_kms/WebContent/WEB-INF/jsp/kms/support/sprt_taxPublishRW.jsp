<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>

<validator:javascript formName="taxPublish" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='${commonPath}/js/jquery.validate.js'/>" ></script>

<script>

// 금액 cnt
var expenseCnt = ${resultExpenseCnt + 1};

// 프로젝트 cnt
var projectCnt = ${resultProjectCnt + 1};

//공급가액, 세액, 합계, 프로젝트 별 금액
var supExp = [];
var taxExp = [];
var pubExp = [];
var prjExp = [];
var supSum = 0;
var taxSum = 0;
var pubSum = 0;
var prjSum = 0;

$(document).ready(function() {
	addMakeCurrencyEvent();
	addCheckboxEvent();
	calExpense();
	custNmAutoComplete();
	chgZeroTaxRateEvent();
});

function reInsertTaxPublish() {

	calExpense();

	if (!validateTaxPublish(document.taxPublishVO)) {
		return;
	}
	var boolValidate = true;
	$('[name$=expense]').each(function(){
		if ($(this).closest('div').css('display') != 'none' && $(this).val().length == 0 && boolValidate) {
			boolValidate = false;
			alert('금액을 입력해주세요.');
		}
	});
	$('[name$=prjId]').each(function(){
		if ($(this).closest('div').css('display') != 'none' && $(this).val().length == 0 && boolValidate) {
			boolValidate = false;
			alert('관련 프로젝트를 선택해주세요.');
		}
	});
	$('[name$=prjExpense]').each(function(){
		if ($(this).closest('div').css('display') != 'none' && $(this).val().length == 0 && boolValidate) {
			boolValidate = false;
			alert('금액을 입력해주세요.');
		}
	});
	if (prjSum != supSum) {
		boolValidate = false;
		alert('총 공급가액과 프로젝트별 금액 총합이 일치하지 않습니다.');
	}
	
	if (!boolValidate)
		return;

	$('[name$=expense]').each(function(){
		$(this).val(parseInt(jsDeleteComma($(this).val())));
	});
	$('[name$=prjExpense]').each(function(){
		$(this).val(parseInt(jsDeleteComma($(this).val())));
	});
	
	var form = $('#taxPublishVO');
	var expenseVO = $('#taxPublishVO').toObject({mode: 'first'})['expenseArray'];
	form.find("input[name=jsonExpenseString]").val(escape(JSON.stringify(expenseVO)));
	var projectVO = $('#taxPublishVO').toObject({mode: 'first'})['project'];
	form.find("input[name=jsonProjectString]").val(escape(JSON.stringify(projectVO)));

	//location.href = "${rootPath}/support/taxPublishI.do?" + form.serialize();
	document.taxPublishVO.action = '<c:url value="${rootPath}/support/taxPublishRI.do" />';
	document.taxPublishVO.submit();
}
function cancelTaxPublish(bondId) {
	document.taxPublishVO.bondId.value = bondId;
	document.taxPublishVO.action = '<c:url value="${rootPath}/support/taxPublishV.do" />';
	document.taxPublishVO.submit();
}
function addExpense(){
	var disabled = '';
	if ($('#zeroTaxRate:checked').length == 1) {	// 영세율 구분
		disabled = 'disabled="disabled"';
	}
	var expense = $('<div id="expenseList[' + expenseCnt + ']">' +
			'<input type="hidden" name="expenseArray[' + expenseCnt + '].useAt" value="Y" /><input type="text" class="input01 span_8 currency" name="expenseArray[' + expenseCnt + '].expense" id="exp' + expenseCnt + '" value="0"/> 원 ' +
			'<label><input type="checkbox" class="check" name="expenseArray[' + expenseCnt + '].containVat" value="Y" id="expVat' + expenseCnt + '" ' + disabled + ' /> VAT 포함</label> <span class="pL10"></span>비고 : <input type="text" class="input01 span_10" name="expenseArray[' + expenseCnt + '].note" />' +
			'&nbsp;<img src="../../images/btn/btn_delete04.gif" class="search_btn02 cursorPointer" onclick="javascript:removeExpense(\'' + expenseCnt + '\');"/><br/>' +
			'</div>');
	var addBtn = $('#addExpenseBtn').clone();
	$('#addExpenseBtn').remove();
	expense.appendTo($('#Expenses'));
	addBtn.appendTo($('#Expenses'));
	expenseCnt++;

	addMakeCurrencyEvent();
	addCheckboxEvent();
}
function removeExpense(num) {
	$("[name='expenseArray\\[" + num + "\\].useAt']").attr('value', 'N');
	$('#expenseList\\[' + num + '\\]').hide();
	calExpense();
}
function addProject(){
	var project = $('<div id="projectList[' + projectCnt + ']">' +
			'<input type="hidden" name="project[' + projectCnt + '].useAt" value="Y" ><input type="text" name="prjId2[' + projectCnt + ']" id="searchPrjNm' + projectCnt + '" class="span_11 input01" readonly="readonly" onclick="prjGen(\'searchPrjNm' + projectCnt + '\',\'searchPrjId' + projectCnt + '\',1);"/>' +
			'<input type="hidden" name="project[' + projectCnt + '].prjId" id="searchPrjId' + projectCnt + '" > <img src="${imagePath}/btn/btn_tree.gif" onclick="prjGen(\'searchPrjNm' + projectCnt + '\',\'searchPrjId' + projectCnt + '\',1);" class="cursorPointer">' +
			'<span class="pL20"></span>&nbsp;금액(원) <input type="text" class="input01 span_6 currency" name="project[' + projectCnt + '].prjExpense" id="prj' + projectCnt + '" value="0" />' +
			'&nbsp;<img src="../../images/btn/btn_delete04.gif" class="search_btn02 cursorPointer" onclick="javascript:removeProject(\'' + projectCnt + '\')"/>' +
			'</div>');
	
	var addBtn = $('#addProjectBtn').clone();
	$('#addProjectBtn').remove();
	project.appendTo($('#Projects'));
	addBtn.appendTo($('#Projects'));
	projectCnt++;

	addMakeCurrencyEvent();
}
function removeProject(num) {
	$("[name='project\\[" + num + "\\].useAt']").attr('value', 'N');
	$('#projectList\\[' + num + '\\]').hide();
	calExpense();
}
function addMakeCurrencyEvent(){
	$('#taxPublishVO').find(".currency").keyup(function(){

		calExpense();
		
		if ($(this).val().length != 0)
			jsMakeCurrency(this);
	});
}
function addCheckboxEvent() {
	$('#taxPublishVO').find(".check").click(function(){		
		calExpense();
	});
}
function chgZeroTaxRateEvent() {
	$('#zeroTaxRate').change(function(){
		var vatCheckboxes = $('#Expenses').find("input[type=checkbox]");
		if ($('#zeroTaxRate:checked').length == 1) {
			vatCheckboxes.attr('checked', false);
			vatCheckboxes.attr('disabled', true);
		} else {
			//vatCheckboxes.attr('checked', true);
			vatCheckboxes.attr('disabled', false);
		}
	});
}
function calExpense() {
	
	// 공급가액, 세액, 합계  계산
	supSum = 0;
	taxSum = 0;
	for (var i = 0; i < expenseCnt; i++) {
		if ($('#expenseList\\[' + i + '\\]').length == 0 || $('#expenseList\\[' + i + '\\]').css('display') == 'none')
			continue;

		if ($('#expenseList\\[' + i + '\\]').find("input:checked").length == 1) {
			taxExp[i] = parseInt(Math.round(jsDeleteComma($('#exp' + i).val()) / 11));
			supExp[i] = parseInt(jsDeleteComma($('#exp' + i).val()) - taxExp[i]);
		} else {
			// 영세율 구분
			if ($('#zeroTaxRate:checked').length == 1) {
				taxExp[i] = 0;
				supExp[i] = parseInt(jsDeleteComma($('#exp' + i).val()));
			} else {
				taxExp[i] = parseInt(Math.round(jsDeleteComma($('#exp' + i).val()) / 10));
				supExp[i] = parseInt(jsDeleteComma($('#exp' + i).val()));
			}
		}

		supSum = supSum + supExp[i];
		taxSum = taxSum + taxExp[i];
	}
	pubSum = supSum + taxSum;

	// 프로젝트 별 금액 총합을 계산
	prjSum = 0;
	for (var i = 0; i < projectCnt; i++) {
		if ($('#projectList\\[' + i + '\\]').length == 0 || $('#projectList\\[' + i + '\\]').css('display') == 'none')
			continue;

		prjExp[i] = parseInt(jsDeleteComma($('#prj' + i).val()));
		prjSum = prjSum + prjExp[i];
	}

	if (prjSum != supSum)
		$('#prjSum').addClass('txt_red');
	else
		$('#prjSum').removeClass('txt_red');

	// 분배될 프로젝트가 하나밖에 없을 때, 즉 $('#firstPrjExpense')가 비활성 시에는 프로젝트의 금액을 자동으로 계산해 줌
	if ($('#prj0').attr('disabled'))
		$('#prj0').val(jsAddComma(roundXL(supSum,0)));

	$('#supSum').html(jsAddComma(roundXL(supSum,0)));
	$('#taxSum').html(jsAddComma(roundXL(taxSum,0)));
	$('#pubSum').html(jsAddComma(roundXL(pubSum,0)));

	$('#supChkSum').html(jsAddComma(roundXL(supSum,0)));
	$('#prjSum').html(jsAddComma(roundXL(prjSum,0)));
}

var searchKeyword = null;
var searchAction = null;


function custNmAutoComplete(){

	var custDiv = null;
	var searchTyp = '';
	
	$('#searchFromCustomer').click(function() {
		searchTyp = 'cust';
		popCustSearch();
	});

	$('#searchFromTaxPublish').click(function() {
		searchTyp = 'tax';
		popCustSearch();
	});

	function popCustSearch() {

		if (custDiv != null) {
			custDiv.dialog('destroy');
			custDiv.remove();
		}

		custDiv = $('<div id="_custDiv">'+
				'<div class="ui_layer customer">'+
				'	<dl>'+
				'		<dd>검색어 : <input type="text" name="custSearchKeyword"/></dd>'+
				'	</dl>'+
				'	<div class="ui_List" style="height:490px;">'+
				'	</div>'+
				'</div>'+
			'</div>');
		
		custDiv.appendTo('body');
		var position = $('#searchFromCustomer').offset();
		// custDiv.css("left",(position.left - 20)+"px");
		// custDiv.css("top",(position.top - 5)+"px");
		// custDiv.css("position","absolute");

		$('[name=custSearchKeyword]').keyup(function(){

			searchKeyword = this.value;
			//prjIdObj.data("searchKeyword",searchKeyword);
			if(searchAction)
			{
				clearTimeout( searchAction );
			}
			searchAction = setTimeout(customerIncluded,300);
		});

		var width = custDiv.find(".ui_layer").css("width");
		width = parseInt(width.substr(0, width.indexOf("px"))) + 8;
		custDiv.dialog({
			width : width
			,height : 570
			,closeOnEscape: true 
			,resizable: true 
			,draggable: true
			,autoOpen: true 		
			,position : [(position.left - 20), (position.top - 5)]   
		});	
	}
	
	function customerIncluded(){

		if (searchKeyword == "") {
			return;
		}
		
		$.post("/ajax/customerIncluded.do?searchKeyword=" + encodeURI(searchKeyword) + "&searchTyp=" + searchTyp,function(data){

			var size = $(data).find('.customerIncludedLi').size();
			if (size == 0) {
				return;
			}
			
			custDiv.find('.ui_List').html(data);
			
			//selectedPrjId = prjIdObj.val();
			//if(selectedPrjId!="")
			//	$('.prjUserIncludedLi input[name=prjUserIncluded_prjId][value='+selectedPrjId +']').parent().addClass('txtB_blue2');
			
			$('body').bind('click.customer', function custLayerClickEvent(event){
					if (!$(event.target).closest(custDiv).length) {
						custDiv.hide();
						$('body').unbind('click.customer');
					};
				}
			);

			$('.customerIncludedLi').click(function(){
				$('[name=custNm]').val($(this).find('[name=customerIncluded_custNm]').val());
				$('[name=custAdres]').val($(this).find('[name=customerIncluded_custAdres]').val());
				$('[name=custBusiNo]').val($(this).find('[name=customerIncluded_custBusiNo]').val());

				$('[name=custRepNm]').val($(this).find('[name=customerIncluded_custRepNm]').val());
				$('[name=custBusiCond]').val($(this).find('[name=customerIncluded_custBusiCond]').val());
				$('[name=custBusiTyp]').val($(this).find('[name=customerIncluded_custBusiTyp]').val());
				
				$('[name=taxEmail1]').val($(this).find('[name=customerIncluded_taxEmail1]').val());
				$('[name=taxUserNm1]').val($(this).find('[name=customerIncluded_taxUserNm1]').val());
				$('[name=taxUserTelNo1]').val($(this).find('[name=customerIncluded_taxTelno1]').val());

				$('[name=taxEmail2]').val($(this).find('[name=customerIncluded_taxEmail2]').val());
				$('[name=taxUserNm2]').val($(this).find('[name=customerIncluded_taxUserNm2]').val());
				$('[name=taxUserTelNo2]').val($(this).find('[name=customerIncluded_taxTelno2]').val());

				$('[name=taxEmail3]').val($(this).find('[name=customerIncluded_taxEmail3]').val());
				$('[name=taxUserNm3]').val($(this).find('[name=customerIncluded_taxUserNm3]').val());
				$('[name=taxUserTelNo3]').val($(this).find('[name=customerIncluded_taxTelno3]').val());

				$('[name=taxEmail4]').val($(this).find('[name=customerIncluded_taxEmail4]').val());
				$('[name=taxUserNm4]').val($(this).find('[name=customerIncluded_taxUserNm4]').val());
				$('[name=taxUserTelNo4]').val($(this).find('[name=customerIncluded_taxTelno4]').val());

				$('[name=taxEmail5]').val($(this).find('[name=customerIncluded_taxEmail5]').val());
				$('[name=taxUserNm5]').val($(this).find('[name=customerIncluded_taxUserNm5]').val());
				$('[name=taxUserTelNo5]').val($(this).find('[name=customerIncluded_taxTelno5]').val());

				if(typeof callback!= "undefined")
				{
					callback.call(this,prjNmObj, prjIdObj);
				}
				custDiv.dialog('destroy');
				custDiv.remove();
				$('body').unbind('click.customer');
			});
		});
	};
}
</script>
<body>

<div id="wrap">
	<%@ include file="../common/menu/head.jsp"%>
	<!-- S: container -->
	<div id="container">
		<ul class="container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="contents">
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
			<!-- S: center -->
			<div id="center">
				<div class="path_navi">
					<ul>
						<li class="stitle">세금계산서 발행요청</li>
						<li class="navi">홈 > 업무지원 > 각종신청 > 세금계산서 발행요청</li>
					</ul>
				</div>
				<span class="stxt">(*) 표시가 있는 항목은 필수 입력 항목입니다.</span>
				<!-- S: section -->
				<div class="section01">
					<form:form commandName="taxPublishVO" id="taxPublishVO" name="taxPublishVO" method="post" enctype="multipart/form-data" >
					
					<input type="hidden" name="pageIndex" value="${taxPublishVO.pageIndex}"/>
					<input type="hidden" name="bondStatN" value="${taxPublishVO.bondStatN}"/>
					<input type="hidden" name="bondStatY" value="${taxPublishVO.bondStatY}"/>
					<input type="hidden" name="bondStatC" value="${taxPublishVO.bondStatC}"/>
					<input type="hidden" name="userNm" value="${taxPublishVO.userNm}"/>
					<input type="hidden" name="searchNm" value="${taxPublishVO.searchNm}"/>
					<input type="hidden" name="untilToday" value="${taxPublishVO.untilToday}"/>
					<input type="hidden" name="searchCompanyCd" value="${taxPublishVO.searchCompanyCd}"/>
					
					<input type="hidden" name="bondId" value="${result.bondId}" />
					<input type="hidden" name="jsonExpenseString" />
					<input type="hidden" name="jsonProjectString" />
					
					<input type="hidden" name="returnUrl" value="<c:url value='${rootPath}/support/taxPublishRW.do'/>"/>
					<input type="hidden" name="posblAtchFileNumber" value="3" />
					
					<p class="th_stitle">계산서 발행 요청 정보</p>
					<div class="boardWrite02 mB20">
						
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup>
							<col class="col100" />
							<col class="col70" />
							<col class="col250" />
							<col class="col70" />
							<col width="px" />
						</colgroup>
						<tbody>
							<tr>
								<td class="title">제목(*)</td>
								<td class="pL10" colspan="4"><input type="text" class="input01 span_24" name="bondSj" value="${result.bondSj}"/></td>
							</tr>
							<tr>
								<td class="title">공급자(*)</td>
								<td class="pL10" colspan="4">
									<select  name="companyCd" class="select01" >
										<c:forEach items="${companyList}" var="company">
											<option
												value="${company.code}"
												<c:choose>
													<c:when test="${company.code==result.companyCd}">selected</c:when>
												</c:choose>
											>
												${company.codeNm}
											</option>
										</c:forEach>
									</select>
									<span class="pL5"></span> 계산서 발행 법인을 선택해주세요.
								</td>
							</tr>
							<tr>
								<td class="title" rowspan="4">공급받는자</td>
								<td class="title2">
									상호(*)
								</td>
								<td class="pL10" colspan="3">
									<input type="text" class="input01 span_10 custNmAuto" name="custNm" value="${result.custNm}"/> <img src="../../images/btn/btn_fromCustomerList.gif" class="cursorPointer" id="searchFromCustomer"/> <img src="../../images/btn/btn_fromTaxPublishList.gif" class="cursorPointer" id="searchFromTaxPublish"/>
								</td>
							</tr>
							<tr>
								<td class="title2">
									등록번호
								</td>
								<td class="pL10">
									<input type="text" class="input01 span_10" name="custBusiNo" value="${result.custBusiNo}" maxlength="14"/>
								</td>
								<td class="title2">
									대표자
								</td>
								<td class="pL10">
									<input type="text" class="input01 span_10" name="custRepNm" value="${result.custRepNm}"/>
								</td>
							</tr>
							<tr>
								<td class="title2">
									업태
								</td>
								<td class="pL10">
									<input type="text" class="input01 span_10" name="custBusiCond" value="${result.custBusiCond}"/>
								</td>
								<td class="title2">
									업종
								</td>
								<td class="pL10">
									<input type="text" class="input01 span_10" name="custBusiTyp" value="${result.custBusiTyp}"/>
								</td>
							</tr>
							<tr>
								<td class="title2">
									주소
								</td>
								<td class="pL10" colspan="3">
									<input type="text" class="input01 span_24" name="custAdres" value="${result.custAdres}"/>
								</td>
							</tr>
							<tr>
								<td class="title" rowspan="5">수신자</td>
								<td class="title2">수신자1(*)</td>
								<td class="pL10" colspan="3">
									<div id="Receiver1">
										<span class="pL5">E-mail : <input type="text" class="input01 span_6" name="taxEmail1" value="${result.taxEmail1}"/></span>
										<span class="pL20">담당자 : <input type="text" class="input01 span_6" name="taxUserNm1" value="${result.taxUserNm1}"/></span>
										<span class="pL20">연락처 : <input type="text" class="input01 span_6" name="taxUserTelNo1" value="${result.taxUserTelNo1}"/></span>
										<br/>
									</div>
								</td>
							</tr>
							<tr>
								<td class="title2">수신자2</td>
								<td class="pL10" colspan="3">
									<div id="Receiver2">
										<span class="pL5">E-mail : <input type="text" class="input01 span_6" name="taxEmail2" value="${result.taxEmail2}"/></span>
										<span class="pL20">담당자 : <input type="text" class="input01 span_6" name="taxUserNm2" value="${result.taxUserNm2}"/></span>
										<span class="pL20">연락처 : <input type="text" class="input01 span_6" name="taxUserTelNo2" value="${result.taxUserTelNo2}"/></span>
										<br/>
									</div>
								</td>
							</tr>
							<tr>
								<td class="title2">수신자3</td>
								<td class="pL10" colspan="3">
									<div id="Receiver3">
										<span class="pL5">E-mail : <input type="text" class="input01 span_6" name="taxEmail3" value="${result.taxEmail3}"/></span>
										<span class="pL20">담당자 : <input type="text" class="input01 span_6" name="taxUserNm3" value="${result.taxUserNm3}"/></span>
										<span class="pL20">연락처 : <input type="text" class="input01 span_6" name="taxUserTelNo3" value="${result.taxUserTelNo3}"/></span>
										<br/>
									</div>
								</td>
							</tr>
							<tr>
								<td class="title2">수신자4</td>
								<td class="pL10" colspan="3">
									<div id="Receiver4">
										<span class="pL5">E-mail : <input type="text" class="input01 span_6" name="taxEmail4" value="${result.taxEmail4}"/></span>
										<span class="pL20">담당자 : <input type="text" class="input01 span_6" name="taxUserNm4" value="${result.taxUserNm4}"/></span>
										<span class="pL20">연락처 : <input type="text" class="input01 span_6" name="taxUserTelNo4" value="${result.taxUserTelNo4}"/></span>
										<br/>
									</div>
								</td>
							</tr>
							<tr>
								<td class="title2">수신자5</td>
								<td class="pL10" colspan="3">
									<div id="Receiver5">
										<span class="pL5">E-mail : <input type="text" class="input01 span_6" name="taxEmail5" value="${result.taxEmail5}"/></span>
										<span class="pL20">담당자 : <input type="text" class="input01 span_6" name="taxUserNm5" value="${result.taxUserNm5}"/></span>
										<span class="pL20">연락처 : <input type="text" class="input01 span_6" name="taxUserTelNo5" value="${result.taxUserTelNo5}"/></span>
										<br/>
									</div>
								</td>
							</tr>
							<tr>
								<td class="title">발행일(*)</td>
								<td colspan="2" class="pL10">
									<input type="text" class="input01 span_5 calGen" name="publishDate" value="${result.publishDate}"/>
								</td>
								<td class="title">영세율</td>
								<td class="pL10">
									<input type="checkbox" class="check" name="zeroTaxRate" value="Y" id="zeroTaxRate" <c:if test="${result.zeroTaxRate=='Y'}">checked</c:if>/>
								</td>
							</tr>
							<tr>
								<td class="title" rowspan="2">금액(*)</td>
								<td id="Expenses" class="pL10" colspan="4">
									<c:forEach items="${resultExpenseList}" var="expense" varStatus="c">
									<div id="expenseList[${c.count}]">
										<input type="hidden" name="expenseArray[${c.count}].expenseNo" value="${expense.expenseNo}" />
										<input type="hidden" name="expenseArray[${c.count}].useAt" value="Y" />
										<input type="text" class="input01 span_8 currency" name="expenseArray[${c.count}].expense" id="exp${c.count}" value="<print:currency cost='${expense.expense}' />"/> 원&nbsp;
										<label><input type="checkbox" class="check" name="expenseArray[${c.count}].containVat" value="Y" id="expVat${c.count}" <c:if test="${expense.containVat == 'Y'}">checked="checked"</c:if>/> VAT 포함</label>
										<span class="pL10"></span>비고 : <input type="text" class="input01 span_10" name="expenseArray[${c.count}].note" value="${expense.note}"/>&nbsp;
										<c:if test="${c.count != 1}"><img src="../../images/btn/btn_delete04.gif" class="search_btn02 cursorPointer" onclick="javascript:removeExpense('${c.count}');"/></c:if>
										<br/>
									</div>
									</c:forEach>
									<img id="addExpenseBtn" src="../../images/btn/btn_add03.gif" class="search_btn02 cursorPointer" onclick="javascript:addExpense();" />
								</td>
							</tr>
							<tr>
								<td class="pL10" colspan="2">
									공급가액 : <span id="supSum"><print:currency cost="${result.supSum}" /></span>원<br/>
									 세액 : <span id="taxSum"><print:currency cost="${result.taxSum}" /></span>원<br/>
									 합계 : <span id="pubSum"><print:currency cost="${result.pubSum}" /></span>원<br/>
								</td>
								<td class="title">청구/영수</td>
								<td class="pL10"><label><input type="radio" class="radio" name="bondTyp" value="1" <c:if test="${result.bondTyp == 1}">checked="checked"</c:if>/> 청구</label> <label><input type="radio" class="radio" name="bondTyp" value="2" <c:if test="${result.bondTyp == 2}">checked="checked"</c:if>/> 영수</label></td>
							</tr>
							<tr>
								<td class="title">비고</td>
								<td class="pL10" colspan="4"><textarea class="span_24" name="bondCn">${result.bondCn}</textarea></td>
							</tr>
							<tr>
								<td class="title" rowspan="2">첨부파일</td>
								<td class="pL10" colspan="4">
									<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${result.atchFileId}" />
									</c:import>
									<c:if test="${result.atchFileId == ''}">
										<input type="hidden" name="fileListCnt" value="0" />
									</c:if>
									<div id="file_upload_posbl"  style="display:none;" >	
										<input name="file_1" id="egovComFileUploader" type="file" />
										<div id="egovComFileList"></div>
									</div>
									<div id="file_upload_imposbl"  style="display:none;" >
										<spring:message code="common.imposbl.fileupload" />
									</div>		    
												
									<script type="text/javascript">
									var existFileNum = document.taxPublishVO.fileListCnt.value;	    
									var maxFileNum = document.taxPublishVO.posblAtchFileNumber.value;
									
									if (existFileNum=="undefined" || existFileNum ==null) {
										existFileNum = 0;
									}
									if (maxFileNum=="undefined" || maxFileNum ==null) {
										maxFileNum = 0;
									}		
									var uploadableFileNum = maxFileNum - existFileNum;
									if (uploadableFileNum<0) {
										uploadableFileNum = 0;
									}				
									if (uploadableFileNum != 0) {
										fn_egov_check_file('Y');
										var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum );
										multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
									} else {
										fn_egov_check_file('N');
									}			
									</script>
								</td>
							</tr>
						</tbody>
						</table>
					</div>
					<!--// 게시판 끝  -->
					
					<p class="th_stitle">채권관리 정보</p>
					<span class="stxt">이 세금계산서와 관련하여 매출을 보고한(또는 보고 예정인) 프로젝트를 선택해 주시기 바랍니다.</span>
					<!-- 게시판 시작  -->
					<div class="boardWrite02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup>
							<col class="col100" />
							<col width="px" />
						</colgroup>
						<tbody>
							<tr>
								<td class="title" rowspan="2">관련프로젝트</td>
								<td id="Projects" class="pL10">
									<c:forEach items="${resultProjectList}" var="project" varStatus="c">
										<div id="projectList[${c.count}]">
											<input type="hidden" name="project[${c.count}].prjNo" value="${project.prjNo}" ><input type="hidden" name="project[${c.count}].useAt" value="Y" ><input type="text" name="prjId2[${c.count}]" id="searchPrjNm${c.count}" class="span_11 input01" readonly="readonly" onclick="prjGen('searchPrjNm${c.count}','searchPrjId${c.count}',1);" value="${project.prjNm}"/>
											<input type="hidden" name="project[${c.count}].prjId" id="searchPrjId${c.count}" value="${project.prjId}" > <img src="${imagePath}/btn/btn_tree.gif" onclick="prjGen('searchPrjNm${c.count}','searchPrjId${c.count}',1);" class="cursorPointer">
											<span class="pL20"></span>금액(원) <input type="text" class="input01 span_6 currency" name="project[${c.count}].prjExpense" id="prj${c.count}" value="<print:currency cost='${project.prjExpense}' />"/>
											<c:if test="${c.count != 1}"><img src="../../images/btn/btn_delete04.gif" class="search_btn02 cursorPointer" onclick="javascript:removeProject('${c.count}')"/></c:if>
										</div>
									</c:forEach>
									<div id="addProjectBtn"><input type="image" src="../../images/btn/btn_add03.gif" class="search_btn02 cursorPointer" onclick="javascript:addProject();"/> <span class="T11"> 여러 프로젝트의 매출에 대해 세금계산서를 1건으로 발행하는 경우에만 추가해 주세요.</span></div>
								</td>
							</tr>
							<tr>
								<td class="pL10">※ 총 공급가액을 각 프로젝트별로 배분해 주시기 바랍니다.<br>
								공급가액 : <span id="supChkSum">0</span>원 / 프로젝트별 금액 총합 : <span id="prjSum">0</span>원</td>
							</tr>
						</tbody>
						</table>
					</div>
					<!--// 게시판 끝  -->
					
					<!-- 버튼 시작 -->
					<div class="btn_area">
						<img src="../../images/btn/btn_regist.gif" onclick="javascript:reInsertTaxPublish();" class="cursorPointer"/>
						<a href="javascript:cancelTaxPublish('${result.bondId}');"><img src="../../images/btn/btn_cancel.gif" /></a>
					</div>
					<!-- 버튼 끝 -->

					</form:form>
				</div>
				<!-- E: section -->
			</div>
			<!-- E: center -->				
			<%@ include file="../include/right.jsp"%>
			</div>	
			<!-- E: centerBg -->
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
