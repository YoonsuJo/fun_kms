<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>

$(document).ready(function(){
	var prjId = "${projectVO.prjId }";
	/*하위프로젝트 로딩*/
	$.post("/ajax/selectProjectList.do",$('#searchProjectChildVO').serialize(),function(data){
		$('#ProjectChildD').html(data);
		$('#searchProjectChildVO input[name=searchStatL]').bind("change",function(){
			$.post("/ajax/selectProjectList.do",$('#searchProjectChildVO').serialize(),function(data){
				
					$('#ProjectChildD').html(data);
				});
			});
		}); 

	
	var mode = "${mode}";
	
	$('#prntPrjInputB').click(function(){
		if(confirm('상위프로젝트의 투입인력을 가져시겠습니까?')){
			$.post('/ajax/insertPrntPrjInput.do',{prjId:prjId},function(data){
				if(data.indexOf('success')>=0){
					window.location = window.location;
				}
			});
		};

	});
	$('#projectInputS').click(function(){
		
		var _this = $(this);
		var position = _this.offset();
		$.post("/ajax/writeProjectInput.do?prjId="+prjId,function(data){
			var layer = $('<div id="projectInputL">'+ data + '</div>');
			
			layer.dialog({
				height: 500
			,width:830 
			,closeOnEscape: true 
			,resizable: true 
			,draggable: true
			,modal :true
			,autoOpen: true		
			,position : [50,100]
			,close: function(event,ui){
					layer.remove();

				}});	
			/* form 값이 바꼇는지를 체크 하는 변수 */
			var isChanged = false;
			
			$('#userTreeB').click(function(){
				usrGen('userInput',2,userAdd);
			});
			
			$('#userAddB').click(function(){
				userAdd($('#userInput'));
			});

			$('#userInput').keydown(function(e) {
				if(e.keyCode == 13 && !$(this).data("autocomplete").menu.active){
					userAdd($(this));
				}
			});
			
			$('#prjInputSaveB').click(function(){
				//check안된 box에 valid한 값을 setting하기 위해 clone된 form을 만들어서 보내준다.
				var cloneForm = $('#projectInputVO');
				cloneForm.find(":checkbox").each(function(){
					if($(this).is(":checked"))
						;
					else
						$(this).val(0);
				});
				cloneForm.find(":checkbox").attr("checked","checked");
				$.post("/ajax/updateProjectInput.do",cloneForm.serialize()
					,function(data){
					if(data.indexOf("success"))
					{
						window.location = window.location;
					}
				});

			});
			$('#prjInputCancleB').click(function(){
				layer.dialog("destroy");
				layer.remove();
			});
			function moveProjectInputYear(event)
			{
				if(isChanged)
				{
					if(!confirm("저장되지 않은 값이 있습니다. 이동하시겠습니까?"))
						return;
				}
				var offset = event.data.key1;
				var year = parseInt($('#projectInputVO input[name=year]').val()) + parseInt(offset);
				
				$.post("/ajax/writeProjectInput.do?prjId="+ prjId +"&year="+year,function(data){
					$('#projectInputVO input[name=year]').val(year);
					$('#projectInputYear').html(year);
					var tableData = $(data).find('#userInputTable');
					$('#userInputTable').html(tableData.html());
					isChanged = false;
				});
			}
			
			$('#moveYearNext').bind("click",{key1 : 1},moveProjectInputYear);
			$('#moveYearPrev').bind("click",{key1 : -1},moveProjectInputYear);

			$('#projectInputVO input[name=monthAll]').live("change",function(event){
				isChanged = true;
				var checked = $(this).is(":checked");
				if(checked)
					$(this).parent().parent().find("input[type=checkbox]").attr("checked",true);
				else
					$(this).parent().parent().find("input[type=checkbox]").attr("checked",false);
			});
			$('#projectInputVO input[name!=monthAll]').live("change",function(event){
				isChanged= true;
			});
			$('.verticalAll').change(function(){
				if($(this).attr("checked"))
					$('.monthList' + $(this).val()).attr("checked",true);
				else
					$('.monthList' + $(this).val()).attr("checked",false);
			});

			function userAdd(userNmObj, userIdObj){
				var userNmList = makeUserNmArray(userNmObj.val());
				var userIdList = makeUserIdArray(userNmObj.val());
				userNmObj.val("");
				for( var i =0; i<userIdList.length; i++){
					var trLength = $('#projectInputVO').find("tr").length;
					if($('#projectInputVO').find("input[name=userIdList][value="+escapeJQuerySelector(userIdList[i]) +"]").length>0)
					{
						alert(userNmList[i] + "은(는) 이미 추가된 사원입니다.");
						continue;
					}

					var tr = $('<tr>' + 
							'<td class="hidden"><input type="hidden" name="userIdList" value="'+userIdList[i] +'"/></td>' +
							'<td class="txt_center">'+ trLength +'</td>' +
							'<td class="txt_center userNm">'+userNmList[i]+'</td>' +
							'<td class="txt_center"><input name="monthList" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" type="checkbox" value="1"/></td>' +
							'<td class="txt_center"><input name="monthList" type="checkbox" value="1"/></td>' +
							'<td class="td_last txt_center"><input name="monthAll" type="checkbox" /></td>' +
							'</tr>');
						tr.appendTo($('#userInputTable').find('tbody'));
				}
				
			};

		});

	});


	//월별 실적 로딩
	$.post('/ajax/cooperation/selectProjectMonthlyReport.do',{prjId : prjId,includeUnderPrj :'Y'},function(data){
		$('#monthlyReportInnerD').html(data);	
		$('#monthlyReportD input[name=includeUnderPrj]').click(function(){
			var checkVal = $('#monthlyReportD input[name=includeUnderPrj]:checked').val();
			$.post('/ajax/cooperation/selectProjectMonthlyReport.do',{prjId : prjId,includeUnderPrj : checkVal},function(data){
				$('#monthlyReportInnerD').html(data);
			});

		});	

		
	});

	//토글 버튼 활성화
	$('.toggleB').click(function(){
		if($(this).hasClass('btn_arrow_down')){
			$(this).removeClass('btn_arrow_down');
			$(this).addClass('btn_arrow_up');
			$(this).closest('p').removeClass('mB20');
			$(this).closest('p').next().show();
		}
		else{
			$(this).removeClass('btn_arrow_up');
			$(this).addClass('btn_arrow_down');
			$(this).closest('p').addClass('mB20');
			$(this).closest('p').next().hide();
		}
		
	});

	// 업무연락, 펀네트회의실, 월별실적, 작업은 숨김 상태가 default
	$('#busiContactD').hide();
	$('#meetingD').hide();
	$('#taskD').hide();
	$('#monthlyReportD').hide();
});

