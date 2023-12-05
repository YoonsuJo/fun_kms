<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>

function selectSubPartPop() {
	var POP_NAME = "_PRODUCT_WRITE_RELATION_POP_";
	var target = document.fm.target;
	document.fm.method = "POST";
	document.fm.target = POP_NAME;
	document.fm.action = "/product/selectSubPartPop.do?searchType=M";

	//var popup = window.showModalDialog('/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var option = "width=800px, height=500px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	var popup = window.open("about:blank", POP_NAME, option);
	document.fm.submit();
	popup.focus();
	document.fm.target = target;
}

function modifyPartPop() {
	var POP_NAME = "_PRODUCT_MODIFY_PART_POP_";
	var target = document.fm.target;
	document.fm.method = "POST";
	document.fm.target = POP_NAME;
	document.fm.action = "/product/modifyPartPop.do";

	//var popup = window.showModalDialog('/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var option = "width=700px, height=500px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	var popup = window.open("about:blank", POP_NAME, option);
	document.fm.submit();
	popup.focus();
	document.fm.target = target;
}

function writeVersionPop() {
	var POP_NAME = "_PRODUCT_WRITE_VERSION_POP_";
	var target = document.fm.target;
	document.fm.method = "POST";
	document.fm.target = POP_NAME;
	document.fm.action = "/product/writeVersionPop.do";

	//var popup = window.showModalDialog('/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var option = "width=700px, height=800px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	var popup = window.open("about:blank", POP_NAME, option);
	document.fm.no.value = 0;
	document.fm.submit();
	popup.focus();
	document.fm.target = target;
}

function deleteSubPart(partNo, subNo, verCount) {
	
	$.ajax({
		url: "/product/deleteRelationAjax.do",
		data: {
			ownerNo: partNo,
			subNo: subNo,
			type:"M"
		},
		type: "POST",
		async: false,
		dataType: "json",
		success: function(data) {
			if (!data.RETURN.equals('OK')) {
				alert('관련모듈이 적절하게 삭제되지 못하였습니다');
				return false;
			}
			$('#trNo_' + verCount).remove();
//			location.reload();
		},
		error: function(xhr, testStatus, errorThrown) {
			alert("관련모듈이 적절하게 삭제중 에러가 발생하였습니다.");
  	 	}
	});
}

//버전 상세보기로 이동한다.
function viewPartVersion(no, versionNo) {
	document.fm.method = "POST";
	document.fm.action = "/product/viewPartVersion.do";

	document.fm.searchNo.value = no;
	document.fm.searchVersionNo.value = versionNo;
	document.fm.submit();
}

function updatePartStatus(no,partNm,useAt) {
	document.fm.no.value = no;
	
	var text = "";
	if(useAt == "Y"){
		document.fm.useAt.value = "N";
		text = partNm+"을(를) 사용안함 상태로 변경하시겠습니까?";
	}else{
		document.fm.useAt.value = "Y";
		text = partNm+"을(를) 사용 상태로 변경하시겠습니까?";
	}
	
	if(confirm(text)){
		document.fm.action = "<c:url value='${rootPath}/product/updateProductPart.do'/>";
		document.fm.submit();			
	}else{
		document.fm.useAt.value = "";
	}			
}

function sortNoUpDn(type,no,sortNo){
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
	document.fm.no.value = no;
	document.fm.method = "POST";
	document.fm.action = "<c:url value='${rootPath}/product/updateProductPartSortNo.do'/>";
	document.fm.submit();							
		
 			
}

