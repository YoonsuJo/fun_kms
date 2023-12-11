<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="bondCollect" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='${commonPath}/js/jquery.validate.js'/>" ></script>

<script>

var g_totalSum;
var g_totalCollectOld;

/////   1. Setting in Loading 
$(document).ready(function() {
	// 본세금계산서에서 발행된 총 발행금액을 저장한다.
	g_totalSum = parseInt(Math.round(jsDeleteComma($('#totalSum').val() ) ) );
	// 현재까지 수금된총 금액을 저장한다.
	g_totalCollectOld = parseInt(Math.round(jsDeleteComma($('#totalCollectOld').val() ) ) );

	/* 현재날짜를 수금일로 세팅한다 */
	var d = new Date();
	var month = "";
	var date = "";
	if(d.getMonth() < 9){
		month = "0";
	}
	if(d.getDate() < 10){
		date = "0";
	}
	var dateString = d.getFullYear() + month + (d.getMonth() + 1) + date + d.getDate();
	$('#collectDate').val(dateString);
	
	/* 미수금액은 기본으로 현재까지의 미수금 즉 총발행액에서 지금까지의 총수금을 뺀금액으로 설정한다 */
	$('#totalCollect').val(g_totalSum - g_totalCollectOld);
	jsMakeCurrency(document.getElementById('totalCollect'));

	// 프로젝트별 수금액은 일단 그동안 수금되었던 금액과 오늘 받는 돈을 합친돈이 현재까지 받은 수금액
	$('#prjCollect0').val(g_totalSum - g_totalCollectOld);
	jsMakeCurrency(document.getElementById('prjCollect0'));

	addCollectEvent();  // 수금액을 입력하면 자동으로 미수금 금액을계산해주는 이벤트함수

	addPrjCollectEvent();  // 수금액을 입력하면 자동으로 미수금 금액을계산해주는 이벤트함수

	/* attribute가 currency인것은 key가 up될때 즉 입력이 이루어지고 나면 컴머가 표시되는 형식으로 바꾸어주는 이벤트를 단다.
	$('#CollectFm').find(".currency").keyup(function(){
		jsMakeCurrency(this);
	}); */
	
	$('.check').change(function(){
		var $this = $(this);
		var bankBook = $this.val();
		var companyDc = $this.data('codeValue');
		$('#companyCd').val(companyDc);
		$('#bankBook').val(bankBook);
	});
});

/////   2. Event Methods 
function addCollectEvent(){
	//TENY_170227 수금액을 입력하면 자동으로 미수금액을 자동으로 계산해주는 이벤트함수
	$('#totalCollect').keyup(function(){
		// 수금액 변경에 따라 미수금 수정
		// 변경된 수금액을 숫자로 바꾼뒤 다시 컴머가 들어간 형태로 바꾼다.
		var totalCollect = parseInt(Math.round(jsDeleteComma($('#totalCollect').val())));
		if(isNaN(totalCollect)) {
			totalCollect = 0;
		}
		$('#totalCollect').val(totalCollect);
		jsMakeCurrency(document.getElementById('totalCollect'));

		// 수정된 미수금액은 총발행금액에서 현재까지 수금된 금액과 근번 수금액을 뺀금액이다
		$('#totalUncollect').val(g_totalSum - g_totalCollectOld - totalCollect);
		jsMakeCurrency(document.getElementById('totalUncollect'));
		
		// 현재까지 수금된 금액과 근분 수금된 금액을을 첫번째 프로젝트 금액으로 입력한다.
		$('#prjCollect0').val(totalCollect);
		jsMakeCurrency(document.getElementById('prjCollect0'));
	});
}

