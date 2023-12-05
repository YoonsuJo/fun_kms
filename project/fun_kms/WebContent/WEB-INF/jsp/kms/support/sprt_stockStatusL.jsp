<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>

<script type="text/javascript">
function writeItem() {
	document.frm.action = '<c:url value="${rootPath}/support/stockItemW.do" />';
	document.frm.submit();
}
function modifyItem(itemNo) {
	document.frm.itemNo.value = itemNo;
	document.frm.action = '<c:url value="${rootPath}/support/stockItemM.do" />';
	document.frm.submit();
}
function deleteCategory() {
	// document.frm.action = '<c:url value="${rootPath}/support/stockCategoryD.do" />';
	// document.frm.submit();
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
						<li class="stitle">구분관리</li>
						<li class="navi">홈 > 업무지원 > 전체현황 > 재고현황</li>
					</ul>
				</div>
				<!-- S: section -->
				<div class="section01">
					<ul>
						<li class="th_stitle04 mB10">재고현황</li>
						<c:choose>
						<c:when test="${new == 'new'}">
							<li class="th_navi04"><a href="${rootPath}/support/stockStatusL.do">구 재고현황 바로가기</a></li>
						</c:when>
						<c:otherwise>
							<li class="th_navi04"><a href="${rootPath}/support/stockL.do?type=stock">신규 재고현황 바로가기</a></li>
						</c:otherwise>
						</c:choose>
					</ul>
					<form name="frm" method="POST">
					<input type="hidden" name="itemNo" value="${result.no }" />
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>재고현황</caption>
						<colgroup>
	                    	<col width="30px" />
	                    	<col width="70px" />
	                    	<col width="px" />
	                    	<col width="60px" />
	                    	<col width="60px" />
	                    	<col width="100px" />
	                    	<col width="100px" />
	                    	<col width="30px" />
                    	</colgroup>
                    	<thead>
                    		<tr>
                    			<th scope="col"> </th>
                    			<th scope="col">구분</th>
                    			<th scope="col">품목</th>
                    			<th scope="col">임시출고</th>
                    			<th scope="col">창고재고</th>
                    			<th scope="col">평균단가</th>
                    			<th scope="col">총금액</th>
                    			<th scope="col"> </th>
                    		</tr>
                    	</thead> 
	                    <tbody>
	                    	<c:forEach items="${resultList}" var="result" varStatus="c">
	                   		<tr>
	                   			<td class="txt_center"></td>
	                   			<td class="txt_center">${result.categoryName }</td>
	                   			<td class="txt_center">
	                   				<c:choose>
									<c:when test="${new == 'new'}">
										<a href="${rootPath}/support/stockDetailList.do?type=stock&itemCode=${result.itemCode}">${result.itemName }</a>
									</c:when>
									<c:otherwise>
										<a href="${rootPath}/support/stockDetailListOld.do?type=stock&itemCode=${result.itemCode}">${result.itemName }</a>
									</c:otherwise>
									</c:choose>
	                   			</td>
	                   			<td class="txt_center">${result.count3 }</td>
	                   			<td class="txt_center">${result.count4 }</td>
	                   			<td class="txt_center"><print:currency cost="${result.avgPrice}" />원</td>
	                   			<td class="txt_center"><print:currency cost="${result.totalPrice }" />원</td>
	                   			<td class="txt_center"></td>
	                    	</tr>
	                    	</c:forEach>
	                    	<tr>
	                    		<td></td>
	                    		<td class="txt_center" colspan="5">총 재고금액</td>
	                    		<td class="txt_center"><print:currency cost="${totalAddPrice }" />원</td>
	                    		<td></td>
	                    	</tr>
	                    </tbody>
	                    </table>
					</div>
               	    </form>
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
