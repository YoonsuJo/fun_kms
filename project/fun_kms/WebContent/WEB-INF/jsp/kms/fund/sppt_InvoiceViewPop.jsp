<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
</head>

<script>
//TENY_170218  문서의 상태를 변경하고려고 할때 미발행 -> 발행, 미발행 -> 취소
function updateInvoiceStatus(status) {
	//4:완료 1:취소
	document.invoiceVOFm.action = '<c:url value="${rootPath}/fund/invoiceStatus.do?status=' + status + '" />';
	document.invoiceVOFm.submit();
}

//TENY_170218  현재보고있는 문서를 삭제하려고 할때 
function deleteInvoice() {
	if(confirm("정말 삭제하시겠습니까?")) {
		document.invoiceVOFm.action = '<c:url value="${rootPath}/fund/invoiceDelete.do" />';
		document.invoiceVOFm.submit();
	}
}
//TENY_170218  현재보고있는 문서의 내용을 수정하려고 할때 
function modifyInvoice() {
	document.invoiceVOFm.action = '<c:url value="${rootPath}/fund/invoiceModify.do" />';
	document.invoiceVOFm.submit();
}
// TENY_170218  현재보고있는 문서를 이용하여 세금계산서를 재작성하려고 할때 
function reuseInvoice() {
	document.invoiceVOFm.action = '<c:url value="${rootPath}/fund/invoiceReuse.do" />';
	document.invoiceVOFm.submit();
}
function thisRefresh(){
	return;
}
</script>

