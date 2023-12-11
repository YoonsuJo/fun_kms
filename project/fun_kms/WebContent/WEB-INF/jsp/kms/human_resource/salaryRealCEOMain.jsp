<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>

var rankYear = ${year};
var userYear = ${year}; 

$(document).ready(function(){
	document.getElementById('center').style.width='942px';
	hidden_right_true(true);
	$('#center').trigger('hideRightEvent');
});
window.onload=function(){	
};

function search(pageNo) {	
	var chk = document.frm.workSt;
	document.frm.pageIndex.value = pageNo;
	//if ((chk[0].checked || chk[1].checked) == false) {
	//	alert("재직자 혹은 퇴직자를 선택해주세요.");
	//	return;
	//}
	document.frm.action = "<c:url value='${rootPath}/admin/salary/salaryRealCEOMain.do'/>";	
	document.frm.submit();
}
function searchAll() {
	document.frm.workSt[0].checked = true;
	document.frm.workSt[1].checked = false;
	selRadio(0);
	document.frm.rankId.value = "";
	document.frm.action = "<c:url value='${rootPath}/admin/salary/salaryRealCEOMain.do'/>";
	document.frm.submit();
}
function selRadio(n) {
	document.frm.searchCondition[n].checked = true;
	document.frm.searchConditionH.value = n;
	if (n == 0) {
		document.frm.rankId.style.display = "";
	}
	else if (n == 1) {
		document.frm.rankId.style.display = "none";
		document.getElementById("usrNm").style.display = "";
		document.getElementById("orgNm").style.display = "none";
		document.getElementById("orgTree").style.display = "none";
	}
	else if (n == 2) {
		document.frm.rankId.style.display = "none";
		document.getElementById("usrNm").style.display = "none";
		document.getElementById("orgNm").style.display = "";
		document.getElementById("orgTree").style.display = "";
	}
}
function clickOrderBy(n){
	document.frm.orderBy.value = n;
	search(1);
}
function userSalaryMove(pos) {
	var preYear = userYear;
	userYear = userYear + pos;
	document.frm.year.value = userYear;
	search(1);
}
function userSalaryMoveOld(pos) {
	//검색조건, 통계, 페이징 때문에 ajax 버림
	var preYear = userYear;
	userYear = userYear + pos;
	document.frm.year.value = userYear;
	
	var searchCondition = document.frm.searchConditionH.value;	
	var rankId = document.frm.rankId.value;
	var searchOrgId = document.frm.searchOrgId.value;
	var searchOrgNm = document.frm.searchOrgNm.value;
	var searchUserNm = document.frm.searchUserNm.value;	
	var orderBy  = document.frm.orderBy.value;	

	$.post("/ajax/admin/salary/userSalaryRealCEOAjax.do?year=" + userYear + "&searchCondition=" + searchCondition + "&rankId=" + rankId 
			+ "&searchOrgId=" + searchOrgId + "&searchOrgNm=" + searchOrgNm + "&searchUserNm=" + searchUserNm + "&orderBy=" + orderBy
			, function(data){
		if(data.indexOf("failToLoad")>=0) {
			alert("해당년도 연봉테이블이 작성되어있지 않습니다");
			userYear = preYear;			
		} else {
			$('#userSalaryD').html(data);
			$('#userSalaryYearS').html(userYear+"년 ");
		}
	});
}

//ajax 처리중 제어변수
var ajaxProcessing = false;

