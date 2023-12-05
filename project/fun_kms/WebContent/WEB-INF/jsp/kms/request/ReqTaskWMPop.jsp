<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>

<script>
var chk = false;
var chkErrorChk = "";

function saveReqTask() {
	document.fm.action = '<c:url value="/request/saveReqTask.do" />';
	document.fm.submit();
}

</script>
</head>

<body>
<div id="pop_board1">
	<div id="pop_top">
	<ul>
		<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
		<c:choose>
			<c:when test="${(rtVO.no == null) || (rtVO.no == 0) }" ><li class="popTitle">작업 등록</li></c:when>
			<c:otherwise><li class="popTitle">작업 수정</li></c:otherwise>
		</c:choose>
	</ul>
	</div>
	<div class="pop_con16">
		<div class="pop_board1">
			<input type="button" value="취소" class="mL10 fr btn_gray" onclick="javascript:window.close();"/>
			<input type="button" value="저장" class="mL10 fr btn_gray" onclick="javascript:saveReqTask();"/>
			<p class="th_stitle">작업내용</p>
			<form:form name="fm" id="fm" commandName="fm" method="POST" >
				<input type="hidden" name="searchReload" value="${fm.searchReload}"/>
		<c:choose>
			<c:when test="${(rtVO.no == null) || (rtVO.no == 0) }" ><input type="hidden" name="no" value="0"/></c:when>
			<c:otherwise><input type="hidden" name="no" value="${rtVO.no}"/></c:otherwise>
		</c:choose>
				<input type="hidden" name="reqNo" value="${rtVO.reqNo}"/>
				<input type="hidden" name="reqId" value="${rtVO.reqId}"/>
			<table cellpadding="0" cellspacing="0">
				<colgroup>
					<col class="col80" />
					<col class="col150" />
					<col class="col80" />
					<col class="col80" />
					<col class="col80" />
					<col class="col80" />
				</colgroup>
				<tbody id="tbody">
					<tr>
						<td class="title">작업명</td>
						<td class="pL5" colspan=5"><input type="text" name="title" class="write_input pL5" value="${rtVO.title}"/></td>
					</tr>
					<tr>
						<td class="title">요구명</td>
						<td class="pL10" colspan=5">[${rtVO.reqId}] ${rtVO.reqTitle}</td>
					</tr>
					<tr>
						<td class="title">작업종류</td>
						<td class="txt_center">
							<select  class="select01 txt_center w80" name="taskType" id="taskType">
								<c:choose>
									<c:when test="${rtVO.taskType == 0}"><option value="0" selected > 선택 </option></c:when>
									<c:otherwise><option value="0"> 선택 </option></c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${rtVO.taskType == 1}"><option value="1" selected > 분석 </option></c:when>
									<c:otherwise><option value="1"> 분석 </option></c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${rtVO.taskType == 2}"><option value="2" selected > 설계 </option></c:when>
									<c:otherwise><option value="2"> 설계 </option></c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${rtVO.taskType == 4}"><option value="4" selected > 구현 </option></c:when>
									<c:otherwise><option value="4"> 구현 </option></c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${rtVO.taskType == 8}"><option value="8" selected > 시험 </option></c:when>
									<c:otherwise><option value="8"> 시험 </option></c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${rtVO.taskType == 16}"><option value="16" selected > 오류처리 </option></c:when>
									<c:otherwise><option value="16"> 오류처리 </option></c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${rtVO.taskType == 32}"><option value="32" selected > 연구 </option></c:when>
									<c:otherwise><option value="32"> 연구 </option></c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${rtVO.taskType == 64}"><option value="64" selected > 기타 </option></c:when>
									<c:otherwise><option value="64"> 기타 </option></c:otherwise>
								</c:choose>
							</select>
						</td>
						<td class="title">우선순위</td>
						<td class="txt_center">
							<select  class="select01 txt_center w80" name="priority" id="priority">
								<c:choose>
									<c:when test="${rtVO.priority == 0}"><option value="0" selected > 선택 </option></c:when>
									<c:otherwise><option value="0"> 선택 </option></c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${rtVO.priority == 1}"><option value="1" selected > 긴급 </option></c:when>
									<c:otherwise><option value="1"> 긴급 </option></c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${rtVO.priority == 2}"><option value="2" selected > 중요 </option></c:when>
									<c:otherwise><option value="2"> 중요 </option></c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${rtVO.priority == 4}"><option value="4" selected > 보통 </option></c:when>
									<c:otherwise><option value="4"> 보통 </option></c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${rtVO.priority == 8}"><option value="8" selected > 여유 </option></c:when>
									<c:otherwise><option value="8"> 여유 </option></c:otherwise>
								</c:choose>
							</select>
						</td>
						<td class="title">상태</td>
						<td class="txt_center">
							<c:choose>
								<c:when test="${(rtVO.no == null) || (rtVO.no == 0) }">${rtVO.statusStr}
								</c:when>
								<c:otherwise>
									<select  class="select01" name="status" id="status">
									<c:choose>
										<c:when test="${rtVO.status == 0}"><option value="0" selected > 선택 </option></c:when>
										<c:otherwise><option value="0"> 선택 </option></c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${rtVO.status == 1}"><option value="1" selected > 생성 </option></c:when>
										<c:otherwise><option value="1"> 생성 </option></c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${rtVO.status == 2}"><option value="2" selected > 처리중 </option></c:when>
										<c:otherwise><option value="2"> 처리중 </option></c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${rtVO.status == 4}"><option value="4" selected > 처리완료 </option></c:when>
										<c:otherwise><option value="4"> 처리완료 </option></c:otherwise>
									</c:choose>
									</select>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td class="title">담당자</td>
						<td class="pL5">
							<input type="text" class="pL5 w120 userNameAuto userValidateCheck" name="workerMixes" id="workerMixes" value="${rtVO.workerName}(${rtVO.workerId})"/>
							<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('workerMixes',1)"/>
						</td>
						<td class="title">시작일시</td>
						<td class="pL5 txt_center">${rtVO.startDatetime}</td>
						<td class="title">완료일시</td>
						<td class="pL5 txt_center">${rtVO.finishDatetime}</td>
					</tr>
					<tr>
						<td class="title">작성자</td>
						<td class="pL5 txt_center">${rtVO.writerName}</td>
						<td class="title">작성일</td>
						<td class="pL5 txt_center">${rtVO.regDatetime}</td>
						<td class="title">예상완료일</td>
						<td class="pL5 txt_center"></td>
					</tr>
					<tr>
						<td class="pL5 pT5 pB5 " colspan="6">
							<textarea  class="w98p" name="contents" rows="20" style="resize:both">${rtVO.contents }</textarea>
						</td>
					</tr>
 				</tbody>
			</table>
			</form:form>
		</div>	
	</div>
</div>

</body>
</html>
