<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<script>
$(function(){
	//업무절차 보이기 or 숨기기
	$('#btn_show').click(function(){
		$('#hiddenYn').attr('value', 'N');
		$('#frm').attr('action', '${rootPath}/support/bpManualShowOrHidden.do?hiddeYn=N');
		$('#frm').submit();
	});
	$('#btn_hidden').click(function(){
		$('#hiddenYn').attr('value', 'Y');
		$('#frm').attr('action', '${rootPath}/support/bpManualShowOrHidden.do?hiddeYn=Y');
		$('#frm').submit();
	});
	
	//업무절차 수정
	$('#btn_modify').click(function(){
		$('#frm').attr('action', '${rootPath}/support/bpManualModify.do');
		$('#frm').submit();
	});
	//업무절차 삭제
	$('#btn_delete').click(function(){
		if(confirm("삭제하시겠습니까?")){
			$('#frm').attr('action', '${rootPath}/support/bpManualDelete.do');
			$('#frm').submit();
		}
	});
	//목록으로 가기
	$('#btn_list').click(function(){
		$('#frm').attr('action', '${rootPath}/support/bpManualList.do');
		$('#frm').submit();
	});

	//댓글 제어 시작
	//댓글 입력
	$('#btn_commentRegist').click(function(){
		if($('#comment').val() == ""){
			alert("내용은 필수 값 입니다.");
			$('#comment').focus();
			return false;
		}
		$('#commentFrm').attr('action', '${rootPath}/support/bpManualCWP.do');
		$('#commentFrm').submit();
	});
	//댓글 삭제
	$('img[id^="btn_commentDelete_"]').click(function(){
		var commentNo = $(this).attr('id').replace('btn_commentDelete_', '');
		$('#commentNo').attr('value', commentNo);
		
		if(confirm("삭제하시겠습니까?")){
			$('#commentFrm').attr('action', '${rootPath}/support/bpManualCDP.do');
			$('#commentFrm').submit();
		}
	});
	//댓글 수정내용 가져오기
	$('img[id^="btn_doModify_"]').click(function(){
		var commentNo = $(this).attr('id').replace('btn_doModify_', '');
		$('#commentNo').attr('value', commentNo);
		$.ajax({
			url : '${rootPath}/support/bpManualCM.do',
			data : {
						"commentNo" : commentNo
				   },
			dataType : 'json',
			type : 'post',
			success : function(data){
						$('#comment').attr('value', data.result.comment);
						$('#btn_commentRegist').hide();
						$('#btn_commentModify').show();
						$('#comment').focus();
			}
		});
	});
	//댓글 수정
	$('#btn_commentModify').click(function(){
		$('#commentFrm').attr('action', '${rootPath}/support/bpManualCMP.do');
		$('#commentFrm').submit();
	});
	//댓글 제어 끝

	//건의제어 시작
	//건의 팝업
	$('#btn_askSuggest').click(function(){
		var popup = window.open("${rootPath}/support/bpManualSW.do?bpmNo="+$('#bpmNo').val()+"&suggestStatus=Y", "_SUGGEST_ASK_","width=560px,height=590px,scrollbars=no");
		popup.focus();
	});
	//답변팝업
	$('#btn_ansSuggest').click(function(){
		var popup = window.open("${rootPath}/support/bpManualSW.do?bpmNo="+$('#bpmNo').val()+"&suggestStatus=N", "_SUGGEST_ASK_","width=560px,height=590px,scrollbars=no");
		popup.focus();
	});
	//건의 처리 완료
	$('#btn_complete').click(function(){
		if(confirm("현재 문서의 상태를 완료로 변경하시겠습니까?")){
			$('#suggestFrm').attr('action', '${rootPath}/support/bpManualComplete.do');
			$('#suggestFrm').submit();
		}
	});
	//건의 삭제
	$('img[id^="btn_suggestDelete_"]').click(function(){
		var suggestNo = $(this).attr('id').replace('btn_suggestDelete_', '');
		if(confirm("삭제하시겠습니까?")){
			$('#suggestFrm').attr('action', '${rootPath}/support/bpManualSuggestDelete.do?suggestNo='+suggestNo);
			$('#suggestFrm').submit();
		}
	});
	//건의제어 끝
});
function lfn_suggestModify(suggestNo, suggestStatus){
	var popup = window.open("${rootPath}/support/bpManualSM.do?suggestNo="+suggestNo+"&suggestStatus="+suggestStatus, "_SUGGEST_ASK_","width=560px,height=590px,scrollbars=no");
	popup.focus();	
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
							<li class="stitle">게시물 읽기</li>
							<li class="navi">홈 > 업무지원 > 업무처리지원 > 업무처리절차</li>
						</ul>
					</div>
					
	
					<!-- S: section -->
					<div class="section01">
						<p class="th_stitle">업무처리절차</p>
						
						<!-- 게시판 시작  -->
						<form id="frm" name="frm" method="POST">
						<input type="hidden" name="bpmNo" value="${bpmVO.bpmNo}"/>
						<input type="hidden" id="hiddenYn" name="hiddenYn"/>						
						
						<input type="hidden" name="searchCondition" value="${bpmVO.searchCondition}"/>
						<input type="hidden" name="searchKeyword" value="${bpmVO.searchKeyword}"/>
						<input type="hidden" name="searchCheck" value="${bpmVO.searchCheck}"/>
						<input type="hidden" name="searchGubunNo" value="${bpmVO.searchGubunNo}"/>
						<input type="hidden" name="pageIndex" value="${bpmVO.pageIndex}"/>
						
						<div class="boardView">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup>
		                    	<col class="col100" />
		                    	<col width="px" />
		                    	<col class="col100" />
		                    	<col width="px" />
	                    	</colgroup>
		                    <thead>
		                    	<tr>
		                    		<th class="write_info">제목</th>
			                        <th class="write_info2" colspan="3">${detail.subject}</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">작성자</th>
			                    	<th class="write_info2" colspan="3">
			                    		<span class="cursorPointer" onclick="openUsrLayer('${detail.chgNo}',this);">${detail.chgNm}</span>
			                    	</th>
		                        </tr>
		                        <tr>
		                        	<th class="write_info">작성일시</th>
			                    	<th class="write_info2">${fn:substring(fn:replace(detail.instDate, '-', '.'), 0, 16)}</th>
			                    	<th class="write_info">변경일시</th>
			                    	<th class="write_info2">${fn:substring(fn:replace(detail.chgDate, '-', '.'), 0, 16)}</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">업무 구분</th>
			                    	<th class="write_info2">
			                    		${detail.gubunNm}
			                    	</th>
			                    	<th class="write_info">상태</th>
			                    	<th class="write_info2">
			                    		<c:if test="${detail.useStatus == 'Y'}">유효문서</c:if>
			                    		<c:if test="${detail.useStatus == 'N'}">무효문서</c:if>
			                    	</th>
		                        </tr>
		                    </thead>
		                    <tbody>
		                    	<tr>
		                    		<td colspan="4" class="H300"><c:out value="${detail.content}" escapeXml="false" /></td>
		                    	</tr>
		                    </tbody>
							<tfoot>
								<tr>
									<td class="write_info">업무절차</td>
									<td class="write_info2" colspan="3">
										<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${detail.atchFileId2}" />
										</c:import>
									</td>
								</tr>
								 
								<tr>
									<td class="write_info">양식</td>
									<td class="write_info2" colspan="3">
										<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${detail.atchFileId}" />
										</c:import>
									</td>
								</tr>
							</tfoot>
		                    </table>
						</div>
						</form>
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<ul>
		                		<li class="right">
		                			<!-- 작성자 또는 관리자 또는 권한이있는 관리자라면 수정, 삭제가 보임 -->
		                			<c:if test="${detail.instNo == user.no || user.isBpmboard == 'Y'}">
		                			<c:if test="${detail.hiddenYn == 'Y'}">
			                			<img src="${imagePath}/btn/btn_open.gif" class="cursorPointer" id="btn_show"/>
		                				<img src="${imagePath}/btn/btn_hidden2.gif" class="cursorPointer" id="btn_hidden" style="display:none"/>
		                			</c:if>
		                			<c:if test="${detail.hiddenYn == 'N'}">
		                				<img src="${imagePath}/btn/btn_open.gif" class="cursorPointer" id="btn_show" style="display:none"/>
		                				<img src="${imagePath}/btn/btn_hidden2.gif" class="cursorPointer" id="btn_hidden"/>
		                			</c:if>
		                			
		                			<img src="${imagePath}/btn/btn_modify.gif" class="cursorPointer" id="btn_modify"/>
					                <img src="${imagePath}/btn/btn_delete.gif" class="cursorPointer" id="btn_delete"/>
					                </c:if>
				                	<img src="${imagePath}/btn/btn_list.gif" class="cursorPointer" id="btn_list"/>
		                		</li>
		                	</ul>
		                </div>
		                <!--// 버튼 끝 -->
						
						<!--// 코멘트 시작  -->
						<div id="commentArea">
							<div class="th_stitle mB10">
	                			건의 및 의견 제시
	                		</div>
							<div class="replyW mT20">
								<form id="commentFrm" name="commentFrm" method="POST">
								<input type="hidden" name="receiverUsers" value="${detail.instUser},${detail.authUsers}"/>
								<input type="hidden" id="bpmNo" name="bpmNo" value="${bpmVO.bpmNo}"/>
								<input type="hidden" id="commentNo" name="commentNo"/>
								<input type="hidden" name="subject" value="${detail.subject}"/>
								<input type="hidden" name="thisUrl" value="${bpmVO.thisUrl}?<%=request.getQueryString()%>"/>
								
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
									<caption>댓글달기</caption>
									<colgroup>
										<col class="col100" />
										<col width="px" />
										<col class="col80" />
									</colgroup>
									<tr>
										<td class="writer"><print:user userNo="${user.userNo}" userNm="${user.userNm}" userId="${user.userId}" printId="false"/></td>
										<td class="pL10 pT5 pB5"><textarea id="comment" name="comment" class="textarea height_90" rows="6" cols="85"></textarea></td>
										<td class="last pL10">
											<img src="${imagePath}/btn/btn_regist02.gif" class="cursorPointer" id="btn_commentRegist"/>
											<img src="${imagePath}/btn/btn_modify02.gif" class="cursorPointer" id="btn_commentModify" style="display:none;"/>
										</td>
									</tr>
								</table>
								</form>
							</div>
							<br>
							<c:if test="${!empty commentList}">
							<div class="replyL mT20">
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
									<caption>댓글보기</caption>
									<colgroup>
									<col class="col100" />
									<col width="px" />
									<col class="col150" />
									</colgroup>
									<c:forEach items="${commentList}" var="result">
										<tr>
											<td class="writer"><print:user userNo="${result.userNo}" userNm="${result.userNm}" userId="${result.userId}" printId="false"/></td>
											<td class="txt" id="comment_${result.commentNo}">
												<c:out value="${result.comment}" escapeXml="false"/>
											</td>
											<td class="date">
												${fn:substring(fn:replace(result.chgDate, '-', '.'), 0, 16)}
												<c:if test="${result.userNo == user.no || user.isBpmboard == 'Y'}">
												<span class="btn_plus">
													<img src="${imagePath}/btn/btn_plus02.gif" class="cursorPointer" id="btn_doModify_${result.commentNo}"/>
													<img src="${imagePath}/btn/btn_minus02.gif" class="cursorPointer" id="btn_commentDelete_${result.commentNo}"/>
												</span>
												</c:if>
											</td>
										</tr>
									</c:forEach>
								</table>
							</div>
							</c:if>
						</div>
						<!--// 코멘트 끝 -->						
		                <br>
		                <!--// 건의사항 시작 -->
		                <!-- 
		                <form id="suggestFrm" name="suggestFrm" method="post">
		                	<input type="hidden" name="bpmNo" value="${bpmVO.bpmNo}"/>
		                </form>
		                <div class="th_stitle mB10">
	                		건의 및 처리 내역
	                	</div>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>공지사항</caption>
							<colgroup>
								<col class="col40" />
								<col class="col60" />
								<col class="col80" />
								<col width="px" />
								<col class="col100" />
								<col class="col50" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">분류</th>
									<th scope="col">작성자</th>
									<th scope="col">내용</th>
									<th scope="col">등록일시</th>
									<th scope="col"></th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
								<c:when test="${!empty suggestList}">
								<c:forEach items="${suggestList}" var="result" varStatus="index">
								<tr>
									<td class="txt_center">${index.count}</td>
									<td class="txt_center">
										<c:if test="${result.suggestStatus == 'Y'}"><span class="txtB_red">요청</span></c:if>
										<c:if test="${result.suggestStatus == 'N'}"><span class="txtB_green">답변</span></c:if>
									</td>
									<td class="txt_center">
										<print:user userNo="${result.userNo}" userNm="${result.userNm}"/>
									</td>
									<td class="pL10"><c:out value="${result.content}" escapeXml="false"/></td>
									<td class="txt_center">${fn:substring(fn:replace(result.instDate, '-', '.'), 0, 16)}</td>
									<td class="txt_center">
										<c:if test="${result.userNo == user.no}">
										<img src="${imagePath}/btn/btn_plus02.gif" class="cursorPointer" onclick="lfn_suggestModify('${result.suggestNo}', '${result.suggestStatus}')"/>
										<img src="${imagePath}/btn/btn_minus02.gif" class="cursorPointer" id="btn_suggestDelete_${result.suggestNo}"/>
										</c:if>
									</td>
								</tr>
								</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td class="txt_center" colspan="6">게시글이 없습니다.</td>
								</tr>
								</c:otherwise>
								</c:choose>
							</tbody>
							</table>
						</div>
						 -->
	                	<!--// 건의사항 끝 -->
	                	<!-- 건의 버튼 시작 -->
	                	<!-- 
		                <div class="btn_area02">
		                	<ul>
		                		<li class="right">
		                			<input type="button" id="btn_askSuggest" value="요청하기"/>
		                			<c:if test="${detail.userNo == user.no || user.isAdmin == 'Y' || user.isBpmboard == 'Y'}">
		                			<input type="button" id="btn_ansSuggest" value="답변하기"/>
		                			<input type="button" id="btn_complete" value="처리완료"/>
		                			</c:if>
		                		</li>
		                	</ul>
		                </div>
		                 -->
		                <!--// 건의 버튼 끝 -->
	                	
	                	
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