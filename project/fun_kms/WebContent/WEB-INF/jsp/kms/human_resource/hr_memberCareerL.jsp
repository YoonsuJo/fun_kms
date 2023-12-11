<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search() {
	var chk = document.frm.workSt;
	if ((chk[0].checked || chk[1].checked) == false) {
		alert("재직자 혹은 퇴직자를 선택해주세요.");
		return;
	}	
	document.frm.submit();
}
function searchAll() {
	document.frm.workSt[0].checked = true;
	document.frm.workSt[1].checked = false;
	document.frm.submit();
}

$(document).ready(function(){
	var form = $('#searchVO');

	$("#chkAll").click(function() {
		var checked_status = this.checked;
			$("input[name=noList]").each(function() {
				this.checked = checked_status;
			});
		});	

});
function view(no) {
	document.frm.no.value = no;
	document.frm.action = "<c:url value='${rootPath}/member/selectMemberCareerList.do'/>";
	document.frm.submit();
}
function write(no){
	document.frm.no.value = no;
	//document.frm.action = "<c:url value='${rootPath}/member/selectCareerChk.do'/>";
	document.frm.action = "<c:url value='${rootPath}/member/updtCareerView.do'/>";
	document.frm.submit();
}
var openedLayerName;
var openLayerBool = "Y";
function hideLayer() {
	$('#'+openedLayerName).dialog( "close" );
	//$('#'+openedLayerName).hide();
}
function fixLayer() {
	openedLayerName = "";
}
function showLayer(layerName, obj) {
	var scrolled = $(window).scrollTop();
	var position = $(obj).offset();
	var left = position.left + 65;
	var top = position.top + 43 - scrolled ;	

	hideLayer();
	openedLayerName = layerName;

	if(openLayerBool=="N"){
		return;
	}
	
	$('#'+layerName).dialog( {	
		height: 147
		,width: 249
		,position : [left, top]
		,closeOnEscape: true 
		,resizable: true
		,draggable: true
		//,modal: true
		,autoOpen: true
		//,beforeClose: function(event, ui) { alert(1);}     
	});
}
function test(){
	//var list = document.getElementsByName("noList");	
	var list = $('input[name=noList]');
	var len = list.length;
	for (var i = 0; i < len; i++) {
		if (list[i].checked == true) {
			var no = list[i].value;
			var popUrl = "${rootPath}/member/selectMemberCareerExcel.do?no=" + no;
			var popOption = "width=700px,height=500px;";			
			var popName = "_POP_MEMBER_CAREER_PRINT_" + no;

			var popup = window.open(popUrl, popName, popOption);			
			popup.focus();			
	  	}
	}	
}
function popPrint() {
	//1개짜리로 길게 만들어주면 좋겠다
	//var list = document.getElementsByName("noList");	
	var list = $('input[name=noList]');
	var len = list.length;
	for (var i = 0; i < len; i++) {
		if (list[i].checked == true) {
			var no = list[i].value;
			var popUrl = "${rootPath}/member/printMemberCareerDetail.do?no=" + no;
			var popOption = "width=700px,height=500px;";			
			var popName = "_POP_MEMBER_CAREER_PRINT_" + no;

			var popup = window.open(popUrl, popName, popOption);			
			popup.focus();
	  	}
	}	
}
function excelDown() {
	var list = $('input[name=noList]');
	var len = list.length;
	for (var i = 0; i < len; i++) {
		if (list[i].checked == true) {
			var no = list[i].value;
			var popUrl = "${rootPath}/member/selectMemberCareerExcel.do?no=" + no;
			var popOption = "width=700px,height=500px;";			
			var popName = "_POP_MEMBER_CAREER_PRINT_" + no;

			var popup = window.open(popUrl, popName, popOption);			
			popup.focus();
	  	}
	}	
}
</script>

</head>

<body>

<div id="wrap">
	<%@ include file="../common/menu/head.jsp"%>
	<%-- S: container --%>
	<div id="container">
		<ul class="container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<%-- S: contents --%>