function viewProject(prjId){
	var form = $('#searchVO');
	form.find("[name$=prjId]").val(prjId);
	form.attr("action", "/cooperation/selectProjectV.do?prjId="+prjId);
	form.submit();
}

function busiSearch(pageIndex) {
	document.busiFrm.pageIndex.value = pageIndex;
	$.post("${rootPath}/ajax/selectBusinessContactList.do", $('#busiFrm').serialize(), function(data) {
		$('#busiContactInnerD').html(data);
	});
}

function meetSearch(pageIndex) {
	document.meetFrm.pageIndex.value = pageIndex;
	$.post("${rootPath}/ajax/selectMeetingRoomList.do", $('#meetFrm').serialize(), function(data) {
		$('#meetingRoomInnerD').html(data);
	});
}

function taskSearch(pageIndex) {
	document.taskFrm.pageIndex.value = pageIndex;
	$.post("${rootPath}/ajax/resultList.do", $('#taskFrm').serialize(), function(data) {
		$('#taskInnerD').html(data);
	});
}
function salesSearch(pageIndex) {
	document.salesFrm.pageIndex.value = pageIndex;
	$.post("${rootPath}/ajax/salesList.do", $('#salesFrm').serialize(), function(data) {
		$('#salesInnerD').html(data);
	});
}
function selectInputResultProjectDetail(year, month) {
	if (month.length == 1)
		month = '0' + month;
	document.monthlyReportFrm.saerchDate.value = year + '' + month + '' + '01';
	document.monthlyReportFrm.action = "${rootPath}/management/selectInputResultProjectDetail.do";
	document.monthlyReportFrm.submit();
}
function selectExpenseStatistic(year) {
	document.monthlyReportFrm.searchYear.value = year;
	document.monthlyReportFrm.action = "${rootPath}/management/selectExpenseStatistic.do";
	document.monthlyReportFrm.submit();
}
function interest(prjId) {
	var form = $('#searchVO');
	form.find('[name$=prjId]').val(prjId);
	form.attr("action", "/cooperation/switchPrjInterest.do");
	form.submit();
}
function terminateProject(prjId) {
	if(confirm("프로젝트를 종료처리하시겠습니까?")){
		location.href="/project/updateProjectStatEnd.do?prjId=" + prjId;
	}
}
</script>
</head>

