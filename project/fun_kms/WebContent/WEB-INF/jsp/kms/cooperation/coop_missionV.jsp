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
/*function view(missionId,missionTree) {
	document.frm.missionId.value = missionId;
	document.frm.missionTree.value = missionTree; 
	document.frm.action = "/cooperation/selectMission.do";
	document.frm.submit();	
}/*/
function view(missionId,missionTree,missionLv) {
	document.frm.missionId.value = missionId;
	document.frm.missionTree.value = missionTree; 
	document.frm.missionLv.value = missionLv;
	document.frm.action = "${rootPath}/cooperation/selectMission.do";
	document.frm.submit();	
}
function delMission() {
	if('${mission.subUseAt}' == 'N'){
		if (confirm('<spring:message code="common.delete.msg" />')) {
			document.frm.redirectUrl.value = '${searchVO.redirectUrl}';
			document.frm.useAt.value = "N";
			document.frm.action = "${rootPath}/cooperation/deleteMission.do";
			document.frm.submit();
		}
	}else if('${mission.subUseAt}' != 'N' && '${mission.topUseAt}' == 'N'){
		if (confirm('<spring:message code="common.delete.msg" />')) {
			document.frm.redirectUrl.value = '${searchVO.redirectUrl}';
			document.frm.useAt.value = "N";
			document.frm.action = "${rootPath}/cooperation/deleteMission.do";
			document.frm.submit();
		}
	}else{
		alert('하위 미션이 사용중 입니다.');
	}
}

function insertMissionSub(){
	document.frm.action = "<c:url value='${rootPath}/cooperation/insertMissionSubView.do'/>";
	document.frm.submit();	
}
function modify(){
	document.frm.action = "<c:url value='${rootPath}/cooperation/updateMissionView.do'/>";
	document.frm.submit();	
}
function list() {
	document.frm.leaderMixes.value = "${searchVO.leaderMixes}"; 
	if('${searchVO.type}' == "search"){
			document.frm.action = "${rootPath}/cooperation/selectMissionSearchList.do";
		}else if('${searchVO.type}' == "prj"){
			document.frm.action = "${rootPath}/cooperation/selectMissionSearchList.do";
		}else if('${searchVO.type}' == "stat"){
			document.frm.action = "${rootPath}/cooperation/selectMissionStatList.do";	
		}else{
			document.frm.action = "${rootPath}/cooperation/selectMissionMyList.do";
		}
		document.frm.submit();
}



function hideLayerName(openedLayerName) {
	$('#'+openedLayerName).hide();
}

