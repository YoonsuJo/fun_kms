<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="taskRegist" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function register() {
	
	$('#taskCn').val($('#taskCn').val().trim());
	
	if (!validateTaskRegist(document.frm)) {
		return;
	}
	
	if ($("#taskStartdate").val() != "" && $("#taskDuedate").val() != "" && $("#taskStartdate").val() > $("#taskDuedate").val()) {
		alert("시작일과 완료예정일을 확인해주세요.");
		return;
	}

	if($("#alwaysViewCheck").prop("checked")){
		$("#alwaysViewYn").val('Y');
	}else{
		$("#alwaysViewYn").val('N');
	}


	if (isNaN($("#taskStarttime").val())) {
		alert("시간에는 숫자를 입력해야합니다.");
		return;
	}
	if ($("#taskStarttime").val() > 24) {
		alert("시간은 24보다 작거나 같은 값만 입력할 수 있습니다.");
		return;
	}

	if (isNaN($("#taskDuetime").val())) {
		alert("시간에는 숫자를 입력해야합니다.");
		return;
	}
	if ($("#taskDuetime").val() > 24) {
		alert("시간은 24보다 작거나 같은 값만 입력할 수 있습니다.");
		return;
	}

	/*
	var wsTyp = $("input[type=radio][name=wsTyp]:checked").val();
	if(wsTyp == "O" && ($("#taskStarttime").val() == "" || $("#taskDuetime").val() == "")) {
		alert("시간이 잘못되었습니다. 다시 확인해주세요.");
		return;
	}
	*/
	//if(wsTyp == "T" || wsTyp == "S") {
	//	$("#taskStarttime").val("");
	//	$("#taskDuetime").val("");
	//}
	
	if($("#wsTyp").val() != "" && ($("#wsPlace").val() == "")) {
		alert("행선지를 확인해 주세요.");
		return;
	}
	
	
	
	document.frm.submit();					
}

$(document).ready(function() {
	//기존 사이즈 570, 450
	window.resizeTo(770, 850);
});


//부재 현황 등록
function chngAbsTyp(type) {

	var trWsPlace = document.getElementById("trWsPlace");

	if($("#wsTypCheck").prop("checked")){
		$("#wsTyp").val('O');
		trWsPlace.style.display = "";
	}else{
		$("#wsTyp").val('');
		trWsPlace.style.display = "none";
	}

	/*
	if (type=="O") {
		trWsPlace.style.display = "";
	} else if (type=="T") {
		trWsPlace.style.display = "";
	} else if (type=="S") {
		trWsPlace.style.display = "";
	} else {
		trWsPlace.style.display = "none";
	}
	*/
}
</script>
</head>