<!--		<div id="contents">-->
		<div id="contents">
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<%-- S: centerBg --%>
			<div id="center_bg">
			<%-- S: center --%>
				<div id="center2">
					<div class="path_navi">
						<ul>
							<li class="stitle">이력관리 조회</li>
							<li class="navi">홈 > 인사정보 > 사원정보 > 이력관리</li>
						</ul>
					</div>	
					
					<!-- 게시판 시작 -->
					<div id="ajxDiv" class="boardList mB20">
					</div>
					<form name="ajxFrm" method="POST" action="${rootPath}/member/selectMemberCareerList.do" onsubmit="search(); return false;">						
					</form>
						
					<%-- S: section --%>
					<div class="section01">
												
						<!-- 상단 검색창 시작 -->
						<form name="frm" method="POST" action="${rootPath}/member/selectMemberCareerList.do" onsubmit="search(); return false;">
						<input type="hidden" name="no"/>
						<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
						
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
								<table cellpadding="0" cellspacing="0" >
								<caption>상단 검색</caption>
								<tbody>
									<tr>
										<td class="search_right">
											<label>
											<input type="checkbox" name="workSt" value="W,L" <c:if test="${searchVO.working}">checked="checked"</c:if> /> 
											재직자</label>
											<span class="pL7"></span>
											<label>
											<input type="checkbox" name="workSt" value="R" <c:if test="${searchVO.retired}">checked="checked"</c:if> /> 
											퇴직자</label>
											<span class="pL7"></span>
											<label>											
											<input type="checkbox" name="needUpdate" value="Y" <c:if test="${searchVO.needUpdate=='Y'}">checked="checked"</c:if> /> 
											갱신 필요 </label>
											<label>
											<input type="checkbox" name="hasLicense" value="Y" <c:if test="${searchVO.hasLicense=='Y'}">checked="checked"</c:if> />
											자격증 유무</label>
											<span class="pL7"></span>
											
											경력
											<select name="careerFrom" class="span_3">
												<option value="">전체</option>
												<c:forEach var="i" begin="0" end="40">
													<option value="${i}" <c:if test="${i == searchVO.careerFrom}">selected="selected"</c:if> >
													<c:out value="${i}"/></option>
												</c:forEach>
											</select>
											~
											<select name="careerTo" class="span_3">
												<option value="">전체</option>
												<c:forEach var="i" begin="0" end="40">
													<option value="${i}" <c:if test="${i == searchVO.careerTo}">selected="selected"</c:if> >
													<c:out value="${i}"/></option>
												</c:forEach>
											</select>
											직급
											<select name="rankIdFrom" class="span_3">
												<option value="">전체</option>
												<c:forEach items="${rankList}" var="rank">
													<option value="${rank.code}" <c:if test="${rank.code == searchVO.rankIdFrom}">selected="selected"</c:if> >
													<c:out value="${rank.codeNm}"/></option>
												</c:forEach>
											</select>
											~
											<select name="rankIdTo" class="span_3">
												<option value="">전체</option>
												<c:forEach items="${rankList}" var="rank">
													<option value="${rank.code}" <c:if test="${rank.code == searchVO.rankIdTo}">selected="selected"</c:if> >
													<c:out value="${rank.codeNm}"/></option>
												</c:forEach>
											</select>
																						
											SW 기술등급
											<select name="swLevel">
												<option value="" <c:if test="${searchVO.swLevel==''}"> selected="selected"</c:if>> 전체</option>
												<option value="선택없음" <c:if test="${searchVO.swLevel=='선택없음'}"> selected="selected"</c:if>> 선택없음</option>
												<option value="초급기능사" <c:if test="${searchVO.swLevel=='초급기능사'}"> selected="selected"</c:if>> 초급기능사</option>
												<option value="중급기능사" <c:if test="${searchVO.swLevel=='중급기능사'}"> selected="selected"</c:if>>중급기능사</option>
												<option value="고급기능사" <c:if test="${searchVO.swLevel=='고급기능사'}"> selected="selected"</c:if>>고급기능사</option>
												<option value="초급기술자" <c:if test="${searchVO.swLevel=='초급기술자'}"> selected="selected"</c:if>>초급기술자</option>
												<option value="중급기술자" <c:if test="${searchVO.swLevel=='중급기술자'}"> selected="selected"</c:if>>중급기술자</option>
												<option value="고급기술자" <c:if test="${searchVO.swLevel=='고급기술자'}"> selected="selected"</c:if>>고급기술자</option>
												<option value="특급기술자" <c:if test="${searchVO.swLevel=='특급기술자'}"> selected="selected"</c:if>>특급기술자</option>
												<option value="기술사" <c:if test="${searchVO.swLevel=='기술사'}"> selected="selected"</c:if>>기술사</option>
											</select>			
											
											<!-- 검색 버튼 -->											
											<input type="image" src="${imagePath}/admin/btn/btn_search02.gif" />											
										</td>
									</tr>
									<tr>
										<td class="search_right">											
											<span class="pL7"></span>
											보유기술
											<input type="text" name="searchSkill" id="searchSkill" class="search_txt04" value="${searchVO.searchSkill}" />
											자격증
											<input type="text" name="searchLicense" id="searchLicense" class="search_txt04" value="${searchVO.searchLicense}" />
											
											이름
											<input type="text" name="searchUserMix" id="searchUserMix" class="search_txt02 userNamesAuto" value="${searchVO.searchUserMix}"/>
											<img id="usrTree" src="${imagePath}/btn/btn_tree.gif" onclick="usrGen('searchUserMix',0);" class="cursorPointer">