function leaderModifyCall(missionId,leaderMixes,type){
	document.frm.missionId.value = missionId; 
	document.frm.leaderMixes.value = leaderMixes; 
	
	$('#leaderModify').hide();
	$('#dueDtModify').hide();
	$('#endDtModify').hide();
	var scrolled = $(window).scrollTop();
	var position = $('#leaderModifyPosition_'+missionId+type).offset();
	var left = position.left + 0;
	var top = position.top + 10 - scrolled ;
	$('#leaderModify').css("left",($('#leaderModifyPosition_'+missionId+type).offset().left+46)+"px");
	$('#leaderModify').css("top",($('#leaderModifyPosition_'+missionId+type).offset().top+28)+"px");	
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


function dueDtModifyCall(missionId,dueDt,prntDueDt,type,missionLv,chdMissionDt){
	document.frm.missionId.value = missionId; 
	document.frm.dueDt.value = dueDt; 
	document.frm.prntDueDt.value = prntDueDt;
	document.frm.missionLv.value = missionLv;
	document.frm.chdMissionDt.value = chdMissionDt;
	
	$('#leaderModify').hide();
	$('#dueDtModify').hide();
	$('#endDtModify').hide();
	var scrolled = $(window).scrollTop();
	var position = $('#dueDtModifyPosition_'+missionId+type).offset();
	var left = position.left + 0;
	var top = position.top + 10 - scrolled ;
	$('#dueDtModify').css("left",($('#dueDtModifyPosition_'+missionId+type).offset().left+46)+"px");
	$('#dueDtModify').css("top",($('#dueDtModifyPosition_'+missionId+type).offset().top+28)+"px");	
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


function endDtModifyCall(missionId, missionStat, statCnt, type){
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
	var position = $('#endDtModifyPosition_'+missionId+type).offset();
	var left = position.left + 0;
	var top = position.top + 10 - scrolled ;
	$('#endDtModify').css("left",($('#endDtModifyPosition_'+missionId+type).offset().left+46)+"px");
	$('#endDtModify').css("top",($('#endDtModifyPosition_'+missionId+type).offset().top+28)+"px");	
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
							<li class="stitle">미션 상세정보</li>
							<li class="navi">홈 > 업무공유 > Mission Clear > 미션</li>
						</ul>
					</div>
					<!-- S: section -->
					<div class="section01">
						<!-- 게시판 시작  -->
						<form name="frm" method="POST">
			    		<input type="hidden" name="type" 					value="${searchVO.type}"/>	
						<input type="hidden" name="missionId" 				value="${mission.missionId}"/>		  					    															    					 
			   	    	<input type="hidden" name="prntDueDt" 				value=""/>
			   			<input type="hidden" name="useAt" 					value=""/>	
			 			<input type="hidden" name="redirectUrl" 			value="${rootPath}/cooperation/selectMission.do?missionId=${mission.missionId}&type=${searchVO.type}&missionTree=${fn:substring(searchVO.missionTree,0, 23)}&searchPrjId=${searchVO.searchPrjId}&searchPrjNm=${searchVO.searchPrjNm}&searchDateS=${searchVO.searchDateS}&searchDateE=${searchVO.searchDateE}&searchWriterNm=${searchVO.searchWriterNm}&includeICMission=${searchVO.includeICMission}&includeCMission=${searchVO.includeCMission}&searchLeaderMixes=${searchVO.searchLeaderMixes}&searchKeyword=${searchVO.searchKeyword}"/>		
			 			<input type="hidden" name="searchDate" 				value="${searchVO.searchDate}"/>			    					    					 
			    		<input type="hidden" name="searchLeaderMixes" 		value="${searchVO.searchLeaderMixes}"/>	
			    		<input type="hidden" name="searchPrjId" 		    value="${searchVO.searchPrjId}"/>
			    		<input type="hidden" name="searchPrjNm" 		    value="${searchVO.searchPrjNm}"/>	
			    		<input type="hidden" name="searchDateS" 		    value="${searchVO.searchDateS}"/>	
			    		<input type="hidden" name="searchDateE" 		    value="${searchVO.searchDateE}"/>	
			    		<input type="hidden" name="searchWriterNm" 			value="${searchVO.searchWriterNm}"/>	
			    		<input type="hidden" name="includeEndMission" 		value="${searchVO.includeEndMission}"/>	
			    		<input type="hidden" name="includeICMission" 		value="${searchVO.includeICMission}"/>	
			    		<input type="hidden" name="includeCMission" 		value="${searchVO.includeCMission}"/>	
			    		<input type="hidden" name="searchKeyword" 			value="${searchVO.searchKeyword}"/>	
			        	<input type="hidden" name="missionTree"             value=""/>
			        	<input type="hidden" name="missionLv"               value="${mission.missionLv }"/>
			        	<input type="hidden" name="chdMissionDt"            value=""/>
			   		<div class="boardView">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>미션 상세보기</caption>
		                    <colgroup>
		                    	<col class="col100" />
		                    	<col width="px" />
		                    	<col class="col100" />
		                    	<col width="px" />
	                    	</colgroup>
		                    <thead>
		                    	<tr>
		                    		<th class="write_info">미션명</th>
			                        <th class="write_info2" colspan="3" >${mission.missionNm}</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">담당자</th>
			                    	<th class="write_info2">${mission.leaderNm}
			                    	<c:if test="${user.userNm == mission.leaderNm || user.userNm == mission.writerNm || user.isAdmin == 'Y'}">
			                    		<img src="/images/btn/btn_change6.gif" class="cursorPointer" id="leaderModifyPosition_${mission.missionId}view" onclick="javascript:leaderModifyCall('${mission.missionId}','${mission.leaderNm}(${mission.leaderId})','view');" alt="변경" />
				                	</c:if>
			                    	<th class="write_info">작성자</th>
			                    	<th class="write_info2"><print:user userNo="${mission.writerNo}" userNm="${mission.writerNm}"/></th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">완료예정일</th>
			                    	<th class="write_info2">${fn:substring(mission.dueDt,4,6)}.${fn:substring(mission.dueDt,6,8)}
			                    	<c:if test="${user.userNm == mission.leaderNm || user.userNm == mission.writerNm || user.isAdmin == 'Y'}">
			                    		<img src="/images/btn/btn_change6.gif" class="cursorPointer" id="dueDtModifyPosition_${mission.missionId}view" onclick="javascript:dueDtModifyCall('${mission.missionId}','${mission.dueDt}','${mission.prntDueDt}','view',${mission.missionLv },'${mission.chdMissionDt }');" alt="변경" />
			                    	</c:if>
			                    	<th class="write_info">작성일시</th>
			                    	<th class="write_info2">${fn:substring(mission.regDt,4,6)}.${fn:substring(mission.regDt,6,8)}</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">처리상태</th>
			                    	<th class="write_info2">
			                    	<!--완료-C 미완료-IC 지연-D  -->
			                    <c:choose>
									<c:when test="${mission.missionStat == 'C'}">
										<span class="">완료(${mission.endDt})</span>
									</c:when>
									<c:when test="${mission.missionStat == 'IC'}">
										<span class="txtS_blue">미완료</span>	
									</c:when>
									<c:when test="${mission.missionStat == 'D'}">
										<span class="txtS_red">지연</span>	
									</c:when>										
									<c:otherwise>
										<span class="">확인오류</span>
									</c:otherwise>
								</c:choose>
								<c:if test="${user.userNm == mission.leaderNm || user.userNm == mission.writerNm || user.isAdmin == 'Y'}">
									<img src="/images/btn/btn_change6.gif" class="cursorPointer" id="endDtModifyPosition_${mission.missionId}view" onclick="javascript:endDtModifyCall('${mission.missionId}','${mission.missionStat}','${mission.statCnt }','view');" alt="변경" />
								</c:if>
									</th>
			                    	<th class="write_info">변경일시</th>
			                    	<th class="write_info2">${fn:substring(mission.modDt,4,6)}.${fn:substring(mission.modDt,6,8)}</th>
		                        </tr>
		                       <tr>
			                    	<th class="write_info">프로젝트</th>
			                    	<th class="write_info2" colspan="3"><print:project prjCd="${mission.prjCd}" prjId="${mission.prjId}" prjNm="${mission.prjNm}" length="35"/></th>
		                        </tr>
		          
		                       <tr>
			                    	<th class="write_info">상위미션</th>
			                    	<th class="write_info2" colspan="3">${mission.prntMissionNm}</th>
		                        </tr>
		          
		          
		                                             
		                    </thead>
							<tfoot>
								<tr>
									<td class="write_info">첨부파일</td>
									<td class="write_info2" colspan="3">
										<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${mission.attachFileId}" />
										</c:import>
									</td>
								</tr>
							</tfoot>
		                    <tbody>
		                    	<tr>
			                    	<td colspan="4" class="H300"><c:out value="${mission.missionCn}" escapeXml="false" /></td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						
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
		        		<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02 pB20">
		                	<ul>
		                		<li class="left">
		                		<a href="javascript:insertMissionSub();"><img src="/images/btn/btn_addmission.gif" alt="서브미션 추가"/></a>
		                		</li>
		                		<li class="right">
		                			<c:if test="${user.userNm == mission.writerNm || user.isAdmin == 'Y'}">
		                				<a href="javascript:delMission();"><img src="/images/btn/btn_delete.gif" alt="삭제"/></a>
		                			</c:if>
		                			<c:if test="${user.userNm == mission.leaderNm || user.userNm == mission.writerNm || user.isAdmin == 'Y'}">
				                		<a href="javascript:modify();"><img src="/images/btn/btn_modify.gif" alt="수정"/></a>
				                	</c:if>
				                	<a href="javascript:list();"><img src="/images/btn/btn_list.gif" alt="목록"/></a>
		                		</li>
		                	</ul>
		                </div>
		                <!--// 버튼 끝 -->
		                
			            <!-- 관련미션 시작  -->
					
					<div class="boardList mB20">
						<p class="th_stitle mB10">관련미션</p>		
						<table id="missionListT" cellpadding="0" cellspacing="0" summary="관련미션">
						<caption>관련미션</caption>
						<colgroup>
							<col width="px" />
							<col class="col55" />
							<col class="col55" />
							<col class="col80" />
							<col class="col80" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">미션명</th>
							<th scope="col">작성자</th>
							<th scope="col">담당자</th>
							<th scope="col">완료예정일</th>
							<th scope="col">처리상태</th>	
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${missionLinkList}" var="missionLink" varStatus="status">
								<tr <c:if test="${missionLink.missionId == missionId}">style='background-color:#FAECC5;'</c:if>>
						     		<td class="hidden">
						     			<input name="typeTree" type="hidden" value="${missionLink.typeTree}"/>
								     	<input name="prntMissionIdTree" type="hidden" value="${missionLink.prntMissionId}"/>
								     	<input name="missionIdTree" type="hidden" value="${missionLink.missionId}"/>
								     	<input name="missionSnTree" type="hidden" value="${missionLink.missionTree}"/>
								     	<input name="missionLvTree" type="hidden" value="${missionLink.missionLv}"/>
								     	<input name="chdMissionDt" type="hidden" value="${missionLink.chdMissionDt }"/>
								     </td>	
							      	<td class="pL10">
							      		<c:forEach begin="1" end="${missionLink.missionLv}">
							      			&nbsp;&nbsp;&nbsp;
							      		</c:forEach>
							      		<span class="plusMinus midPlusB pL10"></span>
							      		<a href="javascript:view('${missionLink.missionId}','${fn:substring(missionLink.missionTree,0, 23)}','${missionLink.missionLv }');">
																<span class =
																<c:choose>
																	<c:when test="${missionLink.missionStat == 'C'}">	
																		"txtS_grey"											
																	</c:when>
																	<c:when test="${missionLink.missionStat == 'IC'}">
																		"txtS_blue"
																	</c:when>
																	<c:when test="${missionLink.missionStat == 'D'}">
																		"txtS_red"
																	</c:when>										
																	<c:otherwise>												
																	</c:otherwise>
																</c:choose>>${missionLink.missionNm}</span>	
										</a>
							      	</td>
							      	<td class="txt_center"><print:user userNo="${missionLink.writerNo}" userNm="${missionLink.writerNm}"/></td>
							      	<td class="txt_center">
							      		<c:if test="${user.userNm == mission.leaderNm || user.userNm == mission.writerNm || user.isAdmin == 'Y'}">
							      		<a href="javascript:leaderModifyCall('${missionLink.missionId}','${missionLink.leaderNm}(${missionLink.leaderId})','');" id="leaderModifyPosition_${missionLink.missionId}">
							      		</c:if>
							      			${missionLink.leaderNm}
							      		</a>
							      		
							      	</td>
							      	<td class="txt_center">
							      		<c:if test="${user.userNm == mission.leaderNm || user.userNm == mission.writerNm || user.isAdmin == 'Y'}">
							      		<a href="javascript:dueDtModifyCall('${missionLink.missionId}','${missionLink.dueDt}','${missionLink.prntDueDt}','','${missionLink.missionLv }','${missionLink.chdMissionDt }');" id="dueDtModifyPosition_${missionLink.missionId}">
							      		</c:if>
							      			${fn:substring(missionLink.dueDt,4,6)}.${fn:substring(missionLink.dueDt,6,8)}
							      		</a>
							      	</td>
									<td class="td_last txt_right pR5">
										<c:if test="${user.userNm == mission.leaderNm || user.userNm == mission.writerNm || user.isAdmin == 'Y'}">
										<a href="javascript:endDtModifyCall('${missionLink.missionId}','${missionLink.missionStat}','${missionLink.statCnt }','');" id="endDtModifyPosition_${missionLink.missionId}">
										</c:if>
										<!--완료-C 미완료-IC 지연-D  -->
						                   <c:choose>
											<c:when test="${missionLink.missionStat == 'C'}">
												<span class="">완료(${fn:substring(missionLink.endDt,4,6)}.${fn:substring(missionLink.endDt,6,8)})</span>	
											</c:when>
											<c:when test="${missionLink.missionStat == 'IC'}">
												<span class="txtS_blue">미완료</span>	
											</c:when>
											<c:when test="${missionLink.missionStat == 'D'}">
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
		        		<!--// 관련미션 끝  -->

	    
		           <!-- 변경이력 시작  -->
					
					<div class="boardList mB20">
						<p class="th_stitle mB10">변경이력</p>	
						<table cellpadding="0" cellspacing="0" summary="미션 히스토리">
						<caption>변경이력</caption>
						<colgroup>
							<col class="col100" />
							<col class="col50" />
							<col class="col100" />
							<col width="px" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">일시</th>
							<th scope="col">이름</th>
							<th scope="col">진행내역</th>
							<th scope="col">내용</th>

							</tr>
						</thead>
						<tbody>
							<c:forEach items="${missionHistoryList}" var="missionHistory" varStatus="c">
								<tr>
									<td class="txt_center">${fn:substring(missionHistory.regDt,0,4)}.${fn:substring(missionHistory.regDt,5,7)}.${fn:substring(missionHistory.regDt,8,10)} ${fn:substring(missionHistory.regDt,11,16)}</td>
									<td class="txt_center">${missionHistory.writerNm}</td>
									<td class="txt_center">
										<c:choose>
											<c:when test="${missionHistory.historyStat == 'CL'}">												
												담당자 변경
											</c:when>
											<c:when test="${missionHistory.historyStat == 'CD'}">
												예정일 변경
											</c:when>
											<c:when test="${missionHistory.historyStat == 'C'}">
												완료 처리
											</c:when>										
											<c:when test="${missionHistory.historyStat == 'IC'}">
												미완료 처리
											</c:when>	
											<c:when test="${missionHistory.historyStat == 'W'}">
												등록
											</c:when>
											<c:when test="${missionHistory.historyStat == 'U'}">
												수정
											</c:when>
											<c:when test="${missionHistory.historyStat == 'D'}">
												삭제
											</c:when>																					
											<c:otherwise>												
											</c:otherwise>
										</c:choose>										
									</td>
									<td class="txt_center" style="text-align: left;"><pre>${missionHistory.historyCn}</pre></td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
					</div>
		        		<!--// 변경이력 끝  -->
		        		
		        		
		        		
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
