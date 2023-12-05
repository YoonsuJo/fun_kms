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
							<li class="stitle">업무지원 신청양식 선택</li>
							<li class="navi">홈 > 업무지원 > 각종신청</li>
						</ul>
					</div>
					
					<span class="stxt">양식을 선택하여 담당자에게 업무지원을 요청할 수 있습니다.</span>
	
					<!-- S: section -->
					<div class="section01">
						
						<p class="th_stitle">결재문서 양식</p>
						<!-- 게시판 시작  -->
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup><col class="col200" /><col width="px" /></colgroup>
		                    <thead>
		                    	<tr>
		                    		<th>양식구분</th>
		                    		<th class="td_last">설명</th>
		                    	</tr>
		                    </thead>
		                    <tbody>
		                    	<tr>
			                    	<td class="td_ico">
			                    		<ul>
			                    			<li><img src="${imagePath}/approval/ico_general.gif" /></li>
			                    			<li class="pT15 pL10">명함신청</li>
			                    		</ul>
			                    	</td>
			                    	<td class="td_last pL10">명함을 신청하는 양식입니다.</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="td_ico">
			                    		<ul>
			                    			<li><img src="${imagePath}/approval/ico_employ.gif" /></li>
			                    			<li class="pT15 pL10">채용요청</li>
			                    		</ul>
			                    	</td>
			                    	<td class="td_last pL10">채용요청 관련 양식입니다.</td>
		                    	</tr>		                    			                    			                    	
		                    </tbody>
		                    </table>
						</div>
						<!--// 게시판 끝  -->
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
