<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="KmsOvertime" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function register() {
	if (!validateKmsOvertime(document.frm)) {
		return;
	}
	document.frm.action = '<c:url value="${rootPath}/member/insertOvertime.do" />';
	document.frm.submit();
}
function list() {
	location.href = '<c:url value="${rootPath}/member/selectOvertimeView.do" />';
}
function calcWsHrCnt(obj) {
	var wsHrCnt = obj.value - 18;
	if (wsHrCnt < 0) wsHrCnt += 24;

	document.frm.wsHrCnt.value = wsHrCnt;
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
						<li class="stitle">연장근무  보고</li>
						<li class="navi">홈 > 인사정보> 근무현황 >연장근무내역</li>
					</ul>
				</div>	
				
				
				<span class="stxt">퇴근시간 이후 추가 근무한 경우 양식에 맞게 등록합니다. 다른 임직원의 연장근무내역을 대신 등록할 수 있습니다.</span>
				
				<!-- S: section -->
					<div class="section01">
						<form:form commandName="KmsOvertime" name="frm" method="POST">
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
			                    		<select name="userNo" class="span_6">
			                    			<c:forEach items="${memList}" var="mem">
				                    			<option value="${mem.no}" <c:if test="${mem.no == user.no}">selected="selected"</c:if>>${mem.userNm}</option>
			                    			</c:forEach>
			                    		</select>
			                    	</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">근무형태</td>
			                    	<td class="pL10">
			                    		연장근무
			                    		<input type="hidden" name="wsTyp" value="N"/>
			                    	</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">날짜</td>
			                    	<td class="pL10">
				                    	<input type="text" name="wsBgnDe" class="span_6 calGen" maxlength="8" /> 
				                    	<input type="hidden" name="wsEndDe" class="span_6" value="99991231" /> 
			                    		** 자정이 지나 퇴근하는 경우 날짜 선택에 유의해 주세요
			                    	</td>
		                    	</tr>
		                    	<tr>
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
						                    			<label><input name="wsOverTm" type="radio" value="07" onclick="calcWsHrCnt(this);" /> 07시</label>
						                    			<label><input name="wsOverTm" type="radio" value="08" onclick="calcWsHrCnt(this);" /> 08시</label>
						                    			<label><input name="wsOverTm" type="radio" value="09" onclick="calcWsHrCnt(this);" /> 09시</label>
					                    			</li>
				                    			</c:when>
				                    			<c:otherwise>
					                    			<li>익일
					                    				<c:forEach begin="${codeResult.code}" end="9" var="i">
							                    			<label><input name="wsBgnTm" type="radio" value="0${i}" onclick="calcWsHrCnt(this);" /> 0${i}시</label>
						                    			</c:forEach>
					                    			</li>
				                    			</c:otherwise>
			                    			</c:choose>
			                    		</ul>
			                    	</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">사유</td>
			                    	<td class="pL10 pT5 pB5">
			                    	 * 연장근무 사유를 입력해 주세요.<br/>
			                    	<textarea name="wsPurpose" class="span_15 height_170"></textarea></td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						<!--// 게시판 끝  -->
						</form:form>
						
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
