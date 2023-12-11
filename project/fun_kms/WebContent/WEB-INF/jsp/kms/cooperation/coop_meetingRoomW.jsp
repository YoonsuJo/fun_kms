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
<validator:javascript formName="meeting" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function register() {
	document.frm.mtCn.value = myeditor.outputBodyHTML();
	if (!validateMeeting(document.frm)) {
		return;
	}
	document.frm.submit();					
}
function list() {
	document.frm.action = "<c:url value='${rootPath}/cooperation/selectMeetingRoomList.do'/>";
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
							<li class="stitle">회의실 개설하기</li>
							<li class="navi">홈 > 업무공유 > 협업 > 펀네트 회의실</li>
						</ul>
					</div>
					
	
					<!-- S: section -->
					<div class="section01">

						<!-- 게시판 시작  -->
						<form:form name="frm" commandName="MeetingRoom" action="${rootPath}/cooperation/insertMeetingRoom.do" enctype="multipart/form-data">
						<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
						<input type="hidden" name="searchPrjNm" value="${searchVO.searchPrjNm}"/>
						<input type="hidden" name="searchPrjId" value="${searchVO.searchPrjId}"/>
						<input type="hidden" name="includeUnderProject" value="${searchVO.includeUnderProject}"/>
						<input type="hidden" name="searchCondition" value="${searchVO.searchCondition}"/>
						<input type="hidden" name="searchKeyword" value="${searchVO.searchKeyword}"/>
						<input type="hidden" name="searchUserNm" value="${searchVO.searchUserNm}"/>
						
						<div class="boardWrite">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>회의실 개설하기</caption>
							<colgroup>
								<col class="col100" />
								<col class="col270" />
								<col class="col100" />
								<col width="px" />
							</colgroup>
							<thead>
								<tr>
									<th class="write_info">회의명(*)</th>
									<th class="write_info2" colspan="3"><input type="text" name="mtSj" class="write_input" /></th>
								</tr>
								<tr>
									<th class="write_info">참석자(*)</th>
									<th class="write_info2" colspan="3">
										<input type="text" class="span_12 userNamesAuto userValidateCheck" name="recUserMixes" id="recUserMixes" />
										<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('recUserMixes',0)"/>
									</th>
								</tr>
								<tr>
									<th class="write_info">참조자</th>
									<th class="write_info2" colspan="3">
										<input type="text" class="span_12 userNamesAuto userValidateCheck" name="refUserMixes" id="refUserMixes" />
										<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('refUserMixes',0)" />
									</th>
								</tr>
								<tr>
									<th class="write_info">프로젝트(*)</th>
									<th class="write_info2" colspan="3">
										<input type="text" class="span_12" name="prjNm" id="prjNm" readonly="readonly" onclick="prjGen('prjNm','prjId',1)" onfocus="prjGen('prjNm','prjId',1)"/>
										<input type="hidden" class="span_12" name="prjId" id="prjId" />
										<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen('prjNm','prjId',1)" />
									</th>
								</tr>
								<tr>
									<th class="write_info">회의일시(*)</th>
									<th class="write_info2" colspan="3">
										<input type="text" name="mtDate" id="mtDate" class="span_6 calGen" />
										<span id="mark">&nbsp;</span>
										<select name="mtFrTm" id="mtFrTm">
											<option value="">--</option>
											<c:forEach begin="1" end="24" var="i">
												<c:choose>
													<c:when test="${i<10}"><option value="0${i}">0${i}</option></c:when>
													<c:otherwise><option value="${i}">${i}</option></c:otherwise>
												</c:choose>
											</c:forEach>
										</select> ~
										<select name="mtToTm" id="mtToTm">
											<option value="">--</option>
											<c:forEach begin="1" end="24" var="i">
												<c:choose>
													<c:when test="${i<10}"><option value="0${i}">0${i}</option></c:when>
													<c:otherwise><option value="${i}">${i}</option></c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</th>
								</tr>
								<tr id="trWsPlace">
									<th class="write_info">회의장소(*)</th>
									<th class="write_info2">
										<input type="text" name="mtPlace" id="mtPlace" class="span_10" />
									</th>
									<th class="write_info">회의장소 구분</th>
									<th class="write_info2">
										<c:forEach items="${mtPlaceTypList}" var="typ" varStatus="c">
											<label>
											<input type="radio" name="mtPlaceTyp" value="${typ.code}" <c:if test="${c.count==1}">checked="checked"</c:if> />${typ.codeNm} &nbsp;
											</label>
										</c:forEach>
									</th>
								</tr>
								<tr>
									<th class="write_info">회의알림</th>
									<th class="write_info2" colspan="3">
										<input type="checkbox" name="pushYn1" value="Y">
										회의참석자, 참조자에게 회의실이 개설 되었음을  Push메세지 및 쪽지로 알립니다.
									</th>
								</tr>
								<tr>
									<th class="write_info">회의자료</th>
									<th class="write_info2" colspan="3">
										<input name="file_1" id="egovComFileUploader" type="file" class="write_input"/>
										<div id="egovComFileList"></div>
										<script type="text/javascript">
											var maxFileNum = 3;
											var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum , 'write_input');
											multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
										</script>
									</th>
								</tr>	                        
							</thead>
							<tbody>
								<tr>
									<td colspan="4">
										<textarea rows="9" cols="100" name="mtCn" id="mtCn"></textarea>
										<script type="text/javascript" language="javascript">
											var myeditor = new cheditor();
											myeditor.config.editorHeight = '400px';
											myeditor.config.editorWidth = '100%';
											myeditor.inputForm = 'mtCn';
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
