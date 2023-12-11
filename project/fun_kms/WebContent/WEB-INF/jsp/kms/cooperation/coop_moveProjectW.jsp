<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
	$(document).ready( function() {

		var form = $('#projectVO');
		$('#prjMoveB').click( function() {
			form.attr("action", "/cooperation/moveProjectU.do");

			form.submit();

		});
		
		
		$('#prjCancleB').click( function() {
			history.back(-1);

		});
		$('[name=type]').change( function() {
			typeChange();

		});
		$('#prntPrjTreeB,#prntPrjNm').click( function() {
			prjGen('prntPrjNm', 'prntPrjId', 1, '${projectVO.prjId}');
		});
		
		
		
		$('#orgTreeB,#orgnztNm').click( function() {
			orgGen('orgnztNm', 'orgnztId', 1);
		});

		function typeChange() {
			var val = $('[name=type]:checked').val();
			if (val == "S") {
				$('#orgnztTr').hide();
				$('#prntPrjTr').show();
			} else {
				$('#orgnztTr').show();
				$('#prntPrjTr').hide();
			}
		};
		
		typeChange();
	});
</script>
</head>

<body>

<div id="wrap"><%@ include file="../common/menu/head.jsp"%>
<!-- S: container -->
<div id="container">
<ul class="container_bg">
	<li class="container_left"></li>
	<li class="container_right"></li>
</ul>
<!-- S: contents -->
<div id="contents"><%@ include file="../common/menu/leftMenu.jsp"%>
<!-- S: centerBg -->
<div id="center_bg"><!-- S: center -->
<div id="center">
<div class="path_navi">
<ul>
	<li class="stitle">프로젝트 이동</li>
	<li class="navi">홈 > 업무공유 > 프로젝트 > 프로젝트현황</li>
</ul>
</div>
<!-- S: section -->
<form:form commandName="projectVO" name="projectVO" method="post" enctype="multipart/form-data">
	<form:hidden path="prjId" />
	<span class="stxt">프로젝트를 이동하면 프로젝트코드도 함께 변경됩니다.</span> 
	<div class="section01">
	<!-- 게시판 시작  -->
	<div class="boardWrite02 mB20">
	<table cellpadding="0" cellspacing="0"
		summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>프로젝트 이동</caption>
		<colgroup>
			<col class="col120" />
			<col class="col120" />
			<col class="col120" />
			<col width="px" />
			<col class="col120" />
			<col class="col90" />
		</colgroup>
		<tbody>
			<tr>
				<td class="title">프로젝트코드</td>
				<td class="pL10">${projectVO.prjCd }</td>
				<td class="title">프로젝트명</td>
				<td class="pL10">${projectVO.prjNm }</td>
				<td class="title">담당자(PL)</td>
				<td class="pL10">${projectVO.leaderNm }</td>
			</tr>
			<tr>
				<td class="title">구분</td>
				<td class="pL10" colspan="5"><input type="radio" name="type" value="M" <c:if test="${projectVO.type=='M' }">checked </c:if> />
				메인프로젝트 <input type="radio" name="type" value="S" <c:if test="${projectVO.type=='S' }">checked </c:if> /> 서브프로젝트</td>
			</tr>
			<tr id="prntPrjTr">
				<td class="title">상위프로젝트</td>
				<td class="pL10" colspan="5"><form:input path="prntPrjNm" id="prntPrjNm" cssClass="span_9" readonly="true" /> <img src="${imagePath}/btn/btn_tree.gif" id="prntPrjTreeB"
					class="cursorPointer" /> <form:hidden path="prntPrjId" /></td>
			</tr>
			<tr id="orgnztTr">
				<td class="title">주관부서</td>
				<td class="pL10" colspan="5"><form:input path="orgnztNm" id="orgnztNm"
					readonly="true" cssClass="span_9" /> 
					<img src="${imagePath}/btn/btn_tree.gif" id="orgTreeB" class="cursorPointer" />
					<form:hidden path="orgnztId" />
				</td>
			</tr>
		</tbody>
	</table>
	</div>
	<!--// 게시판 끝  --> 
	<!-- 버튼 시작 -->
	<div class="btn_area">
	<img src="${imagePath}/btn/btn_move.gif" id="prjMoveB" class="cursorPonter" /> 
	<img src="${imagePath}/btn/btn_cancel.gif" id="prjCancleB" class="cursorPonter" />
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
