<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="KmsAbsence" staticJavascript="false" xhtml="true" cdata="false"/>
<validator:javascript formName="KmsOvertime" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
var boolValidAlert = true;
var process = false;

$(document).ready(function(){	
	//span class = "icn_new"  블링크
	var icn_blink = setInterval(function(){
		$('span.icn_new').fadeOut('fast').fadeIn('fast');
	}, 2500);
	
});

function register() {
	
	if(getAbsTyp() == undefined) {
		alert("근무형태를 선택해주세요.");
		return;
	}
	if(document.frm.wsPurpose.value == "") {
		alert("목적 또는 사유를 입력해주세요.");
		return;
	}	
	if (!validateKmsAbsence(document.frm)) {
		return;
	}
	if (getAbsTyp() != "O" && document.frm.wsBgnDe.value > document.frm.wsEndDe.value) {
		alert("기간이 잘못되었습니다. 다시 확인해주세요.");
		return;
	}
	if (getAbsTyp() == "O" && (document.frm.wsBgnTm.value == "" || document.frm.wsEndTm.value == "" 
							|| document.frm.wsBgnTm.value > document.frm.wsEndTm.value)) {
		alert("시간이 잘못되었습니다. 다시 확인해주세요.");
		return;
	}
	if (getAbsTyp() == "N") {
		if (document.frm.wsBgnTm.value == "") {
			alert("근무종료시각은 필수입력 사항입니다.");
			return;
		}
		if (document.frm.wsBgnTm.value < "22" && boolValidAlert) {
			var year = new Date().getFullYear();
			var month = new Date().getMonth();
			month = month + 1;
			if ((month + "").length == 1)
				month = "0" + month;
			var date = new Date().getDate();
			var today = year + "" + month + "" + date;
			if (document.frm.wsBgnDe.value == today) {
				alert("자정이 지나 퇴근하는 경우 전날 날짜로 기록해주세요.\nex) 4/1 2:00 AM 퇴근 → 3/31 선택");
				boolValidAlert = false;
				return;
			}
		}
	}
	if(process == true){
		return;
	}
	process = true;
	document.frm.action = '<c:url value="${rootPath}/member/insertAbsence.do" />';
	document.frm.submit();
}
function calcWsHrCnt(obj) {
	var year = new Date().getFullYear();
	var month = new Date().getMonth();	
	month++;
	var date = new Date().getDate();	
	if ((month + "").length == 1)
		month = "0" + month;	
	if ((date + "").length == 1)
		date = "0" + date;	
	var hour = new Date().getHours();
	var min = new Date().getMinutes();
	var sec = new Date().getSeconds();
	var today = year + "" + month + "" + date;
	var now = hour + ":" + min + ":" + sec;		
	var wsBgnDe = document.frm.wsBgnDe.value;
	var wsBgnTm = obj.value;	
	var stoday = '현재시간: ' + year + '년 ' + month + '월 ' + date + '일 ' + hour + "시 " + min + "분 " + sec + "초";;
	var msg = '당일 등록시간 ~ 6시 이전에만 등록가능합니다\n6시 입력가능시간은 5:00:00~5:59:59\n' + stoday;
	wsBgnDe += ''; //String casting
	wsBgnDe *= 1; //int casting	
	 
	//AbsenceController.java 부분 활용
	if(today == wsBgnDe){
		if(hour > 21 && hour >= wsBgnTm){
		} else {
			alert(msg);
		}				
	} // 익일 등록
	else if(today == wsBgnDe + 1 || date == 1){
		if((hour < 6 && wsBgnTm > 21) || //22, 23, 24시
		   (hour < 6 && hour >= wsBgnTm) || //1, 2, 3, 4, 5시
		   (hour == 5 && wsBgnTm == 6)){ // 6시 야근등록은 5시~5:59:59까지 등록		
		} else {
			alert(msg);											
		}
	}	
	
	var wsHrCnt = obj.value - 18;
	if (wsHrCnt < 0) wsHrCnt += 24;

	document.frm.wsHrCnt.value = wsHrCnt;
	document.frm.wsBgnTm.value = obj.value;
}
function dateSetToday(){
	var year = new Date().getFullYear();
	var month = new Date().getMonth();
	var date = new Date().getDate();
	month = month + 1;
	if ((month + "").length == 1)
		month = "0" + month;
	if ((date + "").length == 1)
		date = "0" + date;	
	var today = year + "" + month + "" + date;
	
	document.frm.wsBgnDe.value = today;	
}
function dateSetYesterday(){
	var year = new Date().getFullYear();
	var month = new Date().getMonth();
	var date = new Date().getDate();

	var yesterday = new Date(new Date(year, month, date) - 1);	
	year = yesterday.getFullYear();
	month = yesterday.getMonth() + 1;
	date = yesterday.getDate();	
	
	if ((month + "").length == 1)
		month = "0" + month;
	if ((date + "").length == 1)
		date = "0" + date;
	
	var day = year + "" + month + "" + date;	
	document.frm.wsBgnDe.value = day;	
}

