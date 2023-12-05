<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search() {
	document.frm.submit();
}
$(document).ready(function() {
	var tmp = "${searchVO.searchStatListPrint}".split(",");

	for (var i=0; i<tmp.length; i++) {
		if (tmp[i] == "P") {
			document.frm.searchStatList[0].checked = true;
		}
		else if (tmp[i] == "E") {
			document.frm.searchStatList[1].checked = true;
		}
		else if (tmp[i] == "S") {
			document.frm.searchStatList[2].checked = true;
		}
	}
});
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
							<li class="stitle">부서 게시판 목록</li>
							<li class="navi">업무공유 > 부서 게시판 목록</li>
						</ul>
					</div>
	
				<!-- S: section -->
				<div class="section01">
			    	<form name="frm" method="POST" onsubmit="search(); return false;" action="${rootPath}/cooperation/selectOrgBoardMain.do">
					<input type="hidden" name="searchOrgId" id="searchWrd" value="${searchVO.searchOrgId}"/>
			    <!-- 상단 검색창 시작 -->
					<fieldset>
					<legend>상단 검색</legend>
						<div class="top_search07 mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<tbody>
							<tr>
								<td>
									진행상태 : 
									<label><input type="checkbox" name="searchStatList" value="P" /> 진행</label>
									<label><input type="checkbox" name="searchStatList" value="E" /> 완료</label>
									<label><input type="checkbox" name="searchStatList" value="S" /> 중단</label>
								</td>
								<td class="search_right">
									주관부서<span class="pL7"></span>
									<input type="text" name="searchOrgNm" id="searchOrgNm" class="search_txt02" value="${searchVO.searchOrgNm}" readonly="readonly" onclick="orgGen('searchOrgNm','searchWrd',0);"/>
									<img src="${imagePath}/btn/btn_tree.gif" onclick="orgGen('searchOrgNm','searchWrd',0);" class="cursorPointer"/>
									<img src="${imagePath}/btn/btn_search02.gif" alt="검색" onclick="search(); return false;" style="cursor:pointer"/>
								</td>
							</tr>
						</tbody>
						</table>
	                    </div>
	                	</fieldset>
	                </form>
                <!-- 상단 검색창 끝 -->
                	
                	<!-- 게시판 시작 -->
					<p class="th_stitle">내가 소속된 부서</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup>
							<col width="px"/>
							<col class="col120" />
							<col class="col50" />
							<col class="col70" />
							<col class="col70" />
						</colgroup>
						<thead>
							<tr>
								<th>부서명</th>
								<th>부서장</th>
								<th>상태</th>
								<th>미열람</th>
								<th class="td_last">총 게시물</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${result.myOrgList}" var="org">
								<tr>
									<td class="txt_center">
										<a href="${rootPath}/cooperation/selectOrgBoardList.do?orgnztId=${org.orgnztId}&searchOrgNm=${org.orgnztNm}">
									${org.orgnztNm}
									</a>
								</td>
								<td class="txt_center">부서장</td>
								<td class="txt_center">
									<c:choose>
										<c:when test="${org.stat == 'P'}">진행</c:when>
										<c:when test="${org.stat == 'S'}">중지</c:when>
										<c:when test="${org.stat == 'E'}">종료</c:when>
									</c:choose>
								</td>
								<td class="txt_center">
									<a href="${rootPath}/cooperation/selectOrgBoardList.do?orgnztId=${org.orgnztId}&searchOrgNm=${org.orgnztNm}">
										<span class="txt_red">${org.unreadCnt}</span>
									</a>
								</td>
								<td class="td last txt_center">
									<a href="${rootPath}/cooperation/selectOrgBoardList.do?orgnztId=${org.orgnztId}&searchOrgNm=${org.orgnztNm}">
										${org.allCnt}
									</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>
					
					<p class="th_stitle">전체 부서</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup>
							<col width="px"/>
							<col class="col120" />
							<col class="col50" />
							<col class="col70" />
							<col class="col70" />
						</colgroup>
						<thead>
							<tr>
								<th>부서명</th>
								<th>부서장</th>
								<th>상태</th>
								<th>미열람</th>
								<th class="td_last">총 게시물</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${result.allOrgList}" var="org">
								<tr>
									<td class="txt_center">
										<a href="${rootPath}/cooperation/selectOrgBoardList.do?orgnztId=${org.orgnztId}&searchOrgNm=${org.orgnztNm}">
									${org.orgnztNm}
									</a>
								</td>
								<td class="txt_center">부서장</td>
								<td class="txt_center">
									<c:choose>
										<c:when test="${org.stat == 'P'}">진행</c:when>
										<c:when test="${org.stat == 'S'}">중지</c:when>
										<c:when test="${org.stat == 'E'}">종료</c:when>
									</c:choose>
								</td>
								<td class="txt_center">
									<a href="${rootPath}/cooperation/selectOrgBoardList.do?orgnztId=${org.orgnztId}&searchOrgNm=${org.orgnztNm}">
										<span class="txt_red">${org.unreadCnt}</span>
									</a>
								</td>
								<td class="td last txt_center">
									<a href="${rootPath}/cooperation/selectOrgBoardList.do?orgnztId=${org.orgnztId}&searchOrgNm=${org.orgnztNm}">
										${org.allCnt}
									</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>
					<!-- 게시판 끝 -->
					
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