function editUserSalary(userNo, status, target) {
	var salaryReal = document.getElementById('salaryReal'+userNo).value;
	var salaryHope = document.getElementById('salaryHope'+userNo).value;
	var salarySuggest = document.getElementById('salarySuggest'+userNo).value;	
	salarySuggest = salarySuggest.replace(/,/gi,"");
	var salaryName = document.getElementById('salaryName'+userNo).value;
	var carCost = document.getElementById('carCost'+userNo).value;
	var mealCost = document.getElementById('mealCost'+userNo).value;
	var note = document.getElementById('note'+userNo).value;

	var hopeNote = document.getElementById('hopeNote'+userNo).value;
	
	var stat1 = document.getElementById('stat1').value*1;
	var stat2 = document.getElementById('stat2').value*1;
	var stat3 = document.getElementById('stat3').value*1;
	var statF = document.getElementById('status'+userNo).value;
	switch(statF){
		case "1" : stat1--; break;	
		case "2" : stat2--; break;	
		case "3" : stat3--; break;
	}
	document.getElementById('status'+userNo).value = status;
	
	var statusStr;
	switch(status){
		case "1" : statusStr='제시'; stat1++; break;	
		case "2" : statusStr='동의'; stat2++; break;	
		case "3" : statusStr='면담'; stat3++; break;
	}
	
	if(salaryReal==null || salaryReal=="" || isNaN(salaryReal)
		|| salaryHope==null || salaryHope=="" || isNaN(salaryHope)
		|| salarySuggest==null || salarySuggest=="" || isNaN(salarySuggest) ){
			
	 	msg = "올바르지 않은 값이 작성되어 있습니다.\n숫자 형식만 입력하여 주세요";
	 	displayMessageSimple(msg, "txtB_grey", target);	 		
	 	return;
	}
	
	if(ajaxProcessing == false){
		ajaxProcessing = true;
				
		$.post("/ajax/admin/salary/userSalaryRealU.do?year=" + userYear + "&userNo=" + userNo 
				+ "&salaryReal=" + salaryReal + "&salaryHope=" + salaryHope  + "&salarySuggest=" + salarySuggest 
				+ "&carCost=" + carCost + "&mealCost=" + mealCost + "&status=" + status + "&note=" + encodeURIComponent(note) + "&hopeNote=" + encodeURIComponent(hopeNote)
				,function(data){
				if(data.indexOf("success"))	{
					msg = userYear + "년 " + salaryName + " 사원의 제안연봉을 수정했습니다.";
					document.getElementById('statusStr'+userNo).value = statusStr;	
					document.getElementById('stat1').value = stat1;
					document.getElementById('stat2').value = stat2;
					document.getElementById('stat3').value = stat3;									
					//document.getElementById('acceptBtn'+userNo).src = "${imagePath}/btn/btn_acceptCancel.gif";
					//document.getElementById('acceptBtn'+userNo).onclick = function(){editUserSalary(userNo, 'N', this);}
					//document.getElementById('acceptBtn'+userNo).src = "${imagePath}/btn/btn_accept02.gif";
					//document.getElementById('acceptBtn'+userNo).onclick = function(){editUserSalary(userNo, 'Y', this);}				
					//userSalaryMove(0);
					
					//if(status == "1" && statF != '1'){
					//	location.replace("/admin/salary/salaryRealCEOMain.do");
					//}
					
				} else {
					msg = userYear + "년 " + salaryName + " 사원의 제안연봉 수정에 실패했습니다";													
				}
				displayMessageSimple(msg, "txtB_grey", target);
				ajaxProcessing = false;
		});
	} else{
		displayMessageSimple("입력 처리중입니다", "txtB_grey", target, "short");
		return;
	}
}

