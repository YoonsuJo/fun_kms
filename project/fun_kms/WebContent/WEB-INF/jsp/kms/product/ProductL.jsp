<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function writeProduct() {
	var POP_NAME = "_PRODUCT_WRITE_PRODUCT_POP_";
	var target = document.fm.target;
	document.fm.method = "POST";
	document.fm.target = POP_NAME;
	document.fm.action = "/product/writeProductPop.do";

	//var popup = window.showModalDialog('/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var option = "width=700px, height=500px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	var popup = window.open("about:blank", POP_NAME, option);
	document.fm.submit();
	popup.focus();
	document.fm.target = target;
}

function viewProduct(no) {
	document.fm.no.value = no.toString();
	document.fm.method = "POST";
	document.fm.action = "<c:url value='${rootPath}/product/viewProduct.do'/>";
	document.fm.submit();
}

function updateStatus(no,productNm,useAt) {
	document.fm.no.value = no;
	
	var text = "";
	if(useAt == "Y"){
		document.fm.useAt.value = "N";
		text = productNm+"을(를) 사용안함 상태로 변경하시겠습니까?";
	}else{
		document.fm.useAt.value = "Y";
		text = productNm+"을(를) 사용 상태로 변경하시겠습니까?";
	}
	
	if(confirm(text)){
		document.fm.method = "POST";
		document.fm.action = "<c:url value='${rootPath}/product/updateProduct.do'/>";
		document.fm.submit();			
	} else {
		document.fm.useAt.value = "";
	}			
}


function sortNoUpDn(type,no,sortNo){
		if(type == "UP" && sortNo == 1){
			alert("최상위 입니다.");
			return;
		}

		if(type == "DN" && sortNo == '${totCnt}'){
			alert("최하위 입니다.");
			return;
		}

		document.fm.sortNo.value = sortNo;
		document.fm.sortNoType.value = type;
		document.fm.no.value = no;
		document.fm.method = "POST";
		document.fm.action = "<c:url value='${rootPath}/product/updateProductSortNo.do'/>";
		document.fm.submit();							
			
	 		    
}

function testGen(inputTxtObj){
	if(typeof(inputTxtObj)=='object')
		inputTxtObj = $(inputTxtObj);
	else
		inputTxtObj = $('#'+ inputTxtObj);
	
	var position = inputTxtObj.offset();
	
	var left = position.left ;
	var top = position.top + 5 ;
	var width = 200;
	if($('.mouseOver_testGen').length>0)
	{
		$('.mouseOver_testGen').remove();
	}
	var layer = $('<div class="mouseOver_testGen"></div>');
	layer.appendTo('body');
	layer.css("left", left-20 +"px");
	layer.css("top", top+15 +"px");
	layer.css("width", width +"px");
	$('<table cellpadding="0" cellspacing="0" id="_testGenTable">').appendTo($('.mouseOver_testGen'));
	$('<tbody id="_testGenTbody"></tbody>').appendTo($('#_testGenTable'));
	$('<tr id="_testGenTr_0"></tr>').appendTo($('#_testGenTbody'));
	$('<td>test</td>').appandTo($('#_testGenTr_0'));
}

