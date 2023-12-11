	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(move) {
	document.frm.move.value = move;
	document.frm.submit();
}
function insert() {
	//var form =$('#searchVO');
	var form =$('#specificVO');	
	form.attr("action", "${rootPath}/admin/approval/insertVacationList.do");
	form.submit();
	//document.frm.action = "${rootPath}/admin/approval/insertVacationList.do";
	//document.frm.submit();
}

$(document).ready(function()
{
	function calSumDate(){
		var startDay = specificVO.stDt.value; 
		var endDay = specificVO.edDt.value; 
		var stAmpm = $('#specificVO input[name="stAmpm"]:checked').val();
		var edAmpm = $('#specificVO input[name="edAmpm"]:checked').val();
		var target = this;
		if(startDay !="" && endDay !="")
		{
			/*if(endDay<startDay){
				alert("종료일이 시작일보다 나중입니다. 값을 확인해 주십시오.");
				$(this).datepicker("show");
				$(this).val("");
			}*/
			{
				$.post("/ajax/approval/selectHolDateSum.do",$('#specificVO').serialize(),function(data){
					if(data<=0)
					{
						
						alert("유효하지 않은 기간입니다.");
						$('#specificVO input[name=edDt]').val("");
						$('#specificVO [name=sumDate]').val("");
						$('#specificVO input[name=stAmpm][value=1]').attr("checked","checked");
						$('#specificVO input[name=edAmpm][value=2]').attr("checked","checked");
						$(target).focus();
					}
					else
						$('#specificVO [name=sumDate]').val(data);
					
				});
				
				/*if($(this).hasClass("calGen"))
				{
					$(this).datepicker("hide");
				}*/
			}
		} 
	 }
	$('#vacationDayInform .calGen').change(calSumDate);
	$('#vacationDayInform input[type=radio]').click(calSumDate);
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
						<li class="stitle">일괄 휴가 처리 (현재 개발자만 이용가능)</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
				<form:form commandName="specificVO" id="specificVO" name="specificVO" method="post" enctype="multipart/form-data" >
					<p class="th_stitle mB10">휴가신청 정보</p>
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
								<td class="title">제목(간략히)</td>
								<td class="pL10">
									<input type="text" name="subject" id="subject" class="input_left write_input06" />
								</td>
							</tr>
							<tr>
								<td class="title">휴가자</td>
								<td class="pL10" id="searchVO">
									<input type="text" name="recieverList" id="recieverList" class="input_left write_input09 userNamesAuto userValidateCheck"/> 
									<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('recieverList',0);">
									<img src="${imagePath}/btn/btn_regist.gif" alt="등록" style="cursor:pointer;" onclick="insert(); return false;"/>
	<!--	                    		<li><img src="${imagePath}/btn/btn_search02.gif" alt="검색" style="cursor:pointer;" onclick="search('1'); return false;"/></li>-->
								</td>
							</tr>
							
						</tbody>
						</table>
					</div>
				</form:form>
				
				
				<form:form commandName="searchVO" id="searchVO" name="searchVO" method="post" enctype="multipart/form-data" >
					<!-- 상단 검색창 시작 -->
					<fieldset>
					<legend>상단 검색</legend>
												
						<div class="bot_search mB10">
							<ul>
								<li class="option_txt">
									<label>휴가자</label>
								</li>
							</ul>
						</div>
					</fieldset>
					<!-- 상단 검색창 끝 -->
				</form:form>
					
				<!-- 게시판 시작  -->	
				
				<p class="th_stitle">휴가 사원수 </p>
					<div class="th_txt"><a href="#v">${result.state.v} 명</a></div>
					
					<p class="th_stitle2 mT10" id="v">오늘 휴가 사원 명단</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup><col class="col70" /><col class="col120" /><col class="col100" /><col class="col90" /><col class="col90" /><col width="px" /></colgroup>
						<thead>
							<tr>
								<th>이름</th>
								<th>소속부서</th>
								<th>기간</th>
								<th>유선전화</th>
								<th>휴대전화</th>
								<th class="td_last">사유</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${result.vacList}" var="vac">
								<tr class="height_td">
									<td class="txt_center"><print:user userNo="${vac.userNo}" userNm="${vac.userNm}"/></td>
									<td class="txt_center">${vac.orgnztNm}</td>
									<td class="txt_center">&nbsp;${vac.wsBgnDe}<br/>~${vac.wsEndDe}</td>
									<td class="txt_center">${vac.userTelno}</td>
									<td class="txt_center">${vac.userMoblphonNo}</td>
									<td class="td_last txt_center">
										<print:textarea text="${vac.wsPurpose}"/>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${empty result.vacList}">
								<tr>
									<td class="td_last txt_center" colspan="6">휴가현황이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
						</table>
					</div>
					<!--// 게시판  끝  -->
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
