<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
$(function(){
	$('#btn_regist').click(function(){
		$('#frm').attr('action', '${rootPath}/support/bpManualWrite.do');
		$('#frm').submit();
	});
	$('#btn_search').click(function(){
		document.frm.pageIndex.value = 1;
		
		$('#frm').attr('action', '${rootPath}/support/bpManualList.do');
		$('#frm').submit();
	});
});
function lfn_view(no){
	$('#frm').attr('action', '${rootPath}/support/bpManualView.do?bpmNo='+no);
	$('#frm').submit();
}
function search(pageNo) {
	document.frm.pageIndex.value = pageNo;
	
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
							<li class="stitle">업무처리절차</li>
							<li class="navi">홈 > 업무지원 > 업무처리지원 > 업무처리절차</li>
						</ul>
					</div>
	
				<!-- S: section -->
				<div class="section01">
			    	
			    	<!-- 상단 검색창 시작 -->
			    	<form id="frm" name="frm" method="post">
			    	<input type="hidden" name="pageIndex" value="${bpmVO.pageIndex}"/>
			    	
					<div class="top_search07 mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<tbody>
							<tr>
								<td class="pT5">
									업무구분 : 
									<select id="searchGubunNo" name="searchGubunNo">
										<option value="">-- 전체 --</option>
										<c:forEach items="${gubunList}" var="gubunList">
										<option value="${gubunList.gubunNo}" <c:if test="${gubunList.gubunNo == bpmVO.searchGubunNo}">selected="selected"</c:if>>${gubunList.gubunNm}</option>
										</c:forEach>
									</select>
									<label><input type="radio" name="searchCondition" value="0" <c:if test="${bpmVO.searchCondition == '0'}">checked="checked"</c:if>/>제목</label><span class="pL7"></span>
									<label><input type="radio" name="searchCondition" value="1" <c:if test="${bpmVO.searchCondition == '1'}">checked="checked"</c:if>/>제목+내용</label><span class="pL7"></span>
									<label><input type="radio" name="searchCondition" value="2" <c:if test="${bpmVO.searchCondition == '2'}">checked="checked"</c:if>/>작성자</label>
									<input type="text" name="searchKeyword" id="searchKeyword" class="search_txt02" value="${bpmVO.searchKeyword}"/>
								</td>
								<td class="search_right">
									<label><input type="checkbox" name="searchCheck" value="N" <c:if test="${bpmVO.searchCheck == 'N'}">checked="checked"</c:if>/> 무효글 포함</label><span class="pL7"></span>
									<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색" class="search_btn02" id="btn_search"/>
								</td>
							</tr>
						</tbody>
						</table>
	                </div>
			    	</form>
                	<!-- 상단 검색창 끝 -->
					
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col40" />
							<col class="col100" />
							<col width="px" />
							<col class="col60" />
							<col class="col110" />
							<col class="col60" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">업무구분</th>
								<th scope="col">제목</th>
								<th scope="col">작성자</th>
								<th scope="col">변경일시</th>
								<th scope="col">조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
							<c:when test="${!empty list}">
								<c:forEach items="${list}" var="element" varStatus="index">
								<tr>
									<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((bpmVO.pageIndex-1) * bpmVO.recordCountPerPage + index.count) + 1}"/></td>
									<td class="txt_center">${element.gubunNm}</td>
									<td class="pL10">
										<a href="#" onclick="lfn_view('${element.bpmNo}')">
										<c:if test="${element.useStatus == 'Y'}">
											<c:if test="${element.readYn == 'N'}"><span class="txt_red">${element.subject}</span> [${element.commentCount}]</c:if>
											<c:if test="${element.readYn == 'Y'}">${element.subject} [${element.commentCount}]</c:if>
										</c:if>
										<c:if test="${element.useStatus == 'N'}">
											<strike>${element.subject}</strike> [${element.commentCount}] [무효문서]
										</c:if>
										<c:if test="${element.hiddenYn == 'Y'}">
											[숨김문서]
										</c:if>
										</a>
									</td>
									<td class="txt_center"><print:user userNo="${element.userNo}" userNm="${element.userNm}"/></td>
									<td class="txt_center">${fn:substring(fn:replace(element.chgDate, '-', '.'), 0, 16)}</td>
									<td class="txt_center">${element.readCount}</td>
								</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td class="txt_center" colspan="6">
									게시글이 없습니다.
									</td>
								</tr>
							</c:otherwise>
							</c:choose>
						</tbody>
						</table>
					</div>
					
					<!-- 페이징 시작 -->
					<div class="paginate">
	                	<ui:pagination paginationInfo="${paginationInfo}" jsFunction="search" type="image"/>
					</div>
					<!-- 페이징 끝 -->
					
					
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
                		<img src="${imagePath}/btn/btn_regist.gif" class="cursorPointer" id="btn_regist"/>
               	    </div>
                 	<!-- 버튼 끝 -->
                 	
				</div>
				<!--
				\ E: section -->
	
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
