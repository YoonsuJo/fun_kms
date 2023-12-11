<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>

function viewProject(prjId){
	/*
	var form = $('#searchVO');
	form.attr("action", "/cooperation/selectProjectV.do?prjId="+prjId);
	form.submit();
	*/

	var popup = window.open("/cooperation/selectProjectV.do?prjId=" + prjId, '_POP_PROJECT_VIEW' + prjId, '');
	popup.focus();
}
function interest(prjId) {
	var form = $('#searchVO');
	// form.find('[name$=prjId]').val(prjId);
	form.attr("action", "/cooperation/switchPrjInterest.do?prjId=" + prjId);
	form.submit();
}
$(document).ready(function(){
	var form = 	$('#searchVO');
	$('#projectSearchB').click(function(){
		form.attr("action", "/cooperation/selectProjectDetailList.do");
		form.submit();
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
						<c:if test="${searchVO.searchPrjType == 'P'}"><li class="stitle">수행중인 프로젝트 현황</li></c:if>
						<c:if test="${searchVO.searchPrjType == 'S'}"><li class="stitle">진행중인 영업현황</li></c:if>
						<c:if test="${searchVO.searchPrjType == 'B'}"><li class="stitle">진행중인 사업현황</li></c:if>
						<c:if test="${searchVO.searchPrjType == 'P'}"><li class="navi">홈 > 업무공유  > 프로젝트  > 수행중인 프로젝트 현황</li></c:if>
						<c:if test="${searchVO.searchPrjType == 'S'}"><li class="navi">홈 > 업무공유  > 프로젝트  > 진행중인 영업현황</li></c:if>
						<c:if test="${searchVO.searchPrjType == 'B'}"><li class="navi">홈 > 업무공유  > 프로젝트  > 진행중인 사업현황</li></c:if>
					</ul>
				</div>	
				
				
				<!-- S: section -->
				
				<div class="section01">
				<form:form commandName="searchVO" name="searchVO" method="post" enctype="multipart/form-data" >
			    
			    <!-- 상단 검색창 시작 -->
				<fieldset>
				<legend>상단 검색</legend>
                   <div class="top_search07 mB20">
					<table cellpadding="0" cellspacing="0" summary="">
					<caption>상단 검색</caption>
					<colgroup>
						<col width="px" />
						<col width="px" />
					</colgroup>
					<tbody>
						<tr>
							<td>
								진행상태 : <form:checkboxes items="${codeList3}" path="searchStatL" itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/>
							</td>
							<td class="search_right">
								주관부서<span class="pL7"></span>
								<input type="text" class="search_txt02" name="searchOrgnztNm" id="orgNm" value="${searchVO.searchOrgnztNm}" readonly="readonly" onfocus="orgGen('orgNm','orgId',0);"/>
								<img src="${imagePath}/btn/btn_tree.gif" onclick="orgGen('orgNm','orgId',0);" class="cursorPointer"/>
								<input type="hidden" name="searchOrgnztId" id="orgId" value="${searchVO.searchOrgnztId}"/>
		                    	<input name="returnUrl" type="hidden" value="${rootPath}/cooperation/selectProjectList.do" />
		                    	<input name="searchPrjType" type="hidden" value="${searchVO.searchPrjType}" />
								<img src="${imagePath}/btn/btn_search02.gif" id="projectSearchB" class="cursorPointer" alt="검색"/>
							</td>
						</tr>
					</tbody>
					</table>
                   </div>
                     
                </fieldset>
               
                <!-- 상단 검색창 끝 -->
			    
                
	            </form:form>	
	            <!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<table id="projectListT" cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						    <caption>프로젝트 현황</caption>
						    <colgroup>
							    <col class="col110" />
							    <col width="px"/>
							    <col class="col50" />
							    <col class="col50" />
							    <col class="col80" />
							    <c:if test="${searchVO.searchPrjType == 'B' || searchVO.searchPrjType == 'P'}">
							    <col class="col90" />
							    </c:if>
							    <col class="col90" />
						    </colgroup>
						    <thead>
						    	<tr>
						    		<th>주관부서</th>
						    		<th>프로젝트</th>
						    		<th>PL</th>
						    		<th>상태</th>
						    		<c:if test="${searchVO.searchPrjType == 'B' || searchVO.searchPrjType == 'P'}">
						    		<th>종료일</th>
						    		</c:if>
						    		<th>월수익</th>
						    		<th class="td_last">누적수익</th>
						    	</tr>
						    </thead>
						    <tbody>
						    	<c:forEach items="${resultList}" varStatus="status" var="result">
							    							    
						     	<tr>
						     		<td class="hidden" >
								     	<input name="type" type="hidden" value="${result.type }"/>
								     	<input name="prntPrjId" type="hidden" value="${result.prntPrjId }"/>
								     	<input name="prjId" type="hidden" value="${result.prjId }"/>
								     	<input name="prjSn" type="hidden" value="${result.prjSn }"/>
								     	<input name="prjLv" type="hidden" value="${result.prjLv }"/>
								    </td>
								    <c:if test="${result.displayTd == 'Y'}">
							      		<td class="txt_center" rowspan="${result.rowspanCnt}">${result.orgnztNm }</td>
								    </c:if>
							      	<td class="pL10">
							      		<a class="cursorPointer" onclick="viewProject('${result.prjId }');">
							      			<span class="txtB_grey">[${result.prjCd }]</span> ${result.prjNm }
							      		</a>
							      	</td>
							      	<td class="txt_center"><print:user userNo="${result.leaderNo}" userNm="${result.leaderNm}"/></td>
							      	<td class="txt_center">${result.statNm }</td>
							      	<c:if test="${searchVO.searchPrjType == 'B' || searchVO.searchPrjType == 'P'}">
							      	<td class="txt_center">${fn:substring(result.compDueDt,0,4)}-${fn:substring(result.compDueDt,4,6)}-${fn:substring(result.compDueDt,6,8)}</td>
							      	</c:if>
							      	<td class="txt_right pR5">
							      		<c:choose>
						           			<c:when test="${fn:substring(result.busiProf,0,1) == '-'}"><span class="txt_red">${result.busiProf}</span></c:when>
						           			<c:otherwise>${result.busiProf}</c:otherwise>
						           		</c:choose>
							      	</td>
							      	<td class="td_last txt_right pR5">
							      		<c:choose>
						           			<c:when test="${fn:substring(result.busiProfAcc,0,1) == '-'}"><span class="txt_red">${result.busiProfAcc}</span></c:when>
						           			<c:otherwise>${result.busiProfAcc}</c:otherwise>
						           		</c:choose>
							      	</td>
						     	</tr>	 
						    	</c:forEach>                 			                    			                    	
						    </tbody>
						</table>					
					</div>
					
					<!--// 게시판  끝  -->
					
					<!-- 버튼 시작 ${user.admin} ${user.isProjectadmin}
		                <div class="btn_area">
		                	<c:if test="${user.admin == true || user.isProjectadmin == 'Y'}">
								<a href="/cooperation/writeProject.do?type=M">
		                			<img src="${imagePath}/btn/btn_add.gif"/>
		                		</a>
		                	</c:if>
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
