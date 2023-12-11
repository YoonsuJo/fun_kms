<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
</head>

<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFile.js'/>" ></script>

<script>

// 품목 cnt
var contentsIdx;
var contentsCnt;

// 프로젝트 cnt
var projectIdx;
var projectCnt;

/* TENY_170130 재구성함 */
$(document).ready(function() {
	addPriceEvent();  // 품목의 공급가액을 입력하면 자동으로 부가세, 공급가, 총합계(공급가, 부가세, 합계)금액을 자동으로 계산해주는 이벤트함수
	addSumEvent();  // 품목의 합계금액을 입력하면 자동으로 부가세, 공급가, 총합계(공급가, 부가세, 합계)금액을 자동으로 계산해주는 이벤트함수
	addPrjSumEvent();
	
	addCustInfoEvent();
	addTaxZeroEvent();
	addRepeatEvent();

	contentsIdx = parseInt($('#rstContentsListCnt').val());
	contentsCnt = parseInt($('#rstContentsListCnt').val());

	// 프로젝트 cnt
	projectIdx = parseInt($('#rstProjectListCnt').val());
	projectCnt = parseInt($('#rstProjectListCnt').val());
});

//  TENY_170217 priceEvent()를 등록하는 함수
//
function addPriceEvent(){

	$('#invoiceVOFm').find(".price").keyup(function(){
		priceEvent();
//		if ($(this).val().length != 0)
//			jsMakeCurrency(this);
	});
}

//TENY_170217 품목의 공급가액을 입력하면 자동으로 부가세, 공급가, 총합계(공급가, 부가세, 합계)금액을 자동으로 계산해주는 이벤트함수
//
function priceEvent() {
	// 공급가액, 세액, 합계  계산
	var price;
	var vat;
	var totalPrice = 0;
	var totalVat = 0;
	var totalSum = 0;

	for (var i = 0; i < contentsIdx; i++) {

//		if(	$('input[name^="contentsVOList[0]"]').length <= 0)
		if($('#price' + i).length > 0){
			price = parseInt(Math.round(jsDeleteComma($('#price' + i).val())));
			if($('#taxZero').is(":checked")){
				vat = 0;
			} else {
				vat = Math.round(price / 10);
			}
			document.getElementById('vat' + i).value = vat;
			document.getElementById('sum' + i).value = price + vat;
	
			jsMakeCurrency(document.getElementById('price'+ i));
			jsMakeCurrency(document.getElementById('vat'+ i));
			jsMakeCurrency(document.getElementById('sum'+ i));
	
			totalPrice = totalPrice + price;
			totalVat = totalVat + vat;
		}
	}
	totalSum = totalPrice + totalVat;

	document.getElementById('totalPrice').value = totalPrice;
	document.getElementById('totalVat').value = totalVat;
	document.getElementById('totalSum').value = totalSum;
//	document.getElementById('0').value = totalPrice;
	
	jsMakeCurrency(document.getElementById('totalPrice'));
	jsMakeCurrency(document.getElementById('totalVat'));
	jsMakeCurrency(document.getElementById('totalSum'));
//	jsMakeCurrency(document.getElementById('0'));

/*		TENY_170212  input이 아닌경우 아래를 쓴다 ^^
		$('#totalPrice').html(jsAddComma(roundXL(totalPrice,0)));
		$('#totalVat').html(jsAddComma(roundXL(totalVat,0)));
		$('#totalSum').html(jsAddComma(roundXL(totalSum,0)));
*/		
	prjSumEvent();
}

function addSumEvent(){

	$('#invoiceVOFm').find(".sum").keyup(function(){
		sumEvent();
	});
}

//  TENY_170212 품목의 합계금액을 입력하면 자동으로 부가세, 공급가, 총합계(공급가, 부가세, 합계)금액을 자동으로 계산해주는 이벤트함수
//
function sumEvent() {
	var price;
	var vat;
	var sum;
	var totalPrice = 0;
	var totalVat = 0;
	var totalSum = 0;

	for (var i = 0; i < contentsIdx; i++) {

		if($('#sum' + i).length > 0){

			sum = parseInt(Math.round(jsDeleteComma($('#sum' + i).val())));
			if($('#taxZero').is(":checked")){
				vat = 0;
				price = sum;
			} else {
				price = Math.round(sum / 1.1);
				vat = sum - price;
			}
			document.getElementById('price' + i).value = price;
			document.getElementById('vat' + i).value = vat;
			
			jsMakeCurrency(document.getElementById('price'+i));
			jsMakeCurrency(document.getElementById('vat'+i));
			jsMakeCurrency(document.getElementById('sum'+i));
			
			totalPrice = totalPrice + price;
			totalVat = totalVat + vat;
		}
	}
	totalSum = totalPrice + totalVat;

	document.getElementById('totalPrice').value = totalPrice;
	document.getElementById('totalVat').value = totalVat;
	document.getElementById('totalSum').value = totalSum;
//	document.getElementById('prjSum0').value = totalPrice;

	jsMakeCurrency(document.getElementById('totalPrice'));
	jsMakeCurrency(document.getElementById('totalVat'));
	jsMakeCurrency(document.getElementById('totalSum'));
//	jsMakeCurrency(document.getElementById('prjSum0'));
	
	prjSumEvent();
}

