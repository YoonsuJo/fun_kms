
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
function searchList(){
	document.invcStatVOFm.pageIndex.value = 1;
	document.invcStatVOFm.action = '<c:url value="${rootPath}/fund/chckOrgSalesList.do" />';
	document.invcStatVOFm.submit();
}
function searchPSList(orgId){
	document.invcStatVOFm.pageIndex.value = 1;
	document.invcStatVOFm.orgnztId.value = orgId;
	document.invcStatVOFm.action = '<c:url value="${rootPath}/fund/chckProjectSalesCheckList.do" />';
	document.invcStatVOFm.submit();
}
function searchBCList(orgId){
	document.invcStatVOFm.pageIndex.value = 1;
	document.invcStatVOFm.orgnztId.value = orgId;
	document.invcStatVOFm.action = '<c:url value="${rootPath}/fund/chckProjectBondCheckList.do" />';
	document.invcStatVOFm.submit();
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
							<li class="stitle">채권 관리 종합 ( 매출 vs 계산서 발행 현황)</li>
							<li class="navi">매출관리 > 채권 관리 종합</li>
						</ul>
					</div> <!-- div class="path_navi" -->
	
					<span class="stxt">금액을 클릭하면 해당 부서의 프로젝트별 채권관리 상세정보 페이지로 이동합니다.</span>

					<!-- S: section -->
					<div class="section01">
						
					<form:form commandName="invcStatVOFm" id="invcStatVOFm" name="invcStatVOFm" method="post"  >
						<input type="hidden" name="pageIndex" 		id="pageIndex" value="${invcStatVO.pageIndex}"/>
						<input type="hidden" name="orgnztId" id="orgId" value=""/>
						<input type="hidden" name="searchOrgNm" id="orgNm" value=""/>
						
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<colgroup>
								<col class="col200" />
								<col class="col200" />
								<col class="col200" />
								<col class="col200" />
							</colgroup>
							<tbody>
								<tr>
									<td colspan="2">
									</td>
									<td>
										<input type="text" class="input03 w100 calGen"  readonly="readonly" name="toDate" id="toDate" value="${invcStatVO.toDate}"/>까지 매출
									</td>
									<td class="search_right">
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
		                    	<col class="col200" />
		                    	<col class="col100" />
		                    	<col class="col100" />
		                    	<col class="col100" />
		                    	<col class="col100" />
		                    	<col class="col100" />
		                    	<col class="col100" />
	                    	</colgroup>
		                    <thead>
		                    	<tr>
		                    		<th >부서</th>
		                    		<th><span class="tooltip" >계약매출액</span></th>
		                    		<th><span class="tooltip" >미발행금액</span></th>
		                    		<th><span class="tooltip" >진행매출액</span></th>
		                    		<th><span class="tooltip" >미발행금액</span></th>
		                    		<th><span class="tooltip" >계산서발행액</span></th>
		                    		<th><span class="tooltip" onmouseover="bindTooltip(this, '4688', '250');">미수금액</span></th>
		                    	</tr>
		                    </thead>
		                    <tfoot>
		                    	<tr>
			                    	<td class="txt_center">합계</td>
			                    	<td class="txt_right pR10"><print:currency cost="${rstInvcStatVOSum.contractSales}"/></td>
			                    	<td class="txt_right pR10 "><print:currency cost="${rstInvcStatVOSum.contractSales - rstInvcStatVOSum.invPrjPrice}"/></td>
			                    	<td class="txt_right pR10"><print:currency cost="${rstInvcStatVOSum.progressiveSales}"/></td>
			                    	<td class="txt_right pR10 "><print:currency cost="${rstInvcStatVOSum.progressiveSales - rstInvcStatVOSum.invPrjPrice}"/></td>
			                    	<td class="txt_right pR10"><print:currency cost="${rstInvcStatVOSum.invPrjSum}"/></td>
			                    	<td class="txt_right pR10" ><print:currency cost="${rstInvcStatVOSum.invPrjSum - rstInvcStatVOSum.invPrjCollect}"/></td>
		                    	</tr>
		                    </tfoot>
		                    <tbody>
		                    	<c:forEach items="${rstInvcStatVOList}" var="result" varStatus="c">
		                    	<tr>
		                    		<td class="txt_center">${result.orgnztName}</td>
			                    	<td class="txt_right pR10"><print:currency cost="${result.contractSales}"/></td>
			                    	<td class="txt_right pR10"><span class="txtS_bold"><a href="javascript:searchPSList('${result.orgnztId}');"><print:currency cost="${result.contractSales - result.invPrjPrice}"/></a></span></td>
			                    	<td class="txt_right pR10"><print:currency cost="${result.progressiveSales}"/></td>
			                    	<td class="txt_right pR10"><span class="txtS_bold"><a href="javascript:searchPSList('${result.orgnztId}');"><print:currency cost="${result.progressiveSales - result.invPrjPrice}"/></a></span></td>
			                    	<td class="txt_right pR10"><print:currency cost="${result.invPrjSum}"/></td>
			                    	<td class="txt_right pR10"><span class="txtS_bold"><a href="javascript:searchBCList('${result.orgnztId}');"><print:currency cost="${result.invPrjSum - result.invPrjCollect}"/></a></span></td>
		                    	</tr>
		                    	</c:forEach>
		                    </tbody>
		                    </table>
							<p class="th_plus03">* 미발행 금액이 마이너스이면 계산서를 초과발행한 것임.</p>
						</div>  <!-- class="boardList02 mB20" -->
					</div>	<!-- E: section -->
				</div>	<!-- E: center -->				
			</div>	<!-- E: centerBg -->
		</div>	<!-- E: contents -->
	</div>  <!-- E: container -->
<%@ include file="../include/footer.jsp"%>
</div> <!-- id=wrap -->
</body>
</html>