<body>
<div id="pop_regist03">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
			<li class="popTitle">새 작업 등록하기</li>
		</ul>
 	</div>
 	
 	<div class="pop_con10">
 		<form:form name="frm" commandName="taskRegist" method="POST" action="${rootPath}/cooperation/insertTask.do" enctype="multipart/form-data">
 		<input type="hidden" name="writerNo" id="writerNo" value="${user.no}"/>
		<input type="hidden" name="taskState" id="taskState" value="P" />
		<input type="hidden" name="alwaysViewYn" id="alwaysViewYn"/>
		<input type="hidden" name="param_returnUrl" id="param_returnUrl" value="${param_returnUrl}"/>
		
		
 		<table cellpadding="0" cellspacing="0">
 			<colgroup>
 				<col class="col90" />
				<col class="col120" />
				<col class="col90" />
				<col class="col120" />
				<col class="col60" />
				<col class="px" />
 			</colgroup>
 			<tbody>
 				<tr>
 					<td class="title" >프로젝트</td>
 					<td class="pL10" colspan="5">
 						<input type="text" class="span_19" name="prjNm" id="prjNm" readonly="readonly" onclick="prjGen('prjNm','prjId',1);"/>
 						<img src="${imagePath}/btn/btn_tree.gif" onclick="prjGen('prjNm','prjId',1);" class="cursorPointer"/>
 						<input type="hidden" class="span_19" name="prjId" id="prjId" />
 					</td>
 				</tr>
 				<tr>
 					<td class="title" >작업명</td>
 					<td class="pL10" colspan="5"><input type="text" class="span_19" name="taskSj" id="taskSj"/></td>
 				</tr>
 				<tr>
 					<td class="title" >담당자</td>
 					<td class="pL10" colspan="5">
 						<input type="text" class="span_19 userNamesAuto userValidateCheck" name="userNm" id="userNm" value="${member.userNm}(${member.userId})"/>
 						<img src="${imagePath}/btn/btn_tree.gif" onclick="usrGen('userNm',0);" class="cursorPointer"/>
 					</td>
 				</tr>
 				<tr>
 					<td class="title" >시작일</td>
 					<td class="pL10" colspan="">
 					<input type="text" class="span_4 calGen" name="taskStartdate" id="taskStartdate" value="${date}"/>
 					<input type="text" class="span_15px" name="taskStarttime" id="taskStarttime" value="9" onfocus="numGen('taskStarttime',9,18,5);"/> 시
 					</td>
 					<td class="title" >완료예정일시</td>
 					<td class="pL10">
 						<input type="text" class="span_4 calGen" name="taskDuedate" id="taskDuedate" value="${date}"/>
 						<input type="text" class="span_15px" name="taskDuetime" id="taskDuetime" value="18" onfocus="numGen('taskDuetime',9,18,5);"/> 시
 					</td>
 					<td class="title cursorPointer" title="작업기간내 오늘의 업무에 계속 보여집니다.">계속보기</td>
 					<td class="pL10 cursorPointer" title="작업기간내 오늘의 업무에 계속 보여집니다."><input type="checkbox" name="alwaysViewCheck" id="alwaysViewCheck" checked="true"/></td>
 				</tr>
 				<tr>
 					<td class="title">등록자</td>
 					<td class="pL10"><print:user userNo="${user.no}" userNm="${user.userNm}"/></td>
 					<td class="title">진행상태</td>
 					<td class="pL10" colspan="3"><span class="txt_blue">진행중</span></td>
 				</tr>
 				<tr>
 					<td class="title">내용</td>
 					<td class="pL10 pT5 pB5" colspan="5">
 						<textarea name="taskCn" id="taskCn" class="span_12 height_170"></textarea>
 					</td>
 				</tr>
 				
 				<!-- 부재 현황 등록  -->
 				<tr>
                   	<td class="title">외근등록</td>
                   	<td class="pL10" colspan="5">
               	 		<!-- 
               	 		<label><input name="wsTyp" id="wsTyp" type="radio" value="" onclick="chngAbsTyp('');" checked="checked"/> 본사</label>
               	 		<label><input name="wsTyp" id="wsTyp" type="radio" value="O" onclick="chngAbsTyp('O');"/> 외근</label>
               			<label><input name="wsTyp" id="wsTyp" type="radio" value="T" onclick="chngAbsTyp('T');"/> 출장</label>
               			<label><input name="wsTyp" id="wsTyp" type="radio" value="S" onclick="chngAbsTyp('S');"/> 파견</label>
               			 -->
               			<label>
               			<input type="checkbox"  name="wsTypCheck" id="wsTypCheck" onclick="chngAbsTyp('O');"/>
               			<input type="hidden" name="wsTyp" id="wsTyp"/>     
               			</label>                			         			
               		</td>
                  </tr>
                <tr id="trWsPlace" style="display: none">
	               	<td class="title">행선지</td>
	               	<td class="pL10" colspan="5">
	               		<input type="text" name="wsPlace" id="wsPlace" class="span_10" /> 
	               		<span class="icn_new">예) 삼성SDS (용산,토투밸리)</span>
	               	</td>
              	</tr> 				
 			</tbody>
 		</table>
 		</form:form>
 		
 	    <div class="pop_btn_area">
            <a href="javascript:register();"><img src="${imagePath}/btn/btn_regist.gif"/></a>
            <a href="javascript:window.close();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
        </div>
 		
 	</div>
</div>

</body>
</html>
