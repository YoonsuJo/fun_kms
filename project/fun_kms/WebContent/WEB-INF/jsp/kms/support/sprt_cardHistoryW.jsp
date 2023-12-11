<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<script>
$(document).ready(function(){

	var form = $('#cardHistoryVO');
	
	$('#cardHistoryInsertB').click(function(){
		form.attr("action","/support/insertCardHistory.do");
		form.submit();
	});
	$('#usrGenB').click(function(){
		usrGen('userMix',1);
	});

	$('#cardBackB').click(function(){
		history.back(-1);
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
							<li class="stitle">법인카드 사용등록</li>
							<li class="navi">홈 > 업무지원 > 자원관리 > 법인카드 관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<form:form commandName="cardHistoryVO" name="cardHistoryVO" method="post" id="cardHistoryVO">
					<form:hidden path="cardId"/>
					<div class="section01">
					
						<!-- 법인카드 사용등록  -->
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>법인카드 사용등록</caption>
		                    <colgroup>
			                    <col class="col120" />
			                    <col width="px" />
		                    </colgroup>
		                    <tbody>
		                    	<tr>
		                    		<td class="title">카드번호</td>
			                    	<td class="td_last pL10">${cardHistoryVO.cardId }</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">사용자</td>
			                    	<td class="td_last pL10">
			                    		<form:input path="userMix" cssClass="input01 span_6 userNamesAuto userValidateCheck"/>
			                    		<img src="${imagePath}/btn/btn_tree.gif" id="usrGenB" class="search_btn02 cursorPointer"/>
			                    	</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">비고</td>
			                    	<td class="td_last pL10">
			                    		<form:input path="note" cssClass="input01 span_24"/>
			                    	</td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						<!--// 차량정보 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<img src="${imagePath}/btn/btn_regist.gif" id="cardHistoryInsertB" class="cursorPointer" />
		                	<img src="${imagePath}/btn/btn_cancel.gif" id="cardBackB" class="cursorPointer" />
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
