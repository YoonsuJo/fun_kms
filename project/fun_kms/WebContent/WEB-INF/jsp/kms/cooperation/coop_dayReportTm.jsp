<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search() {
	document.frm.action = "${rootPath}/cooperation/getDayReportStats.do";
	document.frm.submit();
}
function excelDown() {
	document.frm.action = "${rootPath}/cooperation/getDayReportStatsExcel.do";
	document.frm.submit();
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
							<li class="stitle">엑셀</li>
							<li class="navi">홈 > 업무공유 > </li>
						</ul>
					</div>
	
				<!-- S: section -->
				<div class="section01">
			    	
			    	<!-- 상단 검색창 시작 -->
			    	<form name="frm" method="get" action="${rootPath}/cooperation/getDayReportStats.do" onsubmit="search(); return false;">
					<fieldset>
					<legend>상단 검색</legend>
						<div class="top_search mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<tbody>
							<tr>
								<td>
									<input type="text" class="input01 span_6 calGen" name="sDate" value="${searchVO.sDate}"/> ~
									<input type="text" class="input01 span_6 calGen" name="eDate" value="${searchVO.eDate}"/>
									<input type="image" src="${imagePath}/btn/btn_search02.gif"  class="search_btn02" alt="검색"/>
									<img src="${imagePath}/btn/btn_excelSave.gif" class="search_btn02 cursorPointer" onclick="excelDown()" alt="엑셀다운"/>
								</td>
							</tr>
						</tbody>
						</table>
	                    </div>
	                </fieldset>
			    	</form>
                	<!-- 상단 검색창 끝 -->
                	
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="">
						<caption>엑셀리스트</caption>
						<colgroup>
							<col width="px" />
							<col width="px" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">이름</th>
								<c:forEach items="${dateList}" var="date">
								<th scope="col"><print:date date="${date}"/></th>
								</c:forEach>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList}" var="result">
							<tr>
								<td class="txt_center">${result.userNm}</td>
								<c:forEach items="${dateList}" var="date">
								<td class="txt_center">${result[date]}</td>
								</c:forEach>
							</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>
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
