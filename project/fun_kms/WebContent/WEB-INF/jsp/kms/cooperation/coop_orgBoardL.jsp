<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(pageNo) {
	document.frm.pageIndex.value = pageNo;
	document.frm.submit();
}
function view(nttId, readBool) {
	document.subForm.nttId.value = nttId;
	document.subForm.readBool.value = readBool;
	document.subForm.submit();
}
function write() {
	document.frm.action = "${rootPath}/cooperation/insertOrgBoardView.do";
	document.frm.submit();
}
function selRadio(n) {
	document.frm.searchCondition[n].checked = true;
	
	var searchKeyword = document.getElementById("searchKeyword");
	var userNm = document.getElementById("userNm");
	var usrTree = document.getElementById("usrTree");

	if (n == "1") {
		searchKeyword.type = "text";
		userNm.type = "hidden";
		usrTree.style.display = "none";
	}
	else if (n == "2") {
		searchKeyword.type = "text";
		userNm.type = "hidden";
		usrTree.style.display = "none";
	}
	else if (n == "3") {
		searchKeyword.type = "hidden";
		userNm.type = "text";
		usrTree.style.display = "";
	}
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
							<li class="stitle">부서 게시판</li>
							<li class="navi">홈 > 업무공유 > 협업 > 부서 게시판</li>
						</ul>
					</div>
					
				<!-- S: section -->
				<div class="section01">
					<p class="th_stitle mT10 mB10">${searchVO.searchOrgNm}</p>

			    	<form name="frm" id="frm" method="POST" action="${rootPath}/cooperation/selectOrgBoardList.do" onsubmit="search(1); return false;">
					<input type="hidden" name="nttId" value="0" />
					<input type="hidden" name="bbsId" value="${boardVO.bbsId}" />
					<input type="hidden" name="orgnztId" value="${searchVO.orgnztId}" />
					<input type="hidden" name="searchOrgNm" value="${searchVO.searchOrgNm}" />
					<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
					<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
					<input type="hidden" name="pageIndex" value="1"/>
					<!-- 상단 검색창 시작 -->
					<fieldset>
					<legend>상단 검색</legend>
						<div class="top_search07 mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<tbody>
							<tr>
								<td>
									<label><input type="checkbox" name="includeUnderOrg" value="Y" <c:if test="${searchVO.includeUnderPrj == 'Y'}">checked="checked"</c:if>> 하위부서 포함</label><span class="pL30"></span>
								</td>
								<td class="search_right">
									<input type="radio" name="searchCondition" value="0" style="display:none;"/>
									<label><input type="radio" name="searchCondition" value="1" onclick="selRadio(1);" /> 제목</label><span class="pL7"></span>
									<label><input type="radio" name="searchCondition" value="2" onclick="selRadio(2);" /> 제목+내용</label><span class="pL7"></span>
									<label><input type="radio" name="searchCondition" value="3" onclick="selRadio(3);" /> 작성자</label><span class="pL7"></span>
									<input type="text" name="searchKeyword" id="searchKeyword" class="search_txt02"/>
									<input type="text" name="searchUserNm" id="userNm" class="search_txt02"/>
									<img src="${imagePath}/btn/btn_tree.gif" id="usrTree" onclick="usrGen('searchKeyword', 1);" class="cursorPointer"/>
									<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색" class="search_btn02 cursorPointer" onclick="search(1); return false;"/>
								</td>
							</tr>
						</tbody>
						</table>
	                    </div>
	                </fieldset>
                	<!-- 상단 검색창 끝 -->
					</form>
					<script type="text/javascript">selRadio("${searchVO.searchCondition}");</script>
					
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col40" />
							<col width="px" />
							<col class="col120" />
							<col class="col110" />
							<col class="col50" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">등록일시</th>
							<th scope="col">조회수</th>
							</tr>
						</thead>
						<tbody>
								<c:forEach items="${resultList}" var="result" varStatus="c">
									<tr>
										<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/></td>
										<td class="pL5">
											<a href="javascript:view('<c:out value="${result.nttId}"/>','<c:out value="${result.readBool}"/>');">
												<c:choose>
													<c:when test="${result.readBool == 'Y'}"><c:out value="${result.nttSj}"/> <span class="txt_reply">[<c:out value="${result.commentCount}"/>]</span></c:when>
													<c:otherwise><span class="txt_red"><c:out value="${result.nttSj}"/></span> <span class="txt_reply">[<c:out value="${result.commentCount}"/>]</span></c:otherwise>
												</c:choose>
											</a>
										</td>
										<td class="txt_center"><print:user userNo="${result.frstRegisterId}" userNm="${result.ntcrNm}" userId="${result.ntcrId}" printId="true"/></td>
										<td class="txt_center"><c:out value="${result.frstRegisterPnttm}"/></td>
										<td class="txt_center"><c:out value="${result.inqireCo}"/></td>
									</tr>
								</c:forEach>
								<c:if test="${empty resultList}">
									<tr>
										<td class="txt_center" colspan="5">등록된 글이 없습니다.</td>
									</tr>
								</c:if>
						</tbody>
						</table>
					</div>
					
					<!-- 페이징 시작 -->
					<div class="paginate">
	                	<ui:pagination paginationInfo="${paginationInfo}" jsFunction="search" type="image"/>
					</div>
					<!-- 페이징 끝 -->
					
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
                		<a href="javascript:write();"><img src="${imagePath}/btn/btn_regist.gif"/></a>
               	    </div>
                 	<!-- 버튼 끝 -->
				</div>
				<!-- E: section -->
	
				<form name="subForm" method="post" action="${rootPath}/cooperation/selectOrgBoard.do">
					<input type="hidden" name="nttId" />
					<input type="hidden" name="bbsId" value="${boardVO.bbsId}" />
					<input type="hidden" name="readBool" />
					<input type="hidden" name="orgnztId" value="${searchVO.orgnztId}"/>
					<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
					<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
					<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
					<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
					<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
					<input type="hidden" name="searchOrgNm" value="<c:out value='${searchVO.searchOrgNm}'/>"/>
					<input type="hidden" name="searchUserNm" value="<c:out value='${searchVO.searchUserNm}'/>"/>
				</form>
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
