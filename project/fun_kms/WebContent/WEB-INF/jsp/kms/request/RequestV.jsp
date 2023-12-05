<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<script>
function modifyRequest() {
	var POP_NAME = "_REQUEST_MODIFY_REQUEST_POP_";
	var target = document.fm.target;
	document.fm.method = "POST";
	document.fm.target = POP_NAME;
	document.fm.action = "/request/modifyRequestPop.do";

	//var popup = window.showModalDialog('/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var option = "width=700px, height=700px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	var popup = window.open("about:blank", POP_NAME, option);
	document.fm.submit();
	popup.focus();
	document.fm.target = target;
}

function insertReview(reqNo) {
	var s_width = screen.width;
	var s_height = screen.height;
	var left = -1000;
	var top = 100;
	
	var url = "/request/ReviewW.do?reqNo=" + reqNo;
	var title = "_REQUEST_REVIEW_WRITE_";
	var option = "width=700px, height=400px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	
	var popup = window.open(url, title, option);
	//	popup.moveTo( ( ( (s_width -500)/2* (-1)) ), ((s_height-570)/2));
	//	popup.moveTo(200, 200);
	popup.focus();
}

function modifyReview(no) {
	var s_width = screen.width;
	var s_height = screen.height;
	var left = -1000;
	var top = 100;
	
	var url = "/request/ReviewM.do?no=" + no;
	var title = "_REQUEST_REVIEW_MODIFY_";
	var option = "width=700px, height=500px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	
	var popup = window.open(url, title, option);
	//	popup.moveTo( ( ( (s_width -500)/2* (-1)) ), ((s_height-570)/2));
	//	popup.moveTo(200, 200);
	popup.focus();
}

function writeReqTask() {
	var POP_NAME = "_REQUEST_WRITE_TASK_POP_";
	var target = document.fm.target;
	document.taskfm.method = "POST";
	document.taskfm.target = POP_NAME;
	document.taskfm.action = "/request/ReqTaskW.do";

	//var popup = window.showModalDialog('/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var option = "width=700px, height=500px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	var popup = window.open("about:blank", POP_NAME, option);
	document.taskfm.submit();
	popup.focus();
	document.taskfm.target = target;
}

function viewReqTask(no) {
	var s_width = screen.width;
	var s_height = screen.height;
	var left = -1000;
	var top = 100;
	
	var url = "/request/ReqTaskV.do?no=" + no;
	var title = "_REQUEST_REQTASK_VIEW_";
	var option = "width=700px, height=500px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	
	var popup = window.open(url, title, option);
	//	popup.moveTo( ( ( (s_width -500)/2* (-1)) ), ((s_height-570)/2));
	//	popup.moveTo(200, 200);
	popup.focus();
}

function modifyReqTask(no) {
	var POP_NAME = "_REQUEST_MODIFY_TASK_POP_";
	var target = document.fm.target;
	document.taskfm.method = "POST";
	document.taskfm.target = POP_NAME;
	document.taskfm.action = "/request/ReqTaskM.do";

	//var popup = window.showModalDialog('/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var option = "width=700px, height=500px, left=" + left + ", top=" + top + ", screenX=" + left + ", screenY=" + top 
			+ ", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, directories=no, status=no";
	var popup = window.open("about:blank", POP_NAME, option);
	document.taskfm.no.value = no;
	document.taskfm.submit();
	popup.focus();
	document.taskfm.target = target;
}

function cancel() {
	document.fm.action = '${formVO.param_returnUrl}';
	document.fm.submit();
}