function addPrjCollectEvent() {
	$('#CollectFm').find('.prjCollect').keyup(function(){
		var totalCollect = g_totalCollectOld + parseInt(jsDeleteComma($('#totalCollect').val()));
		var prjCount = $('#rstProjectListCnt').val();
		
		// 프로젝트 별 금액 총합을 계산
		var tmpPrjCollect = 0;
		var tmpPrice = 0;
		for (var i = 1; i < prjCount; i++) {
			if($('#prjCollect' + i).length > 0){
				tmpPrjCollect = parseInt(jsDeleteComma($('#prjCollect' + i).val()));
				if(isNaN(tmpPrjCollect)) {
					tmpPrjCollect = 0;
				}
				document.getElementById('prjCollect' + i).value = tmpPrjCollect;
				jsMakeCurrency(document.getElementById('prjCollect' + i));
				totalCollect =  totalCollect - tmpPrjCollect;
			}
		}
		document.getElementById('prjCollect0').value = totalCollect;
		jsMakeCurrency(document.getElementById('prjCollect0'));
	});
}

/////   3. Call Methods 

/////   4. Validation Check
function ValidationCheck() {
/* 	if( ($('#totalCollect').val().length <= 0 ) || ($('#totalCollect').val() <= 0) ){
		alert("수금액은 필수입력사항입니다");
		$('#totalCollect').focus();
		return false;
	}
 */
 	$('#CollectFm').find(".totalCollect, .prjCollect").each(function(){
		if($(this).val().length > 0){
			$(this).val(parseInt(jsDeleteComma($(this).val())));
		}
	});
	
	$('#type').val("D");
	$('#expense').val($('#totalCollect').val());
//	$('#note').val($('#note').val());
	
	return true;
}
/////   5. Submit Methods 
// 수금등록 버튼을 눌렀을때
function insertCollection(){
	/* TENY_170213  품목1의 공급가 필드값을 확인한다. 비었으면 포커스 맞추고 종료 */
	if( !ValidationCheck() ){
		return;
	}

	var form = $('#CollectFm');
	var projectVO = $('#CollectFm').toObject({mode: 'first'})['projectVOList'];
	form.find("input[name=jsonProjectString]").val(escape(JSON.stringify(projectVO)));

	//location.href = "${rootPath}/fund/taxPublishI.do?" + form.serialize();
	document.CollectFm.action = '<c:url value="/fund/invoiceCollectInsert.do" />';
	document.CollectFm.submit();
//	this.close();
}
// 수금등록후 자금등록까지 하는 메소드
function insertCollectionNFund(){
	/* TENY_170325  수금등록후 자금등록을 하려면 autoInsertFund를 Y값을 넣어 submit한다. */
	var checkList = document.getElementsByName("bankBookR");
	var isChecked = 0;	
	for(var i=0; i<checkList.length; i++) {
		if (checkList[i].checked) {
			isChecked = 1;
		}
	}
	if (isChecked == 0) {
		alert("수금등록후 자동자금보고를 하시려면 통장을 선택하셔야 합니다");
		return;
	}

	$('#autoInsertFund').val("Y");

	insertCollection();
}
//미수금등록 버튼을 눌렀을때
function endCollection(){
	/* TENY_170213  품목1의 공급가 필드값을 확인한다. 비었으면 포커스 맞추고 종료 */
	if( !ValidationCheck() ){
		return;
	}
	var totalCollect = parseInt(jsDeleteComma($('#totalCollect').val()));
	if(totalCollect > 0) {
		$('#autoInsertFund').val("Y");
	}
	var form = $('#CollectFm');
	var projectVO = $('#CollectFm').toObject({mode: 'first'})['projectVOList'];
	form.find("input[name=jsonProjectString]").val(escape(JSON.stringify(projectVO)));

	//location.href = "${rootPath}/fund/taxPublishI.do?" + form.serialize();
	document.CollectFm.action = '<c:url value="/fund/invoiceCollectEnd.do" />';
	document.CollectFm.submit();
//	this.close();
}
// 닫기버튼을 눌렀을때
function popClose(){
	this.close();
}