<!--											<input type="text" name="searchUserNm" id="searchUserNm" class="search_txt02 userNameAuto" value="${searchVO.searchUserNm}"/>-->
<!--											<img id="usrTree" src="${imagePath}/btn/btn_tree.gif" onclick="usrGen('searchUserNm',1);" class="cursorPointer">-->
											부서
											<input type="text" name="searchOrgNm" id="orgNm" class="search_txt02" value="${searchVO.searchOrgNm}" onfocus="orgGen('orgNm','orgId',0);" readonly="readonly" style="display:"/>
											<img src="${imagePath}/btn/btn_tree.gif" id="orgTree" class="cursorPointer" onclick="orgGen('orgNm','orgId',0);" style="display:"/>											
<!--											<a href="javascript:searchAll();"><img src="${imagePath}/admin/btn/btn_allview.gif" alt="전체보기"/></a>-->			
											<!-- 전체보기 버튼  -->
											<a href="/member/selectMemberCareerList.do"><img src="${imagePath}/admin/btn/btn_allview.gif" alt="전체보기"/></a>
										</td>
									</tr>
								</tbody>
								</table>
		                    </div>
		                </fieldset>
		                </form>
		                <!-- 상단 검색창 끝 -->
		                
		                <!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<!-- 등록 버튼 -->	                
			                <a href="javascript:write('${user.no }');"><img src="${imagePath}/btn/btn_regist.gif"/></a>
			                <!-- 인쇄 버튼 -->
							<a href="javascript:popPrint();"><img src="${imagePath}/btn/btn_print.gif"/></a>
			                <!-- 엑셀다운 버튼 -->
		                	<c:if test="${user.isHmdev == 'Y'}"></c:if>
                				<a href="javascript:excelDown();"><img src="${imagePath}/btn/btn_excelSave.gif"/></a>                			
		                </div>
		                <!-- 버튼 끝 -->
		                
						<!-- 게시판 시작 -->
						<p class="th_stitle">사원조회 (검색된 사용자 : ${fn:length(resultList)}명)</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>사원조회</caption>
							<colgroup>
								<col class="col20" />
								<col class="col40" />
								<col class="col50" />								
								<col class="col60" />
								<col width="px" />
								<col class="col60" />
<!--								<col class="col90" />-->
								<col class="col80" />
								<col class="col120" />
								<col class="col50" />
<!--								<col class="col80" />-->
								<col class="col80" />
<!--								<col class="col100" />-->
							</colgroup>
							<thead>
								<tr>
									<th scope="col"><input type="checkbox" name="chk" id="chkAll"/></th>
									<th scope="col">번호</th>
									<th scope="col">이름</th>								
									<th scope="col">직급</th>
									<th scope="col">소속부서</th>
									<th scope="col">경력기간</th>
									<th scope="col">SW기술등급</th>
									<th scope="col">자격증</th>
									<th scope="col">연령</th>
									<th scope="col">최종수정일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList}" var="result" varStatus="c">								
									<tr>
										<td class="txt_center"><input type="checkbox" name="noList" value="${result.no}"/></td>		
										<td class="txt_center">
											<a href="${rootPath}/member/selectMemberCareerDetail.do?no=${result.no}">
											${c.count }</a></td>
										<td class="txt_center">
											<print:user userNo="${result.no}" userNm="${result.userNm}"/>
										</td>
										<td class="txt_center">
											<a href="${rootPath}/member/selectMemberCareerDetail.do?no=${result.no}" target="_blank">
											${result.rankNm}</a></td>
										<td class=""txt_left"">
											<a href="${rootPath}/member/selectMemberCareerDetail.do?no=${result.no}" target="_blank">
