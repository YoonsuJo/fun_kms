<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
$(document).ready(function(){
	/*
 	$('#scorePolicySumitB').click(function(){
 	 	var inputList = $("#scorePolicyVO input[type=text]");
 	 	for(var i =0; i<inputList.length; i++)
 	 	{
 	 		var val = inputList[i];
 	 		if(val.value==null || val.value=="" || isNaN(val.value))
 	 		{
 	 	 		alert("올바르지 않은 값이 작성되어 있습니다. 숫자 형식만 입력하여 주십시오");
 	 	 		val.focus();
 	 	 		return;
 	 		}
 	 	} 
	 	$("#scorePolicyVO").attr("action", "/admin/score/scorePolicyU.do");
	 	$("#scorePolicyVO").submit();
 		});
	*/
});
function updatePolicy(code) {
	document.scorePolicyVO.codeDc.value = document.getElementById('code_' + code).value;
	document.scorePolicyVO.code.value = code;
	document.scorePolicyVO.action = "/admin/score/scorePolicyU.do";
	document.scorePolicyVO.submit();
}
</script>
</head>

<body>

<div id="admin_wrap">
	<!-- S: container -->
	<div id="admin_container">
		<ul class="admin_container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="admin_contents">
		<%@ include file="../left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">점수관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">		
						<!-- 게시판 시작 -->
						
						<p class="th_stitle mT20">점수 정책</p>
						<!-- 사내메일 점수 시작 -->
						<form:form commandName="scorePolicyVO" name="scorePolicyVO" id="scorePolicyVO" method="post" enctype="multipart/form-data" >
						<input type="hidden" name="codeDc" value="" />
						<input type="hidden" name="code" value="" />
						<div class="boardList02">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>점수 정책</caption>
							<colgroup>
								<col class="col250" />
								<col width="px" />
								<col class="col100" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">항목</th>
								<th scope="col">점수</th>
								<th class="td_last" scope="col"> </th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${policyList}" var="pol">
								<tr class="center">
									<td>
										${pol.codeNm}
									</td>
									<td class="txt_center"><input type="text" class="span_2 txt_center" name="point1List" id="code_${pol.code }" value="${pol.codeDc }"/></td>
									<td class="td_last txt_center"><img src="${imagePath}/admin/btn/btn_save.gif" onclick="javascript:updatePolicy('${pol.code }');" class="cursorPointer" id="scorePolicySumitB"/></td>
								</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						</form:form>
						
					</div>
					<!-- E: section -->	
				</div>
				<!-- E: center -->
			</div>	
			<!-- E: centerBg -->		
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/admin_footer.jsp"%>
</div>
</body>
</html>