//TENY_170212  prjSumEvent 이벤트함수를 등록해 주는 함수
function addPrjSumEvent(){

	$('#invoiceVOFm').find(".prjSum").keyup(function(){
		prjSumEvent(this);
	});
}

// 관련 프로젝트를 여러개 만들었을때 프로젝트별 금액 배분을 자동으로 해주는 이벤트함수
// 총공급가 금액에서 나머지 관련프로젝트 금액을 뺀 나머지 금액을 첫번째 프로젝트 금액으로 한다. 
function prjSumEvent(varObj) {

	var totalSum = parseInt(jsDeleteComma($('#totalSum').val()));

	// 프로젝트 별 금액 총합을 계산
	var tmpSum = 0;
	var tmpPrice = 0;
	for (var i = 1; i < projectIdx; i++) {

		if($('#prjsum' + i).length > 0){
			tmpSum = parseInt(jsDeleteComma($('#prjsum' + i).val()));
			tmpPrice =  Math.round(tmpSum/1.1);

			$('#prjprice' + i ).val(tmpPrice);
			jsMakeCurrency(document.getElementById('prjprice' + i));
			$('#prjvat' + i ).val(tmpSum - tmpPrice);
			jsMakeCurrency(document.getElementById('prjvat' + i));
			$('#prjsum' + i ).val(tmpSum);
			jsMakeCurrency(document.getElementById('prjsum' + i));

			totalSum =  totalSum - tmpSum;
		}
	}
	tmpPrice =  Math.round(totalSum/1.1);
	document.getElementById('prjprice0').value = tmpPrice;
	jsMakeCurrency(document.getElementById('prjprice0'));
	document.getElementById('prjvat0').value = totalSum - tmpPrice;
	jsMakeCurrency(document.getElementById('prjvat0'));
	document.getElementById('prjsum0').value = totalSum;
	jsMakeCurrency(document.getElementById('prjsum0'));
}

function addRepeatEvent() {

	$('#repeat').change(function(){
		repeatEvent();
	});

	function repeatEvent() {
		if ($('#repeat').is(":checked")) {
			if(confirm("반복발행을 선택하시면 종료일까지 같은날 반복적으로 세금계선서가 발행됩니다" + 
					"\n발행요청시작일은 지정월의 첫날로 변경됩니다\n원하지 않으시면 해제해 주세기바랍니다")){
				var startDate = $('#publishReqDate').val();
				if(startDate.length >= 6)
				$('#publishReqDate').val(startDate.substr(0, 6) + "01");
				$('#repeatDateDiv').show();
			}
		} else {
			$('#repeatDateDiv').hide();
		}
	};
}

function addTaxZeroEvent() {

	$('#taxZero').change(function(){
		taxZeroEvent();
	});
	
	function taxZeroEvent() {
		if($('#taxZero').is(":checked")){
			alert("영세율을 설정합니다 \n 영세율이 설정되면 부가세를 추가하지 않습니다");
			if(confirm("합계금액을 중심으로 영세율을 적용하시겠습니까?\n 공급액을 중심으로 영세율을 적용하시려면 취소를 선택하세요") != 0) {
				sumEvent();			
			}
			else{
				priceEvent();
			}
		}
		else{
			alert("영세율을 적용을 해제합니다 \n 영세율 설정해제되면 합계금액에 부가세(10%)를 추가합니다");
			if(confirm("합계금액을 중심으로 영세율을 적용을 해제하시겠습니까?\n 공급액을 중심으로 영세율을 적용하시려면 취소를 선택하세요") != 0) {
				sumEvent();			
			}
			else{
				priceEvent();
			}
		}
	};
}


var searchKeyword = null;
var searchAction = null;

