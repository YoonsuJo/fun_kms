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
	

});


function authSave(authCode,userComplexs)
{
	/*alert('#'+authCode + ' input[name=userComplexs]');
	alert($('#admin  > input[name="userComplexs"]').val());
	alert($('#'+authCode + '> input[name="userComplexs"]').val());
	$('#'+authCode + ' input[name=userComplexs]').val($('#'+authCode + ' input[name=userComplexs]').val().trimAll());*/
	
	$.post("/admin/authority/authU.do",$('#'+authCode).serialize(),
			function(data){
			if(data.indexOf("success"))
			{
				alert("저장에 성공했습니다");
			}	
			else
			{
				alert("저장에 실패했습니다. 형식을 확인해주세요.");
			}
			location.replace("${rootPath}/admin/authority/authMain.do");
	});
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
							<li class="stitle">권한 관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">	
						
						<!-- 게시판 시작  -->
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>권한 관리</caption>
		                    <colgroup><col class="col150" /><col width="px" /><col class="col90" /></colgroup>
		                    <tbody>
		                    	<c:forEach items="${resultList}" var="result">
		                    		<form id="${result.authCode}">
		                    		<input type="hidden" name ="authCode" value ="${result.authCode}" />
				                    	<tr class="height_td"> 
					                    	<td class="title">${result.authNm}</td>
					                    	<td class="pL10">
					                    		<ul>
					                    			<li class="T11">${result.authDesc}</li>
					                    			<li><input type="text" name="userComplexs" value="${result.userComplexs}" class="span_12 userNamesAuto userValidateCheck" /></li>
					                    		</ul>
					                    	</td>
					                    	<td class="pL10" ><img class="cursorPointer" onclick="authSave('${result.authCode}');" src="${imagePath}/admin/btn/btn_save.gif"/></td>
				                    	</tr>
			                    	</form>
		                    	</c:forEach>
								                    	
		                    </tbody>
		                    </table>
						</div>
						<!-- 게시판 끝  -->					
						
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
