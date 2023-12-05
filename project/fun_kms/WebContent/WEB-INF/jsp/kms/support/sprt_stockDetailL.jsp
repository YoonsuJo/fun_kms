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
function search(pageNo) {
	document.frm.pageIndex.value = pageNo;
	document.frm.submit();
}

function list(type)
{
	location.href = "${rootPath}/support/stockL.do?searchType=" + type;
}

function showDetail(stockNo)
{
	document.frm.action = '<c:url value="${rootPath}/support/stockHistoryL.do" />';
	document.frm.stockNo.value = stockNo;
	document.frm.submit();
}

function saveStock() {
	if (setLength()) {
		document.frm.action = '<c:url value="${rootPath}/support/stockS.do" />';
		document.frm.submit();
	}
}

function setLength() {
	var checked = 0;
	var list = $('input[name=saveStockNo]');
	for (var i = 0; i < list.length; i++)
	{
		if (list[i].checked == true)
			checked += 1;
	}
	if (checked == 0) {
		alert('대상 상품을 선택해주세요.');
		return false;
	}
	document.frm.stockLength.value = checked;
	return true;
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
						<li class="stitle">${mainTitle}</li>
						<li class="navi">홈 > 업무지원 > ${mainTitle} > 상세현황</li>
					</ul>
				</div>
				<!-- S: section -->
				<div class="section01">
					<ul>
						<li class="th_stitle04 mB10">${subTitle}</li>
					</ul>
					<form name="frm" method="POST" action="${rootPath}/support/stockDetailList.do" onsubmit="search(1); return false;">
					<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
					<input type="hidden" name="itemCode" value="${searchVO.itemCode}"/>
					<input type="hidden" name="type" value="${type}"/>
					<input type="hidden" name="stockNo" value="0"/>
					<input type="hidden" name="stockLength" value="0"/>
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>상세내역</caption>
						<colgroup>
	                    	<col width="20px" />
	                    	<col width="40px" />
	                    	<col width="80px" />
	                    	<col width="120px" />
	                    	<col width="75px" />
	                    	<col width="75px" />
	                    	<col width="60px" />
	                    	<col width="170px" />
	                    	<col width="40px" />
	                    	<col width="px" />
                    	</colgroup>
                    	<thead>
                    		<tr>
                    			<th scope="col"> </th>
                    			<th scope="col">분류</th>
                    			<th scope="col">품목</th>
                    			<th scope="col">시리얼넘버</th>
                    			<th scope="col">입고일</th>
                    			<th scope="col">출고일</th>
                    			<th scope="col">ENDUSER</th>
                    			<th scope="col">옵션</th>
                    			<th scope="col">상태</th>
                    			<th scope="col">비고</th>
                    		</tr>
                    	</thead> 
	                    <tbody>
	                    	<c:forEach items="${resultList}" var="result" varStatus="c">
	                   		<tr>
	                   			<td class="txt_center"><c:if test="${(result.status == 0 || result.status == 5) && result.tempSaverNo == -1}"><input type="checkbox" name="saveStockNo" value="${result.stockNo }" /></c:if></td>
	                   			<td class="txt_center">${result.type}</td>
	                   			<td class="txt_center">${result.itemName}</td>
	                   			<td class="txt_center"><a href="javascript:showDetail('${result.stockNo}');">${result.serialNo}</a></td>
	                   			<td class="txt_center">${result.inputDate}</td>
	                   			<td class="txt_center">${result.outputDate}</td>
	                   			<td class="txt_center">${result.endUser}</td>
	                   			<td class="txt_center">
	                   				<c:if test="${result.swNm1 != null}">${result.swNm1}:${result.swSerialNo1}<br/></c:if>
	                   				<c:if test="${result.swNm2 != null}">${result.swNm2}:${result.swSerialNo2}<br/></c:if>
	                   				<c:if test="${result.swNm3 != null}">${result.swNm3}:${result.swSerialNo3}<br/></c:if>
	                   				<c:if test="${result.swNm4 != null}">${result.swNm4}:${result.swSerialNo4}<br/></c:if>
	                   			</td>
	                   			<td class="txt_center">${result.statusNm}</td>
	                   			<td class="txt_center"><div style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;">${result.note}</div></td>
	                    	</tr>
	                    	</c:forEach>
	                    </tbody>
	                    </table>
					</div>
					</form>
					
					<div class="paginate">
	                	<ui:pagination paginationInfo="${paginationInfo}" jsFunction="search" type="image"/>
					</div>
           		</div>
           		<div class="btn_area02">
	           		<ul>
		           		<li class="right">
		           			<a href="javascript:saveStock();">
		           				<img src="/images/btn/btn_save.gif">
		           			</a>
		           			<a href="javascript:list('${type}');">
		           				<img src="/images/btn/btn_list.gif">
		           			</a>
		           		</li>
	           		</ul>
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
