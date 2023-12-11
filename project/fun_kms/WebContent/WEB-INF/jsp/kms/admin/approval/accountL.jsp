	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="adminPrntAccount" staticJavascript="false" xhtml="true" cdata="false"/>

<script>

function view(accId)
{
	$('#searchVO').attr("action","/admin/approval/modifyAccount.do?accId="+ accId + "&accLv=2");
	$('#searchVO').submit();
			
}
$(document).ready(function(){
/*
	var fixHelper = function(e, ui) {
	    ui.children().each(function() {
	        $(this).width($(this).width());
	    });
	    return ui;
	};

	$('#accListT').sortable({
	 	helper: fixHelper,
		update: function(event, ui) { 
			//var result = $('#accListT').sortable("toArray");
	
			var order = new Object();
			$('#accListT').find('tr').each(function(idx, elm) {
				var templtId = $(elm).find("input[name=accId]").val();
			  	order[templtId] = idx.toString();
	
			});  
			order = JSON.stringify(order);
			order = escape(order);
			$.post("/ajax/updateAccountOrder.do",
					{"orderResult" : order}
					, function(data) {
				});
		 }
	});
	$('#accListT').disableSelection();
*/

	$('#prntAccListB').click(function(){
		$.post("/ajax/selectPrntAccountList.do",function(data){
			var layer = $('<div id="prntAccountL">'+ data + '</div>');
			layer.appendTo('body');
			layer.dialog({
	 		    height: 500
	 		   ,width:1000 
	 		   ,closeOnEscape: true 
	 		   ,resizable: true 
	 		   ,draggable: true
	 		   ,modal :true
	 		   ,autoOpen: true 		
	 		   ,position : [50,100]   
	 		,close: function(event,ui){
					layer.remove();

		 		}});
			
	 		$('#prntAccAddB').live("click",function(){
	 				$.post("/ajax/writePrntAccount.do?accLv=1",function(data){
	 				$('#prntAccAddL').html('');
					$('#prntAccAddL').html(data);

					$('#prntAccInsB').click(function(){
						//validate
						if(!validateAdminPrntAccount(document.accountVO))
								return;		
						$.post("/ajax/insertPrntAccount.do",$("#accountVO").serialize(),function(data){
							if(data.indexOf("success"))
							{
								$.post("/ajax/selectPrntAccountList.do",function(data){
									$('#prntAccountL').html(data);
								});
							}
							else
							{
							}
						});
			 		});
			 		
					
	 			});
	 		});

	 		$('#prntAccountL').find("#prntAccListT tr").live("click",function(){
		 		var accId = $(this).find("input[name=accId]").val();
	 			$.post("/ajax/modifyPrntAccount.do?accLv=1&accId="+accId,function(data){
	 				$('#prntAccAddL').html('');
					$('#prntAccAddL').html(data);

					$('#prntAccInsB').click(function(){
						if(!validateAdminPrntAccount(document.accountVO))
							return;		
						$.post("/ajax/updatePrntAccount.do",$("#accountVO").serialize(),function(data){
							if(data.indexOf("success")>0)
							{
								$.post("/ajax/selectPrntAccountList.do",function(data){
									$('#prntAccountL').html(data);
								});
							}
							else
							{
								alert($(data).html());
							}
				 		});
			 		});
					$('#prntAccAddCancleB').click(function(){
						$('#prntAccAddL').html('');
			 		});
	 			});
	 		});

	 		
		});
	});
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
							<li class="stitle">계정과목 관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<form:form commandName="searchVO" name="searchVO" method="post"></form:form>
					<div class="section01">	
						
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>계정과목 관리</caption>
							<colgroup><col class="col5" /><col class="col00" /><col class="col00" /><col class="col00" /><col class="col00" /><col width="px" /><col class="col90" /><col class="col5" /></colgroup>
							<thead>
								<tr>
								<th class="th_left"></th>
								<th scope="col">상위계정</th>
								<th scope="col">계정명</th>
								<th scope="col">계정분류</th>
								<th scope="col">지출타입</th>
								<th scope="col">설명</th>
								<th scope="col">사용여부</th>
								<th class="th_right"></th>
								</tr>
							</thead>
							<tbody id="accListT">
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr onclick="view('${result.accId}');" class="cursorPointer">
										<td class="hidden"><input type="hidden" value="${result.accId }" name="accId" /></td>
										<td class="txt_center" colspan="2">${result.prntAccNm }</td>
										<td class="txt_center" >${result.accNm }</td>
										<td class="txt_center">${result.prntTypNm }</td>
										<td class="txt_center">${result.childTypNm }</td>
										<td class="txt_center">${result.accCt }</td>
										<td colspan="2" class="txt_center">${result.useAt }</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
						
						<!-- 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<img src="${imagePath}/admin/btn/btn_topaccount.gif" class="cursorPointer" id="prntAccListB"/>
		                	<a href="/admin/approval/writeAccount.do?accLv=2"><img src="${imagePath}/admin/btn/btn_accountadd.gif"/></a>
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
