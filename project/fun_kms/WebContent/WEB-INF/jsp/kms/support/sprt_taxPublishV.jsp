<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>

<script>
function taxSearch() {
	document.taxPublishVO.bondStatN.value = "Y";
	document.taxPublishVO.untilToday.value = "Y";
	document.taxPublishVO.action = '<c:url value="${rootPath}/support/taxPublishL.do?bondStatN=Y&untilToday=Y" />';	
	document.taxPublishVO.submit();
}
function deleteTaxPublish() {
	if(confirm("정말 삭제하시겠습니까?")) {
		document.taxPublishVO.action = '<c:url value="${rootPath}/support/taxPublishD.do" />';
		document.taxPublishVO.submit();
	}
}
function updateTaxPublish() {
	document.taxPublishVO.action = '<c:url value="${rootPath}/support/taxPublishM.do" />';
	document.taxPublishVO.submit();
}
function reWriteTaxPublish() {
	document.taxPublishVO.action = '<c:url value="${rootPath}/support/taxPublishRW.do" />';
	document.taxPublishVO.submit();
}
function updateTaxPublishProject() {
	document.taxPublishVO.action = '<c:url value="${rootPath}/support/taxPublishProjectM.do" />';
	document.taxPublishVO.submit();
}
function updateTaxPublishState(bondStat) {
	//Y:완료 C:취소
	document.taxPublishVO.action = '<c:url value="${rootPath}/support/taxPublishStateU.do?bondStat=' + bondStat + '" />';
	document.taxPublishVO.submit();
}
function popCollection(bondPrjNo, prjId){
	document.bondFrm.bondPrjNo.value = bondPrjNo;
	document.bondFrm.prjId.value = prjId;
	
	var POP_NAME = "_POP_COLLECTION_LIST_";
	var target = document.bondFrm.target;
	document.bondFrm.target = POP_NAME;
	document.bondFrm.action = '<c:url value="${rootPath}/management/collectL.do" />';
	
	var popup = window.open("about:blank", POP_NAME, "width=560px,height=570px;");
	document.bondFrm.submit();
	popup.focus();
	document.bondFrm.target = target;
}
function thisRefresh(){
	return;
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
						<li class="stitle">세금계산서 신청 정보</li>
						<li class="navi">홈 > 업무지원 > 각종신청 > 세금계산서 발행요청</li>
					</ul>
				</div>
				<!-- S: section -->
				<div class="section01">
					<form name="bondFrm" id="bondFrm" method="POST" action="">
						<input type="hidden" name="bondPrjNo" value="" />
						<input type="hidden" name="bondColNo" value="0" />
						<input type="hidden" name="prjId" value="" />
					</form>
				
					<form:form commandName="taxPublishVO" id="taxPublishVO" name="taxPublishVO" method="post" enctype="multipart/form-data" >
						<input type="hidden" name="pageIndex" value="${taxPublishVO.pageIndex}"/>
						<input type="hidden" name="bondStatN" value="${taxPublishVO.bondStatN}"/>
						<input type="hidden" name="bondStatY" value="${taxPublishVO.bondStatY}"/>
						<input type="hidden" name="bondStatC" value="${taxPublishVO.bondStatC}"/>
						<input type="hidden" name="userNm" value="${taxPublishVO.userNm}"/>
						<input type="hidden" name="searchNm" value="${taxPublishVO.searchNm}"/>
						<input type="hidden" name="untilToday" value="${taxPublishVO.untilToday}"/>
						<input type="hidden" name="searchCompanyCd" value="${taxPublishVO.searchCompanyCd}"/>
						<input type="hidden" name="bondId" value="${result.bondId}" />
					</form:form>
					
					
					<p class="th_stitle">계산서 발행 요청 정보</p>
					<div class="boardWrite02 mB20">
						
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup>
							<col class="col100" />
							<col class="col70" />
							<col class="col250" />
							<col class="col70" />
							<col width="px" />
						</colgroup>
						<tbody>
							<tr>
								<td class="title">제목(*)</td>
								<td class="pL10" colspan="2">${result.bondSj}</td>
								<td class="title">상태</td>
								<td class="pL10">
									<c:choose>
										<c:when test="${result.bondStat == 'Y'}">발행완료</c:when>
										<c:when test="${result.bondStat == 'C'}">발행취소</c:when>
										<c:otherwise>미발행</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<tr>
								<td class="title">공급자(*)</td>
								<td class="pL10" colspan="4">${result.companyNm}</td>
							</tr>
							<tr>
								<td class="title" rowspan="4">공급받는자</td>
								<td class="title2">
									상호
								</td>
								<td class="pL10" colspan="3">
									${result.custNm}
								</td>
							</tr>
							<tr>
								<td class="title2">
									등록번호
								</td>
								<td class="pL10">
									${result.custBusiNo}
								</td>
								<td class="title2">
									대표자
								</td>
								<td class="pL10">
									${result.custRepNm}
								</td>
							</tr>
							<tr>
								<td class="title2">
									업태
								</td>
								<td class="pL10">
									${result.custBusiCond}
								</td>
								<td class="title2">
									업종
								</td>
								<td class="pL10">
									${result.custBusiTyp}
								</td>
							</tr>
							<tr>
								<td class="title2">
									주소
								</td>
								<td class="pL10" colspan="3">
									${result.custAdres}
								</td>
							</tr>
							<tr>
								<td class="title" rowspan="5">수신자</td>
								<td class="title2">수신자1</td>
								<td class="pL10" colspan="3">
									<div id="Receiver1">
										<span class="pL5">E-mail : ${result.taxEmail1}</span>
										<span class="pL20">담당자 : ${result.taxUserNm1}</span>
										<span class="pL20">연락처 : ${result.taxUserTelNo1}</span>
										<br/>
									</div>
								</td>
							</tr>
							<tr>
								<td class="title2">수신자2</td>
								<td class="pL10" colspan="3">
									<div id="Receiver2">
										<span class="pL5">E-mail : ${result.taxEmail2}</span>
										<span class="pL20">담당자 : ${result.taxUserNm2}</span>
										<span class="pL20">연락처 : ${result.taxUserTelNo2}</span>
										<br/>
									</div>
								</td>
							</tr>
							<tr>
								<td class="title2">수신자3</td>
								<td class="pL10" colspan="3">
									<div id="Receiver3">
										<span class="pL5">E-mail : ${result.taxEmail3}</span>
										<span class="pL20">담당자 : ${result.taxUserNm3}</span>
										<span class="pL20">연락처 : ${result.taxUserTelNo3}</span>
										<br/>
									</div>
								</td>
							</tr>
							<tr>
								<td class="title2">수신자4</td>
								<td class="pL10" colspan="3">
									<div id="Receiver4">
										<span class="pL5">E-mail : ${result.taxEmail4}</span>
										<span class="pL20">담당자 : ${result.taxUserNm4}</span>
										<span class="pL20">연락처 : ${result.taxUserTelNo4}</span>
										<br/>
									</div>
								</td>
							</tr>
							<tr>
								<td class="title2">수신자5</td>
								<td class="pL10" colspan="3">
									<div id="Receiver5">
										<span class="pL5">E-mail : ${result.taxEmail5}</span>
										<span class="pL20">담당자 : ${result.taxUserNm5}</span>
										<span class="pL20">연락처 : ${result.taxUserTelNo5}</span>
										<br/>
									</div>
								</td>
							</tr>
							<tr>
								<td class="title">발행일</td>
								<td colspan="2" class="pL10">
									<print:date date="${result.publishDate}"/>
								</td>
								<td class="title">영세율</td>
								<td class="pL10">
									<input type="checkbox" <c:if test="${result.zeroTaxRate=='Y'}">checked</c:if> disabled/>
								</td>
							</tr>
							<tr>
								<td class="title" rowspan="2">금액(*)</td>
								<td id="Expenses" class="pL10" colspan="4">
									<c:forEach items="${resultExpenseList}" var="expense" varStatus="c">
										 <print:currency cost="${expense.expense}" /> 원
										 &nbsp;(<c:if test="${expense.containVat == 'Y'}">
													공급가액 <span id="expSup"><print:currency cost="${expense.supplyExpense}" /></span>
													&nbsp;/&nbsp;세액 <span id="expVat"><print:currency cost="${expense.taxExpense}" /></span>
												</c:if>
												<c:if test="${expense.containVat != 'Y'}">
													공급가액 <span id="expSup"><print:currency cost="${expense.supplyExpense}" /></span>
													&nbsp;/&nbsp;세액 <span id="expVat"><print:currency cost="${expense.taxExpense}" /></span>
												</c:if>
										 &nbsp;<c:if test="${expense.containVat == 'Y'}">/ VAT 포함</c:if> ) - ${expense.note}<br/>
									</c:forEach>
								</td>
							</tr>
							<tr>
								<td class="pL10" colspan="2">
									공급가액 : <span id="supSum"><print:currency cost="${result.supSum}" /></span>원<br/>
									 세액 : <span id="taxSum"><print:currency cost="${result.taxSum}" /></span>원<br/>
									 합계 : <span id="pubSum"><print:currency cost="${result.pubSum}" /></span>원<br/>
								</td>
								<td class="title">청구/영수</td>
								<td class="pL10"><c:if test="${result.bondTyp == 1}">청구</c:if><c:if test="${result.bondTyp == 2}">영수</c:if></td>
							</tr>
							<tr>
								<td class="title">비고</td>
								<td class="pL10" colspan="4"><print:textarea text="${result.bondCn}" /></td>
							</tr>
							<tr>
								<td class="title">첨부파일</td>
								<td class="pL10" colspan="4">
									<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${result.atchFileId}" />
									</c:import>
								</td>
							</tr>
						</tbody>
						</table>
					</div>
					<!--// 게시판 끝  -->
					
					<p class="th_stitle">채권관리 정보
						<c:if test="${result.writerNo == user.no || user.taxAdmin || user.admin}">
							<c:if test="${result.bondStat == 'Y'}">
								<img src="../../images/btn/btn_change2.gif" onclick="javascript:updateTaxPublishProject();" class="search_btn02 cursorPointer"/>
							</c:if>
						</c:if>
					</p>
					<!-- 게시판 시작  -->
					<div class="boardWrite02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup>
							<col class="col100" />
							<col width="px" />
							<col class="col80" />
						</colgroup>
						<tbody>
							<c:forEach items="${resultProjectList}" var="project" varStatus="c">
								<tr>
									<c:if test="${c.count == 1}">
									<td class="title" rowspan="${fn:length(resultProjectList)}">관련프로젝트</td>
									</c:if>
									<td class="pL10">
										<print:currency cost="${project.prjExpense}" /> 원 - [${project.prjCd}] ${project.prjNm}
									</td>
									<td class="td_last">
										<c:if test="${user.taxAdmin || user.admin}">
											<c:if test="${result.bondStat == 'Y'}">
												<img src="../../images/btn/btn_collect.gif" onclick="javascript:popCollection(${project.prjNo},'${project.prjId}');" class="cursorPointer"/>
												<!-- ../../images/btn/btn_collectRegist.gif -->
											</c:if>
										</c:if>
									</td>
								</tr>                			               
							</c:forEach>
						</tbody>
						</table>
					</div>
					<!--// 게시판 끝  -->
					
					<!-- 버튼 시작 -->
					<div class="btn_area">           		    	
						<c:if test="${user.taxAdmin || user.admin}">
							<!-- 발행완료 -->
							<c:if test="${result.bondStat == 'N' || result.bondStat == 'C'}">
								<img src="../../images/btn/btn_publishComp.gif" onclick="javascript:updateTaxPublishState('Y');" class="cursorPointer"/>
							</c:if>
							<!-- 발행취소 -->
							<c:if test="${result.bondStat == 'N' || result.bondStat == 'Y'}">
								<img src="../../images/btn/btn_publishCancel.gif" onclick="javascript:updateTaxPublishState('C');" class="cursorPointer"/>
							</c:if>
						</c:if>
						<!--문서재사용-->
						<img src="../../images/btn/btn_reusedoc.gif" onclick="javascript:reWriteTaxPublish();" class="cursorPointer"/>
						<!--수정-->
						<c:if test="${(result.writerNo == user.no && result.bondStat == 'N') || ((user.admin || user.taxAdmin) && (result.bondStat == 'N' || result.bondStat == 'C'))}">
							<img src="../../images/btn/btn_modify.gif" onclick="javascript:updateTaxPublish();" class="cursorPointer"/>
						</c:if>
						<!-- 삭제 -->
						<c:if test="${result.writerNo == user.no && result.bondStat == 'N'}">
							<img src="../../images/btn/btn_delete.gif" onclick="javascript:deleteTaxPublish();" class="cursorPointer"/>
						</c:if>
						<!-- 목록 -->
						<img src="../../images/btn/btn_list.gif" onclick="taxSearch();" class="cursorPointer"/>
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
