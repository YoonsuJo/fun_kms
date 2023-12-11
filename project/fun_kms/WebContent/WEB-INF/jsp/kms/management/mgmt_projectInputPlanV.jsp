<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript">
function search(moveMonth) {
	document.frm.moveMonth.value = moveMonth;
	document.frm.submit();
}
function management() {
	document.frm.action = "${rootPath}/management/prjInputPlanMgmt.do";
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
							<li class="stitle">프로젝트 투입계획 보기</li>
							<li class="navi">홈 > 경영정보 > 프로젝트 투입계획 보기</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<!-- 상단 검색창 시작 -->
						<form name="frm" method="POST" action="${rootPath}/management/prjInputPlanView.do" onsubmit="search(0); return false;">
						<input type="hidden" name="no" value="0"/>
						<input type="hidden" name="moveMonth" value="0"/>
						<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
						<input type="hidden" name="searchMonth" value="${searchVO.searchMonth}"/>
						<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
						<input type="hidden" name="searchPrjId" id="prjId" value="${searchVO.searchPrjId}"/>
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<tbody>
								<tr>
									<td>
			               	 			<a href="javascript:search(-1);"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
			                			<span class="option_txt">${searchVO.searchYear}년 ${searchVO.searchMonth}월</span>
										<a href="javascript:search(1);" class="pR10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
									</td>
								</tr>
								<tr>
									<td class="search_right">
										프로젝트 <input type="text" name="searchPrjNm" id="prjNm" value="${searchVO.searchPrjNm}" class="input01 span_29" readonly="readonly" onfocus="prjGen('prjNm','prjId',1);"/>
										<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen('prjNm','prjId',1);"/>
										부서 <input type="text" name="searchOrgNm" id="orgNm" value="${searchVO.searchOrgNm}" class="input01 span_29" readonly="readonly" onfocus="orgGen('orgNm','orgId',1);"/>
										<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="orgGen('orgNm','orgId',1);"/>
										<input type="image" src="${imagePath}/btn/btn_search02.gif" class="search_btn02" alt="검색"/>
									</td>
								</tr>
							</tbody>
							</table>
		                    </div>
		                </fieldset>
						</form>
	                	<!-- 상단 검색창 끝 -->
						
						<!-- 게시판 시작  -->
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup>
		                    	<col class="col50" />
		                    	<c:forEach begin="1" end="${lastDate}">
		                    	<col width="px" />
		                    	</c:forEach>
		                    	<col class="col50" />
		                    	
	                    	</colgroup>
		                    <thead>
		                    	<tr>
		                    		<th>이름</th>
			                    	<c:forEach begin="1" end="${lastDate}" var="date">
		                    		<th>${date}</th>
			                    	</c:forEach>
		                    		<th class="td_last">평균</th>
		                    	</tr>
		                    </thead>
		                    <tbody>
		                    	<c:forEach items="${resultList}" var="result">
		                    	<tr>
		                    		<c:choose>
		                    		<c:when test="${result.orgnztRow == 'Y'}">
			                    		<td class="td_last txt_center" colspan="${lastDate + 2}">${result.orgnztNm }</td>
		                    		</c:when>
		                    		<c:otherwise>
			                    		<td class="txt_center">${result.userNm}</td>
				                    	<c:forEach items="${result.inputPercentList}" var="inputPercent">
					                    <td class="txt_center
					                    <c:choose>
					                    	<c:when test="${inputPercent > 100}"> Bg_blue txtS_blue</c:when>
					                    	<c:when test="${inputPercent == 100}"> Bg_green txtS_green</c:when>
					                    	<c:when test="${inputPercent < 50}"> Bg_red txtS_red</c:when>
					                    	<c:otherwise> Bg_yellow txtS_yellow</c:otherwise>
					                    </c:choose>
					                    "><print:percent value="${inputPercent / 100 / 10}"/></td>
				                    	</c:forEach>
				                    	<td class="td_last txt_center">${result.average}%</td>
		                    		</c:otherwise>
		                    		</c:choose>
		                    	</tr>
		                    	</c:forEach>
		                    </tbody>
		                    </table>
						</div>
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
	           		    <div class="btn_area">
                			<a href="javascript:management();"><img src="${imagePath}/btn/btn_management.gif"/></a>
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
