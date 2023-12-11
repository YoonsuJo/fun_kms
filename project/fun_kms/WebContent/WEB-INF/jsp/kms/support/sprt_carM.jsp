<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/cheditor.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/utils/imageUtil.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="carReg" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function update() {
	if (!validateCarReg(document.frm)) {
		return;
	}
	
	if (document.frm.userTyp[0].checked == true) {
		document.frm.userNm.value = "";
	}

	if (confirm('<spring:message code="common.update.msg" />')) {
		document.frm.submit();					
	}
}
function selRadio(n) {
	if (n == 0 || n == "C") {
		document.frm.userTyp[0].checked = true;
		document.getElementById("userNm").style.display = "none";
		document.getElementById("userTree").style.display = "none";
	}
	else if (n == 1 || n == "U") {
		document.frm.userTyp[1].checked = true;
		document.getElementById("userNm").style.display = "";
		document.getElementById("userTree").style.display = "";
	}
}
function fn_egov_check_file(flag) {
	if (flag=="Y") {
		document.getElementById('file_upload_posbl').style.display = "";
		document.getElementById('file_upload_imposbl').style.display = "none";			
	} else {
		document.getElementById('file_upload_posbl').style.display = "none";
		document.getElementById('file_upload_imposbl').style.display = "";
	}
}
$(document).ready(function(){selRadio("${result.userTyp}");});
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
							<li class="stitle">법인차량 등록</li>
							<li class="navi">홈 > 업무지원 > 자원관리 > 법인차량 관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<!-- 차량정보 시작  -->
						<form:form name="frm" commandName="carReg" action="${rootPath}/support/updateCarInfo.do" method="POST" enctype="multipart/form-data">
						<input type="hidden" name="returnUrl" value="<c:url value='${rootPath}/support/updateCarInfoView.do'/>"/>
						<input type="hidden" name="carId" value="${result.carId}"/>
						<input type="hidden" name="imgFileId" value="${result.imgFileId}"/>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>법인차량 등록</caption>
		                    <colgroup><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr>
		                    		<td class="title">차종</td>
			                    	<td class="td_last pL10"><input type="text" class="input01 span_29" name="carTyp" value="${result.carTyp}"/></td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">차량번호</td>
			                    	<td class="td_last pL10">${result.carId}</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">사용자</td>
			                    	<td class="td_last pL10">
			                    		<label><input type="radio" class="radio" name="userTyp" value="C" onclick="selRadio(0)"/> 공용</label>
			                    		<label><input type="radio" class="radio" name="userTyp" value="U" onclick="selRadio(1)"/> 개인사용</label>
			                    		<input type="text" class="input01 span_6 userNameAuto userValidateCheck" name="userNm" id="userNm" style="display:none;"  value="${result.userNm}"/>
			                    		<img src="${imagePath}/btn/btn_tree.gif" class="search_btn02 cursorPointer" id="userTree" onclick="usrGen('userNm',1);" style="display:none;"/>
			                    	</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">보험회사</td>
			                    	<td class="td_last pL10"><input type="text" class="input01 span_29" name="insComp" value="${result.insComp}"/></td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">보험회사 연락처</td>
			                    	<td class="td_last pL10"><input type="text" class="input01 span_29" name="insCallNo" value="${result.insCallNo}"/></td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">보험 만료일</td>
			                    	<td class="td_last pL10"><input type="text" class="input01 span_29 calGen" name="insEdate" value="${result.insEdate}"/></td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">보험연령</td>
			                    	<td class="td_last pL10">만 <input type="text" class="input01 span_2" name="insAge" value="${result.insAge}"/> 세 이상</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">면허종류</td>
			                    	<td class="td_last pL10">
			                    		<select class="select01" name="insLicTyp">
			                    			<option value="A" <c:if test="${result.insLicTyp == 'A'}">selected="selected"</c:if>>1종대형</option>
			                    			<option value="B" <c:if test="${result.insLicTyp == 'B'}">selected="selected"</c:if>>1종보통</option>
			                    			<option value="C" <c:if test="${result.insLicTyp == 'C'}">selected="selected"</c:if>>2종보통</option>
			                    		</select> 이상
			                    	</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">소유회사</td>
			                    	<td class="td_last pL10">
			                    		<select class="select01" name="compnyId">
			                    			<c:forEach items="${compList}" var="comp">
				                    			<option value="${comp.code}" <c:if test="${comp.code == result.compnyId}">selected="selected"</c:if>>${comp.codeNm}</option>
			                    			</c:forEach>
			                    		</select>
			                    	</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">차량이미지</td>
			                    	<td class="td_last pL10">
										<c:if test="${not empty result.imgFileId}">
											<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${result.imgFileId}" />
											</c:import>
										</c:if>	
										<c:if test="${result.imgFileId == ''}">
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
										var existFileNum = document.frm.fileListCnt.value;	    
										var maxFileNum = 1;
										
										if (existFileNum=="undefined" || existFileNum ==null) {
											existFileNum = 0;
										}
										var uploadableFileNum = maxFileNum - existFileNum;
										if (uploadableFileNum<0) {
											uploadableFileNum = 0;
										}				
										if (uploadableFileNum != 0) {
											fn_egov_check_file('Y');
											var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum , 'span_12');
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
						</form:form>
						<!--// 차량정보 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="javascript:update();"><img src="${imagePath}/btn/btn_modify.gif"/></a>
		                	<a href="${rootPath}/support/selectCarList.do"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
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
