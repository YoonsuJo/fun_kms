<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>

<script>
function collectionSearch(pageIndex) {
	document.colFrm.pageIndex.value = pageIndex;
	document.colFrm.action = '<c:url value="${rootPath}/management/collectionFullL.do" />';
	document.colFrm.submit();
}
function popCollection(bondPrjNo){
	document.colFrm.bondPrjNo.value = bondPrjNo;
	
	var POP_NAME = "_POP_COLLECTION_LIST_";
	var target = document.colFrm.target;
	document.colFrm.target = POP_NAME;
	document.colFrm.action = '<c:url value="${rootPath}/management/collectL.do" />';

	//var popup = window.showModalDialog('${rootPath}/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var popup = window.open("about:blank", POP_NAME, "width=560px,height=570px;");
	document.colFrm.submit();
	popup.focus();
	document.colFrm.target = target;
}
function thisRefresh() {
	document.colFrm.action = '<c:url value="${rootPath}/management/collectionFullL.do" />';
	document.colFrm.submit();
}
function excelSave(){
	$('#collectionVO').attr("action","/management/collectionExcelI.do");
	$('#collectionVO').submit();
	
};
$(document).ready(function(){
	var maxFileNum = 1;
	var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
	multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
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
							<li class="stitle">수금 등록</li>
							<li class="navi">홈 > 경영정보 > 채권관리 > 액셀로 수금 등록</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<form:form commandName="collectionVO" id="collectionVO" name="collectionVO" method="post" enctype="multipart/form-data" >
					
						<div class="section01">	
							
							<div class="boardWrite02 mB20">
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			                    <caption>공지사항 보기</caption>
			                    <colgroup><col class="col120" /><col width="px" /></colgroup>
			                    <tbody>
			                    	<tr>
				                    	<td class="title"  colspan="2">엑셀파일(*.xls)을 업로드하면 파싱해서 DB에 자동 입력합니다.</td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">파일</td>
				                    	<td class="pL10"><input name="file_1" id="egovComFileUploader" type="file" class="span_15" /></td>
			                    	</tr>
			                    	<tr>
									    <td colspan="2">
			      							<div id="egovComFileList"></div>
			      						</td>
		      						</tr>
			                    </tbody>
			                    </table>
							</div>
							<!-- 게시판 끝  -->
							
							<!-- 버튼 시작 -->
			                <div class="btn_area">
			                	<img src="${imagePath}/btn/btn_regist.gif" onclick="excelSave();" class="cursorPointer"/> 
			                	<img src="${imagePath}/btn/btn_cancel.gif" onclick="history.back(-1);" class="cursorPointer"/>
			                </div>
			                <!-- 버튼 끝 -->
			                
						</div>
					</form:form>
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
