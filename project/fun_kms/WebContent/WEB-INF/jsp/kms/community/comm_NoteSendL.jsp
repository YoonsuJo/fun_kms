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
	document.frm.action = "<c:url value='${rootPath}/community/selectSendNoteList.do'/>";
	document.frm.submit();	
}

function view(noteId,recieverNo) {
	var popName = "sendNoteView";
	var popup = window.open("about:blank", popName, 'top=0px, left=0px, width=500px, height=415px, ,scrollbars=yes');
	document.subForm.noteId.value = noteId;
	document.subForm.recieverNo.value = recieverNo;
	document.subForm.action = "<c:url value='${rootPath}/community/selectNote.do'/>";
	document.subForm.target = popName;
	document.subForm.submit();
	popup.focus();
}

function deleteNote() {
	if (confirm('<spring:message code="common.delete.msg" />')) {
		var chk = document.getElementsByName("chk");
		var noteId = "";
		
		for(var i=0; i<chk.length; i++) {
			if (chk[i].checked) {
				if (noteId != "") {
					noteId += ",";
				}
				noteId += chk[i].value;
			}
		}
		if (noteId == "") {
			alert("삭제할 쪽지를 선택해주세요.");
			return;
		}
		document.subForm.noteId.value = noteId;
		document.subForm.action = "<c:url value='${rootPath}/community/deleteSendNoteList.do'/>";
		document.subForm.submit();
	}
}

function allChkChng(obj) {
	var chk = document.getElementsByName("chk");
	if (obj.checked) {
		for(var i=0; i<chk.length; i++) {
			chk[i].checked=true;
		}
	}
	else {
		for(var i=0; i<chk.length; i++) {
			chk[i].checked=false;
		}
	}
}

//[2014.6.25/김동우]검색 조건에 따라, 초성검색 지원여부 조절
function clickSearchCondition() {
	var condition = $('.bot_search input[name=searchCondition]:checked').val();
	var searchKeyword = $('.bot_search input[name=searchKeyword]');
	if (condition == 1) {
		searchKeyword.addClass('userNameAutoHead');
		$('#usrTree').show();
	}
	else {
		searchKeyword.removeClass('userNameAutoHead');
		removeAutoComplete(searchKeyword);
		$('#usrTree').hide();
	}
}

//자르기(usrGen 으로 데이터 가져왔을때, 사용자명만 잘라내기)
function cutUsrGenName() {
	var searchKeyword = $('.bot_search input[name=searchKeyword]');
	var val = searchKeyword.val();
	val = val.substring(0, val.indexOf('('));
	searchKeyword.val(val);
}

$(document).ready(function() {
	clickSearchCondition();
});

function selectPageUnit(cnt) {
	$('input[name=pageUnit]').val(cnt);
	
	// Cookie에 페이지 조회 줄수 담기(30일 보관)
	setCookie('hanmam_note_pageunit', cnt, 30);
	
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
			<div id="center" style="padding-bottom:80px">
				<div class="path_navi">
					<ul>
						<li class="stitle">보낸쪽지함</li>
						<li class="navi">홈 > 커뮤니티 > 쪽지  > <a href="${rootPath}/community/selectRecieveNoteList.do"><b>보낸쪽지</b></a></li>
					</ul>
				</div>				
				
				<!-- S: section -->
				<div class="section01">
					<form name="frm" action ="<c:url value='${rootPath}/community/selectSendNoteList.do'/>" onsubmit="search(1);" method="post">
					<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				
				    <!-- 상단 검색창 시작 -->
					<fieldset>
					<legend>상단 검색</legend>
	                    <div class="bot_search mB10">
							<ul>
								<li class="option_txt">
									<label><input type="radio" name="searchCondition" value="0" onclick="javascript:clickSearchCondition();" <c:if test="${searchVO.searchCondition == 0}">checked="checked"</c:if> /><span class="pL7"></span>내용</label><span class="pL7"></span>
									<label><input type="radio" name="searchCondition" value="1" onclick="javascript:clickSearchCondition();" <c:if test="${searchVO.searchCondition == 1}">checked="checked"</c:if> /><span class="pL7"></span>받는사람(이름)</label>
								</li>
								<li class="search_box">
									<input type="text" name="searchKeyword" id="searchKeyword" value="<c:out value='${searchVO.searchKeyword}' />" class="search_txt02"/>
									<img id="usrTree" src="${imagePath}/btn/btn_tree.gif" onclick="usrGen('searchKeyword',1,cutUsrGenName);" class="cursorPointer">
								</li>
								<li><img src="${imagePath}/btn/btn_search02.gif" alt="검색" style="cursor:pointer;" onclick="search('1'); return false;"/></li>
								<li><a href="${rootPath}/community/selectRecieveNoteList.do"><img src="${imagePath}/btn/btn_noteReceiveL.gif"/></a></li>
                        	</ul>
	                    </div>
	                </fieldset>
	            	<!-- 상단 검색창 끝 -->
					</form>
					
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
						<table cellpadding="0" cellspacing="0" summary="보낸쪽지함 목록입니다.">
						<caption>보낸쪽지</caption>
						<colgroup>
							<col class="col40" />
							<col class="col40" />
							<col width="px" />
							<col class="col120" />
							<col class="col120" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col"><input type="checkbox" onclick="allChkChng(this);" /></th>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">받는사람</th>
							<th scope="col">확인시간</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center"><input name="chk" type="checkbox" value='<c:out value="${result.noteId}"/>' /></td>
									<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/></td>
									<td>
										<c:choose>
											<c:when test="${empty result.readDt || result.readDt == ''}">
												<a href="javascript:view('<c:out value="${result.noteId}"/>','<c:out value="${result.recieverNo}"/>');"><span class="txt_red"><c:out value="${result.noteCnShort}" escapeXml="false"/></span></a>
											</c:when>
											<c:otherwise>
												<a href="javascript:view('<c:out value="${result.noteId}"/>','<c:out value="${result.recieverNo}"/>');"><c:out value="${result.noteCnShort}" escapeXml="false"/></a>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center"><print:user userNo="${result.recieverNo}" userNm="${result.recieverNm}" userId="${result.recieverId}" printId="true"/></td>
									<td class="txt_center">
										<c:choose>
											<c:when test="${empty result.readDt || result.readDt == ''}">읽지않음</c:when>
											<c:otherwise><c:out value="${result.readDt}"/></c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>
					
					<!-- 페이징 시작 -->
					<div class="paginate">
	                		<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="search" />
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
					
					<form name="subForm" method="post" action="<c:url value='${rootPath}/community/selectNote.do'/>">
						<input type="hidden" name="noteId" />
						<input type="hidden" name="recieverNo" />
					</form>
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
           		    	<a href="#" onclick="window.open('${rootPath}/community/sendNoteView.do', '_POP_NOTE_WRITE_', 'top=0px, left=0px, width=500px, height=415px, scrollbars=yes')"><img src="${imagePath}/btn/btn_regist.gif"/></a>
                		<a href="javascript:deleteNote();"><img src="${imagePath}/btn/btn_delete.gif"/></a>
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
