<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/ajax_inc.jsp"%>
 <script>
 
//todo: 추후 날짜 뺄셈 보강 
$(document).ready(function() {
	
	function calSumDate(){
		var startDay = specificVO.stDt.value; 
		var endDay = specificVO.edDt.value; 
		var stAmpm = $('#specificVO input[name="stAmpm"]:checked').val();
		var edAmpm = $('#specificVO input[name="edAmpm"]:checked').val();
		var target = this;
		if(startDay !="" && endDay !="") {
			/*
			if(endDay<startDay){
				alert("종료일이 시작일보다 나중입니다. 값을 확인해 주십시오.");
				$(this).datepicker("show");
				$(this).val("");
			} else {}
			*/			
			$.post("/ajax/approval/selectHolDateSum.do",$('#specificVO').serialize(),function(data){
				if(data<=0) {
					
					alert("유효하지 않은 기간입니다.");
					$('#specificVO input[name=edDt]').val("");
					$('#specificVO [name=sumDate]').val("");
					$('#specificVO input[name=stAmpm][value=1]').attr("checked","checked");
					$('#specificVO input[name=edAmpm][value=2]').attr("checked","checked");
					$(target).focus();
				} else
					$('#specificVO [name=sumDate]').val(data);
				
			});
			
			/*
			if($(this).hasClass("calGen")) {
				$(this).datepicker("hide");
			}
			*/		
		} 
	 }
	$('#vacationDayInform .calGen').change(calSumDate);
	$('#vacationDayInform input[type=radio]').click(calSumDate);
});
 </script>
 

<p class="th_stitle2 mB10">휴가신청 정보</p>
<div class="boardWrite02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
                <caption>공지사항 보기</caption>
                <colgroup><col class="col120" /><col width="px" /></colgroup>
                <tbody>
                	<tr>
                 	<td class="title">구분</td>
                 	<td class="pL10">
                 		<input type="radio" name="vacTyp" value ="1"<c:if test="${specificVO.vacTyp==1}"> checked </c:if> /> 연차
                 		<input type="radio" name="vacTyp" value ="2"<c:if test="${specificVO.vacTyp==2}"> checked </c:if> /> 경조휴가
                 		<input type="radio" name="vacTyp" value ="3"<c:if test="${specificVO.vacTyp==3}"> checked </c:if> /> 특별휴가
                 		<%-- <input type="radio" name="vacTyp" value ="5"<c:if test="${specificVO.vacTyp==5}"> checked </c:if> /> 하계휴가 --%>
                 		<input type="radio" name="vacTyp" value ="4"<c:if test="${specificVO.vacTyp==4}"> checked </c:if> /> 기타
                 	</td>
                	</tr>
                	<tr>
                 		<td class="title">기간</td>
                 		<td class="pL10" id="vacationDayInform">
                 			<input type ="text" name="stDt" class="span_5 calGen" value ="${specificVO.stDt}"/>
                 			<input type ="radio" name="stAmpm" value="1" <c:if test="${specificVO.stAmpm==1}"> checked </c:if>/> 오전
                 			<input type ="radio" name="stAmpm" value="2" <c:if test="${specificVO.stAmpm==2}"> checked </c:if>/> 오후 부터
                 			<input type ="text" name="edDt" class="span_5 calGen" value ="${specificVO.edDt}"/>
                 			<input type ="radio" name="edAmpm" value="1" <c:if test="${specificVO.edAmpm==1}"> checked </c:if>/> 오전
                 			<input type ="radio" name="edAmpm" value="2" <c:if test="${specificVO.edAmpm==2}"> checked </c:if>/> 오후 까지 총
                 			<input type ="text" name="sumDate" class="span_3" value ="${specificVO.sumDate}" readonly/> 일간                 			
                 		 </td>
                	</tr>
                	<tr>
                 		<td class="title">행선지</td>
                 		<td class="pL10" id="vacationWsPlace">
                 			<input type ="text" name="wsPlace" class="span_9" value="${specificVO.wsPlace}"/>                 			
                 		 </td>
                	</tr>
                	
                </tbody>
                </table>
</div>
