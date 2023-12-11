<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<c:import url="${rootPath}/cooperation/selectCustomerCommentList.do">
	<c:param name="type" value="head" />
</c:import>
<script>
function delCust() {
	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.action = "${rootPath}/cooperation/deleteCustomer.do";
		document.frm.submit();
	}
}
function modify() {
	document.frm.action = "${rootPath}/cooperation/updateCustomerView.do";
	document.frm.submit();
}
function list() {
	document.frm.action = "${rootPath}/cooperation/selectCustomerList.do";
	document.frm.submit();
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
							<li class="stitle">고객사정보 열람</li>
							<li class="navi">홈 > 업무공유 > 정보공유 > 고객사정보</li>
						</ul>
					</div>
					
					<!-- S: section -->
					<div class="section01">
						
						<!-- 게시판 시작 -->
						<form name="frm" method="POST">
						<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
						<input type="hidden" name="searchKeyword" value="${searchVO.searchKeyword}"/>
						<input type="hidden" name="searchBusiNo" value="${searchVO.searchBusiNo}"/>
						<input type="hidden" name="searchPersonNm" value="${searchVO.searchPersonNm}"/>
						<input type="hidden" name="searchTelno" value="${searchVO.searchTelno}"/>
						<input type="hidden" name="searchFaxno" value="${searchVO.searchFaxno}"/>
						<input type="hidden" name="searchUserMix" value="${searchVO.searchUserMix}"/>
						<input type="hidden" name="custId" value="${result.custId}"/>
						<p class="th_stitle">고객사 정보</p>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>고객사 정보</caption>
		                    <colgroup>
			                    <col class="col120" />
			                    <col width="px" />
			                    <col class="col120" />
			                    <col width="px" />
		                    </colgroup>
		                    <tbody>
		                    	<tr>
			                    	<td class="title">최초등록자</td>
			                    	<td class="pL10"><print:user userNo="${result.userNoReg}" userNm="${result.userNmReg}"/></td>
			                    	<td class="title">등록일시</td>
			                    	<td class="pL10">${result.regDt}</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">최종수정자</td>
			                    	<td class="pL10"><print:user userNo="${result.userNoMod}" userNm="${result.userNmMod}"/></td>
			                    	<td class="title">수정일시</td>
			                    	<td class="pL10">${result.modDt}</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">업체명</td>
			                    	<td class="pL10" colspan="3">${result.custNm}</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">사업자등록번호</td>
			                    	<td class="pL10">${result.custBusiNo}</td>
			                    	<td class="title">대표자</td>
			                    	<td class="pL10">${result.custRepNm}</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">주소</td>
			                    	<td class="pL10" colspan="3">${result.custAdres}</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">전화번호</td>
			                    	<td class="pL10">${result.custTelno}</td>
		                    		<td class="title">FAX</td>
			                    	<td class="pL10">${result.custFaxno}</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">업태</td>
			                    	<td class="pL10">${result.custBusiCond}</td>
		                    		<td class="title">업종</td>
			                    	<td class="pL10">${result.custBusiTyp}</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">비고</td>
			                    	<td class="pL10 pT5 pB5" colspan="3">${result.notePrint}</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">계좌정보</td>
			                    	<td class="pL10" colspan="3">
			                    		<span class="txtB_grey T11">은행 : </span>${result.bankNm}<span class="pL7"></span>
			                    		<span class="txtB_grey T11">계좌번호 : </span>${result.bankNo}<span class="pL7"></span>
			                    		<span class="txtB_grey T11">예금주 : </span>${result.bankUserNm}
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">첨부파일</td>
			                    	<td class="pL10" colspan="3">
										<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${result.atchFileId}" />
										</c:import>
									</td>
		                    	</tr>
		                    	<c:forEach items="${result.taxList}" var="tax" varStatus="c">
			                    	<tr>
			                    		<c:if test="${c.count == 1}">
				                    	<td class="title" rowspan="${fn:length(result.taxList)}">세금계산서<br/>수신정보</td>
			                    		</c:if>
				                    	<td class="pL10" colspan="3">
				                    		<span class="txtB_grey T11">E-Mail : </span>${tax.taxEmail}<span class="pL7"></span>
				                    		<span class="txtB_grey T11">담당자 : </span>${tax.taxUserNm}<span class="pL7"></span>
				                    		<span class="txtB_grey T11">연락처 : </span>${tax.taxTelno}
			                    		</td>
			                    	</tr>
		                    	</c:forEach>
		                    	<c:if test="${empty result.taxList}">
		                    		<tr>
		                    			<td class="title">세금계산서<br/>수신정보</td>
				                    	<td class="pL10" colspan="3">
				                    		세금계산서 수신정보가 없습니다.
			                    		</td>
		                    		</tr>
		                    	</c:if>
		                    </tbody>
		                    </table>
						</div>
						
						<p class="th_stitle">담당자 정보</p>
                    	<c:forEach items="${result.personList}" var="person">
							<div class="boardWrite02 mB20">
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			                    <caption>공지사항 보기</caption>
			                    <colgroup><col class="col120" /><col width="px" /><col class="col120" /><col width="px" /></colgroup>
			                    <tbody>
				                    	<tr>
					                    	<td class="title" >담당자명</td>
					                    	<td class="pL10" >${person.personNm}</td>
					                    	<td class="title" >E-Mail</td>
					                    	<td class="pL10" >${person.personEmail}</td>
				                    	</tr>
				                    	<tr>
					                    	<td class="title" >휴대전화</td>
					                    	<td class="pL10" >${person.personHpno}</td>
					                    	<td class="title" >유선전화</td>
					                    	<td class="pL10" >${person.personTelno}</td>
				                    	</tr>
				                    	<tr>
					                    	<td class="title" >비고</td>
					                    	<td class="pL10" colspan="3" >${person.personNote}</td>
				                    	</tr>
			                    </tbody>
			                    </table>
							</div>
                    	</c:forEach>
						</form>
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02 pB20">
		                	<ul>
		                		<li class="left th_txt2 T11">※ 고객사 정보 삭제를 원하시면 관리자에게 문의하시기 바랍니다.</li>
		                		<li class="right">
		                			<c:if test="${user.admin}">
		                			<a href="javascript:delCust();"><img src="${imagePath}/btn/btn_delete.gif"/></a>
		                			</c:if>
		                			<a href="javascript:modify();"><img src="${imagePath}/btn/btn_modify.gif"/></a>
		                			<a href="javascript:list();"><img src="${imagePath}/btn/btn_list.gif"/></a>
		                		</li>
		                	</ul>
		                </div>
		                <!-- 버튼 끝 -->
						
						<div id="commentArea">
							<c:import url="${rootPath}/cooperation/selectCustomerCommentList.do">
								<c:param name="type" value="body" />
								<c:param name="commentNo" value="${comment.no}" />
							</c:import>
						</div>
						<!--// 게시판 끝-->
						
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
