<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
$(document).ready(function () {
	bindSearchData()
});

//검색데이터들을 바인딩시킨다.
function bindSearchData() {
	
	// 간단히/자세히 bind
	if ('${searchVO.searchDetail}' == 'Y') $('#btnDetail').click();
	
	// 전체 기간 bind 및 기간 event처리
	if ('${searchVO.searchRegDtS}' == '' && '${searchVO.searchRegDtE}' == '') {
		$('#searchAllPeriod').attr('checked', true);
		clickChkboxDate();
	}
}

function search(pageNo) {
	document.frm.pageIndex.value = pageNo;
	document.frm.submit();
}

function interest(obj, bcId) {
	
	var bool;
	if ($(obj).attr('value') == 'Y') bool = 'N';
	else bool = 'Y';
	
	$.ajax({
		url: "/cooperation/updateBusinessContactInterestAjax.do",
		data: {
			bcId: bcId,
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
function viewState(bcId) {
	var popup = window.open("/cooperation/selectBusinessContactRecieveList.do?bcId=" + bcId,"_POP_STATE_","width=360px,height=415px,scrollbars=yes");
	popup.focus();
}

function selectPageUnit(cnt) {
	$('input[name=pageUnit]').val(cnt);
	
	// Cookie에 페이지 조회 줄수 담기(30일 보관)
	setCookie('hanmam_business_contact_pageunit', cnt, 30);
	
	search(1);
}

//프로젝트 검색조건 초기화
function clsPrj() {
	$('#searchPrjNm').val('');
	$('#searchPrjId').val('');
}

//간단히/자세히 토글
function toggleCondition(){
	var btnDetail = $('#btnDetail');
	if (btnDetail.hasClass('btn_arrow_down')) {
		// 자세히 클릭
		btnDetail.removeClass('btn_arrow_down');
		btnDetail.addClass('btn_arrow_up');
		$('.option').show();
		var clone = btnDetail.clone();
		var span = btnDetail.closest('span');
		span.html('간단히 ');
		span.append(clone);
		$('#searchDetail').val('Y');
	} else {
		// 간단히 클릭
		btnDetail.removeClass('btn_arrow_up');
		btnDetail.addClass('btn_arrow_down');
		$('.option').hide();
		var clone = btnDetail.clone();
		var span = btnDetail.closest('span');
		span.html('자세히 ');
		span.append(clone);
		$('#searchDetail').val('N');
	}
}

function clickChkboxDate() {
	var allchk = $('#searchAllPeriod');

	$('#searchRegDtS').attr('disabled', allchk.is(':checked'));
	$('#searchRegDtE').attr('disabled', allchk.is(':checked'));
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
							<li class="stitle">업무연락</li>
							<li class="navi">홈 > 업무공유 > 협업 > 업무연락</li>
						</ul>
					</div>
	
				<!-- S: section -->
				<div class="section01">
					
					<!-- 상단 검색창 시작 -->
					<form name="frm" method="POST" action="${rootPath}/cooperation/selectBusinessContactList.do" onsubmit="search(1); return false;">
					<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
					<input type="hidden" name="interestYn"/>
					<input type="hidden" name="bcId"/>
					<input type="hidden" name="pageUnit" value="${paginationInfo.recordCountPerPage}"/>
					<input type="hidden" id="searchDetail" name="searchDetail" value="${searchVO.searchDetail}" />
					
					<fieldset>
					<legend>상단 검색</legend>
						<div class="top_search07 mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<colgroup>
							<col class="col120" />
							<col class="col270"/>
							<col class="col110" />
							<col class="col260"/>
							<col width="px" />
						</colgroup>
						<tbody>
							<tr class="pT5">
								<th>프로젝트선택</th>
								<td>
									<input type="text" name="searchPrjNm" id="searchPrjNm" value="${searchVO.searchPrjNm}" class="span_11 input01" readonly="readonly" onclick="prjGen('searchPrjNm','searchPrjId',2);"/>
									<input type="hidden" name="searchPrjId" id="searchPrjId" value="${searchVO.searchPrjId}"/>
									<img src="${imagePath}/btn/btn_tree.gif" onclick="prjGen('searchPrjNm','searchPrjId',2);" class="cursorPointer">
									<img src="${imagePath}/btn/btn_replay.gif" onclick="clsPrj();" class="cursorPointer" title="프로젝트 검색조건 초기화" style="padding-top:2px;">
								</td>
								<td></td>
								<td>
									<label><input type="checkbox" name="receiveTyp" value="WR" <c:if test="${searchVO.write}">checked="checked"</c:if> /> 작성</label>
									<span class="pL7"></span>
									<label><input type="checkbox" name="receiveTyp" value="RE" <c:if test="${searchVO.receive}">checked="checked"</c:if> /> 수신</label>
									<span class="pL7"></span>
									<label><input type="checkbox" name="receiveTyp" value="RF" <c:if test="${searchVO.reference}">checked="checked"</c:if> /> 참조</label>									
								</td>
								<td>
									<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색" class="search_btn02"/>
								</td>
							</tr>
							<tr>
								<th><span class="tooltip" onmouseover="bindTooltip(this, '4700', '250');">제목+내용</span></th>
								<td><input type="text" name="searchKeyword" id="searchKeyword" class="span_11 input01" value="${searchVO.searchKeyword}"/></td>
								<th><span class="tooltip" onmouseover="bindTooltip(this, '4704', '250');">작성자</span></th>
								<td>
									<input type="text" name="searchUserNm" id="searchUserNm" class="input01" value="${searchVO.searchUserNm}"/>
								</td>
								<td><!-- 간단히/자세히 버튼 -->
									<span>자세히 <img class="btn_arrow_down cursorPointer" id="btnDetail" onclick="toggleCondition();"/></span>
								</td>
							</tr>
							<tr class="option" style="display:none;">
								<th>덧글 내용</th>
								<td><input type="text" name="searchCmmtCn" id="searchCmmtCn" value="${searchVO.searchCmmtCn}" class="span_11 input01"/></td>
								<th>덧글 작성자</th>
								<td colspan="2"><input type="text" name="searchCmmtUserNm" id="searchCmmtUserNm" value="${searchVO.searchCmmtUserNm}" class="span_11 input01"/></td>
							</tr>
							<tr class="option" style="display:none;">
								<th>프로젝트명</th>
								<td><input type="text" name="searchOnlyPrjNm" id="searchOnlyPrjNm" value="${searchVO.searchOnlyPrjNm}" class="span_11 input01"/></td>
								<th>작성일</th>
								<td colspan="2">
									<input type="text" id="searchRegDtS" name="searchRegDtS" value="${searchVO.searchRegDtS}" class="calGen" maxlength="8" style="width:55px;"/>&nbsp;-
									<input type="text" id="searchRegDtE" name="searchRegDtE" value="${searchVO.searchRegDtE}" class="calGen" maxlength="8" style="width:55px;"/>&nbsp;
									<input type="hidden" id="ckValue" name="ckValue" value=""/>
									<label><input type="checkbox" title="전체기간" name="searchAllPeriod" id="searchAllPeriod" onclick="clickChkboxDate();" /> 전체</label>
								</td>
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
						
						<!-- 버튼 시작 -->
						<div class="btn_area">
							<a href="${rootPath}/cooperation/insertBusinessContactView.do"><img src="${imagePath}/btn/btn_regist.gif"/></a>
						</div>
						<!-- 버튼 끝 -->
					</div>
					<!-- 상단 바 끝 -->
						
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col40" />
							<col class="col90" />
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
							<th scope="col">제목</th>
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
									<td class="txt_center" title="${result.prjNm}"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}"/></td>
									<td class="pL10">
										<a href="${rootPath}/cooperation/selectBusinessContact.do?bcId=${result.bcId}&linkCmmtCn=${searchVO.searchCmmtCn}&linkCmmtUserNm=${searchVO.searchCmmtUserNm}">
											<c:choose>
												<c:when test="${result.readYn == 'N'}"><span <c:if test="${result.alarmYn != 'N'}">class="txt_red"</c:if> >${result.bcSj}</span></c:when>
												<c:when test="${result.interestYn == 'Y'}"><span class="txt_blue">${result.bcSj}</span></c:when>
												<c:otherwise><span>${result.bcSj}</span></c:otherwise>
											</c:choose>
											<span class="txt_reply">[${result.commentCnt}]</span>
										</a>
									</td>
									<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
									<td class="txt_center">${fn:substring(result.regDtShort, 2, 10)}</td>
									<td class="txt_center">${fn:substring(result.modDtShort, 2, 10)}</td>
									<td class="txt_center"><a href="javascript:viewState('${result.bcId}')">${result.readStatPrint}</a></td>
									<td class="txt_center">
										<c:choose>
											<c:when test="${result.interestYn == 'Y'}">
												<img src="${imagePath}/btn/btn_light_on.gif" class="cursorPointer" onclick="interest(this, '${result.bcId}');" value="${result.interestYn}"/>
											</c:when>
											<c:otherwise>
												<img src="${imagePath}/btn/btn_light_off.gif" class="cursorPointer" onclick="interest(this, '${result.bcId}');" value="${result.interestYn}"/>
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
						
						<!-- 버튼 시작 -->
						<div class="btn_area">
							<a href="${rootPath}/cooperation/insertBusinessContactView.do"><img src="${imagePath}/btn/btn_regist.gif"/></a>
						</div>
						<!-- 버튼 끝 -->
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
