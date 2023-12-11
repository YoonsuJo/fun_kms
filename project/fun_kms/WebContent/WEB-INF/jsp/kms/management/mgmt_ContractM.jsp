<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>

<validator:javascript formName="taxPublish" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='${commonPath}/js/jquery.validate.js'/>" ></script>
<script>
function updateContract(){
	document.contractFrm.action = '<c:url value="${rootPath}/management/contractU.do" />';
	document.contractFrm.submit();
}
function contractSearch() {
	document.contractFrm.action = '<c:url value="${rootPath}/management/contractL.do" />';
	document.contractFrm.submit();
}
function viewContract() {
	document.contractFrm.action = '<c:url value="${rootPath}/management/contractV.do" />';
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
						<li class="navi">홈 > 경영정보 > 계약건관리 > 계약건 수정</li>
					</ul>
				</div>
				<span class="stxt">(*) 표시가 있는 항목은 필수 입력 항목입니다.</span>
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
	           		
	           		<p class="th_stitle">계약건 수정</p>
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
		                    	<td class="title">계약명(*)</td>
		                    	<td class=" pL10" colspan="4"><input type="text" class="input01 span_16" name="sj" value="${result.sj }"/></td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title">법인구분(*)</td>
		                    	<td class=" pL10" colspan="2">
		                    		<select  name="companyCd" class="select01" >
										<c:forEach items="${companyList}" var="company">
											<option
												value="${company.code}"
												<c:choose>
													<c:when test="${company.code==result.companyCd}">selected</c:when>
													<c:otherwise><c:if test="${company.code==user.expCompId}">selected</c:if></c:otherwise>
												</c:choose>
											>
												${company.codeNm}
											</option>
										</c:forEach>
									</select>
		                    	</td>
		                    	<td class="title">종류</td>
		                    	<td class=" pL10">
		                    		<select  name="insertTyp" class="select01" >
										<option value="W" <c:if test="${result.typ == 'W'}">selected</c:if>>수주계약</option>
										<option value="O" <c:if test="${result.typ == 'O'}">selected</c:if>>발주계약</option>
									</select>
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title">계약일(*)</td>
		                    	<td class=" pL10" colspan="2">
		                    		<input type="text" name="contractDate" class="input01 span_5 calGen" value="${result.contractDate }" />
		                    	</td>
		                    	<td class="title">계약기간</td>
		                    	<td class=" pL10">
		                    		<input type="text" name="contractStartDate" class="input01 span_5 calGen" value="${result.contractStartDate }" /> ~ <input type="text" name="contractEndDate" class="input01 span_5 calGen" value="${result.contractEndDate }" />
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title" rowspan="4">계약대상자</td>
		                    	<td class="title2">상호(*)</td>
		                    	<td class="pL10" colspan="3">
	                    			<input type="text" class="input01 span_10" name="nm" value="${result.nm }"/> <img src="../../images/btn/btn_fromCustomerList.gif" class="cursorPointer" id="searchFromCustomer"/>
	                    		</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title2">등록번호</td>
	                    		<td class="pL10" colspan="3">
	                    			<input type="text" class="input01 span_10" name="busiNo" value="${result.busiNo }"/>
	                    		</td>
	                    	</tr>
		                    <tr>
		                    	<td class="title2">대표자</td>
		                    	<td class="pL10">
	                    			<input type="text" class="input01 span_10" name="repNm" value="${result.repNm }"/>
	                    		</td>
	                    		<td class="title2">전화번호</td>
		                    	<td class="pL10">
	                    			<input type="text" class="input01 span_10" name="phone" value="${result.phone }"/>
	                    		</td>
	                    	</tr>
		                    <tr>
		                    	<td class="title2">주소</td>
		                    	<td class="pL10" colspan="3">
	                    			<input type="text" class="input01 span_24" name="adres" value="${result.adres }"/>
	                    		</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title">계약금액</td>
		                    	<td id="Expenses" class="pL10" colspan="4">
	                    			<input type="text" class="input01 span_6 currency" name="expense" value="${result.expense }"/> 원
	                    			<label><input type="checkbox" class="check" name="containVat" value="Y" <c:if test="${result.containVat == 'Y'}">checked="true"</c:if>/> VAT 포함</label>
		                    	</td>
	                    	</tr>             			               
	                    	<tr>
		                    	<td class="title">계약내용</td>
		                    	<td class="pL10" colspan="4"><textarea class="span_23" name="cn">${result.cn}</textarea></td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title">부서(*)</td>
		                    	<td class=" pL10" colspan="2">
		                    		<input type="text" name="orgnztNm" id="orgnztNm" value="${result.orgnztNm }" readonly="true" class="span_29" onclick="orgGen('orgnztNm','orgnztId',1);"/>
		                    		<input type="hidden" name="orgnztId" id="orgnztId" value="${result.orgnztId }" >
	                    			<img src="${imagePath}/btn/btn_tree.gif" id="orgnztTreeB" class="cursorPointer" onclick="orgGen('orgnztNm','orgnztId',1);"/>
		                    	</td>
		                    	<td class="title">프로젝트(*)</td>
		                    	<td class=" pL10">
		                    		<input type="text" name="prjNm" id="searchPrjNm" value="${result.prjNm }" class="span_9 input01" readonly="readonly" onclick="prjGen('searchPrjNm','searchPrjId',1);"/>
									<input type="hidden" name="prjId" id="searchPrjId" value="${result.prjId }" >
									<img src="${imagePath}/btn/btn_tree.gif" onclick="prjGen('searchPrjNm','searchPrjId',1);" class="cursorPointer">
		                    	</td>
	                    	</tr>
	                    	<tr>
								<td class="title" rowspan="2">첨부파일</td>
								<td class="pL10" colspan="4">
									<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${result.atchFileId}" />
									</c:import>
									<c:if test="${result.atchFileId == ''}">
										<input type="hidden" name="fileListCnt" value="0" />
									</c:if>
									<div id="file_upload_posbl"  style="display:none;" >	
										<input name="file_1" id="egovComFileUploader" type="file" />
										<div id="egovComFileList"></div>
									</div>
									<div id="file_upload_imposbl"  style="display:none;" >
										<spring:message code="common.imposbl.fileupload" />
									</div>		    
											   	
									<script type="text/javascript">
									var existFileNum = document.contractFrm.fileListCnt.value;	    
									var maxFileNum = document.contractFrm.posblAtchFileNumber.value;
									
									if (existFileNum=="undefined" || existFileNum ==null) {
										existFileNum = 0;
									}
									if (maxFileNum=="undefined" || maxFileNum ==null) {
										maxFileNum = 0;
									}		
									var uploadableFileNum = maxFileNum - existFileNum;
									if (uploadableFileNum<0) {
										uploadableFileNum = 0;
									}				
									if (uploadableFileNum != 0) {
										fn_egov_check_file('Y');
										var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum );
										multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
									} else {
										fn_egov_check_file('N');
									}			
									</script>
								</td>
	                        </tr>
	                    </tbody>
	                    </table>
					</div>
					<!--// 게시판 끝  -->
					
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
                		<img src="../../images/btn/btn_regist.gif" onclick="javascript:updateContract();" class="cursorPointer"/>
                		<img src="../../images/btn/btn_cancel.gif" onclick="viewContract();" class="cursorPointer"/>
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
