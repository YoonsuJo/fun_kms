<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<c:import url="${rootPath}/community/selectCommentList.do" charEncoding="utf-8">
	<c:param name="type" value="head" />
</c:import>
<script>
function moveArticle() {
	return;
}
function modifyArticle() {
	document.frm.action = "<c:url value='${rootPath}/community/forUpdateBoardArticle.do'/>";
	document.frm.submit();		
}
function deleteArticle() {
	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.action = "<c:url value='${rootPath}/community/deleteBoardArticle.do'/>";
		document.frm.submit();
	}	
}
function answerArticle() {
	document.frm.action = "<c:url value='${rootPath}/community/addReplyBoardArticle.do'/>";
	document.frm.submit();
}
function listArticle() {
	document.frm.exChk.value = "";
	document.frm.action = "<c:url value='${rootPath}/community/selectBoardList.do'/>";
	<c:if test="${searchVO.fromUnread == 'Y'}">
	document.frm.action = "<c:url value='${rootPath}/community/selectUnreadBoardList.do'/>";
	</c:if>
	document.frm.submit();
}
function setDiscussState(exChk) {
	document.frm.exChk.value = exChk;
	document.frm.action = "<c:url value='${rootPath}/community/setDiscussState.do'/>";
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
				<div id="center" style="padding-bottom:80px">
					<div class="path_navi">
						<ul>
							<li class="stitle">게시물 읽기</li>
							<li class="navi">홈 > 커뮤니티 > 게시판</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						
						<p class="th_stitle">토론게시판<span class="th_count">(조회수 <c:out value="${result.inqireCo}"/>)</span></p>
						
						<!-- 게시판 시작  -->
						<form name="frm" method="post" enctype="multipart/form-data" >
						<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
						<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>"/>
						<input type="hidden" name="searchWrd" value="<c:out value='${searchVO.searchWrd}'/>"/>
						<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" >
						<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" >
						<input type="hidden" name="parnts" value="<c:out value='${result.parnts}'/>" >
						<input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>" >
						<input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>" >
						<input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>" >
						<input type="hidden" name="exChk" value="<c:out value='${result.exChk}'/>" >
						<div class="boardView">
							<table cellpadding="0" cellspacing="0" summary="토론게시판 읽기페이지입니다.">
		                    <caption>토론게시판  읽기</caption>
		                    <colgroup>
			                    <col class="col100" />
			                    <col width="px" />
			                    <col class="col100" />
			                    <col width="px" />
		                    </colgroup>
		                    <thead>
		                    	<tr>
			                    	<th class="write_info">제목</th>
			                    	<th class="write_info2" colspan="3"><c:out value="${result.nttSj}" /></th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">작성자</th>
			                    	<th class="write_info2"><print:user userNo="${result.frstRegisterId}" userNm="${result.ntcrNm}" userId="${result.ntcrId}" printId="true"/></th>
			                    	<th class="write_info">소속</th>
			                    	<th class="write_info2">${result.ntcrOrgnztNm}</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">등록일시</th>
			                    	<th class="write_info2"><c:out value="${result.frstRegisterPnttm}" /></th>
			                    	<th class="write_info">상태</th>
			                    	<th class="write_info2">
			                    		<c:choose>
			                    			<c:when test="${result.exChk == 'Y'}" >종료(<c:out value="${result.exChkTm}" />)</c:when>
			                    			<c:otherwise>진행중</c:otherwise>
			                    		</c:choose>
			                    	</th>
		                        </tr>
		                    </thead>
							<tfoot>
								<tr>
									<td class="write_info">첨부파일</td>
									<td class="write_info2" colspan="3">
										<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${result.atchFileId}" />
										</c:import>
									</td>
								</tr>
							</tfoot>
		                    <tbody>
		                    	<tr>
			                    	<td colspan="4" class="H300"><c:out value="${result.nttCn}" escapeXml="false" /></td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						
						<c:import url="${rootPath}/community/selectCommentList.do" charEncoding="utf-8">
							<c:param name="type" value="body" />
						</c:import>
						</form>
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<c:if test="${user.admin || user.no == result.frstRegisterId}">
		                		<c:choose>
		                   			<c:when test="${result.exChk == 'Y'}" ><a href="javascript:setDiscussState('N');"><img src="${imagePath}/btn/btn_reprogress.gif"/></a></c:when>
		                   			<c:otherwise><a href="javascript:setDiscussState('Y');"><img src="${imagePath}/btn/btn_enddiscussion.gif"/></a></c:otherwise>
		                   		</c:choose>
			                	<a href="javascript:modifyArticle();"><img src="${imagePath}/btn/btn_modify.gif"/></a>
			                	<a href="javascript:deleteArticle();"><img src="${imagePath}/btn/btn_delete.gif"/></a>
		                	</c:if>
		                	<a href="javascript:scrapArticle('BBS', '${result.nttId}')"><img src="${imagePath}/btn/btn_scrap.gif"/></a>
		                	<a href="javascript:answerArticle();"><img src="${imagePath}/btn/btn_answer.gif"/></a>
		                	<a href="javascript:listArticle();"><img src="${imagePath}/btn/btn_list.gif"/></a>
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
