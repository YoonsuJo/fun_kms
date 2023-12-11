<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(yearMove) {
	document.frm.searchYear.value = new Number("${searchVO.searchYear}") + yearMove;
	document.frm.submit();
}
function detail(orgNm, orgId) {
	document.frm.searchOrgNm.value = orgNm;
	document.frm.searchOrgId.value = orgId;
	document.frm.action = "${rootPath}/member/diningMoneyStatisticView.do";
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
						<li class="stitle">팀장경비 사용 현황</li>
						<li class="navi">홈 > 인사정보 > 복리후생 > 팀장경비 사용내역</li>
					</ul>
				</div>
				
				<span class="stxt">부서별 팀장경비 사용 내역을 년도별로 조회할 수 있습니다.</span>
				<span class="stxt_btn"><a href="${rootPath}/approval/approvalW.do?templtId=12"><img src="${imagePath}/btn/btn_grpEatRegist.gif"/></a></span>
				<!-- S: section -->
				<div class="section01">
				
			   		<!-- 상단 검색창 시작 -->
			   		<form name="frm" method="POST" action="${rootPath}/member/diningMoneyStatisticList.do" onsubmit="search(0); return false;">
			   		<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
			   		<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
					<fieldset>
					<legend>상단 검색</legend>
	                    <div class="scheduleDate mB20">
	                		<ul>
	                		<li class="li_left">
	               	 			<a href="javascript:search(-1);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
	                			<span class="option_txt">${searchVO.searchYear}년</span>
								<a href="javascript:search(1);" class="pL10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
	                		</li>
	                		<li class="li_right">
	                			부서
	                			<input type="text" name="searchOrgNm" id="orgNm" class="search_txt02" value="${searchVO.searchOrgNm}" readonly="readonly" onfocus="orgGen('orgNm','orgId',0);"/>
								<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="orgGen('orgNm','orgId',0);"/>
								<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색"/>
	                		</li>
	                		</ul>
						</div>
	                </fieldset>
			   		</form>
	            	<!--// 상단 검색창 끝 -->
	            	
	            	<p class="th_stitle">팀장경비 사용 현황</p>
	            	<span class="stxt">기본배정예산 : 현재까지 매월 부서 인원수에 따라 배정된 금액의 한계입니다.<br/>
	            	추가배정예산 : 워크샵 등의 목적으로 추가 배정된 예산입니다.<br/>
	            	연말예상잔액 : 연말까지 부서원 수에 변동이 없을 경우를 가정할 떄 매월 주기적으로 배정될 예산을 고려한 금액입니다.</span>
		            <!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>공지사항 보기</caption>
	                    <colgroup>
	                    	<col width="px" />
	                    	<col class="col100" />
	                    	<col class="col100" />
	                    	<col class="col100" />
	                    	<col class="col100" />
	                    	<col class="col100" />
	                   	</colgroup>
	                    <thead>
	                    	<tr>
	                    		<th>부서</th>
	                    		<th>기본배정예산</th>
	                    		<th>추가배정예산</th>
	                    		<th>사용금액</th>
	                    		<th>현재잔액</th>
	                    		<th class="td_last">연말 예상잔액</th>
	                    	</tr>
	                    </thead>
	                    <tbody>
	                    	<c:forEach items="${resultList}" var="result">
		                    	<tr>
			                    	<td class="txt_center">${result.orgnztNm}</td>
			                    	<td class="txt_center"><a href="javascript:detail('${result.orgnztNm}','${result.orgnztId}');">${result.dineMoneyPrint}</a></td>
			                    	<td class="txt_center"><a href="javascript:detail('${result.orgnztNm}','${result.orgnztId}');">${result.dineMoneyAddPrint}</a></td>
			                    	<td class="txt_center"><a href="javascript:detail('${result.orgnztNm}','${result.orgnztId}');">${result.dineMoneyUsePrint}</a></td>
			                    	<td class="txt_center"><a href="javascript:detail('${result.orgnztNm}','${result.orgnztId}');">${result.dineMoneyLeftPrint}</a></td>
			                    	<td class="td_last txt_center"><a href="javascript:detail('${result.orgnztNm}','${result.orgnztId}');">${result.dineMoneyExpectLeftPrint}</a></td>
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
