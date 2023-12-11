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
function albumSearch(pageIndex) {
	document.frm.pageIndex.value = pageIndex;
	document.frm.submit();
}
function memberSearch() {
	document.frm.mode.value = "list";
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
						앨범 형식으로 임직원을 조회하실 수 있습니다.
					</span>
					<span class="stxt_btn">
						<a href="javascript:memberSearch();"><img src="${imagePath}/btn/btn_list_type.gif"/></a>
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
						<p class="th_stitle">사원조회 (검색된 사용자 : ${paginationInfo.totalRecordCount}명)</p>
						<div class="boardList">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>사원조회</caption>
							<colgroup>
								<col width="90px" />
								<col width="50px" />
								<col width="px" />
								<col width="40px" />
								<col width="px" />
								
								<col width="90px" />
								<col width="50px" />
								<col width="px" />
								<col width="40px" />
								<col width="px" />
							</colgroup>
							<tbody>
								<c:forEach var="c" begin="1" end="${fn:length(resultList)}" step="2">
									<tr height="50px">
										<td rowspan="3">
											<c:choose>
												<c:when test="${empty resultList[c - 1].picFileId || resultList[c - 1].picFileId == ''}">
		                   							<img src="${imagePath}/inc/img_no_photo.gif" alt="소개사진 없음" width="80" height="100" />
		                   						</c:when>
		                   						<c:otherwise>
		                   							<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
														<c:param name="param_atchFileId" value="${resultList[c - 1].picFileId}" />
														<c:param name="param_width" value="80" />
														<c:param name="param_height" value="100" />
													</c:import>
		                   						</c:otherwise>
											</c:choose>
										</td>
										<td class="txt_center" colspan="4"><a href="javascript:view('<c:out value="${resultList[c - 1].no}"/>');">${resultList[c - 1].sabun} ${resultList[c - 1].orgnztNm} <strong>${resultList[c - 1].userNm}</strong> ${resultList[c - 1].rankNm} (${resultList[c - 1].workStPrint})</a></td>
										
										<c:choose>
										<c:when test="${not empty resultList[c]}">
											<td rowspan="3">
												<c:choose>
													<c:when test="${empty resultList[c].picFileId || resultList[c].picFileId == ''}">
			                   							<img src="${imagePath}/inc/img_no_photo.gif" alt="소개사진 없음" width="80" height="100" />
			                   						</c:when>
			                   						<c:otherwise>
			                   							<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
															<c:param name="param_atchFileId" value="${resultList[c].picFileId}" />
															<c:param name="param_width" value="80" />
															<c:param name="param_height" value="100" />
														</c:import>
			                   						</c:otherwise>
												</c:choose>
											</td>
											<td class="txt_center" colspan="4"><a href="javascript:view('<c:out value="${resultList[c].no}"/>');">${resultList[c].sabun} ${resultList[c].orgnztNm} <strong>${resultList[c].userNm}</strong> ${resultList[c].rankNm} (${resultList[c].workStPrint})</a></td>
										</c:when>
										<c:otherwise>
											<td rowspan="3" class="noLine">
												 
											</td>
											<td colspan="4" class="noLine">
												 
											</td>
										</c:otherwise>
										</c:choose>
									</tr>
									<tr>
										<td class="txt_center title">휴대폰</td>
										<td class="txt_center"><a href="javascript:view('<c:out value="${resultList[c - 1].no}"/>');">${resultList[c - 1].moblphonNo}</a></td>
										<td class="txt_center title">내선</td>
										<td class="txt_center"><a href="javascript:view('<c:out value="${resultList[c - 1].no}"/>');">${resultList[c - 1].offmTelnoInner}</a></td>
										
										<c:choose>
										<c:when test="${not empty resultList[c]}">
											<td class="txt_center title">휴대폰</td>
											<td class="txt_center"><a href="javascript:view('<c:out value="${resultList[c].no}"/>');">${resultList[c].moblphonNo}</a></td>
											<td class="txt_center title">내선</td>
											<td class="txt_center"><a href="javascript:view('<c:out value="${resultList[c].no}"/>');">${resultList[c].offmTelnoInner}</a></td>
										</c:when>
										<c:otherwise>
											<td colspan="4" class="noLine">
												 
											</td>
										</c:otherwise>
										</c:choose>
									</tr>
									<tr>
										<td class="txt_center title">입사일</td>
										<td class="txt_center"><a href="javascript:view('<c:out value="${resultList[c - 1].no}"/>');">${resultList[c - 1].compinDtPrint}</a></td>
										<td class="txt_center title">생일</td>
										<td class="txt_center"><a href="javascript:view('<c:out value="${resultList[c - 1].no}"/>');">${resultList[c - 1].brthMainPrintShort}</a></td>
										
										<c:choose>
										<c:when test="${not empty resultList[c]}">
											<td class="txt_center title">입사일</td>
											<td class="txt_center"><a href="javascript:view('<c:out value="${resultList[c].no}"/>');">${resultList[c].compinDtPrint}</a></td>
											<td class="txt_center title">생일</td>
											<td class="txt_center"><a href="javascript:view('<c:out value="${resultList[c].no}"/>');">${resultList[c].brthMainPrintShort}</a></td>
										</c:when>
										<c:otherwise>
											<td colspan="4" class="noLine">
												 
											</td>
										</c:otherwise>
										</c:choose>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						<!-- 게시판 끝  -->
						
						<div class="paginate">
							<ui:pagination paginationInfo="${paginationInfo}" jsFunction="albumSearch" type="image"/>
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
