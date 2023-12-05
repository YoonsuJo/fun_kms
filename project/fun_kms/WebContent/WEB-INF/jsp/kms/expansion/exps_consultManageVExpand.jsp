<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
 
<c:import url="${rootPath}/cooperation/selectConsultCommentList.do">
	<c:param name="type" value="head" />
</c:import>

</head>
<!-- exps_consultManageV.jsp와 동일한 뷰, 초기값만 자세히 -->
<script type="text/javascript">


//상담관리 삭제
function deleteArticle() {
	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.action = "<c:url value='${rootPath}/cooperation/deleteBoardArticle.do'/>";
		document.frm.submit();
	}	
}

//덧글 등록
function interest() {
	if ("${result.interestYn}" == "Y") {
		document.frm.interestYn.value = "N";
	}
	else {
		document.frm.interestYn.value = "Y";
	}
	document.frm.action = "${rootPath}/cooperation/updateBusinessContactInterest.do";
	document.frm.submit();
}
function copyList(typ, obj) {
	var chared = "<c:forEach items='${result.chargedList}' var='char' varStatus='c'><c:if test='${c.count != 1}'>,</c:if> ${char.userNm}(${char.userId})</c:forEach>";
	var add = "<c:forEach items='${result.addList}' var='add' varStatus='c'><c:if test='${c.count != 1}'>,</c:if> ${add.userNm}(${add.userId})</c:forEach>";
	var data = '';
	
	if(typ == 'char')
		data = chared;
	else if(typ == 'add')
		data = add;

	var sUserAgent = navigator.userAgent;
	var isOpera = sUserAgent.indexOf("Opera") > -1;
	var isIE = sUserAgent.indexOf("compatible") > -1 && sUserAgent.indexOf("MSIE") > -1 && !isOpera;
	if(isIE) {
        window.clipboardData.setData('Text',data);
        var tmp = '담당자';
        if(typ == 'add') tmp = '참조자';
        window.alert(tmp + "가 복사되었습니다.");
    } else {
    	if($('.copy_chargedList').length>0)
    	{
    		$('body').unbind('click.copyLayer');
    		$('.copy_chargedList').remove();
    	}
    	
    	var layer = $('<div class="copy_recieveList">' + data + '<br/><p align="right">※ 드래그하여 복사해주세요.</p></div>');
    	
    	layer.css("left",($(obj).offset().left+20)+"px");
    	layer.css("top",($(obj).offset().top+15)+"px");

    	layer.css("width", 300);
    	
    	layer.appendTo('body');

    	function copyLayerClickEvent(event){
			if (!$(event.target).closest(layer).length && event.target !== $(obj).get(0)) {
				$('body').unbind('click.copyLayer');
		        layer.remove();
		    };
		}
    	$('body').bind('click.copyLayer', copyLayerClickEvent );
    }
}

function updateState(consultNo) {
	var popup = window.open("/cooperation/updateConsultStateView.do?consult_no=" + consultNo,"_POP_STATE_","width=560px,height=570px,scrollbars=yes");
	popup.focus();
}
function updateJira(consultNo) {
	var popup = window.open("/cooperation/updateConsultJiraView.do?consult_no=" + consultNo,"_POP_STATE_","width=560px,height=570px,scrollbars=yes");
	popup.focus();
}
function delConsult(consultNo){
	
	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.consult_no.value = consultNo;
		document.frm.action = "<c:url value='${rootPath}/cooperation/deleteConsultManage.do'/>";
		document.frm.submit();	
	}
}
function toggleInfo(obj){
	if($(obj).hasClass('btn_arrow_down')){
		$(obj).removeClass('btn_arrow_down');
		$(obj).addClass('btn_arrow_up');
		$('.toggleInfo').show();
		$(obj).prev().html('간단히');
	}
	else{
		$(obj).removeClass('btn_arrow_up');
		$(obj).addClass('btn_arrow_down');
		$('.toggleInfo').hide();
		$(obj).prev().html('자세히');
	}
}
function recieveLayerShow() {
	var position = $("#btn_chng").position();
	var height = $("#btn_chng").height();
	
	$('#RecieverLayer').show();
	document.getElementById("RecieverLayer").style.top = position.top - 140 + "px";
	document.getElementById("RecieverLayer").style.left = position.left - 100 + "px";
	document.getElementById("RecieverLayer").style.zIndex = "1";
}
function recieveLayerHide() {
	$('#RecieverLayer').hide();
}
function changeRecieve() {
	document.frm.action = "${rootPath}/cooperation/changeConsultRecieve.do";
	document.frm.submit();
}
function updateIssue() {	
	document.frm.action = "${rootPath}/cooperation/updateIssue.do";	
	document.frm.submit();	
}

