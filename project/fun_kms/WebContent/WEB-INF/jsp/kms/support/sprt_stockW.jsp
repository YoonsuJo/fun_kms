<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript">
function insertStock() {
	$('#totalExpense').val(jsDeleteComma($('#totalExpense').val()));
	$('#expense').val(jsDeleteComma($('#expense').val()));
	document.frm.action = '<c:url value="${rootPath}/support/stockI.do" />';
	document.frm.submit();
}

function calculateExpense() {
	$('#expense').val(parseInt(jsDeleteComma($('#totalExpense').val()) / $('#amount').val()));
	jsMakeCurrency($('#expense').get(0));
}

$(document).ready(function() {
	$('#totalExpense').keyup(function(){
		if ($(this).val().length != 0)
			jsMakeCurrency(this);
		calculateExpense();
	});
	$('#amount').keyup(function(){
		calculateExpense();
	});
	changeCategoryNo();
});

function changeCategoryNo() {
	var tag = $('select[name=categoryNo]').val();
	$('select[name=itemNo]').val('');
	$('select[name=itemNo]').children().remove();
	$('select[name=itemNo]').append($('select[name=itemNoSample]').find('option[tag=' + tag + ']').clone());
	$($('select[name=itemNo]').find('option[tag=' + tag + ']').get(0)).attr('selected', 'selected');
}
</script>
</head>
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
						<li class="stitle">재고입고</li>
						<li class="navi">홈 > 경영정보 > 사업실적 > 재고입고</li>
					</ul>
				</div>
				<!-- S: section -->
				<div class="section01">
	           		<ul>
						<li class="th_stitle04 mB10">재고입고</li>
					</ul>
           		 	<!-- 게시판 시작  -->
					<form name="frm" method="POST">
					<input name="serialCode" type="hidden" />
					<input name="itemCode" type="hidden" />
					<div class="boardList04 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>재고입고</caption>
						<colgroup>
							<col width="100px" />
							<col width="px" />
						</colgroup>
                    	<thead>
                    		<tr>
                    			<th scope="col" colspan="2" class="tal">입고 내용을 체크하세요</th>
                    		</tr>
                    	</thead> 
	                    <tbody>
	                   		<tr>
		                    	<td class="txt_center bc01 title">입고일</td>
		                    	<td class="pL10">
		                    		<input type="text" class="input01 span_5 calGen" name="inputDate" value="${today}"/>
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bc01 title">입고자</td>
		                    	<td class="pL10">
		                    		<select name="inputUserNo" class="span_6">
		                    			<c:forEach items="${memList}" var="mem">
			                    			<option value="${mem.no}" <c:if test="${mem.no == user.no}">selected="selected"</c:if>>${mem.userNm}</option>
		                    			</c:forEach>
		                    		</select>
		                    	</td>
	                    	</tr>
	                    </tbody>
	                    </table>
					</div>
					
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>재고입고</caption>
						<colgroup>
							<col width="150px" />
							<col width="130px" />
							<col width="100px" />
							<col width="107px" />
							<col width="120px" />
							<col width="px" />
						</colgroup>
                    	<thead>
                    		<tr>
                    			<th scope="col" class="txt_center">구분</th>
                    			<th scope="col" class="txt_center">품목</th>
                    			<th scope="col" class="txt_center">수량</th>
                    			<th scope="col" class="txt_center">합계</th>
                    			<th scope="col" class="txt_center">개별단가</th>
                    			<th scope="col" class="txt_center">입고처</th>
                    		</tr>
                    	</thead> 
	                    <tbody>
	                   		<tr>
		                    	<td class="txt_center">
		                    		<select name="categoryNo" class="span_7" onchange="javascript:changeCategoryNo();">
		                    			<c:forEach items="${categoryList}" var="category" varStatus="c">
		                    			<option value="${category.no }"
			                    			<c:if test="${c.count == 1 }">
			                    				checked="checked"
			                    			</c:if>
		                    			>${category.categoryName }</option>
		                    			</c:forEach>
		                    		</select>
		                    	</td>
		                    	<td class="txt_center">
		                    		<select name="itemNoSample" class="span_6" style="display:none;">
		                    			<c:forEach items="${itemList}" var="item" varStatus="c">
		                    				<option value="${item.no }" tag="${item.categoryNo }" >${item.itemName}</option>
		                    			</c:forEach>
		                    		</select>
		                    		<select name="itemNo" class="span_6" >
		                    			<c:forEach items="${itemList}" var="item" varStatus="c">
		                    				<option value="${item.no }" tag="${item.categoryNo }" >${item.itemName}</option>
		                    			</c:forEach>
		                    		</select>
		                    	</td>
		                    	<td class="txt_center"><input id="amount" name="amount" class="span_3" type="text" value="0"/></td>
		                    	<td class="txt_center"><input id="totalExpense" name="totalExpense" class="span_4" type="text" value="0"/>원</td>
		                    	<td class="txt_center"><input id="expense" name="expense" class="span_4" type="text" value="0" readonly="readonly" />원</td>
		                    	<td class="txt_center"><input id="inputPlace" name="inputPlace" class="span_5" type="text" value=""/></td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bc01 title">비고</td>
		                    	<td class="p5" colspan="5">
		                    		<textarea style="width:530px" name="note"></textarea>
		                    	</td>
	                    	</tr>
	                    </tbody>
	                    </table>
					</div>
					</form>
					<!--// 게시판 끝  -->
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
           		    	<img src="../../images/btn/btn_regist.gif" onclick="javascript:insertStock();" class="cursorPointer"/>
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
