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
function radioSel(n) {
	document.frm.searchCondition[n].checked = true;

	var userNm = document.getElementById("userNm");
	var orgId = document.getElementById("orgId");
	var orgNm = document.getElementById("orgNm");
	var prjId = document.getElementById("prjId");
	var prjNm = document.getElementById("prjNm");
	var tree = document.getElementById("tree");
	
	if (n == 0) {
		userNm.value = "${searchVO.searchUserNm}";
		orgId.value = "";
		orgNm.value = "";
		prjId.value = "";
		prjNm.value = "";

		userNm.style.display = "";
		orgNm.style.display = "none";
		prjNm.style.display = "none";

		tree.onclick = new Function("usrGen('userNm',1)");
	}
	else if (n == 1) {
		userNm.value = "";
		orgId.value = "${searchVO.searchOrgId}";
		orgNm.value = "${searchVO.searchOrgNm}";
		prjId.value = "";
		prjNm.value = "";

		userNm.style.display = "none";
		orgNm.style.display = "";
		prjNm.style.display = "none";

		tree.onclick = new Function("orgGen('orgNm','orgId',0)");
	}
	else if (n == 2) {
		userNm.value = "";
		orgId.value = "";
		orgNm.value = "";
		prjId.value = "${searchVO.searchPrjId}";
		prjNm.value = "${searchVO.searchPrjNm}";

		userNm.style.display = "none";
		orgNm.style.display = "none";
		prjNm.style.display = "";

		tree.onclick = new Function("prjGen('prjNm','prjId',1)");
	}
	
	if (n == 2) {
		document.getElementById("prjChk").style.display = "";
	}
	else {
		document.getElementById("prjChk").style.display = "none";
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
							<li class="stitle">업무진행내역</li>
							<li class="navi">홈 > 업무공유 > 업무계획/실적 > 업무진행내역</li>
						</ul>
					</div>
	
				<!-- S: section -->
				<div class="section01">
				
					<form name="frm" method="POST" onsubmit="search(1); return false;" action="${rootPath}/cooperation/selectProcessList.do">
					<input type="hidden" name="pageIndex" value="1"/>
					<input type="hidden" name="searchKeyword" value="0"/>
					<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
					<input type="hidden" name="searchPrjId" id="prjId" value="${searchVO.searchPrjId}"/>
			    	<!-- 상단 검색창 시작 -->
					<fieldset>
					<legend>상단 검색</legend>
	                    <div class="bot_search mB10">
							<ul>
								<li class="option_txt">
									<label><input type="radio" name="searchCondition" value="0" onclick="radioSel(0);" /> 사용자</label><span class="pL7"></span>
									<label><input type="radio" name="searchCondition" value="1" onclick="radioSel(1);" /> 부서</label><span class="pL7"></span>
									<label><input type="radio" name="searchCondition" value="2" onclick="radioSel(2);" /> 프로젝트</label>
								</li>
								
								<li class="search_box">
									<input type="text" name="searchUserNm" id="userNm" class="userNameAuto search_txt02" value="${searchVO.searchUserNm}"/>
									<input type="text" name="searchOrgNm" id="orgNm" class="search_txt02" value="${searchVO.searchOrgNm}" readonly="readonly" onfocus="orgGen('orgNm','orgId',0);"/>
									<input type="text" name="searchPrjNm" id="prjNm" class="search_txt02" value="${searchVO.searchPrjNm}" readonly="readonly" onfocus="prjGen('prjNm','prjId',1);"/>
									<img src="${imagePath}/btn/btn_tree.gif" id="tree" onclick="usrGen('userNm',1);" class="cursorPointer"/>
								</li>
								<li id="prjChk">
									<label><input type="checkbox" name="includeUnderProject" id="prjChk" value="Y" <c:if test="${searchVO.includeUnderProject == 'Y'}">checked="checked"</c:if>> 하위프로젝트 포함</label>
								</li>
								<li class="search_btn"><input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색" onclick="search(1); return false;"/></li>
                        	</ul>
	                    </div>
	                </fieldset>
	            	<!-- 상단 검색창 끝 -->
					</form>
					<script>radioSel("${searchVO.searchCondition}");</script>
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col40" />
							<col class="col70" />
							<col class="col50" />
							<col class="col50" />
							<col class="col150" />
							<col class="col150" />
							<col width="px" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">번호</th>
							<th scope="col">날짜</th>
							<th scope="col">시간</th>
							<th scope="col">이름</th>
							<th scope="col">프로젝트</th>
							<th scope="col">작업명</th>
							<th scope="col">내용</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/></td>
									<td class="txt_center">${result.dayReportDtPrint}</td>
									<td class="txt_center">${result.dayReportTm}시간</td>
									<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
									<td class="txt_center"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}"/></td>
									<td class="txt_center"><a href="${rootPath}/cooperation/selectTaskInfo.do?taskId=${result.taskId}">${result.taskSj}</a></td>
									<td class="pL10">${result.dayReportCnPrint}</td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>
					
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
