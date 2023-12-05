<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function install(){
	document.frm.action = "<c:url value='${rootPath}/support/installI.do'/>";
	document.frm.submit();
}
$(document).ready(function() {
	changeCategoryNo();
	$($('select[name=searchItmNo]').find('option[value=${search.searchItemNo}]').get(0)).attr('selected', 'selected');
});

function changeCategoryNo() {
	var tag = $('select[name=categoryNo]').val();
	$('select[name=searchItemNo]').val('');
	$('select[name=searchItemNo]').children().remove();
	$('select[name=searchItemNo]').append($('select[name=itemNoSample]').find('option[tag=' + tag + ']').clone());
	//$($('select[name=searchItemNo]').find('option[tag=' + tag + ']').get(0)).attr('selected', 'selected');
}

function search() {
	document.frm.action = "<c:url value='${rootPath}/support/installL.do'/>";
	document.frm.submit();
}

$(document).ready(function(){
	$('.check').change(function(){
		if($(this).attr("checked")) {
			$('input[name=checkList]').attr("checked",false);
			$('input[name=checkList]').closest('tr').find('select').attr('disabled', 'disabled');
			$(this).attr("checked",true);
			$(this).closest('tr').find('select').removeAttr('disabled');
		}
	});
});
</script>
</head>

<body style="overflow-X:hidden;overflow-Y:hidden" onunload="parent.window.refresh();"><div id="pop_message">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
			<li class="popTitle">설치 대상 선택</li>
		</ul>
 	</div>
 	
 	<div id="pop_con02">
 		<form method="POST" name="frm">
 		<input type="hidden" name="swNo" value="${search.swNo}" />
 		<table cellpadding="0" cellspacing="0">
 			<colgroup>
 				<col class="col90" />
 				<col width="px" />
 			</colgroup>
 			<thead>
 				 <tr>
					<th class="title2" scope="col">
						<select name="categoryNo" class="span_7" onchange="javascript:changeCategoryNo();">
                   			<c:forEach items="${categoryList}" var="category" varStatus="c">
                   			<option value="${category.no }"
                    			<c:if test="${category.no == search.categoryNo }">
                    				selected="selected"
                    			</c:if>
                   			>${category.categoryName }</option>
                   			</c:forEach>
                   		</select>
						<select name="itemNoSample" class="span_6" style="display:none;">
                   			<c:forEach items="${itemList}" var="item" varStatus="c">
                   				<option value="${item.no }" tag="${item.categoryNo }"
                   				<c:if test="${item.no == search.searchItemNo }">
                    				selected="selected"
                    			</c:if> 
                   				>${item.itemName}</option>
                   			</c:forEach>
                   		</select>
                   		<select name="searchItemNo" class="span_6" >
                   			<c:forEach items="${itemList}" var="item" varStatus="c">
                   				<option value="${item.no }" tag="${item.categoryNo }"
                   				<c:if test="${item.no == search.searchItemNo }">
                    				selected="selected"
                    			</c:if>
                   				 >${item.itemName}</option>
                   			</c:forEach>
                   		</select>
                   		<a href="javascript:search();"><img src="${imagePath}/btn/btn_search04.gif"/></a>
					</th>
				</tr>
 			</thead>
 		</table>
 		<div class="popNote_scroll">
	 		<table cellpadding="0" cellspacing="0">
	 			<colgroup>
	 				<col class="col80" />
	 				<col width="px" />
	 				<col class="col180" />
	 				<col class="col80" />
	 				<col class="col120" />
	 			</colgroup>
	 			<tbody>
	 				<c:forEach items="${resultList}" var="result" varStatus="c">
           				<tr>
           					<td class="txt_center">
           						<input type="checkbox" name="hwNo" value="${result.no }" class="check"/>
           					</td>
		 					<td>
		 						${result.serialNo }
		 					</td>
		 					<td>
		 						입고일:${result.inputDate }
		 					</td>
		 					<td>
		 						${result.statusNm }
		 					</td>
		 					<td>
		 						<select name="typ" class="span_6" disabled="disabled">
		                   			<option value="1">Codec</option>
		                   			<option value="2">Camera</option>
		                   			<option value="3">Phone</option>
		                   			<option value="4">Mic Pod</option>
		                   		</select>
		 					</td>
		 				</tr>
           			</c:forEach>
	 			</tbody>
	 		</table>
 		</div>
 		
 		<p></p>
      
		<div class="pop_btn_area">
            <a href="javascript:install();"><img src="${imagePath}/btn/btn_install.gif"/></a>
			<a href="javascript:window.close();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
        </div>
 		</form>
 	</div>
</div>

</body>
</html>
