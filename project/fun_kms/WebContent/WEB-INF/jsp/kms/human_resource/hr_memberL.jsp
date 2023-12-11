<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search() {
	var chk = document.frm.workSt;

	if ((chk[0].checked || chk[1].checked) == false) {
		alert("재직자 혹은 퇴직자를 선택해주세요.");
		return;
	}
	
	document.frm.submit();
}
function searchAll() {
	document.frm.workSt[0].checked = true;
	document.frm.workSt[1].checked = false;
	selRadio(0);
	document.frm.rankId.value = "";
	document.frm.submit();
}
function view(no) {
	document.frm.no.value = no;
	document.frm.action = "<c:url value='${rootPath}/member/selectMember.do'/>";
	document.frm.submit();
}
function selRadio(n) {
	document.frm.searchCondition[n].checked = true;
	if (n == 0) {
		document.frm.rankId.style.display = "";
	}
	else if (n == 1) {
		document.frm.rankId.style.display = "none";
		document.getElementById("usrNm").style.display = "";
		document.getElementById("orgNm").style.display = "none";
		document.getElementById("orgTree").style.display = "none";
	}
	else if (n == 2) {
		document.frm.rankId.style.display = "none";
		document.getElementById("usrNm").style.display = "none";
		document.getElementById("orgNm").style.display = "";
		document.getElementById("orgTree").style.display = "";
	}
}
function albumSearch() {
	document.frm.mode.value = "album";
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
							<li class="stitle">사원조회</li>
							<li class="navi">홈 > 인사정보 > 사원정보 > 사원조회</li>
						</ul>
					</div>	
					
					<span class="stxt">
						목록 형식으로 임직원을 조회하실 수 있습니다.
					</span>
					<span class="stxt_btn">
						<a href="javascript:albumSearch();"><img src="${imagePath}/btn/btn_album_type.gif"/></a>
					</span>
					
					<!-- S: section -->
					<div class="section01">
	
						<!-- 상단 검색창 시작 -->
						<form name="frm" method="POST" action="${rootPath}/member/selectMemberList.do" onsubmit="search(); return false;">
						<input type="hidden" name="mode" value="${searchVO.mode}"/>
						<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
						<input type="hidden" name="no" value="0"/>
						<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
								<table cellpadding="0" cellspacing="0" >
								<caption>상단 검색</caption>
								<tbody>
									<tr>
										<td>
											검색범위 :
											<input type="checkbox" name="workSt" value="W,L" <c:if test="${searchVO.working}">checked="checked"</c:if> /> 재직자
											<span class="pL7"></span>
											<c:if test="${user.admin == 'true'}">
											<input type="checkbox" name="workSt" value="R" <c:if test="${searchVO.retired}">checked="checked"</c:if> /> 퇴직자											
											</c:if>
										</td>
										<td class="search_right" >
											투입 프로젝트
											<input type="text" name="searchPrjNm" id="searchPrjNm" value="${searchVO.searchPrjNm}" class="span_11 input01" 
											readonly="readonly" onclick="prjGen('searchPrjNm','searchPrjId',1);"/>
											<input type="hidden" name="searchPrjId" id="searchPrjId" value="${searchVO.searchPrjId}"/>
											<img src="${imagePath}/btn/btn_tree.gif" onclick="prjGen('searchPrjNm','searchPrjId',1);" class="cursorPointer">
										</td>
									</tr>
									<tr>
										<td class="search_right" colspan="2">																						
											<label><input type="radio" name="searchCondition" value="0" onclick="selRadio(0);" <c:if test="${searchVO.searchCondition == 0}">checked="checked"</c:if>>직급</label>
											<select name="rankId" class="span_3">
												<option value="">선택</option>
												<c:forEach items="${rankList}" var="rank">
													<option value="${rank.code}" <c:if test="${rank.code == searchVO.rankId}">selected="selected"</c:if> ><c:out value="${rank.codeNm}"/></option>
												</c:forEach>
											</select><span class="pL7"></span>
											<label><input type="radio" name="searchCondition" value="1" onclick="selRadio(1);" <c:if test="${searchVO.searchCondition == 1}">checked="checked"</c:if>>사용자</label><span class="pL7"></span>
											<label><input type="radio" name="searchCondition" value="2" onclick="selRadio(2);" <c:if test="${searchVO.searchCondition == 2}">checked="checked"</c:if>>부서</label>
											<input type="text" name="searchUserNm" id="usrNm" class="search_txt02 userNameAuto" value="${searchVO.searchUserNm}" />
											<input type="text" name="searchOrgNm" id="orgNm" class="search_txt02" value="${searchVO.searchOrgNm}" onfocus="orgGen('orgNm','orgId',0);" readonly="readonly" style="display:none"/>
											<img src="${imagePath}/btn/btn_tree.gif" id="orgTree" class="cursorPointer" onclick="orgGen('orgNm','orgId',0);" style="display:none"/>
											<input type="image" src="${imagePath}/admin/btn/btn_search02.gif" />
											<a href="javascript:searchAll();"><img src="${imagePath}/admin/btn/btn_allview.gif" alt="전체보기"/></a>
										</td>
									</tr>
								</tbody>
								</table>
		                    </div>
		                </fieldset>
		                </form>
						<script>selRadio("${searchVO.searchCondition}");</script>
		                <!-- 상단 검색창 끝 -->
		                
		                
						<!-- 게시판 시작 -->
						<p class="th_stitle">사원조회 (검색된 사용자 : ${fn:length(resultList)}명)</p>
						<div class="boardList">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>사원조회</caption>
							<colgroup>
								<col class="col40" />
								<col class="col50" />
								<col class="col70" />
								<col class="col40" />
								<col width="px" />
								<col class="col100" />
								<col class="col40" />
								<col class="col70" />
								<col class="col80" />
								<col class="col40" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">사번</th>
								<th scope="col">이름</th>
								<th scope="col">ID</th>
								<th scope="col">직급</th>
								<th scope="col">소속부서</th>
								<th scope="col">휴대전화</th>
								<th scope="col">내선</th>
								<th scope="col">입사일</th>
								<th scope="col">생일</th>
								<th scope="col">상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList}" var="result">
									<tr>
										<td class="txt_center"><a href="javascript:view('<c:out value="${result.no}"/>');">${result.sabun}</a></td>
										<td class="txt_center"><a href="javascript:view('<c:out value="${result.no}"/>');">${result.userNm}</a></td>
										<td class="txt_center"><a href="javascript:view('<c:out value="${result.no}"/>');">${result.userId}</a></td>
										<td class="txt_center"><a href="javascript:view('<c:out value="${result.no}"/>');">${result.rankNm}</a></td>
										<td class="txt_center"><a href="javascript:view('<c:out value="${result.no}"/>');">${result.orgnztNmFullLong}</a></td>
										<td class="txt_center"><a href="javascript:view('<c:out value="${result.no}"/>');">${result.moblphonNo}</a></td>
										<td class="txt_center"><a href="javascript:view('<c:out value="${result.no}"/>');">${result.offmTelnoInner}</a></td>
										<td class="txt_center"><a href="javascript:view('<c:out value="${result.no}"/>');">${result.compinDtPrint}</a></td>
										<td class="txt_center"><a href="javascript:view('<c:out value="${result.no}"/>');">${result.brthMainPrintShort}</a></td>
										<td class="txt_center"><a href="javascript:view('<c:out value="${result.no}"/>');">${result.workStPrint}</a></td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						<!-- 게시판 끝  -->
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
