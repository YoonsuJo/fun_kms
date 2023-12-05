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
						<li class="navi">홈 > 업무지원 > 재고관리 > 관리 > 구분관리</li>
					</ul>
				</div>
				<!-- S: section -->
				<div class="section01">
					<ul>
						<li class="th_stitle04 mB10">구분관리</li>
					</ul>
					<form name="frm" method="POST">
					<input type="hidden" name="itemNo" value="${result.no }" />
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>재고입고</caption>
						<colgroup>
	                    	<col width="50px" />
	                    	<col width="70px" />
	                    	<col width="100px" />
	                    	<col width="px" />
	                    	<col width="50px" />
	                    	<col width="50px" />
                    	</colgroup>
                    	<thead>
                    		<tr>
                    			<th scope="col"> </th>
                    			<th scope="col">구분</th>
                    			<th scope="col">품목명</th>
                    			<th scope="col">설명</th>
                    			<th scope="col">단가</th>
                    			<th scope="col"> </th>
                    		</tr>
                    	</thead> 
	                    <tbody>
	                    	<c:forEach items="${resultList}" var="result" varStatus="c">
	                   		<tr>
	                   			<td class="txt_center">${c.count }</td>
	                   			<td class="txt_center">${result.categoryName }</td>
	                   			<td class="txt_center">${result.itemName }</td>
	                   			<td class="txt_center">${result.note }</td>
	                   			<td class="txt_center"><print:currency cost="${result.price }" /></td>
	                   			<td class="txt_center">
	                   				<span><img src="/images/btn/btn_plus02.gif" class="cursorPointer" onclick="javascript:modifyItem(${result.no });"></span>
		                    		<!-- <span><img src="/images/btn/btn_minus02.gif" class="cursorPointer" onclick="javascript:modifyCategory(${result.no });"></span> -->
	                   			</td>
	                    	</tr>
	                    	</c:forEach>
	                    </tbody>
	                    </table>
					</div>
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
                		<img src="../../images/btn/btn_regist.gif" onclick="javascript:writeItem();" class="cursorPointer"/>
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
