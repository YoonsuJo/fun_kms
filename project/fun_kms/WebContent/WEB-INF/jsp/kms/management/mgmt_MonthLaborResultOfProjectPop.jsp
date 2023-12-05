<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>

<%@ include file="../include/top_inc.jsp"%>
<script>
function viewProject(prjId){
	var popup = window.open("/project/viewProjectPop.do?prjId="+prjId,
			"_POP_PROJECT_VIEW",
			"width=970px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
}
</script>
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
							<li class="stitle">월 인건비 세부내역 조회</li>
							<li class="navi">사업실적 > 인건비 조회</li>
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
										<span > 프로젝트명 : </span>
										<input type="text" class="pL5 w300" name="searchPrjNm" id="searchPrjNm" value="${searchVO.searchPrjNm}" readonly="readonly"/>
										<span > 프로젝트ID : </span>
										<input type="text" class="pL5 w200" name="searchPrjId" id="searchPrjId" value="${searchVO.searchPrjId}" readonly="readonly"/>
									</td>
								</tr>
							</tbody>
							</table>
							</div>
						</fieldset>
						</form:form>
						<!-- 상단 검색창 끝 -->
						
						<!-- 게시판 시작  -->
						<p class="th_plus02">단위 : 천원</p>
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" >
								<colgroup>
									<col class="col40" />
									<col class="col500" />
									<col class="col100" />
									<col class="col80" />
									<col class="col80" />
									<col class="col80" />
								</colgroup>
								<thead>
									<tr class="height_th">
										<th>번호</th>
										<th>프로젝트</th>
										<th>담당자</th>
										<th>인건비</th>
										<th>근무시간</th>
										<th>투입율</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td class="txt_center" colspan="3">합계</td>
										<td class="pR10 txt_right"><print:currency cost="${searchVO.amountSum}" divideBy="${divideby}"/></td>
										<td></td>
										<td></td>
									</tr>
								</tfoot>
								<tbody>
									<c:forEach items="${mrVOList}" var="vo" varStatus="vs">
										<tr>
											<td class="txt_center"><c:out value="${vs.count}"/></td>
											<td class="pL10"><print:project prjCd="${vo.prjCode}" prjId="${vo.prjId}" prjNm="${vo.prjName}"/>	</td>
											<td class="txt_center">${vo.writerName }</td>
											<td class="pR10 txt_right"><print:currency cost="${vo.amount}" divideBy="${divideby}"/> </td>
											<td class="txt_center">${vo.workHour}</td>
											<td class="txt_center">${vo.workRate} %</td>
										</tr>
									</c:forEach>
								</tbody>
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
