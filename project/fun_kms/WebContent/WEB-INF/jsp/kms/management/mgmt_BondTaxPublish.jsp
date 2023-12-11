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
function searchTaxPrj(){
	document.bondFrm.prjId.value = '';
	document.bondFrm.action = '<c:url value="${rootPath}/management/bondPrj.do" />';
	document.bondFrm.submit();
}
function popCollection(bondPrjNo){
	document.bondFrm.bondPrjNo.value = bondPrjNo;
	
	var POP_NAME = "_POP_COLLECTION_LIST_";
	var target = document.bondFrm.target;
	document.bondFrm.target = POP_NAME;
	document.bondFrm.action = '<c:url value="${rootPath}/management/collectL.do" />';

	//var popup = window.showModalDialog('${rootPath}/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var popup = window.open("about:blank", POP_NAME, "width=560px,height=570px;");
	document.bondFrm.submit();
	popup.focus();
	document.bondFrm.target = target;
}
function thisRefresh() {
	document.bondFrm.action = '<c:url value="${rootPath}/management/bondTaxPublish.do" />';
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
							<li class="stitle">세금계산서 발행내역</li>
							<li class="navi">홈 > 경영정보 > 매출관리 > 채권관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
					<form name="bondFrm" id="bondFrm" method="POST" action="">
						<input type="hidden" name="searchAllPeriod" value="${searchVO.searchAllPeriod}"/>
						<input type="hidden" name="startDate" value="${searchVO.startDate}"/>
						<input type="hidden" name="endDate" value="${searchVO.endDate}"/>
						<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
						<input type="hidden" name="searchOrgNm" id="orgNm" value="${searchVO.searchOrgNm}"/>
						<input type="hidden" name="bondPrjNo" value="0"/>
						<input type="hidden" name="prjId" value="${projectVO.prjId}"/>
						<input type="hidden" name="noColOnly" value="${searchVO.noColOnly}" />
					</form>
					
					<p class="th_stitle"><a href="${rootPath}/cooperation/selectProjectV.do?prjId=${projectVO.prjId}">[${projectVO.prjCd}] ${projectVO.prjNm}</a></p>
						
						<!-- 게시판 시작  -->
						<p class="th_plus02">
							<c:choose>
							<c:when test="${searchVO.searchAllPeriod == 'Y'}">
								기간 : 전체 / 단위 : 원
							</c:when>
							<c:otherwise>
								기간 : <print:date date="${searchVO.startDate}"/>~<print:date date="${searchVO.endDate}"/> / 단위 : 원
							</c:otherwise>
							</c:choose>
						</p>
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup>
		                    	<col class="col100" />
		                    	<col width="px" />
		                    	<col class="col100" />
		                    	<col class="col80" />
		                    	<col class="col80" />
		                    	<col class="col80" />
		                    	<col class="col80" />
	                    	</colgroup>
		                    <thead>
		                    	<tr class="height_th">
		                    		<th>발행일</th>
		                    		<th>업체명</th>
		                    		<th>발행회사</th>
		                    		<th>발행금액</th>
		                    		<th>수금액<br/>(VAT 포함)</th>
		                    		<th>미수금액<br/>(VAT 포함)</th>
		                    		<th class="td_last">수금내역</th>
		                    	</tr>
		                    </thead>
		                    <tbody>
		                    	<c:forEach items="${resultList}" var="result" varStatus="c">
		                    	<tr>
			                    	<td class="txt_center"><a href="${root}/support/taxPublishV.do?bondId=${result.bondId}"><print:date date="${result.publishDate}"/></a></td>
			                    	<td class="txt_center"><a href="${root}/support/taxPublishV.do?bondId=${result.bondId}">${result.custNm}</a> </td>
			                    	<td class="txt_center">${result.companyNm} </td>
			                    	<td class="txt_center"><a href="${root}/support/taxPublishV.do?bondId=${result.bondId}"><print:currency cost="${result.sumExpense}"/></a></td>
			                    	<td class="txt_center"><print:currency cost="${result.sumCollection}"/></td>
			                    	<td class="txt_center"><print:currency cost="${result.noCollection}"/></td>
			                    	<td class="td_last txt_center"><img src="../../images/btn/btn_collect.gif" onclick="popCollection(${result.bondPrjNo});" class="cursorPointer" /></td>
		                    	</tr>
		                    	</c:forEach>
		                    </tbody>
		                    </table>
						</div>
						<!--// 게시판 끝  -->
					
						<!-- 버튼 시작 -->
	           		    <div class="btn_area">
	                		<a href="#" onclick="searchTaxPrj();"><img src="../../images/btn/btn_list.gif"/></a>
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
