<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>

<%@ include file="../include/top_inc.jsp"%>
</head>

<body>

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
				<div id="center2">
					<div class="path_navi">
						<ul>
						<c:choose>
							<c:when test="${searchVO.searchResultType == 10}">
								<li class="stitle">월 외부매출 세부내역 조회</li>
								<li class="navi">사업실적 > 월 외부매출 세부내역 조회</li>
							</c:when>
							<c:when test="${searchVO.searchResultType == 11}">
								<li class="stitle">월누계 외부매출 세부내역 조회</li>
								<li class="navi">사업실적 > 월누계 외부매출 세부내역 조회</li>
							</c:when>
							<c:when test="${searchVO.searchResultType == 20}">
								<li class="stitle">월 내부매출 세부내역 조회</li>
								<li class="navi">사업실적 > 월 내부매출 세부내역 조회</li>
							</c:when>
							<c:when test="${searchVO.searchResultType == 21}">
								<li class="stitle">누계 내부매출 세부내역 조회</li>
								<li class="navi">사업실적 > 누계 내부매출 세부내역 조회</li>
							</c:when>
							<c:when test="${searchVO.searchResultType == 30}">
								<li class="stitle">월 외부매입 세부내역 조회</li>
								<li class="navi">사업실적 > 월 외부매입 세부내역 조회</li>
							</c:when>
							<c:when test="${searchVO.searchResultType == 31}">
								<li class="stitle">누계 외부매입 세부내역 조회</li>
								<li class="navi">사업실적 > 누계 외부매입 세부내역 조회</li>
							</c:when>
							<c:when test="${searchVO.searchResultType == 40}">
								<li class="stitle">월 내부매입 세부내역 조회</li>
								<li class="navi">사업실적 > 월 내부매입 세부내역 조회</li>
							</c:when>
							<c:when test="${searchVO.searchResultType == 41}">
								<li class="stitle">누계 내부매입 세부내역 조회</li>
								<li class="navi">사업실적 > 누계 내부매입 세부내역 조회</li>
							</c:when>
							<c:when test="${searchVO.searchResultType == 50}">
								<li class="stitle">월 인건비 세부내역 조회</li>
								<li class="navi">사업실적 > 인건비 조회</li>
							</c:when>
							<c:when test="${searchVO.searchResultType == 51}">
								<li class="stitle">누계 인건비 세부내역 조회</li>
								<li class="navi">사업실적 > 누계 인건비 조회</li>
							</c:when>
							<c:when test="${searchVO.searchResultType == 60}">
								<li class="stitle">월 판관비 세부내역 조회</li>
								<li class="navi">사업실적 > 월 판관비 조회</li>
							</c:when>
							<c:when test="${searchVO.searchResultType == 61}">
								<li class="stitle">누계 판관비 세부내역 조회</li>
								<li class="navi">사업실적 > 누계 판관비 조회</li>
							</c:when>
							<c:otherwise>												
								<li class="stitle">월 실적 세부내역 조회</li>
								<li class="navi">사업실적 > 월 실적 세부내역 조회</li>
							</c:otherwise>
						</c:choose>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<!-- 상단 검색창 시작 -->
						<form:form commandName="searchVO" id="searchVO" name="searchVO" method="post" enctype="multipart/form-data" >
						<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<colgroup>
								<col class="col120" />
								<col class="colpx" />
							</colgroup>
							<tbody>
								<tr>
									<td>
										<label> ${searchVO.searchYear}년</label>
										<label> ${searchVO.searchMonth}월</label>
									</td>
									<td class="search_right">
										<span >사업부 : </span>
										<input type="text" class="pL5 w300" name="searchOrgNm" id="searchOrgNm" value="${searchVO.searchOrgNm}" readonly="readonly"/>
									</td>
								</tr>
							</tbody>
							</table>
							</div>
						</fieldset>
						</form:form>
						<!-- 상단 검색창 끝 -->
						
						10배 이상 손실의 이익률은 0.0%로 표시
						<!-- 게시판 시작  -->
						<p class="th_plus02">단위 : 천원</p>
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" >
<c:choose>
	<c:when test="${( 10 <= searchVO.searchResultType) && (searchVO.searchResultType <= 21)}">
								<colgroup>
									<col class="col30" />
									<col class="col300" />
									<col class="colpx" />
									<col class="col80" />
									<col class="col80" />
								</colgroup>
								<thead>
									<tr class="height_th">
										<th>번호</th>
										<th>프로젝트</th>
										<th>매출명</th>
										<th>금액</th>
										<th>담당자</th>
									</tr>
									<tr >
										<th colspan="3">합계</th>
										<th class="pR10 txt_right"><print:currency cost="${searchVO.amountSum}" divideBy="${divideby}"/></th>
										<th></th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td class="txt_center" colspan="3">합계</td>
										<td class="pR10 txt_right"><print:currency cost="${searchVO.amountSum}" divideBy="${divideby}"/></td>
										<td></td>
									</tr>
								</tfoot>
								<tbody>
									<c:forEach items="${mrVOList}" var="vo" varStatus="vs">
										<tr>
											<td class="txt_center"><c:out value="${vs.count}"/></td>
											<td class="pL10"><print:project prjCd="${vo.prjCode}" prjId="${vo.prjId}" prjNm="${vo.prjName}"/></td>
 											<td class="pL10 txt_left">${vo.subject }</td>
											<td class="pR10 txt_right"><print:currency cost="${vo.amount}" divideBy="${divideby}"/> </td>
											<td class="txt_center">${vo.writerName}</td>
										</tr>
									</c:forEach>
								</tbody>
	</c:when>
	<c:when test="${( 30 <= searchVO.searchResultType) && (searchVO.searchResultType <= 41)}">
								<colgroup>
									<col class="col30" />
									<col class="col300" />
									<col class="colpx" />
									<col class="col80" />
									<col class="col80" />
								</colgroup>
								<thead>
									<tr class="height_th">
										<th>번호</th>
										<th>프로젝트</th>
										<th>매입명</th>
										<th>금액</th>
										<th>담당자</th>
									</tr>
									<tr >
										<th colspan="3">합계</th>
										<th class="pR10 txt_right"><print:currency cost="${searchVO.amountSum}" divideBy="${divideby}"/></th>
										<th></th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td class="txt_center" colspan="3">합계</td>
										<td class="pR10 txt_right"><print:currency cost="${searchVO.amountSum}" divideBy="${divideby}"/></td>
										<td></td>
									</tr>
								</tfoot>
								<tbody>
									<c:forEach items="${mrVOList}" var="vo" varStatus="vs">
										<tr>
											<td class="txt_center"><c:out value="${vs.count}"/></td>
											<td class="pL10"><print:project prjCd="${vo.prjCode}" prjId="${vo.prjId}" prjNm="${vo.prjName}"/></td>
 											<td class="pL10 txt_left">${vo.subject }</td>
											<td class="pR10 txt_right"><print:currency cost="${vo.amount}" divideBy="${divideby}"/> </td>
											<td class="txt_center">${vo.writerName}</td>
										</tr>
									</c:forEach>
								</tbody>
	</c:when>
	<c:when test="${( 50 <= searchVO.searchResultType) && (searchVO.searchResultType <= 51)}">
								<colgroup>
									<col class="col30" />
									<col class="col500" />
									<col class="col100" />
									<col class="col80" />
									<col class="col80" />
								</colgroup>
								<thead>
									<tr class="height_th">
										<th>번호</th>
										<th>프로젝트</th>
										<th>투입인력</th>
										<th>인건비</th>
										<th>근무시간</th>
									</tr>
									<tr >
										<th colspan="3">합계</th>
										<th class="pR10 txt_right"><print:currency cost="${searchVO.amountSum}" divideBy="${divideby}"/></th>
										<th></th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td class="txt_center" colspan="3">합계</td>
										<td class="pR10 txt_right"><print:currency cost="${searchVO.amountSum}" divideBy="${divideby}"/></td>
										<td></td>
									</tr>
								</tfoot>
								<tbody>
									<c:forEach items="${mrVOList}" var="vo" varStatus="vs">
										<tr>
											<td class="txt_center"><c:out value="${vs.count}"/></td>
											<td class="pL10"><print:project prjCd="${vo.prjCode}" prjId="${vo.prjId}" prjNm="${vo.prjName}"/>	</td>
											<td class="txt_center">${vo.writerName } 외</td>
											<td class="pR10 txt_right"><print:currency cost="${vo.amount}" divideBy="${divideby}"/> </td>
											<td class="txt_center">${vo.workHour}</td>
										</tr>
									</c:forEach>
								</tbody>
	</c:when>
	<c:otherwise>												
								<colgroup>
									<col class="col30" />
									<col class="col500" />
									<col class="col100" />
									<col class="col80" />
								</colgroup>
								<thead>
									<tr class="height_th">
										<th>번호</th>
										<th>프로젝트</th>
										<th>담당자</th>
										<th>판관비</th>
									</tr>
									<tr >
										<th colspan="3">합계</th>
										<th class="pR10 txt_right"><print:currency cost="${searchVO.amountSum}" divideBy="${divideby}"/></th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td class="txt_center" colspan="3">합계</td>
										<td class="pR10 txt_right"><print:currency cost="${searchVO.amountSum}" divideBy="${divideby}"/></td>
									</tr>
								</tfoot>
								<tbody>
									<c:forEach items="${mrVOList}" var="vo" varStatus="vs">
										<tr>
											<td class="txt_center"><c:out value="${vs.count}"/></td>
											<td class="pL10"><print:project prjCd="${vo.prjCode}" prjId="${vo.prjId}" prjNm="${vo.prjName}"/>	</td>
											<td class="txt_center">${vo.writerName }</td>
											<td class="pR10 txt_right"><print:currency cost="${vo.amount}" divideBy="${divideby}"/> </td>
										</tr>
									</c:forEach>
								</tbody>
	</c:otherwise>
</c:choose>
							</table>
						</div>
						<!--// 게시판 끝  -->
					</div>
					<!-- E: section -->
				</div>
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
