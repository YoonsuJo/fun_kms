<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
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
							<li class="stitle">결재 완료된 ${appTyp.docSj} 수정</li>
							<li class="navi">홈 > 전자결재 > 기안하기</li>
						</ul>
					</div>
					
					<span class="stxt">결재 완료된 문서를 수정하여 다시 기안합니다.<br/>다시 기안한 문서가 승인되면 기존에 결재된 문서의 효력이 상실되고 이 문서의 내용으로 대체됩니다.</span>
	
					<!-- S: section -->
					<div class="section01">
						
						<p class="th_stitle mB10">결재정보</p>
						<!-- 게시판 시작  -->
						<form:form commandName="approvalVO" id="approvalVO1" name="approvalVO" method="post" enctype="multipart/form-data" >
						<form:hidden path="templtId" />
						 <form:hidden path="parntId" />
						 <form:hidden path="reWriteYn" />
						<div class="boardWrite02 mB20">
							<jsp:include page="${jspPath}/approval/include/commonTopW.jsp"></jsp:include>
						</div>
						
						
						
						<p class="th_stitle mB10">세부내용</p>
						<p class="th_stitle2 mB10">기 결재된 휴가신청 정보</p>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr>
			                    	<td class="title">구분</td>
			                    	<td class="pL10">
			                    		<input type="radio" name="break" value="1" checked> 연차 
			                    		<input type="radio" name="break" value="2"> 경조휴가 
			                    		<input type="radio" name="break" value="3"> 특별휴가 
			                    		<!-- <input type="radio" name="break" value="5"> 하계휴가 -->
			                    		<input type="radio" name="break" value="4"> 기타
			                    	</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">기간</td>
			                    	<td class="pL10"><input type="text" name="sdate" class="span_5" /> <input type="radio" name="stime" value="1" checked> 오전  <input type="radio" name="stime" value="2"> 오후 부터 <input type="text" name="edate" class="span_5" /> <input type="radio" name="etime" value="1" checked> 오전  <input type="radio" name="etime" value="2"> 오후 까지 총 <input type="text" name="date" class="span_3" /> 일간</td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						
						<p class="th_stitle2 mB10">변경된 휴가신청 정보</p>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr>
			                    	<td class="title">구분</td>
			                    	<td class="pL10">
			                    		<input type="radio" name="mbreak" value="1" checked> 연차 
			                    		<input type="radio" name="mbreak" value="2"> 경조휴가 
			                    		<input type="radio" name="mbreak" value="3"> 특별휴가 
			                    		<!-- <input type="radio" name="mbreak" value="5"> 하계휴가 -->
			                    		<input type="radio" name="mbreak" value="4"> 기타
			                    	</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">기간</td>
			                    	<td class="pL10"><input type="text" name="msdate" class="span_5" /> <input type="radio" name="mstime" value="1" checked> 오전  <input type="radio" name="mstime" value="2"> 오후 부터 <input type="text" name="medate" class="span_5" /> <input type="radio" name="metime" value="1" checked> 오전  <input type="radio" name="metime" value="2"> 오후 까지 총 <input type="text" name="mdate" class="span_3" /> 일간</td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						
						<p class="th_stitle2 mB10">기안내용</p>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup><col class="col120" /><col width="px" /><col class="col40"></colgroup>
		                    <tbody>
		                    	<tr>
			                    	<td class="title">내용</td>
			                    	<td class="pL10"><input type="text" name="reply" class="span_15 height_35"/></td>
			                    	<td>
				                    	<ul class="arrow">
			                    			<li><img src="${imagePath}/btn/btn_arrow_top.gif" /></li>
			                    			<li class="dotline"></li>
			                    			<li><img src="${imagePath}/btn/btn_arrow_down.gif" /></li>
			                    		</ul>
			                    	</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">첨부파일</td>
			                    	<td class="pL10"><input type="file" name="file" class="span_15" /></td>
			                    	<td></td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<img src="${imagePath}/btn/btn_report.gif"/> <img src="${imagePath}/btn/btn_cancel.gif"/>
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
