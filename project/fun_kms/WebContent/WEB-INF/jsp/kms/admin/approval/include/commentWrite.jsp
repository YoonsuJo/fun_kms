<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 댓글 달기 시작 -->

	
<form:form commandName="approvalVO" name="approvalVO" id="approvalVO" method="post" enctype="multipart/form-data" >
	<div class="hidden" > 
		<input type="hidden" name="mode" value="${approvalVO.mode}" />
		<input type="hidden" name="searchTempltId" value="${approvalVO.searchTempltId}" />
		<input type="hidden" name="searchWriterNm" value="${approvalVO.searchWriterNm}" />
		<input type="hidden" name="docId" value="<c:out value='${approvalVO.docId}'/>">
		<form:checkbox cssClass="check" path="searchdocStatL" value="APP004" />  
		<form:checkbox cssClass="check" path="searchdocStatL" value="APP005" />  
		<form:checkbox cssClass="check" path="searchHandleStatL"  value="0"/>  
		<form:checkbox cssClass="check" path="searchHandleStatL"   value="1"/>
		<form:checkbox cssClass="check" path="searchHandleStatL"  value="2" />
		<form:checkbox cssClass="check" path="searchHandleStatL"  value="3" />
		<input type="hidden" name="searchSubject" value="${approvalVO.searchSubject}" />
	</div>
	
	<div class="replyW mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>댓글달기</caption>
		<colgroup>
			<col width="px" />
			<col class="col70" />
			<col class="col70" />
			<col class="col70" />
		</colgroup>
		<tr>
			<td rowspan="3" class="last pA10"><textarea name="eappCt" id="eappCt"
				class="textarea height_70"></textarea></td>
			<td colspan="3" class="last">
				<c:if test="${button.handleAccept==1 }">
					처리완료일 : <input type="text" name="handleDt" class="span_5 calGen" value="${todayDate}" />
				</c:if>
			</td>
		</tr>
		<tr>
			<td class="last">		
				<c:if test="${button.accept==1 }">
					<img class="cursorPointer" id="appAcceptB" 
					  src="${imagePath}/btn/btn_accept.gif" />
	            </c:if>			
				<c:if test="${button.handleAccept==1 }">
					<img class="cursorPointer" id="handleAcceptB"
						src="${imagePath}/btn/btn_handlingcomp.gif" />
				</c:if>
			</td>	
			<td class="last">
				<c:if test="${button.confirmReject==1 }">
					<img id="confirmRejectB" class="cursorPointer"
						src="${imagePath}/btn/btn_chkreturn.gif" />
				</c:if> 
				<c:if test="${button.reject==1 }">
					<img class="cursorPointer" id="appRejectB"
						 src="${imagePath}/btn/btn_return.gif" />
				</c:if>				
				<c:if test="${button.handleReject==1 }">
					<img class="cursorPointer" id="handleRejectB"
						src="${imagePath}/btn/btn_handlingcancel.gif" />
				</c:if>
			</td>
			<td class="last"><img class="cursorPointer" id="appCommentB"
				src="${imagePath}/btn/btn_addcomment.gif" />
			</td>
		</tr>
		<tr><td colspan="4" class="last"/></tr>
	</table>
	</div>
</form:form>	


