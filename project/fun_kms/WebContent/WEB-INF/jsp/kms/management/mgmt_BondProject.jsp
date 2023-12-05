<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<script>
$(document).ready(function() {
	var searchPrjCd = '${searchVO.prjCd}';
	if (searchPrjCd.trim() != '') {

		// 프로젝트 코드에 포커스 
		var prjs = $('.boardList02>table>tbody>tr>td:nth-child(2)');
		for(var i=0; i<prjs.length; i++) {
			if ($(prjs[i]).html().indexOf(searchPrjCd) > -1) {
				$(prjs[i]).parent().css('background-color', '#fffddb');
				
				// 스크롤 이동
				window.scrollTo(0, prjs[i].offsetTop);
				/*
				setTimeout(function() {
					window.scrollTo(0, targetHeight);
				}, 500);
				*/
			}
		}
	}
});

function searchTax(){
	document.bondFrm.action = '<c:url value="${rootPath}/management/bondPrj.do" />';
	document.bondFrm.submit();
}
function searchTaxPublish(prjId, noColOnly, searchAllPeriod){
	document.bondFrm.searchAllPeriod.value = searchAllPeriod;
	document.bondFrm.prjId.value = prjId;
	document.bondFrm.noColOnly.value = noColOnly;
	document.bondFrm.action = '<c:url value="${rootPath}/management/bondTaxPublish.do" />';
	document.bondFrm.submit();
}
function searchNoPublish(prjId){
	document.bondFrm.prjId.value = prjId;
	document.bondFrm.action = '<c:url value="${rootPath}/management/bondNoPublish.do" />';
	document.bondFrm.submit();
}
function linkModPrj(prjId) {
	var searchOrgId = 'searchOrgId=${searchVO.searchOrgId}';
	//var searchOrgNm = 'searchOrgNm=${searchVO.searchOrgNm}';
	var searchIncMngd = 'searchIncMngd=${searchVO.searchIncMngd}';
	var returnUrl = '/management/bondPrj.do?' + searchOrgId + '&' + searchIncMngd;
	returnUrl = encodeURIComponent(returnUrl);
	var modPrjUrl = '${rootPath}/cooperation/modifyProject.do?prjId=' + prjId + '&returnUrl=' + returnUrl; 
	location.href = modPrjUrl;
}
</script>
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
							<li class="stitle">프로젝트별 채권관리</li>
							<li class="navi">홈 > 경영정보 > 매출관리 > 채권관리</li>
						</ul>
					</div>
	
					<span class="stxt">금액을 클릭하면 상세정보 페이지로 이동합니다.
					<span class="txtS_blue">중지</span>
					<span class="txtS_red">종료</span>는 프로젝트 뒤에 표시, 진행은 미표시  
					</span>

					<!-- S: section -->
					<div class="section01">
					
						<form name="bondFrm" id="bondFrm" method="POST" action="">
						<input name="prjId" type="hidden" value="" />
						<input name="noColOnly" type="hidden" value="${searchVO.noColOnly}" />
						<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
						<input type="hidden" name="searchAllPeriod" value="${searchVO.searchAllPeriod}"/>
						
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<colgroup>
								<col class="col200" />
								<col width="px" />
							</colgroup>
							<tbody>
								<tr>
									<td colspan="2">
										<input type="text" class="input01 span_4 calGen" name="startDate" value="${searchVO.startDate}"/> ~ <input type="text" class="input01 span_4 calGen" name="endDate" value="${searchVO.endDate}"/><span class="T11"> (세금계산서 발행일 기준)</span>
									</td>
								</tr>
								<tr>
									<td>
										<label><input type="checkbox" name="searchIncMngd" <c:if test="${!empty searchVO.searchIncMngd}">checked="true"</c:if>>관리대상 모두 포함</label>
									</td>
									<td class="search_right">
										프로젝트 주관부서 : 
										<input type="text" name="searchOrgNm" id="orgNm" class="search_txt02 span_27" value="${searchVO.searchOrgNm}" readonly="readonly" onclick="orgGen('orgNm','orgId',0);"/>
										<img id="orgTree" src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="orgGen('orgNm','orgId',0);"/>
										<img src="../../images/btn/btn_search02.gif" class="search_btn02 cursorPointer" alt="검색" onclick="searchTax();"/>
									</td>
								</tr>
							</tbody>
							</table>
							</div>
						</fieldset>
						<!-- 상단 검색창 끝 -->
						
						</form>
						
						<!-- 게시판 시작  -->
						<p class="th_plus02">단위 : 원</p>
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>공지사항 보기</caption>
							<colgroup>
								<col class="col100" />
								<col width="px" />
								<col class="col90" />
								<col class="col90" />
								<col class="col90" />
								<col class="col90" />
								<col class="col90" />
								<col class="col90" />
							</colgroup>
							<thead>
								<tr>
									<th rowspan="2">부서</th>
									<th rowspan="2">프로젝트</th>
									<th colspan="4"><print:date date="${searchVO.startDate}"/> ~ <print:date date="${searchVO.endDate}"/></th>
									<th class="td_last" colspan="2">전체누적</th>
								</tr>
								<tr>
									<th><span class="tooltip" onmouseover="bindTooltip(this, '4688', '250');">계산서<br/>발행금액</span></th>
		                    		<th><span class="tooltip" onmouseover="bindTooltip(this, '4689', '200');">계산서<br/>미발행금액</span></th>
		                    		<th>수금액<br/>(VAT 포함)</th>
		                    		<th><span class="tooltip" onmouseover="bindTooltip(this, '4690', '300');">미수금액<br/>(VAT 포함)</span></th>
		                    		<th><span class="tooltip" onmouseover="bindTooltip(this, '4691', '300');">계산서<br/>미발행금액</span></th>
		                    		<th class="td_last"><span class="tooltip" onmouseover="bindTooltip(this, '4692', '250');">미수금액<br/>(VAT 포함)</span></th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center">${result.orgnztNm}</td>
									<td class="txt_center">
										<a href="${rootPath}/cooperation/selectProjectV.do?prjId=${result.prjId}">[${result.prjCd}] ${result.prjNm}
										<c:if test="${user.admin || user.isProjectadmin == 'Y' }">
											</a><a href="javascript:linkModPrj('${result.prjId}');">
										</c:if>
										<c:if test="${result.prjStat == 'P'}"><!--<span class="txtS_red">진행</span>--></c:if>
										<c:if test="${result.prjStat == 'S'}"><span class="txtS_blue">중지</span></c:if>
										<c:if test="${result.prjStat == 'E'}"><span class="txtS_red">종료</span></c:if>
										</a>
									</td>
									<td class="txt_center"><a href="javascript:searchTaxPublish('${result.prjId}','N','N');"><print:currency cost="${result.sumExpense}"/></a></td>
									<td class="txt_center">
										<a href="javascript:searchNoPublish('${result.prjId}');">
											<span <c:if test="${result.noPublish < 0}">class="txt_blue"</c:if>>
												<print:currency cost="${result.noPublish}"/>
											</span>
										</a>
									</td>
									<td class="txt_center"><a href="javascript:searchTaxPublish('${result.prjId}','N','N');"><print:currency cost="${result.sumCollection}"/></a></td>
									<td class="txt_center bG04">
										<a href="javascript:searchTaxPublish('${result.prjId}','Y','N');">
											<span 
											<c:if test="${0 < result.noCollection}">class="txt_red"</c:if>
											<c:if test="${result.noCollection < 0}">class="txt_blue"</c:if>>
												<print:currency cost="${result.noCollection}"/>
											</span>
										</a>
									</td>
									<td class="txt_center">
										<a href="javascript:searchNoPublish('${result.prjId}');">
											<span <c:if test="${result.accNoPublish < 0}">class="txt_blue"</c:if>>
												<print:currency cost="${result.accNoPublish}"/>
											</span>
										</a>
									</td>
									<td class="td_last txt_center bG04">
										<a href="javascript:searchTaxPublish('${result.prjId}','Y','Y');">
											<span <c:if test="${0 < result.accNoCollection}">class="txt_red"</c:if><c:if test="${result.noCollection < 0}">class="txt_blue"</c:if>>
												<print:currency cost="${result.accNoCollection}"/>
											</span>
										</a>
									</td>
								</tr>
							</c:forEach>
							</tbody>
							<tfoot>
								<tr>
									<td class="txt_center" colspan="2">합계</td>
									<td class="txt_center"><print:currency cost="${resultSum.sumExpense}"/></td>
									<td class="txt_center"><print:currency cost="${resultSum.noPublish}"/></td>
									<td class="txt_center"><print:currency cost="${resultSum.sumCollection}"/></td>
									<td class="txt_center"><print:currency cost="${resultSum.noCollection}"/></td>
									<td class="txt_center"><print:currency cost="${resultSum.accNoPublish}"/></td>
									<td class="td_last txt_center"><print:currency cost="${resultSum.accNoCollection}"/></td>
								</tr>
							</tfoot>
							</table>
						</div>
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
						<div class="btn_area">
							<a href="/management/bondOrg.do"><img src="../../images/btn/btn_list.gif"/></a>
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
