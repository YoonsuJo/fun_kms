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
function selRadio(n) {
	document.frm.searchCondition[n].checked = true;
	
	var searchKeyword = document.getElementById("searchKeyword");
	var searchUserNm = document.getElementById("searchUserNm");
	var usrTree = document.getElementById("usrTree");

	if (n == "0") {
		searchKeyword.style.display = "";
		searchUserNm.style.display = "none";
		usrTree.style.display = "none";
	}
	else if (n == "1") {
		searchKeyword.style.display = "";
		searchUserNm.style.display = "none";
		usrTree.style.display = "none";
	}
	else if (n == "2") {
		searchKeyword.style.display = "none";
		searchUserNm.style.display = "";
		usrTree.style.display = "";
	}
}
function interest(obj, mtId) {
	
	var bool;
	if ($(obj).attr('value') == 'Y') bool = 'N';
	else bool = 'Y';
	
	$.ajax({
		url: "/cooperation/updateMeetingRoomInterestAjax.do",
		data: {
			mtId: mtId,
			interestYn: bool
		},
		type: "POST",
		async: false,
		//dataType: "json",
		success: function(data) {
			if (data.indexOf("success") > -1) {
				//alert("저장에 성공했습니다");
				if (bool=='Y') {
					$(obj).attr('src', '${imagePath}/btn/btn_light_on.gif');
					$(obj).closest('tr').find('a>span:first').addClass('txt_blue');
				} else {
					$(obj).attr('src', '${imagePath}/btn/btn_light_off.gif');
					$(obj).closest('tr').find('a>span:first').removeClass('txt_blue');
				}
				$(obj).attr('value', bool);
			}
			else 
				alert("저장에 실패했습니다. 형식을 확인해주세요.");
		},
		error: function(xhr, testStatus, errorThrown) {
			alert("저장에 실패했습니다. 형식을 확인해주세요.");
			return false;
		}
	});
}

function viewState(mtId) {
	var popup = window.open("/cooperation/selectMeetingRoomRecieveList.do?mtId=" + mtId,"_POP_STATE_","width=360px,height=415px,scrollbars=yes");
	popup.focus();
}

function selectPageUnit(cnt) {
	$('input[name=pageUnit]').val(cnt);
	
	// Cookie에 페이지 조회 줄수 담기(30일 보관)
	setCookie('hanmam_meeting_room_pageunit', cnt, 30);
	
	search(1);
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
							<li class="stitle">펀네트 회의실</li>
							<li class="navi">홈 > 업무공유 > 협업 > 펀네트 회의실</li>
						</ul>
					</div>
	
				<!-- S: section -->
				<div class="section01">
					
					<!-- 상단 검색창 시작 -->
					<form name="frm" method="POST" action="${rootPath}/cooperation/selectMeetingRoomList.do" onsubmit="search(1); return false;">
					<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
					<input type="hidden" name="interestYn"/>
					<input type="hidden" name="mtId"/>
					<input type="hidden" name="pageUnit" value="${paginationInfo.recordCountPerPage}"/>
					<fieldset>
					<legend>상단 검색</legend>
						<div class="top_search07 mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<tbody>
							<tr>
								<td class="pT5">
									프로젝트 선택
									<input type="text" name="searchPrjNm" id="searchPrjNm" value="${searchVO.searchPrjNm}" class="span_11 input01" readonly="readonly" onclick="prjGen('searchPrjNm','searchPrjId',1);"/>
									<input type="hidden" name="searchPrjId" id="searchPrjId" value="${searchVO.searchPrjId}"/>
									<img src="${imagePath}/btn/btn_tree.gif" onclick="prjGen('searchPrjNm','searchPrjId',1);" class="cursorPointer">
									<span class="pL7"></span> 
									<label><input type="checkbox" name="includeUnderProject" value="Y" <c:if test="${searchVO.includeUnderProject == 'Y'}">checked="checked"</c:if>> 하위프로젝트 포함</label>
								</td>
							</tr>
							<tr>
								<td class="search_right">
									<label><input type="radio" name="searchCondition" value="0" onclick="selRadio(0);" /> 회의명</label><span class="pL7"></span>
									<label><input type="radio" name="searchCondition" value="1" onclick="selRadio(1);" /> 회의명+내용</label><span class="pL7"></span>
									<label><input type="radio" name="searchCondition" value="2" onclick="selRadio(2);" /> 작성자</label>
									<input type="text" name="searchKeyword" id="searchKeyword" class="search_txt02" value="${searchVO.searchKeyword}"/>
									<input type="text" name="searchUserNm" id="searchUserNm" class="search_txt02 userNameAuto" value="${searchVO.searchUserNm}"/>
									<img id="usrTree" src="${imagePath}/btn/btn_tree.gif" onclick="usrGen('searchUserNm',1);" class="cursorPointer">
									<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색" class="search_btn02"/>
								</td>
							</tr>
						</tbody>
						</table>
						</div>
					</fieldset>
					</form>
					<script>selRadio("${searchVO.searchCondition}");</script>
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
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,회의명,작성자,등록일,첨부,조회를 볼수 있고 회의명 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col40" />
							<col class="col90" />
							<col class="col40" />
							<col width="px" />
							<col class="col50" />
							<col class="col70" />
							<col class="col70" />
							<col class="col40" />
							<col class="col40" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">번호</th>
							<th scope="col">프로젝트코드</th>
							<th scope="col">장소</th>
							<th scope="col">회의명</th>
							<th scope="col">작성자</th>
							<th scope="col">작성일</th>
							<th scope="col">변경일시</th>
							<th scope="col">열람</th>
							<th scope="col">관심</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/></td>
									<td class="txt_center"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}"/></td>
									<td class="txt_center">
										<c:forEach items="${mtPlaceTypList}" var="typ">
											<c:if test="${result.mtPlaceTyp==typ.code}">
												<span title="${result.mtPlace}">${typ.codeNm}</span>
											</c:if>
										</c:forEach>
									</td>
									<td class="pL10">
										<a href="${rootPath}/cooperation/selectMeetingRoom.do?mtId=${result.mtId}">
											<c:choose>
												<c:when test="${result.readYn == 'N'}"><span class="txt_red">${result.mtSj}</span></c:when>
												<c:when test="${result.interestYn == 'Y'}"><span class="txt_blue">${result.mtSj}</span></c:when>
												<c:otherwise><span>${result.mtSj}</span></c:otherwise>
											</c:choose>
											<span class="txt_reply">[${result.commentCnt}]</span>
										</a>
									</td>
									<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
									<td class="txt_center">${fn:substring(result.regDt, 2, 10)}</td>
									<td class="txt_center">${fn:substring(result.modDt, 2, 10)}</td>
									<td class="txt_center"><a href="javascript:viewState('${result.mtId}')">${result.readStatPrint}</a></td>
									<td class="txt_center">
										<c:choose>
											<c:when test="${result.interestYn == 'Y'}">
												<img src="${imagePath}/btn/btn_light_on.gif" class="cursorPointer" onclick="interest(this, '${result.mtId}');" value="${result.interestYn}"/>
											</c:when>
											<c:otherwise>
												<img src="${imagePath}/btn/btn_light_off.gif" class="cursorPointer" onclick="interest(this, '${result.mtId}');" value="${result.interestYn}"/>
											</c:otherwise>
										</c:choose>
									</td>
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

					<!-- 버튼 시작 -->
					<div class="btn_area">
						<a href="${rootPath}/cooperation/insertMeetingRoomView.do"><img src="${imagePath}/btn/btn_regist.gif"/></a>
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
