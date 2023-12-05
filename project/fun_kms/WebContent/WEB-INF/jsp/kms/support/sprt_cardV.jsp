<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<script>
$(document).ready(function(){

	var searchForm = $('#searchVO');
	$('#cardModifyB').click(function(){
		searchForm.attr("action","/support/modifyCard.do");
		searchForm.submit();
	});
	//카드삭제 버튼은 숨겨둠
	$('#cardDeleteB').click(function(){
		alert('준비중입니다.');
		return false;
		if(confirm("정말 삭제하시겠습니까? 카드 사용내역이 있을 시 관련 통계가 잘못될 수 있습니다.")) {
			searchForm.attr("action","/support/deleteCard.do");
			searchForm.submit();
		}
	});
	$('#cardListB').click(function(){
		searchForm.attr("action","/support/selectCardList.do");
		searchForm.submit();
	});
	$('#cardWithdrawB').click(function(){
		if(confirm("카드를 회수하시겠습니까?")){
			searchForm.attr("action","/support/insertCardHistory.do");
			searchForm.submit();
		}
	});
	$('#cardWriteHistoryB').click(function(){
		searchForm.attr("action","/support/writeCardHistory.do");
		searchForm.submit();
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
							<li class="stitle">법인카드 상세정보</li>
							<li class="navi">홈 > 업무지원 > 자원관리 > 법인카드 관리</li>
						</ul>
					</div>
					<form:form commandName="searchVO" name="searchVO" method="post" id="searchVO">
						<form:hidden path="cardId"/>
					</form:form>
					
					<!-- S: section -->

					<div class="section01">
					
					
						<!-- 카드정보 시작  -->
						<p class="th_stitle">카드정보</p>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>카드정보 보기</caption>
		                    <colgroup>
			                    <col class="col120" />
			                    <col width="px" />
		                    </colgroup>
		                    <tbody>
		                    	<tr>
		                    		<td class="title">카드번호</td>
			                    	<td class="td_last pL10">${cardVO.cardId }</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">유효기간</td>
			                    	<td class="td_last pL10">${cardVO.expiryYear }년 ${cardVO.expiryMonth }월</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">회사구분</td>
			                    	<td class="td_last pL10">${cardVO.companyNm }</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">한도</td>
			                    	<td class="td_last pL10"><print:currency cost="${cardVO.limitSpend }"/> 원</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">카드상태</td>
			                    	<td class="td_last pL10">
			                    		${cardVO.statNm }
			                    	</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">비고</td>
			                    	<td class="td_last pL10">
			                    		${cardVO.cardCt }
			                    	</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">지급상태</td>
			                    	<td class="td_last pL10">
			                    		<c:choose>
				                    		<c:when test="${empty cardVO.userId }">
				                    		미지급
				                    		</c:when>
				                    		<c:otherwise>
				                    		지급 (<print:user userNo="${cardVO.userNo}" userNm="${cardVO.userNm }"/> )
				                    		</c:otherwise>
			                    		</c:choose>
			                    	
			                    	</td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						<!--// 카드정보 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<c:if test="${user.admin}">
		                		<input type="image" src="${imagePath}/btn/btn_modify.gif" id="cardModifyB" class="cursorPointer" /> 
<!--		                		<input type="image" src="${imagePath}/btn/btn_delete.gif" id="cardDeleteB" class="cursorPointer" />-->
		                	</c:if>
		                	<input type="image" src="${imagePath}/btn/btn_list.gif" id="cardListB" class="cursorPointer" />
		                </div>
		                <!-- 버튼 끝 -->
		                
		                <!-- 사용이력 시작  -->
						<p class="th_stitle">사용이력</p>
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>사용이력 보기</caption>
		                    <colgroup><col class="col60" /><col class="col200" /><col width="px" /></colgroup>
		                    <thead>
		                    	<tr>
		                    		<th>사용자</th>
		                    		<th>사용기간</th>
		                    		<th class="td_last">비고</th>
		                    	</tr>
		                    </thead>
		                    <tbody>
		                    	<c:forEach items="${cardHistoryVOList}" var="result">
		                    		<tr>
			                        	<td class="txt_center">
					                    	<c:choose>
					                    		<c:when test="${empty result.userId }">
					                    		미지급
					                    		</c:when>
					                    		<c:otherwise>
					                    			<print:user userNo="${result.userNo }" userNm="${result.userNm }"/> 
					                    		</c:otherwise>
				                    		</c:choose>
				                    	</td>
				                    	<td class="txt_center">
				                    		<print:date date="${result.stDt}"/>
				                    		 ~ 
											<c:choose>
												<c:when test="${empty result.edDt}">
													현재
												</c:when>
												<c:otherwise>
													<print:date date="${result.edDt}"/>
												</c:otherwise>
											</c:choose> 
										</td>
				                    	<td class="td_last pL10">${result.note}</td>
		                    		</tr>
		                    	
		                    	</c:forEach>
		                    	
		                    </tbody>
		                    </table>
						</div>
						<!--// 처리내역 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<c:if test="${not empty cardVO.userId && user.admin}">
		                		<input type="image" src="${imagePath}/btn/btn_recovery.gif" id="cardWithdrawB" class="cursorPointer" />
		                	</c:if> 
		                	<c:if test="${user.admin}">
		                		<input type="image" src="${imagePath}/btn/btn_useRegist.gif" id="cardWriteHistoryB" class="cursorPointer" />
		                	</c:if>
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
