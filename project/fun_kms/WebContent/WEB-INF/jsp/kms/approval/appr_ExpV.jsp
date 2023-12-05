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
	//승인버튼
	$('#appAcceptB').click(function(){
		//frm = confirm("승인하시겠습니까.");
		//if(frm){
		if(confirm("승인하시겠습니까")){
			form.attr("action", "/approval/appAccept.do?stat=1&ajaxMode=0&"+queryString);
			form.submit();
		}else{         
	    }
	});
	//반려버튼
	$('#appRejectB').click(function(){
		//frm = confirm("반려하시겠습니까.");
		//if(frm){
		if(confirm("반려하시겠습니까")){
			form.attr("action", "/approval/appAccept.do?stat=2&ajaxMode=0&"+queryString);
			form.submit();
		} else {
		}
	});
	//기안취소
	$('#cancleB').click(function(){
		form.attr("action", "/approval/cancleDraft.do?");
		form.submit();
	});
	//문서재사용버튼
	$('#reUseB').click(function(){
		//frm = confirm("이 결재문서는 그대로 보관되고 새로운 문서를 다시 작성합니다.\r\n\r\n계속하시겠습니까?");
		//if (frm) {
		if(confirm("이 결재문서는 그대로 보관되고\n새로운 문서를 다시 작성합니다.\r\n계속하시겠습니까?")){
			location.replace("/approval/approvalRU.do?docId=${approvalVO.docId}&"+queryString);
		} else {
		}
	});
	//draftM 수정기안 예산수정취소 매출수정보고 휴가수정취소
	$('#reApprovalB').click(function(){
		//frm = confirm("이 결재문서의 효력이 상실되고 새로운 문서의 내용으로 대체됩니다.\r\n\r\n계속하시겠습니까?");
		//if (frm) {
		if(confirm("이 결재문서의 효력이 상실되고\n새로운 문서의 내용으로 대체됩니다.\r\n계속하시겠습니까?")){
			location.replace("/approval/approvalRW.do?docId=${approvalVO.docId}&"+queryString);
		} else {
		}
	});
	//반려확인 버튼 commentWrite.jsp (docContent.jsp 에 포함)
	$('#confirmRejectB').click(function(){
		form.attr("action", "/approval/confirmReject.do?");
		form.submit();
	});
	//상신버튼
	$('#updateB').click(function(){
		form.attr("action", "/approval/updateSaveDocStat.do?");
		form.submit();
	});
	//수정버튼
	$('#modifyB').click(function(){
		form.attr("action", "/approval/modifySaveDoc.do?");
		form.submit();
	});
	//삭제 버튼
	$('#deleteB').click(function(){
		if(confirm("삭제된 문서는 되돌릴 수 없습니다. 정말 삭제하시겠습니까?")){
			location.replace("/approval/deleteSaveDoc.do?docId=${approvalVO.docId}&"+queryString);
		}
	});
	//목록버튼
	$('#listB').click(function(){
		location.replace("/approval/approvalL.do?" + queryString);
	});
	//처리완료 버튼
	$('#handleAcceptB').click(function(){
		if(form.find('[name=handleDt]').val() == null || form.find('[name=handleDt]').val().length<8){
			alert("처리완료일을 입력하여 주십시오.");
			return; 
		}
		form.attr("action", "/approval/updateHandle.do?stat=1&" + queryString);
		form.submit();
	});
	//처리취소 버튼
	$('#handleRejectB').click(function(){
		form.attr("action", "/approval/updateHandle.do?stat=2&" + queryString);
		form.submit();
	});
	
});
//참조자 추가 기능
function referencerLayerShow() {
	var position = $("#btn_chng").position();
	var height = $("#btn_chng").height();
	
	$('#ReferencerLayer').show();
	document.getElementById("ReferencerLayer").style.top = position.top - 100 + "px";
	document.getElementById("ReferencerLayer").style.left = position.left - 300 + "px";
	document.getElementById("ReferencerLayer").style.zIndex = "1";
	location.hash = "refUserMixes";
	document.getElementById("refUserMixes").style.imeMode = "active";
}
function referencerLayerHide() {
	$('#ReferencerLayer').hide();
}
function insertReferencer(){
	document.frm.action="/approval/insertReferencer.do";
	document.frm.submit();
}
//작성자 변경기능
function writerLayerShow(){
	var position = $("#btn_chng2").position();
	var height = $("#btn_chng2").height();
	
	$('#writerLayer').show();
	document.getElementById("writerLayer").style.top = position.top - 110 + "px";
	document.getElementById("writerLayer").style.left = position.left - 100 + "px";
	document.getElementById("writerLayer").style.zIndex = "1";
}
function writerLayerHide() {
	$('#writerLayer').hide();
}
function updateWriterNo(){
	document.frm2.action="/approval/updateWriterNo.do";
	document.frm2.submit();
}
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
		<%@ include file="../common/menu/leftMenu.jsp"%>
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
						<c:if test="${user.isEappadmin=='Y' || user.isHmdev=='Y' }">
							<img class="cursorPointer" id="appRejectB" src="${imagePath}/btn/btn_return03.gif" />
