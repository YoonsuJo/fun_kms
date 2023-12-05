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
<script>

//이 파일은 사용안함 support 폴더에서 community 폴더로 이동
$(function(){
	$('#btn_regist').click(function(){
		if($('#subject').val() == ""){
			alert("제목은 필수 입력값입니다.");
			$('#subject').focus();
			return false;
		}
		if($('#gubunNo').val() == ""){
			alert("업무구분은 필수 입력값입니다.");
			$('#gubunNo').focus();
			return false;
		}
		document.frm.content.value = myeditor.outputBodyHTML();
		if($('#content').val() == ""){
			alert("내용은 필수 입력값입니다.");
			$('#content').focus();
			return false;
		}
		$('#frm').attr('action', '${rootPath}/support/bpManualWriteP.do');
		$('#frm').submit();
	});
	$('#btn_cancel').click(function(){
		$('#frm').attr('action', '${rootPath}/support/bpManualList.do');
		$('#frm').submit();
	});
	$('#btn_insertGubun').click(function(){
		var popup = window.open("${rootPath}/support/bpManualGubunList.do", "_GUBUN_ADD_POP_","width=560px,height=570px,scrollbars=yes");
		popup.focus();
	});
});
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
							<li class="stitle">게시글 작성하기</li>
							<li class="navi">홈 > 업무지원 > 업무처리지원</li>
						</ul>
					</div>
					
	
					<!-- S: section -->
					<div class="section01">
						<p class="th_stitle">업무처리절차</p>

						<!-- 게시판 시작  -->
						<form id="frm" name="frm" method="post" enctype="multipart/form-data">
						<input type="hidden" name="searchCondition" value="${bpmVO.searchCondition}"/>
						<input type="hidden" name="searchKeyword" value="${bpmVO.searchKeyword}"/>
						<input type="hidden" name="searchCheck" value="${bpmVO.searchCheck}"/>
						<input type="hidden" name="searchGubunNo" value="${bpmVO.searchGubunNo}"/>
						<input type="hidden" name="pageIndex" value="${bpmVO.pageIndex}"/>
						
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
			                        <th class="write_info2">
			                        	<input type="text" id="subject" name="subject" class="write_input" />
			                        </th>
		                        </tr>
		                        <tr>
			                        <th class="write_info">업무 구분</th>
			                        <th class="write_info2">
			                        	<select id="gubunNo" name="gubunNo">
			                        		<option value="">-- 업무 구분 --</option>
			                        		<c:forEach items="${gubunList}" var="gubunList">
											<option value="${gubunList.gubunNo}">${gubunList.gubunNm}</option>
											</c:forEach>
			                        	</select>
			                        	<input type="button" id="btn_insertGubun" value="업무구분 등록"/>
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
									</th>
		                        </tr>
		                    </thead>
		                    <tbody>
		                    	<tr>
			                    	<td colspan="2">
			                    		<textarea rows="9" cols="100" name="content" id="content"></textarea>
			                    		<script type="text/javascript" language="javascript">
											var myeditor = new cheditor();
											myeditor.config.editorHeight = '400px';
											myeditor.config.editorWidth = '100%';
											myeditor.inputForm = 'content';
											myeditor.run();
										</script>
			                    	</td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						</form>
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<img src="${imagePath}/btn/btn_regist.gif" class="cursorPointer" id="btn_regist"/>
		                	<img src="${imagePath}/btn/btn_cancel.gif" class="cursorPointer" id="btn_cancel"/>
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
