<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search() {
	if($("#includeEndMissionCheck").prop("checked")){
		document.frm.includeEndMission.value = 'Y';
	}else{
		document.frm.includeEndMission.value = 'N';
	}

	document.frm.action = "${rootPath}/cooperation/selectMissionSearchList.do";		
	document.frm.submit();
}


function view(missionId,missionTree) {
	document.frm.missionId.value = missionId;
	document.frm.missionTree.value = missionTree; 
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


function dueDtModifyCall(missionId,dueDt,prntDueDt){
	document.frm.missionId.value = missionId; 
	document.frm.dueDt.value = dueDt; 
	document.frm.prntDueDt.value = prntDueDt;
	
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
		alert('완료 예정일을 입력하십시오.');
	}else{
		var dueDt = document.frm.dueDt.value;
		var prntDueDt = document.frm.prntDueDt.value;
		if(dueDt > prntDueDt){
			document.frm.leaderMixes.value = "";
			document.frm.dueDt.value = "";
			document.frm.historyCn.value = "";
			document.frm.missionStat.value = "";
	
			alert("상위 미션 완료일"+prntDueDt+"을 초과합니다.");	
		}else{
			document.frm.leaderMixes.value = "";
			document.frm.historyCn.value = "";
			document.frm.missionStat.value = "";
			document.frm.action = "<c:url value='${rootPath}/cooperation/updateMissionStat.do'/>";
			document.frm.submit();	
		}		
	}
}