//상승률 계산
function calRate(userNo) {
	var salaryReal = document.getElementById('salaryReal'+userNo).value;
	var salarySuggest = document.getElementById('salarySuggest'+userNo).value;
	salaryReal = salaryReal.replace(/,/gi,"");
	salarySuggest = salarySuggest.replace(/,/gi,"");

	var rate = Math.floor((salarySuggest - salaryReal)/salaryReal * 10000) / 100;	
	document.getElementById('increaseRate'+userNo).value = rate;// + '%';

	var amount = Math.floor(salarySuggest - salaryReal);
	document.getElementById('increaseAmount'+userNo).value = amount;
	jsMakeCurrency(document.getElementById('increaseAmount'+userNo));
}
function editUserSalary2(userNo, status, target) {
	target = document.getElementById(target);
	editUserSalary(userNo, status, target);
}
function enterUserSalary(userNo, target) {

	var status = document.getElementById('status'+userNo).value;
	if(status.equals("") || status.equals(null)){ status=1;	}
	
	if(status==3) status=2;	
	if(inputEnter()){		
		editUserSalary(userNo, status, target);
	}
}
//상승률 입력
function calIncreaseRate(userNo) {
	var increaseRate = document.getElementById('increaseRate'+userNo).value;
	var salaryReal = document.getElementById('salaryReal'+userNo).value;
	var salarySuggest = document.getElementById('salarySuggest'+userNo).value;
	increaseRate = increaseRate.replace(/%/gi,"");
	salaryReal = salaryReal.replace(/,/gi,"");
	salarySuggest = salarySuggest.replace(/,/gi,"");

	increaseRate = increaseRate / 100;	
	salarySuggest = salaryReal * ( 1 + increaseRate);
	var amount = Math.floor(salarySuggest - salaryReal);
	document.getElementById('increaseAmount'+userNo).value = amount;
	jsMakeCurrency(document.getElementById('increaseAmount'+userNo));
	
	document.getElementById('salarySuggest'+userNo).value = salarySuggest;
	jsMakeCurrency(document.getElementById('salarySuggest'+userNo));
}
function showUserHistory(userNo, year, elem) {
	var scrolled = $(window).scrollTop();
	var position = $(elem).offset();
	var left = position.left + 90;
	var top = position.top + 30 - scrolled ;		
	
	$.post("/ajax/admin/salary/salaryRealCEOHistory.do?year=" + year +"&userNo=" + userNo ,function(data){
		$("#tab1").html(data);
		$("#tab1").show();
		$("#tab1").dialog( { 
			height: 294
			,width: 349
			,position: [left, top]
			,closeOnEscape: true 
			,resizable: true
			,draggable: true
			//,modal: true
			,autoOpen: true				
		});
		hideNote();
		document.getElementById('salarySuggest'+userNo).focus();		
	});	
}
function hideUserHistory() {
	$("#tab1").dialog( "destroy" );
}
var openedNoteNo;
function hideNote() {
	$('#noteLayer'+openedNoteNo).dialog( "close" );
}
function hideNoteLayer(userNo) {
	//$('#noteLayerView'+userNo).hide();
	$('#noteLayerView'+userNo).dialog( "destroy" );
	//$('#noteLayerView'+userNo).dialog( "close" );
}
function writeNote(userNo, year, obj) {
	var scrolled = $(window).scrollTop();
	var position = $(obj).offset();
	var left = position.left + 65;
	var top = position.top + 40 - scrolled ;	
	var width = $(obj).width();
	var height = $(obj).height();

	hideNote();
	openedNoteNo = userNo;
	
	$('#noteLayer'+userNo).dialog( {	
		height: 147
		,width: 349
		,position : [left, top]
		,closeOnEscape: true 
		,resizable: true
		,draggable: true
		//,modal: true
		,autoOpen: true
		//,beforeClose: function(event, ui) { alert(1);}     
	});
	hideUserHistory();
}
function showNoteLayer(userNo, year, obj) {
	var scrolled = $(window).scrollTop();
	var position = $(obj).offset();
	var left = position.left + 65;
	var top = position.top + 40 - scrolled ;	
	var width = $(obj).width();
	var height = $(obj).height();

	//$('#noteLayer'+userNo).show();
	$('#noteLayerView'+userNo).dialog( {
		height: 147
		,width: 349
		,position : [left, top]
		,closeOnEscape: true 
		,resizable: true
		,draggable: true
		//,modal: true
		,autoOpen: true
		,create: function(event, ui) { hideNote(); }
	});
	hideUserHistory();
}
function historySR(userNo, salaryReal){
	var salarySuggest = document.getElementById('salarySuggest'+userNo).value;	
	salarySuggest = salarySuggest.replace(/,/gi,"");
	document.getElementById('salarySuggest'+userNo).value = salaryReal;
	jsMakeCurrency(document.getElementById('salarySuggest'+userNo));
	calRate(userNo);
}
function historyIA(userNo, increaseAmount){
	var salarySuggest = document.getElementById('salarySuggest'+userNo).value;	
	salarySuggest = salarySuggest.replace(/,/gi,"");
	document.getElementById('salarySuggest'+userNo).value = (salarySuggest*1) + (increaseAmount*1);
	jsMakeCurrency(document.getElementById('salarySuggest'+userNo));
	calRate(userNo);
}
function historyIR(userNo, increaseRate){
	var salarySuggest = document.getElementById('salarySuggest'+userNo).value;	
	salarySuggest = salarySuggest.replace(/,/gi,"");
	salarySuggest = Math.floor(salarySuggest * (increaseRate / 100 + 1));	
	document.getElementById('salarySuggest'+userNo).value = salarySuggest;
	jsMakeCurrency(document.getElementById('salarySuggest'+userNo));
	calRate(userNo);
}
function historyIAD(userNo){
	var increaseAmount = document.getElementById('increaseAmount'+userNo).value;	
	increaseAmount = increaseAmount.replace(/,/gi,"");
	historyIA(userNo, increaseAmount);
}
function historyIRD(userNo){
	var increaseRate = document.getElementById('increaseRate'+userNo).value;	
	increaseRate = increaseRate.replace(/%/gi,"");
	historyIR(userNo, increaseRate);
}




