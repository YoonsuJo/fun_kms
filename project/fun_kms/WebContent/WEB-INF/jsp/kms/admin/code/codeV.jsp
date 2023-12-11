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
function fnList(){
	var varForm				 = document.all["Form"];
	varForm.action           = "<c:url value='/admin/code/codeL.do'/>";
	varForm.submit();
}
/* ********************************************************
 * 수정화면으로  바로가기
 ******************************************************** */
function fnModify(){
	var varForm				 = document.all["Form"];
	varForm.action           = "<c:url value='/admin/code/codeM.do'/>";
	varForm.codeId.value     = "${result.codeId}";
	varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){
	if (confirm("<spring:message code='common.delete.msg'/>")) {
		var varForm				 = document.all["Form"];
		varForm.action           = "<c:url value='/admin/code/codeD.do'/>";
		varForm.codeId.value     = "${result.codeId}";
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
							<li class="stitle">공통코드 상세조회</li>
						</ul>
					</div>
					<form name="Form" method="post">
						<input name="codeId" type="hidden">
						<input name="searchCondition" type="hidden" value="${searchVO.searchCondition}" />
						<input name="searchKeyword" type="hidden" value="${searchVO.searchKeyword}"/>
						<input name="pageIndex" type="hidden" value="${searchVO.pageIndex}"/>
					</form>
	
					<!-- S: section -->
					<div class="section01">	
						
						<!-- 게시판 시작  -->
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공통코드</caption>
		                    <colgroup><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr> 
			                    	<td class="title">분류코드명</td>
			                    	<td class="pL10" >${result.clCodeNm}</td>
		                    	</tr>
		                    	<tr> 
			                    	<td class="title">코드ID</td>
			                    	<td class="pL10" >${result.codeId}</td>
		                    	</tr>
								<tr>
								    <td class="title">코드ID명</td>
									<td class="pL10" >${result.codeIdNm}</td>
 								</tr>
 								<tr>
								    <td class="title">코드ID설명</td>
									<td class="pL10 pT5 pB5" ><textarea  disabled name="text" id="codeIdDc" class="span_23 height_170">${result.codeIdDc}</textarea></td>
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
		                    </tbody>
		                    </table>
						</div>
						<!-- 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<img onclick="fnModify(); return false;" class="cursorPointer" src="${imagePath}/admin/btn/btn_modify.gif"/>
		                	<img onclick="fnDelete(); return false;" class="cursorPointer" src="${imagePath}/admin/btn/btn_delete.gif"/>
		                	<img onclick="fnList(); return false;" class="cursorPointer" src="${imagePath}/admin/btn/btn_list.gif"/>
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