<body>
	<!-- S: center -->
	<div id="pop_reg_div01">
		<div id="pop_top">
			<ul>
				<li><img src="../images/inc/pop_bullet.gif" /></li>
				<li class="popTitle">프로젝트 상세정보</li>
			</ul>
		</div>	
		
		<!-- S: section -->
		<div class="pop_reg_div02">
			<form:form commandName="searchVO" name="searchVO" id="searchVO" method="post" enctype="multipart/form-data" >
				<input name="prjId" type="hidden" value="${projectVO.prjId }" />
				<input name="returnUrl" type="hidden" value="${rootPath}/cooperation/selectProjectV.do?prjId=${projectVO.prjId }" />
			</form:form>
			<form:form commandName="projectVO" name="projectVO" method="post" enctype="multipart/form-data" >
			<!-- 게시판 시작  -->
				<p class="th_stitle">프로젝트 개요</p>
				<div class="boardWrite02 mB20">
				<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
				<caption>프로젝트 개요</caption>
				<colgroup>
					<col class="col120" />
					<col width="col400"/>
					<col class="col120" />
					<col width="col400"/>
				</colgroup>
				<tbody>
					<tr>
						<td class="title" rowspan="2">구분</td>
						<td class="pL10" colspan="3">
							<input name="" type="radio" name="type" disabled="disabled" <c:if test="${projectVO.type=='M' }">checked </c:if> /> 메인프로젝트
							<input name="" type="radio" name="type" disabled="disabled" <c:if test="${projectVO.type=='S' }">checked </c:if>/> 서브프로젝트
						</td>
					</tr>
					<tr>
						<td class="pL10" colspan="3">
                			<input type="radio" name="prjType" disabled="disabled" <c:if test="${projectVO.prjType=='M' }">checked </c:if>/> 경영
                			<input type="radio" name="prjType" disabled="disabled" <c:if test="${projectVO.prjType=='B' }">checked </c:if>/> 사업
                			<input type="radio" name="prjType" disabled="disabled" <c:if test="${projectVO.prjType=='S' }">checked </c:if>/> 영업
                			<input type="radio" name="prjType" disabled="disabled" <c:if test="${projectVO.prjType=='P' }">checked </c:if>/> 수행
                			<input type="radio" name="prjType" disabled="disabled" <c:if test="${projectVO.prjType=='E' }">checked </c:if>/> 기타
						</td>
					</tr>
					<tr>
						<td class="title">프로젝트코드</td>
						<td class="pL10">
							<span class="txtB_grey">${projectVO.prjCd }</span>
						</td>
						<td class="title">프로젝트명</td>
						<td class="pL10" ><span class="txtB_grey">${projectVO.prjNm }</span></td>
					</tr>
					<tr>
						<td class="title">상위프로젝트</td>
						<td class="pL10" colspan="3">
							<print:project prjCd="${projectVO.prntPrjCd }" prjId="${projectVO.prntPrjId}" prjNm="${projectVO.prntPrjNm}"/>
						</td>
					</tr>
					<tr>
						<td class="title">주관부서</td>
						<td class="pL10">${projectVO.orgnztNm }</td>
						<td class="title">담당자(PL)</td>
						<td class="pL10">${projectVO.leaderMix}</td>
					</tr>
					
					<tr>
						<td class="title">진행상태</td>
						<td class="pL10">
							<form:radiobuttons items="${codeList3}" path="stat" disabled="true" itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/>
						</td>
						<td class="title">생성일</td>
						<td class="pL10"><print:date date="${projectVO.regDt }"/></td>
					</tr>
					<tr>
						
						<td class="title">
							시작일
						</td>
						<td class="pL10" > 
							<print:date date="${projectVO.stDt}"/> 
						</td>
						<td class="title">
							종료일
						</td>
						<td class="pL10" > 
							<print:date date="${projectVO.compDueDt}"/> 
						</td>
					</tr>
					<tr>
						<td class="title">투입인력</td>
						<td class="pL10" colspan="2">
							<c:choose>
								<c:when test="${empty prjInputMaxUser }">
									<span class="txt_blue cursorPointer" id="projectInputS">투입 인력이 없습니다</span>
								</c:when>
								<c:otherwise>
									<span class="txt_blue cursorPointer" id="projectInputS">${prjInputMaxUser.userNm} 외 ${prjInputCnt - 1}명</span>		
								</c:otherwise>
							</c:choose> 
							<span class="T11"> (클릭하면 상세정보를 확인할 수 있습니다)</span>
						</td>
						<td>
							<c:if test="${projectVO.type=='S' && (user.admin || prjAuth=='Y' || prjAuth2=='Y')}">
								<span id="prntPrjInputB" class="cursorPointer mL20">※ 상위프로젝트 투입인력 가져오기</span>
							</c:if>
						</td>
					</tr>
					<tr>
						<td class="title">업무실적등록</td>
						<td class="pL10" >
							<form:radiobuttons items="${codeList2}" path="dayReportRule" disabled="true" itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/>
							</td>
							<td class="title">비용지출</td>
						<td class="pL10" >
							<form:radiobuttons items="${codeList2}" path="manageCostRule" disabled="true" itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/>
							</td>
					</tr>
					<tr>
						<td class="title">예산초과관리</td>
						<td class="pL10" colspan="3">
							<form:radiobuttons items="${codeList1}" path="budgetExceedRule" disabled="true" itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/><br/>
							</td>

						</tr>
						<tr>
							<td class="title">개요</td>
							<td class="pL10 pT5 pB5" colspan="3"><print:textarea text="${projectVO.prjCn}"/> </td>
						</tr>
					</tbody>
					</table>
				</div>
				<!--// 게시판 끝  -->
				
				<!-- 버튼 시작 -->
                <div class="btn_area02 pB30">
                	<ul>
                		<li class="right">
                			<c:if test="${user.admin || prjAuth=='Y' || user.isProjectadmin == 'Y' || prjAuth2=='Y'}">
								<a href="/project/ProjectMovePop.do?prjId=${projectVO.prjId}">
									<img src="${imagePath}/btn/btn_move.gif"/>
								</a>
							</c:if>
							<c:if test="${user.admin || prjAuth=='Y' || user.isProjectadmin == 'Y' || prjAuth2=='Y'}">
								<a href="/project/modifyProjectPop.do?prjId=${projectVO.prjId}">
									<img src="${imagePath}/btn/btn_modify.gif"/>
								</a>
							</c:if>
							<c:if test="${user.admin || prjAuth=='Y' || user.isProjectadmin == 'Y' || prjAuth2=='Y'}">
								<a href="/project/updateProjectStatEnd.do?prjId=${projectVO.prjId}">
									<img src="${imagePath}/btn/btn_end_prj.gif"/>
								</a>
							</c:if>
							<img src="${imagePath}/btn/btn_cancel.gif" onclick="window.close()"/>
                		</li>
                	</ul>
                </div>
                <!--// 버튼 끝 -->

			</form:form> 
				
			<!-- 작업목록 시작  -->
			<p class="th_stitle mB20">관련 작업 <img class="btn_arrow_down cursorPointer toggleB" id="taskTB"/></p>
			<div id="taskD">
		    	<form name="taskFrm" id="taskFrm" method="POST" action="" onsubmit="taskSearch(1); return false;">
		    	<input type="hidden" name="pageIndex"/>
				<input type="hidden" name="param_prjId" value="${projectVO.prjId}"/>
				<fieldset>
				<legend>체크</legend>
					<div class="bot_search mT10">
					<ul>
						<li class="Sright">
							하위프로젝트
							<input type="radio" name="includeUnderProject" value="Y" onclick="taskSearch(1);" checked="checked"/> 포함<span class="pL7"></span>
							<input type="radio" name="includeUnderProject" value="N" onclick="taskSearch(1);" /> 미포함
						</li>
					</ul>
					</div>
				</fieldset>
				</form>
				
				<!-- 게시판 시작  -->
				<div id="taskInnerD">
 					<c:import url="${rootPath}/ajax/resultList.do">
 						<c:param name="param_prjId" value="${projectVO.prjId}"/>
						<c:param name="includeUnderProject" value="N"/>
						<c:param name="pageIndex" value="1"/>
					</c:import>
				</div>
			</div>	
			<!--// 작업목록  끝  -->

			<form:form commandName="searchProjectChildVO" name="searchProjectChildVO" method="post" enctype="multipart/form-data" >
			<input type="hidden" name ="searchPrntPrjId" value= "${searchProjectChildVO.prjId }"/>
		  
			<!-- 게시판 시작  -->
			<p class="th_stitle pT20">하위프로젝트 
				<c:if test="${user.admin || prjAuth=='Y' || user.isProjectadmin == 'Y' || prjAuth2=='Y'}">
					<a href="/cooperation/writeProject.do?prntPrjId=${projectVO.prjId }&type=S">
						<img src="${imagePath }/btn/btn_add.gif"/>
					</a>
				</c:if>	
			</p>
				
			<!-- 하단 상태체크 시작 -->
			<fieldset>
			<legend>체크</legend>
				<div class="bot_search mT10">
				<ul>
					<li class="Sright">
					진행상태 : 
					<form:checkboxes items="${codeList3}" path="searchStatL" itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/>
					</li>
				</ul>
				</div>
			</fieldset>
			<!-- 하단 상태체크 끝 -->
			</form:form>
			<div class="boardList02 mB20" id="ProjectChildD">
			</div>
			<!--// 게시판  끝  -->
			
			
			<!-- 매출건 시작  -->
			<p class="th_stitle">매출건 <img class="btn_arrow_up cursorPointer toggleB" id="salesTB"/></p>
			<div id="salesD">
				<form name="salesFrm" id="salesFrm" method="POST" action="" onsubmit="salesSearch(1); return false;">
		    	<input type="hidden" name="pageIndex"/>
				<input type="hidden" name="prjId" value="${projectVO.prjId}"/>
				<!-- 게시판 시작  -->
				<div id="salesInnerD">
					<c:import url="${rootPath}/ajax/salesList.do">
						<c:param name="pageIndex" value="1"/>
					</c:import>
				</div>
				</form>
			</div>
			<!--// 매출건  끝  -->
			
			
			<!-- 매입건(사내) 시작  -->
			<p class="th_stitle">매입건(사내) <img class="btn_arrow_up cursorPointer toggleB" id="purchaseInTB"/></p>
			<div id="purchaseInD">
				<!-- 게시판 시작  -->
				<div id="purchaseInInnerD">
					<c:import url="${rootPath}/ajax/purchaseInList.do">
					</c:import>
				</div>
			</div>
			<!--// 매입건(사내) 끝  -->
			
			
			<!-- 매입건(사내) 시작  -->
			<p class="th_stitle">매입건(사외) <img class="btn_arrow_up cursorPointer toggleB" id="purchaseOutTB"/></p>
			<div id="purchaseOutD">
				<!-- 게시판 시작  -->
				<div id="purchaseOutInnerD">
					<c:import url="${rootPath}/ajax/purchaseOutList.do">
					</c:import>
				</div>
			</div>
			<!--// 매입건(사외) 끝  -->
			
			
			<!-- 업무연락 시작  -->
			<p class="th_stitle mB20">업무연락 <img class="btn_arrow_down cursorPointer toggleB" id="busiContactTB"/></p>
			<div id="busiContactD">
		    	<form name="busiFrm" id="busiFrm" method="POST" action="" onsubmit="busiSearch(1); return false;">
		    	<input type="hidden" name="pageIndex"/>
		    	<input type="hidden" name="ajax" value="Y"/>
				<input type="hidden" name="searchPrjId" value="${projectVO.prjId}"/>
		    	<input type="hidden" name="interestYn"/>
		    	<input type="hidden" name="bcId"/>
				<fieldset>
				<legend>체크</legend>
					<div class="bot_search mT10">
					<ul>
						<li class="Sright">
							하위프로젝트
							<input type="radio" name="includeUnderProject" value="Y" onclick="busiSearch(1);" checked="checked"/> 포함<span class="pL7"></span>
							<input type="radio" name="includeUnderProject" value="N" onclick="busiSearch(1);" /> 미포함
						</li>
					</ul>
					</div>
				</fieldset>
				</form>
				<!-- 게시판 시작  -->
				<div id="busiContactInnerD">
					<c:import url="${rootPath}/ajax/selectBusinessContactList.do">
						<c:param name="searchPrjId" value="${projectVO.prjId}"/>
						<c:param name="includeUnderProject" value="Y"/>
						<c:param name="ajax" value="Y"/>
					</c:import>
				</div>
			</div>
			<!--// 업무연락  끝  -->
			
			
			<!-- 펀네트회의실 시작  -->
			<p class="th_stitle mB20">펀네트회의실 <img class="btn_arrow_down cursorPointer toggleB" id="meetingTB"/></p>
			<div id="meetingD">
		    	<form name="meetFrm" id="meetFrm" method="POST" action="" onsubmit="meetSearch(1); return false;">
		    	<input type="hidden" name="pageIndex"/>
		    	<input type="hidden" name="ajax" value="Y"/>
				<input type="hidden" name="searchPrjId" value="${projectVO.prjId}"/>
		    	<input type="hidden" name="interestYn"/>
		    	<input type="hidden" name="bcId"/>
				<fieldset>
				<legend>체크</legend>
					<div class="bot_search mT10">
					<ul>
						<li class="Sright">
							하위프로젝트
							<input type="radio" name="includeUnderProject" value="Y" onclick="meetSearch(1);" checked="checked"/> 포함<span class="pL7"></span>
							<input type="radio" name="includeUnderProject" value="N" onclick="meetSearch(1);" /> 미포함
						</li>
					</ul>
					</div>
				</fieldset>
				</form>
				<!-- 게시판 시작  -->
				<div id="meetingRoomInnerD">
					<c:import url="${rootPath}/ajax/selectMeetingRoomList.do">
						<c:param name="searchPrjId" value="${projectVO.prjId}"/>
						<c:param name="includeUnderProject" value="Y"/>
						<c:param name="ajax" value="Y"/>
					</c:import>
				</div>
			</div>
			<!--// 펀네트회의실  끝  -->
			

			<%-- 
			<!-- 매출현황 시작  -->
			<p class="th_stitle">매출현황 <span><img src="${imagePath}/btn/btn_btn_arrow_down.gif"/></span></p>
	    	<form name="busiFrm" id="busiFrm" method="POST" action="" onsubmit="busiSearch(1); return false;">
			<fieldset>
			<legend>체크</legend>
				<div class="bot_search mT10">
				<ul>
					<li class="Sright">
						하위프로젝트
						<input type="radio" name="includeUnderPrj" value="Y" checked="checked"/> 포함<span class="pL7"></span>
						<input type="radio" name="includeUnderPrj" value="N" /> 미포함
					</li>
				</ul>
				</div>
			</fieldset>
	   		</form>
	   		
	   		<!-- 사외매출 시작  -->
			<p class="th_stitle2 mT10">사외매출 <span class="th_plus02">단위 : 천원</span></p>
			<div class="boardList02 mB20">
				<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
				<caption>프로젝트 현황</caption>
				<colgroup>
					<col class="col120" />
					<col width="px"/>
					<col class="col70" />
					<col class="col50" />
					<col class="col50" />
					<col class="col50" />
					<col class="col50" />
					<col class="col50" />
					<col class="col50" />
					<col class="col50" />
					<col class="col35" />
				</colgroup>
				<thead>
					<tr>
						<th>프로젝트</th>
						<th>매출명</th>
						<th>매출일</th>
						<th>총계약금</th>
						<th>당월매출</th>
						<th>사외매입</th>
						<th>사내매입</th>
						<th>매출이익</th>
						<th>이익률</th>
						<th>구분</th>
						<th class="td_last">수정</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<td class="txt_center" colspan="3">합계</td>
						<td class="txt_center">-</td>
						<td class="txt_center">-</td>
						<td class="txt_center">-</td>
						<td class="txt_center">-</td>
						<td class="txt_center">-</td>
						<td class="txt_center">-</td>
						<td class="txt_center">-</td>
						<td class="td_last txt_center">-</td>
					</tr>
				</tfoot>
				<tbody>
					<tr>
						<td class="pL10">
							<span class="txtB_grey">[국방1-4]</span> 국방 SI사업</td>
						<td class="pL10">매출명입니다</td>
						<td class="txt_center">2011-08-01</td>
						<td class="txt_center">10,000</td>
						<td class="txt_center">5,000</td>
						<td class="txt_center">0</td>
						<td class="txt_center">3,000</td>
						<td class="txt_center">2,000</td>
						<td class="txt_center">40.0%</td>
						<td class="txt_center">확정</td>
						<td class="td_last txt_center"><img src="${imagePath}/btn/btn_plus02.gif"/></td>
					</tr>																							
				</tbody>
				</table>
			</div>
			
			<!-- 사내매출 시작  -->
			<p class="th_stitle2 mT10">사내매출 <span class="th_plus02">단위 : 천원</span></p>
			<div class="boardList02 mB20">
				<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
				<caption>프로젝트 현황</caption>
				<colgroup>
					<col class="col70" />
					<col class="col100" />
					<col width="px"/>
					<col class="col100" />
					<col width="px"/>
					<col class="col70" />
				</colgroup>
				<thead>
					<tr>
						<th>매출일</th>
						<th>매입 부서</th>
						<th>매입 프로젝트</th>
						<th>매출부서</th>
						<th>매출 프로젝트</th>
						<th class="td_last">금액</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="txt_center">2011-08-01</td>
						<td class="txt_center">솔루션사업부1</td>
						<td class="pL10">
							<span class="txtB_grey">[솔루션1-4.1]</span> 솔루션 사업</td>
						<td class="txt_center">국방사업부</td>
						<td class="pL10">
							<span class="txtB_grey">[국방-1.2]</span> 국방 프리세일즈</td>
						<td class="td_last txt_center">25,000</td>
					</tr>																							
				</tbody>
				</table>
			</div>
			
			<div class="paginate">
				<a href="#"><img src="${imagePath}/btn/btn_first.gif" alt="처음페이지" /></a>
				<a href="#" class="pR10"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
				 1 2 3 4 5 6 7 8 9 10
				<a href="#" class="pL10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
				<a href="#"><img src="${imagePath}/btn/btn_end.gif" alt="마지막 페이지"></a>
			</div>
			<!--// 매출현황  끝  -->
			
			
			--%>
			
			<!-- 월별실적 시작  -->
			<p class="th_stitle mB20">월별실적  <img class="btn_arrow_down cursorPointer toggleB" id="monthlyReportTB"/></p>
			<div id="monthlyReportD">
				<form name="monthlyReportFrm" id="monthlyReportFrm" action="">
					<input name="saerchDate" type="hidden" value=""/>
					<input name="searchPrjId" type="hidden" value="${projectVO.prjId}"/>
					<input name="searchYear" type="hidden" value=""/>
					<input name="searchCondition" type="hidden" value="3"/>
					<input name="includeCost" type="hidden" value="N"/>
					<input name="includeExp" type="hidden" value="Y"/>
					<fieldset>
					<legend>체크</legend>
						<div class="bot_search mT10 mB20">
						<ul>
							<li class="Sright">
								하위프로젝트
								<input type="radio" name="includeUnderPrj" value="Y" checked="checked"/> 포함<span class="pL7"></span>
								<input type="radio" name="includeUnderPrj" value="N" /> 미포함
							</li>
						</ul>
						</div>
					</fieldset>
				</form>
		   			
				<!-- 게시판 시작  -->
				<p class="th_plus02">단위 : 천원</p>
				<div class="boardList02 mB20" id="monthlyReportInnerD">
				</div>
			</div>
			<!--// 월별실적  끝  -->
			
		</div>
		<!-- E: section -->
	</div>
	<!-- E: center -->				
</body>
</html>
