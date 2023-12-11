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
	
	var popup = window.open("/cooperation/selectProjectV.do?prjId="+prjId,"_POP_PROJECT_VIEW","width=1200px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
	
}

function search(page){
	var form = $('#searchVO');
	
	if(!isNaN(page))
		form.find("input[name='pageIndex']").val(page);
	form.attr("action", "/admin/project/selectProjectList.do");
	form.submit();
	
}
$(document).ready(function(){
	var form = $('#searchVO');
	form.find("input[type=text]").keyup(function(e) {
		//alert(e.keyCode);
		if(e.keyCode == 13) {
			form.submit();
		}
	});
});

var searchRegStDt = "";
var searchRegEnDt = "";
function clickChkboxDate() {
	var allchk = $('#searchAllPeriod');
	
	if (allchk.is(':checked')) {
		searchRegStDt = $('#searchRegStDt').val();
		searchRegEnDt = $('#searchRegEnDt').val();
		$('#searchRegStDt').val('');
		$('#searchRegEnDt').val('');
	} else {
		$('#searchRegStDt').val(searchRegStDt);
		$('#searchRegEnDt').val(searchRegEnDt);
	}
}
</script>
</head>

<body>

<div id="admin_wrap">
	<!-- S: container -->
	<div id="admin_container">
		<ul class="admin_container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="admin_contents2">
		<%@ include file="../left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center2">
					<div class="path_navi">
						<ul>
							<li class="stitle">프로젝트 검색</li>
							<li class="navi">홈 > 업무공유  > 프로젝트  > 프로젝트 검색</li>
						</ul>
					</div>	
					
					
					<!-- S: section -->
					<div class="section01">
					<form:form commandName="searchVO" name="searchVO" method="post" enctype="multipart/form-data" >
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
						<input name="initFlag" type="hidden" value="Y"/>
				    <!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<colgroup>
								<col width="119px"/>
								<col width="23%" />
								<col class="col100" />
								<col width="23%" />
								<col class="col100" />
								<col width="23%" />
							</colgroup>
							<tbody>
								<tr>
									<td class="search_right">생성/수정일</td>
									<td colspan="5">
										<input type="text" name="searchRegStDt" id="searchRegStDt" class="span_3 calGen" value="${searchVO.searchRegStDt}"/> ~
	                   					<input type="text" name="searchRegEnDt" id="searchRegEnDt" class="span_3 calGen" value="${searchVO.searchRegEnDt}"/>
	                   					<label><input type="checkbox" title="전체기간" name="searchAllPeriod" id="searchAllPeriod" onclick="clickChkboxDate();" 
	                   						<c:if test="!empty ${searchVO.searchRegStDt} && !empty ${searchVO.searchRegEnDt}">checked="checked"</c:if> /> 전체</label>	
	                   				</td>
								</tr>
								<tr>
									<td class="search_right">프로젝트</td>
									<td><form:input path="searchPrjNm" cssClass="search_txt05 w87"/></td>
									<td class="search_right">투입인력</td>
									<td><form:input path="searchUserInputMix" cssClass="search_txt05 userNameAuto w87"/></td>
									<td class="search_right">PL</td>
									<td><form:input path="searchLeaderMix" cssClass="search_txt05 userNameAuto w87"/></td>
								</tr>
								<tr>
									<td class="search_right">주관부서</td>
									<td colspan="5">
										<div style="float:left;width:50%;">
											<form:input path="searchOrgnztNm" readonly="true" size="40" cssClass="search_txt05 w87" onclick="orgGen('searchOrgnztNm','searchOrgnztId',2);"/>
											<img src="${imagePath}/btn/btn_tree.gif" onclick="orgGen('searchOrgnztNm','searchOrgnztId',2);" class="cursorPointer" />
				                    	</div>
				                    	
				                    	<div style="float:left;width:300px;">
		
					                    	<form:hidden path="searchOrgnztId"/>
				                    		<input name="returnUrl" type="hidden" value="${rootPath}/admin/project/selectProjectList.do" />
				                    		
											진행상태 : 
											<form:checkboxes items="${codeList3}" path="searchStatL" itemLabel="codeNm" delimiter="&nbsp;" itemValue="code"/>
											<img src="${imagePath}/btn/btn_search02.gif" alt="검색" class="cursorPointer" onclick="search();"/>
										</div>
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
							<jsp:include page="${jspPath}/cooperation/include/projectListTable.jsp"></jsp:include>
						</div>
						
						<!--// 게시판  끝  -->
		            	
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
<%@ include file="../include/admin_footer.jsp"%>
</div>
</body>
</html>
					