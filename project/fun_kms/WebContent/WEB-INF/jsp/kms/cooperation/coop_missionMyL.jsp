<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>

function search(type,missionLv) {
	document.frm.type.value = type;
	document.frm.missionLv.value = missionLv;

	if($("#includeEndMissionCheck").prop("checked")){
		document.frm.includeEndMission.value = 'Y';
	}else{
		document.frm.includeEndMission.value = 'N';
	}
	document.frm.action = "${rootPath}/cooperation/selectMissionMyList.do";	
	document.frm.submit();
}


function view(missionId,type,missionTree,missionLv) {
	document.frm.type.value = type;
	document.frm.missionId.value = missionId; 
	document.frm.missionTree.value = missionTree;
	document.frm.missionLv.value = missionLv;
	document.frm.action = "${rootPath}/cooperation/selectMission.do";
	document.frm.submit();	
}


function insertMission() {
	document.frm.action = "${rootPath}/cooperation/insertMissionView.do";
	document.frm.submit();	
}


function hideLayerName(openedLayerName) {
	$('#'+openedLayerName).hide();
}

function leaderModifyCall(missionId,leaderMixes){
	document.frm.missionId.value = missionId; 
	document.frm.leaderMixes.value = leaderMixes; 
	
	$('#leaderModify').hide();
	$('#dueDtModify').hide();
	$('#endDtModify').hide();
	var scrolled = $(window).scrollTop();
	var position = $('#leaderModifyPosition_'+missionId).offset();
	var left = position.left + 0;
	var top = position.top + 10 - scrolled ;
	$('#leaderModify').css("left",($('#leaderModifyPosition_'+missionId).offset().left+46)+"px");
	$('#leaderModify').css("top",($('#leaderModifyPosition_'+missionId).offset().top+28)+"px");	
	$('#leaderModify').show();
}

function leaderModify(){
	document.frm.dueDt.value = "";
	document.frm.historyCn.value = "";
	document.frm.missionStat.value = "";
	if(document.frm.leaderMixes.value == ""){
		alert('담당자를 입력하십시오.');
	}else{
		document.frm.action = "<c:url value='${rootPath}/cooperation/updateMissionStat.do'/>";
		document.frm.submit();		
	}

}


function dueDtModifyCall(missionId,dueDt,prntDueDt,missionLv,chdMissionDt){
	document.frm.missionId.value = missionId; 
	document.frm.dueDt.value = dueDt; 
	document.frm.prntDueDt.value = prntDueDt;
	document.frm.missionLv.value = missionLv;
	document.frm.chdMissionDt.value = chdMissionDt;
	
	$('#leaderModify').hide();
	$('#dueDtModify').hide();
	$('#endDtModify').hide();
	var scrolled = $(window).scrollTop();
	var position = $('#dueDtModifyPosition_'+missionId).offset();
	var left = position.left + 0;
	var top = position.top + 10 - scrolled ;
	$('#dueDtModify').css("left",($('#dueDtModifyPosition_'+missionId).offset().left+46)+"px");
	$('#dueDtModify').css("top",($('#dueDtModifyPosition_'+missionId).offset().top+28)+"px");	
	$('#dueDtModify').show();
}
function dueDtModify(){
	if(document.frm.dueDt.value == ""){
		document.frm.leaderMixes.value = "";
		document.frm.historyCn.value = "";
		document.frm.missionStat.value = "";
		document.frm.dueDt.value = "";
		document.frm.missionLv.value = "";
		alert('완료 예정일을 입력하십시오.');
	}else{
		var dueDt = document.frm.dueDt.value;
		var prntDueDt = document.frm.prntDueDt.value;
		var missionLv = document.frm.missionLv.value;
		var chdMissionDt = document.frm.chdMissionDt.value;
		
		if(dueDt > prntDueDt && missionLv != 0){
			document.frm.leaderMixes.value = "";
			document.frm.dueDt.value = "";
			document.frm.historyCn.value = "";
			document.frm.missionStat.value = "";
	
			alert("상위 미션 완료일"+prntDueDt+"을 초과합니다.");	
		}else if(chdMissionDt > dueDt){
			document.frm.leaderMixes.value = "";
			document.frm.dueDt.value = "";
			document.frm.historyCn.value = "";
			document.frm.missionStat.value = "";
	
			alert("하위 미션 완료일"+chdMissionDt+"을 초과합니다.");
		}else{
			document.frm.leaderMixes.value = "";
			document.frm.historyCn.value = "";
			document.frm.missionStat.value = "";
			document.frm.action = "<c:url value='${rootPath}/cooperation/updateMissionStat.do'/>";
			document.frm.submit();	
		}		
	}
}


