<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>

</head>
<script>

$(document).ready(function() {

	var queryString = "${queryString}";
	var form = $('#approvalVO');
	var docId ="${approvalVO.docId}";
	$('#appCommentB').click(function(){
			form.attr("action", "/kmsEappComment/commentI.do?"+queryString);
			form.submit();
	});

	$('#appAcceptB').click(function(){
		frm = confirm("승인하시겠습니까.");
		if(frm){
			form.attr("action", "/approval/appAccept.do?stat=1&ajaxMode=0&"+queryString);
			form.submit();
		}else{
         
	    }
	});
	

	$('#appRejectB').click(function(){
		frm = confirm("반려하시겠습니까.");
		if(frm){
		form.attr("action", "/approval/appAccept.do?stat=2&ajaxMode=0&"+queryString);
		form.submit();
		}else{
		}
			}
		);

	$('#cancleB').click(function(){
		form.attr("action", "/approval/cancleDraft.do?");
		form.submit();
	});

	$('#reUseB').click(function(){
		frm = confirm("이 결재문서는 그대로 보관되고 새로운 문서를 다시 작성합니다.\r\n\r\n계속하시겠습니까?");
		if (frm) {
			location.replace("/approval/approvalRU.do?docId=${approvalVO.docId}&"+queryString);
		}
		else {
		}
	});

	$('#reApprovalB').click(function(){
		frm = confirm("이 결재문서의 효력이 상실되고 새로운 문서의 내용으로 대체됩니다.\r\n\r\n계속하시겠습니까?");
		if (frm) {
			location.replace("/approval/approvalRW.do?docId=${approvalVO.docId}&"+queryString);
		}
		else {
		}
	});

	$('#confirmRejectB').click(function(){
		form.attr("action", "/approval/confirmReject.do?");
		form.submit();
	});

	$('#updateB').click(function(){
		form.attr("action", "/approval/updateSaveDocStat.do?");
		form.submit();
	});

	$('#modifyB').click(function(){
		form.attr("action", "/approval/modifySaveDoc.do?");
		form.submit();
	});


	$('#deleteB').click(function(){
		if(confirm("삭제된 문서는 되돌릴 수 없습니다. 정말 삭제하시겠습니까?")){
			location.replace("/approval/deleteSaveDoc.do?docId=${approvalVO.docId}&"+queryString);
		}
	});

	$('#listB').click(function(){
		location.replace("/approval/approvalL.do?" + queryString);
	});

	$('#handleAcceptB').click(function(){
		if(form.find('[name=handleDt]').val() == null || form.find('[name=handleDt]').val().length<8){
			alert("처리완료일을 입력하여 주십시오.");
			return; 
		}
		form.attr("action", "/approval/updateHandle.do?stat=1&" + queryString);
		form.submit();
	});
	
	$('#handleRejectB').click(function(){
		form.attr("action", "/approval/updateHandle.do?stat=2&" + queryString);
		form.submit();
	});
	
});
</script>
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
		<%@ include file="left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">결재문서 보기<!-- TODO :문서 상태에 따라 타이틀 변환 승인하기--></li>
							<li class="navi">홈 > 전자결재 > 결재하기 > 결재문서 보기</li>
						</ul>
					</div>
					<span class="stxt"><!--TODO : 문서 상태에 따라 설명 값 변환 결재 문서를 검토하고 승인합니다.--></span>
					
					<!-- S: section -->
					<!-- 문서 보기 시작 -->
					<div class="section01">
						<%@include file= "./include/docContent.jsp"%>
					</div>

					<!-- 코멘트 보기 시작 -->
										
				<!-- 버튼 시작 -->
			        <div class="btn_area">
			        	<c:if test="${button.update==1 }">
			        		<a href="/approval/updateSaveDocStat.do?docId=${approvalVO.docId}">
				        		<img id="updateB" src="${imagePath}/btn/btn_report.gif"/>
				        	</a>
				        </c:if>
				        <c:if test="${button.cancle==1 }">
				        	<a href="/approval/cancleDraft.do?docId=${approvalVO.docId}">
				        		<img id="cancleB" class="cursorPointer" src="${imagePath}/btn/btn_canceldraft.gif"/>
				        	</a>
				        </c:if>
			    	   	<c:if test="${button.reApproval==1 }">
			    	   		<c:choose>
			    	   		<c:when test="${appTyp.templtId == 2}">
			    	   			<img id="reApprovalB" class="cursorPointer" src="${imagePath}/btn/btn_draftM_vacation.gif"/>
			    	   		</c:when>
			    	   		<c:when test="${appTyp.templtId == 20 || appTyp.templtId == 21 || appTyp.templtId == 25}">
			    	   			<img id="reApprovalB" class="cursorPointer" src="${imagePath}/btn/btn_draftM_sales.gif"/>
			    	   		</c:when>
			    	   		<c:when test="${appTyp.templtId == 24}">
			    	   			<img id="reApprovalB" class="cursorPointer" src="${imagePath}/btn/btn_draftM_budget.gif"/>
			    	   		</c:when>
			    	   		<c:otherwise>
			    	   			<img id="reApprovalB" class="cursorPointer" src="${imagePath}/btn/btn_draftM.gif"/>
			    	   		</c:otherwise>
			    	   		</c:choose>
				        </c:if>
				  		<c:if test="${button.reUse==1 }">
			        		<img id="reUseB" class="cursorPointer" src="${imagePath}/btn/btn_reusedoc.gif"/>
				        </c:if>
				        
			    	   	<c:if test="${button.modify==1 }">
			    	   		<a href="/approval/modifySaveDoc.do?docId=${approvalVO.docId}">
				        		<img id="modifyB" class="cursorPointer" src="${imagePath}/btn/btn_modify.gif"/>
				        	</a>
				        </c:if>
			    	   	<c:if test="${button.delete==1 }">
				        	<img id="deleteB" class="cursorPointer" src="${imagePath}/btn/btn_delete.gif"/>
				        </c:if>

				        <a href ="${rootPath}/approval/printDoc.do?docId=${approvalVO.docId}" target="_blank">
				        	<img id="printB" src="${imagePath}/btn/btn_print.gif"/>
				        </a>
				        <a href="/approval/approvalL.do?${queryString}">
			        		<img id="listB" class="cursorPointer" src="${imagePath}/btn/btn_list.gif"/>
			        	</a>
			        
			        	
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
<%@ include file="../../include/footer.jsp"%>
</div>
</body>
</html>
