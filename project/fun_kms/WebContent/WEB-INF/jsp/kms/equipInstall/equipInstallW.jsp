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
$(function(){
	$('.btn_area02 img:eq(0)').click(function(){
		if($('#subject').val() == ""){
			alert("제목을 입력하셔야 합니다.");
			$('#subject').focus();
			return false;
		}
		if($('#prjId').val() == ""){
			alert("프로젝트를 선택해 주시기 바랍니다.");
			prjGen('prjNm','prjId',1);
			return false;
		}
		if($('#customer').val() == ""){
			alert("고객사를 입력해 주시기 바랍니다.");
			$('#customer').focus();
			return false;
		}
		if($('#solutionCode').val() == ""){
			alert("납품 할 솔루션을 선택해주시기 바랍니다.");
			$('#solutionCode').focus();
			return false;
		}
		if($('#content').val() == ""){
			alert("요청 내용을 입력하셔야 합니다.");
			$('#content').focus();
			return false;
		}
		if($('#subject').length > 255){
			alert("255자 이상 입력 할 수 없습니다.");
			$('#solutionName').focus();
			return false;
		}
		if($('#customer').length > 100){
			alert("100자 이상 입력 할 수 없습니다.");
			$('#solutionName').focus();
			return false;
		}
		if(confirm("작성된 내용으로 설치 요청을 진행 하시겠습니까?")){
			$('#frm').attr('action', '${rootPath}/equipInstall/equipInstallWP.do');
			$('#frm').submit();
		}
	});
	$('.btn_area02 img:eq(1)').click(function(){
		$('#searchfrm').attr('action', '${rootPath}/equipInstall/equipInstallL.do');
		$('#searchfrm').submit();
	});

	$('#btnRegist').click(function(){
		var popup = window.open("${rootPath}/equipInstall/equipmentAdd.do", "_EQUIPMENT_ADD_POP_","width=560px,height=570px,scrollbars=yes");
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
							<li class="stitle">솔루션 납품 설치요청 등록</li>
							<li class="navi">홈 > 업무지원 > 솔루션 장비 납품 설치요청 등록</li>
						</ul>
					</div>
					
					<!-- S: section -->
					<div class="section01">
						<p class="th_stitle mB10">설치 요청</p>
						
						<!-- 게시판 시작  -->
						<form name="searchfrm" id="searchfrm" method="post">
							<input type="hidden" name="searchPrjId" value="${searchVO.searchPrjId}"/>
							<input type="hidden" name="searchPrjNm" value="${searchVO.searchPrjNm}"/>
							<input type="hidden" name="searchSubject" value="${searchVO.searchSubject}"/>
							<input type="hidden" name="searchUserId" value="${searchVO.searchUserId}"/>
							<input type="hidden" name="searchUserNm" value="${searchVO.searchUserNm}"/>
							<input type="hidden" name="searchGubun" value="${searchVO.searchGubun}"/>
							<input type="hidden" name="pageIndex" value="${eiVO.pageIndex}"/>
						</form>
						<form name="frm" id="frm" method="post" enctype="multipart/form-data">
						
						
						
						<div class="boardWrite">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>솔루션 장비 납품 설치요청 등록</caption>
		                    
		                    <colgroup>
			                    <col class="col100" />
			                    <col width="px" />
		                    </colgroup>
		                    
		                    <thead>
		                    	<tr>
			                        <th class="write_info">제목</th>
			                        <th class="write_info2"><input type="text" id="subject" name="subject" class="write_input" maxlength="255" /></th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">프로젝트</th>
			                    	<th class="write_info2">
			                    		<input type="text" class="span_12" name="prjNm" id="prjNm" readonly="readonly" onclick="prjGen('prjNm','prjId',1)" onfocus="prjGen('prjNm','prjId',1)"/>
			                    		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen('prjNm','prjId',1)" />
			                    		<input type="hidden" name="prjId" id="prjId" />
			                    	</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">고객사</th>
			                    	<th class="write_info2">
			                    		<input type="text" class="span_12" name="customer" id="customer" maxlength="100"/>
			                    	</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">납품 솔루션</th>
			                    	<th class="write_info2">
			                    		<select id="solutionCode" name="solutionCode">
			                    			<option value="">-- 솔루션 --</option>
			                    			<c:forEach items="${sList}" var="element">
			                    				<option value="${element.solutionCode}">${element.solutionNm}</option>
			                    			</c:forEach>
			                    		</select>
			                    		<img src="${imagePath}/btn/btn_solutionRegist.gif" class="cursorPointer" id="btnRegist"/>
			                    	</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">요청 내용</th>
			                    	<th class="write_info2">
			                    		<textarea rows="18" cols="100" name="content" id="content"></textarea>
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
		                    </tbody>
		                    </table>
						</div>
						</form>
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<img src="${imagePath}/btn/btn_regist.gif" class="cursorPointer"/>
		                	<img src="${imagePath}/btn/btn_cancel.gif" class="cursorPointer"/>
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