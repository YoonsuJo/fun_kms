<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 초기화
 ******************************************************** */
function fnInit(){
}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */

var mode = ${cmmnDetailCode.mode };

function fnList(){
	var varForm = document.all["Form"];
	if(mode == 2) {
		varForm.action = "<c:url value='/admin/codeDetail/codeL2.do'/>";
	} else {
		varForm.action = "<c:url value='/admin/codeDetail/codeL.do'/>";
	}
	varForm.submit();
}
/* ********************************************************
 * 수정화면으로  바로가기
 ******************************************************** */
function fnModify(){
	var varForm				 = document.all["Form"];
	varForm.action           = "<c:url value='/admin/codeDetail/codeM.do'/>";
	varForm.codeId.value     = "${result.codeId}";
	varForm.code.value       = "${result.code}";
	varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){
	if (confirm("<spring:message code='common.delete.msg'/>")) {
		var varForm				 = document.all["Form"];
		varForm.action           = "<c:url value='/admin/codeDetail/codeD.do'/>";
		varForm.codeId.value     = "${result.codeId}";
		varForm.code.value       = "${result.code}";
		varForm.submit();
	}
}
-->
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
							<li class="stitle">공통상세코드 상세조회 ${cmmnDetailCode.mode }</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<form name="Form" method="post">
						<input type="hidden" name="codeId">
						<input type="hidden" name="code">
						<input type="hidden" name="mode" value="${result.mode }">
						<input type="hidden" name="searchCondition">
						<input type="hidden" name="searchKewWord">
						
					</form>
					<div class="section01">	
						
						<!-- 게시판 시작  -->
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공통상세코드</caption>
		                    <colgroup><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr> 
			                    	<td class="title">${result.codeIdNm}</td>
			                    	<td class="pL10" >등록구분</td>
		                    	</tr>
		                    	<tr> 
			                    	<td class="title">코드</td>
			                    	<td class="pL10" >${result.code}</td>
		                    	</tr>
								<tr>
								    <td class="title">코드명</td>
									<td class="pL10" >${result.codeNm}</td>
 								</tr>
 								<tr>
								    <td class="title">코드설명</td>
									<td class="pL10 pT5 pB5" >
									<textarea name="text" class="span_23 height_170" id="codeDc" disabled>${result.codeDc}</textarea>
									</td>
 								</tr>
 								<tr>
								    <td class="title">사용여부</td>
									<td class="pL10">
										<select name="useAt" disabled id="useAt">
											<option value="Y" <c:if test="${result.useAt == 'Y'}">selected="selected"</c:if> >Yes</option>
											<option value="N" <c:if test="${result.useAt == 'N'}">selected="selected"</c:if> >No</option>				
										</select>
									</td>
 								</tr>
 								<tr>
								    <td class="title">칼럼1</td>
									<td class="pL10 pT5 pB5" >
										${result.column1}
									</td>
 								</tr>
 								<tr>
								    <td class="title">칼럼2</td>
									<td class="pL10 pT5 pB5" >
										${result.column2}
									</td>
 								</tr>
 								<tr>
								    <td class="title">칼럼3</td>
									<td class="pL10 pT5 pB5" >
										${result.column3}
									</td>
 								</tr>
 								<tr>
								    <td class="title">칼럼4</td>
									<td class="pL10 pT5 pB5" >
										${result.column4}
									</td>
 								</tr>
 								<tr>
								    <td class="title">정렬순서</td>
									<td class="pL10 pT5 pB5" >
										${result.ord}
									</td>
 								</tr>                   	
		                    </tbody>
		                    </table>
						</div>
						<!-- 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<img class="cursorPointer" onclick="fnModify(); return false;" src="${imagePath}/admin/btn/btn_modify.gif"/>
		                	<img class="cursorPointer" onclick="fnDelete(); return false;" src="${imagePath}/admin/btn/btn_delete.gif"/>
		                	<img class="cursorPointer" onclick="fnList(); return false;" src="${imagePath}/admin/btn/btn_list.gif"/>
		                </div>
		                <!-- 버튼 끝 -->						
						
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