<body>
<div id="pop_reg_div01">
 	<div id="pop_top">
		<ul>
			<li><img src="../images/inc/pop_bullet.gif" /></li>
			<li>세금계산서 보기</li>
		</ul>
 	</div>
 	<div class="pop_reg_div02">
		<form:form commandName="invoiceVOFm" id="invoiceVOFm" name="invoiceVOFm" method="post" enctype="multipart/form-data" >
			<input type="hidden" name="searchMode" 		value="${invoiceVO.searchMode}"/>
			<input type="hidden" name="searchCondition" 	value="${invoiceVO.searchCondition}"/>
			<input type="hidden" name="searchStatus" id="searchStatus" value="${invoiceVO.searchStatus}"/>
			<input type="hidden" name="pageIndex" 			value="${invoiceVO.pageIndex}"/>
			<input type="hidden" name="invoiceId" value="${invoiceVO.invoiceId}"/>
		
			<input type="hidden" name="searchWriterName" value="${invoiceVO.searchWriterName}"/>
			<input type="hidden" name="searchTitle" value="${invoiceVO.searchTitle}"/>
			<input type="hidden" name="searchPublishCoAcronym" value="${invoiceVO.searchPublishCoAcronym}"/>
		</form:form>
 	
		<p class="th_stitle">세금 계산서 발행 내용</p>
		<div class="pop_board mT20" >
			<table cellpadding="0" cellspacing="0" summary="세금계산서 처리 정보 내용을 볼 수 있습니다.">
			<colgroup>
				<col class="col100" />
				<col width="px" />
				<col class="col90" />
				<col class="col90" />
				<col class="col90" />
				<col class="col90" />
				<col class="col140" />
				<col class="col100" />
	
			</colgroup>
			<tbody>
				<tr>
					<td class="title">제    목(*)</td>
					<td class="pL10" colspan="3">${invoiceVO.title}</td>
					<td class="title" rowspan="6">담당자</td>
					<td class="title">이   름</td>
					<td class="title">이메일</td>
					<td class="title">연락처</td>
				</tr>
				<tr>
					<td class="title">회사명</td>
					<td class="pL10" colspan="3">${invoiceVO.custCompanyName}</td>
					<td class="pL10" >${invoiceVO.custName1}</td>
					<td class="pL10" >${invoiceVO.custEmail1}</td>
					<td class="pL10" >${invoiceVO.custTelNo1}</td>
				</tr>
				<tr>
					<td class="title">대표자</td>
					<td class="pL10" colspan="3">${invoiceVO.custCeoName}</td>
					<td class="pL10" >${invoiceVO.custName2}</td>
					<td class="pL10" >${invoiceVO.custEmail2}</td>
					<td class="pL10" >${invoiceVO.custTelNo2}</td>
				</tr>
				<tr>
					<td class="title">사업자번호</td>
					<td class="pL10" colspan="3">${invoiceVO.custBusiNo}</td>
					<td class="pL10" >${invoiceVO.custName3}</td>
					<td class="pL10" >${invoiceVO.custEmail3}</td>
					<td class="pL10" >${invoiceVO.custTelNo3}</td>
				</tr>
				<tr>
					<td class="title">주   소</td>
					<td class="pL10" colspan="3">${invoiceVO.custAddress}</td>
					<td class="pL10" >${invoiceVO.custName4}</td>
					<td class="pL10" >${invoiceVO.custEmail4}</td>
					<td class="pL10" >${invoiceVO.custTelNo4}</td>
				</tr>
				<tr>
					<td class="title">업  태</td>
					<td class="pL10" >${invoiceVO.custBusiType}</td>
					<td class="title">업  종</td>
					<td class="pL10" >${invoiceVO.custBusiKind}</td>
					<td class="pL10" >${invoiceVO.custName5}</td>
					<td class="pL10" >${invoiceVO.custEmail5}</td>
					<td class="pL10" >${invoiceVO.custTelNo5}</td>
				</tr>
				<tr>
					<td class="title" rowspan="${fn:length(rstContentsList) + 2}">금   액</td>
					<td class="title">품   목</td>
					<td class="title">공급액</td>
					<td class="title">부가세</td>
					<td class="title">합   계</td>
					<td class="title" colspan="3">비   고</td>
				</tr>
				<c:forEach items="${rstContentsList}" var="contents" varStatus="c">
					<tr>
						<td class="pL10" >${contents.productName}</td>
						<td class="pR10 txt_right" ><print:currency cost="${contents.price}" /></td>
						<td class="pR10 txt_right" ><print:currency cost="${contents.vat}" /></td>
						<td class="pR10 txt_right" ><print:currency cost="${contents.sum}" /></td>
						<td class="pL10" colspan="3">${contents.note} </td>
					</tr>
				</c:forEach>
				<tr>
					<td class="title">총 합 계</td>
					<td class="pR10 txt_right" ><print:currency cost="${invoiceVO.totalPrice}" /></td>
					<td class="pR10 txt_right" ><print:currency cost="${invoiceVO.totalVat}" /></td>
					<td class="pR10 txt_right" ><print:currency cost="${invoiceVO.totalSum}" /></td>
					<td class="title">발행구분</td>
					<td class="pL10" >
						<c:choose>
							<c:when test="${invoiceVO.publishType == '1'}">청구</c:when>
							<c:otherwise>영수</c:otherwise>
						</c:choose>
					</td>
					<td class="title">영세율&nbsp;&nbsp;
						<c:choose>
							<c:when test="${invoiceVO.taxZero == 'Y'}">적용</c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td class="title" rowspan="1">첨부파일</td>
					<td class="pL10" colspan="7">
						<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${invoiceVO.attachFileId}" />
						</c:import>
					</td>
				</tr>
			</tbody>
			</table>
		</div>
		<!--// 세금 계산서 발행 내용  -->
 	
		<br/><p class="th_stitle">세금계산서 처리 정보</p>
		<div class="pop_board mT20" >
			<table cellpadding="0" cellspacing="0" summary="세금계산서 처리 정보 내용을 볼 수 있습니다.">
			<colgroup>
				<col class="col100" />
				<col width="px" />
				<col class="col100" />
				<col class="col100" />
	
				<col class="col100" />
				<col class="col100" />
				<col class="col100" />
				<col class="col100" />
			</colgroup>
			<tbody>
				<tr>
					<td class="title">요청자</td>
					<td class="title">회사구분</td>
					<td class="title">요청일시</td>
					<td class="title">발행요청일</td>
					
					<td class="title">수금예상일</td>
					<td class="title">발행일시</td>
					<td class="title">발행자</td>
					<td class="title">수금액</td>
				</tr>
				<tr>
					<td class="pL10 txt_center" >${invoiceVO.writeUserName}</td>
					<td class="pL10 txt_center" >${invoiceVO.publishCoAcronym}</td>
					<td class="pL10 txt_center" >${invoiceVO.writeDatetime}</td>
					<td class="pL10 txt_center" >${invoiceVO.publishReqDate}</td>
	
					<td class="pL10 txt_center" >${invoiceVO.collectExpectDate}</td>
					<td class="pL10 txt_center" >
						<c:choose>
							<c:when test="${invoiceVO.status == 'N'}">미발행</c:when>
							<c:when test="${invoiceVO.status == 'C'}">발행취소</c:when>
							<c:otherwise>${invoiceVO.publishDatetime}</c:otherwise>
						</c:choose>
					</td>
					<td class="pL10 txt_center" >${invoiceVO.publishUserName}</td>
					<td class="pR10 txt_right" ><print:currency cost="${invoiceVO.totalCollect}" /></td>
				</tr>
				<tr>
					<td class="title" >특이사항</td>
					<td class="pL10"  colspan="7">${invoiceVO.comment}</td>
				</tr>
			</tbody>
			</table>
		</div>
		<!-- 계산서 발행 요청 정보 끝  -->

		<!-- 관련 프로젝트 정보 시작  -->
		<br/><p class="th_stitle">관련 프로젝트 정보</p>
		<div class="pop_board mT20" >
			<table cellpadding="0" cellspacing="0" summary="세금계산서 관련 프로젝트 정보를 볼 수 있습니다.">
			<colgroup>
				<col class="col80" />
				<col class="col200" />
				<col class="col100" />
				<col class="col100" />
				<col class="col100" />
				<col class="col100" />
			</colgroup>

			<tbody>
				<tr>
					<td class="title">일렬번호</td>
					<td class="title">관련프로젝트 명</td>
					<td class="title">공급가</td>
					<td class="title">부가세</td>
					<td class="title">합 계</td>
					<td class="title">수금액</td>
				</tr>
				<c:forEach items="${rstProjectList}" var="project" varStatus="c">
				<tr>
					<td class="pL10 txt_center" > ${c.count}</td>
					<td class="pL10 txt_center"> ${project.prjName}</td>
					<td class="pR10 txt_center"><print:currency cost="${project.price}" /></td>
					<td class="pR10 txt_center"t><print:currency cost="${project.sum - project.price}" /></td>
					<td class="pR10 txt_center"><print:currency cost="${project.sum}" /></td>
					<td class="pR10 txt_center"><print:currency cost="${project.collect}" /></td>
				</tr>
				</c:forEach>
			</tbody>
			</table>
		</div><br/>
		<!--  관련프로젝트 정보 끝  -->
 	
		<!-- 버튼 시작 -->
		<div class="btn_area">           		    	
			<!-- 기능 : 세금계산서 발행후 발행완료처리를 할때 하는 기능 -->
			<!-- 권한 : 세금계산서 발행권자와 관리자 -->
			<!-- 상태 : 미발행 상태의 세금계산서만이 버튼이 나타난다. -->
			<c:if test="${(user.taxAdmin || user.admin ) && invoiceVO.status == 2}">
					<img src="../../images/btn/btn_publishComp.gif" onclick="javascript:updateInvoiceStatus(4);" class="cursorPointer"/>
			</c:if>
			<!-- 기능 : 세금계산서 발행전 발행 취소를 요청할때 사용하는 기능 -->
			<!-- 권한 : 세금계산서 발행권자와 관리자, 발행요청자 -->
			<!-- 상태 : 미발행 상태의 세금계산서만이 버튼이 나타난다. -->
			<c:if test="${(user.taxAdmin || user.admin ) && invoiceVO.status == 2}">
				<img src="../../images/btn/btn_publishCancel.gif" onclick="javascript:updateInvoiceStatus(1);" class="cursorPointer"/>
			</c:if>
			<!-- 기능 : 세금계산서 발행요청서의 내용을 수정하고자 할떄 사용하는 기능 -->
			<!-- 권한 : 발행요청자 -->
			<!-- 상태 : 미발행 상태. -->
			<c:if test="${(invoiceVO.writeUserNo == user.no && invoiceVO.status == 2) || (user.taxAdmin || user.admin )}">
				<img src="../../images/btn/btn_modify.gif" onclick="javascript:modifyInvoice();" class="cursorPointer"/>
			</c:if>
			<!-- 기능 : 세금계산서 발행요청서를 삭제하고자 할떄 사용하는 기능 -->
			<!-- 권한 : 발행요청자 -->
			<!-- 상태 : 미발행 상태. -->
			<c:if test="${(invoiceVO.writeUserNo == user.no && invoiceVO.status == 2) || (user.taxAdmin || user.admin )}">
				<img src="../../images/btn/btn_delete.gif" onclick="javascript:deleteInvoice();" class="cursorPointer"/>
			</c:if>
			<!-- 기능 : 세금계산서 발행요청서를 활용하여 다시 요청서를 작성할때 사용하는 기능 -->
			<img src="../../images/btn/btn_reusedoc.gif" onclick="javascript:reuseInvoice();" class="cursorPointer"/>
			
			<!-- 기능 : 세금계산서 조회창을 닫는다 -->
			<img src="../../images/btn/btn_cancel.gif" onclick="javascript:window.close();" class="cursorPointer"/>
		</div>
		<!-- 버튼 끝 -->

</body>
</html>

