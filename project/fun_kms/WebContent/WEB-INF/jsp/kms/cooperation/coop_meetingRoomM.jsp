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
function update() {
	$('#pushYn1').val($('#pushYn').is(':checked') ? 'Y': 'N');
	document.frm.mtCn.value = myeditor.outputBodyHTML();
	if (!validateMeeting(document.frm)) {
		return;
	}

	document.frm.submit();					
}
function cancel() {
	document.frm.action = "<c:url value='${rootPath}/cooperation/selectMeetingRoom.do'/>";
	document.frm.submit();
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
							<li class="stitle">펀네트 회의실 수정하기</li>
							<li class="navi">홈 > 업무공유 > 협업 > 펀네트 회의실</li>
						</ul>
					</div>
					
	
					<!-- S: section -->
					<div class="section01">

						<!-- 게시판 시작  -->
						<form:form name="frm" commandName="MeetingRoom" action="${rootPath}/cooperation/updateMeetingRoom.do" enctype="multipart/form-data">
						<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
						<input type="hidden" name="searchPrjNm" value="${searchVO.searchPrjNm}"/>
						<input type="hidden" name="searchPrjId" value="${searchVO.searchPrjId}"/>
						<input type="hidden" name="includeUnderProject" value="${searchVO.includeUnderProject}"/>
						<input type="hidden" name="searchCondition" value="${searchVO.searchCondition}"/>
						<input type="hidden" name="searchKeyword" value="${searchVO.searchKeyword}"/>
						<input type="hidden" name="searchUserNm" value="${searchVO.searchUserNm}"/>
						<input type="hidden" name="returnUrl" value="<c:url value='${rootPath}/cooperation/updateMeetingRoomView.do'/>"/>
						<input type="hidden" name="mtId" value="${result.mtId}"/>
						<input type="hidden" name="attachFileId" value="${result.attachFileId}"/>
						<input type="hidden" name="userNo" value="${result.userNo}"/>
						
						<div class="boardWrite">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>업무연락 작성하기</caption>
							<colgroup>
								<col class="col100" />
								<col class="col270" />
								<col class="col100" />
								<col width="px" />
							</colgroup>
							<thead>
								<tr>
									<th class="write_info">회의명(*)</th>
									<th class="write_info2" colspan="3"><input type="text" name="mtSj" class="write_input" value="${result.mtSj}"/></th>
								</tr>
								<tr>
									<th class="write_info">작성자</th>
									<th class="write_info2" colspan="3">
									<print:user userNo="${result.userNo}" userNm="${result.userNm}" userId="${result.userId}" printId="true"/></th>									
								</tr>
								<tr>
									<th class="write_info">참석자(*)</th>
									<th class="write_info2" colspan="3">
										<input type="text" class="span_12 userNamesAuto userValidateCheck" name="recUserMixes" id="recUserMixes"
											value="<c:forEach items="${result.recieveList}" var="rec">${rec.userNm}(${rec.userId}), </c:forEach>" />
										<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('recUserMixes',0)"/>
									</th>
								</tr>
								<tr>
									<th class="write_info">참조자</th>
									<th class="write_info2" colspan="3">
										<input type="text" class="span_12 userNamesAuto userValidateCheck" name="refUserMixes" id="refUserMixes"
											value="<c:forEach items="${result.referenceList}" var="ref">${ref.userNm}(${ref.userId}), </c:forEach>" />
										<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('refUserMixes',0)" />
									</th>
								</tr>
								<tr>
									<th class="write_info">프로젝트(*)</th>
									<th class="write_info2" colspan="3">
										<input type="text" class="span_12" name="prjNm" id="prjNm" value="${result.prjNm}" readonly="readonly" onclick="prjGen('prjNm','prjId',1)" onfocus="prjGen('prjNm','prjId',1)"/>
										<input type="hidden" class="span_12" name="prjId" id="prjId" value="${result.prjId}"/>
										<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen('prjNm','prjId',1)" />
									</th>
								</tr>
								<tr>
									<th class="write_info">회의일시(*)</th>
									<th class="write_info2" colspan="3">
										<input type="text" name="mtDate" id="mtDate" class="span_6 calGen" value="${result.mtDate}"/>
										<span id="mark">&nbsp;</span>
										<select name="mtFrTm" id="mtFrTm">
											<option value="01" <c:if test="${result.mtFrTm == '01'}">selected="selected"</c:if>>01</option>
											<option value="02" <c:if test="${result.mtFrTm == '02'}">selected="selected"</c:if>>02</option>
											<option value="03" <c:if test="${result.mtFrTm == '03'}">selected="selected"</c:if>>03</option>
											<option value="04" <c:if test="${result.mtFrTm == '04'}">selected="selected"</c:if>>04</option>
											<option value="05" <c:if test="${result.mtFrTm == '05'}">selected="selected"</c:if>>05</option>
											<option value="06" <c:if test="${result.mtFrTm == '06'}">selected="selected"</c:if>>06</option>
											<option value="07" <c:if test="${result.mtFrTm == '07'}">selected="selected"</c:if>>07</option>
											<option value="08" <c:if test="${result.mtFrTm == '08'}">selected="selected"</c:if>>08</option>
											<option value="09" <c:if test="${result.mtFrTm == '09'}">selected="selected"</c:if>>09</option>
											<option value="10" <c:if test="${result.mtFrTm == '10'}">selected="selected"</c:if>>10</option>
											<option value="11" <c:if test="${result.mtFrTm == '11'}">selected="selected"</c:if>>11</option>
											<option value="12" <c:if test="${result.mtFrTm == '12'}">selected="selected"</c:if>>12</option>
											<option value="13" <c:if test="${result.mtFrTm == '13'}">selected="selected"</c:if>>13</option>
											<option value="14" <c:if test="${result.mtFrTm == '14'}">selected="selected"</c:if>>14</option>
											<option value="15" <c:if test="${result.mtFrTm == '15'}">selected="selected"</c:if>>15</option>
											<option value="16" <c:if test="${result.mtFrTm == '16'}">selected="selected"</c:if>>16</option>
											<option value="17" <c:if test="${result.mtFrTm == '17'}">selected="selected"</c:if>>17</option>
											<option value="18" <c:if test="${result.mtFrTm == '18'}">selected="selected"</c:if>>18</option>
											<option value="19" <c:if test="${result.mtFrTm == '19'}">selected="selected"</c:if>>19</option>
											<option value="20" <c:if test="${result.mtFrTm == '20'}">selected="selected"</c:if>>20</option>
											<option value="21" <c:if test="${result.mtFrTm == '21'}">selected="selected"</c:if>>21</option>
											<option value="22" <c:if test="${result.mtFrTm == '22'}">selected="selected"</c:if>>22</option>
											<option value="23" <c:if test="${result.mtFrTm == '23'}">selected="selected"</c:if>>23</option>
											<option value="24" <c:if test="${result.mtFrTm == '24'}">selected="selected"</c:if>>24</option>
										</select> ~
										<select name="mtToTm" id="mtToTm">
											<option value="01" <c:if test="${result.mtToTm == '01'}">selected="selected"</c:if>>01</option>
											<option value="02" <c:if test="${result.mtToTm == '02'}">selected="selected"</c:if>>02</option>
											<option value="03" <c:if test="${result.mtToTm == '03'}">selected="selected"</c:if>>03</option>
											<option value="04" <c:if test="${result.mtToTm == '04'}">selected="selected"</c:if>>04</option>
											<option value="05" <c:if test="${result.mtToTm == '05'}">selected="selected"</c:if>>05</option>
											<option value="06" <c:if test="${result.mtToTm == '06'}">selected="selected"</c:if>>06</option>
											<option value="07" <c:if test="${result.mtToTm == '07'}">selected="selected"</c:if>>07</option>
											<option value="08" <c:if test="${result.mtToTm == '08'}">selected="selected"</c:if>>08</option>
											<option value="09" <c:if test="${result.mtToTm == '09'}">selected="selected"</c:if>>09</option>
											<option value="10" <c:if test="${result.mtToTm == '10'}">selected="selected"</c:if>>10</option>
											<option value="11" <c:if test="${result.mtToTm == '11'}">selected="selected"</c:if>>11</option>
											<option value="12" <c:if test="${result.mtToTm == '12'}">selected="selected"</c:if>>12</option>
											<option value="13" <c:if test="${result.mtToTm == '13'}">selected="selected"</c:if>>13</option>
											<option value="14" <c:if test="${result.mtToTm == '14'}">selected="selected"</c:if>>14</option>
											<option value="15" <c:if test="${result.mtToTm == '15'}">selected="selected"</c:if>>15</option>
											<option value="16" <c:if test="${result.mtToTm == '16'}">selected="selected"</c:if>>16</option>
											<option value="17" <c:if test="${result.mtToTm == '17'}">selected="selected"</c:if>>17</option>
											<option value="18" <c:if test="${result.mtToTm == '18'}">selected="selected"</c:if>>18</option>
											<option value="19" <c:if test="${result.mtToTm == '19'}">selected="selected"</c:if>>19</option>
											<option value="20" <c:if test="${result.mtToTm == '20'}">selected="selected"</c:if>>20</option>
											<option value="21" <c:if test="${result.mtToTm == '21'}">selected="selected"</c:if>>21</option>
											<option value="22" <c:if test="${result.mtToTm == '22'}">selected="selected"</c:if>>22</option>
											<option value="23" <c:if test="${result.mtToTm == '23'}">selected="selected"</c:if>>23</option>
											<option value="24" <c:if test="${result.mtToTm == '24'}">selected="selected"</c:if>>24</option>
										</select>
									</th>
								</tr>
								<tr id="trWsPlace">
									<th class="write_info">회의장소(*)</th>
									<th class="write_info2">
										<input type="text" name="mtPlace" id="mtPlace" class="span_10" value="${result.mtPlace}"/>
									</th>
									<th class="write_info">회의장소 구분</th>
									<th class="write_info2">
										<c:forEach items="${mtPlaceTypList}" var="typ" varStatus="c">
											<label>
											<input type="radio" name="mtPlaceTyp" value="${typ.code}" <c:if test="${result.mtPlaceTyp==typ.code}">checked="checked"</c:if> />${typ.codeNm} &nbsp;
											</label>
										</c:forEach>
									</th>
								</tr>
								<tr>
									<th class="write_info">회의알림</th>
									<th class="write_info2" colspan="3">
										<!-- 
										<input type="checkbox" name="pushYn" <c:if test="${result.pushYn1 == 'Y'}">disabled="disabled"</c:if> value="${result.pushYn1}" <c:if test="${result.pushYn1 == 'Y'}">checked="checked"</c:if>>
										 -->
										<input type="checkbox" id="pushYn" name="pushYn">
										<input type="hidden" id="pushYn1" name="pushYn1" value="" />
										회의참석자, 참조자에게 회의실이 개설 되었음을  Push메세지 및 쪽지로 알립니다.
									</th>
								</tr>
								<tr>
									<th class="write_info">회의자료</th>
									<th class="write_info2" colspan="3">
										<c:if test="${not empty result.attachFileId}">
											<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${result.attachFileId}" />
											</c:import>
										</c:if>	
										<c:if test="${result.attachFileId == ''}">
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
									<td colspan="4">
										<textarea rows="9" cols="100" name="mtCn" id="mtCn"><c:out value="${result.mtCn}" escapeXml="false"/></textarea>
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
