<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>

<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="adminApproval" staticJavascript="false" xhtml="true" cdata="false"/>
	
<script type="text/javascript">
$(document).ready(function(){
	var existFileNum = document.result.fileListCnt.value;	    
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
		var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum );
		multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
	} else {
		fn_egov_check_file('N');
	}

	$('#submitB').click(
		function(){
			if(!validateAdminApproval(document.result))
				return;
			var form = $('#result');
			if($("#writeMode").val()=="W")
				form.attr("action","/admin/approval/approvalI.do");
			else
				form.attr("action","/admin/approval/approvalU.do");	
			form.submit();
				
	});

	$('#backB').click(function(){
		history.back(-1);
	});

	$('#coopUserGenB').click(function(){
		usrGen('coopMixs',2);
	});
	
	$('#referUserGenB').click(function(){
		usrGen('referMixs',2);
	});
	
	$('#handlerUserGenB').click(function(){
		usrGen('handlerMixs',2);
	});
	
	$('#deciderUserGenB').click(function(){
		usrGen('deciderMix',1);
	});
	
});
</script>

</head>





<body>
<div id="admin_wrap">
	<!-- S: container -->
	<div id="admin_container">
		<ul class="admin_container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="admin_contents">
		<%@ include file="../left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">전자결재 양식설정 수정</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">	
						
						<!-- 게시판 시작  -->
						<form:form commandName="result" name="result" method="post" enctype="multipart/form-data" >
							
							<input type="hidden" name="returnUrl" value="<c:url value='${rootPath}/admin/approval/approval${code}.do'/>"/>
							<form:hidden path="templtId"/>
							<form:hidden path="docIcon"/>
							<input type="hidden" value ="${code}" id="writeMode" />
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>전자결재양식</caption>
		                    <colgroup><col class="col120" /><col width="px" /><col class="col250" /><col class="col100" /></colgroup>
		                    <tbody>
		                    	<tr> 
			                    	<td class="title">양식코드</td>
			                    	<td class="pL10" colspan="2">${result.templtId }</td>
			                    	<td class="pic" rowspan="3">
			                    		<c:if test="${result.docIcon!=''}">
			                    			<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${result.docIcon}" />
											</c:import>
										</c:if >
			                    	</td>
		                    	</tr>
		                    	<tr> 
			                    	<td class="title">양식명</td>
			                    	<td class="pL10" colspan="2"><form:input path="docSj" cssClass="span_22" /></td>
		                    	</tr>
								<tr>
								    <td class="title">아이콘</td>
									<td class="pL10" colspan="2"> 
											<c:if test="${result.docIcon == ''}">
												<input type="hidden" name="fileListCnt" value="0" />
											</c:if>
											<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${result.docIcon}" />
											</c:import>
											<div id="file_upload_posbl"  style="display:none;" >	
												<input name="file_1" id="egovComFileUploader" type="file" />
												<div id="egovComFileList"></div>
											</div>
											<div id="file_upload_imposbl"  style="display:none;" >
												<spring:message code="common.imposbl.fileupload" />
											</div>		    
									</td>
 								</tr>
 								<tr>
								    <td class="title">양식설명</td>
									<td class="pL10 pT5 pB5" colspan="3">
										<form:textarea path="docCt" cssClass="span_23 height_80" />


									</td>
 								</tr>
 								<tr>
								    <td class="title">결재선 기준 설명</td>
									<td class="pL10 pT5 pB5" colspan="3">
										<form:textarea path="decideLineDesc" cssClass="span_23 height_80" />
									</td>
 								</tr>
 								<tr>
								    <td class="title">결재선 자동입력</td>
									<td class="pL10" colspan="3">
										<form:radiobutton path="readerAutoCmt"  value="1" label="예"/>
										<form:radiobutton path="readerAutoCmt"  value="2" label="아니오"/>
										&nbsp;&nbsp;&nbsp;※ 검토자 및 전결자를 자동으로 입력해주는 기능입니다.
									</td>
 								</tr>
 								<tr>
								    <td rowspan="2" class="title">최종결재자(전결)<br/><span class="txtB_red">(기능 X)</span></td>
									<td class="pL10 pT5 pB5" colspan="3">전결자의 조건을 지정하면 기안자 소속부서 ~ 전결자 하위부서의 장이 검토자로 자동등록됨 (0~N명)</td>
 								</tr>
 								<tr>
									<td class="select_list">
										<form:radiobutton path="deciderRule1"  value ="1" label=" X레벨 부서의 장을 전결자로 지정"/>
										<br/>
										<form:select  path="deciderRule2" cssClass="span_4">
											<form:option value="0" label="0레벨"></form:option>
											<form:option value="1" label="1레벨"></form:option>
											<form:option value="2" label="2레벨"></form:option>
											<form:option value="3" label="3레벨"></form:option>
										
										</form:select>
										
									</td>	
									<td class="select_list" colspan="2">
									<form:radiobutton path="deciderRule1"  value ="2" label=" 소속부서보다 X단계 위 부서의 장을 전결자로 지정"/>
										<form:select  path="deciderRule3" cssClass="span_4">
											<form:option value="0" label="0레벨"></form:option>
											<form:option value="1" label="1레벨"></form:option>
											<form:option value="2" label="2레벨"></form:option>
											<form:option value="3" label="3레벨"></form:option>
										
										</form:select>
										상위부서 <br/>
										<form:checkbox path="deciderRule4" value ="1"/> 단, 최대
										
										<form:select  path="deciderRule5" cssClass="span_4">
											<form:option value="0" label="0레벨"></form:option>
											<form:option value="1" label="1레벨"></form:option>
											<form:option value="2" label="2레벨"></form:option>
											<form:option value="3" label="3레벨"></form:option>
										
										</form:select> 부서보다 상위부서로 올라가지 않음
									</td>									
 								</tr>
 								<tr>
								    <td class="title">협조자</td>
									<td class="pL10" colspan="3">
									<form:input  path="coopMixs" cssClass="span_17 userNamesAuto userValidateCheck" /> 
									<img src="${imagePath}/btn/btn_tree.gif" id="coopUserGenB" class="cursorPointer"/> 여러명 지정 가능</td>
 								</tr>
 								<tr>
								    <td class="title">전결자</td>
									<td class="pL10" colspan="3">
									<form:input  path="deciderMix" cssClass="span_17 userNameAuto userValidateCheck" /> 
									<img src="${imagePath}/btn/btn_tree.gif" id="deciderUserGenB" class="cursorPointer"/> 1명만 지정 가능</td>
 								</tr>
 								<tr>
								    <td class="title">참조자</td>
									<td class="pL10" colspan="3"><form:input  path="referMixs" cssClass="span_17 userNamesAuto userValidateCheck" />
									<img src="${imagePath}/btn/btn_tree.gif" id="referUserGenB" class="cursorPointer"/> 여러명 지정 가능</td>
 								</tr>
 								<tr>
								    <td class="title">처리담당자</td>
									<td class="pL10" colspan="3"><form:input  path="handlerMixs" cssClass="span_17 userNamesAuto userValidateCheck" />
									<img src="${imagePath}/btn/btn_tree.gif" id="handlerUserGenB" class="cursorPointer"/> 여러명 지정 가능</td>
 								</tr>
 								<tr>
								    <td class="title">사용여부</td>
									<td class="pL10" colspan="3">
										<form:radiobutton path="useYn"  value="1" label="사용"/>
										<form:radiobutton path="useYn"  value="2" label="사용안함"/>
									</td>
 								</tr>                      	
		                    </tbody>
		                    </table>
						</div>
						</form:form>
						<!-- 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<img id="submitB" class="cursorPointer" src="${imagePath}/btn/btn_modify.gif"/>
		                	<img id="backB" class="cursorPointer" src="${imagePath}/btn/btn_cancel.gif"/>
		                </div>
		                <!-- 버튼 끝 -->						
						
					</div>
					<!-- E: section -->	
				</div>
				<!-- E: center -->
			</div>	
			<!-- E: centerBg -->		
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/admin_footer.jsp"%>
</div>
</body>
</html>
