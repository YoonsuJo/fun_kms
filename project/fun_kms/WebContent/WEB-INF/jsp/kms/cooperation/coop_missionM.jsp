<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/cheditor.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/utils/imageUtil.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="Mission" staticJavascript="false" xhtml="true" cdata="false"/>

<script>
function update() {
	document.frm.missionCn.value = myeditor.outputBodyHTML();
	if(nullMissionChk() == true){    	
	document.frm.submit();	
    }				
}


function nullMissionChk(){
	var bol = true;

	if(document.frm.leaderMixes.value == ""){
		alert('담당자를 입력하십시오.');
		bol = false;		
	}

	if(document.frm.dueDt.value == ""){
		alert('완료예정일을 입력하십시오.');
		bol = false;		
	}else{
		var dueDt = document.frm.dueDt.value;
		var prntDueDt = document.frm.prntDueDt.value;
		var missionLv = document.frm.missionLv.value;
		var chdMissionDt = document.frm.chdMissionDt.value;
		
		if(dueDt > prntDueDt && missionLv != 0){
			//document.frm.leaderMixes.value = "";
			//document.frm.dueDt.value = "";
			//document.frm.historyCn.value = "";
			//document.frm.missionStat.value = "";
	
			alert("상위 미션 완료일"+prntDueDt+"을 초과합니다.");
			bol = false;
		}else if(chdMissionDt > dueDt){
			//document.frm.leaderMixes.value = "";
			//document.frm.dueDt.value = "";
			//document.frm.historyCn.value = "";
			//document.frm.missionStat.value = "";
	
			alert("하위 미션 완료일"+chdMissionDt+"을 초과합니다.");
			bol = false;
		}
	}

	if(document.frm.missionNm.value == ""){
		alert('미션명을 입력하십시오.');
		bol = false;		
	}
	if(document.frm.missionCn.value == ""){
		alert('미션 내용을 입력하십시오.');
		bol = false;		
	}
	
	return bol; 
}