function list() {
	location.href = '<c:url value="${rootPath}/member/selectAbsenceState.do" />';
}
function getAbsTyp() {
	var wsTyp = document.frm.wsTyp;
	var result;
	for (var i=0; i<wsTyp.length; i++) {
		if (wsTyp[i].checked)
			result = wsTyp[i].value;
	}
	return result;
}
function chngAbsTyp() {
	var tmRow = document.getElementById("tmRow");
	var mark = document.getElementById("mark");
	var wsEndDe = document.getElementById("wsEndDe");
	var wsTmTitle = document.getElementById("wsTmTitle");
	var overTmRow = document.getElementById("overTmRow");
	var overTmPlace = document.getElementById("overTmPlace");
	var overTimeInfo = document.getElementById("overTimeInfo");
	var wsPurposeTitle = document.getElementById("wsPurposeTitle");
	var purposeInfo = document.getElementById("purposeInfo");
	var telNo = document.getElementById("telNo");
	var moblNo = document.getElementById("moblNo");
	var trWsPlace = document.getElementById("trWsPlace");
	
	if (getAbsTyp()=="O") {
		tmRow.style.display = "";
		mark.style.display = "none";
		wsEndDe.style.display = "none";
		wsEndDe.value = "99991231";

		wsTmTitle.innerHTML = "기간";
		overTmRow.style.display = "none";
		overTmPlace.style.display = "none";
		overTimeInfo.style.display = "none";
		wsPurposeTitle.innerHTML = "목적";
		purposeInfo.style.display = "";
		telNo.style.display = "";
		moblNo.style.display = "";
		trWsPlace.style.display = "";
	} else if (getAbsTyp()=="T") {
		tmRow.style.display = "none";
		mark.style.display = "";
		wsEndDe.style.display = "";
		wsEndDe.value = "";

		wsTmTitle.innerHTML = "기간";
		overTmRow.style.display = "none";
		overTmPlace.style.display = "none";
		overTimeInfo.style.display = "none";
		wsPurposeTitle.innerHTML = "목적";
		purposeInfo.style.display = "";
		telNo.style.display = "";
		moblNo.style.display = "";
		trWsPlace.style.display = "";
	} else if (getAbsTyp()=="S") {
		tmRow.style.display = "none";
		mark.style.display = "";
		wsEndDe.style.display = "";
		wsEndDe.value = "";
		
		wsTmTitle.innerHTML = "기간";
		overTmRow.style.display = "none";
		overTmPlace.style.display = "none";
		overTimeInfo.style.display = "none";
		wsPurposeTitle.innerHTML = "목적";
		purposeInfo.style.display = "";
		telNo.style.display = "";
		moblNo.style.display = "";
		trWsPlace.style.display = "";
	} else if (getAbsTyp()=="N") {
		tmRow.style.display = "";
		mark.style.display = "none";
		wsEndDe.style.display = "none";
		wsEndDe.value = "99991231";
		
		wsTmTitle.innerHTML = "날짜";
		tmRow.style.display = "none";
		overTmRow.style.display = "";
		overTmPlace.style.display = "";
		overTimeInfo.style.display = "";
		wsPurposeTitle.innerHTML = "사유";
		purposeInfo.style.display = "none";
		telNo.style.display = "none";
		moblNo.style.display = "none";
		trWsPlace.style.display = "none";
	} else {
		tmRow.style.display = "";
		mark.style.display = "none";
		wsEndDe.style.display = "none";
		wsEndDe.value = "99991231";

		wsTmTitle.innerHTML = "기간";
		overTmRow.style.display = "none";
		overTimeInfo.style.display = "none";
		wsPurposeTitle.innerHTML = "목적";
		purposeInfo.style.display = "";
		telNo.style.display = "";
		moblNo.style.display = "";
		trWsPlace.style.display = "";
	}
}
function setDefault() {
	var wsBgnDe = document.getElementById("wsBgnDe");
	var year = (new Date().getFullYear()).toString();
	var month = (new Date().getMonth() + 1).toString();
	if (month.length == 1) month = "0" + month;
	var date =  (new Date().getDate()).toString();
	if (date.length == 1) date = "0" + date;
	wsBgnDe.value = year + month + date;
	var sHours = (new Date().getHours()).toString();
	if (sHours.length == 1) sHours = "0" + sHours;
	var eHours = (new Date().getHours() + 2).toString();
	if (eHours.length == 1) eHours = "0" + eHours;
	var wsBgnTm = document.getElementById("wsBgnTm");
	var wsEndTm = document.getElementById("wsEndTm");

	//외근시간 기본값 설정 현재시각 ~ 현재시각 + 2
	for (var i = 0; i < wsBgnTm.options.length; i++) {
	   if (wsBgnTm.options[i].text == sHours) {
		   wsBgnTm.selectedIndex = i;
		   break;
	   }
	}
	for (var i = 0; i < wsEndTm.options.length; i++) {
	   if (wsEndTm.options[i].text == eHours) {
		   wsEndTm.selectedIndex = i;
		   break;
	   }
	}

	var wsPlace = document.getElementById("wsPlace");
	wsPlace.focus();
}
function docReady() {
	setDefault();
	chngAbsTyp();
}
function setUserInfo() {
	var act = new yAjax("${rootPath}/member/changeUserinfo.do", "POST");
	act.send = "no=" + document.frm.userNo.value;
	act.statechange = function(){
		var xml = act.getResXmlObject();
		document.frm.userTelno.value = xml.getValue("homeTelno", 0);
		document.frm.userMoblphonNo.value = xml.getValue("moblphonNo", 0);
	};
	act.action();
}
function changeWsTm(){
	var wsBgnDe = document.getElementById("wsBgnDe");
	var wsEndTm = document.getElementById("wsEndTm");

	if(document.frm.wsBgnTm.value == document.frm.wsEndTm.value){
		alert('외근 시작시간과 종료시간은 같을 수 없습니다.');
		wsBgnTm.selectedIndex = wsBgnTm.selectedIndex - 1;
	}		
}
</script>
</head>

