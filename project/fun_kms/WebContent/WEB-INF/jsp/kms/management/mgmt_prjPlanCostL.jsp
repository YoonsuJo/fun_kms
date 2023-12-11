<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<style>
	tr.TrBg4_2 a { color: #A6A6A6;}
</style>
<script>
$(document).ready(function(){
	var year = ${searchVO.searchYear};
	var form = $('#searchVO');
	form.attr('action','/management/prjPlanCostList.do');
	$('#searchB').click(function(){
		form.submit();
	});

	$('#orgTreeGenB,#searchOrgNm').click(function(){
		orgGen('searchOrgNm', 'searchOrgId',2);
	});

	$('#searchYearNext').click(function(){
		form.find("[name=searchYear]").val(++year);
		form.submit();
	});
	$('#searchYearPrev').click(function(){
		form.find("[name=searchYear]").val(--year);
		form.submit();
	});
	$('[name=includeResult]').click(function(){
		form.submit();
	});
		
});
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
						<li class="stitle">프로젝트별 예산</li>
						<li class="navi">홈 > 경영정보 > 사업계획 > 프로젝트별 예산</li>
					</ul>
				</div>
				
				<!-- S: section -->
			
				<div class="section01">
				
					<!-- 상단 검색창 시작 -->
					<form:form commandName="searchVO" id="searchVO" name="searchVO" method="post" enctype="multipart/form-data" >
					<form:hidden path="searchYear" />
					<fieldset>
					<legend>상단 검색</legend>
						<div class="top_search07 mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<tbody>
							<tr>
								<td class="pT5" colspan="2">
									<img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지" class="cursorPointer" id="searchYearPrev"/>
									${searchVO.searchYear}년 
									<img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지" class="cursorPointer" id="searchYearNext"/>		
								</td>
							</tr>
							<tr>
								<td>
									<c:forEach begin="1" end="12" varStatus="status">
										<form:radiobutton path="searchMonth" label=" ${status.count}월" value="${status.count}"/>
									</c:forEach>
								</td>
								<td class="search_right">
									<label><input type="checkbox" name="includeAllDate" value="Y" 
											<c:if test="${searchVO.includeAllDate == 'Y'}">checked="checked"</c:if>/> 전체기간포함</label><br/>
									<label><input type="checkbox" name="includeResult" value="Y" 
											<c:if test="${searchVO.includeResult == 'Y'}">checked="checked"</c:if>/> 예상실적포함</label><br/>
									<label><input type="checkbox" name="includeAcc" value="Y" 
											<c:if test="${searchVO.includeAcc == 'Y'}">checked="checked"</c:if>/> 누적실적보기</label>
								</td>
							</tr>
							<tr>
								<td class="search_right" colspan="2"> 부서
									<form:input cssClass="search_txt02 span_12" path="searchOrgNm" readonly="true"/>
									<form:hidden path="searchOrgId" />
									
									<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" id="orgTreeGenB">
									<img src="${imagePath}/btn/btn_search02.gif" class="cursorPointer" id="searchB" alt="검색"/>
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
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup>
							<col class="col120" />
							<col width="px" />
							<col class="col90" />
							<col class="col90" />
							<col class="col70" />
						</colgroup>
						<thead>
							<tr>
								<th>부서</th>
								<th>프로젝트</th>
								<th>인건비 계획</th>
								<th>판관비 계획</th>
								<th class="td_last">합계</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td class="txt_center" colspan="2">합계</td>
								<td class="txt_center"><print:currency cost="${resultSum.planLabor }" divideBy="1000"/></td>
								<td class="txt_center" ><print:currency cost="${resultSum.planExp }" divideBy="1000"/></td>
								<td class="td_last txt_center"><print:currency cost="${resultSum.planLabor + resultSum.planExp }" divideBy="1000"/></td>
							</tr>
						</tfoot>
						<tbody>
							<c:forEach items="${resultList}" var="result">
								<tr <c:if test="${result.stat == 'P'}">class="TrBg4_1"</c:if>
									<c:if test="${result.stat == 'E' || result.stat == 'S'}">class="TrBg4_2"</c:if>>
									<td class="txt_center">${result.orgnztNm }</td>
									<td class="pL10">
										<span class="txtB_grey">
											<print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}"/>
										</span>
									</td>
									<td class="txt_center">
										<a href="/management/prjPlanCostDetailList.do?searchPrjId=${result.prjId }&searchYear=${searchVO.searchYear}&
											searchMonth=${searchVO.searchMonth }&includeResult=${searchVO.includeResult}" target="_blank">
											<print:currency cost="${result.planLabor}" divideBy="1000"/>
										</a>
									</td>
									<td class="txt_center">
										<a href="/management/prjPlanCostDetailList.do?searchPrjId=${result.prjId }&searchYear=${searchVO.searchYear}&
										searchMonth=${searchVO.searchMonth }&includeResult=${searchVO.includeResult}" target="_blank">
											<print:currency cost="${result.planExp}" divideBy="1000"/>
										</a>
										
									</td>
									<td class="td_last txt_center">
										<a href="/management/prjPlanCostDetailList.do?searchPrjId=${result.prjId }&searchYear=${searchVO.searchYear}&
										searchMonth=${searchVO.searchMonth }&includeResult=${searchVO.includeResult}" target="_blank">
											<print:currency cost="${result.planLabor + result.planExp}" divideBy="1000"/>
										</a>
									</td>
								</tr>
							
							</c:forEach>
							
						</tbody>
						</table>
					</div>
					<!--// 게시판 끝  -->
					
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
