<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
$(function(){
	$('#btn_close').click(function(){
		self.close();
	});

	$('span[id^="gubun_"]').click(function(){
		var gubunId = $(this).attr('id').replace('gubun_', '');

		$('#gubunNo', opener.document).val(gubunId);
		self.close();
	});

	
	//입력
	$('#btn_regist').click(function(){
		var gubunNo = $('#gubunNo', opener.document).val();
		
		if($('#gubunNm').val() == ""){
			alert("업무구분 명을 입력하셔야 합니다.");
			$('#gubunNm').focus();
			return false;
		}
		if($('#gubunNm').length > 100){
			alert("100자 이상 입력 할 수 없습니다.");
			$('#gubunNm').focus();
			return false;
		}
		if(confirm("작성된 내용으로 업무구분을 추가 하시겠습니까?")){
			$.ajax({
				url : '${rootPath}/support/bpManualGubunWrite.do',
				data : {
							"gubunNm" : $('#gubunNm').val()
					   },
				dataType : 'json',
				type : 'post',
				success : function(data){
							if(data.result == "Y"){
								var html = '<option value="">-- 업무구분 --</option>';
								$('#gubunNo option', opener.document).remove();
							   for(var i=0; i<data.gubunList.length; i++){
								   if(data.gubunList[i].gubunNo == gubunNo){
									   html += '<option value="'+data.gubunList[i].gubunNo+'" selected>'+data.gubunList[i].gubunNm+'</option>';
								   }else{
									   html += '<option value="'+data.gubunList[i].gubunNo+'">'+data.gubunList[i].gubunNm+'</option>';
								   }
							   }
							   $('#gubunNo', opener.document).append(html);
							   location.reload();
							}else if(data.result == "S"){
								alert("이미 등록된 솔루션 입니다.");
								location.reload();
							}else{
								alert("솔루션 추가에 실패 했습니다.");
								location.reload();
							}
				},
				error: function(xhr, testStatus, errorThrown) {
					alert("솔루션 추가에 실패 했습니다.");
					location.reload();
		  	 	}
			});
		}
	});
	//수정
	$('#btn_modifyProcess').click(function(){
		var gubunNo = $('#gubunNo', opener.document).val();
		
		if(confirm("솔루션명을 수정 하시겠습니까?")){
			$.ajax({
				url : '${rootPath}/support/bpManualGubunModify.do',
				data : {
							"gubunNo" : $('#gubunNo').val(),
							"gubunNm"   : $('#gubunNm').val()
					   },
				dataType : 'json',
				type : 'post',
				success : function(data){
						   if(data.result == "Y"){
								var html = '<option value="">-- 솔루션 --</option>';
								$('#gubunNo option', opener.document).remove();
							   for(var i=0; i<data.gubunList.length; i++){
								   if(data.gubunList[i].gubunNo == gubunNo){
									   html += '<option value="'+data.gubunList[i].gubunNo+'" selected>'+data.gubunList[i].gubunNm+'</option>';
								   }else{
									   html += '<option value="'+data.gubunList[i].gubunNo+'">'+data.gubunList[i].gubunNm+'</option>';
								   }
							   }
							   $('#gubunNo', opener.document).append(html);
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

//삭제
function lfn_delete(gubunNo){
	if(confirm("업무구분을 삭제 하시겠습니까?")){
		$.ajax({
			url : '${rootPath}/support/bpManualGubunDelete.do',
			data : {
						"gubunNo" : gubunNo
				   },
			dataType : 'json',
			type : 'post',
			success : function(data){
					   if(data.result == "Y"){
							var html = '<option value="">-- 업무구분 --</option>';
							$('#gubunNo option', opener.document).remove();
						   for(var i=0; i<data.gubunList.length; i++){
							   html += '<option value="'+data.gubunList[i].gubunNo+'">'+data.gubunList[i].gubunNm+'</option>';
						   }
						   $('#gubunNo', opener.document).append(html);
						   location.reload();
						}else if(data.result == "U"){
							alert("사용중인 업무구분 이므로 삭제할 수 없습니다.");
							location.reload();
						}else{
							location.reload();
						}
			},
			error: function(xhr, testStatus, errorThrown) {
				alert("업무구분 삭제를 실패 했습니다.");
				location.reload();
	  	 	}
		});
	}
}

function lfn_modify(gNo, gNm){
	$('#btn_modifyProcess').show();
	$('#btn_regist').hide();
	
	$('#gubunNo').attr('value', gNo);
	$('#gubunNm').attr('value', gNm);
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
			<li class="popTitle">업무구분 등록</li>
		</ul>
 	</div>
 	<div class="pop_con08">
 	
       	<p class="th_stitle">업무구분 등록</p>
		<div class="boardList02 mB20">
			<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
            <caption>업무구분 현황</caption>
            <colgroup>
	            <col class="col90" />
            </colgroup>
            <thead>
            	<tr>
            		<th>업무구분 명</th>
            	</tr>
            </thead>
            <tbody>
            	<tr>
            		<td>
            			<input type="text" id="gubunNm" size="70"/>
            			<input type="hidden" id="gubunNo"/>
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
 		<p class="th_stitle">업무구분 목록</p>
 		<table cellpadding="0" cellspacing="0">
 			<colgroup><col class="col40" /><col width="px"/><col class="col90" /></colgroup>
 			<thead>
 				<tr>
 					<th class="title">번호</th>
 					<th class="title">업무구분 명</th>
 					<th>수정/삭제</th>
 				</tr>
 			</thead>
 			<tbody>
 				<c:forEach items="${gubunList}" var="element" varStatus="index">
 				<tr>
 					<td class="Lright height24 txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((bpmVO.pageIndex-1) * bpmVO.recordCountPerPage + index.count) + 1}"/></td>
 					<td class="Lright height24 txt_center"><span class="cursorPointer" id="gubun_${element.gubunNo}">${element.gubunNm}</span></td>
 					<td class="txt_center height24 td_last pT5"><img src="../../images/btn/btn_plus02.gif" id="btn_modify" class="cursorPointer" onclick="lfn_modify('${element.gubunNo}','${element.gubunNm}')"/> <img src="../../images/btn/btn_minus02.gif" class="cursorPointer" onclick="lfn_delete('${element.gubunNo}')"/></td>
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