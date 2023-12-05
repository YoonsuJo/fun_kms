<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 댓글 달기 시작 -->

<input type="hidden" name="docIdList" />
<div class="replyW mT10">
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
               <caption>댓글달기</caption>
               <colgroup><col class="col120" /><col class="col500" /><col class="col120" /></colgroup>
               <tr>
               	<td class="writer">처리의견</td>
               	<td class="pL10"><textarea name="eappCt" class="replyW_txt02"></textarea></td>
               	<td class="pL10">
               		<img id="appHandleCompB" src="${imagePath}/btn/btn_recruitok.gif"/>
               		<img id="appHandleCancleB" src="${imagePath}/btn/btn_recruitcancel.gif"/>
               	</td>
               </tr>
   </table>
</div>

