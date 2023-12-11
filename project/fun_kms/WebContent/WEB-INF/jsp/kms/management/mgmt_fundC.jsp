<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>


<validator:javascript formName="fund" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='${commonPath}/js/jquery.validate.js'/>" ></script>


<script>
$(document).ready(function() {
	jsMakeCurrency($('#expense').get(0));
	$('#expense').keyup(function(){
		if ($(this).val().length != 0)
			jsMakeCurrency(this);
	});
	changeBankBook(document.fundVO.companyCd);
	$($('select[name=bankBook]').find('option[value=${result.bankBook}]').get(0)).attr('selected', 'selected');
});

function updateFund() {

	if (!validateFund(document.fundVO)) {
		return;
	}

	$('#expense').val(parseInt(jsDeleteComma($('#expense').val())));

	document.fundVO.action = '<c:url value="${rootPath}/management/fundU.do" />';
	document.fundVO.submit();
}

function changeType(obj) {
	var type = obj.value;
	if (type == 'D') {
		$('#account').show();
		var optionList = $('select[name=account]').find('option');
		for (var i = 0; i < optionList.length; i++) {
			$(optionList[i]).attr('selected', '');
			if ($(optionList[i]).attr('tag') == 'D') {
				$(optionList[i]).show();
			} else if ($(optionList[i]).attr('tag') == 'W') {
				$(optionList[i]).hide();
			}
		}
		$('option[tag=W]').attr('selected', '');
		$($('option[tag=D]').get(0)).attr('selected', 'selected')
	} else if (type == 'W') {
		$('#account').show();
		var optionList = $('select[name=account]').find('option');
		for (var i = 0; i < optionList.length; i++) {
			$(optionList[i]).attr('selected', '');
			if ($(optionList[i]).attr('tag') == 'D') {
				$(optionList[i]).hide();
			} else if ($(optionList[i]).attr('tag') == 'W') {
				$(optionList[i]).show();
			}
		}
		$('option[tag=D]').attr('selected', '');
		$($('option[tag=W]').get(0)).attr('selected', 'selected')
	} else if (type == 'RD') {
		$('#account').hide();
	} else if (type == 'RW') {
		$('#account').hide();
	}
}

function changeBankBook(obj) {

	var tag = $(obj).val();

	$('select[name=bankBook]').val('');
	$('select[name=bankBook]').children().remove();
	$('select[name=bankBook]').append($('select[name=bankBookSample]').find('option[tag=' + tag + ']').clone());
	// $($('select[name=bankBook]').find('option[tag=' + tag + ']').get(0)).attr('selected', 'selected');
}
</script>


<body>

