
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<script>
$(document).ready(function() {
	addOrgIdEvent();  
	
});


function invoiceListPaging(pageIndex) {
	document.bondCheckFm.pageIndex.value = pageIndex;
	document.bondCheckFm.action = '<c:url value="${rootPath}/fund/chckProjectBondCheckList.do" />';
	document.bondCheckFm.submit();
}

function searchList(){
	document.bondCheckFm.action = '<c:url value="${rootPath}/fund/bizCollectList.do" />';
	document.bondCheckFm.submit();
}

function viewProject(prjId){
	/*
	var form = $('#searchVO');
	form.attr("action", "/fund/selectProjectPopV.do?prjId="+prjId);
	form.submit();
	*/
	
	var popup = window.open("/project/viewProjectPop.do?prjId="+prjId,"_POP_PROJECT_VIEW","width=1200px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
	
}

function viewTotalSales(prjId, prjName){
	/*
	var form = $('#searchVO');
	form.attr("action", "/fund/selectProjectPopV.do?prjId="+prjId);
	form.submit();
	*/
	
	var popup = window.open("/fund/chckTotalSalesList.do?prjId="+prjId + "&prjName=" + prjName, "_POP_PROJECT_VIEW","width=1200px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
	
}

function viewProjectSales(prjId, prjName){

	var popup = window.open("/fund/chckProjectBondCheckView.do?prjId="+prjId + "&prjName=" + prjName, "_POP_PROJECT_VIEW","width=1200px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
	
}

function addOrgIdEvent() {

	$('#orgnztIdSel').change(function(){
		OrgIdEvent(this);
	});

	function OrgIdEvent(selector) {
		var option = selector.children(':selected');
		$('#orgnztId').val(option.val());			
	};
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
							<li class="stitle">수금 현황 조회(사업부용)</li>
							<li class="navi">홈 > 경영정보 > 채권관리 > 수금 현황 조회(사업부용)</li>
						</ul>
					</div> <!-- div class="path_navi" -->
	
					<span class="stxt">.</span>

					<!-- S: section -->
					<div class="section01">
						
					<form:form commandName="bondCheckFm" id="bondCheckFm" name="bondCheckFm" method="post"  >
						<input type="hidden" name="searchCondition" 	id="searchCondition" value="Y"/>
						
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<colgroup>
								<col class="col200" />
								<col class="col400" />
								<col class="col200" />
							</colgroup>
							<tbody>
								<tr>
									<td>
										<select  name="orgnztId" id="orgnztId" class="select01" >
											<option value="" > 전 체 </option>
											<c:forEach items="${rstOrgnztList}" var="rstOrgnzt" varStatus="c">
											<c:choose>
												<c:when test="${rstOrgnzt.orgnztId == bcFm.orgnztId}">
													<option value="${rstOrgnzt.orgnztId}" selected > ${rstOrgnzt.orgnztName}</option>
												</c:when>
												<c:otherwise>
													<option value="${rstOrgnzt.orgnztId}" > ${rstOrgnzt.orgnztName} </option>
												</c:otherwise>
											</c:choose>
											</c:forEach>
										</select>
									</td>
									<td>
										<span class="pL70"></span><label>수금기준일 : </label><input type="text" class="input03 span_5 calGen"  readonly="readonly" name="fromDate" id="fromDate" value="${bcFm.fromDate}"/>
										<label> ~ </label><input type="text" class="input03 w70 calGen"  readonly="readonly" name="toDate" id="toDate" value="${bcFm.toDate}"/>
									</td>
									<td class="search_right" >
										<img src="../../images/btn/btn_search02.gif" class="search_btn02 cursorPointer" alt="검색" onclick="searchList();"/>
									</td>
								</tr>
							</tbody>
							</table>
		                    </div>
		                </fieldset>
	                	<!-- 상단 검색창 끝 -->
                	</form:form>
						
						<!-- 게시판 시작  -->
						<p class="th_plus02">단위 : 원</p>
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>공지사항 보기</caption>
							<colgroup>
								<col class="col40" />
								<col class="col400" />
								<col class="col80" />
								<col class="col80" />
								<col class="col80" />
								<col class="col80" />
							</colgroup>
							<thead>
								<tr>
									<th >번호</th>
									<th >프로젝트명</th>
									<th><span class="tooltip" >처리자</span></th>
									<th><span class="tooltip" >수금일</span></th>
									<th><span class="tooltip" >수금액</span></th>
									<th><span class="tooltip" >잔여금액</span></th>
								</tr>
								<tr>
									<th ></th>
									<th >합계</th>
									<th></th>
									<th></th>
									<th><print:currency cost="${clVOSum.collect}"/></th>
									<th><print:currency cost="${clVOSum.prjUncollect}"/></th>
								</tr>
							</thead>
		                    <tbody>
		                    	<c:forEach items="${clVOList}" var="vo" varStatus="c">
		                    	<tr>
									<td class="txt_center">	<c:out value="${c.count}"/></td>
			                    	<td class="txt_left"><a href="javascript:viewProject('${vo.prjId}');">&nbsp; ${vo.prjName}</a></td>
			                    	<td class="txt_center pR10">${vo.collectUserName}</td>
			                    	<td class="txt_center pR10">${vo.collectDate}</td>
			                    	<td class="txt_right pR10"><print:currency cost="${vo.collect}"/></td>
			                    	<td class="txt_right pR10"><print:currency cost="${vo.prjUncollect}"/></td>
		                    	</tr>
		                    	</c:forEach>
		                    </tbody>
		                    </table>
							<p class="th_plus03">* 미수금 금액이 마이너스이면 초과 수금임.</p>
						</div>  <!-- class="boardList02 mB20" -->
				<div class="btn_area">
				</div>

					</div>	<!-- E: section -->
				</div>	<!-- E: center -->				
				<%@ include file="../include/right.jsp"%>
			</div>	<!-- E: centerBg -->
		</div>	<!-- E: contents -->
	</div>  <!-- E: container -->
<%@ include file="../include/footer.jsp"%>
</div> <!-- id=wrap -->
</body>
</html>
