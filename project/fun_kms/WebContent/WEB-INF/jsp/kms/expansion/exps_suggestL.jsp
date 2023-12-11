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
	document.frm.action = "<c:url value='${rootPath}/expansion/selectBoardList.do'/>";

	var sDt = document.frm.searchBgnDe.value;
	var eDt = document.frm.searchEndDe.value;

	if (sDt != "" && eDt != "") {
		if (sDt > eDt || sDt.length != 8 || eDt.length != 8) {
			alert("검색기간이 잘못되었습니다.");
			return;
		}
	}
	
	document.frm.submit();	
}
function exSearch(exChk) {
	document.frm.exChk.value = exChk;
	search('1');	
}

function view(nttId, bbsId, readBool) {
	document.subForm.nttId.value = nttId;
	document.subForm.bbsId.value = bbsId;
	document.subForm.readBool.value = readBool;
	document.subForm.action = "<c:url value='${rootPath}/expansion/selectBoardArticle.do'/>";
	document.subForm.submit();
}

function selectPageUnit(cnt) {
	$('input[name=pageUnit]').val(cnt);
	
	// Cookie에 페이지 조회 줄수 담기(30일 보관)
	setCookie('hanmam_board_pageunit', cnt, 30);
	
	search(1);
}
</script>
</head>

<body style="overflow-X:hidden">

<div id="wrap">
	<!-- S: container -->
	<div id="container">
		<ul class="container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="contents">
			<!-- S: centerBg -->
			<div id="center_bg">
			<!-- S: center -->
			<div id="center">
				<div class="path_navi">
					<ul>
						<li class="stitle">${bdMstr.bbsNm} </li>
						<li class="navi">홈 > 확장기능 > ${bdMstr.bbsNm}</li>
					</ul>
				</div>	
				
				<span class="stxt">${bdMstr.bbsIntrcn} </span>
				
				<!-- S: section -->
				<div class="section01">
					<form name="frm" action ="<c:url value='${rootPath}/expansion/selectBoardList.do'/>" method="post" onsubmit="exSearch(''); return false;">
					<input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>" />
					<input type="hidden" name="nttId"  value="0" />
					<input type="hidden" name="exChk"  value="<c:out value="${searchVO.exChk}"/>" />
					<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
					<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
					<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
					<input type="hidden" name="pageUnit" value="${paginationInfo.recordCountPerPage}"/>
					
				    <!-- 상단 검색창 시작 -->
					<fieldset>
					<legend>상단 검색</legend>
	                    <div class="bot_search mB10">
							<ul>
								<li class="option_txt">
									기간지정<span class="pL7"></span>
									<input type="text" name="searchBgnDe" value="<c:out value="${searchVO.searchBgnDe}"/>" class="span_4 input01 calGen"/> ~
									<input type="text" name="searchEndDe" value="<c:out value="${searchVO.searchEndDe}"/>" class="span_4 input01 calGen"/><span class="pL7"></span>
								</li>
								<li class="option_txt">
									<label>제목<span class="pL7"></span><input type="radio" name="searchCnd" value="0" <c:if test="${searchVO.searchCnd == '0'}">checked="checked"</c:if> ></label><span class="pL7"></span>
									<label>제목+내용<span class="pL7"></span><input type="radio" name="searchCnd" value="1" <c:if test="${searchVO.searchCnd == '1'}">checked="checked"</c:if> ></label><span class="pL7"></span>
									<label>작성자<span class="pL7"></span><input type="radio" name="searchCnd" value="2" <c:if test="${searchVO.searchCnd == '2'}">checked="checked"</c:if> ></label></li>
								<li class="search_box"><input type="text" name="searchWrd" class="search_txt02" value='<c:out value="${searchVO.searchWrd}"/>' /></li>
								<li class="search_btn"><input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색" style="cursor:pointer;" onclick="exSearch(''); return false;"/></li>
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
					
	            	<c:import url="${rootPath}/expansion/selectSuggestSummary.do" charEncoding="utf-8">
					</c:import>
	             
	            	<!-- 상세정보 시작  -->
					<p class="th_stitle">상세 정보</p>
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>건의/제안 상세 정보</caption>
						<colgroup>
							<col class="col40" />
							<col width="px" />
							<col class="col120" />
							<col class="col120" />
							<col class="col120" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">등록일시</th>
							<th scope="col">처리상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/></td>
									<td>
										<a href="javascript:view('<c:out value="${result.nttId}"/>','<c:out value="${result.bbsId}"/>','<c:out value="${result.readBool}"/>');">
											<c:if test="${result.replyAt == 'Y'}"><c:forEach begin="1" end="${result.replyLc}">&nbsp;&nbsp;</c:forEach><img src="${imagePath}/board/icon_re.gif" /></c:if>
											<c:choose>
												<c:when test="${result.readBool == 'Y'}"><c:out value="${result.nttSj}"/> <span class="txt_reply">[<c:out value="${result.commentCount}"/>]</span></c:when>
												<c:otherwise><span class="txt_red"><c:out value="${result.nttSj}"/></span> <span class="txt_reply">[<c:out value="${result.commentCount}"/>]</span></c:otherwise>
											</c:choose>
										</a>
									</td>
									<td class="txt_center"><print:user userNo="${result.frstRegisterId}" userNm="${result.ntcrNm}" userId="${result.ntcrId}" printId="true"/></td>
									<td class="txt_center"><c:out value="${result.frstRegisterPnttm}"/></td>
									<td class="txt_center">
										<c:choose>
											<c:when test="${result.exChk == 'E'}">작업예정</c:when>
											<c:when test="${result.exChk == 'C'}">작업중<c:if test="${!empty result.exChkTm}"><br>(<print:date date="${result.exChkTm}" printType='S'/>)</c:if></c:when>
											<c:when test="${result.exChk == 'H'}">향후작업</c:when>
											<c:when test="${result.exChk == 'R'}">기각<c:if test="${!empty result.exChkTm}"><br>(<print:date date="${result.exChkTm}" printType='S'/>)</c:if></c:when>
											<c:when test="${result.exChk == 'F'}">처리완료<c:if test="${!empty result.exChkTm}"><br>(<print:date date="${result.exChkTm}" printType='S'/>)</c:if></c:when>
											<c:otherwise>작업예정</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>
					<!-- 상세정보 끝 -->
					
					<!-- 페이징 시작 -->
					<div class="paginate">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="search" />
					</div>
					
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
					
					<!-- 페이징 끝 -->
					<form name="subForm" method="post" action="<c:url value='${rootPath}/expansion/selectBoardArticle.do'/>">
						<input type="hidden" name="bbsId" />
						<input type="hidden" name="nttId" />
						<input type="hidden" name="readBool" />
						<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
						<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
						<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>"/>
						<input type="hidden" name="searchWrd" value="<c:out value='${searchVO.searchWrd}'/>"/>
					</form>
					
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
                		<a href="${rootPath}/expansion/addBoardArticle.do?bbsId=${boardVO.bbsId}"><img src="${imagePath}/btn/btn_regist.gif"/></a>
               	    </div>
                 	<!-- 버튼 끝 -->
				</div>
				<!-- E: section -->
			</div>
			<!-- E: center -->				
			</div>	
			<!-- E: centerBg -->
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
</div>
</body>
</html>
