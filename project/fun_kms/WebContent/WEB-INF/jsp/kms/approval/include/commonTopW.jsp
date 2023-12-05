<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>


<script>

function showGuideLayer(obj) {
	var position = $(obj).position();
	var layer = $('#apprGuideLayer');
	var left = position.left + $(obj).width() - layer.width();
	var top = position.top;
	layer.css("left",left+"px");
	layer.css("top",top+"px");
	layer.show();
}

function hideGuideLayer() {
	$('#apprGuideLayer').hide();
}

</script>

<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup><col class="col120" /><col width="px" /><col class="col90"></colgroup>
	<tbody>
		<tr>
			<td class="title">문서종류</td>
			<td class="pL10" colspan="2">${appTyp.docSj}</td>
		</tr>
		<tr>
			<td class="title">제목</td>
			<td class="pL10" colspan="2">
			<form:input path="subject" cssClass="span_15" autocomplete="true" />
			<!-- <input name="subject" type="text"  > -->
			</td>
		</tr>
		<tr>
			<td class="title">검토자</td>
			<td class="pL10">
				<form:input path="reviewerMixs" cssClass="span_12 userNamesAuto userValidateCheck" />
				<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('reviewerMixs',2);"/> (0~N명)
				<c:if test="${appTyp.templtId==2}">
					<br/>
					<span class="txtS_red">검토자에 기안자가 수행중인 프로젝트의 PL을 필수 선택하여 주시기 바랍니다.</span>
				</c:if>
			</td>
			<c:if test="${appTyp.templtId==6}">
				<td class="Br02" rowspan="6">
				<p class="mB5">결재선 안내</p>
				<img src="${imagePath}/btn/btn_question.gif" class="cursorPointer" onmouseover="javascript:showGuideLayer(this);"/>
			</td>
			</c:if>
			<c:if test="${appTyp.templtId!=6}">
				<td class="Br02" rowspan="4">
				<p class="mB5">결재선 안내</p>
				<img src="${imagePath}/btn/btn_question.gif" class="cursorPointer" onmouseover="javascript:showGuideLayer(this);"/>
				</td>
			</c:if>
		</tr>
		<tr>
			<td class="title">협조자</td>
			<td class="pL10">
				<form:input path="cooperatorMixs"  cssClass="span_12 userNamesAuto userValidateCheck" />
				<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('cooperatorMixs',2);"/> (0~N명)
			</td>
		</tr>
		<tr>
			<td class="title">전결자</td>
			<td class="pL10">
				<form:input path="deciderMix"  cssClass="span_12 userNamesAuto userValidateCheck" />
				<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('deciderMix',2);"/> (0~N명)
				
			</td>
		</tr>
		<tr>
			<td class="title">참조자</td>
			<td class="pL10">
				<form:input path="referencerMixs"  cssClass="span_12 userNamesAuto userValidateCheck" />
				<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('referencerMixs',2);"/> (0~N명)
			</td>
		</tr>
		<c:if test="${appTyp.templtId==6}">
			<tr>
					<td class="title">프로젝트</td>
					<td class="pL10">
						<input type="text" class="span_12" name="prjNm" id="prjNm" readonly="readonly" 
						onclick="prjGen('prjNm','prjId',1)" onfocus="prjGen('prjNm','prjIdDoc',1)"/>
						<form:hidden path="prjIdDoc"/>
						<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen('prjNm','prjIdDoc',1)" />
					</td>
				</tr>	
			<tr>
				<td class="title">수신메일주소</td>
				<td class="pL10">
					<form:input path="emailMixs"  cssClass="span_12" /> (구분자 ,)
				</td>
			</tr>
		</c:if> 
	</tbody>
</table>
 
<!-- 결재선안내 레이어  -->
<div class="apprGuide_layer" id="apprGuideLayer" style="display:none;" onmouseout="javascript:hideGuideLayer();">

		<print:textarea text="${appTyp.decideLineDesc }"/>

</div>
<!-- 결재선안내 레이어  -->
 