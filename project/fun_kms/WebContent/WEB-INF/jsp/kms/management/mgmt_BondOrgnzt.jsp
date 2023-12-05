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
function searchTax(){
	document.bondFrm.action = '<c:url value="${rootPath}/management/bondOrg.do" />';
	document.bondFrm.submit();
}
function searchTaxPrj(orgId, orgNm){
	document.bondFrm.searchOrgId.value = orgId;
	document.bondFrm.searchOrgNm.value = orgNm;
	document.bondFrm.action = '<c:url value="${rootPath}/management/bondPrj.do" />';
	document.bondFrm.submit();
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
							<li class="stitle">채권관리</li>
							<li class="navi">홈 > 경영정보 > 매출관리 > 채권관리</li>
						</ul>
					</div>
	
					<span class="stxt">금액을 클릭하면 해당 부서의 프로젝트별 채권관리 상세정보 페이지로 이동합니다.</span>

					<!-- S: section -->
					<div class="section01">
						
						<form name="bondFrm" id="bondFrm" method="POST" action="">
						<input type="hidden" name="searchOrgId" id="orgId" value=""/>
						<input type="hidden" name="searchOrgNm" id="orgNm" value=""/>
						
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<tbody>
								<tr>
									<td>
										<input type="text" class="input01 span_4 calGen" name="startDate" value="${searchVO.startDate}"/> ~ <input type="text" class="input01 span_4 calGen" name="endDate" value="${searchVO.endDate}"/><span class="T11"> (세금계산서 발행일 기준)</span>
									</td>
									<td class="search_right">
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
		                    	<col width="px" />
		                    	<col class="col100" />
		                    	<col class="col100" />
		                    	<col class="col100" />
		                    	<col class="col100" />
		                    	<col class="col100" />
		                    	<col class="col100" />
	                    	</colgroup>
		                    <thead>
		                    	<tr>
		                    		<th rowspan="2">부서</th>
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
		                    <tfoot>
		                    	<tr>
			                    	<td class="txt_center">합계</td>
			                    	<td class="txt_center"><print:currency cost="${resultSum.sumExpense}"/></td>
			                    	<td class="txt_center"><print:currency cost="${resultSum.noPublish}"/></td>
			                    	<td class="txt_center"><print:currency cost="${resultSum.sumCollection}"/></td>
			                    	<td class="txt_center"><print:currency cost="${resultSum.noCollection}"/></td>
			                    	<td class="txt_center"><print:currency cost="${resultSum.accNoPublish}"/></td>
			                    	<td class="td_last txt_center"><print:currency cost="${resultSum.accNoCollection}"/></td>
		                    	</tr>
		                    </tfoot>
		                    <tbody>
		                    	<c:forEach items="${resultList}" var="result" varStatus="c">
		                    	<tr>
<!--		                    		부서-->
			                    	<td class="txt_center">${result.orgnztNm} </td>
<!--			                    	계산서 발행금액-->
			                    	<td class="txt_center"><a href="javascript:searchTaxPrj('${result.orgnztId}', '${result.orgnztNm}');"><print:currency cost="${result.sumExpense}"/>
<!--			                    	계산서 미발행금액-->
			                    	<td class="txt_center"><a href="javascript:searchTaxPrj('${result.orgnztId}', '${result.orgnztNm}');"><print:currency cost="${result.noPublish}"/></a></td>
<!--			                    	수금액 (VAT 포함)-->
			                    	<td class="txt_center">
			                    		<a href="javascript:searchTaxPrj('${result.orgnztId}', '${result.orgnztNm}');">
				                    		<span <c:if test="${result.noPublish < 0}">class="txt_blue"</c:if>>
			                    				<print:currency cost="${result.sumCollection}"/>
			                    			</span>
			                    		</a>
			                    	</td>
<!--			                    	미수금액(VAT 포함)-->
			                    	<td class="txt_center bG04">
				                    	<a href="javascript:searchTaxPrj('${result.orgnztId}', '${result.orgnztNm}');">
				                    		<span <c:if test="${0 < result.noCollection}">class="txt_red"</c:if><c:if test="${result.noCollection < 0}">class="txt_blue"</c:if>>
					                    		<print:currency cost="${result.noCollection}"/>
					                    	</span>
				                    	</a>
			                    	</td>
<!--			                    	계산서 미발행금액-->
			                    	<td class="txt_center">
			                    		<a href="javascript:searchTaxPrj('${result.orgnztId}', '${result.orgnztNm}');">
				                    		<span <c:if test="${result.accNoPublish < 0}">class="txt_blue"</c:if>>
			                    				<print:currency cost="${result.accNoPublish}"/>
			                    			</span>
			                    		</a>
			                    	</td>
<!--			                    	미수금액(VAT 포함)-->
			                    	<td class="td_last txt_center bG04">
				                    	<a href="javascript:searchTaxPrj('${result.orgnztId}', '${result.orgnztNm}');">
			                    			<span <c:if test="${0 < result.accNoCollection}">class="txt_red"</c:if><c:if test="${result.noCollection < 0}">class="txt_blue"</c:if>>
				                    			<print:currency cost="${result.accNoCollection}"/>
				                    		</span>
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