<!--							<a href="/approval/appRejectCancle.do?docId=${approvalVO.docId}">반려취소(개발예정)</a>-->
						</c:if>			        	
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
				        <!-- 수정기안 -->
				        <!-- 2 휴가신청서  -->
				        <!-- 20 종합 21 일반 25 사내 매출보고서 -->
				        <!-- 24 예산승인 요청서 -->
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
				  		<c:if test="${button.reUse==1 || user.isHmdev=='Y' }">
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
						<a href ="javascript:referencerLayerShow();">
							<img id="btn_chng" src="${imagePath}/btn/btn_change3.gif"/>
						</a>
						<c:if test="${user.isHmdev=='Y' }">
							<a href ="javascript:writerLayerShow();">
								<img id="btn_chng2" src="${imagePath}/btn/btn_change5.gif"/>
							</a>
						</c:if>
				        <a href ="${rootPath}/approval/printDoc.do?docId=${approvalVO.docId}" target="_blank">
				        	<img id="printB" src="${imagePath}/btn/btn_print.gif"/>
				        </a>
				        <a href="/approval/approvalL.do?${queryString}">
			        		<img id="listB" class="cursorPointer" src="${imagePath}/btn/btn_list.gif"/>
			        	</a>
			        	
			        	
			        	<!-- 참조자 추가 레이어  -->
			        	<form name="frm" method="POST" onsubmit="return false;">
			        	<input type="hidden" name="docId" value="${approvalVO.docId}"/>
			        	<input type="hidden" name="mode" value="${approvalVO.mode}"/>
		                <div id="ReferencerLayer" class="Receiver_layer" style="display:none;">
		                	<dl>
		                		<dt>전자결재 참조자 추가</dt>
		                		<dd>
		                			<div class="boardWrite02 mB10">
									<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
				                    <caption>공지사항 보기</caption>
				                    <colgroup>
					                    <col class="col120" />
					                    <col width="px" />
				                    </colgroup>
				                    <tbody>
				                    	<tr>
					                    	<td class="title">참조자</td>
					                    	<td class="pL10">
					                    		<input type="text" class="span_13 userNamesAuto userValidateCheck" name="refUserMixes" id="refUserMixes"
					                    			value="" />
					                    		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('refUserMixes',0)" />
				                    		</td>
				                    	</tr>
				                    </tbody>
				                    </table>
									</div>
									<div class="btn_area">
			                			<a href="javascript:insertReferencer();"><img src="${imagePath}/btn/btn_apply.gif"/></a>
			                			<a href="javascript:referencerLayerHide();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
					                </div>
		                		</dd>
		                	</dl>
						</div>		                
		                </form>
		                <!--// 참조자 추가 레이어 끝  -->
		                
		                <!-- 작성자 변경 레이어  -->
			        	<form name="frm2" method="POST" onsubmit="return false;">
			        	<input type="hidden" name="docId" value="${approvalVO.docId}"/>
			        	<input type="hidden" name="mode" value="${approvalVO.mode}"/>
		                <div id="writerLayer" class="Receiver_layer" style="display:none;">
		                	<dl>
		                		<dt>전자결재 작성자 변경</dt>
		                		<dd>
		                			<div class="boardWrite02 mB10">
									<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
				                    <caption>공지사항 보기</caption>
				                    <colgroup>
					                    <col class="col120" />
					                    <col width="px" />
				                    </colgroup>
				                    <tbody>
				                    	<tr>
					                    	<td class="title">작성자</td>
					                    	<td class="pL10">
					                    		<input type="text" class="span_27 userNameAuto userValidateCheck" name="deciderMix" id="deciderMix" />
        										<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('deciderMix',1);"/> (1명)
				                    		</td>
				                    	</tr>
				                    </tbody>
				                    </table>
									</div>
									<div class="btn_area">
			                			<a href="javascript:updateWriterNo();"><img src="${imagePath}/btn/btn_apply.gif"/></a>
			                			<a href="javascript:writerLayerHide();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
					                </div>
		                		</dd>
		                	</dl>
						</div>		                
		                </form>
		                <!--// 작성자 변경 레이어 끝  -->
			        	
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
