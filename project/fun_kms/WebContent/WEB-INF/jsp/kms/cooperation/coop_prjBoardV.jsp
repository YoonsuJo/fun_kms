<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<c:import url="${rootPath}/cooperation/selectCommentList.do" charEncoding="utf-8">
	<c:param name="type" value="head" />
</c:import>
<script>
function modifyArticle() {
	document.frm.action = "<c:url value='${rootPath}/cooperation/updatePrjBoardView.do'/>";
	document.frm.submit();		
}
function deleteArticle() {
	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.action = "<c:url value='${rootPath}/cooperation/deletePrjBoard.do'/>";
		document.frm.submit();
	}	
}
function listArticle() {
	document.frm.action = "<c:url value='${rootPath}/cooperation/selectPrjBoardList.do'/>";
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
							<li class="stitle">프로젝트게시판</li>
							<li class="navi">홈 > 업무공유 > 협업 > 프로젝트게시판</li>
						</ul>
					</div>
	
				<!-- S: section -->
					<div class="section01">
						
						<!-- 게시판 시작  -->
						<form name="frm" method="post" enctype="multipart/form-data" >
						<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
						<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
						<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
						<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" >
						<input type="hidden" name="prjId" value="<c:out value='${result.prjId}'/>" >
						<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" >
						<input type="hidden" name="parnts" value="<c:out value='${result.parnts}'/>" >
						<input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>" >
						<input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>" >
						<input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>" >
						<div class="boardView">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
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
			                    	<th class="write_info">프로젝트</th>
			                    	<th class="write_info2"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}"/></th>
			                    	<th class="write_info">등록일시</th>
			                    	<th class="write_info2"><c:out value="${result.frstRegisterPnttm}" /></th>
		                        </tr>
		                    </thead>
		                    
							<tfoot>
								<tr>
									<td class="write_info">첨부파일</td>
									<td class="write_info2" colspan="3" >
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
						
						<c:import url="${rootPath}/cooperation/selectCommentList.do" charEncoding="utf-8">
							<c:param name="type" value="body" />
						</c:import>
						</form>
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<c:if test="${user.admin || user.no == result.frstRegisterId}">
			                	<a href="javascript:modifyArticle();"><img src="${imagePath}/btn/btn_modify.gif"/></a>
			                	<a href="javascript:deleteArticle();"><img src="${imagePath}/btn/btn_delete.gif"/></a>
			                </c:if>
		                	<a href="javascript:scrapArticle('BBS', '${result.nttId}')"><img src="${imagePath}/btn/btn_scrap.gif"/></a>
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
