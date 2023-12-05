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
						<li class="stitle">전체현황</li>
						<li class="navi">홈 > 업무지원 > 재고현황 > 전체현황</li>
					</ul>
				</div>
				<!-- S: section -->
				<div class="section01">
					<ul>
						<li class="th_stitle04 mB10">하드웨어</li>
						<c:choose>
						<c:when test="${new == 'new'}">
							<li class="th_navi04"><a href="${rootPath}/support/stockStateTotalL.do">구 전체현황 바로가기</a></li>
						</c:when>
						<c:otherwise>
							<li class="th_navi04"><a href="${rootPath}/support/stockL.do?type=all">신규 재고현황 바로가기</a></li>
						</c:otherwise>
						</c:choose>
					</ul>
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>재고입고</caption>
						<colgroup>
	                    	<col width="70px" />
	                    	<col width="px" />
	                    	<col width="70px" />
	                    	<col width="100px" />
	                    	<col width="70px" />
	                    	<col width="70px" />
	                    	<col width="70px" />
	                    	<col width="70px" />
                    	</colgroup>
                    	<thead>
                    		<tr>
                    			<th scope="col">구분</th>
                    			<th scope="col">품목</th>
                    			<th scope="col">평균단가</th>
                    			<th scope="col">구매</th>
                    			<th scope="col">판매</th>
                    			<th scope="col">임시출고</th>
                    			<th scope="col">창고재고</th>
                    			<th scope="col">재산재고</th>
                    		</tr>
                    	</thead> 
	                    <tbody>
	                    	<c:forEach items="${hardware}" var="hardware" varStatus="c">
	                   		<tr>
	                   			<td class="txt_center">${hardware.categoryName}</td>
	                   			<td class="txt_center">
	                   				<c:choose>
									<c:when test="${new == 'new'}">
		                   				<a href="${rootPath}/support/stockDetailList.do?type=all&itemCode=${hardware.itemCode}">${hardware.itemName}</a>
									</c:when>
									<c:otherwise>
										<a href="${rootPath}/support/stockDetailListOld.do?type=all&itemCode=${hardware.itemCode}">${hardware.itemName }</a>
									</c:otherwise>
									</c:choose>
	                   			</td>
	                   			<td class="txt_center"><print:currency cost="${hardware.avgPrice}" /></td>
	                   			<td class="txt_center"><print:currency cost="${hardware.count1}" /></td>
	                   			<td class="txt_center"><print:currency cost="${hardware.count2}" /></td>
	                   			<td class="txt_center"><print:currency cost="${hardware.count3}" /></td>
	                   			<td class="txt_center"><print:currency cost="${hardware.count4}" /></td>
	                   			<td class="txt_center"><print:currency cost="${hardware.count5}" /></td>
	                    	</tr>
	                    	</c:forEach>
	                    </tbody>
	                    </table>
					</div>
           		</div>   
				<div class="btn_area"></div>
				<div class="section01">
					<ul>
						<li class="th_stitle04 mB10">소프트웨어</li>
					</ul>
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>재고입고</caption>
						<colgroup>
	                    	<col width="70px" />
	                    	<col width="px" />
	                    	<col width="70px" />
	                    	<col width="100px" />
	                    	<col width="70px" />
	                    	<col width="70px" />
	                    	<col width="70px" />
	                    	<col width="70px" />
                    	</colgroup>
                    	<thead>
                    		<tr>
                    			<th scope="col">구분</th>
                    			<th scope="col">품목</th>
                    			<th scope="col">평균단가</th>
                    			<th scope="col">구매</th>
                    			<th scope="col">판매</th>
                    			<th scope="col">임시출고</th>
                    			<th scope="col">창고재고</th>
                    			<th scope="col">재산재고</th>
                    		</tr>
                    	</thead> 
	                    <tbody>
	                    	<c:forEach items="${software}" var="software" varStatus="c">
	                   		<tr>
	                   			<td class="txt_center">${software.categoryName}</td>
	                   			<td class="txt_center"><a href="${rootPath}/support/stockDetailList.do?type=all&itemCode=${software.itemCode}">${software.itemName}</a></td>
	                   			<td class="txt_center"><print:currency cost="${software.avgPrice}" /></td>
	                   			<td class="txt_center"><print:currency cost="${software.count1}" /></td>
	                   			<td class="txt_center"><print:currency cost="${software.count2}" /></td>
	                   			<td class="txt_center"><print:currency cost="${software.count3}" /></td>
	                   			<td class="txt_center"><print:currency cost="${software.count4}" /></td>
	                   			<td class="txt_center"><print:currency cost="${software.count5}" /></td>
	                    	</tr>
	                    	</c:forEach>
	                    </tbody>
	                    </table>
					</div>
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