function addCustInfoEvent(){
	var custDiv = null;
	var searchType = '';
	
/* TENY_170211  기존에 작성했던 세금계산서(invoice)정보에서 고객정보를 가져오는 방식 */ 
	$('#searchFromInvoice').click(function() {
		searchType = 'invoice';
		popCustSearch();
	});

/* TENY_170211  고객DB에서 가져오는 방식은 추후 구현하기로 함 
	$('#searchFromCustomer').click(function() {
		searchType = 'cust';
		popCustSearch();
	});
*/
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
		var position = $('#searchFromInvoice').offset();
		// custDiv.css("left",(position.left - 20)+"px");
		// custDiv.css("top",(position.top - 5)+"px");
		// custDiv.css("position","absolute");

		$('[name=custSearchKeyword]').keyup(function(){

			searchKeyword = this.value;
			if(searchAction)
			{
				clearTimeout( searchAction );
		    }
			searchAction = setTimeout(searchCustInfoFn, 500);
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
	
	function searchCustInfoFn(){

		if (searchKeyword == "") {
			return;
		}
		
		$.post("invoiceCustInfoListAjax.do",
		{
			searchCompanyName: searchKeyword, searchType: searchType
		} ,function(data){

			var size = $(data).find('.custInfoListLi').size();
			if (size == 0) {
				return;
			}
			custDiv.find('.ui_List').html(data);
			$('body').bind('click.customer', function custLayerClickEvent(event){
					if (!$(event.target).closest(custDiv).length) {
						custDiv.hide();
						$('body').unbind('click.customer');
				    };
				}
			);

			$('.custInfoListLi').click(function(){
				$('[name=custCompanyName]').val($(this).find('[name=custILLi_custCompanyName]').val());
				$('[name=custCeoName]').val($(this).find('[name=custILLi_custCeoName]').val());
				$('[name=custAddress]').val($(this).find('[name=custILLi_custAddress]').val());
				$('[name=custBusiNo]').val($(this).find('[name=custILLi_custBusiNo]').val());
				$('[name=custBusiType]').val($(this).find('[name=custILLi_custBusiType]').val());
				$('[name=custBusiKind]').val($(this).find('[name=custILLi_custBusiKind]').val());

				$('[name=custName1]').val($(this).find('[name=custILLi_custName1]').val());
				$('[name=custName2]').val($(this).find('[name=custILLi_custName2]').val());
				$('[name=custName3]').val($(this).find('[name=custILLi_custName3]').val());
				$('[name=custName4]').val($(this).find('[name=custILLi_custName4]').val());
				$('[name=custName5]').val($(this).find('[name=custILLi_custName5]').val());

				$('[name=custEmail1]').val($(this).find('[name=custILLi_custEmail1]').val());
				$('[name=custEmail2]').val($(this).find('[name=custILLi_custEmail2]').val());
				$('[name=custEmail3]').val($(this).find('[name=custILLi_custEmail3]').val());
				$('[name=custEmail4]').val($(this).find('[name=custILLi_custEmail4]').val());
				$('[name=custEmail5]').val($(this).find('[name=custILLi_custEmail5]').val());

				$('[name=custTelNo1]').val($(this).find('[name=custILLi_custTelNo1]').val());
				$('[name=custTelNo2]').val($(this).find('[name=custILLi_custTelNo2]').val());
				$('[name=custTelNo3]').val($(this).find('[name=custILLi_custTelNo3]').val());
				$('[name=custTelNo4]').val($(this).find('[name=custILLi_custTelNo4]').val());
				$('[name=custTelNo5]').val($(this).find('[name=custILLi_custTelNo5]').val());

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

/* TENY_170130 
 * 계산서의 세부항목을 한줄 늘리는 함수
 */
function addContents(){

	var disabled = '';
	if ($('#zeroTaxRate:checked').length == 1) {	// 영세율 구분
		disabled = 'disabled="disabled"';
	}
	var contentsDiv = $('<div id="contentsList[' 
			+ contentsIdx + ']"><span class="pL2"></span><input type="text" class="span_10 input01" name="contentsVOList[' 
			+ contentsIdx + '].productName" id="productName' 
			+ contentsIdx + '" /><span class="pL5"> </span><input type="text" class="span_5 input02 price" name="contentsVOList[' 
			+ contentsIdx + '].price" id="price'
			+ contentsIdx + '"/><span class="pL5"> </span><input type="text" class="span_5 input02 currency" readonly="readonly" name="contentsVOList[' 
			+ contentsIdx + '].vat" id="vat'
			+ contentsIdx + '"/><span class="pL5"> </span><input type="text" class="span_5 input02 sum" name="contentsVOList['
			+ contentsIdx + '].sum" id="sum' 
			+ contentsIdx + '"/><span class="pL5"> </span><input type="text" class="span_11 input01" name="contentsVOList[' 
			+ contentsIdx + '].note" id="note' 
			+ contentsIdx + '"/> <img src="../../images/btn/btn_delete04.gif" class="search_btn02 cursorPointer" onclick="javascript:removeContents(' 
			+ contentsIdx + ');" /></div>' );
	
//	var addBtn = $('#addContentsBtn').clone();
//	$('#addContentsBtn').remove();
	contentsDiv.appendTo($('#Contents'));
//	addBtn.appendTo($('#Contents'));
	contentsIdx++;
	contentsCnt++;

	addPriceEvent();
	addSumEvent();
}

function removeContents(num) {
	$('#contentsList\\[' + num + '\\]').remove();
	contentsCnt--;

	priceEvent();
}

function addProject(){
	var project = $('<div id="projectList['+ projectIdx + ']"><input type="text" class="span_27 input01" name="projectVOList['
			+ projectIdx + '].prjName" id="prjName' + projectIdx + '" readonly="readonly" onclick="prjGen(prjName' + projectIdx + ', prjId'
			+ projectIdx + ',1);" /><input type="hidden" name="projectVOList['
			+ projectIdx + '].prjId" id="prjId'+ projectIdx + '" /> <img src="${imagePath}/btn/btn_tree.gif" onclick="prjGen(prjName' + projectIdx + ', prjId'
			+ projectIdx + ' , 1);" class="cursorPointer"><span class="pL20"/> <input type="text" class="input02 span_6 currency" readonly="readonly" name="projectVOList['
			+ projectIdx + '].price" id="prjprice' + projectIdx + '"/><span class="pL30"/> <input type="text" class="input02 span_6 " readonly="readonly" name="projectVOList['
			+ projectIdx + '].vat"   id="prjvat' + projectIdx + '" /><span class="pL30"/> <input type="text" class="input02 span_6 prjSum" name="projectVOList['
			+ projectIdx + '].sum" id="prjsum' + projectIdx + '" /><span class="pL30"/> <input type="text" class="input02 span_6 currency" readonly="readonly" name="projectVOList['
			+ projectIdx + '].collect" id="prjcollect' + projectIdx + '" value="0"/><span class="pL30"/><img src="../../images/btn/btn_delete04.gif" '
			+ 'class="search_btn02 cursorPointer" onclick="javascript:removeProject(' + projectIdx + ');"/></div>');

//	var addBtn = $('#addProjectBtn').clone();
//	$('#addProjectBtn').remove();
	project.appendTo($('#Projects'));
//	addBtn.appendTo($('#Projects'));
	projectIdx++;
	projectCnt++;

/*
	if (projectCnt == 2) {
//		$('#prjPrice0').attr("readonly", false);
//		$('#prjPrice0').closest('tbody').find('.title').attr('rowspan', '2');
		$('#prjPrice0').closest('tbody').append('<tr id="warning">' +
			'	<td class="pL10">※ 총 공급가액을 각 프로젝트별로 배분해 주시기 바랍니다.<br>' +
			'공급가액 : <span id="supChkSum">0</span>원 / 프로젝트별 금액 총합 : <span id="prjSum">0</span>원</td>' +
			'</tr>');
	}
*/
	addPrjSumEvent();

//	addMakeCurrencyEvent();
}

function removeProject(num) {
	$('#projectList\\[' + num + '\\]').remove();
	projectCnt--;
//	$('#contentsList\\[' + num + '\\]').remove();
//	contentsCnt--;

//	if (projectCnt == 1) {
//		$('#prjPrice0').attr("readonly", true);
//		$('#prjPrice0').closest('tbody').find('.title').attr('rowspan', '1');
//		$('#warning').remove();
//	}
	prjSumEvent();
}


/* TENY_170130
 * submit하기위한 함수
 */ 
function writeInvoice() {

	/* TENY_170213  각 필드값을 확인한다 */
	/* TENY_170213  제목 필드값을 확인한다. 비었으면 포커스 맞추고 종료 */
	var strTmp = "#title";
	if($(strTmp).val().length <= 0){
		alert("제목은 필수입력사항입니다");
		$(strTmp).focus();
		return;
	}
	strTmp = "[name=custCompanyName]";
	/* TENY_170213  회사명 필드값을 확인한다. 비었으면 포커스 맞추고 종료 */
	if($(strTmp).val().length <= 0 ){
		alert("회사명은 필수입력사항입니다");
		$(strTmp).focus();
		return;
	}
	
	/* TENY_170213  대표자 이름 필드값을 확인한다. 비었으면 포커스 맞추고 종료 */
	if($('[name=custCeoName]').val().length <= 0 ){
		alert("대표자 이름은 필수입력사항입니다");
		$('[name=custCeoName]').focus();
		return;
	}
	
	/* TENY_170213  주소 필드값을 확인한다. 비었으면 포커스 맞추고 종료 */
	if($('[name=custAddress]').val().length <= 0 ){
		alert("주소는 필수입력사항입니다");
		$('[name=custAddress]').focus();
		return;
	}
	
	/* TENY_170213  사업자번호의 필드값을 확인한다. 비었으면 포커스 맞추고 종료 */
	if($('[name=custBusiNo]').val().length <= 0 ){
		alert("사업자번호는 필수입력사항입니다");
		$('[name=custBusiNo]').focus();
		return;
	}
	
	/* TENY_170213  업태의 필드값을 확인한다. 비었으면 포커스 맞추고 종료 */
	if($('[name=custBusiType]').val().length <= 0 ){
		alert("업태는 필수입력사항입니다");
		$('[name=custBusiType]').focus();
		return;
	}
	
	/* TENY_170213  업종의 필드값을 확인한다. 비었으면 포커스 맞추고 종료 */
	if($('[name=custBusiKind]').val().length <= 0 ){
		alert("업종은 필수입력사항입니다");
		$('[name=custBusiKind]').focus();
		return;
	}
	
	/* TENY_170213  담당자1의 이름 필드값을 확인한다. 비었으면 포커스 맞추고 종료 */
	if($('[name=custName1]').val().length <= 0 ){
		alert("최소한 1명의 담당자 정보는 필수입력사항입니다");
		$('[name=custName1]').focus();
		return;
	}
	
	/* TENY_170213  담당자1의 이메일 필드값을 확인한다. 비었으면 포커스 맞추고 종료 */
	if($('[name=custEmail1]').val().length <= 0 ){
		alert("최소한 1명의 담당자 이메일 정보는 필수입력사항입니다");
		$('[name=custEmail1]').focus();
		return;
	}
	
	/* TENY_170213  담당자1의 연락처 필드값을 확인한다. 비었으면 포커스 맞추고 종료 */
	if($('[name=custTelNo1]').val().length <= 0 ){
		alert("최소한 1명의 담당자 연락처 정보는 필수입력사항입니다");
		$('[name=custTelNo1]').focus();
		return;
	}
	
	/* TENY_170213  품목1의 품목명 필드값을 확인한다. 비었으면 포커스 맞추고 종료 */
	if ($('#productName0').val().length <= 0) {
		alert("최소한 1개의 품목명 정보는 필수입력사항입니다");
		$('[name=productName1]').focus();
		return;
	}

	/* TENY_170213  품목1의 공급가 필드값을 확인한다. 비었으면 포커스 맞추고 종료 */
	if($('#price0').val().length <= 0 ){
		alert("최소한 1개의 공급가 정보는 필수입력사항입니다");
		$('#price0').focus();
		return;
	}

	/* TENY_170213  품목1의 합계 필드값을 확인한다. 비었으면 포커스 맞추고 종료 */
	if($('#sum0').val().length <= 0 ){
		alert("최소한 1개의 합계 정보는 필수입력사항입니다");
		$('#sum0').focus();
		return;
	}

	/* TENY_170213 발행요청일을 확인한다. 비었으면 포커스 맞추고 종료 */
	if ($('#publishReqDate').val().length <= 0) {
		alert("발행요청일 정보는 필수입력사항입니다");
		$('#publishReqDate').focus();
		return;
	}
	
	/* TENY_170213 수금예상일을 확인한다. 비었으면 포커스 맞추고 종료 */
	if ($('#collectExpectDate').val().length <= 0) {
		alert("수금예상일 정보는 필수입력사항입니다");
		$('#collectExpectDate').focus();
		return;
	}

	/* TENY_170213 관련프로젝트를 확인한다. 비었으면 포커스 맞추고 종료 */
	if ($('#prjName0').val().length <= 0) {
		alert("첫번째 관련프로젝트 정보는 필수입력사항입니다");
		$('#searchPrjNm0').focus();
		return;
	}
	if ($('#prjsum0').val().length <= 0) {
		alert("첫번째 관련프로젝트 금액은 필수입력사항입니다");
		$('#prjPrice0').focus();
		return;
	}

	/* TENY_170216  반복발행을 요청한 경우 */
	if($('#repeat').is(":checked") ){
		if(!confirm("확인바랍니다\n세금계산서 반복발행 요청건입니다\n반복발행시작일은 [" + "$('#publishReqDate').val().substr(0, 6)" +
			"01] 이고\n반복발행종료일은  [" + "$('#publishToDate').val().substr(0, 6)" + "31] 입니다\ 반복발행을 하시겠습니까?")){
			return;
		}
	}
	
	/*
	$('[name$=prjId]').each(function(){
		if ($(this).val().length == 0 && boolValidate) {
			boolValidate = false;
			alert('관련 프로젝트를 선택해주세요.');
		}
	});
	$('[name$=prjExpense]').each(function(){
		if ($(this).val().length == 0 && boolValidate) {
			boolValidate = false;
			alert('금액을 입력해주세요.');
		}
	});
*/	
	$('#invoiceVOFm').find(".prjSum, .price, .sum, .currency").each(function(){
		if($(this).val().length > 0){
			$(this).val(parseInt(jsDeleteComma($(this).val())));
		}
	});

	if($('#egovComFileList').children().length > 0) {
		$('#attachFileId').val("MODIFY");
	}
	
	var form = $('#invoiceVOFm');
	var contentsVO = $('#invoiceVOFm').toObject({mode: 'first'})['contentsVOList'];
	form.find("input[name=jsonContentsString]").val(escape(JSON.stringify(contentsVO)));
	var projectVO = $('#invoiceVOFm').toObject({mode: 'first'})['projectVOList'];
	form.find("input[name=jsonProjectString]").val(escape(JSON.stringify(projectVO)));

	//location.href = "${rootPath}/fund/taxPublishI.do?" + form.serialize();
	document.invoiceVOFm.action = '<c:url value="/fund/invoiceInsert.do" />';
	document.invoiceVOFm.submit();
}

</script>


<body>

<div id="pop_reg_div01">
 	<div id="pop_top">
		<ul>
			<li><img src="../images/inc/pop_bullet.gif" /></li>
			<li>세금계산서 발행요청(재사용)</li>
		</ul>
 	</div>
 	<div class="pop_reg_div02">
				<form:form commandName="invoiceVOFm" id="invoiceVOFm" name="invoiceVOFm" method="post" enctype="multipart/form-data" >
					<input type="hidden" name="invoiceId" value=""/>
					 <!--  첨부파일 수정을 구현하기 위하여 기존에 파일이 있었던 경우 attachFileId을 가져와 저장해 놓는다 -->
					 <!--  첨부파일에 변경이 없는 경우 없다가 계속없는 경우 : 기존의 attachFileId를 그대로 보낸다 -->
					 <!--  첨부파일에 변경이 있는 경우 : attachFileId에 MODIFY라고 적어보낸다-->
					<input type="hidden" name="posblAtchFileNumber" value="3" />
					<input type="hidden" name="jsonContentsString" value=""/>
					<input type="hidden" name="jsonProjectString" value=""/>
					<input type="hidden" name="attachFileId" id="attachFileId" value="${invoiceVO.attachFileId}"/> 
					<input type="hidden" name="rstContentsListCnt" id="rstContentsListCnt" value="${fn:length(rstContentsList)}" />
					<input type="hidden" name="rstProjectListCnt" id="rstProjectListCnt" value="${fn:length(rstProjectList)}" />
					<input name="searchMode" type="hidden" value="${invoiceVO.searchMode}"/>
					
					<!-- 세금계산서 발행 정보 시작  -->
					<p class="th_stitle">세금계산서 작성 정보</p>
					<div class="pop_board mT20">
						
						<table cellpadding="0" cellspacing="0" summary="세금계산서 작성 정보">
						<caption>세금계산서 작성 정보</caption>
						<colgroup>
							<col class="col100" />
							<col width="px" />
							<col class="col90" />
							<col class="col90" />
							<col class="col90" />
							<col class="col90" />
							<col class="col140" />
							<col class="col100" />
						</colgroup>

						<tbody>
							<tr>
								<td class="title">제    목(*)</td>
								<td class="pL10" colspan="3"><input type="text" class="input01 span_95p" name="title" id="title" value="${invoiceVO.title}"/></td>
								<td class="title" rowspan="6">담당자</td>
								<td class="title">이 름</td>
								<td class="title">이메일</td>
								<td class="title">연락처</td>
							</tr>
							<tr>
								<td class="title">회 사 명</td>
								<td class="pL10" colspan="3"><input type="text" class="input01 span_95p custNmAuto" name="custCompanyName" value="${invoiceVO.custCompanyName}"/>
									<img src="../../images/btn/btn_fromCustomerList.gif" class="cursorPointer" id="searchFromCustomer"/> 
									<img src="../../images/btn/btn_fromTaxPublishList.gif" class="cursorPointer" id="searchFromInvoice"/>
								</td>
								<td class="pL10" ><input type="text" class="input01 span_95p" name="custName1" value="${invoiceVO.custName1}"/></td>
								<td class="pL10" ><input type="text" class="input01 span_95p" name="custEmail1" value="${invoiceVO.custEmail1}"/></td>
								<td class="pL10" ><input type="text" class="input01 span_95p" name="custTelNo1" value="${invoiceVO.custTelNo1}"/></td>
							</tr>
							<tr>
								<td class="title">대 표 자</td>
								<td class="pL10" colspan="3"><input type="text" class="input01 span_95p" name="custCeoName" value="${invoiceVO.custCeoName}"/></td>
								<td class="pL10" ><input type="text" class="input01 span_95p" name="custName2" value="${invoiceVO.custName2}"/></td>
								<td class="pL10" ><input type="text" class="input01 span_95p" name="custEmail2" value="${invoiceVO.custEmail2}"/></td>
								<td class="pL10" ><input type="text" class="input01 span_95p" name="custTelNo2" value="${invoiceVO.custTelNo2}"/></td>
							</tr>
								<td class="title">사업자번호</td>
								<td class="pL10" colspan="3"><input type="text" class="input01 span_95p" name="custBusiNo" value="${invoiceVO.custBusiNo}"/></td>
								<td class="pL10" ><input type="text" class="input01 span_95p" name="custName3" value="${invoiceVO.custName3}"/></td>
								<td class="pL10" ><input type="text" class="input01 span_95p" name="custEmail3" value="${invoiceVO.custEmail3}"/></td>
								<td class="pL10" ><input type="text" class="input01 span_95p" name="custTelNo3" value="${invoiceVO.custTelNo3}"/></td>
							</tr>
							<tr>
								<td class="title">주    소</td>
								<td class="pL10" colspan="3"><input type="text" class="input01 span_95p" name="custAddress" value="${invoiceVO.custAddress}"/></td>
								<td class="pL10" ><input type="text" class="input01 span_95p" name="custName4" value="${invoiceVO.custName4}"/></td>
								<td class="pL10" ><input type="text" class="input01 span_95p" name="custEmail4" value="${invoiceVO.custEmail4}"/></td>
								<td class="pL10" ><input type="text" class="input01 span_95p" name="custTelNo4" value="${invoiceVO.custTelNo4}"/></td>
							</tr>
							<tr>
								<td class="title">업    태</td>
								<td class="pL10" ><input type="text" class="input01 span_95p" name="custBusiType" value="${invoiceVO.custBusiType}"/></td>
								<td class="title">업    종</td>
								<td class="pL10" ><input type="text" class="input01 span_95p" name="custBusiKind" value="${invoiceVO.custBusiKind}"/></td>
								<td class="pL10" ><input type="text" class="input01 span_95p" name="custName5" value="${invoiceVO.custName5}"/></td>
								<td class="pL10" ><input type="text" class="input01 span_95p" name="custEmail5" value="${invoiceVO.custEmail5}"/></td>
								<td class="pL10" ><input type="text" class="input01 span_95p" name="custTelNo5" value="${invoiceVO.custTelNo5}"/></td>
							</tr>
							<tr >
								<td id="ContentsTitle" class="title" rowspan="3"  >금    액</td>
								<td class="title">품    목</td>
								<td class="title">공급액</td>
								<td class="title">부가세</td>
								<td class="title">합    계</td>
								<td class="title" colspan="3">비       고</td>
							</tr>
							<tr >
								<td class="pL10" colspan="7" id = "Contents">
								<c:forEach items="${rstContentsList}" var="contents" varStatus="c">
									<div id="contentsList[${c.index}]">
										<span class="pL2"></span>
										<input type="text" class="span_10 input01" name="contentsVOList[${c.index}].productName" id="productName${c.index}" value="${contents.productName}"/>
										<span class="pL5"></span>
										<input type="text" class="span_5 input02 price" name="contentsVOList[${c.index}].price" id="price${c.index}" value="<print:currency cost='${contents.price}' />"/>
										<span class="pL5"></span>
										<input type="text" class="span_5 input02 currency" name="contentsVOList[${c.index}].vat" id="vat${c.index}" value="<print:currency cost='${contents.vat}' />"  readonly="readonly"/>
										<span class="pL5"></span>
										<input type="text" class="span_5 input02 sum" name="contentsVOList[${c.index}].sum" id="sum${c.index}" value="<print:currency cost='${contents.sum}' />"/>
										<span class="pL5"></span>
										<input type="text" class="span_11 input01" name="contentsVOList[${c.index}].note" id="note${c.index}" value="${contents.note}"/>
									<c:choose>
										<c:when test="${c.index == '0'}">
											<img src="../../images/btn/btn_add03.gif" class="search_btn02 cursorPointer" onclick="javascript:addContents();" />
										</c:when>
										<c:otherwise>
											<img src="../../images/btn/btn_delete04.gif" class="search_btn02 cursorPointer" onclick="javascript:removeContents(${c.index});" />
										</c:otherwise>
									</c:choose>
									</div>
								</c:forEach>
								</td>
							</tr>
							<tr>
								<td class="title">총 합 계</td>
								<td class="pL10" ><input type="text" class="input02 span_95p currency" readonly="readonly" name="totalPrice" id="totalPrice" value="<print:currency cost='${invoiceVO.totalPrice}' />" /></td>
								<td class="pL10" ><input type="text" class="input02 span_95p currency" readonly="readonly" name="totalVat" id="totalVat" value="<print:currency cost='${invoiceVO.totalVat}' />" /></td>
								<td class="pL10" ><input type="text" class="input02 span_95p currency" readonly="readonly" name="totalSum" id="totalSum" value="<print:currency cost='${invoiceVO.totalSum}' />" /></td>
								<td class="title">발행구분</td>
								<td class="pL10" >
									<c:choose>
										<c:when test="${invoiceVO.publishType == '1'}">
											<label>&nbsp;<input type="radio" class="radio" name="publishType"  value="1" checked="checked"/>청구</label> 
											<label>&nbsp;<input type="radio" class="radio" name="publishType"  value="2"/>영수</label>
										</c:when>
										<c:otherwise>
											<label>&nbsp;<input type="radio" class="radio" name="publishType"  value="1" />청구</label>
											<label>&nbsp;<input type="radio" class="radio" name="publishType"  value="2" checked="checked"/>영수</label> 
										</c:otherwise>
									</c:choose>
								</td>
								<td class="title">영 세 율
									<c:choose>
										<c:when test="${invoiceVO.taxZero == 'Y'}">
											<input type="checkbox" class="check" name="taxZero" id="taxZero" value="Y" checked="checked"/>
										</c:when>
										<c:otherwise>
											<input type="checkbox" class="check" name="taxZero" id="taxZero" value="Y" />
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<tr>
								<td class="title" rowspan="2">첨부파일</td>
								<td class="pL10" colspan="7"> * 첨부파일을 수정하시려면 기존첨부파일을 다운로드받아 재첨부하셔야 합니다.
									<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${invoiceVO.attachFileId}" />
									</c:import>
								</td>
							</tr>
							<tr>
								<td class="pL10" colspan="7"><input type="file" class="w_input01" name="file_1" id="egovComFileUploader"/><div class="boardWrite02 mB20" id="egovComFileList"></div>
									<script type="text/javascript">
										var maxFileNum = document.invoiceVOFm.posblAtchFileNumber.value;
										if(maxFileNum==null || maxFileNum==""){
											maxFileNum = 3;
										}
										var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
										multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
									</script>
								</td>
							</tr>
						</tbody>
						</table>
					</div>
					<!-- 세금계산서 발행 정보 끝  -->
			
					<!-- 발행 요청 정보 시작  -->
					<p class="th_stitle">발행 요청 정보</p>
					<div class="pop_board mT20">
						
						<table cellpadding="0" cellspacing="0" summary="발행 요청 정보">
						<caption>발행 요청 정보</caption>
						<colgroup>
							<col class="col100" />
							<col class="col200" />
							<col class="col100" />
							<col class="col300" />
						</colgroup>

						<tbody>
							<tr>
								<td class="title">발행회사</td>
								<td class="title">발행요청일</td>
								<td class="title">수금예상일</td>
								<td class="title">특이사항</td>
							</tr>
							<tr>
								<td class="pL10 cent" align="center">
									<select  name="publishCoAcronym" id="publishCoAcronym" class="select01" >
										<c:forEach items="${companyList}" var="company">
										<c:choose>
											<c:when test="${company.codeDc == rstInvoiceVO.publishCoAcronym }">
												<option value="${company.codeDc}" selected > ${company.codeNm} </option>
											</c:when>
											<c:when test="${company.code == user.expCompId}">
												<option value="${company.codeDc}" selected > ${company.codeNm} </option>
											</c:when>
											<c:otherwise>
												<option value="${company.codeDc}"> ${company.codeNm} </option>
											</c:otherwise>
										</c:choose>
										</c:forEach>
									</select>
								</td>
								<td class="pL10">
									<div id="repeatDiv">
										<input type="text" class="input03 w100 calGen"  readonly="readonly" name="publishReqDate" id="publishReqDate" value="${invoiceVO.publishReqDate}"/>&nbsp;
										<input type="checkbox" class="check" name="repeat" id="repeat" value="Y" /> 반복발행
										<div id="repeatDateDiv" style="display:none;">
											<input type="text" class="input03 w100 calGen" readonly="readonly" name="publishToDate" id="publishToDate"/>&nbsp;까지 매월 
											<input type="text" class="w30" name="publishAtDate" onfocus="numGen(this,1,31,7);" value="1" />일 <br/>(※ 해당일이 없는 달은 말일에 발행)
										</div>
									</div>
								</td>
								<td class="pL10" ><input type="text" class="w100 span_4 calGen" readonly="readonly" name="collectExpectDate" id="collectExpectDate" value="${invoiceVO.collectExpectDate}"/></td>
								<td class="pL10" ><textarea class="w98%" name="comment" >${invoiceVO.comment}</textarea></td>
							</tr>
						</tbody>
						</table>
					</div>
					<!--  발행 요청 정보 끝  -->

					<p class="th_stitle">관련 프로젝트 정보</p>
					<span class="stxt">여러 프로젝트의 매출에 대해 본건의 세금계산서를 발행하는 경우에만 추가해 주세요..</span>
					<div class="pop_board mT20">
						<table cellpadding="0" cellspacing="0" summary="">
						<colgroup>
							<col class="col200" />
							<col class="col100" />
							<col class="col100" />
							<col class="col100" />
							<col class="col100" />
							<col class="col40" />
						</colgroup>
						<tbody>
							<tr>
								<td class="title">관련프로젝트 명</td>
								<td class="title">공급가</td>
								<td class="title">부가세</td>
								<td class="title">합 계</td>
								<td class="title">수금액</td>
								<td class="title"></td>
							</tr>
							<tr>
								<td id="Projects" class="pL10" colspan="6">
								<c:forEach items="${rstProjectList}" var="project" varStatus="c">
									<div id="projectList[${c.index}]">
										<input type="text" class="span_27 input01" name="projectVOList[${c.index}].prjName" id="prjName${c.index}" 
												readonly="readonly" onclick="prjGen('prjName${c.index}','prjId${c.index}',1);" value="${project.prjName}"/>
										<input type="hidden" name="projectVOList[${c.index}].prjId" id="prjId${c.index}" value="${project.prjId}" />
										<img src="${imagePath}/btn/btn_tree.gif" onclick="prjGen('prjName${c.index}', 'prjId${c.index}', 1);" class="cursorPointer"><span class="pL20"></span> 
										<c:choose>
											<c:when test="${c.index == 0}">
												<input type="text" class="input02 span_6 currency" readonly="readonly" name="projectVOList[${c.index}].price" id="prjprice${c.index}" 
														value="<print:currency cost='${project.price}' />" /><span class="pL30"/>
												<input type="text" class="input02 span_6 " readonly="readonly" name="projectVOList[${c.index}].vat" id="prjvat${c.index}" 
														value="<print:currency cost='${project.sum - project.price}' />" /><span class="pL30"/>
												<input type="text" class="input02 span_6 prjSum" readonly="readonly" name="projectVOList[${c.index}].sum" id="prjsum${c.index}" 
														value="<print:currency cost='${project.sum}' />" /><span class="pL30"/>
												<input type="text" class="input02 span_6 " readonly="readonly" name="projectVOList[${c.index}].collect" id="prjcollect${c.index}" 
														value="0" /><span class="pL30"/><img src="../../images/btn/btn_add03.gif"
														class="cursorPointer" onclick="javascript:addProject();"/>
											</c:when>
											<c:otherwise>
												<input type="text" class="input02 span_6 currency" readonly="readonly" name="projectVOList[${c.index}].price" id="prjprice${c.index}" 
														value="<print:currency cost='${project.price}' />" /><span class="pL30"/>
												<input type="text" class="input02 span_6" readonly="readonly" name="projectVOList[${c.index}].vat" id="prjvat${c.index}" 
														value="<print:currency cost='${project.sum - project.price}' />" /><span class="pL30"/>
												<input type="text" class="input02 span_6 prjSum" name="projectVOList[${c.index}].sum" id="prjsum${c.index}" 
														value="<print:currency cost='${project.sum}' />" /><span class="pL30"/>
												<input type="text" class="input02 span_6 " readonly="readonly" name="projectVOList[${c.index}].collect" id="prjcollect${c.index}" 
														value="0" /><span class="pL30"/><img src="../../images/btn/btn_delete04.gif" 
														class="cursorPointer" onclick="javascript:removeProject(${c.index});"/>
											</c:otherwise>
										</c:choose>
									</div>
								</c:forEach>
								</td>
							</tr>
							<tr>
								<td class="pL10" colspan="6">
									<div id="addProjectBtn"> 
									</div>
								</td>
							</tr>
						</tbody>
						</table>
					</div>
					<!--// 프로젝트별 금액구분  -->

					<!-- 버튼 시작 -->
					<div class="btn_area">
						<img src="../../images/btn/btn_regist.gif" onclick="javascript:writeInvoice();" class="cursorPointer"/>
						<img src="../../images/btn/btn_cancel.gif" onclick="javascript:window.close();" class="cursorPointer"/>
					</div>  <!-- btn_area -->
				</form:form>  <!-- invoiceVOFm -->
	</div> <!-- container -->
</div> <!-- wrap -->
</body>
</html>

