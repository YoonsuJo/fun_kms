<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>

<script>

var id = "";
var nm = "";

<c:forEach items="${orgList}" var="org" varStatus="c">
id += "${org.id},";
nm += "${org.nm},";
</c:forEach>

<c:forEach items="${sectorList}" var="sector" varStatus="c">
<c:if test="${sector.no == searchVO.searchSectorNo}">
var sectorNo = "${sector.no}";
var sectorVal = "${sector.busiSectorVal}";
</c:if>
</c:forEach>

$(document).ready(function(){
	var form =$('#searchVO');
	form.attr('action','/management/selectBusinessPlanApp.do');
	function search(){
		form.submit();
	};  
	$('#searchYearPrev').click(function(){
		form.find('[name=searchYear]').val(parseInt(form.find('[name=searchYear]').val()) - 1 );
		search();
	});
	$('#searchYearNext').click(function(){
		form.find('[name=searchYear]').val(parseInt(form.find('[name=searchYear]').val()) + 1 );
		search();
	});

	$('select[name=searchSectorNo]').change(function(){
		search();
	});
	
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
						<li class="stitle">사업계획 승인내역</li>
						<li class="navi">홈 > 경영정보 > 사업계획 > 연간사업계획</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
				
			    	<!-- 상단 검색창 시작 -->
			    	<form:form commandName="searchVO" name="searchVO" id="searchVO" method="post" enctype="multipart/form-data" >
			    	<form:hidden path="searchYear"/>
					<fieldset>
					<legend>상단 검색</legend>
	                    <div class="scheduleDate mB20">
	                		<ul>
	                		<li>
		                		<img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지" class="cursorPointer" id="searchYearPrev"/>
	                			${searchVO.searchYear}년 
								<img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지" class="cursorPointer" id="searchYearNext"/>	
	                		</li>
	                		<li class="li_right">
	                			<span class="option_txt">사업구분 :</span><span class="pL7"></span>
	                			<select name="searchSectorNo">
	                				<c:forEach items="${sectorList}" var="sector">
	                					<option value="${sector.no}" <c:if test="${sector.no == searchVO.searchSectorNo}">selected="selected"</c:if>>${sector.busiSectorNm}</option>	
	                				</c:forEach>
	                			</select>
	                		</li>
	                		</ul>
						</div>
	                </fieldset>
	                </form:form>
	            	<!--// 상단 검색창 끝 -->
	            
	           		 	<!-- 게시판 시작  -->
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup>
		                    	<col class="col250" />
		                    	<col width="px" />
		                    	<col class="col70" />
		                    	<col class="col70" />
		                    	<col class="col40" />
	                    	</colgroup>
		                    <thead>
		                    	<tr>
		                    		<th>사업구분(부서)</th>
		                    		<th>제목</th>
		                    		<th>상신자</th>
		                    		<th>상신일</th>
		                    		<th class="td_last">수정</th>
	                    		</tr>
		                    </thead>
		                    <tbody>
		                    	<c:forEach items="${resultList}" var="result">
			                    	<tr>
				                    	<td class="pL10"><print:org orgnztNm="${result.orgnztNm}" orgnztId="${result.orgnztId}" orgnztFnm="${result.orgnztFnm}"/> </td>
				                    	<td class="txt_center"><a href="/approval/approvalV.do?docId=${result.docId}" target="_blank">${result.subject }</a></td>
				                    	<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/> </td>
				                    	<td class="txt_center"><print:date date="${result.docDt}"/></td>
				                    	<td class="td_last txt_center">
				                    		<c:if test="${user.admin||result.writerNo == user.no }">
					                    		<a href="/approval/approvalRW.do?docId=${result.docId}">
					                    			<img src="${imagePath}/btn/btn_plus02.gif"/>
					                    		</a>
				                    		</c:if>
				                    	</td>
			                    	</tr>
		                    	</c:forEach>
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
