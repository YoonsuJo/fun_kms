<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="carRsv" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
var userAge = 0;
var userLicTyp = "";
var insAge = 0;
var insLicTyp = "";

function update() {
	if (!validateCarRsv(document.frm)) {
		return;
	}

	if (insAge > userAge) {
		alert("보험연령 조건이 맞지 않습니다.\r\n예약할 수 없습니다.");
		return;
	}
	if (insLicTyp < userLicTyp) {
		alert("보험면허 조건이 맞지 않습니다.\r\n예약할 수 없습니다.");
		return;
	}
	document.frm.submit();					
}
function setInsInfo(obj) {
	if (obj.value == '') {
		$('#insInfo').hide();
		return;
	}
	$('#insInfo').show();
	var act = new yAjax("${rootPath}/ajax/getCarInfo.do", "POST");
	act.send = "carId=" + obj.value;
	act.statechange = function(){
		var xml = act.getResXmlObject();
		var age = xml.getValue("age", 0);
		var carLicTyp = xml.getValue("carLicTyp", 0);
		var carLicTypPrint = xml.getValue("carLicTypPrint", 0);

		insAge = age;
		insLicTyp = carLicTyp;
		$('#insAge').html(age);
		$('#insLicTyp').html(carLicTypPrint);
	};
	act.action();
}
function setUserInfo() {
	var str = $('#userNm').get(0).value;
	if (str.indexOf('(') == -1 || str.indexOf(')') == -1 || str.indexOf('(') > str.indexOf(')')) {
		userAge = 0;
		userLicTyp = "";
		$('#userInfo').hide();
		return;
	}
	$('#userInfo').show();
	var act = new yAjax("${rootPath}/ajax/getMemberInfo.do", "POST");
	act.send = "userNm=" + str;
	act.statechange = function(){
		var xml = act.getResXmlObject();
		var age = xml.getValue("age", 0);
		var carLicTyp = xml.getValue("carLicTyp", 0);
		var carLicTypPrint = xml.getValue("carLicTypPrint", 0);

		userAge = age;
		userLicTyp = carLicTyp;
		$('#userAge').html(age);
		$('#carLicTyp').html(carLicTypPrint);
	};
	act.action();
}
$(document).ready(function() {
	setUserInfo($('#userNm').get(0));
	setInsInfo($('#carId').get(0));
});
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
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">법인차량 사용 예약</li>
							<li class="navi">홈 > 업무지원 > 각종신청 > 법인차량 사용신청</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						<span class="stxt">사용자 개인정보에 면허종별을 등록하지 않으면 차량 예약이 정상적으로 진행되지 않을 수도 있습니다.</span>
						<!-- 차량정보 시작  -->
						<form:form name="frm" commandName="carRsv" action="${rootPath}/support/updateCarRsv.do" method="POST">
						<input type="hidden" name="no" value="${result.no}"/>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>법인차량 사용 예약</caption>
		                    <colgroup><col class="col100" /><col width="px" /><col class="col100" /><col class="col120"/></colgroup>
		                    <tbody>
		                    	<tr>
		                    		<td class="title">차량구분</td>
			                    	<td colspan="3" class="td_last pL10">
			                    		<select class="select01" name="carId" id="carId" onchange="setInsInfo(this);">
			                    			<option value="">==== 선택 ====</option>
			                    			<c:forEach items="${carList}" var="car">
				                    			<option value="${car.carId}" <c:if test="${car.carId == result.carId}">selected="selected"</c:if>>${car.carTyp}(${car.carId})</option>
			                    			</c:forEach>
			                    		</select>
			                    		<span id="insInfo" style="display:none;"> 보험연령 : 만 <span id="insAge">26</span>세 이상 / 면허종별 : <span id="insLicTyp">1종보통</span> 이상</span>
			                    	</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">사용자</td>
			                    	<td class="pL10">
			                    		<input type="text" name="userNm" id="userNm" class="input01 span_6 userNameAuto userValidateCheck" value="${result.userNm}(${result.userId})" onblur="setUserInfo();"/>
			                    		<img src="${imagePath}/btn/btn_tree.gif" class="search_btn02 cursorPointer" onclick="usrGen('userNm',1,setUserInfo);"/>
			                    		<span id="userInfo" style="display:none;"> 연령 : 만 <span id="userAge"></span>세 / 면허종별 : <span id="carLicTyp"></span></span>
			                    	</td>
			                    	<td class="title">예약자</td>
			                    	<td class="td_last pL10"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">사용기간</td>
			                    	<td colspan="3" class="td_last pL10">
			                    		<input type="text" class="input01 span_4 calGen" maxlength="8" name="stDt" value="${result.stDt}"/>
			                    		<select class="select01" name="stTm">
			                    			<c:forEach begin="0" end="23" var="tm">
				                    			<option value="${tm}" <c:if test="${tm == result.stTm}">selected="selected"</c:if>>${tm}시</option>
			                    			</c:forEach>
			                    		</select>
			                    		~
			                    		<input type="text" class="input01 span_4 calGen" maxlength="8" name="edDt" value="${result.edDt}"/>
			                    		<select class="select01" name="edTm">
			                    			<c:forEach begin="0" end="23" var="tm">
				                    			<option value="${tm}" <c:if test="${tm == result.edTm}">selected="selected"</c:if>>${tm}시</option>
			                    			</c:forEach>
			                    		</select>
			                    	</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">사용목적</td>
			                    	<td colspan="3" class="td_last pL10">
			                    		<label><input type="radio" class="radio" name="purpose" value="W" checked="checked"/> 업무용</label>
			                    		<label><input type="radio" class="radio" name="purpose" value="P"/> 개인사용</label>
			                    		<script>
			                    			setValue("purpose", "${result.purpose}");
			                    		</script>
			                    	</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">행선지</td>
		                    		<td class="pL10"><input type="text" class="input01 span_29" name="destination" value="${result.destination}"/></td>
		                    		<td class="title">운행예정거리</td>
			                    	<td class="td_last pL10"><input type="text" class="input01 span_5" name="runLength" value="${result.runLength}"/> km</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">비고</td>
			                    	<td colspan="3" class="td_last pL10 pT10 pB10"><textarea class="span_24" name="rsvNote">${result.rsvNote}</textarea></td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						</form:form>
						<!--// 차량정보 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="javascript:update();"><img src="${imagePath}/btn/btn_modify.gif"/></a>
		                	<a href="${rootPath}/support/selectCarRsvCalendar.do"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
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