function endDtModifyCall(missionId, missionStat){
	document.frm.missionId.value = missionId; 
	if(missionStat == 'C'){
		document.frm.missionStat.value = "IC"; 
		$('#missionICText').hide();
		$('#missionCText').show();
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





///$(document).ready(a,{key1 : 1});
$(document).ready(function(){
	//해당 mission의 바로 아래 mission 의  plus/minus상태에 따라 show/hide 시키는 recursive 함수
	function showChild(tr)
	{
		tr.show();
		if(tr.find(".midMinusB").length>0)
		{
			var prntMissionIdTree = tr.find("input[name=missionIdTree]").val();
			var prntMissionLv = parseInt(tr.find("input[name=missionLvTree]").val());
			tr.nextAll().each(function(index){
				var sn = $(this).find("input[name=missionSnTree]").val(); 
				var missionLvTree = $(this).find("input[name=missionLvTree]").val(); 
				if(sn.indexOf(prntMissionIdTree)>=0 && prntMissionLv+1 == parseInt(missionLvTree))
					showChild($(this));
			});
		}
	}

		// typeTree이 m이면 main, s면 sub project 
		
		//subProject 숨기기
		$('#missionListT input[name=typeTree][value=S]').closest('tr').hide();
		//leaf프로젝트 +- 버튼 없애기//
		$('#missionListT tr').each(function(){
			var missionLvTree = $(this).find("input[name=missionLvTree]").val();
			//마지막 tr일 경우
			if($(this).next().length==0) {
				$(this).find('.plusMinus').removeClass('midPlusB');
				$(this).find('.plusMinus').addClass('midNeutralB');
			}
			if(missionLvTree >= $(this).next().find("input[name=missionLvTree]").val()) {
				$(this).find('.plusMinus').removeClass('midPlusB');
				$(this).find('.plusMinus').addClass('midNeutralB');
			}
		});
		
		//+버튼 처리
		$('#missionListT .midPlusB').live("click",function(){
			var missionIdTree = $(this).closest('tr').find("input[name=missionIdTree]").val();
			$(this).removeClass('midPlusB');
			$(this).addClass('midMinusB');
			var tr = $(this).closest('tr');
			showChild(tr);
			//.parent().find("input[name=prntMissionIdTree][value="+missionIdTree+"]").parent().show();
		});
	
		//-버튼 처리
		$('#missionListT .midMinusB').live("click",function(){
			var missionIdTree = $(this).closest('tr').find("input[name=missionIdTree]").val();
			$(this).removeClass('midMinusB');
			$(this).addClass('midPlusB');
			$('#missionListT').find("input[name=missionSnTree][value*="+missionIdTree+"]").closest('tr').hide();
			$(this).closest('tr').show();
		});
});

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
							<li class="stitle">프로젝트별 미션</li>
							<li class="navi">홈 > 업무공유 > Mission Clear > 프로젝트별 미션</li>
						</ul>
					</div>
	
				<!-- S: section -->
				<div class="section01">
			    	
			    	<!-- 상단 검색창 시작 -->
			    	<form name="frm" method="POST">
			    	<input type="hidden" name="type" value="prj"/>
			    	<input type="hidden" name="includeEndMission" value="${searchVO.includeEndMission}"/>			    	
			        <input type="hidden" name="missionId" value=""/>
			        <input type="hidden" name="missionTree" value=""/>
			        <input type="hidden" name="prntDueDt" value=""/>
			        <input type="hidden" name="redirectUrl" value="${rootPath}/cooperation/selectMissionSearchList.do?type=prj&searchPrjId=${searchVO.searchPrjId}&searchPrjNm=${searchVO.searchPrjNm}&includeEndMission=${searchVO.includeEndMission}"/>
					
					<fieldset>
					<legend>상단 검색</legend>
						<div class="top_search07 mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<tbody>                    	
							<tr>
								<td class="pT5">
									프로젝트 선택 :
									<input type="text" name="searchPrjNm" id="searchPrjNm" value="${searchVO.searchPrjNm}" class="span_11 input01" readonly="readonly" onclick="prjGen('searchPrjNm','searchPrjId',1);"/>
									<input type="hidden" name="searchPrjId" id="searchPrjId" value="${searchVO.searchPrjId}"/>
									<img src="${imagePath}/btn/btn_tree.gif" onclick="prjGen('searchPrjNm','searchPrjId',1);" class="cursorPointer">
									<span class="pL7"></span> 
								</td>
								<td class="search_right">
									<label><input type="checkbox" name="includeEndMissionCheck"  id="includeEndMissionCheck" value="Y" onclick="javascript:search('${searchVO.type}');" <c:if test="${searchVO.includeEndMission == 'Y'}">checked="checked"</c:if>> 
										완료된 미션 표시</label>
									<span class="pL7"></span>	
									<a href="javascript:search();"><img src="${imagePath}/btn/btn_search02.gif" alt="검색"></a>
								</td>
							</tr>
						</tbody>
						</table>
	                    </div>
	                </fieldset>
			    	
			    	
			    	
					<!-- 레이어 수정 화면 시작 -->
                	<div class="simpleMsg_layer ms_layer" id="leaderModify" >
                		<div class="ms_layer_con">
                			<ul>
                				<li class="m_tt mB15">담당자</li>
                				<li>
		                    		<input type="text" class="userNamesAuto userValidateCheck" name="leaderMixes" id="leaderMixes" value="${result.leaderNm}(${result.leaderId})" />
		                    		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('leaderMixes',1)"/>
                				</li>
                				<li class="txt_right mT20">
			                    	<a href="javascript:leaderModify();" onfocus="this.blur();"><img src="${imagePath}/btn/btn_r.gif" alt="등록"/></a>
			                    	<input type="button" value="취소" class="btn_gray" onclick="javascript:hideLayerName('leaderModify');"/>
                				</li>
                			</ul>
                		</div>	
					</div>	
					<div class="simpleMsg_layer ms_layer" id="dueDtModify" >
						<div class="ms_layer_con">
                			<ul>
                				<li class="m_tt mB15">완료예정일</li>
                				<li>
		                    		<input type="text" name="dueDt" id="dueDt" class="span_7 calGen" value="${result.dueDt}"/>
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
					
					<!-- 게시판 시작  -->
					<div class="boardList mB20">
					총 ${paginationInfo.totalRecordCount} 건
						<!-- 버튼 시작 -->
	           		    <div style="float:right;border:0px solid red;">
	           		    	<a href="javascript:insertMission();"><img src="${imagePath}/btn/btn_mission.gif" alt="새미션"/></a>                		
	               	    </div>
	                 	<!-- 버튼 끝 -->					
						<table id="missionListT" cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						    <caption>프로젝트별 미션</caption>
						    <colgroup>
							    <col width="px" />
								<col class="col55" />
								<col class="col55" />
								<col class="col80" />
								<col class="col80" />
						    </colgroup>
						    <thead>
						    	<tr>
						    		<th>미션명</th>
						    		<th>작성자</th>
						    		<th>담당자</th>
						    		<th>완료예정일</th>
						    		<th class="td_last">처리상태</th>
						    	</tr>
						    </thead>
						    <tbody>    
						    	<c:forEach items="${missionList}" varStatus="status" var="mission">
						     	<tr>
						     		<td class="hidden">
						     			<input name="typeTree" type="hidden" value="${mission.typeTree}"/>
								     	<input name="prntMissionIdTree" type="hidden" value="${mission.prntMissionId}"/>
								     	<input name="missionIdTree" type="hidden" value="${mission.missionId}"/>
								     	<input name="missionSnTree" type="hidden" value="${mission.missionTree}"/>
								     	<input name="missionLvTree" type="hidden" value="${mission.missionLv}"/>
								     </td>	
							      	<td class="pL10">
							      		<c:forEach begin="1" end="${mission.missionLv}">
							      			&nbsp;&nbsp;&nbsp;
							      		</c:forEach>
							      		<span class="plusMinus midPlusB pL10"></span>
							      		<a href="javascript:view('${mission.missionId}','${fn:substring(mission.missionTree,0, 23)}');">
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
							      	<td class="txt_center">
							      		<c:if test="${user.userNm == mission.leaderNm || user.userNm == mission.writerNm || user.isAdmin == 'Y'}">
							      		<a href="javascript:leaderModifyCall('${mission.missionId}','${mission.leaderNm}(${mission.leaderId})');" id="leaderModifyPosition_${mission.missionId}">
							      		</c:if>
							      		${mission.leaderNm}
							      		</a>
							      	</td>
							      	<td class="txt_center">
							      		<c:if test="${user.userNm == mission.leaderNm || user.userNm == mission.writerNm || user.isAdmin == 'Y'}">
							      		<a href="javascript:dueDtModifyCall('${mission.missionId}','${mission.dueDt}','${mission.prntDueDt}');" id="dueDtModifyPosition_${mission.missionId}">
							      		</c:if>
							      		${fn:substring(mission.dueDt,4,6)}.${fn:substring(mission.dueDt,6,8)}
							      		</a>
							      	</td>
									<td class="td_last txt_right pR5">
										<c:if test="${user.userNm == mission.leaderNm || user.userNm == mission.writerNm || user.isAdmin == 'Y'}">
										<a href="javascript:endDtModifyCall('${mission.missionId}','${mission.missionStat}');" id="endDtModifyPosition_${mission.missionId}">
										</c:if>
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
					<!--// 게시판  끝  -->				
					
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
