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
<validator:javascript formName="Mission" staticJavascript="false" xhtml="true" cdata="false"/>

<script>
function register() {
	document.frm.missionCn.value = myeditor.outputBodyHTML();
	document.frm.submit();					
}
function cancel() {
	document.frm.action = '${searchVO.redirectUrl}';
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
							<li class="stitle">서브 미션 추가</li>
							<li class="navi">홈 > 업무공유 > Mission Clear > 미션</li>
						</ul>
					</div>
					
	
					<!-- S: section -->
					<div class="section01">

						<!-- 게시판 시작  -->

			    		<form:form name="frm" commandName="Mission" action="${rootPath}/cooperation/insertMission.do" enctype="multipart/form-data">
			    		<input type="hidden" name="type" id="type" value="S"/>	
			    		<c:set var="missionLv" value="${mission.missionLv + 1}"/>
			    		<input type="hidden" name="missionLv" value="${missionLv}"/>	
						<input type="hidden" name="redirectUrl" value="${searchVO.redirectUrl}"/>
			    	    	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>서브 미션 추가</caption>
		                    <colgroup>
			                    <col class="col100" />
			                    <col width="px" />
		                    </colgroup>
		                    <thead>
		                        <tr>
			                    	<th class="write_info">프로젝트</th>
			                    	<th class="write_info2">
			                    		<input type="text" class="span_12" name="prjNm" id="prjNm" value="${mission.prjNm}" readonly="readonly"/>
			                    		<input type="hidden" class="span_12" name="prjId" id="prjId" value="${mission.prjId}"/>			                    		
			                    	</th>
		                        </tr>
		                        
		                        <tr>
			                    	<th class="write_info">상위 미션</th>
			                    	<th class="write_info2">
			                    		<input type="text" class="span_12" name="prntMissionNm" id="prntMissionNm" readonly="readonly" value="${mission.missionNm}"/>
			                    		<input type="hidden" class="span_12" name="prntMissionId" id="prntMissionId" value="${mission.missionId}" />
			                    	</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">담당자</th>
			                    	<th class="write_info2">
			                    		<input type="text" class="span_12 userNamesAuto userValidateCheck" name="leaderMixes" id="leaderMixes" />
			                    		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('leaderMixes',0)"/>
			                    	</th>
		                        </tr>
		                        
		                        <tr>
			                    	<th class="write_info">완료예정일</th>
			                    	<th class="write_info2">
			                    		<input type="text" name="dueDt" id="dueDt" class="span_6 calGen" />		                    		
			                    	</th>
		                    	</tr>
		                    	

		                    	<tr>
			                        <th class="write_info">미션명</th>
			                        <th class="write_info2"><input type="text" name="missionNm" class="write_input" /></th>
		                        </tr>
		                        
		                        <tr>
			                    	<th class="write_info">첨부파일</th>
			                    	<th class="write_info2">
										<input name="file_1" id="egovComFileUploader" type="file" class="write_input"/>
										<div id="egovComFileList"></div>
										<script type="text/javascript">
											var maxFileNum = 3;
											var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum , 'write_input');
											multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
										</script>
										<span>※ 첨부파일의 최대 용량은 70MB입니다.</span>
									</th>
		                        </tr>	                        
		                    </thead>
		                    <tbody>
		                    	<tr>
			                    	<td colspan="2">
			                    		<textarea rows="9" cols="100" name="missionCn" id="missionCn"></textarea>
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
		                	<a href="javascript:register();"><img src="${imagePath}/btn/btn_regist.gif"/></a>
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
