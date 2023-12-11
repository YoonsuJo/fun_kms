	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="adminChildAccount" staticJavascript="false" xhtml="true" cdata="false"/>

<script>
$(document).ready(function(){
	var form = $('#accountVO');
	var mode = "${mode}";

	document.getElementById('prntAccIdSelector').focus();
	
	$('#accountSaveB').click(function(){
		//validate
		if(!validateAdminChildAccount(document.accountVO))
				return;
		if(mode=="W")
		{
			form.attr("action", "/admin/approval/insertAccount.do");
		}
		else
		{
			form.attr("action", "/admin/approval/updateAccount.do");
		}
		form.submit();
	});

	$('#backB').click(function(){
		history.back(0);
		return false;

	});

	$('#prntAccIdSelector').blur(function(){
		var prntAccId = $(this).find(":selected").val().split("/")[0]; 
		var prntTyp = $(this).find(":selected").val().split("/")[1]; 
		var prntTypNm = $(this).find(":selected").val().split("/")[2]; 
		$('#prntAccId').val(prntAccId);
		$('#prntTypNm').html(prntTypNm);
		toggleChildTyp(prntTyp);
		
	});

	function toggleChildTyp(prntTyp){
		if(prntTyp=="E")
		{
			form.find('[name=childTyp][value=10]').parent().show();
			form.find('[name=childTyp][value=11]').parent().show();
			form.find('[name=childTyp][value=12]').parent().show();
			form.find('[name=childTyp][value=13]').parent().hide();
			if(form.find('[name=childTyp][value=13]').attr("checked"))
				form.find('[name=childTyp][value=10]').attr("checked","checked");
		}
		else
		{
			form.find('[name=childTyp][value=10]').parent().hide();
			form.find('[name=childTyp][value=11]').parent().hide();
			form.find('[name=childTyp][value=12]').parent().hide();
			form.find('[name=childTyp][value=13]').parent().show();
			form.find('[name=childTyp][value=13]').attr("checked","checked");
		}
	}

	toggleChildTyp("${accountVO.prntTyp}");
});
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
							<li class="stitle">${title }</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<form:form commandName="accountVO" name="accountVO" method="post" >
					<form:hidden path="accLv"/>
					<form:hidden path="accId"/>
					<div class="section01">	
						
						<!-- 게시판 시작  -->
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>계정과목 추가</caption>
		                    <colgroup><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
 								<tr>
								    <td class="title">계정명</td>
									<td class="pL10" >
										<form:input path="accNm" cssClass="span_22" />
									</td>
 								</tr> 
 								<tr>
								    <td class="title">상위계정</td>
									<td class="pL10" >
										<select name="prntAccIdSelector" id="prntAccIdSelector">
											<c:forEach items="${prntAccList}" var="item">
												<option value="${item.accId}/${item.prntTyp}/${item.prntTypNm}" 
													<c:if test="${item.accId==accountVO.prntAccId}">selected="selected"</c:if>>${item.accNm}
												</option>
											</c:forEach>
										</select>
										<input type="hidden" name="prntAccId" id="prntAccId" value="${accountVO.prntAccId}"/>
										&nbsp;&nbsp;&nbsp;계정분류 : <span id="prntTypNm">${accountVO.prntTypNm}</span> 
									</td>
 								</tr> 
 								<tr>
								    <td class="title">설명</td>
									<td class="pL10" >
										<form:input path="accCt" cssClass="span_22" />
									</td>
 								</tr> 
 								<tr>
								    <td class="title">지출타입</td>
									<td class="pL10" >
										<form:radiobuttons path="childTyp"
										items="${childTypList}" itemValue="code" itemLabel="codeNm" delimiter="&nbsp;"/>
									</td>
 								</tr> 
 								<tr>
								    <td class="title">사용여부</td>
									<td class="pL10" >
										<form:radiobuttons items="${useAtList}" path="useAt" itemValue="code" itemLabel="codeNm" delimiter="&nbsp;"/>
									</td>
 								</tr>                      	
		                    </tbody>
		                    </table>
						</div>
						<!-- 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<img src="${imagePath}/admin/btn/btn_save.gif" class="cursorPointer" id="accountSaveB"/>
		                	<img src="${imagePath}/admin/btn/btn_cancel.gif" class="cursorPointer" id="backB"/>
		                </div>
		                <!-- 버튼 끝 -->	
		                
					</div>
					</form:form>
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