function statusGen(inputTxtObj, startNum, endNum, rowCnt){
	
	if(typeof(inputTxtObj)=='object')
		inputTxtObj = $(inputTxtObj);
	else
		inputTxtObj = $('#'+ inputTxtObj);
	
	var position = inputTxtObj.offset();

	var left = position.left ;
	var top = position.top + 5 ;
	var width = 200;
	if($('.mouseOver_statusGen').length>0)
	{
		$('.mouseOver_statusGen').remove();
	}

	var layer = $('<div class="mouseOver_statusGen"></div>');
	layer.appendTo('body');
	layer.css("left", left-20 +"px");
	layer.css("top", top+15 +"px");
	layer.css("width", width +"px");
	$('<table cellpadding="0" cellspacing="0" id="_statusGenTable">').appendTo($('.mouseOver_statusGen'));
	$('<tbody id="_statusGenTbody"></tbody>').appendTo($('#_statusGenTable'));

	var row = 0;
	var column = 0;

	for(var i=startNum; i <= endNum; i++){
		if (column == 0) {
			row++;
			$('<tr id="_statusGenTr' + row + '"></tr>').appendTo($('#_statusGenTbody'));
		}
		
		var td = $('<td>'+ i +'</td>');
		td.bind('click.numGen',function(){
			inputTxtObj.val($(this).html());
			$('body').unbind('click.numGen');
			layer.remove();
		});
		td.addClass('cursorPointer');
		td.appendTo($('#_numGenTr' + row));
		
		if (column == 4) column = 0;
		else column++;
	}
	console.log(layer.html());

	$('body').bind('click', function numGenLayerClickEvent(event){
			if (!$(event.target).closest(layer).length && event.target !== inputTxtObj.get(0)) {
						$('body').unbind('click.numGen');
						layer.remove();
				};
		}
	);
	/*
	function numGenLayerClickEvent(event){
		alert("why");
		if (!$(event.target).closest(layer).length) {
			alert("why2");
					layer.remove();
					$('body').unbind(numGenLayerClickEvent);
			};
	}
	*/
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
							<li class="stitle">제품 관리</li>
							<li class="navi">홈 > 상품관리 > 제품관리 > ${vo.productNm}</li>
						</ul>
					</div>
	
				<!-- S: section -->
				<div class="section01">
					<p class="th_stitle">제품 목록
						<span class="th_plus02">
							<input type="button" value="제품 등록" class="btn_gray" onclick="javascript:writeProduct();"/>	
						</span>
					</p>
			    	<!-- 상단 검색창 시작 -->
			    	<form name="fm">
			    	
			    	<input type="hidden" name="sortNo" id="sortNo"/>
			    	<input type="hidden" name="sortNoType" id="sortNoType"/>
			    	
			    	<input type="hidden" name="useAt" id="useAt"/>
			    	<input type="hidden" name="no" id="no" value="0"/>
					<input type="hidden" name="param_returnUrl" id="param_returnUrl" value="<c:url value='/product/selectProductInfoList.do'/>"/>
					
			    	</form>
                	<!-- 상단 검색창 끝 -->
					
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col100" />
							<col class="col300" />
							<col class="col100" />
							<col class="col100" />
							<col class="col100" />
							<col class="col100" />
							<col class="col100" />
						</colgroup>
						<thead>
							<tr>
							<th>제품코드</th>
							<th>제품명</th>
							<th>등록자</th>
							<th>등록일</th>
							<th>관리자</th>
							<th>수정일</th>
							<th>순서</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pVOList}" var="vo" varStatus="c">
								<tr>
									<td class="txt_center">${vo.productCode}</a></td>
									<td class="txt_center"><a href="javascript:viewProduct('${vo.no}');">${vo.productNm}</a></td>
									<td class="txt_center">${vo.writerNm}</td>
									<td class="txt_center"><fmt:formatDate value="${vo.regDt}" pattern="yy.MM.dd"/></td>
									<td class="txt_center">${vo.adminNm}</td>
									<td class="txt_center"><fmt:formatDate value="${vo.modDt}" pattern="yy.MM.dd"/></td>
									<td class="txt_center">
									<a href="javascript:sortNoUpDn('UP','${vo.no}','${vo.sortNo}');"><img src="${imagePath}/btn/btn_up.gif"  border="0" alt="위로"></a>
									<a href="javascript:sortNoUpDn('DN','${vo.no}','${vo.sortNo}');"><img src="${imagePath}/btn/btn_down.gif" border="0" alt="아래로"></a>
									</td>							
								</tr>
							</c:forEach>
							<c:if test="${empty pVOList}">
								<tr>
									<td class="txt_center td_last" colspan="7">등록된 제품이 없습니다.</td>
								</tr>										
							</c:if>	
							
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
