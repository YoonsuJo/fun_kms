<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>

<script type="text/javascript">
function modifyStockInfo() {
	$('.toggleClass').toggle();
}
function saveStockInfo() {
	document.frm.action = "<c:url value='${rootPath}/support/stockU.do'/>";
	document.frm.submit();
}
function cancelStockInfo() {
	$('.toggleClass').toggle();
}
function installSW() {
	var popName = "install_SW_View";
	var popup = window.open("about:blank", popName, 'top=0px, left=0px, width=500px, height=415px, ,scrollbars=yes');
	document.frm.action = "<c:url value='${rootPath}/support/installL.do'/>";
	document.frm.target = popName;
	document.frm.submit();
	popup.focus();
}
function deleteInstall(installNo) {
	document.frm.installNo.value = installNo; 
	document.frm.action = "<c:url value='${rootPath}/support/installD.do'/>";
	document.frm.submit();
}
$(document).ready(function(){
	if ('' != '${errorMessage}')
		alert('${errorMessage}');
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
						<li class="stitle">구분관리</li>
						<li class="navi">홈 > 업무지원 > 재고관리 > 상세정보</li>
					</ul>
				</div>
				<!-- S: section -->
				<div class="section01">
				<!--  제품정보 -->
					<form name="frm" method="POST">
					<input name="itemCode" value="${result.itemInfo.itemNo}" type="hidden" />
					<input name="stockNo" value="${result.stockInfo.no}" type="hidden" />
					<input name="status" value="${result.stockInfo.status}" type="hidden" />
					<input name="oldOne" value="${result.stockInfo.serialNo}" type="hidden" />
					<input name="swNo" value="${searchVO.stockNo}" type="hidden" />
					<input name="installNo" value="" type="hidden" />
					
					<p class="th_stitle04 mB10">제품정보</p>
					<div class="boardWrite02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>내역</caption>
						<colgroup>
	                    	<col width="100px" />
	                    	<col width="px" />
	                    	<col width="100px" />
	                    	<col width="px" />
	                    	<col width="100px" />
	                    	<col width="px" />
                    	</colgroup>
	                    <tbody>
	                   		<tr>
	                   			<td class="title">구분</td>
	                   			<td class="pL10">${result.itemInfo.categoryName} </td>
	                   			<td class="title">품목</td>
	                   			<td class="pL10">${result.itemInfo.itemName }</td>
	                   			<td class="title">단가</td>
	                   			<td class="pL10"><print:currency cost="${result.itemInfo.expenseAvg }" />원</td>
	                    	</tr>
	                    </tbody>
	                    </table>
					</div>
					<!--  입고정보 -->
					<p class="th_stitle04 mB10">입고정보</p>
					<div class="boardWrite02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>내역</caption>
						<colgroup>
	                    	<col width="100px" />
	                    	<col width="px" />
	                    	<col width="100px" />
	                    	<col width="px" />
	                    	<col width="100px" />
	                    	<col width="px" />
                    	</colgroup>
	                    <tbody>
	                   		<tr class="toggleClass">
	                   			<td class="title">시리얼넘버</td>
	                   			<td class="pL10">${result.stockInfo.serialNo}</td>
	                   			<td class="title">입고일</td>
	                   			<td class="pL10"><print:date date="${result.stockInfo.inputDate}"/></td>
	                   			<td class="title">입고자</td>
	                   			<td class="pL10">${result.stockInfo.userNm}</td>
	                    	</tr>
	                    	<tr class="toggleClass">
	                    		<td class="title">비고</td>
	                    		<td class="pL10" colspan="5">${result.stockInfo.note}</td>
	                    	</tr>
	                   		<tr class="toggleClass" style="display:none;">
	                   			<td class="title">시리얼넘버</td>
	                   			<td class="pL10"><input type="text" name="serialNo" class="span_6" value="${result.stockInfo.serialNo}"/></td>
	                   			<td class="title">입고일</td>
	                   			<td class="pL10"><input type="text" name="inputDate" class="span_5 calGen" value="${result.stockInfo.inputDate}"/></td>
	                   			<td class="title">입고자</td>
	                   			<td class="pL10">${result.stockInfo.userNm}</td>
	                    	</tr>
	                    	<tr class="toggleClass" style="display:none;">
	                    		<td class="title">비고</td>
	                    		<td class="pL10" colspan="5"><input type="text" name="note" value="${result.stockInfo.note}"/></td>
	                    	</tr>
	                    </tbody>
	                    </table>
					</div>
					
					<div class="btn_area">
						<div class="toggleClass">
                			<img src="../../images/btn/btn_modify.gif" onclick="javascript:modifyStockInfo();" class="cursorPointer"/>
						</div>
						<div class="toggleClass" style="display:none;">
                			<img src="../../images/btn/btn_save.gif" onclick="javascript:saveStockInfo();" class="cursorPointer"/>
                			<img src="../../images/btn/btn_cancel.gif" onclick="javascript:cancelStockInfo();" class="cursorPointer"/>
						</div>
               	    </div>
					
					<!--  입/출고내역 -->
					<p class="th_stitle04 mT20 mB10">입/출고 내역</p>
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>내역</caption>
						<colgroup>
	                    	<col width="80px" />
	                    	<col width="80px" />
	                    	<col width="50px" />
	                    	<col width="50px" />
	                    	<col width="50px" />
	                    	<col width="80px" />
	                    	<col width="80px" />
	                    	<col width="px" />
                    	</colgroup>
                    	<thead>
                    		<tr>
                    			<th scope="col">시작일</th>
                    			<th scope="col">종료일</th>
                    			<th scope="col">담당자</th>
                    			<th scope="col">판매사</th>
                    			<th scope="col">고객사</th>
                    			<th scope="col">설치장소</th>
                    			<th scope="col">목적</th>
                    			<th scope="col">비고</th>
                    		</tr>
                    	</thead> 
	                    <tbody>
	                    	<c:forEach items="${result.historyList}" var="history" varStatus="c">
	                   		<tr>
	                   			<td class="txt_center"><print:date date="${history.sDate}"/></td>
	                   			<td class="txt_center"><print:date date="${history.eDate}"/></td>
	                   			<td class="txt_center">${history.userNm}</td>
	                   			<td class="txt_center">${history.reseller}</td>
	                   			<td class="txt_center">${history.enduser}</td>
	                   			<td class="txt_center">${history.installPlace}</td>
	                   			<td class="txt_center">${history.statusNm}</td>
	                   			<td class="txt_center">${history.note}</td>
	                    	</tr>
	                    	</c:forEach>
	                    </tbody>
	                    </table>
					</div>
					
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
           		    	<c:if test="${result.itemInfo.division == 'S'}">
                		<img src="../../images/btn/btn_install.gif" onclick="javascript:installSW();" class="cursorPointer"/>
           		    	</c:if>
                		<img src="../../images/btn/btn_list.gif" onclick="javascript:history.back(-1);" class="cursorPointer"/>
               	    </div>
               	    
               	    <c:if test="${result.itemInfo.division == 'H'}">
               	    <!--  입/출고내역 -->
					<p class="th_stitle04 mT20 mB10">탑재 S/W 내역</p>
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>내역</caption>
						<colgroup>
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="80px" />
	                    	<col width="40px" />
                    	</colgroup>
                    	<thead>
                    		<tr>
                    			<th scope="col">품목</th>
                    			<th scope="col">시리얼넘버</th>
                    			<th scope="col">유형</th>
                    			<th scope="col"> </th>
                    		</tr>
                    	</thead> 
	                    <tbody>
	                    	<c:forEach items="${result.installList}" var="install" varStatus="c">
	                   		<tr>
	                   			<td class="txt_center">${install.itemName}</td>
	                   			<td class="txt_center">${install.serialNo}</td>
	                   			<td class="txt_center">${install.typNm}</td>
	                   			<td class="txt_center">
	                   				<span><img src="/images/btn/btn_minus02.gif" class="cursorPointer" onclick="javascript:deleteInstall(${install.installNo});"></span>
	                   			</td>
	                    	</tr>
	                    	</c:forEach>
	                    </tbody>
	                    </table>
					</div>
               	    </c:if>
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
