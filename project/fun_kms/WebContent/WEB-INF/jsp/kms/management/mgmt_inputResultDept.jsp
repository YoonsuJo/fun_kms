<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(moveMonth) {
	document.frm.moveMonth.value = moveMonth;
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
						<li class="stitle">부서별 인력투입실적</li>
						<li class="navi">홈 > 경영정보 > 인력투입관리 > 부서별 투입실적</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
				
			    <!-- 상단 검색창 시작 -->
			    	<form name="frm" method="POST" action="${rootPath}/management/selectInputResultDept.do" onsubmit="search(0); return false;">
					<input type="hidden" name="moveMonth" value="0"/>
					<input type="hidden" name="searchDate" value="${searchVO.searchDate}"/>
					<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
					<fieldset>
					<legend>상단 검색</legend>
	                    <div class="scheduleDate mB20">
	                		<ul>
		                		<li class="li_left">
		               	 			<a href="javascript:search(-1);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
		                			<span class="option_txt">${fn:substring(searchVO.searchDate,0,4)}년 ${fn:substring(searchVO.searchDate,4,6)}월</span>
									<a href="javascript:search(1);" class="pL10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
		                		</li>
		                		<li class="li_right">
		                			<span class="option_txt">소속부서</span><span class="pL7"></span>
									<input type="text" class="search_txt02 span_13" name="searchOrgNm" id="orgNm" value="${searchVO.searchOrgNm}" readonly="readonly" onfocus="orgGen('orgNm','orgId',0);"/>
									<img src="${imagePath}/btn/btn_tree.gif" onclick="orgGen('orgNm','orgId',0);" class="cursorPointer"/>
									<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색" onclick="search(0); return false;"/>
		                		</li>
	                		</ul>
						</div>
	                </fieldset>
			    	</form>
	            <!--// 상단 검색창 끝 -->
	            
	            <!-- 게시판 시작  -->
					<div class="boardList02 mB5">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>부서별 인력투입실적</caption>
	                    <colgroup>
	                    	<col class="col140" />
	                    	<col width="px"/>
	                    	<col class="col60" />
                    		<col class="col60" />
	                    	<col class="col60" />
	                    </colgroup>
	                    <thead>
	                    	<tr>
	                    		<th>프로젝트 주관부서</th>
	                    		<th>프로젝트</th>
	                    		<th>이름</th>
	                    		<th>투입시간</th>
	                    		<th class="td_last">참여율</th>
	                    	</tr>
	                    </thead>
	                    <tbody>
	                    	<c:forEach items="${result.inputResultDeptByOrgList}" var="irdbo" varStatus="c1">
		                    	<c:forEach items="${irdbo.inputResultDeptByPrjList}" var="irdbp" varStatus="c2">
			                    	<c:forEach items="${irdbp.inputResultDeptList}" var="ird" varStatus="c3">
		                    			<tr>
					                    	<c:if test="${c3.count == 1}">
					                    		<c:if test="${c2.count == 1}">
					                    			<td class="txt_center" rowspan="${fn:length(irdbo.inputResultDeptByPrjList) + irdbo.itemCnt}">
					                    				${irdbo.orgFnm}
					                    			</td>
					                    		</c:if>
						                    	<td class="pL10 pR5" rowspan="${fn:length(irdbp.inputResultDeptList)}">
						                    		<print:project prjId="${ird.prjId}" prjCd="${ird.prjCd}" prjNm="${ird.prjNm}"/>
						                    	</td>
					                    	</c:if>
					                    	<td class="txt_center"><print:user userNo="${ird.userNo}" userNm="${ird.userNm}"/></td>
			                    			<td class="txt_center">${ird.drTm}</td>
			                    			<td class="td_last txt_center"><print:percent value="${ird.drTm / result.drTm}" roundDigits="2" printSignYn="Y"/></td>
				                    	</tr>
			                    	</c:forEach>
			                    	<tr>
				                    	<td class="txt_center bG04" colspan="2"><print:project prjId="${irdbp.prjId}" prjCd="${irdbp.prjCd}" bracket="Y"/> 소계</td>
		                    			<td class="txt_center bG04">${irdbp.drTm}</td>
		                    			<td class="td_last txt_center bG04"><print:percent value="${irdbp.drTm / result.drTm}" roundDigits="2" printSignYn="Y"/></td>
		                    		</tr>
		                    	</c:forEach>
		                    	<tr>
			                    	<td class="txt_center bG" colspan="3">${irdbo.orgFnm} 소계</td>
	                    			<td class="txt_center bG">${irdbo.drTm}</td>
	                    			<td class="td_last txt_center bG"><print:percent value="${irdbo.drTm / result.drTm}" roundDigits="2" printSignYn="Y"/></td>
		                    	</tr>   
	                    	</c:forEach>
	                    	<tr>
	                    		<td class="txt_center bG03" colspan="3">총계</td>
	                    		<td class="td_last txt_center bG03" colspan="2">총 ${result.drTm}시간</td>
	                    	</tr>
	                    </tbody>
	                    </table>
					</div>
					
					
					<!--// 게시판  끝  -->
					
	            	
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