function viewProject(prjId){
	var popup = window.open("/project/viewProjectPop.do?prjId="+prjId,
			"_POP_PROJECT_VIEW",
			"width=970px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
}

function updateCompleteDemand(no , completeStatus , reqId) {
	var stateName ="";
	if(completeStatus == 1){
		stateName = "완료"
	}else{
		stateName = "미완료"
	}
	if(confirm(stateName +" 하시겠습니까?")){
		$.ajax({
			url: "/request/completeStatusAjax.do",
			data: {
				no: no,
				completeStatus: completeStatus,
				reqId: reqId
			},
			type: "POST",
			async: false,
			dataType: "json",
			success: function(data) {
				// 수행 프로젝트가 아닐 경우, 오류메시지
				if (!data.RETURN.equals('OK')) {
					alert('작업이 처리되지 못하였습니다');
					return false;
				}
				$("#complete_datetime_"+no).text(data.UPDATETIME);
			},
			error: function(xhr, testStatus, errorThrown) {
				alert("작업 처리에 실패하였습니다.");
	  	 	}
		});
	} else{
		return false;
	} 
}

function contentsShow(){
	
	var isShow = $(".th_show_content").css('display') == 'none';
	
	if(isShow){
		$(".th_show_content").show();
		$("#th_show").attr("src", "../../images/btn/btn_arrow_top.gif");

	}
	else{
		$(".th_show_content").hide();
		$("#th_show").attr("src", "../../images/btn/btn_arrow_down.gif");
	}
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
							<li class="stitle">요구사항 조회</li>
							<li class="navi">요구사항 관리 > 요구사항 조회</li>
						</ul>
					</div>
					<!-- S: section -->
					<div class="section01">
						<input type="button" value="수정" class="mL10 fr btn_gray" onclick="javascript:modifyRequest();"/>
						
						<p class="th_stitle">요구사항 내용 </p>
						<div class="boardWrite02 mB20">
						 <form name="fm" id="fm" methos="POST" enctype="multipart/form-data">
							<input type="hidden" name="no" id="no" value="${rVO.no}"/>
							<table cellpadding="0" cellspacing="0">
							<colgroup>
								<col class="col100" />
								<col class="col100" />
								<col class="col100" />
								<col class="col150" />
								
								<col class="col100" />
								<col class="col100" />
								<col class="col100" />
								<col class="col150" />
							</colgroup>
							<tbody>
								<tr>
									<td class="title">요구사항명</td>
									<td class="pL5 write_info2" colspan="7">${rVO.title}
									<img id="th_show" src="../../images/btn/btn_arrow_down.gif" style="float:right;cursor: pointer;width:16px;height:16px;padding-top:1px;" onclick="javascript:contentsShow();"/>
									</td>
									
								</tr>
							</tbody>
							</table>
							<table cellpadding="0" cellspacing="0" style="border-top:0px">
							<colgroup>
								<col class="col100" />
								<col class="col100" />
								<col class="col100" />
								<col class="col150" />
								
								<col class="col100" />
								<col class="col100" />
								<col class="col100" />
								<col class="col150" />
							</colgroup>
							<tbody>
								<tr class="th_show_content" style="display:none;">
									<td class="title">프로젝트</td>
									<td class="pL5 write_info2" colspan="7"><a href="javascript:viewProject('${rVO.prjId }');">${rVO.prjNm}</a></td>
								</tr>
								<tr class="th_show_content" style="display:none;">
									<td class="title">작성자</td>
									<td class="write_info2 txt_center">
										<print:user userNo="${rVO.writerNo}" userNm="${rVO.writerName}"/>
									</td>
									<td class="title">처리예정일</td>
									<td class="write_info2 txt_center">${rVO.regDatetime}</td>
									<td class="title">요구유형</td>
									<td class="write_info2 txt_center">${rVO.reqTypeStr}</td>
									<td class="title">완료요청일</td>
									<td class="write_info2 txt_center">${rVO.dueDate}</td>
								</tr>
								<tr class="th_show_content" style="display:none;">
									<td class="title">주 담당자</td>
									<td class="pL5" colspan="7">
										${rVO.managerMixesMain}
									</td>
								</tr>								
								<tr class="th_show_content" style="display:none;">
									<td class="title">담당자</td>
									<td class="pL5" colspan="7">
									<%-- ${rVO.managerName} --%>
									<c:forEach items="${reqUserList}" var="req" varStatus="c">
										<c:if test="${c.count != 1}"></br></c:if>
										<print:user userNo="${req.userNo}" userNm="${req.userNm}"/>
										&nbsp;&nbsp;
										(미완료 <input type="radio" name="completeDemand_${req.no}" value="0" onclick="return updateCompleteDemand('${req.no}','0','${req.reqId}')" <c:if test="${req.completeStatus eq 0}">checked</c:if>> 
										완료 <input type="radio" name="completeDemand_${req.no}" value="1" onclick="return updateCompleteDemand('${req.no}','1','${req.reqId}')" <c:if test="${req.completeStatus eq 1}">checked</c:if>> 
										<span id="complete_datetime_${req.no}">${req.completeDateTime }</span>)
									</c:forEach>									
									</td>
								</tr>
								<tr class="th_show_content" style="display:none;">									
									<td class="title">완료일</td>
									<td class="write_info2 txt_center">${rVO.finishDatetime}</td>
									<td class="title">우선순위</td>
									<td class="write_info2 txt_center">${rVO.priorityStr}</td>
									<td class="title">진행상태</td>
									<td class="write_info2 txt_center" colspan="4" id="resulttext">${rVO.statusStr}</td>
								</tr>
								<tr class="th_show_content" style="display:none;">
									<td class="title">첨부 파일</td>
									<td class="pA5 write_info2 last" colspan="7">
										<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${rVO.atchFileId}" />
										</c:import>
									</td>
								</tr>
								<tr>
									<td class="write_info2 pL5 pT5 pB5" colspan="8">
									<p class="textarea1"><c:out value="${rVO.contents}" escapeXml="false" /></p>
									</td>
								</tr>
							</tbody>
							</table>							
						</form>
						</div> <!--// 요구사항 내용 끝  -->

						<!-- 검토목록 시작 -->
						<!-- LYS_20180716_ 검토목록을 작업 목록으로 수정 -->
						<%-- <input type="button" value="추가" class="mL10 fr btn_gray" onclick="javascript:insertReview(${rVO.no});"/> --%>
						<p class="th_stitle">작업내역</p>
						<div class="boardWrite02 mB20">
						 <form name="reviewfm" id="reviewfm" methos="POST" >
							<table cellpadding="0" cellspacing="0" >
							<colgroup>
								<col class="col60" />
								<col width="px" />
								<col class="col100" />
								<col class="col60" />
							</colgroup>
							<tbody>
								<tr>
									<td class="title">번호</td>
									<td class="title">내용</td>
									<td class="title">작성일</td>
									<td class="title">작성자</td>
								</tr>
							<c:forEach items="${rvVOList}" var="vo" varStatus="c">
								<tr>
									<td class="txt_center" > ${c.count}</td>
									<td class="write_info2 pA5">
										<p class="textarea1">${vo.contents}</p>
										<%-- <a href="javascript:modifyReview('${vo.no}')"><p class="textarea1">${vo.contents}</p></a> --%>
									</td>

									<td class="txt_center"> ${vo.regDatetime}</td>
									<td class="txt_center">
									<print:user userNo="${vo.writerNo }" userNm="${vo.writerName }"/>
									</td>
								</tr>
							</c:forEach>
							</tbody>
							</table>
						</form>
						</div>
						<!-- 검토목록 끝 -->
						<!-- LYS_20180716_작업 목록 안씀 (검토목록을 작업 목록으로 대체)  -->
						<input type="button" value="등록" class="fr btn_gray" onclick="javascript:writeReqTask();" style="display:none;"/>
						<p class="th_stitle" style="display:none;">작업목록</p>
						<div class="boardWrite02 mB20" style="display:none;">
						 <form name="taskfm" id="taskfm" methos="POST" >
							<input type="hidden" name="no" id="no" value="0"/>
							<input type="hidden" name="reqNo" id="reqNo" value="${rVO.no}"/>
							<input type="hidden" name="reqId" id="reqId" value="${rVO.reqId}"/>
							<input type="hidden" name="reqTitle" id="reqTitle" value="${rVO.title}"/>
							<table cellpadding="0" cellspacing="0" >
							<colgroup>
								<col class="col80" />
								<col width="px" />
								<col class="col60" />

								<col class="col60" />
								<col class="col60" />
			
								<col class="col60" />
								<col class="col50" />
							</colgroup>
							<tbody>
								<tr>
									<td class="title">작업번호</td>
									<td class="title">작업명</td>
									<td class="title">우선순위</td>

									<td class="title">작성자</td>
									<td class="title">생성일</td>

									<td class="title">담당자</td>
									<td class="title">상태</td>
								</tr>
							<c:forEach items="${rtVOList}" var="vo" varStatus="c">
								<tr>
									<td class="txt_center" ><a href="javascript:modifyReqTask('${vo.no}')">${vo.taskId}</a></td>
									<td class="pL10 txt_left"><a href="javascript:viewReqTask('${vo.no}')">${vo.title}</a></td>
									<td class="txt_center">${vo.priorityStr}</td>

									<td class="txt_center">${vo.writerName}</td>
									<td class="txt_center"> ${vo.regDatetime}</td>

									<td class="txt_center"> ${vo.workerName}</td>
									<td class="txt_center"> ${vo.statusStr}</td>
								</tr>
							</c:forEach>
							</tbody>
							</table>
						</form>
						</div>
						<!-- 작업록록 끝 -->
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
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>