<!--										${result.orgnztNm}-->
											${result.orgnztNmFull}
										</a></td>
										<td class="txt_center">
											<a href="${rootPath}/member/selectMemberCareerDetail.do?no=${result.no}" target="_blank">
											<c:if test="${result.workMonth==null}">미입력</c:if>
					                    	<c:if test="${result.workMonth!=null}">					                    	
						                    	${result.workYear}년<br/>
				                    			${result.workMonth}개월 
					                    	</c:if>												
				                    		</a></td>
										<td class="txt_center">
											<a href="${rootPath}/member/selectMemberCareerDetail.do?no=${result.no}" target="_blank">
											${result.swLevel}</a></td>
																				
										<td class="txt_center"
										<c:if test="${result.licenseNm != null && fn:length(result.licenseNm) != 0}">
										onmouseover="showLayer('licenseNm${result.no }',this)"	</c:if>					
			                    		onmouseout="hideLayer()" onclick="fixLayer()">
									<!-- a href="${rootPath}/member/selectMemberCareerDetail.do?no=${result.no}" target="_blank"> </a> -->
									<!-- ${result.licenseNm} -->
											${result.licenseNmTop}
										</td>
										
										<td class="txt_center">
											<a href="${rootPath}/member/selectMemberCareerDetail.do?no=${result.no}" target="_blank">
											${result.ageKor}세<br/>(만${result.age}세)</a></td>
										<td class="txt_center">
<!--											<a href="${rootPath}/member/selectMemberCareerDetail.do?no=${result.no}" target="_blank">-->
											<a href="${rootPath}/member/updtCareerView.do?no=${result.no}" target="_blank">
											<c:if test="${result.upDt==null}"><span class="txtB_red">미입력</span></c:if>
					                    	<c:if test="${result.upDt!=null}">
						                    	<c:choose>
													<c:when test="${result.needUpdate == '1'}"><span class="txtB_red">
														${fn:substring(result.upDt,0,4)}.${fn:substring(result.upDt,4,6)}.${fn:substring(result.upDt,6,8)}
														<br/>(갱신)
													</span></c:when>
													<c:when test="${result.blankInfoCount > 0}"><span class="txtB_red">
														${fn:substring(result.upDt,0,4)}.${fn:substring(result.upDt,4,6)}.${fn:substring(result.upDt,6,8)}
														<br/>(누락)
													</span></c:when>
													<c:otherwise>
														${fn:substring(result.upDt,0,4)}.${fn:substring(result.upDt,4,6)}.${fn:substring(result.upDt,6,8)}
													</c:otherwise>
												</c:choose> 
					                    	</c:if>	
										</a></td>									
									</tr>
									<!-- 추가정보 레이어  -->
									<div id="licenseNm${result.no }" style="display:none; z-index:5; ">
										${result.licenseNm}							
									</div>
									<!-- 추가정보 레이어  끝  -->
								</c:forEach>
							</tbody>
							</table>
						</div>
						<!-- 게시판 끝  -->						
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<!-- 등록 버튼 -->	                
			                <a href="javascript:write('${user.no }');"><img src="${imagePath}/btn/btn_regist.gif"/></a>
			                <!-- 인쇄 버튼 -->
							<a href="javascript:popPrint();"><img src="${imagePath}/btn/btn_print.gif"/></a>
			                <!-- 엑셀다운 버튼 -->
		                	<c:if test="${user.isHmdev == 'Y'}"></c:if>
                				<a href="javascript:excelDown();"><img src="${imagePath}/btn/btn_excelSave.gif"/></a>                			
		                </div>
		                <!-- 버튼 끝 -->
		                		                
					</div>
					<%-- E: section --%>
				</div>
			<%-- E: center --%>
			
			</div>	
			<%-- E: centerBg --%>
		</div>
		<%-- E: contents --5>
	</div>
	<%-- E: container --%>
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
