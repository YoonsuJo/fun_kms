<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function moveArticle() {
	return;
}
function modifyArticle() {
	document.frm.action = "<c:url value='${rootPath}/community/forUpdateBoardArticle.do'/>";
	document.frm.submit();		
}
function deleteArticle() {
	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.action = "<c:url value='${rootPath}/community/deleteBoardArticle.do'/>";
		document.frm.submit();
	}	
}
function answerArticle() {
	document.frm.action = "<c:url value='${rootPath}/community/addReplyBoardArticle.do'/>";
	document.frm.submit();
}
function listArticle() {
	document.frm.exChk.value = "";
	document.frm.action = "<c:url value='${rootPath}/community/selectBoardList.do'/>";
	<c:if test="${searchVO.fromUnread == 'Y'}">
	document.frm.action = "<c:url value='${rootPath}/community/selectUnreadBoardList.do'/>";
	</c:if>
	document.frm.submit();
}
function setDiscussState(exChk) {
	document.frm.exChk.value = exChk;
	document.frm.action = "<c:url value='${rootPath}/community/setDiscussState.do'/>";
	document.frm.submit();
}

var commentM;
var commentD;

$(document).ready(function() {

	var queryString = "${queryString}";
	var docIdList = ${docIdList};
	var bbsIdList = ${bbsIdList};
	var nth = 0;
	var residualDocCnt = docIdList.length;
	var comleteDocCnt = 0; 
	var postponeDocCnt = 0;

	var form = $('#frm');

	/*
	$('#listB').click(function(){
		location.replace("/approval/approvalL.do?" + queryString);
	});
	*/

	var loadDocF =function (){
		$('#residualDocCnt').html(residualDocCnt);
		$('#comleteDocCnt').html(comleteDocCnt);
		if(docIdList.length<=nth)
			$('#boardView').html("읽을 문서가 없습니다.");
		else{
			$.post("/community/selectBoardArticle.do?nttId=" + docIdList[nth] + "&bbsId=" + bbsIdList[nth] + "&ajaxMode=1",
					function(data){
				$('#boardView').html(data);
				$('#nextB').click(nextF);
				$('#registComment').click(commentF);
				form = $('#frm');
				//$('#commentWriteDocId').val(docIdList[nth]);
				//$('input:hidden[name=docId]').val(docIdList[0]);
			//	alert($('input:hidden[name=docId]').val());
				});
		}
		window.scrollTo(0,0);
	};
			
	var nextF = function(){
		$('#nextB,#registComment').unbind("click");
		nth++;
		postponeDocCnt++;
		residualDocCnt--;
		loadDocF();
			
	};

	var commentF =	function(){

		if(document.frm.attach_file.value != "") {
			$(document.frm).attr("enctype", "multipart/form-data");
			document.frm.action = "<c:url value='${rootPath}/community/insertComment.do'/>";
			document.frm.submit();
		} else {
			$.post("${rootPath}/community/insertCommentAjax.do", form.serialize(),
					function(data){
				$('#registComment').unbind("click");
				$('#commentList').html(data);
				$('#registComment').click(commentF);
			});
		}
	};
	
	loadDocF();

	commentM = function(){

		if(document.frm.attach_file.value != "") {
			$(document.frm).attr("enctype", "multipart/form-data");
			$(document.frm.ajaxMode).attr("value", 0);
			document.frm.modified.value = "true";
			document.frm.action = "<c:url value='${rootPath}/community/updateComment.do'/>";
			document.frm.submit();
		} else {
			$.post("${rootPath}/community/updateCommentAjax.do", form.serialize(),
					function(data){
				$('#registComment').unbind("click");
				$('#commentList').html(data);
				$('#registComment').click(commentF);
			});
		}
	};

	commentD = function(){
		$.post("${rootPath}/community/deleteComment.do", form.serialize(),
				function(data){
			$('#registComment').unbind("click");
			$('#commentList').html(data);
			$('#registComment').click(commentF);
		});
	};

});

function fn_egov_selectCommentForupdt(commentNo, index, obj) {
	document.frm.commentNo.value = commentNo;
	document.frm.commentCn.value = $('#commentCn_' + commentNo).attr("value");
	$('#registComment').unbind("click");
	$('#registComment').click(commentM);
}

function fn_egov_deleteCommentList(commentNo, index) {
	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.commentNo.value = commentNo;
		commentD();
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
				<div id="center" style="padding-bottom:80px">
					<div class="path_navi">
						<ul>
							<li class="stitle">읽지 않은 게시물</li>
						<li class="navi">홈 > 커뮤니티 > 게시판 > 미열람게시물</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01" id="boardView">
						
					</div>
					<!-- E: section -->
					
					<div class="section01">
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	열람 건수 :<span id="comleteDocCnt">0</span>건, 
		                	미열람 건수 : <span id="residualDocCnt">0</span>건 
		                	<img class="cursorPointer" id="nextB" src="${imagePath}/btn/btn_nextUnread.gif"/> 
		                </div>
		                <!-- 버튼 끝 -->
					</div>
	
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
