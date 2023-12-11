<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
$(document).ready(function () {
	
});

function search(pageNo) {
	document.frm.pageIndex.value = pageNo;
	document.frm.submit();
}

function selectPageUnit(cnt) {
	$('input[name=pageUnit]').val(cnt);
	// Cookie에 페이지 조회 줄수 담기(30일 보관)
	setCookie('hanmam_sales_prj_pageunit', cnt, 30);
	search(1);
}

function viewProject(prjId){
	var popup = window.open("/cooperation/selectProjectV.do?prjId="+prjId,"_POP_PROJECT_VIEW","width=1200px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
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
							<li class="stitle">영업건 관리</li>
							<li class="navi">홈 > 업무공유 > 영업관리 > 영업건 관리</li>
						</ul>
					</div>
	
				<!-- S: section -->
				<div class="section01">
					
					<!-- 상단 검색창 시작 -->
					<form name="frm" method="POST" action="${rootPath}/cooperation/selectSalesProjectListAll.do" onsubmit="search(1); return false;">
					<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
					<input type="hidden" name="pageUnit" value="${paginationInfo.recordCountPerPage}"/>
					<input type="hidden" name="searchTypAll" value="Y"/>
					
					<fieldset>
					<legend>상단 검색</legend>
						<div class="top_search07 mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<colgroup>
							<col class="col120" />
							<col class="col260"/>
							<col class="col130" />
							<col class="col260"/>
							<col width="px" />
						</colgroup>
						<tbody>
							<tr class="pT5">
								<th>고객사</th>
								<td><input type="text" name="searchCustNm" id="searchCustNm" value="${searchVO.searchCustNm}" class="span_11 input01"/></td>
								<th><span class="tooltip" onmouseover="bindTooltip(this, '4827', '200');">프로젝트명</span></th>
								<td><input type="text" name="searchPrjNm" id="searchPrjNm" value="${searchVO.searchPrjNm}" class="span_11 input01"/></td>
							</tr>
							<tr class="pT5">
								<th><span class="tooltip" onmouseover="bindTooltip(this, '4828', '200');">관련인원</span></th>
								<td>
									<input type="text" class="search_txt05 col80p userNamesAuto userValidateCheck" 
											name="searchUserMixes" id="searchUserMixes" value="${searchVO.searchUserMixes}" />
		                    		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchUserMixes',0)"/>
								</td>
								<td></td>
								<td>
									<label class="pR5"><input type="checkbox" id="searchIncEndPrj" name="searchIncEndPrj" value="Y" 
										<c:if test="${searchVO.searchIncEndPrj=='Y'}">checked="checked"</c:if> />종료/중단 프로젝트 포함</label>
								</td>
								<td><input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색" class="search_btn02"/></td>
							</tr>
							<tr class="pT5">
								<th>부서</th>
								<td>
									<input type="text" id="searchOrgnztNm" name="searchOrgnztNm" value="${searchVO.searchOrgnztNm}" class="search_txt05 col80p" readonly="true"
											onclick="orgGen('searchOrgnztNm','searchOrgnztId',2);" />
									<input type="hidden" id="searchOrgnztId" name="searchOrgnztId" value="${searchVO.searchOrgnztId}" />
									<img src="${imagePath}/btn/btn_tree.gif" onclick="orgGen('searchOrgnztNm','searchOrgnztId',2);" class="cursorPointer" />
								</td>
								<th>프로젝트타입</th>
								<td>
									<label><input type="radio" name="searchPrjType" value="0" 
												<c:if test="${searchVO.searchPrjType=='0'}">checked="checked"</c:if> />사업/영업 &nbsp;</label>
									<label><input type="radio" name="searchPrjType" value="1" 
												<c:if test="${searchVO.searchPrjType=='1'}">checked="checked"</c:if> />영업 &nbsp;</label>
									<label><input type="radio" name="searchPrjType" value="2" 
												<c:if test="${searchVO.searchPrjType=='2'}">checked="checked"</c:if> />사업 &nbsp;</label>
								</td>
								<td></td>
							</tr>
						</tbody>
						</table>
						</div>
					</fieldset>
					</form>
					<!-- 상단 검색창 끝 -->
					
					<!-- 상단 바 시작 -->
					<div>
						<select class="select01" onchange="selectPageUnit(this.options[this.selectedIndex].value)">
							<option value="15" <c:if test="${paginationInfo.recordCountPerPage==15}">selected="selected"</c:if> >15줄</option>
							<option value="30" <c:if test="${paginationInfo.recordCountPerPage==30}">selected="selected"</c:if> >30줄</option>
							<option value="50" <c:if test="${paginationInfo.recordCountPerPage==50}">selected="selected"</c:if> >50줄</option>
						</select>
						<span class="txtB_Black mR20">총 : ${paginationInfo.totalRecordCount}건</span>
					</div>
					<!-- 상단 바 끝 -->
						
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col50" />
							<col width="px" />
							<col class="col130" />
							<col class="col100" />
							<col class="col100" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">번호</th>
							<th scope="col">프로젝트명</th>
							<th scope="col">고객사</th>
							<th scope="col">PL</th>
							<th scope="col">최근등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/></td>
									<td class="txt_left">
										<a class="cursorPointer" href="javascript:viewProject('${result.prjId}');" title="${result.prjCd}">
											${result.prjNm}
										</a>
									</td>
									<td class="txt_center"><a href="${rootPath}/cooperation/selectCustomer.do?custId=${result.custId}" target="_blank">${result.custNm}</a></td>
									<td class="txt_center"><print:user userNo="${result.leaderNo}" userNm="${result.leaderNm}"/></td>
									<td class="txt_center"><print:date date="${result.regDt}"/></td>
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
					
					<!-- 하단 바 시작 -->
					<div class="pB10">
						<select class="select01" onchange="selectPageUnit(this.options[this.selectedIndex].value)">
							<option value="15" <c:if test="${paginationInfo.recordCountPerPage==15}">selected="selected"</c:if> >15줄</option>
							<option value="30" <c:if test="${paginationInfo.recordCountPerPage==30}">selected="selected"</c:if> >30줄</option>
							<option value="50" <c:if test="${paginationInfo.recordCountPerPage==50}">selected="selected"</c:if> >50줄</option>
						</select>
						<span class="txtB_Black mR20">총 : ${paginationInfo.totalRecordCount}건</span>
					</div>
					<!-- 하단 바 끝 -->
					
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
