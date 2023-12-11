<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>

<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/jquery.validate.js'/>" ></script>
<validator:javascript formName="stockReleaseFrm" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javascript">
function releaseStock() {

	if (!validateStockReleaseFrm(document.stockReleaseFrm))
		return;
	
	if (setLength()) {
		document.stockReleaseFrm.action = '<c:url value="${rootPath}/support/stockRU.do" />';
		document.stockReleaseFrm.submit();
	}
}
function deleteSavedStock() {
	if (setLength()) {
		document.stockReleaseFrm.action = '<c:url value="${rootPath}/support/stockDS.do" />';
		document.stockReleaseFrm.submit();
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
	document.stockReleaseFrm.stockLength.value = checked;
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
						<li class="stitle">재고출고</li>
						<li class="navi">홈 > 경영정보 > 사업실적 > 재고출고</li>
					</ul>
				</div>
				<!-- S: section -->
				<div class="section01">
					<ul>
						<li class="th_stitle04 mB10">임시저장목록</li>
					</ul>
					<form name="stockReleaseFrm" method="POST">
					<input type="hidden" name="stockLength" value="0" />
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>재고입고</caption>
						<colgroup>
	                    	<col width="50px" />
	                    	<col width="100px" />
	                    	<col width="160px" />
	                    	<col width="100px" />
	                    	<col width="130px" />
	                    	<col width="100px" />
	                    	<col width="px" />
                    	</colgroup>
                    	<thead>
                    		<tr>
                    			<th scope="col"> </th>
                    			<th scope="col">품목</th>
                    			<th scope="col">시리얼넘버</th>
                    			<th scope="col">가격</th>
                    			<th scope="col">입고일</th>
                    			<th scope="col">입고자</th>
                    			<th scope="col">비고</th>
                    		</tr>
                    	</thead> 
	                    <tbody>
	                    	<c:forEach items="${resultList}" var="result" varStatus="c">
	                   		<tr>
	                   			<td class="txt_center"><input type="checkbox" name="stockNo" value="${result.no }" /></td>
		                    	<td class="txt_center">${result.itemName }</td>
		                    	<td class="txt_center">${result.serialNo }</td>
		                    	<td class="txt_center"><print:currency cost="${result.expense }" /></td>
		                    	<td class="txt_center"><print:date date="${result.inputDate }" /></td>
		                    	<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}" userId="${result.userId}"/></td>
		                    	<td class="txt_center">${result.note} </td>
	                    	</tr>
	                    	</c:forEach>
	                    </tbody>
	                    </table>
					</div>
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
                		<img src="../../images/btn/btn_delete.gif" onclick="javascript:deleteSavedStock();" class="cursorPointer"/>
               	    </div>
                 	<!-- 버튼 끝 -->
           		 	<!-- 출고 게시판 시작  -->
	           		<ul>
						<li class="th_stitle04 mB10" style="clear:both">출고</li>
					</ul>
					<div class="boardList04 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>재고입고</caption>
	                   <colgroup>
	                    	<col width="100px" />
	                    	<col width="px" />
                    	</colgroup>
                    	<thead>
                    		<tr>
                    			<th scope="col" colspan="2" class="tal">출고 내용을 체크하세요</th>
                    		</tr>
                    	</thead> 
	                    <tbody>
	                   		<tr>
		                    	<td class="txt_center bc01 title">목   적</td>
		                    	<td class="pL10">
		                    		<select name="status" class="span_6">
		                    			<c:forEach items="${statusList}" var="status">
		                    				<c:if test="${status.codeDc <= 2 && status.codeDc != 0}">
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
		                    	<td class="txt_center bc01 title">프로젝트</td>
		                    	<td class="pL10">
		                    		<input type="text" class="span_12" name="prjNm" id="prjNm" readonly="readonly" onclick="prjGen('prjNm','prjId',1)" onfocus="prjGen('prjNm','prjId',1)"/>
		                    		<input type="hidden" class="span_12" name="prjId" id="prjId" />
		                    		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen('prjNm','prjId',1)" />
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bc01 title">출고일</td>
		                    	<td class="pL10">
		                    		<input type="text" class="input01 span_5 calGen" name="sDate" value="${today}"/>
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bc01 title">고객사</td>
		                    	<td class="pL10">
		                    		<input id="" name="enduser" class="span_8" type="text" value=""/>
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bc01 title">판매사</td>
		                    	<td class="pL10">
		                    		<input id="" name="reseller" class="span_8" type="text" value=""/>
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bc01 title">설치장소</td>
		                    	<td class="pL10">
		                    		<input id="" name="installPlace" class="span_8" type="text" value=""/>
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
					</form>
					</div>
					<!-- // 출고 게시판 시작  -->
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
           		    	<img src="../../images/btn/btn_regist.gif" onclick="javascript:releaseStock();" class="cursorPointer"/>
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
