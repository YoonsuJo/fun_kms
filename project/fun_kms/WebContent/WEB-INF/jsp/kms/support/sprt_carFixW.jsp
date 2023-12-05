<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="carFix" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function register() {
	if (!validateCarFix(document.frm)) {
		return;
	}
	
	if (confirm('<spring:message code="common.regist.msg" />')) {
		document.frm.submit();					
	}
}
function goBack() {
	history.back(-1);
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
							<li class="stitle">법인차량 정비이력 등록</li>
							<li class="navi">홈 > 업무지원 > 자원관리 > 법인차량 관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<!-- 차량정보 시작  -->
						<form:form name="frm" commandName="carFix" action="${rootPath}/support/insertCarFixInfo.do" method="POST">
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>법인차량 정비이력 등록</caption>
		                    <colgroup>
			                    <col class="col120" />
			                    <col width="px" />
		                    </colgroup>
		                    <tbody>
		                    	<tr>
		                    		<td class="title">정비 차량</td>
			                    	<td class="pL10">
			                    		<select class="select01" name="carId">
			                    			<c:forEach items="${carList}" var="car">
				                    			<option value="${car.carId}" <c:if test="${car.carId == carId}">selected="selected"</c:if>>${car.carTyp}(${car.carId})</option>
			                    			</c:forEach>
			                    		</select>
			                    	</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">정비자</td>
			                    	<td class="pL10">
			                    		<input type="text" class="input01 span_6 userNameAuto userValidateCheck" name="userNm" id="userNm" value="${user.userNm}(${user.userId})" <c:if test="${user.admin == false}">readonly="readonly"</c:if>/>
			                    		<c:if test="${user.admin}">
			                    		<img src="${imagePath}/btn/btn_tree.gif" class="search_btn02 cursorPointer" onclick="usrGen('userNm',1)"/>
			                    		</c:if>
			                    	</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">정비일자</td>
			                    	<td class="pL10"><input type="text" class="input01 span_6 calGen" name="fixDate"/></td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">운행거리</td>
			                    	<td class="pL10"><input type="text" class="input01 span_6" name="runLength"/> km</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">정비항목</td>
			                    	<td class="pL10"><input type="text" class="input01 span_24" name="fixItem"/></td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">정비 상세내역</td>
			                    	<td class="pL10 pT10 pB10"><textarea class="span_24" name="fixItemDetail"></textarea></td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">비고</td>
			                    	<td class="pL10 pT10 pB10"><textarea class="span_24" name="fixNote"></textarea></td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						</form:form>
						<!--// 차량정보 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="javascript:register();"><img src="${imagePath}/btn/btn_regist.gif"/></a>
		                	<a href="javascript:goBack();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
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