function showToolTip(layerName, obj, text, pos) {	

	var scrolled = $(window).scrollTop();
	var position = $('#'+obj).offset();	
	var left = position.left + 0;
	var top = position.top + 10 - scrolled ;	

	$('#ToolTipBox').hide();
	var ToolTipBox = document.getElementById("ToolTipBox");
	ToolTipBox.innerHTML = text;
	
	$('#'+layerName).css("left",($('#'+obj).offset().left+5)+"px");
	if(pos == 'up'){
		var height = $('#ToolTipBox').height()+1;
		$('#'+layerName).css("top",($('#'+obj).offset().top-height)+"px");	
	}else if(pos == 'down'){
		$('#'+layerName).css("top",($('#'+obj).offset().top+28)+"px");	
	}else if(pos == 'left'){
		$('#'+layerName).css("top",($('#'+obj).offset().top)+"px");
		$('#'+layerName).css("left",($('#'+obj).offset().left+45)+"px");
	}
	$('#'+layerName).show();
	
}

function hideToolTip()
{	
	$('#ToolTipBox').hide();
	
		
}

</script>
</head>

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
				<div id="center2">
					<div class="path_navi">
						<ul>
							<li class="stitle">사원연봉결정</li>
							<li class="navi">홈 > 인사정보 > 사원정보 > 사원연봉결정</li>
						</ul>
					</div>	
					
					<span class="stxt">
						사원연봉을 결정하는 화면입니다. 
						차년도연봉을 입력하시면 인상금액과 인상률은 자동계산됩니다. <br/>
						1차점수와 2차점수를 클릭하시면 평가자 정보가 보입니다. <br/>
						특약사항란에 마우스를 올리시면 특약사항이 표시됩니다. 
						특약사항란을 클릭하시면 200자 이내 특약사항 입력창이 나옵니다. <br/>						
					</span>
					<!-- S: section -->
					<div class="section01">	
		                
						<!-- 게시판 시작 -->
						
						<p class="th_stitle mB10">사원연봉결정
							<span class="stxtRt" >
								${statusCode['0'].codeNm}:<input type="text" name="stat1" id="stat1" class="read_input3" maxlength="12" readonly="readonly" 
								value="<c:if test="${statusCntList['0'].count == null}">0</c:if> ${statusCntList['0'].count}" /> 명							
								${statusCode['1'].codeNm}:<input type="text" name="stat2" id="stat2" class="read_input3" maxlength="12" readonly="readonly" 
								value="<c:if test="${statusCntList['1'].count == null}">0</c:if> ${statusCntList['1'].count}" /> 명								
								${statusCode['2'].codeNm}:<input type="text" name="stat3" id="stat3" class="read_input3" maxlength="12" readonly="readonly" 
								value="<c:if test="${statusCntList['2'].count == null}">0</c:if> ${statusCntList['2'].count}" /> 명								
							</span>	
						</p>
												
	        		    <form name="frm" method="POST" action="${rootPath}/admin/salary/salaryRealCEOMain.do" onsubmit="search(1); return false;">						
						<input type="hidden" name="year" id="year" value="${year}"/>
						<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
						<input type="hidden" name="searchConditionH" id="searchConditionH" value="${searchVO.searchCondition}"/>
						<input type="hidden" name="orderBy" id="orderBy" value="${searchVO.orderBy}"/>
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>					
	        		    <!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<colgroup>
								<col width="120px"/>
								<col width="*"/>
							</colgroup>
							<tbody>
								<tr>
									<td class="search_left"> 
										<img id="userSalaryMonthBackB" class="cursorPointer pR10 pT2" onclick="javascript:userSalaryMove(-1);"  src="${imagePath}/admin/btn/btn_prev.gif" alt="이전 페이지">
				                		<span id="userSalaryYearS" class="option_txt">${year }년</span>
										<img id="userSalaryMonthForwardB" class="cursorPointer pL10 pT2" onclick="javascript:userSalaryMove(1);" src="${imagePath}/admin/btn/btn_next.gif" alt="다음 페이지">
									</td>
									<td class="search_right">
										상태
										<select id="status" name="status" class="span_3" style="vertical-align:top;">
											<option value="">선택</option>
											<c:forEach items="${statusCode}" var="status">
												<option value="${status.code}" <c:if test="${status.code == searchVO.status}">selected="selected"</c:if> >
												<c:out value="${status.codeNm}"/></option>
											</c:forEach>
										</select><span class="pL7"></span>
										<label><input type="radio" id="searchCondition" name="searchCondition" value="0" onclick="selRadio(0);" 
										<c:if test="${searchVO.searchCondition == 0}">checked="checked"</c:if>>직급</label>
										<select id="rankId" name="rankId" class="span_3" style="vertical-align:top;">
											<option value="">선택</option>
											<c:forEach items="${rankList}" var="rank">
												<option value="${rank.code}" <c:if test="${rank.code == searchVO.rankId}">selected="selected"</c:if> >
												<c:out value="${rank.codeNm}"/></option>
											</c:forEach>
										</select><span class="pL7"></span>
										<label><input type="radio" id="searchCondition" name="searchCondition" value="1" onclick="selRadio(1);" 
										<c:if test="${searchVO.searchCondition == 1}">checked="checked"</c:if>>사용자</label><span class="pL7"></span>
										<label><input type="radio" id="searchCondition" name="searchCondition" value="2" onclick="selRadio(2);" 
										<c:if test="${searchVO.searchCondition == 2}">checked="checked"</c:if>>부서</label>
										<input type="text" name="searchUserNm" id="usrNm" class="search_txt02 userNameAuto" value="${searchVO.searchUserNm}" />
										<input type="text" name="searchOrgNm" id="orgNm" class="search_txt02" value="${searchVO.searchOrgNm}" onfocus="orgGen('orgNm','orgId',0);" readonly="readonly" style="display:none"/>
										<img src="${imagePath}/btn/btn_tree.gif" id="orgTree" class="cursorPointer" onclick="orgGen('orgNm','orgId',0);" style="display:none"/>
										<input type="image" src="${imagePath}/admin/btn/btn_search02.gif" />
										<a href="javascript:searchAll();"><img src="${imagePath}/admin/btn/btn_allview.gif" alt="전체보기"/></a>
									</td>
								</tr>
							</tbody>
							</table>
		                    </div>
		                </fieldset>
						</form>
						<script>selRadio("${searchVO.searchCondition}");</script>
		                <!-- 상단 검색창 끝 -->
		                
	        		    <div id="userSalaryD" class="boardList">
							<jsp:include page="${jspPath}/human_resource/include/userSalaryRealCEO.jsp"></jsp:include>
						</div>													
						<!-- 게시판 끝  -->
						
						<!-- 페이징 시작 -->
						<div class="paginate">
<!--		                	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="search" />-->
						</div>					
						<!-- 페이징 끝 -->
						제시 상태에서 수정하면 제시 <br/>
						동의, 면담 상태에서 수정하면 동의 <br/>
						동의, 면담 상태에서 취소하면 제시 상태로 변경됩니다.
																		
					</div>
					<!-- E: section -->	
				</div>
			<!-- E: center -->				
			
			</div>	
			<!-- E: centerBg -->
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/footer.jsp"%>
</div>

<!-- for hidden dialog -->
<div id="tab1">
</div>


<div class="simpleMsg_layer" id="ToolTipBox">내용입력</div>

</body>
</html>