<body onload="docReady();">

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
						<li class="stitle">부재현황/연장근무(야근) 등록</li>
						<li class="navi">홈 > 인사정보> 근무현황 > 부재현황/연장근무</li>
					</ul>
				</div>	
				
				
				<span class="stxt">다른 임직원의 부재현황 및 연장근무를 대신 등록할 수 있습니다.</span>
				
				<!-- S: section -->
					<div class="section01">
						<form:form commandName="KmsAbsence" name="frm" method="POST">
						<input type="hidden" name="wsHrCnt" value="0"/>
						<!-- 게시판 시작  -->
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr>
			                    	<td class="title">이름</td>
			                    	<td class="pL10">
			                    		<select name="userNo" class="span_6" onchange="setUserInfo()">
			                    			<c:forEach items="${memList}" var="mem">
				                    			<option value="${mem.no}" <c:if test="${mem.no == user.no}">selected="selected"</c:if>>${mem.userNm}</option>
			                    			</c:forEach>
			                    		</select>
			                    	</td>
		                    	</tr>		                    	
		                    	<tr>
			                    	<td class="title">근무형태</td>
			                    	<td class="pL10">
			                   	 		<label><input name="wsTyp" type="radio" value="O" onclick="chngAbsTyp();" <c:if test="${searchVO.wsTyp == 'O'}">checked="checked"</c:if>/> 외근</label>
		                    			<label><input name="wsTyp" type="radio" value="T" onclick="chngAbsTyp();" <c:if test="${searchVO.wsTyp == 'T'}">checked="checked"</c:if>/> 출장</label>
		                    			<label><input name="wsTyp" type="radio" value="S" onclick="chngAbsTyp();" <c:if test="${searchVO.wsTyp == 'S'}">checked="checked"</c:if>/> 파견</label>
		                    			<label><input name="wsTyp" type="radio" value="N" onclick="chngAbsTyp();" <c:if test="${searchVO.wsTyp == 'N'}">checked="checked"</c:if>/> 연장근무(야근)</label>
		                    		</td>
		                    	</tr>
		                    	<tr id="overTmPlace" style="display:none;">
			                    	<td class="title">접속장소</td>
			                    	<td class="pL10">${user.isInnerNetworkPrint}
			                    	<c:if test="${user.isInnerNetworkPrint == '외부'}"> * 외부접속 연장근무 등록사유를 꼭 적어주세요</c:if>
			                    	</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title"><span id="wsTmTitle">기간</span></td>
			                    	<td class="pL10">
			                    		<input type="text" name="wsBgnDe" id="wsBgnDe" class="span_6 calGen" />
			                    		<span id="mark">~</span>
			                    		<input type="text" name="wsEndDe" id="wsEndDe" class="span_6 calGen" />
			                    		<span id="overTimeInfo" style="display:none;">
			                    		<span class="button"><input type="button" value="당일" onclick="javascript:dateSetToday();" ></span>                			
			                			<span class="button"><input type="button" value="전일" onclick="javascript:dateSetYesterday();" ></span>
			                			* 자정이 지나 퇴근하는 경우 날짜 선택에 유의해주세요.</span>
			                    	</td>
		                    	</tr>
		                    	<tr id="tmRow" style="display:none;">
			                    	<td class="title">시간</td>
			                    	<td class="pL10">
			                    		<select name="wsBgnTm" id="wsBgnTm" onchange="changeWsTm();">
			                    			<option value="">--</option>
			                    			<c:forEach begin="1" end="24" var="i">
			                    				<c:choose>
			                    					<c:when test="${i<10}"><option value="0${i}">0${i}</option></c:when>
			                    					<c:otherwise><option value="${i}">${i}</option></c:otherwise>
			                    				</c:choose>
			                    			</c:forEach>
			                    		</select> ~
			                    		<select name="wsEndTm" id="wsEndTm" onchange="changeWsTm();">
			                    			<option value="">--</option>
			                    			<c:forEach begin="1" end="24" var="i">
			                    				<c:choose>
			                    					<c:when test="${i<10}"><option value="0${i}">0${i}</option></c:when>
			                    					<c:otherwise><option value="${i}">${i}</option></c:otherwise>
			                    				</c:choose>
			                    			</c:forEach>
			                    		</select>
			                    	</td>
		                    	</tr>
		                    	<tr id="overTmRow" style="display:none;">
			                    	<td class="title">근무종료시각</td>
			                    	<td class="pL10 pT5 pB5">
			                    		<ul>
			                    			<c:choose>
				                    			<c:when test="${codeResult.code > 18}">
					                    			<li>당일
						                    			<c:forEach begin="${codeResult.code}" end="24" var="i">
							                    			<label><input name="wsOverTm" type="radio" value="${i}" onclick="calcWsHrCnt(this);" /> ${i}시</label> 
						                    			</c:forEach>
					                    			</li>
					                    			<li>익일
						                    			<label><input name="wsOverTm" type="radio" value="01" onclick="calcWsHrCnt(this);" /> 01시</label>
						                    			<label><input name="wsOverTm" type="radio" value="02" onclick="calcWsHrCnt(this);" /> 02시</label>
						                    			<label><input name="wsOverTm" type="radio" value="03" onclick="calcWsHrCnt(this);" /> 03시</label>
						                    			<label><input name="wsOverTm" type="radio" value="04" onclick="calcWsHrCnt(this);" /> 04시</label>
						                    			<label><input name="wsOverTm" type="radio" value="05" onclick="calcWsHrCnt(this);" /> 05시</label>
						                    			<label><input name="wsOverTm" type="radio" value="06" onclick="calcWsHrCnt(this);" /> 06시</label>
						                    			<!-- 
						                    			<label><input name="wsOverTm" type="radio" value="07" onclick="calcWsHrCnt(this);" /> 07시</label>
						                    			<label><input name="wsOverTm" type="radio" value="08" onclick="calcWsHrCnt(this);" /> 08시</label>
						                    			<label><input name="wsOverTm" type="radio" value="09" onclick="calcWsHrCnt(this);" /> 09시</label>
						                    			 -->
					                    			</li>
				                    			</c:when>
				                    			<c:otherwise>
					                    			<li>익일
					                    				<c:forEach begin="${codeResult.code}" end="9" var="i">
							                    			<label><input name="wsOverTm" type="radio" value="0${i}" onclick="calcWsHrCnt(this);" /> 0${i}시</label>
						                    			</c:forEach>
					                    			</li>
				                    			</c:otherwise>
			                    			</c:choose>
			                    		</ul>
			                    	</td>
		                    	</tr>
		                    	<tr id="telNo">
			                    	<td class="title">유선전화</td>
			                    	<td class="pL10"><input type="text" name="userTelno" class="span_10" value="${user.homeTelno}"/></td>
		                    	</tr>
		                    	<tr id="moblNo">
			                    	<td class="title">휴대전화</td>
			                    	<td class="pL10"><input type="text" name="userMoblphonNo" class="span_10" value="${user.moblphonNo}" /></td>
		                    	</tr>
		                    	<tr id="trWsPlace">
			                    	<td class="title">행선지</td>
			                    	<td class="pL10">
			                    		<input type="text" name="wsPlace" id="wsPlace" class="span_10" /> 
			                    		<span class="icn_new">예) 삼성SDS (용산,토투밸리)</span>
			                    	</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title"><span id="wsPurposeTitle" >목적</span></td>
			                    	<td class="pL10 pT5 pB5">
			                    		<textarea name="wsPurpose" class="span_15 height_35"></textarea>
			                    		<span id="purposeInfo"><br/>예) uniLDAP 테스트 환경 설치 지원</span>
			                    	</td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						</form:form>
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="javascript:register();"><img src="${imagePath}/btn/btn_regist.gif"/></a> 
		                	<a href="javascript:list();"><img src="${imagePath}/btn/btn_cancel.gif"/></a> 
		                </div>
		                <!-- 버튼 끝 -->
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
