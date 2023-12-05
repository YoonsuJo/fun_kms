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
	document.frm.action = "<c:url value='${rootPath}/community/selectRecieveMailList.do'/>";
	document.frm.submit();	
}

function view(mailId) {
	document.subForm.mailId.value = mailId;
	document.subForm.action = "<c:url value='${rootPath}/community/selectMail.do'/>";
	document.subForm.submit();
}

function deleteMail() {
	if (confirm('<spring:message code="common.delete.msg" />')) {
		var chk = document.getElementsByName("chk");
		var mailId = "";
		
		for(var i=0; i<chk.length; i++) {
			if (chk[i].checked) {
				if (mailId != "") {
					mailId += ",";
				}
				mailId += chk[i].value;
			}
		}
		if (mailId == "") {
			alert("삭제할 편지를 선택해주세요.");
			return;
		}
		document.subForm.mailId.value = mailId;
		document.subForm.action = "<c:url value='${rootPath}/community/deleteRecieveMailList.do'/>";
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
		$('#usrTree').hide();
		removeAutoComplete(searchKeyword);
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
	setCookie('hanmam_mail_pageunit', cnt, 30);
	
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
						<li class="stitle">받은편지함</li>
						<li class="navi">홈 > 커뮤니티 > 사내메일 > <a href="${rootPath}/community/selectSendMailList.do"><b>받은편지</b></a></li>
					</ul>
				</div>				
				
				<!-- S: section -->
				<div class="section01">
										
				    <!-- 상단 검색창 시작 -->
					<form name="frm" action ="<c:url value='${rootPath}/community/selectRecieveMailList.do'/>" method="post" onsubmit="search(1); return false;">
					<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
					<input type="hidden" name="pageUnit" value="${paginationInfo.recordCountPerPage}"/>
					<fieldset>
					<legend>상단 검색</legend>
	                    <div class="bot_search mB10">
							<ul>
								<li class="option_txt">
									<label><input type="radio" name="searchCondition" value="0" onclick="javascript:clickSearchCondition();" <c:if test="${searchVO.searchCondition == 0}">checked="checked"</c:if> /> 제목</label><span class="pL7"></span>
									<label><input type="radio" name="searchCondition" value="1" onclick="javascript:clickSearchCondition();" <c:if test="${searchVO.searchCondition == 1}">checked="checked"</c:if> /> 보낸사람(이름)</label>
								</li>
								<li class="search_box">
									<input type="text" name="searchKeyword" id="searchKeyword" class="search_txt02" value="${searchVO.searchKeyword}"/>
									<img id="usrTree" src="${imagePath}/btn/btn_tree.gif" onclick="usrGen('searchKeyword',1,cutUsrGenName);" class="cursorPointer">
								</li>
								<li><img src="${imagePath}/btn/btn_search02.gif" alt="검색" class="cursorPointer" onclick="search(1);"/></li>
								<li><a href="${rootPath}/community/selectSendMailList.do"><img src="${imagePath}/btn/btn_mailSendL.gif"/></a></li>
                        	</ul>
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
						<table cellpadding="0" cellspacing="0" summary="받은편지함 목록입니다.">
						<caption>받은편지</caption>
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
							<th scope="col">보낸사람</th>
							<th scope="col">송신일시</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center"><input name="chk" type="checkbox" value='<c:out value="${result.mailId}"/>' /></td>
									<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/></td>
									<td>
										<c:choose>
											<c:when test="${empty result.readDt || result.readDt == ''}">
												<a href="javascript:view('<c:out value="${result.mailId}"/>');"><span class="txt_red"><c:out value="${result.mailSj}"/></span></a>
											</c:when>
											<c:otherwise>
												<a href="javascript:view('<c:out value="${result.mailId}"/>');"><c:out value="${result.mailSj}"/></a>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="txt_center"><print:user userNo="${result.senderNo}" userNm="${result.senderNm}" userId="${result.senderId}" printId="true"/></td>
									<td class="txt_center"><c:out value="${result.sendDt}"/></td>
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
					
					<form name="subForm" method="post" action="<c:url value='${rootPath}/community/selectMail.do'/>">
						<input type="hidden" name="mailId" />
						<input name="readChk" type="hidden" value="Y"/>
					</form>
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
                		<a href="${rootPath}/community/sendMailView.do"><img src="${imagePath}/btn/btn_regist.gif"/></a>
                		<a href="javascript:deleteMail();"><img src="${imagePath}/btn/btn_delete.gif"/></a>
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
