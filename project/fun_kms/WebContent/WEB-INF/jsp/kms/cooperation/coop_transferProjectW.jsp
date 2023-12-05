<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
$(document).ready( function() {

	var form = $('#projectVO');
	
	$('#prjMoveDataB').click( function() {
		var prjId = $('#prjId').val();			
		var transferPrjId = $('#transferPrjId').val();
		if(prjId == transferPrjId){
			alert("이관 프로젝트가 같습니다.");
			return;
		}
		
		form.attr("action", "/cooperation/transferProjectU.do");
		form.submit();

	});		
	
	$('#prjCancleB').click( function() {
		history.back(-1);
	});
			
	$('#transferPrjTreeB,#prntPrjNm').click( function() {
		prjGen('transferPrjNm', 'transferPrjId', 1);
	});
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
	<li class="stitle">프로젝트 이관</li>
	<li class="navi">홈 > 업무공유 > 프로젝트 > 프로젝트현황</li>
</ul>
</div>
<!-- S: section -->
<form:form commandName="projectVO" name="projectVO" method="post" enctype="multipart/form-data">
	<form:hidden path="prjId" />
	<span class="stxt">프로젝트 이동과 별개로 해당 프로젝트에 연결되어 있는 각종 업무일지, 업무보고, 매출, 지결서 등을 타 프로젝트로 데이터 이관하는 기능</span> 
	<div class="section01">
	<!-- 게시판 시작  -->
	<div class="boardWrite02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>프로젝트 이관</caption>
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
			<tr id="prntPrjTr">
				<td class="title">이관프로젝트</td>
				<td class="pL10" colspan="5"><form:input path="transferPrjNm" id="transferPrjNm" cssClass="span_9" readonly="true" /> 
				<img src="${imagePath}/btn/btn_tree.gif" id="transferPrjTreeB" class="cursorPointer" /> <form:hidden path="transferPrjId" /></td>
			</tr>
		</tbody>
	</table>
	</div>
	<!--// 게시판 끝  --> 
	<!-- 버튼 시작 -->
	<div class="btn_area">
	
	<input type="button" value="이관" class="btn_gray" id="prjMoveDataB"/>
	<input type="button" value="취소" class="btn_gray" id="prjCancleB"/>
	
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
