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
							<li class="stitle">사내매출 상세내역</li>
							<li class="navi">홈 > 경영정보 > 매출관리 > 사내매출내역</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<p class="th_plus02">단위 : 천원</p>
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup>
		                    	<col class="col100" />
		                    	<col width="px" />
		                    	<col class="col60" />
		                    	<col class="col80" />
		                    	<col class="col80" />
		                    	<col class="col80" />
		                    	<col class="col80" />
		                    	<col class="col50" />
	                    	</colgroup>
		                    <thead>
		                    	<tr>
		                    		<th>결재문서 종류</th>
		                    		<th>결재문서 제목</th>
		                    		<th>상신자</th>
		                    		<th>상신일</th>
		                    		<th>매입 프로젝트</th>
		                    		<th>매출 프로젝트</th>
		                    		<th>금액</th>
		                    		<th class="td_last">수정</th>
		                    	</tr>
		                    </thead>
		                    <tbody>
		                    	<c:forEach items="${resultList}" var="result">
		                    	<tr>
			                    	<td class="txt_center">${result.templtNm}</td>
			                    	<td class="pL10">
			                    		<a href="${rootPath}/approval/approvalV.do?docId=${result.docId}" target="_blank">
			                    			${result.subject}
			                    		</a>
			                    	</td>
			                    	<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
			                    	<td class="txt_center"><print:date date="${result.docDt}"/> </td>
			                    	<td class="txt_center"><print:project prjCd="${result.salesPrjCd}" prjId="${result.salesPrjId}" length="16"/></td>
			                    	<td class="txt_center"><print:project prjCd="${result.purchasePrjCd}" prjId="${result.purchasePrjId}" length="16"/></td>
			                    	<td class="txt_center">${result.costPrint}</td>
			                    	<td class="td_last txt_center">
		                    			<a href="${rootPath}/approval/approvalRW.do?docId=${result.docId}" target="_blank">
		                    				<img src="${imagePath}/btn/btn_plus02.gif"/>
		                    			</a>
			                    	</td>
		                    	</tr>
		                    	</c:forEach>
		                    </tbody>
		                    </table>
						</div>
						<!--// 게시판 끝  -->
						
	           		    <div class="btn_area">
	           		    	<form method="POST" action="${rootPath}/management/innerSalesList.do">
							<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
							<input type="hidden" name="searchMonth" value="${searchVO.searchMonth}"/>
							<input type="hidden" name="searchOrgIdSales" value="${searchVO.searchOrgIdSales}"/>
							<input type="hidden" name="searchOrgNmSales" value="${searchVO.searchOrgNmSales}"/>
							<input type="hidden" name="searchPrjIdSales" value="${searchVO.searchPrjIdSales}"/>
							<input type="hidden" name="searchPrjNmSales" value="${searchVO.searchPrjNmSales}"/>
							<input type="hidden" name="searchOrgIdPurchase" value="${searchVO.searchOrgIdPurchase}"/>
							<input type="hidden" name="searchOrgNmPurchase" value="${searchVO.searchOrgNmPurchase}"/>
							<input type="hidden" name="searchPrjIdPurchase" value="${searchVO.searchPrjIdPurchase}"/>
							<input type="hidden" name="searchPrjNmPurchase" value="${searchVO.searchPrjNmPurchase}"/>
							<input type="hidden" name="searchConditionSales" value="${searchVO.searchConditionSales}"/>
							<input type="hidden" name="searchConditionPurchase" value="${searchVO.searchConditionPurchase}"/>
	                		<input type="image" src="${imagePath}/btn/btn_list.gif"/>
	           		    	</form>
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
