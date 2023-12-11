<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="ConsultClient" staticJavascript="false"	xhtml="true" cdata="false" />
<script type="text/javascript">
//고객사관리 정보 인서트
function insertArticle() {
	if (!validateConsultClient(document.frm)) {
		return;
	}
	
	// ValidEmail
	var email = document.frm.custEmail.value;
	if (email.length > 0) {
		if (!isValidEmail(document.frm.custEmail.value)) {
			alert('유효하지 않은 이메일입니다.');
			return;
		}
	}
	
	if(confirm("등록하시겠습니까?")){
		document.frm.action = "<c:url value='${rootPath}/cooperation/insertClient.do'/>";
		document.frm.submit();
	}			
}
//고객사관리 정보 인서트
function moveConsultArticle() {
	if (!validateConsultClient(document.frm)) {
		return;
	}
	
	// ValidEmail
	var email = document.frm.custEmail.value;
	if (email.length > 0) {
		if (!isValidEmail(document.frm.custEmail.value)) {
			alert('유효하지 않은 이메일입니다.');
			return;
		}
	}
	
	if(confirm("고객사 정보 저장 후 상담관리 화면으로 이동하시겠습니까?")){
		document.frm.directConsult.value = 'Y';
		document.frm.action = "<c:url value='${rootPath}/cooperation/insertClient.do'/>";
		document.frm.submit();
	}
}


$(document).ready(function() {
	initSearchBox();
});

var searchKeyword = null;
var searchAction = null;
var searchState = 0;

function initSearchBox(){
	//return;
	$('input[name=custNm]').keyup(function(e) {
		console.log(e.which);
		if (e.which == 38)
		{
			if (0 > searchState - 1)
				return;
			else
				searchState = searchState - 1;
			$('.customerIncludedLi').removeClass('light_on');
			$($('.customerIncludedLi').get(searchState)).addClass('light_on');
		}
		else if (e.which == 40)
		{
			if ($('.customerIncludedLi').length - 1 < searchState + 1)
				return;
			else
				searchState = searchState + 1;
			$('.customerIncludedLi').removeClass('light_on');
			$($('.customerIncludedLi').get(searchState)).addClass('light_on');
		}
		else if (e.which == 13)
		{
			if (searchState == -1) return;
			$('input[name=custNm]').val('');
			$('input[name=custManager]').val('');
			$('input[name=custTelno]').val('');
			$('input[name=custEmail]').val('');
			$('input[name=etcInfo]').val('');
			if ($('#custDiv').length > 0) $('#custDiv').remove();
			alert('이미 등록된 고객사입니다.');
		}
		else
		{
			searchKeyword = $(this).val();
			if (searchKeyword == "" || searchKeyword == " ") {
				if($('#custDiv').length > 0) $('#custDiv').remove();
				return;
			}
			searchKeyword = encodeURI(searchKeyword);
			$.post("/ajax/consultCompanyList.do?searchCust="+searchKeyword,function(data){
				if($('#custDiv').length > 0) $('#custDiv').remove();
				var size = $(data).find('.customerIncludedLi').size();
				if (size == 0) return;
				var custDiv = '<div id="custDiv" class="Customer_layer"></div>';
				custDiv = $(custDiv);
				custDiv.html(data);
				custDiv.css('top', $('input[name=custNm]').offset().top + 20);
				custDiv.css('left', $('input[name=custNm]').offset().left);
				custDiv.css('zIndex', '1');
				custDiv.appendTo('body');
				custDiv.show();

				custDiv.find('li').mouseover(function() {
					$('.customerIncludedLi').removeClass('light_on');
					$(this).addClass('light_on');
				});
				custDiv.find('li').mouseout(function() {
					$('.customerIncludedLi').removeClass('light_on');
					searchState = -1;
				});
				custDiv.find('li').click(function() {
					$('input[name=custNm]').val('');
					$('input[name=custManager]').val('');
					$('input[name=custTelno]').val('');
					$('input[name=custEmail]').val('');
					$('input[name=etcInfo]').val('');
					if ($('#custDiv').length > 0) $('#custDiv').remove();
					alert('이미 등록된 고객사입니다.');
				});
				$('body').bind('click.custSerach', function(event){
					if (!$(event.target).closest(custDiv).length && event.target !== $('#custDiv').get(0)) {
						$('body').unbind('click.custSerach');
						if ($('#custDiv').length > 0) $('#custDiv').remove();
					}
				});
				
				searchState = -1;
			});
		}
	});
}

</script>
</head>

<body>
	<div id="pop_regist07">
	<div id="pop_top">
		 <ul>
			<li><img src="../images/inc/pop_bullet.gif" /></li>
			<li class="popTitle">고객사 등록</li>
		</ul>
	</div>
	<div class="pop_con14">
		
		<div class="pop_board mB20">
		<form:form commandName="frm" name="frm" method="post">
		<input type="hidden" name="directConsult" value="N"/>
		<table cellpadding="0" cellspacing="0">
			<colgroup>
				<col class="col100" />
				<col width="px"/>
			</colgroup>
			<tbody>
				<tr>
					<td class="title" >고 객 사(*)</td>
					<td class="pL10">
						<input type="text" name="custNm" class="input01 span_12" value=""/>
					</td>
				</tr>
				<tr>
					<td class="title" >고 객 명(*)</td>
					<td class="pL10">
						<input type="text" name="custManager" class="input01 span_12" value=""/>
					</td>
				</tr>
				<tr>
					<td class="title" >연 락 처(*)</td>
					<td class="pL10">
						<input type="text" name="custTelno" class="input01 span_12" value=""/>
					</td>
				</tr>
				<tr>
					<td class="title" >이 메 일</td>
					<td class="pL10">
						<input type="text" name="custEmail" class="input01 span_12" value=""/>
					</td>
				</tr>
				<tr>
					<td class="title" >기타정보</td>
					<td class="pL10">
						<textarea name="etcInfo" class="height_130" style="width:390px;"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		</form:form>
		</div>
		
		<div class="pop_btn_area">
			<c:if test="${empty fromInsertConsult}"><a href="javascript:moveConsultArticle()"><img src="${imagePath}/btn/btn_goConsul.gif" alt="상담하기"/></a></c:if>
			<a href="javascript:insertArticle()"><img src="${imagePath}/btn/btn_regist.gif" alt="등록"/></a>
			<img src="${imagePath}/btn/btn_close.gif" alt="창닫기" class="cursorPointer" onclick="window.close();">
		</div>
		
	</div>
</div>

</body>
</html>
