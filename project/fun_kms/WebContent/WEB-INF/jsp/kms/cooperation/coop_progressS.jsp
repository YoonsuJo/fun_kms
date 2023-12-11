<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(pageNo) {
	document.frm.pageIndex.value = pageNo;
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
							<li class="stitle">업무진행내역 검색</li>
							<li class="navi">홈 > 업무공유 > 업무계획/실적 > 업무진행내역 검색</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<form name="frm" method="POST" onsubmit="search(1); return false;" action="${rootPaht}/cooperation/searchProcessList.do">
						<input type="hidden" name="pageIndex" value="1"/>
					<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>공지사항</caption>
							<colgroup>
								<col class="col60" />
								<col class="col300" />
								<col width="px"/>
								<col class="col140" />
							</colgroup>
							<tbody>
								<tr><td>검색어</td>
									<td colspan="3"><input type="text" name="searchText" class="span_29 search_txt02" value="${searchVO.searchText}"/></td>
								</tr>
								<tr>
									<td>기간</td>
									<td>
										<input type="text" class="span_5 search_txt02 calGen" name="searchSdate" maxlength="8" value="${searchVO.searchSdate}"/> ~
										<input type="text" class="span_5 search_txt02 calGen" name="searchEdate" maxlength="8" value="${searchVO.searchEdate}"/>
									</td>
									<td>
										담당자
										<input type="text" name="searchUserNm" id="searchUserNm" class="search_txt02 userNameAuto" value="${searchVO.searchUserNm}"/>
										<img src="${imagePath}/btn/btn_tree.gif" onclick="usrGen('searchUserNm',1);" class="cursorPointer"/>
									</td>
									<td class="search_right"><input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색"/></td>
								</tr>
								<tr>
									<td>프로젝트</td>
									<td>
										<input type="text" name=searchPrjNm id="prjNm" value="${searchVO.searchPrjNm}" class="span_29 search_txt02" readonly="readonly" onclick="prjGen('prjNm','prjId',1);" />
										<input type="hidden" name="searchPrjId" id="prjId" class="span_29 search_txt02" value="${searchVO.searchPrjId}"/>
										<img src="${imagePath}/btn/btn_tree.gif" onclick="prjGen('prjNm','prjId',1);" class="cursorPointer"/>
									</td>
									<td colspan="2">
										<label><input type="checkbox" name="includeUnderProject" value="Y" 
										<c:if test="${searchVO.includeUnderProject == 'Y'}">checked="checked"</c:if>/> 하위프로젝트</label>
									</td>
								</tr>
							</tbody>
							</table>
		                    </div>
		                </fieldset>
                	<!-- 상단 검색창 끝 -->
						</form>
                	
                	<!-- 게시판 시작  -->
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>공지사항</caption>
							<colgroup>
								<col class="col70" />
								<col class="col40" />
								<col class="col90" />
								<col class="col180" />
								<col class="col50" />
								<col width="px" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">날짜</th>
								<th scope="col">시간</th>
								<th scope="col">프로젝트코드</th>
								<th scope="col">작업명</th>
								<th scope="col">담당자</th>
								<th scope="col">내용</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center">${result.dayReportDtPrint}</td>
									<td class="txt_center">${result.dayReportTm}</td>
									<td class="txt_center">
										<print:project prjCd="${result.prjCd}" prjId="${result.prjId}"/>
									</td>
									<td class="txt_center">
										<a href="${rootPath}/cooperation/selectTaskInfo.do?taskId=${result.taskId}">
										${result.taskSjPrint}</a>
									</td>
									<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
									<td class="pL10">${result.dayReportCnPrint}</td>
								</tr>
							</c:forEach>
							</tbody>
							</table>
						</div>
						
						<!--// 게시판  끝  -->
						
						<!-- 페이징 시작 -->
						<div class="paginate">
							<ui:pagination paginationInfo="${paginationInfo}" jsFunction="search" type="image"/>
						</div>
						<!-- 페이징 끝 -->
						
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
