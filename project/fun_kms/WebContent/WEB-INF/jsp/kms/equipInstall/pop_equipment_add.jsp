<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
$(function(){
	$('#btn_regist').click(function(){
		if($('#solutionName').val() == ""){
			alert("솔루션 명을 입력하셔야 합니다.");
			$('#solutionName').focus();
			return false;
		}
		if($('#solutionName').length > 100){
			alert("100자 이상 입력 할 수 없습니다.");
			$('#solutionName').focus();
			return false;
		}
		if(confirm("작성된 내용으로 솔루션을 추가 하시겠습니까?")){
			$.ajax({
				url : '${rootPath}/equipInstall/equipmentAddWP.do',
				data : {
							"solutionNm" : $('#solutionName').val()
					   },
				dataType : 'json',
				type : 'post',
				success : function(data){
							if(data.result == "Y"){
								//alert("솔루션이 정상적으로 추가 되었습니다.");
								var html = '<option value="">-- 솔루션 --</option>';
								$('#solutionCode option', opener.document).remove();
							   for(var i=0; i<data.sList.length; i++){
								   html += '<option value="'+data.sList[i].solutionCode+'">'+data.sList[i].solutionNm+'</option>';
							   }
							   $('#solutionCode', opener.document).append(html);
							   //self.close();
							   location.reload();
							}else if(data.result == "S"){
								alert("이미 등록된 솔루션 입니다.");
							}else{
								alert("솔루션 추가에 실패 했습니다.");
							}
							
				},
				error: function(xhr, testStatus, errorThrown) {
					alert("솔루션 추가에 실패 했습니다.");
		  	 	}
			});
		}
	});
	$('#btn_close').click(function(){
		self.close();
	});

	$('#btn_modifyProcess').click(function(){
		var solCd = $('#solutionCd', opener.document).val();

		if($('#solutionName').val() == ""){
			alert("솔루션 명을 입력하셔야 합니다.");
			$('#solutionName').focus();
			return false;
		}
		if($('#solutionName').length > 100){
			alert("100자 이상 입력 할 수 없습니다.");
			$('#solutionName').focus();
			return false;
		}
		
		if(confirm("솔루션명을 수정 하시겠습니까?")){
			$.ajax({
				url : '${rootPath}/equipInstall/equipmentAddMP.do',
				data : {
							"solutionCode" : $('#solutionCode').val(),
							"solutionNm"   : $('#solutionName').val()
					   },
				dataType : 'json',
				type : 'post',
				success : function(data){
						   if(data.result == "Y"){
								//alert("솔루션이 정상적으로 수정 되었습니다.");
								var html = '<option value="">-- 솔루션 --</option>';
								$('#solutionCode option', opener.document).remove();
							   for(var i=0; i<data.sList.length; i++){
								   if(data.sList[i].solutionCode == solCd){
									   html += '<option value="'+data.sList[i].solutionCode+'" selected>'+data.sList[i].solutionNm+'</option>';
								   }else{
									   html += '<option value="'+data.sList[i].solutionCode+'">'+data.sList[i].solutionNm+'</option>';
								   }
								   
							   }
							   $('#solutionCode', opener.document).append(html);
							   location.reload();
						    }else{
								alert("솔루션 수정 실패 했습니다.");
							}
				},
				error: function(xhr, testStatus, errorThrown) {
					alert("솔루션 수정을 실패 했습니다.");
		  	 	}
			});
		}
	});
});

function lfn_delete(solCd){
	if(confirm("솔루션을 삭제 하시겠습니까?")){
		$.ajax({
			url : '${rootPath}/equipInstall/equipmentAddDP.do',
			data : {
						"solutionCode" : solCd
				   },
			dataType : 'json',
			type : 'post',
			success : function(data){
					   if(data.result == "Y"){
							//alert("솔루션이 정상적으로 삭제 되었습니다.");
							var html = '<option value="">-- 솔루션 --</option>';
							$('#solutionCode option', opener.document).remove();
						   for(var i=0; i<data.sList.length; i++){
							   html += '<option value="'+data.sList[i].solutionCode+'">'+data.sList[i].solutionNm+'</option>';
						   }
						   $('#solutionCode', opener.document).append(html);
						   location.reload();
						}else if(data.result == "U"){
							alert("사용중인 솔루션이므로 삭제할 수 없습니다.");
						}else{
							alert("솔루션 삭제를 실패 했습니다.");
						}
			},
			error: function(xhr, testStatus, errorThrown) {
				alert("솔루션 삭제를 실패 했습니다.");
	  	 	}
		});
	}
}

function lfn_modify(solCd, solNm){
	$('#btn_modifyProcess').show();
	$('#btn_regist').hide();
	
	$('#solutionCode').attr('value', solCd);
	$('#solutionName').attr('value', solNm);
}
function search(pageNo) {
	document.frm.pageIndex.value = pageNo;
	
	document.frm.submit();
}
</script>
</head>

<body>
<div id="pop_regist02">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
			<li class="popTitle">솔루션 입력</li>
		</ul>
 	</div>
 	<div class="pop_con08">
 	
       	<p class="th_stitle">솔루션 명 입력</p>
		<div class="boardList02 mB20">
			<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
            <caption>프로젝트 현황</caption>
            <colgroup>
	            <col class="col90" />
            </colgroup>
            <thead>
            	<tr>
            		<th>솔루션 명</th>
            	</tr>
            </thead>
            <tbody>
            	<tr>
            		<td>
            			<input type="text" id="solutionName" size="70"/>
            			<input type="hidden" id="solutionCode"/>
            		</td>
            	</tr>
            </tbody>
            </table>
		</div>
		<div class="pop_btn_area04">
			<img src="${imagePath}/btn/btn_modify.gif" class="cursorPointer" style="display:none" id="btn_modifyProcess"/>
			<img src="${imagePath}/btn/btn_regist.gif" class="cursorPointer" id="btn_regist"/>
			<img src="${imagePath}/btn/btn_close.gif" class="cursorPointer" id="btn_close"/>
		</div>
		
		<div class="pop_board mB20">
 		<p class="th_stitle">솔루션 목록</p>
 		<table cellpadding="0" cellspacing="0">
 			<colgroup><col class="col40" /><col width="px"/><col class="col90" /></colgroup>
 			<thead>
 				<tr>
 					<th class="title">번호</th>
 					<th class="title">솔루션 이름</th>
 					<th>수정/삭제</th>
 				</tr>
 			</thead>
 			<tbody>
 				<c:forEach items="${sList}" var="element" varStatus="index">
 				<tr>
 					<td class="Lright height24 txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((eiVO.pageIndex-1) * eiVO.recordCountPerPage + index.count) + 1}"/></td>
 					<td class="Lright height24 txt_center">${element.solutionNm}</td>
 					<td class="txt_center height24 td_last pT5"><img src="../../images/btn/btn_plus02.gif" id="btn_modify" class="cursorPointer" onclick="lfn_modify('${element.solutionCode}','${element.solutionNm}')"/> <img src="../../images/btn/btn_minus02.gif" class="cursorPointer" onclick="lfn_delete('${element.solutionCode}')"/></td>
 				</tr>
 				</c:forEach>
 			</tbody>
 		</table>
 		</div>
 		<!-- 페이징 시작 -->
		<div class="paginate">
			<ui:pagination paginationInfo="${paginationInfo}" jsFunction="search" type="image"/>
		</div>
		<!-- 페이징 끝 -->
	</div>
</div>
<form id="frm" name="frm" method="post">
<input type="hidden" name="pageIndex" value="${eiVO.pageIndex}"/>
</form>

	
</body>
</html>