function cancel() {
	document.fm.action = "<c:url value='${partVO.param_returnUrl}'/>";
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
						<li class="stitle">구성품 정보</li>
						<li class="navi">제품관리 > 구성품 정보</li>
					</ul>
				</div>	
				
				
				<!-- S: section -->
				<div class="section01">
				<form name="fm">
					<input type="hidden" name="partNo" id="partNo" value="${partVO.no}"/>
					<input type="hidden" name="no" id="no" value="${partVO.no}"/>
					<input type="hidden" name="partNm" id="partNm" value="${partVO.partNm}"/>
					<input type="hidden" name="useAt" id="useAt"/>
					<input type="hidden" name="sortNo" id="sortNo"/>
					<input type="hidden" name="sortNoType" id="sortNoType"/>
					<input type="hidden" name="searchNo" id="searchNo" value="${partVO.no}"/>
					<input type="hidden" name="searchVersionNo" id="searchVersionNo" value="${partVO.no}"/>
				</form>
					<p class="th_stitle">구성품 정보
						<span class="th_plus02">
						<c:if test="${user.isAdmin == 'Y' || partVO.adminNo ==  user.no || user.isProductadmin == 'Y'}"> 
							<input type="button" value="수정" class="btn_gray" onclick="javascript:modifyPartPop();"/>	
						</c:if>
						</span>
					</p>
					<div class="boardWrite02 mB20">
						<table cellpadding="0" cellspacing="0">
							<colgroup>
								<col class="col90" />
								<col width="px"/>
								<col class="col90" />
								<col width="px"/>
							</colgroup>
							<tbody>
								<tr>
									<td class="title">구성품코드</td>
									<td class="pL10">${partVO.nickName}</td>
									<td class="title">구성품명</td>
									<td class="pL10">${partVO.partNm}</td>
								</tr>
								<tr>
									<td class="title">담당자</td>
									<td class="pL10">${partVO.adminNm}</td>
									<td class="title">구분</td>
									<td class="pL10">
									<c:choose>
										<c:when test="${partVO.type == 'P'}">
											<input type="radio" name="type" disabled checked value="P">구성품(Part)
											<input type="radio" name="type" disabled value="M"> 모듈(Module)
										</c:when>
										<c:when test="${partVO.type == 'M'}">
											<input type="radio" name="type" disabled value="P">구성품(Part)
											<input type="radio" name="type" disabled checked value="M"> 모듈(Module)
										</c:when>
									</c:choose>
									</td>
								</tr>
							
								<tr>
									<td class="title">제품 설명</td>
									<td class="pL10 pT5 pB5" colspan="3">
									<print:textarea text="${partVO.partCn}"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<p class="th_stitle"> 버전 목록
						<span class="th_plus02">
						<c:if test="${user.isAdmin == 'Y' || partVO.adminNo ==  user.no || user.isProductadmin == 'Y'}"> 
							<input type="button" value="버전 등록" class="btn_gray" onclick="javascript:writeVersionPop();"/>	
						</c:if>					
						</span>
					</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" >
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
								<th >버전</th>
								<th >버젼명</th>
								<th >등록자</th>
								<th >등록일</th>
								<th >배포일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pvVOList}" var="vo" varStatus="vs">
								<tr>
									<td class="txt_center"><c:out value="${vs.count}"/></td>
									<td class="txt_center">${vo.version}</td>
									<td class="pL10"><a href="javascript:viewPartVersion('${partVO.no}', '${vo.no}');">${vo.versionName}</a></td>
									<td class="txt_center">${vo.writerName}</td>
									<td class="txt_center">${vo.regDatetime}</td>
									<td class="txt_center">${vo.publishDate}</td>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(pvVOList) == 0}">
								<tr>
									<td colspan="6" class="txt_center td_last">등록된 버전정보가 없습니다.</td>
								</tr>
							</c:if>	
						</tbody>
						</table>
					</div>

					<p class="th_stitle"> 관련(사용한) 모듈 목록
						<span class="th_plus02">
						<c:if test="${user.isAdmin == 'Y' || partVO.adminNo ==  user.no}"> 
							<input type="button" value="관련모듈 등록" class="btn_gray" onclick="javascript:selectSubPartPop();"/>	
						</c:if>					
						</span>
					</p>
					<c:set var = "totCnt" value = "${fn:length(subPartVOList)}" />
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0">
						<colgroup>
							<col class="col40"/>
							<col class="col100"/>
							<col class="col400"/>
							<col class="col60"/>
							<col class="col60"/>
							<col class="col60"/>
							<col class="col40"/>
							<col class="col20"/>
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th scope="col">단축명</th>
								<th scope="col">구성품명</th>
								<th scope="col">담당자</th>
								<th scope="col">등록일</th>
								<th scope="col">구분</th>
								<th scope="col">순서</th>
								<th scope="col"></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${subPartVOList}" var="vo" varStatus="vs">
								<tr id="trNo_${vs.count}">
									<td class="txt_center"><c:out value="${vs.count}"/></td>
									<td class="txt_center">${vo.nickName}</td>
									<td class="pL10"><a href="javascript:viewPart('${vo.no}');">${vo.partNm}</a></td>
									<td class="txt_center">${vo.adminNm}</td>
									<td class="txt_center"><fmt:formatDate value="${vo.regDt}" pattern="yy.MM.dd"/></td>
									<td class="txt_center">${vo.typeStr}</td>
									<td class="txt_center">
										<a href="javascript:sortNoUpDn('DN','${vo.no}','${vo.sortNo}');"><img src="${imagePath}/btn/btn_down.gif" alt="아래로"></a>
									</td>							
									<td class="txt_center">
										<a href="javascript:deleteSubPart('${partVO.no}', '${vo.no}', '${vs.count}');"><img src="${imagePath}/btn/btn_del.gif" alt="삭제"></a>
									</td>							
								</tr>
							</c:forEach>
							<c:if test="${fn:length(subPartVOList) == 0}">
								<tr>
									<td colspan="8" class="txt_center td_last">등록된 구성품이 없습니다.</td>
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