function init(){	
	$('.cursorPointer1').removeClass('btn_arrow_down');
	$('.cursorPointer1').addClass('btn_arrow_up');
	$('.toggleInfo').show();
	$('.cursorPointer1').prev().html('간단히');
}

window.onload = init;

</script>
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
							<li class="stitle">업무공유</li>
							<li class="navi">홈 > 업무공유 > 상담관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						<form name="frm" method="POST" >
						<p class="th_stitle">상담관리   <span class="txtB_green2">자세히</span> 
						<img class="btn_arrow_down cursorPointer1" onclick="javascript:toggleInfo(this);"/>
						<!-- Debug: ${result.consult_no}  -->
						</p>						
						<!-- 상담관리 게시판 시작  -->
						<div class="boardView">
							
							<input type="hidden" name="no"/>
							<input type="hidden" name="consult_no" value="${result.consult_no}"/>
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>상담관리 상세보기</caption>
		                   <%-- 
		                    <colgroup>
		                    	<col class="col5" />
		                    	<col class="col80" />
		                    	<col class="col120" />
		                    	<col class="col80"  />
		                    	<col width="px" />
		                    	<col class="col80 "  />
		                    	<col class="col120" />
		                    	<col class="col5" />
		                    </colgroup>
		                    --%>
		                    <colgroup>
			                    <col class="col100" />
			                    <col width="px" />
			                    <col class="col100" />
			                    <col width="px" />
			                    <col class="col100" />
			                    <col width="px" />
		                    </colgroup>
		                    <thead>
		                    	<tr>
			                    	<th class="write_info">고객사</th>
			                    	<th class="write_info2" colspan="2">${result.cust_nm}&nbsp;</th>
			                    	<th class="write_info">고객명</th>			                    	
			                    	<th class="write_info2" colspan="2">${result.cust_manager}&nbsp;</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">연락처</th>
			                    	<th class="write_info2" colspan="5">${result.cust_telno}</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">상담자</th>
			                    	<th class="write_info2"  colspan="2">${result.user_nm}&nbsp;</th>
			                    	<th class="write_info">상담일시</th>			                    	
			                    	<th class="write_info2" colspan="2">${result.reg_dt}&nbsp;</th>
		                        </tr>
		                        <tr class="toggleInfo" style="display:none;">
			                    	<th class="write_info">담당자</th>
			                    	<th class="write_info2" colspan="5">
				                    	<c:forEach items="${result.chargedList}" var="char" varStatus="c">
			                    			<c:if test="${c.count != 1}">,</c:if>
			                    			<print:user userNo="${char.userNo}" userNm="${char.userNm}"/>(
			                    				<c:choose>
					                    			<c:when test="${empty char.readtime}"><span class="txt_red">미열람</span></c:when>
				                    				<c:otherwise>${char.readtime } <span class="txt_blue">열람</span></c:otherwise>
			                    				</c:choose>
			                    			)
			                    		</c:forEach>
			                    		<c:if test="${!empty result.chargedList}">
			                    			<img class="cursorPointer" onclick="javascript:copyList('char',this);" src="${imagePath}/btn/btn_receiveCopy.gif" />
			                    		</c:if>
			                    	</th>
		                        </tr>
		                        <tr class="toggleInfo" style="display:none;">
			                    	<th class="write_info">참조자</th>			                    	
			                    	<th class="write_info2" colspan="5">
			                    		<c:forEach items="${result.addList}" var="add" varStatus="c">
			                    			<c:if test="${c.count != 1}">,</c:if>
			                    			<print:user userNo="${add.userNo}" userNm="${add.userNm}"/>(
			                    				<c:choose>
					                    			<c:when test="${empty add.readtime}"><span class="txt_red">미열람</span></c:when>
				                    				<c:otherwise>${add.readtime } <span class="txt_blue">열람</span></c:otherwise>
			                    				</c:choose>
			                    			)
			                    		</c:forEach>
			                    		<c:if test="${!empty result.addList}">
			                    			<img class="cursorPointer" onclick="javascript:copyList('add',this);" src="${imagePath}/btn/btn_referCopy.gif" />
			                    		</c:if>
			                    	</th>		                        
		                        </tr>
		                        <tr class="toggleInfo" style="display:none;">
		                        	<th class="write_info">구분</th>
		                        	<th class="write_info2">
		                        		<c:if test="${result.typ == '1'}">멀티</c:if>
										<c:if test="${result.typ == '2'}">메가</c:if>
										<c:if test="${result.typ == '3'}">스쿨</c:if>
										<c:if test="${result.typ == '4'}">KT</c:if>
										<c:if test="${result.typ == '5'}">메신</c:if>
										<c:if test="${result.typ == '6'}">코덱</c:if>
									</th>
		                        	<th class="write_info">상담분류</th>
		                        	<th class="write_info2">
		                        		<c:if test="${result.service_typ == '1'}">일반</c:if>
										<c:if test="${result.service_typ == '2'}">영업</c:if>
										<c:if test="${result.service_typ == '3'}">장애</c:if>
										<c:if test="${result.service_typ == '4'}">기타</c:if>
										<c:if test="${result.service_typ == '5'}">화상</c:if>
		                        	</th>
		                        	<th class="write_info">장애항목</th>
		                        	<th class="write_info2">
		                        		<c:if test="${result.error_typ == '1'}">로그인</c:if>
										<c:if test="${result.error_typ == '2'}">비디오</c:if>
										<c:if test="${result.error_typ == '3'}">음성</c:if>
										<c:if test="${result.error_typ == '4'}">전자칠판</c:if>
										<c:if test="${result.error_typ == '5'}">기타</c:if>
		                        	</th>
		                        </tr>
		                        <tr class="toggleInfo" style="display:none;">
		                        	<th class="write_info">처리상태</th>
		                        	<th class="write_info2">${result.state}</th>
		                        	<th class="write_info">처리일시</th>
		                        	<th class="write_info2">${result.complete_date} ${result.complete_tm}</th>
		                        	<th class="write_info">상담만족도</th>
		                        	<th class="write_info2">
		                        		<c:if test="${result.satisfaction == '1'}">만족</c:if>
		                        		<c:if test="${result.satisfaction == '2'}">보통</c:if>
		                        		<c:if test="${result.satisfaction == '3'}">불만족</c:if>
		                        		<c:if test="${result.satisfaction == '4'}">매우만족</c:if>
		                        		<c:if test="${result.satisfaction == '5'}">Black</c:if>
		                        	</th>
		                        </tr>
		                        <tr class="toggleInfo" style="display:none;">
		                        	<th class="write_info">지라등록여부</th>
		                        	<th class="write_info2">
		                        	<a href="javascript:updateJira('${result.consult_no}')">${result.jira_yn}</a> 
		                        	<c:if test="${result.jira_code==null}">
		                        	<a href="javascript:updateJira('${result.consult_no}')"></a>
		                        	</c:if>
		                        	<a href="http://jira.saeha.com/browse/${result.jira_code }" target="_blank">${result.jira_code }</a>
		                        	</th>
		                        	<th class="write_info">내부이슈</th>
		                        	<th class="write_info2">
		                        	<a href="javascript:updateIssue();">${result.issue_yn}</a> 
		                        	<c:if test="${result.issue_yn!='Y'}"> </c:if>
		                        	<c:if test="${result.issue_yn=='Y'}"> </c:if> </th>
		                        	<th class="write_info">문자알림</th>
		                        	<th class="write_info2">${result.sms_yn}</th>
		                        </tr>
		                        <tr class="toggleInfo" style="display:none;">
			                    	<th class="write_info">마감예정</th>
			                    	<th class="write_info2" colspan="5">${result.end_date}</th>
		                        </tr>		                        
		                        <tr>
			                    	<th class="write_info">문의내용</th>
			                    	<th class="write_info2" colspan="5"><print:textarea text="${result.q_cn}" /></th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">답변내용</th>
			                    	<th class="write_info2" colspan="5"><print:textarea text="${result.a_cn}" /></th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">특이사항</th>
			                    	<th class="write_info2" colspan="5"><print:textarea text="${result.s_cn}" /></th>
		                        </tr>		                        
		                        <tr>
			                    	<th class="write_info">첨부파일</th>
			                    	<th class="write_info2" colspan="5">
			                    		<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${result.atch_file_id}" />
										</c:import>
									</th>
		                        </tr>
		                    </thead>                  
							
		                   </table>
		                   
		                   
		                   <!-- 수신자 변경 레이어  -->
		                    <input name="userNo" type="hidden" value="${result.userNo}" />
			                <div id="RecieverLayer" class="Receiver_layer" style="display:none;">
			                	<dl>
			                		<dt>담당자, 참조자 변경</dt>
			                		<dd>
			                			<div class="boardWrite02 mB10">
										<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
					                    <caption>공지사항 보기</caption>
					                    <colgroup><col class="col120" /><col width="px" /></colgroup>
					                    <tbody>
					                    	<tr>
						                    	<td class="title">담당자</td>
						                    	<td class="pL10">
						                    		<input type="text" class="span_13 userNamesAuto userValidateCheck" name="chargedUserIdMix" id="recUserMixes"
					                    				value="<c:forEach items='${result.chargedList}' var='chr'>${chr.userNm}(${chr.userId}), </c:forEach>" />
						                    		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('recUserMixes',0)"/>
					                    		</td>
					                    	</tr>
					                    	<tr>
						                    	<td class="title">참조자</td>
						                    	<td class="pL10">
						                    		<input type="text" class="span_13 userNamesAuto userValidateCheck" name="addUserIdMix" id="refUserMixes"
						                    			value="<c:forEach items='${result.addList}' var='add'>${add.userNm}(${add.userId}), </c:forEach>" />
						                    		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('refUserMixes',0)" />
					                    		</td>
					                    	</tr>
					                    </tbody>
					                    </table>
										</div>
										<div class="btn_area">
				                			<a href="javascript:changeRecieve();"><img src="${imagePath}/btn/btn_apply.gif"/></a>
				                			<a href="javascript:recieveLayerHide();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
						                </div>
			                		</dd>
			                	</dl>
							</div>
			                <!--// 수신자 변경 레이어 끝  -->
		                   
						</div>				
							
						</form>
						<!-- 덧글입력부분 임포트S -->
						  
						<div id="commentArea">
							<c:import url="${rootPath}/cooperation/selectConsultCommentList.do">							
								<c:param name="type" value="body" />
								<c:param name="commentNo" value="${result.no}" />
							</c:import>
						</div>
				        <!-- 덧글입력부분 임포트E -->
						<!--//상담관리 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<a href="javascript:updateState('${result.consult_no}')"><img src="${imagePath}/btn/btn_statusModify.gif"/></a>
		                	<c:if test="${user.no == result.userNo || user.admin}">
		                	<a href="${rootPath}/cooperation/updateConsultManageView.do?consult_no=${result.consult_no}"><img src="${imagePath}/btn/btn_modify.gif"/></a>
				            <a href="javascript:delConsult('${result.consult_no}');"><img src="${imagePath}/btn/btn_delete.gif"/></a>
                			</c:if>
                			<a href="javascript:recieveLayerShow();"><img id="btn_chng" src="${imagePath}/btn/btn_change.gif"/></a>
		                	<a href="${rootPath}/cooperation/selectConsultManageList.do"><img src="${imagePath}/btn/btn_list.gif"/></a><!--목록보기  -->
		                </div>
		                <!-- 버튼 끝 -->
	
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
