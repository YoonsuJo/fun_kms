<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function modify() {
	document.frm.flagVM.value = "modify";
	document.frm.action = "${rootPath}/license/licenseView.do";
	document.frm.submit();
}
function list() {
	document.frm.action = "${rootPath}/license/licenseList.do";
	document.frm.submit();
}
function historyDetail(licenseId, historyId){
	document.frm.licenseId.value = licenseId;
	document.frm.historyId.value = historyId;
	document.frm.action = "${rootPath}/license/licenseHistoryDetail.do";
	document.frm.submit();
}
function licenseIssueAgain(){
	document.frm.action = "${rootPath}/license/licenseIssueAgain.do";	
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
		<%@ include file="left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">라이선스 상세조회</li>
							<li class="navi">홈 > 업무공유 > 정보공유 > 라이선스 상세조회</li>
						</ul>
					</div>
					
					<!-- S: section -->
					<div class="section01">
						
						<!-- 게시판 시작 -->
						<form name="frm" method="POST">
							<input type="hidden" name="flagVM" value="">
							<input type="hidden" name="licenseId" value="${result.license.licenseId}">
							<input type="hidden" name="historyId" value="${result.historyId}">
							<input type="hidden" name="page" value="${searchVO.page}">
							<input type="hidden" name="searchCompanyName" value="${searchVO.searchCompanyName}"/>
							<input type="hidden" name="searchExpireDateStart" value="${searchVO.searchExpireDateStart}"/>
							<input type="hidden" name="searchExpireDateEnd" value="${searchVO.searchExpireDateEnd}"/>
							<input type="hidden" name="searchProduct" value="${searchVO.searchProduct}"/>
						<p class="th_stitle">라이선스 정보</p>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>라이선스 정보</caption>
		                    <colgroup>
			                    <col class="col180" />
			                    <col width="px" />
			                    <col class="col120" />
			                    <col width="px" />
		                    </colgroup>
		                    <tbody>
		                    	<tr>
			                    	<td class="title">제품선택</td>
			                    	<td class="pL10" colspan="3">${result.license.licenseView.product}</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">회사명</td>
			                    	<td class="pL10" colspan="3">${result.license.licenseView.companyName}</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">업체담당자</td>
			                    	<td class="pL10">${result.license.person}</td>
			                    	<td class="title">연락처</td>
			                    	<td class="pL10">${result.license.phone}</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">발급자</td>
			                    	<td class="pL10">${result.license.regUserName}</td>
			                    	<td class="title">발급일시  <fmt:formatDate value="${result.regDateTime}"  pattern="yyyyMMddhhmmss"/></td>
			                    	<td class="pL10">
			                    	<fmt:formatDate value="${result.regDateTime}" var="date1" pattern="yyyyMMddhhmmss"/>
			                    		<fmt:formatDate value="${result.regDateTime}" pattern="yyyy-MM-dd"/>
			                    	</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">설치서버 IP</td>
			                    	<td class="pL10" colspan="3">${result.license.licenseView.serverIpAddr}</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">설치서버 MAC Address</td>
			                    	<td class="pL10" colspan="3">${result.license.licenseView.serverMacAddr}</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">접속제한수</td>
			                    	<td class="pL10" colspan="3">최대 ${result.license.licenseView.maxUser} 명 / 계약 ${result.license.licenseView.maxUserLimit} 명</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">대상단말</td>
			                    	<td class="pL10" colspan="3">
			                    		<c:forEach items="${result.license.licenseView.functionList}" var="function">
			                    			<c:if test="${function == 'video'}">
			                    			영상회의 ,
			                    			</c:if>
			                    			<c:if test="${function == 'document'}">
			                    			문서공유 ,
			                    			</c:if>
			                    			<c:if test="${function == 'media'}">
			                    			미디어공유 ,
			                    			</c:if>
			                    			<c:if test="${function == 'seminar'}">
			                    			화면공유
			                    			</c:if>
			                    		</c:forEach>
			                    	
			                    	</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">제공기능</td>
			                    	<td class="pL10" colspan="3">
			                    		<c:forEach items="${result.license.licenseView.clientList}" var="client">
			                    			<c:if test="${client == 'pc'}">
			                    			PC ,
			                    			</c:if>
			                    			<c:if test="${client == 'mobile'}">
			                    			모바일 ,
			                    			</c:if>
			                    			<c:if test="${client == 'codec'}">
			                    			H/W 코덱
			                    			</c:if>
			                    		</c:forEach>
			                    	
			                    	</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">만료일</td>
			                    	<td class="pL10" colspan="3">
			                    		<c:out value="${fn:substring(result.license.licenseView.expireDate, 0, 4)}-${fn:substring(result.license.licenseView.expireDate, 4, 6)}-${fn:substring(result.license.licenseView.expireDate, 6, 8)}"/>
			                    	</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">메모</td>
			                    	<td class="pL10 pT5 pB5" colspan="3">${result.license.memo}</td>
		                    	</tr>
		                    	
		                    	<tr>
			                    	<td class="title">라이선스 키 ${result2} -----  </td>
			                    	<td class="pL10 pT5 pB5" colspan="3">${result2.licenseView.licenseKey}</td>
		                    	</tr>
		                    	
		                    </tbody>
		                    </table>
						</div>
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02 pB20">
		                	<ul>
		                		<li class="right">
		                			<a href="javascript:modify();"><img src="${imagePath}/btn/btn_modify.gif"/></a>
		                			<a href="javascript:licenseIssueAgain();" ><img src="${imagePath}/btn/btn_add.gif"/></a>
		                			<a href="javascript:list();"><img src="${imagePath}/btn/btn_list.gif"/></a>
		                		</li>
		                	</ul>
		                </div>
		                <!-- 버튼 끝 -->						
						
						<p class="th_stitle">발급이력 정보</p>
						<div class="boardList">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>발급이력</caption>
		                    <colgroup>
			                    <col class="col20" />
								<col class="col50" />
								<col class="col40" />
								<col class="col70" />
								<col class="col40" />
			                    <col class="col60" />
			                    <col class="col40" />
			                    <col class="col40" />
		                    </colgroup>
		                    <thead>
								<tr>
								<th scope="col">NO.</th>
								<th scope="col">회사명</th>
								<th scope="col">업체담당자</th>
								<th scope="col">연락처</th>
								<th scope="col">발급자</th>
								<th scope="col">접속 제한 수</th>
								<th scope="col">발급일</th>
								<th scope="col">만료일</th>
								</tr>
							</thead>
		                    <tbody>
		                    <c:forEach items="${licenseHistoryList}" var="history" varStatus="c">
		                    <fmt:formatDate value="${history.regDateTime}" var="date2" pattern="yyyyMMddhhmmss"/> 
			                    <c:if test="${date1 == date2}"><!--현재 보고 있는 라이센스 정보일 경우-->
			                    		<tr class="TrBg2">
			                    	</c:if>
			                    	<c:if test="${date1 != date2}">
			                    		<tr class="TrBg3">
			                    	</c:if>
									<td class="txt_center">${c.count}</td>
									<td class="pL10"><a href="javascript:historyDetail('${history.license.licenseId}', '${history.historyId}');">${history.license.companyName}</a></td>
									<td class="txt_center">${history.license.person}</td>
									<td class="txt_center">${history.license.phone}</td>
									<td class="txt_center">${history.license.regUserName}</td>
									<td class="txt_center">${history.license.licenseView.maxUser}/${history.license.licenseView.maxUserLimit}</td>
									<td class="txt_center"><fmt:formatDate value="${history.regDateTime}" pattern="yyyy-MM-dd"/></td>
									<td class="txt_center">
									<c:out value="${fn:substring(history.license.licenseView.expireDate, 0, 4)}-${fn:substring(history.license.licenseView.expireDate, 4, 6)}-${fn:substring(history.license.licenseView.expireDate, 6, 8)}"/>
									</td>
								</tr>
							</c:forEach>
							</tbody>
		                    </table>
						</div>
						</form>
						
				
						<!--// 게시판 끝-->
						
						
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
