<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function taxSearch(pageIndex) {
	document.taxPublishFrm.pageIndex.value = pageIndex;
	document.taxPublishFrm.action = '<c:url value="${rootPath}/support/taxPublishL.do" />';
	document.taxPublishFrm.submit();
}
function taxView(bondId) {
	document.taxPublishFrm.bondId.value = bondId;
	document.taxPublishFrm.action = '<c:url value="${rootPath}/support/taxPublishV.do" />';
	document.taxPublishFrm.submit();	 
}
function taxWrite() {
	document.taxPublishFrm.action = '<c:url value="${rootPath}/support/taxPublishW.do" />';
	document.taxPublishFrm.submit();
}
//프로젝트 검색조건 초기화
function clsPrj() {
	$('#searchPrjNm').val('');
	$('#searchPrjId').val('');
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
						<li class="stitle">세금계산서 신청 현황</li>
						<li class="navi">홈 > 업무지원 > 각종신청 > 세금계산서 발행요청</li>
					</ul>
				</div>	
				
				<!-- S: section -->
				<div class="section01">
				
					<form name="taxPublishFrm" id="taxPublishFrm" method="POST" action="" onsubmit="taxSearch(1); return false;">
					<input name="bondId" type="hidden" value=""/>
					<input name="pageIndex" type="hidden" value="${taxPublishVO.pageIndex}"/>
					
				    <!-- 상단 검색창 시작 -->
					<fieldset>
					<legend>상단 검색</legend>
	                   <div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0">
							<caption>상단 검색</caption>
								<colgroup>
									<col width="px" />
									<col width="180" />
									<col width="50" />
								</colgroup>
							<tbody>
								<tr>
									<td class="pT5">
			               	 			처리상태 :
			               	 			<label><input type="checkbox" class="check" name="bondStatN" value="Y" <c:if test="${taxPublishVO.bondStatN == 'Y'}">checked</c:if>/> 미발행 </label>
			               	 			<label><input type="checkbox" class="check" name="bondStatY" value="Y" <c:if test="${taxPublishVO.bondStatY == 'Y'}">checked</c:if>/> 발행완료 </label>
			               	 			<label><input type="checkbox" class="check" name="bondStatC" value="Y" <c:if test="${taxPublishVO.bondStatC == 'Y'}">checked</c:if>/> 취소 </label>
									</td>
									<td class="pT5">
										발행회사 : 
										<select name="searchCompanyCd">
											<option value="">선택</option>
											<c:forEach items="${compList}" var="comp">
												<option value="${comp.code}" <c:if test="${comp.code == taxPublishVO.searchCompanyCd}">selected="selected"</c:if>><c:out value="${comp.codeNm}"/></option>
											</c:forEach>
										</select>
									</td>
									<td width="75" rowspan="3" class="search_right">
										<input type="image" src="../../images/btn/btn_search02.gif" class="search_btn02" alt="검색"/>
									</td>
								</tr>
								<tr>
									<td colspan="2" class="pT5">
										<label>요청제목 </label><input type="text" value="${taxPublishVO.searchSj}" name="searchSj" class="input01 span_10"/>
			               	 			<span class="pL7"></span><label>요청자 </label><input type="text" value="${taxPublishVO.userNm}" name="userNm" class="input01 span_7 userNameAutoHead"/>
			               	 			<span class="pL7"></span><label>업체명 </label> <input type="text" value="${taxPublishVO.searchNm}" name="searchNm" class="input01 span_7"/> 									
			               	 		</td>
								</tr>
								<tr>
									<td colspan="2" class="pT5">
										<label>관련 프로젝트 </label>
										<input type="text" name="searchPrjNm" id="searchPrjNm" value="${taxPublishVO.searchPrjNm}" class="span_11 input01" readonly="readonly" onclick="prjGen('searchPrjNm','searchPrjId',1);"/>
										<input type="hidden" name="searchPrjId" id="searchPrjId" value="${taxPublishVO.searchPrjId}"/>
										<img src="${imagePath}/btn/btn_tree.gif" onclick="prjGen('searchPrjNm','searchPrjId',1);" class="cursorPointer">
										<img src="${imagePath}/btn/btn_replay.gif" onclick="clsPrj();" class="cursorPointer" title="프로젝트 검색조건 초기화" style="padding-top:2px;">
										<span class="pL10"></span>
										<label><input type="checkbox" class="check" name="untilToday" value="Y" <c:if test="${taxPublishVO.untilToday == 'Y'}">checked</c:if>/> 발행예정일이 오늘 이후인 건은 표시하지 않음 </label>
									</td>
								</tr>
							</tbody>
							</table>
						</div>
	                </fieldset>
	            	<!-- 상단 검색창 끝 -->
	            	
	            	</form>
					
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col40" />
							<col width="px" />
							<col class="col90" />
							<col class="col90" />
							<col class="col80" />
							<col class="col60" />
							<col class="col60" />
							<col class="col60" />
							<col class="col60" />
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>요청제목</th>
								<th>업체명</th>
								<th>발행회사</th>
								<th>총금액<br/>(VAT포함)</th>
								<th>발행<br/>예정일</th>
								<th>요청자</th>
								<th>요청일시</th>
								<th class="th_right">상태</th>
							</tr>
						</thead>
						<tbody>
						<c:choose>
						<c:when test="${empty resultList }">
							<tr><td colspan="9" class="td_last txt_center" > </td></tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${resultList}" var="result" varStatus="c">
							<tr>
								<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((taxPublishVO.pageIndex-1) * paginationInfo.recordCountPerPage + c.count) + 1}"/></td>
								<td class="pL5">
<!--								<a href="javascript:taxView('${result.bondId}');">${result.bondSj}</a>-->
									<a href="${rootPath}/support/taxPublishV.do?bondId=${result.bondId}">${result.bondSj}</a>								
								</td>
								<td class="txt_center">${result.custNm}</td>
								<td class="txt_center">${result.companyNm}</td>
								<td class="txt_center"><print:currency cost="${result.expSum}" /></td>
								<td class="txt_center"><print:date date="${result.publishDate}" printType='S'/></td>
								<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
								<td class="txt_center">${result.writeDate}</td>
								<td class="txt_center td_last">${result.bondStatPrint}</td>
							</tr>
							</c:forEach>
						</c:otherwise>
						</c:choose>
						</tbody>
						</table>
					</div>
					
					<div class="paginate">
						<ui:pagination paginationInfo="${paginationInfo}" jsFunction="taxSearch" type="image"/>
					</div>
					
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
                		  <img src="../../images/btn/btn_publishRqst.gif" class="cursorPointer" onclick="taxWrite();"/>
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
