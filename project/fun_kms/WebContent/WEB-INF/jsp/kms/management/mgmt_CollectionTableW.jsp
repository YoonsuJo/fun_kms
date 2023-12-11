<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>

<script>
function insertCollection() {

	var chkList = $('[name=checkList]');
	for (var i = 0; i < chkList.length; i++) {
		if ($(chkList[i]).attr('checked') == 'checked')
			$(chkList[i]).val("on");
		else
			$(chkList[i]).val("off");
	}
	$('[name=collectionLength]').val(chkList.length);
	$('[name=checkList]').attr('checked', 'checked');
	
	document.colFrm.action = '<c:url value="${rootPath}/management/collectionTableI.do" />';
	document.colFrm.submit();
}

$(document).ready(function(){
	$('#checkAll').change(function(){
		if($(this).attr("checked"))
			$('input[name=checkList]').attr("checked",true);
		else
			$('input[name=checkList]').attr("checked",false);
	});
	changeBankBook(document.fundVO.companyCd);
});

var searchKeyword = null;
var searchAction = null;
var targetTextBox = null;
var lock = false;

function custNmAutoComplete(obj){

	if (lock)
		return;
	else
		lock = true;
	
	targetTextBox = obj;
	
	var custDiv = null;
	/*
	$(obj).click(function() {
		popCustSearch($(this));
	});
	*/

	if (custDiv != null) {
		custDiv.dialog('destroy');
		custDiv.remove();
		custDiv = null;
	}

	custDiv = $('<div id="_custDiv">'+
			'<div class="ui_layer customer">'+
			'	<dl>'+
			'		<dd>검색어 : <input type="text" name="custSearchKeyword"/></dd>'+
			'	</dl>'+
			'	<div class="ui_List" style="height:490px;">'+
			'	</div>'+
			'</div>'+
		'</div>');
	
	custDiv.appendTo('body');
	var position = $(targetTextBox).offset();
	// custDiv.css("left",(position.left - 20)+"px");
	// custDiv.css("top",(position.top - 5)+"px");
	// custDiv.css("position","absolute");

	$('[name=custSearchKeyword]').keyup(function(){

		searchKeyword = this.value;
		//prjIdObj.data("searchKeyword",searchKeyword);
		if(searchAction)
		{
			clearTimeout( searchAction );
	    }
		searchAction = setTimeout(customerIncluded,300);
	});

	var width = custDiv.find(".ui_layer").css("width");
	width = parseInt(width.substr(0, width.indexOf("px"))) + 8;
	custDiv.dialog({
		width : width
		,height : 570
		,closeOnEscape: true 
		,resizable: true 
		,draggable: true
		,autoOpen: true 		
		,position : [(position.left - 20), (position.top - 5)]   
	});
	
	function customerIncluded(){

		if (searchKeyword == "") {
			return;
		}
		
		$.post("/ajax/bondPrjNoSearch.do?searchKeyword=" + encodeURI(searchKeyword),function(data){

			var size = $(data).find('.customerIncludedLi').size();
			if (size == 0) {
				return;
			}
			
			custDiv.find('.ui_List').html(data);
			
			//selectedPrjId = prjIdObj.val();
			//if(selectedPrjId!="")
			//	$('.prjUserIncludedLi input[name=prjUserIncluded_prjId][value='+selectedPrjId +']').parent().addClass('txtB_blue2');
			
			$('body').bind('click.customer', function custLayerClickEvent(event){
					if (!$(event.target).closest(custDiv).length) {
						custDiv.hide();
						$('body').unbind('click.customer');
				    };
				}
			);

			$('.customerIncludedLi').click(function(){
				$(targetTextBox).val($(this).find('[name=searchCustNm]').val());
				$(targetTextBox).next().val($(this).find('[name=searchBondPrjNo]').val());
				$(targetTextBox).next().next().val($(this).find('[name=searchBondPrjId]').val());
				if(typeof callback!= "undefined")
				{
					callback.call(this,prjNmObj, prjIdObj);
				}
				custDiv.dialog('destroy');
				custDiv.remove();
				$('body').unbind('click.customer');
			});
		});
	};

	lock = false;
}

function changeBankBook(obj) {

	var tag = $(obj).val();

	$('select[name=bankBook]').val('');
	$('select[name=bankBook]').children().remove();
	$('select[name=bankBook]').append($('select[name=bankBookSample]').find('option[tag=' + tag + ']').clone());
	$($('select[name=bankBook]').find('option[tag=' + tag + ']').get(0)).attr('selected', 'selected');
}

