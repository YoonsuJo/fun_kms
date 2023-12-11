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
function searchStock() {
	document.frm.action = '<c:url value="${rootPath}/support/stockC.do" />';
	document.frm.submit();
}
function changeStock() {
	if (setLength()) {
		document.frm.action = '<c:url value="${rootPath}/support/stockCU.do" />';
		document.frm.submit();
	}
}
function setLength() {
	var checked = 0;
	var list = $('input[name=stockNo]');
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
						<li class="stitle">재고변동</li>
						<li class="navi">홈 > 경영정보 > 사업실적 > 재고변동</li>
					</ul>
				</div>
				<!-- S: section -->
				<div class="section01">
					<ul>
						<li class="th_stitle04 mB10">프로젝트 관련 재고 목록</li>
					</ul>
					<!-- 상단 검색창 시작 -->
			   		<form name="frm" method="POST">
			   		<input type="hidden" name="stockLength" value="0" />
			   		<input type="hidden" name="searchType" value="Y" />
					<fieldset>
					<legend>상단 검색</legend>
	                    <div class="scheduleDate2 mB20">
	                		<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>검색</caption>
		                   	<colgroup>
		                    	<col width="200px" />
		                    	<col width="205px" />
		                    	<col width="200px" />
		                    	<col width="px" />
	                    	</colgroup>
	                    	<thead>
	                    		<tr>
	                    			<th scope="col" colspan="2" class="txt_center pL5 pB5">프로젝트&nbsp;
		                    			<input type="text" style="width:250px" name="prjNm" id="prjNm" readonly="readonly" onclick="prjGen('prjNm','prjId',1)"
		                    			onfocus="prjGen('prjNm','prjId',1)" value="${searchVO.prjNm}" />
			                    		<input type="hidden" class="span_12" name="searchPrjId" id="prjId" value="${searchVO.searchPrjId}" />
			                    		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen('prjNm','prjId',1)" />
	                    			</th>
	                    			<td scope="col">입고자 <input id="" name="searchUserName" class="span_7 userNameAutoHead" type="text" value="${searchVO.searchUserName}"/></td>
	                    			<th scope="col"></th>
	                    		</tr>
	                    	</thead> 
		                    <tbody>
		                   		<tr>
			                    	<td class="txt_center">구분
			                    		<select name="searchCategoryNo" class="span_5">
			                    		<option value="">전체보기</option>
		                    			<c:forEach items="${categoryList}" var="category" varStatus="c">
		                    			<option value="${category.no }"
			                    			<c:if test="${category.no == searchVO.searchCategoryNo }">
			                    				checked="checked"
			                    			</c:if>
		                    			>${category.categoryName }</option>
		                    			</c:forEach>
		                    		</select>
			                    	</td>
			                    	<td class="txt_center">품목
			                    		<select name="searchItemNo" class="span_7">
			                    		<option value="">전체보기</option>
		                    			<c:forEach items="${itemList}" var="item" varStatus="c">
		                    			<option value="${item.no }"
		                    				<c:if test="${item.no == searchVO.searchItemNo }">
			                    				checked="checked"
			                    			</c:if>
		                    			>${item.itemName}</option>
		                    			</c:forEach>
		                    		</select>
			                    	</td>
			                    	<td>변동일
			                    		<input type="text" class="input01 span_7 calGen" name="searchInputDate" value="${searchVO.searchInputDate}"/>
			                    	</td>
			                    	<td><input type="image" src="/images/btn/btn_search02.gif" alt="검색" onclick="javascript:searchStock();"/></td>
		                    	</tr>
		                    </tbody>
		                    </table>
	                		
						</div>
	                </fieldset>
	            	<!--// 상단 검색창 끝 -->
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>재고입고</caption>
	                   <colgroup>
	                    	<col width="20px" />
	                    	<col width="40px" />
	                    	<col width="120px" />
	                    	<col width="150px" />
	                    	<col width="70px" />
	                    	<col width="50px" />
	                    	<col width="50px" />
	                    	<col width="60px" />
	                    	<col width="px" />
                    	</colgroup>
                    	<thead>
                    		<tr>
                    			<th scope="col"> </th>
                    			<th scope="col">상태</th>
                    			<th scope="col">품목</th>
                    			<th scope="col">시리얼넘버</th>
                    			<th scope="col">가격</th>
                    			<th scope="col">입고자</th>
                    			<th scope="col">출고자</th>
                    			<th scope="col">출고일</th>
                    			<th scope="col">비고</th>
                    		</tr>
                    	</thead> 
	                    <tbody>
	                    	<c:forEach items="${stockList}" var="stock" varStatus="c">
	                   		<tr>
	                   			<td class="txt_center"><input type="checkbox" name="stockNo" value="${stock.no }" /></td>
	                   			<td class="txt_center">${stock.statusNm }</td>
		                    	<td class="txt_center">${stock.itemName }</td>
		                    	<td class="txt_center">${stock.serialNo }</td>
		                    	<td class="txt_center"><print:currency cost="${stock.expense}" /></td>
		                    	<td class="txt_center"><print:user userNo="${stock.userNo}" userNm="${stock.userNm}" userId="${stock.userId}"/></td>
		                    	<td class="txt_center"><print:user userNo="${stock.releaseUserNo}" userNm="${stock.releaseUserNm}" userId="${stock.releaseUserId}"/></td>
		                    	<td class="txt_center"><print:date date="${stock.releaseDate }" /></td>
		                    	<td class="txt_center">${stock.releaseNote }</td>
	                    	</tr>
	                    	</c:forEach>
	                    </tbody>
	                    </table>
					</div>
           		 	<!-- 출고 게시판 시작  -->
	           		<ul>
						<li class="th_stitle04 mB10" style="clear:both">변동</li>
					</ul>
					<div class="boardList04 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>변동</caption>
	                   	<colgroup>
	                    	<col width="100px" />
	                    	<col width="px" />
                    	</colgroup>
                    	<thead>
                    		<tr>
                    			<th scope="col" colspan="2">변동 내용을 체크하세요</th>
                    		</tr>
                    	</thead> 
	                    <tbody>
	                   		<tr>
		                    	<td class="txt_center bc01 title">목   적</td>
		                    	<td class="pL10">
		                    		<select name="status" class="span_6">
		                    			<c:forEach items="${statusList}" var="status">
		                    				<c:if test="${status.codeDc >= 2}">
			                    			<option value="${status.code}">${status.codeNm}</option>
		                    				</c:if>
		                    			</c:forEach>
		                    		</select>
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bc01 title">출 고 자</td>
		                    	<td class="pL10">
		                    		<select name="userNo" class="span_6">
		                    			<c:forEach items="${memList}" var="mem">
			                    			<option value="${mem.no}" <c:if test="${mem.no == user.no}">selected="selected"</c:if>>${mem.userNm}</option>
		                    			</c:forEach>
		                    		</select>
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bc01 title">변동일</td>
		                    	<td class="pL10">
		                    		<input type="text" class="input01 span_7 calGen" name="sDate" value="${today }"/>
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bc01 title">비고</td>
		                    	<td class="p5">
		                    		<textarea style="width:530px" name="note"></textarea>
		                    	</td>
	                    	</tr>
	                    </tbody>
	                    </table>
					</div>
					</form>
					<!-- // 출고 게시판 시작  -->
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
           		    	<img src="../../images/btn/btn_regist.gif" onclick="javascript:changeStock();" class="cursorPointer"/>
                		<img src="../../images/btn/btn_cancel.gif" onclick="javascript:history.back();" class="cursorPointer"/>
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
