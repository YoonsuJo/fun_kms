<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>

<script>
function contractSearch(pageIndex) {
	document.contractFrm.pageIndex.value = pageIndex;
	document.contractFrm.action = '<c:url value="${rootPath}/management/contractL.do" />';
	document.contractFrm.submit();
}
function viewContract(contractNo) {
	document.contractFrm.contractNo.value = contractNo;
	document.contractFrm.action = '<c:url value="${rootPath}/management/contractV.do" />';
	document.contractFrm.submit();
}
function writeContract() {
	document.contractFrm.action = '<c:url value="${rootPath}/management/contractW.do" />';
	document.contractFrm.submit();
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
							<li class="stitle">수주 계약건 관리</li>
							<li class="navi">홈 > 경영정보 > 계약건관리 > <a href="/management/contractL.do?searchTyp=O">수주계약</a></li>
						</ul>
					</div>
					
					<span class="stxt">각 계약건에 관한 요약 정보는 누구나 열람 가능하며, 상세정보는 권한에 따라 열람이 불가능할 수도 있습니다.<br/>
					상세정보 열람이 필요한 경우 관리자에게 문의하시기 바랍니다.
					</span>
	
					<!-- S: section -->
					<div class="section01">
					
						<form:form commandName="contractFrm" id="contractFrm" name="contractFrm" method="post" enctype="multipart/form-data" onsubmit="contractSearch(1); return false;">
					
						<input type="hidden" name="contractNo" value="" />
						<input type="hidden" name="searchTyp" value="W" />
						<input type="hidden" name="pageIndex" value="${searchVO.pageIndex }" />
						
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
						
	                    <div class="top_search04 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<tbody>
								<tr>
									<td class="pT5">
			               	 			계약명 <input type="text"  name="searchSj" class="input01 span_6" value="${searchVO.searchSj }" /><span class="pL10"></span>
			               	 			계약내용 <input type="text"  name="searchCn" class="input01 span_10" value="${searchVO.searchCn }"/><span class="pL10"></span>
			               	 			발주처 <input type="text"  name="searchNm" class="input01 span_6" value="${searchVO.searchNm }"/>
									</td>
									<td width="80" rowspan="2" class="search_right"><a href="javascript:contractSearch(1);"><input type="image" src="../../images/btn/btn_search02.gif" class="search_btn02" alt="검색"/></a></td>
								</tr>
								<tr>
									<td colspan="2" class="pT5">
										부서 <input type="text"  name="searchOrgnztNm" class="input01 span_10" id="orgnztNm" value="${searchVO.searchOrgnztNm }" /><input type="hidden" name="orgnztId" id="orgnztId" >
	                    				<img src="${imagePath}/btn/btn_tree.gif" id="orgnztTreeB" class="cursorPointer" onclick="orgGen('orgnztNm','orgnztId',1);"/><span class="pL10"></span>
										프로젝트 <input type="text"  name="searchPrjNm" class="input01 span_29" id="searchPrjNm" value="${searchVO.searchPrjNm }" /><input type="hidden" name="prjId" id="searchPrjId" >
										<img src="${imagePath}/btn/btn_tree.gif" onclick="prjGen('searchPrjNm','searchPrjId',1);" class="cursorPointer">
									</td>
								</tr>
							</tbody>
							</table>
		                    </div>
		                </fieldset>
		            	<!--// 상단 검색창 끝 -->
	            	
						<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col40" />
							<col class="col90" />
							<col width="px" />
							<col class="col100" />
							<col class="col60" />
							<col class="col120" />
							<col class="col60" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">부서</th>
								<th scope="col">계약명</th>
								<th scope="col">발주처</th>
								<th scope="col">계약일</th>
								<th scope="col">계약기간</th>
								<th scope="col">실적신고</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
							<c:when test="${empty resultList}">
								<tr>
									<td class="txt_center" colspan="7">
										※ 계약건이 없습니다.
									</td>
								</tr>
							</c:when>
							<c:otherwise>
							<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center">
									<a href="javascript:viewContract(${result.contractNo});">
									<c:out value="${(paginationInfo.totalRecordCount) - ((paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + c.count) + 1}"/>
									</a></td>
									<td class="txt_center">${result.orgnztNm}</td>
									<td class="pL10"><a href="javascript:viewContract(${result.contractNo});">${result.sj}</a></td>
									<td class="txt_center">${result.nm}</td>
									<td class="txt_center">
										<c:choose>
										<c:when test="${result.contractDate != ''}">
											<print:date date='${result.contractDate}' printType='S' />
										</c:when>
										<c:otherwise>
											&nbsp;
										</c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center">
										<c:choose>
										<c:when test="${result.contractStartDate != '' && result.contractEndDate != ''}">
											<print:date date='${result.contractStartDate}' printType='S' /> ~ <print:date date='${result.contractEndDate}' printType='S' />
										</c:when>
										<c:otherwise>
											&nbsp;
										</c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center">
										<c:choose>
										<c:when test="${result.resultRegister == 'Y'}">
											신고
										</c:when>
										<c:otherwise>
											미신고
										</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
							</c:otherwise>
							</c:choose>
						</tbody>
						</table>
						</div>
						
						</form:form>
					
					<!-- 하단 숫자 시작 -->
					<div class="paginate">
						<ui:pagination paginationInfo="${paginationInfo}" jsFunction="contractSearch" type="image"/>
					</div>
					<!-- 하단 숫자 끝 -->
					
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
                		<a href="javascript:writeContract();"><img src="../images/btn/btn_regist.gif"/></a>
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