function fundCheck() {
	if ($('#fundAutoInsertCheck:checked').length > 0)
		$('.fundAutoInsert').removeAttr('disabled');
	else if ($('#fundAutoInsertCheck:checked').length == 0)
		$('.fundAutoInsert').attr('disabled', 'disabled');
}
</script>
</head>

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
							<li class="stitle">수금내역 조회</li>
							<li class="navi">홈 > 경영정보 > 채권관리 > 수금내역</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<form name="colFrm" id="colFrm" method="POST" onsubmit="insertCollection(); return false;">
						<input name="collectionLength" value="0" type="hidden" />
						
						<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col20" />
							<col width="px" />
							<col class="col100" />
							<col class="col80" />
							<col class="col60" />
							<col class="col60" />
							<col class="col60" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col"><input type="checkbox" id="checkAll" /></th>
								<th scope="col">업체명</th>
								<th scope="col">비고</th>
								<th scope="col">수금액</th>
								<th scope="col">수금일</th>
								<th scope="col">구분</th>
								<th scope="col">현금<br/>흐름</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${excelList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center"><input type="checkbox" name="checkList" <c:if test="${result.chk == 'true'}">checked="true"</c:if> /></td>
									<td class="txt_center">
										<c:if test="${result.chk == 'true'}">
											<input type="text" id="searchFromTaxPublish" onmouseup="javascript:custNmAutoComplete(this);" class="span_28" value="<print:date date='${result.autoPublishDate}' printType='S'/> ${result.autoCustNm} [${result.autoPrjCd}] ${result.autoPrjNm}"/>
										</c:if>
										<c:if test="${result.chk != 'true'}">
											<input type="text" id="searchFromTaxPublish" onmouseup="javascript:custNmAutoComplete(this);" class="span_28"/>
										</c:if>
										<input type="hidden" name="insertBondPrjNo" value="${result.autoPrjNo}" />
										<input type="hidden" name="insertBondPrjId" value="${result.autoPrjId}" /></td>
									<td class="txt_center"><input type="text" name="note" value="${result.contents}" class="span_6" /></td>
									<td class="txt_center"><print:currency cost="${result.deposit}" /><input type="hidden" name="insertExpense" value="${result.deposit}" /></td>
									<td class="txt_center"><print:date date="${result.date}" printType="S" /><input type="hidden" name="collectionDate" value="${result.date}" /></td>
									<td class="txt_center">
										<select name="type" class="fundAutoInsert span_4">
											<c:forEach items="${typeList}" var="type">
												<option
													value="${type.code}"
													<c:if test="${type.code == 'D' && result.deposit >= 0}">selected="selected"</c:if>
													<c:if test="${type.code == 'W' && result.deposit < 0}">selected="selected"</c:if>
												>
													${type.codeNm}
												</option>
											</c:forEach>
										</select>
									</td>
									<td class="txt_center">
										<select  name="account" class="select01 fundAutoInsert span_4" >
											<c:forEach items="${accountList}" var="account">
												<option
													value="${account.code}"
												>
													${account.codeNm}
												</option>
											</c:forEach>
										</select>
									</td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
						</div>
						
						<!-- 버튼 시작 -->
	           		    <div class="btn_area">
	           		    	<input type="checkbox" name="fundAutoInsertCheck" id="fundAutoInsertCheck" checked="checked" value="Y" onchange="javascript:fundCheck();"/> 자금보고 건 일괄등록&nbsp;&nbsp;&nbsp;
	           		    	회사구분 :&nbsp;
	                		<select name="companyCd" class="fundAutoInsert" onchange="javascript:changeBankBook(this);">
								<c:forEach items="${companyList}" var="company">
									<option
										value="${company.code}"
										<c:if test="${company.code == 'saeha'}">selected="selected"</c:if>
									>
										${company.codeNm}
									</option>
								</c:forEach>
							</select>
							&nbsp;/&nbsp;통장 :&nbsp;
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
							<select  name="bankBook" class="select01 fundAutoInsert">
								<c:forEach items="${bankBookList}" var="bankBook">
									<option
										value="${bankBook.code}" tag="${bankBook.codeDc}"
										<c:if test="${bankBook.codeDc != companyCd}">style="display:none;"</c:if>
									>
										${bankBook.codeNm}
									</option>
								</c:forEach>
							</select>
							&nbsp;&nbsp;
							<a href="javascript:insertCollection();">
	                			<img src="${imagePath}/btn/btn_regist.gif"/>
	                		</a>
	               	    </div>
	                 	<!-- 버튼 끝 -->
	                 	
	                 	</form>
						
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