<div id="wrap">
	<%@ include file="../common/menu/head.jsp"%>
	<!-- S: container -->
	<div id="container">
		<ul class="container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="contents">
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
			<!-- S: center -->
			<div id="center">
				<div class="path_navi">
					<ul>
						<li class="stitle">주간자금보고 수정</li>
						<li class="navi">홈 > 경영정보 > 자금관리 > 주간자금보고 수정</li>
					</ul>
				</div>
				<!-- S: section -->
				<div class="section01">
					
					<form:form commandName="fundVO" id="fundVO" name="fundVO" method="post">
					<input name="fundNo" type="hidden" value="${result.fundNo }" />
					<input name="plan" type="hidden" value="N" />
					<input type="hidden" name="searchDate" value="${searchDate }"/>
					
	           		<p class="th_stitle">주간자금보고 등록</p>
           		 	<!-- 게시판 시작  -->
					<div class="boardWrite02 mB20">
						
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>주간자금보고 등록</caption>
	                    <colgroup>
	                    	<col class="col100" />
	                    	<col width="px" />
                    	</colgroup>
	                    <tbody>
	                    	<tr>
		                    	<td class="title">일자</td>
		                    	<td class=" pL10"><input type="text" class="input01 span_5 calGen" name="date" value="${result.date }"/></td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title">일자</td>
		                    	<td class=" pL10">
		                    		<input type="hidden" class="input01 span_11" name="companyCd" id="companyCd" value="${result.companyCd }"/>
		                    		<select name="companyCdDisabled" disabled="true">
										<c:forEach items="${companyList}" var="company">
											<option
												value="${company.code}"
												<c:if test="${company.code == result.companyCd}">selected="selected"</c:if>
											>
												${company.codeNm}
											</option>
										</c:forEach>
									</select>
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title">구분</td>
		                    	<td class=" pL10">
		                    		<input name="type" type="hidden" value="W" />
		                    		<c:forEach items="${typeList}" var="type" varStatus="c">
		                    		<input type="radio" class="check" name="typeDisabled" value="${type.code}" disabled="true" <c:if test="${result.type == type.code}">checked="checked"</c:if>/>
		                    		<span>${type.codeNm}</span>
		                    		</c:forEach>
		                    	</td>
	                    	</tr>
	                    	<tr id="account" <c:if test="${'D' != result.type && 'W' != result.type}">style="display:none;"</c:if>>
		                    	<td class="title">현금흐름</td>
		                    	<td class=" pL10">
									<select  name="account" class="select01" >
										<c:forEach items="${accountList}" var="account">
											<c:if test="${account.codeDc == 'W'}">
											<option
												value="${account.code}" tag="${account.codeDc}"
												<c:if test="${result.account == account.code}">selected="selected"</c:if>
											>
												${account.codeNm}
											</option>
											</c:if>
										</c:forEach>
									</select>
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title">통장</td>
		                    	<td class=" pL10">
									<select name="bankBookSample" class="select01" style="display:none">
										<c:forEach items="${bankBookList}" var="bankBook">
											<option
												value="${bankBook.code}"
												tag="${bankBook.codeDc}"
											>
												${bankBook.codeNm}
											</option>
										</c:forEach>
									</select>
									<select  name="bankBook" class="select01" >
										<c:forEach items="${bankBookList}" var="bankBook">
											<option
												value="${bankBook.code}" tag="${bankBook.codeDc}"
												<c:if test="${bankBook.codeDc != companyCd}">style="display:none;"</c:if>
												<c:if test="${result.bankBook == bankBook.code}">selected="selected"</c:if>
											>
												${bankBook.codeNm}
											</option>
										</c:forEach>
									</select>
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="title">금 액</td>
		                    	<td class="pL10">
		                    		<input type="hidden" class="input01 span_11" name="expense" id="expense" value="${result.expense }"/>
		                    		<input type="text" class="input01 span_11" name="expenseDisabled" id="expense" disabled="true" value="${result.expense }"/>
		                    	</td>
	                    	</tr>
	                    	<tr>
			                    <td class="title">프로젝트</td>
			                    <td class="pL10">
			                    		<input type="text" class="span_12" name="prjNm" id="prjNm" readonly="readonly" onclick="prjGen('prjNm','prjId',1)" onfocus="prjGen('prjNm','prjId',1)" value="[${result.prjCd}] ${result.prjNm }" />
			                    		<input type="hidden" class="span_12" name="prjId" id="prjId" value="${result.prjId }" />
			                    		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen('prjNm','prjId',1)" />
			                    </td>
			                </tr>
	                    	<tr>
		                    	<td class="title">내 역</td>
		                    	<td class="pL10 pT5 pB5"><textarea class="span_23" name="note">${result.note }</textarea></td>
	                    	</tr>
	                    	
	                    </tbody>
	                    </table>
					</div>
					<!--// 게시판 끝  -->
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
                		<img src="../../images/btn/btn_pay.gif" onclick="javascript:updateFund();" class="cursorPointer"/>
                		<img src="../../images/btn/btn_cancel.gif" onclick="javascript:history.back();" class="cursorPointer"/>
               	    </div>
                 	<!-- 버튼 끝 -->
                 	
                 	</form:form>

				</div>
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
