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
<validator:javascript formName="BusiContact" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function register() {
	document.frm.bcCn.value = myeditor.outputBodyHTML();
	if (!addedValidateBusi()) {
		return;
	}
	if (!validateBusiContact(document.frm)) {
		return;
	}
	document.frm.submit();
}

function addedValidateBusi() {
	var bcSj = document.frm.bcSj.value;
	if (bcSj.indexOf('\'') > -1 || bcSj.indexOf('"') > -1) {
		alert('특수문자 \', " 은 입력할 수 없습니다.');
		return false;	
	}
	return true;
}

function list() {
	document.frm.action = "<c:url value='${rootPath}/cooperation/selectBusinessContactList.do'/>";
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
							<li class="stitle">업무연락 작성하기</li>
							<li class="navi">홈 > 업무공유 > 협업 > 업무연락</li>
						</ul>
					</div>
					
	
					<!-- S: section -->
					<div class="section01">

						<!-- 게시판 시작  -->
						<form:form name="frm" commandName="BusiContact" action="${rootPath}/cooperation/insertBusinessContact.do" enctype="multipart/form-data">
			    		<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
			    		<input type="hidden" name="searchPrjNm" value="${searchVO.searchPrjNm}"/>
			    		<input type="hidden" name="searchPrjId" value="${searchVO.searchPrjId}"/>
			    		<input type="hidden" name="includeUnderProject" value="${searchVO.includeUnderProject}"/>
			    		<input type="hidden" name="searchCondition" value="${searchVO.searchCondition}"/>
			    		<input type="hidden" name="searchKeyword" value="${searchVO.searchKeyword}"/>
			    		<input type="hidden" name="searchUserNm" value="${searchVO.searchUserNm}"/>
						
						<div class="boardWrite">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>업무연락 작성하기</caption>
		                    <colgroup>
			                    <col class="col100" />
			                    <col width="px" />
		                    </colgroup>
		                    <thead>
		                    	<tr>
			                        <th class="write_info">제목</th>
			                        <th class="write_info2"><input type="text" name="bcSj" class="write_input" /></th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">수신자</th>
			                    	<th class="write_info2">
			                    		<input type="text" class="span_12 userNamesAuto userValidateCheck" name="recUserMixes" id="recUserMixes" />
			                    		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('recUserMixes',0)"/>
			                    	</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">참조자</th>
			                    	<th class="write_info2">
			                    		<input type="text" class="span_12 userNamesAuto userValidateCheck" name="refUserMixes" id="refUserMixes" />
			                    		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('refUserMixes',0)" />
			                    	</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">프로젝트</th>
			                    	<th class="write_info2">
			                    		<input type="text" class="span_12" name="prjNm" id="prjNm" readonly="readonly" onclick="prjGen('prjNm','prjId',1)" onfocus="prjGen('prjNm','prjId',1)"/>
			                    		<input type="hidden" class="span_12" name="prjId" id="prjId" />
			                    		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen('prjNm','prjId',1)" />
			                    	</th>
		                        </tr>
		                        <!--<tr>
			                    	<th class="write_info">SMS 연동</th>
			                    	<th class="write_info2">
			                    		<label>
			                    		<input type="checkbox" name="smsYn" class="cursorPointer check" value="Y">
			                    		수신자, 참조자에게 업무연락이 수신되었음을  SMS로 알립니다.</label>
			                    	</th>
		                        </tr>-->
								<!-- //2013.09.20 김대현 PUSH 적용 -->
		                        <tr>
			                    	<th class="write_info">PUSH 연동</th>
			                    	<th class="write_info2">
			                    		<label>
			                    		<input type="checkbox" name="pushYn" class="cursorPointer check" value="Y">
			                    		수신자, 참조자에게 업무연락이 수신되었음을  PUSH로 알립니다.</label>
			                    	</th>
		                        </tr>
		                        
		                        <tr>
			                    	<th class="write_info">댓글 허용</th>
			                    	<th class="write_info2">			                    		
										<label>
										<input type="checkbox" name="commentYn" class="cursorPointer check" value="Y" checked="checked">										
			                    		댓글작성을 허용합니다.</label> 	
			                    	</th>
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
			                    		<textarea rows="9" cols="100" name="bcCn" id="bcCn"></textarea>
			                    		<script type="text/javascript" language="javascript">
											var myeditor = new cheditor();
											myeditor.config.editorHeight = '400px';
											myeditor.config.editorWidth = '100%';
											myeditor.inputForm = 'bcCn';
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
		                	<a href="javascript:list();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
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
