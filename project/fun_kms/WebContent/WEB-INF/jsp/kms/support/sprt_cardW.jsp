<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="cardReg" staticJavascript="false" xhtml="true" cdata="false"/>
</head>
<script>
$(document).ready(function(){

	var mode = "${mode}";
	var form = $('#cardVO');
	var searchForm = $('#searchVO');

	$('[name=limitSpend]').keyup(function(){
		jsMakeCurrency(this);
	});	
	$('#cardInsertB').click(function(){

		
		if (!validateCardReg(document.cardVO)) {
			return false;
		}

		$('[name=limitSpend]').val(jsDeleteComma($('[name=limitSpend]').val()));
		if(mode=="W")
			form.attr("action","/support/insertCard.do");
		else
			form.attr("action","/support/updateCard.do");
		form.submit();
	});
	$('#backB').click(function(){
		form.attr("action","/support/selectCardList.do");
		form.submit();
	});
});
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
							<li class="stitle">법인카드 <c:if test="${mode == 'W'}">등록</c:if><c:if test="${mode == 'M'}">수정</c:if></li>
							<li class="navi">홈 > 업무지원 > 자원관리 > 법인카드 관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<form:form commandName="cardVO" name="cardVO" method="post" id="cardVO">
						<!-- <form:hidden path="cardId"/> -->
					<div class="section01">
					
						<!-- 법인카드 등록  -->
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>법인카드 등록</caption>
		                    <colgroup><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr>
		                    		<td class="title">카드번호</td>
			                    	<td class=" pL10">
			                    		<c:if test="${mode == 'W'}">
			                    			<form:input cssClass="input01 span_29" path="cardId"/>
			                    		</c:if> 
			                    		<c:if test="${mode == 'M'}">
			                    			<form:input cssClass="input01 span_29" path="cardId"/>
			                    			<input type="hidden" name="beforeCardId" value="${cardVO.beforeCardId}" />
			                    		</c:if> 
			                    	</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title ">유효기간</td>
			                    	<td class=" pL10">
			                    		<form:input path="expiryYear" cssClass="input01 span_2"/> 년 
			                    		<form:input path="expiryMonth" cssClass="input01 span_2"/> 월
			                    	</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title ">회사구분</td>
			                    	<td class=" pL10">
			                    		<form:select path="companyCd"  items="${companyList}" itemLabel="codeNm" itemValue="code">
			                    		</form:select>
			                    		
			                    	</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title ">한도</td>
			                    	<td class=" pL10">
			                    		<input name="limitSpend" class="span_29" id="limitSpend" value="<print:currency cost="${cardVO.limitSpend }"></print:currency>"/>원
			                    	</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title ">카드상태</td>
			                    	<td class=" pL10">
			                    		<form:radiobuttons path="stat" items="${cardStatList}" itemLabel="codeNm" itemValue="code"/>
			                    	</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">비고</td>
			                    	<td class=" pL10">
			                    		<form:input path="cardCt" cssClass="input01 span_24"/>
			                    	</td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						<!--// 카드정보 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<img src="${imagePath}/btn/btn_regist.gif" class="cursorPointer" id="cardInsertB"/> 
		                	<img src="${imagePath}/btn/btn_cancel.gif" class="cursorPointer" id="backB"/>
		                </div>
		                <!-- 버튼 끝 -->
					</div>
					</form:form>
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
