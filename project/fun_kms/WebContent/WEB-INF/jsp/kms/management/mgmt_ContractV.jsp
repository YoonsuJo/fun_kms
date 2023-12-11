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
function insertContract(){
	document.contractFrm.action = '<c:url value="${rootPath}/management/contractI.do" />';
	document.contractFrm.submit();
}
function contractSearch(){
	document.contractFrm.action = '<c:url value="${rootPath}/management/contractL.do" />';
	document.contractFrm.submit();
}
function updateContract(){
	document.contractFrm.action = '<c:url value="${rootPath}/management/contractM.do" />';
	document.contractFrm.submit();
}
function deleteContract(){
	if(confirm("삭제 하시겠습니까?")){	
		document.contractFrm.action = '<c:url value="${rootPath}/management/contractD.do" />';
		document.contractFrm.submit();
	}
}
function registerContract(){
	if (document.contractFrm.resultRegister.value == 'Y')
		document.contractFrm.resultRegister.value = 'N';
	else
		document.contractFrm.resultRegister.value = 'Y';
	document.contractFrm.action = '<c:url value="${rootPath}/management/contractU.do" />';
	document.contractFrm.submit();
}
function updateAuth(){
	document.contractFrm.action = '<c:url value="${rootPath}/management/updateAuthList.do" />';
	document.contractFrm.submit();
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
						<li class="stitle">계약건관리</li>
						<li class="navi">홈 > 경영정보 > 계약건관리 > 계약건 조회</li>
					</ul>
				</div>
				<!-- S: section -->
				<div class="section01">
					
					<form:form commandName="contractFrm" id="contractFrm" name="contractFrm" method="post" enctype="multipart/form-data" >
					
					<input type="hidden" name="contractNo" value="${result.contractNo }" />
					<input type="hidden" name="searchTyp" value="${searchVO.searchTyp }" />
					<input type="hidden" name="pageIndex" value="${searchVO.pageIndex }" />
					
					<input type="hidden" name="posblAtchFileNumber" value="3" />
					
					<input type="hidden" name="searchSj" value="${searchVO.searchSj }" />
					<input type="hidden" name="searchCn" value="${searchVO.searchCn }" />
					<input type="hidden" name="searchNm" value="${searchVO.searchNm }" />
					<input type="hidden" name="searchOrgnztNm" value="${searchVO.searchOrgnztNm }" />
					<input type="hidden" name="searchPrjNm" value="${searchVO.searchPrjNm }" />
	           		
	           		<p class="th_stitle">계약건 조회</p>
           		 	<!-- 게시판 시작  -->
					<div class="boardWrite02 mB20">
						
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>공지사항 보기</caption>
	                    <colgroup>
	                    	<col class="col100" />
	                    	<col class="col70" />
	                    	<col class="col240" />
	                    	<col class="col80" />
	                    	<col width="px" />
                    	</colgroup>
	                    <tbody>
	                    	<tr>
		                    	<td class="title">등록자</td>
		                    	<td class=" pL10" colspan="2">
		                    		<print:user userNo="${result.userNo}" userNm="${result.userNm}" userId="${result.userId}" />
		                    	</td>
		                    	<td class="title">등록일시</td>
		                    	<td class=" pL10">
		                    		${result.lastUpdateDate }
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title">계약명</td>
		                    	<td class=" pL10" colspan="4">
		                    		${result.sj }
								</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title">법인구분</td>
		                    	<td class=" pL10" colspan="2">
		                    		${result.companyNm }
		                    	</td>
		                    	<td class="title">종류</td>
		                    	<td class=" pL10">
		                    		<c:if test="${result.typ == 'W'}">수주계약</c:if>
		                    		<c:if test="${result.typ == 'O'}">발주계약</c:if>
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title">계약일</td>
		                    	<td class=" pL10" colspan="2">
		                    		<c:choose>
									<c:when test="${result.contractDate != ''}">
										<print:date date='${result.contractDate}' />
									</c:when>
									<c:otherwise>
										&nbsp;
									</c:otherwise>
									</c:choose>
		                    	</td>
		                    	<td class="title">계약기간</td>
		                    	<td class=" pL10">
		                    		<c:choose>
									<c:when test="${result.contractStartDate != '' && result.contractEndDate != ''}">
										<print:date date='${result.contractStartDate}' /> ~ <print:date date='${result.contractEndDate}' />
									</c:when>
									<c:otherwise>
										&nbsp;
									</c:otherwise>
									</c:choose>
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title" rowspan="4">계약대상자</td>
		                    	<td class="title2">상호</td>
		                    	<td class="pL10" colspan="3">
	                    			${result.nm }
	                    		</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title2">등록번호</td>
	                    		<td class="pL10" colspan="3">
	                    			${result.busiNo }
	                    		</td>
	                    	</tr>
		                    <tr>
		                    	<td class="title2">대표자</td>
		                    	<td class="pL10">
	                    			${result.repNm }
	                    		</td>
	                    		<td class="title2">전화번호</td>
		                    	<td class="pL10">
	                    			${result.phone }
	                    		</td>
	                    	</tr>
		                    <tr>
		                    	<td class="title2">주소</td>
		                    	<td class="pL10" colspan="3">
	                    			${result.adres }
	                    		</td>
	                    	</tr>
	                    	<c:if test="${readAuth}">
	                    	<tr>
		                    	<td class="title">계약금액</td>
		                    	<td id="Expenses" class="pL10" colspan="4">
	                    			<print:currency cost="${result.expense }" /> 원
	                    			<c:if test="${result.containVat == 'Y'}">(VAT 포함)</c:if>
		                    	</td>
	                    	</tr>
	                    	</c:if>
	                    	<tr>
		                    	<td class="title">계약내용</td>
		                    	<td class="pL10" colspan="4">
		                    		<print:textarea text="${result.cn}" />
								</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title">부서</td>
		                    	<td class=" pL10" colspan="2">
		                    		${result.orgnztNm }
		                    	</td>
		                    	<td class="title">프로젝트</td>
		                    	<td class=" pL10">
		                    		<a href="${rootPath }/cooperation/selectProjectV.do?prjId=${result.prjId }" >[${result.prjCd }] ${result.prjNm }</a>
		                    	</td>
	                    	</tr>
	                    	<tr>
								<td class="title">첨부파일</td>
								<td class="pL10" colspan="4">
									<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${result.atchFileId}" />
									</c:import>
								</td>
	                        </tr>
	                        <c:if test="${result.typ == 'W'}">
	                    	<tr>
								<td class="title">실적신고여부</td>
								<td class="pL10" colspan="4">
									<input type="hidden" name="resultRegister" value="${result.resultRegister }" >
									<c:choose>
									<c:when test="${result.resultRegister == 'Y'}">
										신고
									</c:when>
									<c:otherwise>
										미신고
									</c:otherwise>
									</c:choose>
									<c:if test="${user.admin}">
										<span class="pL20"></span><img src="../../images/btn/btn_change2.gif" onclick="javascript:registerContract();" class="cursorPointer"/>
									</c:if>
								</td>
	                        </tr>
	                        </c:if>
	                        <!-- 
	                        <c:if test="${user.admin}">
	                        <tr>
								<td class="title">상세정보<br/>열람권한</td>
								<td class="pL10" colspan="4">
									<input type="text" name="authListMix" id="recieverList" class="input_left write_input09 userNamesAuto userValidateCheck"
										value="<c:forEach items="${authList}" var="auth" varStatus="c" ><c:if test="${c.count > 1}" >,</c:if> ${auth.userNm}(${auth.userId})</c:forEach>"/> <img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('recieverList',0);">
									<span class="pL20"></span><img src="../../images/btn/btn_change2.gif" onclick="javascript:updateAuth();" class="cursorPointer"/>
								</td>
	                        </tr>
	                        </c:if>
	                         -->
	                    </tbody>
	                    </table>
					</div>
					<!--// 게시판 끝  -->
					
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
           		    <!-- 
           		    	<c:if test="${user.admin}">
           		    		<img src="../../images/btn/btn_authAdd2.gif" onclick="javascript:updateContract();" class="cursorPointer"/>
           		    	</c:if>
           		     -->
           		    	<c:if test="${result.writerNo == user.no || user.admin}">
	                		<img src="../../images/btn/btn_modify.gif" onclick="javascript:updateContract();" class="cursorPointer"/>
	                		<img src="../../images/btn/btn_delete.gif" onclick="javascript:deleteContract();" class="cursorPointer"/>
                		</c:if>
                		<img src="../../images/btn/btn_list.gif" onclick="contractSearch();" class="cursorPointer"/>
               	    </div>
                 	<!-- 버튼 끝 -->

					</form:form>
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
