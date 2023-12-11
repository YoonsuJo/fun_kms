<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(moveMonth) {
	document.frm.moveMonth.value = moveMonth;
	document.frm.submit();
}
function detail(prjId, prjNm, includeUnderPrj) {
	document.frm.searchPrjId.value = prjId;
	document.frm.searchPrjNm.value = prjNm;
	document.frm.includeUnderPrj.value = includeUnderPrj;
	document.frm.action = "${rootPath}/management/selectInputResultProjectDetail.do";
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
						<li class="stitle">프로젝트별 인력투입실적</li>
						<li class="navi">홈 > 경영정보 > 인력투입관리 > 프로젝트별 투입실적</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
				
					<!-- 상단 검색창 시작 -->
					<form name="frm" method="POST" action="${rootPath}/management/selectInputResultProject.do" onsubmit="search(0); return false;">
					<input type="hidden" name="moveMonth" value="0"/>
					<input type="hidden" name="searchDate" value="${searchVO.searchDate}"/>
					<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
					<input type="hidden" name="searchPrjId"/>
					<input type="hidden" name="searchPrjNm"/>
					<input type="hidden" name="includeUnderPrj"/>
					<fieldset>
					<legend>상단 검색</legend>
						<div class="scheduleDate mB20">
							<ul>
								<li class="li_left">
									<a href="javascript:search(-1);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
									<span class="option_txt">${fn:substring(searchVO.searchDate,0,4)}년 ${fn:substring(searchVO.searchDate,4,6)}월</span>
									<a href="javascript:search(1);" class="pL10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
								</li>
								<li class="li_right">
									<span class="option_txt">부서</span><span class="pL7"></span>
									<input type="text" class="search_txt02 span_13" name="searchOrgNm" id="orgNm" value="${searchVO.searchOrgNm}" readonly="readonly" onfocus="orgGen('orgNm','orgId',0);"/>
									<img src="${imagePath}/btn/btn_tree.gif" onclick="orgGen('orgNm','orgId',0);" class="cursorPointer"/>
									<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색" onclick="search(0); return false;"/>
								</li>
							</ul>
						</div>
					</fieldset>
					</form>
					<!--// 상단 검색창 끝 -->
					
					<!-- 게시판 시작  -->
					<div class="boardList02 mB5">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>프로젝트별 인력투입실적</caption>
						<colgroup>
							<col class="col90" />
							<col width="px"/>
							<col class="col90" />
							<col class="col90" />
							<col class="col90" />
							<col class="col90" />
						</colgroup>
						<thead>
							<tr>
								<th>부서</th>
								<th>프로젝트</th>
								<th>투입시간</th>
								<th>인건비</th>
								<th>휴일근무일수</th>
								<th class="td_last">휴일근무수당</th>
							</tr>
						</thead>
						<tfoot>
							<c:forEach items="${resultSum}" var="resultSumObj">
								<tr>
									<td class="txt_center <c:if test="${resultSumObj.prjId != 'up'}">nb</c:if>" colspan="2">${resultSumObj.orgnztNm}</td>
									<td class="txt_center bG <c:if test="${resultSumObj.prjId != 'up'}">nb</c:if>">${resultSumObj.drTm}</td>
									<td class="txt_center bG <c:if test="${resultSumObj.prjId != 'up'}">nb</c:if>"><print:currency cost="${resultSumObj.drSalary}" divideBy="${divideby}"/></td>
									<td class="txt_center bG <c:if test="${resultSumObj.prjId != 'up'}">nb</c:if>">${resultSumObj.holTm}</td>
									<td class="txt_center bG <c:if test="${resultSumObj.prjId != 'up'}">nb</c:if>"><print:currency cost="${resultSumObj.holSalary}" divideBy="${divideby}"/></td>
								</tr>
							</c:forEach>
						</tfoot>
						<tbody>
							<c:set var="drTmSum" value="0"/>
							<c:set var="drSalarySum" value="0"/>
							<c:set var="holTmSum" value="0"/>
							<c:set var="holSalarySum" value="0"/>
																				
							<c:forEach items="${resultList}" var="result">
								<c:forEach items="${result.inputResultProjectList}" var="irp" varStatus="c">
									<tr>
										<c:if test="${c.count == 1}">
										<td class="txt_center" rowspan="${fn:length(result.inputResultProjectList)}"><print:org orgnztNm="${result.orgnztNm}" orgnztId="${result.orgnztId}"/>  </td>
										</c:if>
										<td style="padding-left:${irp.prjLvl*14 + 10}px;
											<c:if test="${irp.prjLvl != 0}">
											background:url(${imagePath}/inc/bullet_09.gif) no-repeat; background-position-x:${irp.prjLvl*14}px; background-position-y:10px;
											</c:if>">
											<print:project prjCd="${irp.prjCd}" prjId="${irp.prjId}" prjNm="${irp.prjNm}"/>
										</td>
										<td class="txt_center"><a href="javascript:detail('${irp.prjId}','${irp.prjNm}','N');">${irp.drTm}</a></td>
										<td class="txt_center"><a href="javascript:detail('${irp.prjId}','${irp.prjNm}','N');">${irp.drSalaryPrint}</a></td>
										<td class="txt_center"><a href="javascript:detail('${irp.prjId}','${irp.prjNm}','N');">${irp.holTm}</a></td>
										<td class="td_last txt_center"><a href="javascript:detail('${irp.prjId}','N');">${irp.holSalaryPrint}</a></td>
									</tr>
								</c:forEach>
								<tr>		                    		
									<td class="txt_center bG" colspan="2">소계 </td>
									<td class="txt_center bG"><a href="javascript:detail('${result.inputResultProjectList[0].prjId}','${result.inputResultProjectList[0].prjNm}','Y');">${result.drTmSum}</a></td>
									<!-- <c:set var="drTmSum" value="${result.drTmSum + drTmSum }"/> -->
									<td class="txt_center bG"><a href="javascript:detail('${result.inputResultProjectList[0].prjId}','${result.inputResultProjectList[0].prjNm}','Y');">${result.drSalarySumPrint}</a></td>
									<!-- <c:set var="drSalarySum" value="${result.drSalarySum + drSalarySum }"/> -->
									<td class="txt_center bG"><a href="javascript:detail('${result.inputResultProjectList[0].prjId}','${result.inputResultProjectList[0].prjNm}','Y');">${result.holTmSum}</a></td>
									<!-- <c:set var="holTmSum" value="${result.holTmSum + holTmSum }"/> -->
									<td class="td_last txt_center bG"><a href="javascript:detail('${result.inputResultProjectList[0].prjId}','${result.inputResultProjectList[0].prjNm}','Y');">${result.holSalarySumPrint}</a></td>
									<!-- <c:set var="holSalarySum" value="${result.holSalarySum + holSalarySum }"/> -->
								</tr>
							</c:forEach>
								<!-- 20140716,김동우 부서별 소계 추가하면서 총계도 java에서 계산해오도록 수정
								<tr>		                    		
									<td class="txt_center bG01" colspan="2">총계</td>
									<td class="txt_center bG01">${drTmSum}</td>
									<td class="txt_center bG01"><print:currency cost="${drSalarySum}"/></td>
									<td class="txt_center bG01">${holTmSum}</td>
									<td class="td_last txt_center bG01"><print:currency cost="${holSalarySum}"/></td>
								</tr>
								-->
						</tbody>
						</table>
					</div>
					
					
					<!--// 게시판  끝  -->
					
								
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