function cancel() {
	document.frm.redirectUrl.value = "${rootPath}/cooperation/selectMissionMyList.do?type=${searchVO.type}&includeEndMission=${searchVO.includeEndMission}";
	document.frm.action = "<c:url value='${rootPath}/cooperation/selectMission.do'/>";
	document.frm.submit();

	//history.back();	
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
							<li class="stitle">미션 수정</li>
							<li class="navi">홈 > 업무공유 > Mission Clear > 미션</li>
						</ul>
					</div>
					
	
					<!-- S: section -->
					<div class="section01">

						<!-- 게시판 시작  -->
						<form:form name="frm" commandName="Mission" action="${rootPath}/cooperation/updateMission.do" enctype="multipart/form-data">
						<input type="hidden" name="type" 				value="${searchVO.type}"/>
						<input type="hidden" name="missionId" 			value="${mission.missionId}"/>
						<input type="hidden" name="missionLv" 			value="${mission.missionLv}"/>
						<input type="hidden" name="attachFileId" 		value="${mission.attachFileId}"/>
						<input type="hidden" name="userNo"				value="${mission.userNo}"/>
		         		<input type="hidden" name="redirectUrl" 		value="${searchVO.redirectUrl}"/>
		         		<input type="hidden" name="searchDate" 			value="${searchVO.searchDate}"/>			    					    					 
			    		<input type="hidden" name="searchLeaderMixes" 	value="${searchVO.searchLeaderMixes}"/>	
			    		<input type="hidden" name="searchPrjId" 		value="${searchVO.prjId}"/>
			    		<input type="hidden" name="searchPrjNm" 		value="${searchVO.prjNm}"/>	
			    		<input type="hidden" name="searchDateS" 		value="${searchVO.searchDateS}"/>	
			    		<input type="hidden" name="searchDateE" 		value="${searchVO.searchDateE}"/>	
			    		<input type="hidden" name="searchWriterNm" 		value="${searchVO.searchWriterNm}"/>	
			    		<input type="hidden" name="includeICMission" 	value="${searchVO.includeICMission}"/>	
			    		<input type="hidden" name="includeCMission" 	value="${searchVO.includeCMission}"/>	
			    		<input type="hidden" name="searchKeyword" 		value="${searchVO.searchKeyword}"/>
			    		<input type="hidden" name="missionTree"         value="${mission.missionTree }"/>
			    		<input type="hidden" name="searchVO"            value="${searchVO.includeEndMission }"/>
			    		<input type="hidden" name="prntDueDt"           value="${mission.prntDueDt}"/>
			    		<input type="hidden" name="chdMissionDt"        value="${mission.chdMissionDt }"/>
				
			    		<div class="boardWrite">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>미션 수정</caption>
		                    <colgroup>
			                    <col class="col100" />
			                    <col width="px" />
		                    </colgroup>
		                    <thead>
		                      
		                        <tr>
			                    	<th class="write_info">프로젝트${mission.includeEndMission }</th>
			                    	<th class="write_info2">
			                    		<input type="text" class="span_12" name="prjNm" id="prjNm" value="${mission.prjNm}" readonly="readonly"  <c:if test="${mission.missionLv == '0'}"> onclick="prjGen('prjNm','prjId',1)" onfocus="prjGen('prjNm','prjId',1)"</c:if>/>
			                    		<input type="hidden" class="span_12" name="prjId" id="prjId" value="${mission.prjId}" />
			                    		<c:if test="${mission.missionLv == '0'}"><img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen('prjNm','prjId',1)" /></c:if>
			                    	</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">상위 미션</th>
			                    	<th class="write_info2">
			                    		<input type="text" class="span_12" name="prntMissionNm" id="prntMissionNm" value="${mission.prntMissionNm}" readonly="readonly"/>
			                    		<input type="hidden" name="prntMissionId" id="prntMissionId" value="${mission.prntMissionId}"/>
			                    	</th>
		                        </tr>     
		                        <tr>
			                    	<th class="write_info">담당자</th>
			                    	<th class="write_info2">
			                    		<input type="text" class="span_12 userNamesAuto userValidateCheck" name="leaderMixes" id="leaderMixes" value="${mission.leaderNm}(${mission.leaderId})" />
			                    		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('leaderMixes',1)"/>
			                    	</th>
		                        </tr>
		                        
		                        <tr>
			                    	<th class="write_info">완료예정일</th>
			                    	<th class="write_info2">
			                    		<input type="text" name="dueDt" id="dueDt" class="span_6 calGen" value="${mission.dueDt}"/>		                    		
			                    	</th>
		                    	</tr>
		                    	

		                    	<tr>
			                        <th class="write_info">미션명</th>
			                        <th class="write_info2"><input type="text" name="missionNm" value="${mission.missionNm}" class="write_input" /></th>
		                        </tr>
		                        
		                        <tr>
									<th class="write_info">첨부파일</th>
									<th class="write_info2">
										<c:if test="${not empty mission.attachFileId}">
											<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${mission.attachFileId}" />
											</c:import>
										</c:if>	
										<c:if test="${mission.attachFileId == ''}">
											<input type="hidden" name="fileListCnt" value="0" />
										</c:if>
										<div id="file_upload_posbl"  style="display:none;" >	
											<input type="file" name="file_1" id="egovComFileUploader" class="write_input"/>
											<div id="egovComFileList"></div>
										</div>
										<div id="file_upload_imposbl"  style="display:none;" >
											<spring:message code="common.imposbl.fileupload" />
										</div>			

										<script type="text/javascript">
										var existFileNum = document.frm.fileListCnt.value;
										var maxFileNum = 3;
										
										if (existFileNum=="undefined" || existFileNum ==null) {
											existFileNum = 0;
										}
										var uploadableFileNum = maxFileNum - existFileNum;
										if (uploadableFileNum<0) {
											uploadableFileNum = 0;
										}
										if (uploadableFileNum != 0) {
											fn_egov_check_file('Y');
											var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum , 'write_input');
											multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
										} else {
											fn_egov_check_file('N');
										}
										</script>
									</th>
								</tr>						                  
		                    </thead>
		                    <tbody>
		                    	<tr>
			                    	<td colspan="2">
			                    		<textarea rows="9" cols="100" name="missionCn" id="missionCn">${mission.missionCn}</textarea>
			                    		<script type="text/javascript" language="javascript">
											var myeditor = new cheditor();
											myeditor.config.editorHeight = '400px';
											myeditor.config.editorWidth = '100%';
											myeditor.inputForm = 'missionCn';
											myeditor.run();
										</script>
			                    	</td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						</form:form>
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<a href="javascript:update();"><img src="${imagePath}/btn/btn_regist.gif"/></a>
		                	<a href="javascript:cancel();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
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
