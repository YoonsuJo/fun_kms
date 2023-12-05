<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="bondCollect" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='${commonPath}/js/jquery.validate.js'/>" ></script>

<script>

var g_totalSum;
var g_totalCollect;

$(document).ready(function() {
});

function deleteCollect() {
	var invoiceId = $('#invoiceId').val();
	
	$.ajax({
		url: "/fund/deleteCollectAjax.do",
		data: {
			invoiceId: invoiceId
		},
		type: "POST",
		async: false,
		dataType: "json",
		success: function(data) {
			// 수행 프로젝트가 아닐 경우, 오류메시지
			if (!data.RETURN.equals('OK')) {
				alert('수금정보가 적절하게 삭제되지 못하였습니다');
				return false;
			}
			location.reload();
		},
		error: function(xhr, testStatus, errorThrown) {
			alert("프로젝트에 대한 데이터를 가져오는데 실패하였습니다.");
  	 	}
	});
}

function popClose(){
	opener.location.reload();
	this.close();
}
</script>
<body>
<div id="pop_reg_div01">
 	<div id="pop_top">
		<ul>
			<li><img src="../images/inc/pop_bullet.gif" /></li>
			<li class="popTitle">수금현황보기</li>
		</ul>
 	</div>
 	<div class="pop_reg_div02">
 	<form:form commandName="invoiceVOFm" id="invoiceVOFm" name="invoiceVOFm" method="post" >
		<input type="hidden" name="invoiceId" id="invoiceId" value="${invoiceVO.invoiceId}" />
		<input type="hidden" id="rstProjectListCnt" value="${fn:length(rstProjectList)}" />
		<input type="hidden" id="rstCollectCnt" value="${fn:length(rstCollectList)}" />

		<div class="pop_board mT20" >
		<p class="th_stitle">세금계산서 정보</p>
 		<table cellpadding="0" cellspacing="0">
 			<colgroup>
 				<col class="col100" />
 				<col class="col100" />
 				<col class="col100" />
 				<col class="col100" />
 				<col class="col100" />
 				<col class="col100" />
 			</colgroup>
 			<tbody>
 				<tr>
 					<td class="title" >제  목</td>
 					<td class="pL10" colspan="5">${invoiceVO.title}</td>
 				</tr>
 				<tr>
 					<td class="title" >고객사</td>
 					<td class="pL10" colspan="3">${invoiceVO.custCompanyName}</td>
 					<td class="title" >대표자</td>
 					<td class="pL10">${invoiceVO.custCeoName}</td>
 				</tr>
 				<tr>
 					<td class="title" >발행일</td>
 					<td class="pL10 ">${invoiceVO.publishDatetime}</td>
 					<td class="title" >발행금액</td>
 					<td class="pL10" align="center"  id="totalSum"><print:currency cost='${invoiceVO.totalSum}' /></td>
 					<td class="title" >미수금액</td>
 					<td class="pL10" align="center" >
 						<input type="text" class="input02 span_5 currency" readonly="readonly" id="unCollectSum" 
 						value="<print:currency cost='${invoiceVO.totalSum - invoiceVO.totalCollect}' />" />
 					</td>
 				</tr>
 				</tr>
			</tbody>
		</table>
		</div>  <!--  class="pop_board mT20"  -->

		<div class="pop_board mT20" >
		<p class="th_stitle">기수금 정보</p>
 		<table cellpadding="0" cellspacing="0">
 			<colgroup>
 				<col class="col20" />
 				<col class="col60" />
 				<col class="col80" />
 				
 				<col class="col60" />
 				<col class="col100" />
 				
 				<col class="col60" />
 				<col class="col60" />
 				<col class="col60" />
 				<col class="col300" />
 			</colgroup>
 			<tbody>
			<c:forEach items="${rstCollectList}" var="collect" varStatus="c">
 				<tr>
 					<td class="title">${c.count}</td>
 					<td class="title" >수금일</td>
 					<td class="txt_center ">${collect.collectDate}</td>
 					<td class="title" >수금액</td>
 					<td class="pR5 txt_right" id="collect${c.index} }"><print:currency cost='${collect.collect}' /></td>
 					<td class="title" >구분</td>
 					<td class="txt_center" >
				<c:choose>
					<c:when test="${collect.type == '1'}">
						<label>현금</label> 
					</c:when>
					<c:when test="${collect.type == '2'}">
						<label>어음</label>
					</c:when>
					<c:otherwise>
						<label>기타</label>
					</c:otherwise>
				</c:choose>
					</td>
					<td class="title">비 고</td>
 					<td class="pL7" >${collect.note}</td>
 				</tr>
			</c:forEach>
			</tbody>
		</table>
		</div>  <!--  class="pop_board mT20"  -->

		<div class="pop_board mT20" >
		<p class="th_stitle">프로젝트별 수금 정보</p>
		<table cellpadding="0" cellspacing="0">
			<colgroup>
				<col class="col300" />
				<col class="col100" />
				<col class="col100" />
				<col class="w100p" />
			</colgroup>
			<tbody>
			<colgroup>
			<c:forEach items="${rstProjectList}" var="project" varStatus="c">
 				<tr>
 					<td class="title" >프로젝트명</td>
					<td class="title">매출금액</td>
					<td class="title">수금액</td>
					<td class="title">비고</td>
				</tr>
				<tr>
					<input type="hidden" name="projectVOList[${c.index}].no"			value="${project.no}" />
					<input type="hidden" name="projectVOList[${c.index}].prjId" 		value="${project.prjId}" />
					<input type="hidden" name="projectVOList[${c.index}].collectOld" 	value="${project.collect}" >
					<td class="pL5 txt_left"> ${project.prjName}</td>
					<td class="txt_center"><print:currency cost='${project.sum}' /></td>
					<td class="txt_center"><print:currency cost='${project.collect}' /></td>
					<td class="pL5" ></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		</div>  <!--  class="pop_board mT20"  -->
	</form:form>
	<div class="hm_pop_btn_area01">
<!-- 
		<img src="../../images/btn/btn_delete.gif" onclick="javascript:deleteCollect();" class="cursorPointer"/>
 -->
 		<img src="../../images/btn/btn_reject_ok.gif" onclick="javascript:popClose();" class="cursorPointer"/>
	</div>
	</div>  <!-- class="pop_con08" -->
</div>

</body>
</html>
