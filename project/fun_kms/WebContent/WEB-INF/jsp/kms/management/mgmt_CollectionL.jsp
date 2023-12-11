<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>

<script>
function collectionSearch(pageIndex) {
	document.colFrm.pageIndex.value = pageIndex;
	document.colFrm.action = '<c:url value="${rootPath}/management/collectionFullL.do" />';
	document.colFrm.submit();
}
function popCollection(bondPrjNo){
	document.colFrm.bondPrjNo.value = bondPrjNo;
	
	var POP_NAME = "_POP_COLLECTION_LIST_";
	var target = document.colFrm.target;
	document.colFrm.target = POP_NAME;
	document.colFrm.action = '<c:url value="${rootPath}/management/collectL.do" />';

	//var popup = window.showModalDialog('${rootPath}/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var popup = window.open("about:blank", POP_NAME, "width=560px,height=570px;");
	document.colFrm.submit();
	popup.focus();
	document.colFrm.target = target;
}
function thisRefresh() {
	document.colFrm.action = '<c:url value="${rootPath}/management/collectionFullL.do" />';
	document.colFrm.submit();
}
// 프로젝트 검색조건 초기화
function clsPrj() {
	$('#searchPrjNm').val('');
	$('#searchPrjId').val('');
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
							<li class="stitle">수금내역 조회</li>
							<li class="navi">홈 > 경영정보 > 채권관리 > 수금내역</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<form name="colFrm" id="colFrm" method="POST" onsubmit="collectionSearch(1); return false;">
						<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
						<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex}"/>
						<input type="hidden" name="bondPrjNo" id="bondPrjNo" value="0"/>
						
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<colgroup>
								<col width=""/>
								<col width=""/>
								<col width=""/>
								<col width=""/>
								<col width=""/>
							</colgroup>
							<tbody>
								<tr>
									<td>
										수금일 : <input type="text" class="input01 span_4 calGen" name="startDate" value="${searchVO.startDate}"/> ~ <input type="text" class="input01 span_4 calGen" name="endDate" value="${searchVO.endDate}"/><span class="T11"></span>
									</td>
									<td>
										프로젝트 : 
										<input type="text" name="searchPrjNm" id="searchPrjNm" value="${searchVO.searchPrjNm}" class="span_11 input01" readonly="readonly" onclick="prjGen('searchPrjNm','searchPrjId',1);"/>
										<input type="hidden" name="searchPrjId" id="searchPrjId" value="${searchVO.searchPrjId}"/>
										<img src="${imagePath}/btn/btn_tree.gif" onclick="prjGen('searchPrjNm','searchPrjId',1);" class="cursorPointer">
										<img src="${imagePath}/btn/btn_replay.gif" onclick="clsPrj();" class="cursorPointer" title="프로젝트 검색조건 초기화" style="padding-top:2px;">
									</td>
								</tr>
								<tr>
									<td class="search_left">
										업체명 : 
										<input type="text" name="searchCustNm" class="span_8" value="${searchVO.searchCustNm}"/>
									</td>
									<td class="search_right">
										프로젝트 주관부서 : 
										<input type="text" name="searchOrgNm" id="orgNm" class="search_txt02 span_27" value="${searchVO.searchOrgNm}" readonly="readonly" onclick="orgGen('orgNm','orgId',0);"/>
										<img id="orgTree" src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="orgGen('orgNm','orgId',0);"/>
										<input type="image" src="../../images/btn/btn_search02.gif" class="search_btn02" alt="검색" onclick="collectionSearch(1);"/>
									</td>
								</tr>
							</tbody>
							</table>
		                    </div>
		                </fieldset>
	                	<!-- 상단 검색창 끝 -->
	                	
	                	</form>
	            	
						<div class="boardList mB20">
						<!-- 상단 바 시작 -->
						<div class="pB10">
							<span class="txtB_Black">* 총합계 : <fmt:formatNumber value="${totResSum}" type="number"/>원</span>
						</div>
						<!-- 상단 바 끝 -->
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col40" />
							<col width="px" />
							<col width="px" />
							<col class="col120" />
							<col class="col70" />
							<col class="col120" />
							<col class="col70" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">부서</th>
								<th scope="col">프로젝트</th>
								<th scope="col">수금액</th>
								<th scope="col">수금일</th>
								<th scope="col">업체명</th>
								<th scope="col">발행일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
							<c:when test="${empty resultList}">
								<tr>
									<td class="txt_center" colspan="7">
										※ 수금 내역이 없습니다.
									</td>
								</tr>
							</c:when>
							<c:otherwise>
							<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + c.count) + 1}"/></td>
									<td class="txt_center">${result.orgnztNm}</td>
									<td class="txt_center"><a href="${rootPath }/cooperation/selectProjectV.do?prjId=${result.prjId }">[${result.prjCd}] ${result.prjNm}</a></td>
									<td class="txt_center"><a href="javascript:popCollection(${result.bondPrjNo});"><print:currency cost="${result.expense}" /></a></td>
									<td class="txt_center"><print:date date="${result.collectionDate}" /></td>
									<td class="txt_center"><a href="${rootPath }/support/taxPublishV.do?bondId=${result.bondId}">${result.custNm}</a></td>
									<td class="txt_center"><print:date date="${result.publishDate}" /></td>
								</tr>
							</c:forEach>
							</c:otherwise>
							</c:choose>
						</tbody>
						</table>
						</div>
					
					<!-- 하단 숫자 시작 -->
					<div class="paginate">
						<ui:pagination paginationInfo="${paginationInfo}" jsFunction="collectionSearch" type="image"/>
					</div>
					<!-- 하단 숫자 끝 -->
					
					<c:if test="${user.admin || user.taxAdmin}">
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
                		<a href="/management/collectionExcelW.do">
                			<img src="${imagePath}/btn/btn_excelSave.gif"/>
                		</a>
               	    </div>
                 	<!-- 버튼 끝 -->
					</c:if>
					
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
