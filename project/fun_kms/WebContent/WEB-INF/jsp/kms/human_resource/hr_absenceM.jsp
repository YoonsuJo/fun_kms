<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="KmsAbsence" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function register() {
	if (!validateKmsAbsence(document.frm)) {
		return;
	}
	if (getAbsTyp() != "O" && document.frm.wsBgnDe.value > document.frm.wsEndDe.value) {
		alert("기간이 잘못되었습니다. 다시 확인해주세요.");
		return;
	}
	if (getAbsTyp() == "O" && (document.frm.wsBgnTm.value == "" || document.frm.wsEndTm.value == "" || document.frm.wsBgnTm.value > document.frm.wsEndTm.value)) {
		alert("시간이 잘못되었습니다. 다시 확인해주세요.");
		return;
	}

	document.frm.action = '<c:url value="${rootPath}/member/updateAbsence.do" />';
	document.frm.submit();
}
function list() {
	location.href = '<c:url value="${rootPath}/member/selectAbsenceState.do" />';
}
function getAbsTyp() {
	return "${result.wsTyp}";
}
function chngAbsTyp() {
	var tmRow = document.getElementById("tmRow");
	var mark = document.getElementById("mark");
	var wsEndDe = document.getElementById("wsEndDe");
	if (getAbsTyp()=="O") {
		tmRow.style.display = "";
		mark.style.display = "none";
		wsEndDe.style.display = "none";
		wsEndDe.value = "99991231";
	} else if (getAbsTyp()=="T") {
		tmRow.style.display = "none";
		mark.style.display = "";
		wsEndDe.style.display = "";
		wsEndDe.value = "${result.wsEndDe}";
	} else if (getAbsTyp()=="S") {
		tmRow.style.display = "none";
		mark.style.display = "";
		wsEndDe.style.display = "";
		wsEndDe.value = "${result.wsEndDe}";
	}
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
						<li class="stitle">부재현황 수정</li>
						<li class="navi">홈 > 인사정보> 근무현황 > 부재현황</li>
					</ul>
				</div>	
				
				
				<span class="stxt">외근, 출장, 파견근무 등으로 자리를 비울 경우 해당 양식에 맞게 등록합니다. 다른 임직원의 부재현황을 대신 등록할 수 있습니다.</span>
				
				<!-- S: section -->
					<div class="section01">
						<form:form commandName="KmsAbsence" name="frm" method="POST">
						<input type="hidden" name="wsId" value="${result.wsId}"/>
						<input type="hidden" name="wsHrCnt" value="0"/>
						<input type="hidden" name="wsTyp" value="${result.wsTyp}"/>
						<!-- 게시판 시작  -->
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr>
			                    	<td class="title">이름</td>
			                    	<td class="pL10">
			                    		<select name="userNo" class="span_6" onchange="setUserInfo();">
			                    			<c:forEach items="${memList}" var="mem">
				                    			<option value="${mem.no}" <c:if test="${mem.no == result.userNo}">selected="selected"</c:if>>${mem.userNm}</option>
			                    			</c:forEach>
			                    		</select>
			                    	</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">근무형태</td>
			                    	<td class="pL10">
			                    		<c:choose>
			                    			<c:when test="${result.wsTyp == 'O'}">외근</c:when>
			                    			<c:when test="${result.wsTyp == 'T'}">출장</c:when>
			                    			<c:when test="${result.wsTyp == 'S'}">파견</c:when>
			                    			<c:otherwise></c:otherwise>
			                    		</c:choose>
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">기간</td>
			                    	<td class="pL10">
			                    		<input type="text" name="wsBgnDe" class="span_6 calGen" value="${result.wsBgnDe}"/>
			                    		<span id="mark">~</span>
			                    		<input type="text" name="wsEndDe" id="wsEndDe" class="span_6 calGen" value="${result.wsEndDe}"/>
			                    	</td>
		                    	</tr>
		                    	<tr id="tmRow" style="display:none;">
			                    	<td class="title">시간</td>
			                    	<td class="pL10">
			                    		<select name="wsBgnTm">
			                    			<option value="" <c:if test="${result.wsBgnTm == ''}">selected="selected"</c:if>>--</option>
			                    			<c:forEach begin="1" end="24" var="i">
			                    				<c:choose>
			                    					<c:when test="${i<10}"><option value="0${i}" <c:if test="${result.wsBgnTmInteger == i}">selected="selected"</c:if>>0${i}</option></c:when>
			                    					<c:otherwise><option value="${i}" <c:if test="${result.wsBgnTm == i}">selected="selected"</c:if>>${i}</option></c:otherwise>
			                    				</c:choose>
			                    			</c:forEach>
			                    		</select> ~
			                    		<select name="wsEndTm">
			                    			<option value="" <c:if test="${result.wsEndTm == ''}">selected="selected"</c:if>>--</option>
			                    			<c:forEach begin="1" end="24" var="i">
			                    				<c:choose>
			                    					<c:when test="${i<10}"><option value="0${i}" <c:if test="${result.wsEndTmInteger == i}">selected="selected"</c:if>>0${i}</option></c:when>
			                    					<c:otherwise><option value="${i}" <c:if test="${result.wsEndTm == i}">selected="selected"</c:if>>${i}</option></c:otherwise>
			                    				</c:choose>
			                    			</c:forEach>
			                    		</select>
			                    	</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">유선전화</td>
			                    	<td class="pL10"><input type="text" name="userTelno" class="span_10" value="${result.userTelno}"/></td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">휴대전화</td>
			                    	<td class="pL10"><input type="text" name="userMoblphonNo" class="span_10" value="${result.userMoblphonNo}" /></td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">장소</td>
			                    	<td class="pL10"><input type="text" name="wsPlace" class="span_10" value="${result.wsPlace}" /></td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">목적</td>
			                    	<td class="pL10 pT5 pB5">
			                    		<textarea name="wsPurpose" class="span_15 height_170">${result.wsPurpose}</textarea>
			                    	</td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						</form:form>
                   		<script type="text/javascript">chngAbsTyp();</script>
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="javascript:register();"><img src="${imagePath}/btn/btn_modify.gif"/></a> 
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
