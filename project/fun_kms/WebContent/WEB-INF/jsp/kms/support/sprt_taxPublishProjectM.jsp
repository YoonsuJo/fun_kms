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

<validator:javascript formName="taxPublish" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='${commonPath}/js/jquery.validate.js'/>" ></script>

<script>

var prjExp = [];
var supSum = ${result.supSum};
var taxSum = ${result.taxSum};
var pubSum = ${result.pubSum};
var prjSum = 0;

// 프로젝트 cnt
var projectCnt = ${resultProjectCnt + 1};

$(document).ready(function() {
	addMakeCurrencyEvent();
	calExpense();
});

function updateTaxPublishProject() {

	calExpense();

	var boolValidate = true;
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
	var projectVO = $('#taxPublishVO').toObject({mode: 'first'})['project'];
	form.find("input[name=jsonProjectString]").val(escape(JSON.stringify(projectVO)));

	//location.href = "${rootPath}/support/taxPublishI.do?" + form.serialize();
	document.taxPublishVO.action = '<c:url value="${rootPath}/support/taxPublishProjectU.do" />';
	document.taxPublishVO.submit();
}
function cancelTaxPublish(bondId) {
	document.taxPublishVO.bondId.value = bondId;
	document.taxPublishVO.action = '<c:url value="${rootPath}/support/taxPublishV.do" />';
	document.taxPublishVO.submit();
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
function calExpense() {
	
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

	$('#supChkSum').html(jsAddComma(roundXL(supSum,0)));
	$('#prjSum').html(jsAddComma(roundXL(prjSum,0)));
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
		                    	<td class="pL10" colspan="2">${result.bondSj}</td>
		                    	<td class="title">상태</td>
		                    	<td class="pL10">
		                    		<c:choose>
			                    		<c:when test="${result.bondStat == 'Y'}">발행완료</c:when>
			                    		<c:when test="${result.bondStat == 'C'}">발행취소</c:when>
			                    		<c:otherwise>미발행</c:otherwise>
		                    		</c:choose>
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title">공급자(*)</td>
		                    	<td class="pL10" colspan="4">${result.companyNm}</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title" rowspan="4">공급받는자</td>
	                    		<td class="title2">
	                    			상호
	                    		</td>
	                    		<td class="pL10" colspan="3">
	                    			${result.custNm}
	                    		</td>
	                    	</tr>
	                    	<tr>
	                    		<td class="title2">
	                    			등록번호
	                    		</td>
	                    		<td class="pL10">
	                    			${result.custBusiNo}
	                    		</td>
	                    		<td class="title2">
	                    			대표자
	                    		</td>
	                    		<td class="pL10">
	                    			${result.custRepNm}
	                    		</td>
	                    	</tr>
	                    	<tr>
	                    		<td class="title2">
	                    			업태
	                    		</td>
	                    		<td class="pL10">
	                    			${result.custBusiCond}
	                    		</td>
	                    		<td class="title2">
	                    			업종
	                    		</td>
	                    		<td class="pL10">
	                    			${result.custBusiTyp}
	                    		</td>
	                    	</tr>
	                    	<tr>
	                    		<td class="title2">
	                    			주소
	                    		</td>
	                    		<td class="pL10" colspan="3">
	                    			${result.custAdres}
	                    		</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title" rowspan="5">수신자</td>
		                    	<td class="title2">수신자1</td>
		                    	<td class="pL10" colspan="3">
	                    			<div id="Receiver1">
		                    			<span class="pL5">E-mail : ${result.taxEmail1}</span>
		                    			<span class="pL20">담당자 : ${result.taxUserNm1}</span>
		                    			<span class="pL20">연락처 : ${result.taxUserTelNo1}</span>
	                    				<br/>
	                    			</div>
	                    		</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title2">수신자2</td>
	                    		<td class="pL10" colspan="3">
	                    			<div id="Receiver2">
		                    			<span class="pL5">E-mail : ${result.taxEmail2}</span>
		                    			<span class="pL20">담당자 : ${result.taxUserNm2}</span>
		                    			<span class="pL20">연락처 : ${result.taxUserTelNo2}</span>
	                    				<br/>
	                    			</div>
	                    		</td>
	                    	</tr>
		                    <tr>
		                    	<td class="title2">수신자3</td>
		                    	<td class="pL10" colspan="3">
	                    			<div id="Receiver3">
		                    			<span class="pL5">E-mail : ${result.taxEmail3}</span>
		                    			<span class="pL20">담당자 : ${result.taxUserNm3}</span>
		                    			<span class="pL20">연락처 : ${result.taxUserTelNo3}</span>
	                    				<br/>
	                    			</div>
	                    		</td>
	                    	</tr>
		                    <tr>
		                    	<td class="title2">수신자4</td>
		                    	<td class="pL10" colspan="3">
	                    			<div id="Receiver4">
		                    			<span class="pL5">E-mail : ${result.taxEmail4}</span>
		                    			<span class="pL20">담당자 : ${result.taxUserNm4}</span>
		                    			<span class="pL20">연락처 : ${result.taxUserTelNo4}</span>
	                    				<br/>
	                    			</div>
	                    		</td>
	                    	</tr>
		                    <tr>
		                    	<td class="title2">수신자5</td>
		                    	<td class="pL10" colspan="3">
	                    			<div id="Receiver5">
		                    			<span class="pL5">E-mail : ${result.taxEmail5}</span>
		                    			<span class="pL20">담당자 : ${result.taxUserNm5}</span>
		                    			<span class="pL20">연락처 : ${result.taxUserTelNo5}</span>
	                    				<br/>
	                    			</div>
	                    		</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title">발행일</td>
		                    	<td colspan="4" class="pL10">
			                    	<print:date date="${result.publishDate}"/>
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title" rowspan="2">금액(*)</td>
		                    	<td id="Expenses" class="pL10" colspan="4">
		                    		<c:forEach items="${resultExpenseList}" var="expense" varStatus="c">
										 <print:currency cost="${expense.expense}" /> 원
										 &nbsp;(<c:if test="${expense.containVat == 'Y'}">
										 			공급가액 <span id="expSup"><print:currency cost="${expense.supplyExpense}" /></span>
										 			&nbsp;/&nbsp;세액 <span id="expVat"><print:currency cost="${expense.taxExpense}" /></span>
										 		</c:if>
										 		<c:if test="${expense.containVat != 'Y'}">
										 			공급가액 <span id="expSup"><print:currency cost="${expense.supplyExpense}" /></span>
										 			&nbsp;/&nbsp;세액 <span id="expVat"><print:currency cost="${expense.taxExpense}" /></span>
										 		</c:if>
										 &nbsp;<c:if test="${expense.containVat == 'Y'}">/ VAT 포함</c:if> ) - ${expense.note}<br/>
									</c:forEach>
		                    	</td>
	                    	</tr>
	                    	<tr>
	                    	    <td class="pL10" colspan="2">
	                    	    	공급가액 : <span id="supSum"><print:currency cost="${result.supSum}" /></span>원<br/>
	                    	    	 세액 : <span id="taxSum"><print:currency cost="${result.taxSum}" /></span>원<br/>
	                    	    	 합계 : <span id="pubSum"><print:currency cost="${result.pubSum}" /></span>원<br/>
	                    	    </td>
	                    	    <td class="title">청구/영수</td>
	                    	    <td class="pL10"><c:if test="${result.bondTyp == 1}">청구</c:if><c:if test="${result.bondTyp == 2}">영수</c:if></td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title">비고</td>
		                    	<td class="pL10" colspan="4"><print:textarea text="${result.bondCn}" /></td>
	                    	</tr>
	                    	<tr>
								<td class="title">첨부파일</td>
								<td class="pL10" colspan="4">
									<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${result.atchFileId}" />
									</c:import>
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
                		<img src="../../images/btn/btn_regist.gif" onclick="javascript:updateTaxPublishProject();" class="cursorPointer"/>
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
