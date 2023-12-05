<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 댓글 달기 시작 -->

<input type="hidden" name="docIdList" />
<div class="boardWrite02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>댓글달기</caption>
		<colgroup>
			<col width="120" />
			<col width="px" />
			<col width="120" />
			<col width="px" />
		</colgroup>
		<tr>
			<td class="title">내용</td>
			<td class="pL10 pT5 pB5" colspan="3"><textarea name="reply" class="span_25 height_35"></textarea></td>
		</tr>
		<tr>
			<td class="title">처리일자</td>
			<td class="pL10" ><input type="text" name="handleDt" class="span_5 calGen" value="${todayDate}" /></td>
			<td class="title">지급액</td>
			<td class="pL10" ><span class="txt_blue" id="totalSum">0</span>원</td>
		</tr>
		<tr>
			<td class="title">처리</td>
			<td class="pL10" colspan="3">
				<img id="appHandleCompB" src="${imagePath}/btn/btn_handlingcomp.gif" /> 
				<!-- <img id="appHandleCancleB" src="${imagePath}/btn/btn_handlingcancel.gif" /> -->
			</td>
		</tr>
</table>
</div>

