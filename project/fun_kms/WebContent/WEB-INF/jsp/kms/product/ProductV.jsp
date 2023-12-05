<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
// 창을 띄워 제품정보를 수정한다.
function modifyProductPop() {
	var POP_NAME = "_PRODUCT_MODIFY_PRODUCT_POP_";
	var target = document.fm.target;
	document.fm.method = "POST";
	document.fm.target = POP_NAME;
	document.fm.action = "/product/modifyProductPop.do";

	//var popup = window.showModalDialog('/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var option = "width=700px, height=500px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	var popup = window.open("about:blank", POP_NAME, option);
	document.fm.submit();
	popup.focus();
	document.fm.target = target;
}


//창을 띄워 구성품정보를 등록한다.
function writePartPop() {
	var POP_NAME = "_PRODUCT_WRITE_PART_POP_";
	var target = document.fm.target;
	document.fm.method = "POST";
	document.fm.target = POP_NAME;
	document.fm.action = "/product/writePartPop.do";

	//var popup = window.showModalDialog('/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var option = "width=700px, height=500px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	var popup = window.open("about:blank", POP_NAME, option);
	document.fm.no.value = 0;
	document.fm.submit();
	popup.focus();
	document.fm.target = target;
}

// 구성품 정보상세보기로 이동한다.
function viewPart(partNo) {
	document.fm.no.value = partNo;
	document.fm.method="POST";
	document.fm.action = "<c:url value='${rootPath}/product/viewPart.do'/>";
	document.fm.submit();
}


function updatePartStatus(partNo,partNm,useAt) {
	document.fm.no.value = partNo;
	
	var text = "";
	if(useAt == "Y"){
		document.fm.useAt.value = "N";
		text = partNm+"을(를) 사용안함 상태로 변경하시겠습니까?";
	}else{
		document.fm.useAt.value = "Y";
		text = partNm+"을(를) 사용 상태로 변경하시겠습니까?";
	}
	
	if(confirm(text)){
		document.fm.action = "<c:url value='${rootPath}/product/updatePartStatus.do'/>";
		document.fm.submit();			
	}else{
		document.fm.useAt.value = "";
	}			
}

function sortNoUpDn(type,partNo,sortNo){
	if(type == "UP" && sortNo == 1){
		alert("최상위 입니다.");
		return;
	}

	if(type == "DN" && sortNo == '${totCnt-1}'){
		alert("최하위 입니다.");
		return;
	}

	document.fm.sortNo.value = sortNo;
	document.fm.sortNoType.value = type;
	document.fm.no.value = partNo;
	document.fm.method = "POST";
	document.fm.action = "<c:url value='${rootPath}/product/updatePartSortNo.do'/>";
	document.fm.submit();							
		
 			
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
						<li class="stitle">제품정보</li>
						<li class="navi">제품관리 > 제품 정보</li>
					</ul>
				</div>	
				
				
				<!-- S: section -->
				<div class="section01">
				<form name="fm">
					<input type="hidden" name="productNo" id="productNo" value="${pVO.no}"/>
					<input type="hidden" name="no" id="no" value="${pVO.no}"/>
					<input type="hidden" name="useAt" id="useAt"/>
					<input type="hidden" name="sortNo" id="sortNo"/>
					<input type="hidden" name="sortNoType" id="sortNoType"/>
					<input type="hidden" name="param_returnUrl" id="param_returnUrl" value="/product/listProduct.do"/>				
				</form>
					<p class="th_stitle">제품 정보
						<span class="th_plus02">
						<c:if test="${user.isAdmin == 'Y' || pVO.adminNo ==  user.no || user.isProductadmin == 'Y'}"> 
							<input type="button" value="수정" class="btn_gray" onclick="javascript:modifyProductPop();"/>	
						</c:if>
						</span>
					</p>
					<div class="boardWrite02 mB20">
						<table cellpadding="0" cellspacing="0">
							<colgroup>
								<col class="col90" />
								<col width="px"/>
							</colgroup>
							<tbody>
								<tr>
									<td class="title">제품코드</td>
									<td class="pL10">${pVO.productCode}</td>
								</tr>
								<tr>
									<td class="title">제품명</td>
									<td class="pL10">${pVO.productNm}</td>
								</tr>
								<tr>
									<td class="title">관리자</td>
									<td class="pL10">${pVO.adminNm}</td>
								</tr>
							
								<tr>
									<td class="title">제품 설명</td>
									<td class="pL10 pT5 pB5">
									<!--  ${fn:replace(pVO.productCn, cn, br)} -->
									<print:textarea text="${pVO.productCn}"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<p class="th_stitle">구성품(part) 목록
						<span class="th_plus02">
						<c:if test="${user.isAdmin == 'Y' || pVO.adminNo ==  user.no || user.isProductadmin == 'Y'}"> 
							<input type="button" value="구성품 등록" class="btn_gray" onclick="javascript:writePartPop();"/>	
						</c:if>					
						</span>
					</p>
					<c:set var = "totCnt" value = "${fn:length(ppVOList)}" />
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col40"/>
							<col class="col100"/>
							<col class="col400"/>
							<col class="col60"/>
							<col class="col60"/>
							<col class="col60"/>
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th scope="col">단축명</th>
								<th scope="col">구성품명</th>
								<th scope="col">담당자</th>
								<th scope="col">등록일</th>
								<th scope="col">순서</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${ppVOList}" var="vo" varStatus="vs">
								<tr>
									<td class="txt_center"><c:out value="${vs.count}"/></td>
									<td class="txt_center">${vo.nickName}</td>
									<td class="pL10"><a href="javascript:viewPart('${vo.no}');">${vo.partNm}</a></td>
									<td class="txt_center">${vo.adminNm}</td>
									<td class="txt_center"><fmt:formatDate value="${vo.regDt}" pattern="yy.MM.dd"/></td>
									<td class="txt_center">
										<a href="javascript:sortNoUpDn('UP','${vo.no}','${vo.sortNo}');"><img src="${imagePath}/btn/btn_up.gif" alt="위로"></a>
										<a href="javascript:sortNoUpDn('DN','${vo.no}','${vo.sortNo}');"><img src="${imagePath}/btn/btn_down.gif" alt="아래로"></a>
									</td>							
								</tr>
							</c:forEach>
							<c:if test="${fn:length(ppVOList) == 0}">
								<tr>
									<td colspan="5" class="txt_center td_last">등록된 구성품이 없습니다.</td>
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