function deleteCollect() {
	var invoiceId = $('#invoiceId').val();
	
	$.ajax({
		url: "/fund/deleteCollectAjax.do",
		data: {
			invoiceId: invoiceId
		},
		type: "POST",
		async: false,
		dataType: "json",
		success: function(data) {
			// 수행 프로젝트가 아닐 경우, 오류메시지
			if (!data.RETURN.equals('OK')) {
				alert('수금정보가 적절하게 삭제되지 못하였습니다');
				return false;
			}
			location.reload();
		},
		error: function(xhr, testStatus, errorThrown) {
			alert("프로젝트에 대한 데이터를 가져오는데 실패하였습니다.");
  	 	}
	});
}

</script>
<body>
<div id="pop_reg_div01">
 	<div id="pop_top">
		<ul>
			<li><img src="../images/inc/pop_bullet.gif" /></li>
			<li class="popTitle">수금등록</li>
		</ul>
 	</div>
 	<div class="pop_reg_div02">
 	<form:form commandName="CollectFm" name="CollectFm" id="CollectFm" method="post" >
		<input type="hidden" name="invoiceId" id="invoiceId" 					value="${invoiceVO.invoiceId}" />
		<input type="hidden" name="jsonProjectString" 							value=""/>
		<input type="hidden" name="totalSum" id="totalSum" 					value="${invoiceVO.totalSum}"/>
		<input type="hidden" name="totalCollectOld" id="totalCollectOld" 	value="${invoiceVO.totalCollect}" />
		<input type="hidden" id="rstProjectListCnt" 				value="${fn:length(rstProjectList)}" />
		<input type="hidden" id="rstCollectCnt" 					value="${fn:length(rstCollectList)}" />
		<input type="hidden" name="autoInsertFund" 		id="autoInsertFund"		value=""/>
		<input type="hidden" name="bankBook" 				id="bankBook" 				value="" />
		<input type="hidden" name="account" 				id="account" 				value="ET" />
		<input type="hidden" name="companyCd" 			id="companyCd" 			value="" />
		<input type="hidden" name="title" 						id="title" 						value="${invoiceVO.title}" />
		<input type="hidden" name="custCompanyName" 	id="custCompanyName" 	value="${invoiceVO.custCompanyName}" />

		<div class="pop_board mT20" >
		<p class="th_stitle">세금계산서 정보</p>
 		<table cellpadding="0" cellspacing="0">
 			<colgroup>
 				<col class="col100" />
 				<col class="col100" />
 				<col class="col100" />
 				<col class="col100" />
 				<col class="col100" />
 				<col class="col100" />
 			</colgroup>
 			<tbody>
 				<tr>
 					<td class="title" >제  목</td>
 					<td class="pL10" colspan="5">${invoiceVO.title}</td>
 				</tr>
 				<tr>
 					<td class="title" >고객사</td>
 					<td class="pL10" colspan="3">${invoiceVO.custCompanyName}</td>
 					<td class="title" >대표자</td>
 					<td class="pL10">${invoiceVO.custCeoName}</td>
 				</tr>
 				<tr>
 					<td class="title end" >발행일</td>
 					<td class="pL10 txt_center end">${invoiceVO.publishDatetime}</td>
 					<td class="title end" >발행금액</td>
 					<td class="pR10 txt_right end" ><print:currency cost='${invoiceVO.totalSum}' /></td>
 					<td class="title end" >미수금액</td>
 					<td class="pL10 txt_center end">
 						<input type="text" class="input02 span_5 currency" readonly="readonly" id="totalUncollect" 
 						value="<print:currency cost='${invoiceVO.totalSum - invoiceVO.totalCollect}' />" />
 					</td>
 				</tr>
			</tbody>
		</table>
		</div>  <!--  class="pop_board mT20"  -->
 				
		<div class="pop_board mT20" >
		<p class="th_stitle">기수금 정보</p>
 		<table cellpadding="0" cellspacing="0">
 			<colgroup>
 				<col class="col20" />
 				<col class="col60" />
 				<col class="col60" />
 				
 				<col class="col60" />
 				<col class="col80" />
 				
 				<col class="col60" />
 				<col class="col60" />
 				<col class="col60" />
 				<col class="col400" />
 			</colgroup>
 			<tbody>
			<c:forEach items="${rstCollectList}" var="collect" varStatus="c">
 				<tr>
 					<td class="title">${c.count}</td>
 					<td class="title" >수금일</td>
 					<td class="txt_center">${collect.collectDate}</td>
 					<td class="title" >수금액</td>
 					<td class="pR5 txt_right" id="collect${c.index} }"><print:currency cost='${collect.collect}' /></td>
 					<td class="title" >구분</td>
 					<td class="txt_center" >
				<c:choose>
					<c:when test="${collect.type == '1'}">
						<label>현금</label> 
					</c:when>
					<c:when test="${collect.type == '2'}">
						<label>어음</label>
					</c:when>
					<c:otherwise>
						<label>기타</label>
					</c:otherwise>
				</c:choose>
					</td>
					<td class="title">비 고</td>
 					<td class="pL7">${collect.note}</td>
 				</tr>
			</c:forEach>
			</tbody>
		</table>
		</div>  <!--  class="pop_board mT20"  -->

		<div class="pop_board mT20" >
		<p class="th_stitle">수금 등록 정보</p>
		<table cellpadding="0" cellspacing="0">
			<colgroup>
				<col class="col60" />
				<col class="col80" />
				
				<col class="col60" />
				<col class="col90" />
				
				<col class="col60" />
				<col class="col60" />
				<col class="col60" />
				<col class="col400" />
			</colgroup>
			<tbody>
				<tr>
					<td class="title" >수금일</td> 
					<td class="txt_center"><input type="text" class="input03 span_5 calGen" readonly="readonly" name="collectDate" id="collectDate"/></td>
					<td class="title" >수금액</td>

					<td class="txt_center"><input type="text" class="input02 span_5 totalCollect" name="totalCollect" id="totalCollect" value="0" /></td>
					<td class="title" >구분</td>
					<td class="txt_center">
						<select  name="type" id="type" class="select01" >
							<option value="1" selected > 현금 </option>
							<option value="2" > 어음 </option>
							<option value="3"> 기타 </option>
						</select>
 					</td>
					<td class="title">비 고</td>
 					<td ><textarea class="w100p" name="note" id="note" value=""></textarea>
 					</td>
 				</tr>
			</tbody>
		</table>
		<table cellpadding="0" cellspacing="0">
			<colgroup>
				<col class="col300" />
				<col class="col100" />
				<col class="col100" />
				<col class="col100" />
				<col class="w100p" />
			</colgroup>
			<tbody>
			<colgroup>
			<c:forEach items="${rstProjectList}" var="project" varStatus="c">
 				<tr>
 					<td class="title" >프로젝트명</td>
					<td class="title">매출금액</td>
					<td class="title">기수금액</td>
					<td class="title">수금액</td>
					<td class="title">비고</td>
				</tr>
				<tr>
					<input type="hidden" name="projectVOList[${c.index}].no"			value="${project.no}" />
					<input type="hidden" name="projectVOList[${c.index}].prjId" 		value="${project.prjId}" />
					<input type="hidden" name="projectVOList[${c.index}].collectOld" 	value="${project.collect}" >
					<td class="pL5 txt_left"> ${project.prjName}</td>
					<td class="txt_center"><print:currency cost='${project.sum}' /></td>
					<td class="txt_center"><print:currency cost='${project.collect}' /></td>
					<td class="pL5" >
				<c:choose>
					<c:when test="${c.index == 0}">
							<input type="text" class="input02 span_5 prjCollect" name="projectVOList[${c.index}].collect" id="prjCollect${c.index}" value="0" readonly="readonly" >
					</c:when>
					<c:otherwise>
							<input type="text" class="input02 span_5 prjCollect" name="projectVOList[${c.index}].collect" id="prjCollect${c.index}" value="0" >
					</c:otherwise>
				</c:choose>
					</td>
					<td class="pL5" ></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		</div>  <!--  class="pop_board mT20"  -->

		<div class="pop_board mT20" >
		<p class="th_stitle">자금보고 정보</p>
 		<table cellpadding="0" cellspacing="0">
 			<colgroup>
 				<col class="col100" />
 				<col class="col500" />
 			</colgroup>
			<tbody>
				<tr>
					<td class="title" >펀네트</td> 
					<td class="pL10">
					<c:forEach items="${bankBookList}" var="bankBook">
						<c:if test="${bankBook.codeDc == 'dosanet'}">
							<label>&nbsp;<input type="radio" class="radio check" name="bankBookR" value="${bankBook.code}" data-code-value="${bankBook.codeDc}"/>${bankBook.codeNm}</label>
						</c:if>
					</c:forEach>
					</td>
 				</tr>	
				<tr>
					<td class="title" >새하컴즈</td> 
					<td class="pL10">
					<c:forEach items="${bankBookList}" var="bankBook">
						<c:if test="${bankBook.codeDc == 'saeha'}">
							<label>&nbsp;<input type="radio" class="radio check" name="bankBookR" value="${bankBook.code}" data-code-value="${bankBook.codeDc}"/>${bankBook.codeNm}</label>
						</c:if>
					</c:forEach>
					</td>
 				</tr>	
				<tr>
					<td class="title" >프로비츠</td> 
					<td class="pL10">
					<c:forEach items="${bankBookList}" var="bankBook">
						<c:if test="${bankBook.codeDc == 'probits'}">
							<label>&nbsp;<input type="radio" class="radio check" name="bankBookR" value="${bankBook.code}" data-code-value="${bankBook.codeDc}"/>${bankBook.codeNm}</label>
						</c:if>
					</c:forEach>
					</td>
 				</tr>	
 				<tr>
					<td class="title" >유프리즘</td> 
					<td class="pL10">
					<c:forEach items="${bankBookList}" var="bankBook">
						<c:if test="${bankBook.codeDc == 'uprism'}">
							<label>&nbsp;<input type="radio" class="radio check" name="bankBookR" value="${bankBook.code}" data-code-value="${bankBook.codeDc}"/>${bankBook.codeNm}</label>
						</c:if>
					</c:forEach>
					</td>
 				</tr>
			</tbody>
		</table>
		</div>  <!--  class="pop_board mT20"  -->

	</form:form>
	<div class="hm_pop_btn_area01">
		<input type="button" value="삭제" class="btn_gray w80" onclick="javascript:deleteCollect();"/>
		<input type="button" value="수금자금등록" class="btn_gray w100" onclick="javascript:insertCollectionNFund();"/>
		<input type="button" value="수금등록" class="btn_gray w80" onclick="javascript:insertCollection();"/>
		<input type="button" value="미수금등록" class="btn_gray w80" onclick="javascript:endCollection();"/>
		<input type="button" value="취소" class="btn_gray w80" onclick="javascript:popClose();"/>
<!-- 		<img src="../../images/btn/btn_delete.gif" onclick="javascript:deleteCollect();" class="cursorPointer"/>
		<img src="../../images/btn/btn_add03.gif" onclick="javascript:insertCollectionNFund();" class="cursorPointer"/>
		<img src="../../images/btn/btn_regist.gif" onclick="javascript:insertCollection();" class="cursorPointer"/>
		<img src="../../images/btn/btn_cancel.gif" onclick="javascript:popClose();" class="cursorPointer"/>
 -->	</div>
	</div>  <!-- class="pop_con08" -->
</div>

</body>
</html>
