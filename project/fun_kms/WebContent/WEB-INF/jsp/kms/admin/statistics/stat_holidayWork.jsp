<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>

<script>
$(document).ready(function(){

});

function excelDown1() {
	// todo
	var form = $('#frm1');
	if(form.find('[name=startDt]').val() == null || form.find('[name=startDt]').val().length<8 ||
			form.find('[name=endDt]').val() == null || form.find('[name=endDt]').val().length<8){
		alert("시작일/종료일을 입력하여 주십시오.");
		return; 
	}
	document.frm1.action = "/admin/statistics/selectHolidayWorkExcel1.do";
	document.frm1.submit();
}

function excelDown2() {
	// todo
	var form = $('#frm2');
	if(form.find('[name=startDt]').val() == null || form.find('[name=startDt]').val().length<8 ||
			form.find('[name=endDt]').val() == null || form.find('[name=endDt]').val().length<8){
		alert("시작일/종료일을 입력하여 주십시오.");
		return; 
	}
	if(form.find('[name=compId]').val() == null || form.find('[name=compId]').val().length == 0) {
		alert("회사구분을 선택하여 주십시오.");
		return; 
	} 
	document.frm2.action = "/admin/statistics/selectHolidayWorkExcel2.do";
	document.frm2.submit();
}
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
							<li class="stitle">휴일근무내역</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">	
						<p class="th_stitle">휴일근무내역(전체) 엑셀 출력</p>
						<form name="frm1" id="frm1" method="POST">
							<div class="boardWrite02 mB20">
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
									<caption>댓글달기</caption>
									<colgroup>
										<col width="120" />
										<col width="px" />
										<col width="120" />
										<col width="px" />
									</colgroup>
									<tr>
										<td class="title">시작일</td>
										<td class="pL10"><input type="text" name="startDt" class="span_5 calGen" value="${firstDate}" /></td>
										<td class="title">종료일</td>
										<td class="pL10"><input type="text" name="endDt" class="span_5 calGen" value="${todayDate}" /></td>
									</tr>
									<tr>
										<td class="title">엑셀출력</td>
										<td class="txt_right" colspan="3"><a href="javascript:excelDown1();"><img src="${imagePath}/btn/btn_excelSave.gif"/></a></td>
									</tr>
								</table>
							</div>
						</form>
					</div>
					<!-- E: section -->	

					<!-- S: section -->
					<div class="section01">	
						<p class="th_stitle">회사별 결재완료된 휴일근무내역 엑셀 출력 (근무일 당시 소속회사/소속부서 기준)</p>
						<form name="frm2" id="frm2" method="POST">
							<div class="boardWrite02 mB20">
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
									<caption>댓글달기</caption>
									<colgroup>
										<col width="80" />
										<col width="px" />
										<col width="80" />
										<col width="px" />
										<col width="80" />
										<col width="px" />
									</colgroup>
									<tr>
										<td class="title">시작일</td>
										<td class="pL10"><input type="text" name="startDt" class="span_5 calGen" value="${firstDate}" /></td>
										<td class="title">종료일</td>
										<td class="pL10"><input type="text" name="endDt" class="span_5 calGen" value="${todayDate}" /></td>
										<td class="title">회사구분</td>
										<td class="pL10">
											<select name="compId">
												<option value="">선택</option>
												<c:forEach items="${compList}" var="comp">
													<option value="${comp.code}"><c:out value="${comp.codeNm}"/></option>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr>
										<td class="title">엑셀출력</td>
										<td class="txt_right" colspan="5"><a href="javascript:excelDown2();"><img src="${imagePath}/btn/btn_excelSave.gif"/></a></td>
									</tr>
								</table>
							</div>
						</form>
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