function endDtModifyCall(missionId, missionStat, statCnt){
	document.frm.missionId.value = missionId; 
	if(missionStat == 'C'){
		document.frm.missionStat.value = "IC"; 
		$('#missionICText').hide();
		$('#missionCText').show();
	}else if(missionStat != 'C' && statCnt > 0){
		alert("하위 미션을 모두 완료해야 상위 미션을 완료 할수있습니다.");
		return;
	}else{
		document.frm.missionStat.value = "C";
		$('#missionCText').hide();
		$('#missionICText').show(); 
	}
	$('#leaderModify').hide();
	$('#dueDtModify').hide();
	$('#endDtModify').hide();
	var scrolled = $(window).scrollTop();
	var position = $('#endDtModifyPosition_'+missionId).offset();
	var left = position.left + 0;
	var top = position.top + 10 - scrolled ;
	$('#endDtModify').css("left",($('#endDtModifyPosition_'+missionId).offset().left+46)+"px");
	$('#endDtModify').css("top",($('#endDtModifyPosition_'+missionId).offset().top+28)+"px");	
	$('#endDtModify').show();
}
function endDtModify(){
	document.frm.leaderMixes.value = "";
	document.frm.dueDt.value = "";
	if(document.frm.historyCn.value == ""){
		alert('완료/미완료 변경 사유를 입력하십시오.');
	}else{
		document.frm.action = "<c:url value='${rootPath}/cooperation/updateMissionStat.do'/>";
		document.frm.submit();	
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
							<li class="stitle">나의 미션</li>
							<li class="navi">홈 > 업무공유 > Mission Clear > 미션</li>
						</ul>
					</div>
	
				<!-- S: section -->
				<div class="section01">			    	
			    	<!-- 상단 검색창 시작 -->
			    	<form name="frm" method="POST">
			    	<input type="hidden" name="includeEndMission" value="${searchVO.includeEndMission}"/>
					<input type="hidden" name="missionId" value=""/>
			    	<input type="hidden" name="missionTree" value=""/>			    		
					<input type="hidden" name="prntDueDt" value=""/>					
					<input type="hidden" name="type" value="${searchVO.type}"/>
					<input type="hidden" name="redirectUrl" value="${rootPath}/cooperation/selectMissionMyList.do?type=${searchVO.type}&includeEndMission=${searchVO.includeEndMission}"/>
					<input type="hidden" name="missionLv" value="${searchVO.missionLv }"/>
					<input type="hidden" name="chdMissionDt" value=""/>

					<!-- <fieldset>
					<legend>상단 검색</legend>
						<div class="top_search07 mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<tbody>
							<tr>
								<td class="txt_right">
									<label><input type="checkbox" name="includeEndMissionCheck"  id="includeEndMissionCheck" value="Y" onclick="javascript:search('${searchVO.type}');" <c:if test="${searchVO.includeEndMission == 'Y'}">checked="checked"</c:if>> 
									완료된 미션 표시</label>
								</td>								
							</tr>		
						</tbody>
						</table>
	                    </div>
	                </fieldset>
	                 -->

					<!-- 레이어 수정 화면 시작 -->
                	<div class="simpleMsg_layer ms_layer" id="leaderModify" >
                		<div class="ms_layer_con">
                			<ul>
                				<li class="m_tt mB15">담당자</li>
                				<li>
		                    		<input type="text" class="userNamesAuto userValidateCheck" name="leaderMixes" id="leaderMixes" value="${mission.leaderNm}(${mission.leaderId})" />
		                    		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('leaderMixes',1);"/>
                				</li>
                				<li class="txt_right mT20">
			                    	<a href="javascript:leaderModify();" onfocus="this.blur();"><img src="${imagePath}/btn/btn_r.gif" alt="등록"/></a>
			                    	<a href="javascript:hideLayerName('leaderModify');" onfocus="this.blur();"><img src="${imagePath}/btn/btn_c.gif" alt="취소"/></a>
                				</li>
                			</ul>
                		</div>	
					</div>	
					<div class="simpleMsg_layer ms_layer" id="dueDtModify" >
						<div class="ms_layer_con">
                			<ul>
                				<li class="m_tt mB15">완료예정일</li>
                				<li>
		                    		<input type="text" name="dueDt" id="dueDt" class="span_7 calGen" value="${mission.dueDt}"/>
                				</li>
                				<li class="txt_right mT20">
		                    		<a href="javascript:dueDtModify();" onfocus="this.blur();"><img src="${imagePath}/btn/btn_r.gif" alt="등록"/></a>
		                    		<a href="javascript:hideLayerName('dueDtModify');" onfocus="this.blur();"><img src="${imagePath}/btn/btn_c.gif" alt="취소"/></a>
                				</li>
                			</ul>
                		</div>	
					</div>	
					<div class="simpleMsg_layer ms_layer" id="endDtModify" style="width:240px;" >
						<ul>
							<li>
								<div id="missionICText" class="ms_layer_con"> 
									<ul>
										<li class="m_tt txtB_Black mB15">미션완료</li>
										<li>수고하셨습니다.<br/>작업내용을 입력해주세요.</li>
									</ul>
								</div>
							</li>
							<li>
								<div id="missionCText" class="ms_layer_con">	
									<ul>
										<li class="m_tt txtB_red mB15">미션 미완료</li>
										<li>완료된 미션을 미완료 상태로 변경합니다<br/>변경 사유를 입력해 주세요.</li>
									</ul>
								</div>
							</li>
							<li>
								<textarea rows="5" cols="98%" name="historyCn" id="historyCn"></textarea>
								<input type="hidden" name="missionStat" id="missionStat" style="width:98%;">
							</li>
							<li class="txt_right mT20">
								<input type="button" value="완료" class="btn_gray" onclick="javascript:endDtModify();""/>
								<input type="button" value="취소" class="btn_gray" onclick="javascript:hideLayerName('endDtModify');"/>
							</li>
						</ul>	
					</div>						
	                <!-- 레이어 수정 화면 끝 -->
	                
			    	</form>
                	<!-- 상단 검색창 끝 -->
					
					<div class="boardList mB20">
						<div class="tab_typeA">
							<ul>
								<li class="<c:choose>
											<c:when test="${searchVO.type == 'today'}">												
											on
											</c:when>										
											<c:otherwise>
											off												
											</c:otherwise>
											</c:choose>
											cursorPointer" 
									onclick="javascript:search('today','${searchVO.missionLv}');">오늘
									<span class="txt_blue3">(${todayIcCnt} / ${todayAllCnt})</span>
								</li> <!-- 수정  todayAllCnt - todayIcCnt => todayIcCnt -->
								<li class="<c:choose>
											<c:when test="${searchVO.type == 'seven'}">												
											on
											</c:when>										
											<c:otherwise>
											off												
											</c:otherwise>
											</c:choose>
											cursorPointer" 
									 onclick="javascript:search('seven','${searchVO.missionLv}');">7일 이내
									<span class="txt_blue3">(${sevenIcCnt} / ${sevenAllCnt})</span>
								</li>
								<li class="<c:choose>
											<c:when test="${searchVO.type == 'thirty'}">												
											on
											</c:when>										
											<c:otherwise>
											off												
											</c:otherwise>
											</c:choose>
											cursorPointer" 
									 onclick="javascript:search('thirty','${searchVO.missionLv}');">30일 이내
									<span class="txt_blue3">(${thirtyIcCnt} / ${thirtyAllCnt})</span>
								</li>
								<li class="<c:choose>
											<c:when test="${searchVO.type == 'next'}">												
											on
											</c:when>										
											<c:otherwise>
											off												
											</c:otherwise>
											</c:choose>
											cursorPointer" 
									 onclick="javascript:search('next','${searchVO.missionLv}');">향후
									<span class="txt_blue3">(${nextIcCnt} / ${nextAllCnt})</span>
								</li>
							</ul>
							<div style="text-align: right; height: 20px; width:160px; float: left; margin-top: 10px;">
								<input type="checkbox" name="includeEndMissionCheck"  id="includeEndMissionCheck" value="Y" onclick="javascript:search('${searchVO.type}');" <c:if test="${searchVO.includeEndMission == 'Y'}">checked="checked"</c:if>> 
								<span style=""><b>완료된 미션 표시</b></span>
							</div>
							<!-- 버튼 시작 -->
		           		    <div style="float:right;margin-bottom:1px;margin-top: 9px;border:0px solid red;">
		                		<a href="javascript:insertMission();"><img src="${imagePath}/btn/btn_mission.gif" alt="새미션"/></a>
		               	    </div>
		                 	<!-- 버튼 끝 -->
						</div>

							
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col35" />
							<col class="col90" />
							<col width="px" />
							<col class="col55" />
							<col class="col55" />
							<col class="col80" />
							<col class="col80" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">번호</th>
							<th scope="col">프로젝트코드</th>
							<th scope="col">미션명</th>
							<th scope="col">작성자</th>
							<th scope="col">담당자</th>
							<th scope="col">완료예정일</th>
							<th scope="col">처리상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${missionList}" var="mission" varStatus="c">
								<tr>
									<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/></td>
									<td class="txt_center" title="${mission.prjNm }"><a href="${PathConfig.rootPath }/cooperation/selectProjectV.do?prjId=${mission.prjId}" + " target=\_PRJ_BLANK_\">${mission.prjCd}</a></td>
									<td class="pL10">
										<a href="javascript:view('${mission.missionId}','${searchVO.type}','${fn:substring(mission.missionTree,0, 23)}','${mission.missionLv }');">
										<span class =
										<c:choose>
											<c:when test="${mission.missionStat == 'C'}">												
												"txtS_grey"
											</c:when>
											<c:when test="${mission.missionStat == 'IC'}">
												"txtS_bold"
											</c:when>
											<c:when test="${mission.missionStat == 'D'}">
												"txtS_red"
											</c:when>										
											<c:otherwise>												
											</c:otherwise>
										</c:choose>>${mission.missionNm}</span>											
										</a>
									</td>
									<td class="txt_center"><print:user userNo="${mission.writerNo}" userNm="${mission.writerNm}"/></td>
									<td class="txt_center"><a href="javascript:leaderModifyCall('${mission.missionId}','${mission.leaderNm}(${mission.leaderId})');" id="leaderModifyPosition_${mission.missionId}">${mission.leaderNm}</a></td>
									<td class="txt_center"><a href="javascript:dueDtModifyCall('${mission.missionId}','${mission.dueDt}','${mission.prntDueDt}','${mission.missionLv }','${mission.chdMissionDt }');" id="dueDtModifyPosition_${mission.missionId}">${fn:substring(mission.dueDt,4,6)}.${fn:substring(mission.dueDt,6,8)}</a></td>
									<td class="txt_center">
									<a href="javascript:endDtModifyCall('${mission.missionId}','${mission.missionStat}','${mission.statCnt }');" id="endDtModifyPosition_${mission.missionId}"> 
										<!--완료-C 미완료-IC 지연-D  -->
					                    <c:choose>
											<c:when test="${mission.missionStat == 'C'}">
												<span class="">완료(${fn:substring(mission.endDt,4,6)}.${fn:substring(mission.endDt,6,8)})</span>	
											</c:when>
											<c:when test="${mission.missionStat == 'IC'}">
												<span class="txtS_bold">미완료</span>
											</c:when>
											<c:when test="${mission.missionStat == 'D'}">
												<span class="txtS_red">지연</span>	
											</c:when>										
											<c:otherwise>
												<span class="">확인오류</span>
											</c:otherwise>
										</c:choose> 								
									</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>
					
					<!-- 페이징 시작 
					<div class="paginate">
	                	<ui:pagination paginationInfo="${paginationInfo}" jsFunction="search" type="image"/>
					</div>
					페이징 끝 -->
					
					<!-- 버튼 시작 
           		    <div class="btn_area">
                		<a href="javascript:insertMission();"><img src="${imagePath}/btn/btn_mission.gif" alt="새미션"/></a>
               	    </div>
                 	 버튼 끝 -->
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
