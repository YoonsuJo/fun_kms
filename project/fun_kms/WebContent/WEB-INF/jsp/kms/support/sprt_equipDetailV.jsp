<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
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
							<li class="stitle">전산장비 상세정보</li>
							<li class="navi">홈 > 업무지원 > 자원관리 > 전산장비 관리</li>
						</ul>
					</div>
					<!-- S: section -->
					<div class="section01">
						<!-- 장비사용정보 시작  -->
						<p class="th_stitle">장비사용정보</p>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			                    <caption>장비사용정보 보기</caption>
			                    <colgroup>
				                    <col class="col120" />
				                    <col width="px" />
			                    </colgroup>
			                    <tbody>
			                    	<tr>
			                    		<td class="title">사용자</td>
				                    	<td class=" pL10">${equipVO.user_nm}</td>
			                    	</tr>
			                    	<tr>
			                    		<td class="title">소속</td>
				                    	<td class=" pL10">${equipVO.team_name}</td>
			                    	</tr>
			                    	<tr>
			                    		<td class="title">사용처</td>
				                    	<td class=" pL10">${equipVO.place}</td>
			                    	</tr>
			                    	<tr>
			                    		<td class="title">상태</td>
				                    	<td class=" pL10">
											<c:choose>
					                    		<c:when test="${equipVO.status == '1-public'}">공용</c:when>
					                    		<c:when test="${equipVO.status == '2-personal'}">개인용</c:when>
					                    		<c:when test="${equipVO.status == '3-server'}">서버용</c:when>
					                    		<c:when test="${equipVO.status == '4-repair'}">수리중</c:when>
					                    		<c:when test="${equipVO.status == '5-extra'}">여분</c:when>
					                    		<c:when test="${equipVO.status == '6-disuse'}">폐기</c:when>
					                    		<c:otherwise></c:otherwise>
				                    		</c:choose>
				                    	</td>
			                    	</tr>
			                    	<tr>
			                    		<td class="title">비고</td>
				                    	<td class=" pL10">${equipVO.etc}</td>
			                    	</tr>
			                    </tbody>
		                    </table>
						</div>
						<!--// 장비사용정보 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<c:if test="${user.admin}">
		                		<a href="/support/updateEquipDetailView.do?idx=${equipVO.idx}&equip_no=${equipVO.equip_no}"><img src="${imagePath}/btn/btn_modify.gif" class="cursorPointer" /></a>
		                		<a href="/support/deleteEquipDetail.do?idx=${equipVO.idx}&equip_no=${equipVO.equip_no}"><img src="${imagePath}/btn/btn_delete.gif" class="cursorPointer" /></a>
		                	</c:if>
		                	<a href="javascript:history.back();"><img src="${imagePath}/btn/btn_list.gif" class="cursorPointer" /></a>
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
