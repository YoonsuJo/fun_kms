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
	document.frm.submit();
}
function update(wsId) {
	document.frm.wsId.value = wsId;
	document.frm.action = "${rootPath}/member/updateWorkStateExceptionView.do";
	document.frm.submit();
}
function delExp(wsId) {
	document.frm.wsId.value = wsId;
	document.frm.action = "${rootPath}/member/deleteWorkStateException.do";
	document.frm.submit();
}
function selRadio(n) {
	document.frm.searchCondition[n].checked = true;

	var usrMix = document.getElementById("usrMix");
	var orgNm = document.getElementById("orgNm");
	var usrTree = document.getElementById("usrTree");
	var orgTree = document.getElementById("orgTree");

	if (n == 0) {
		document.frm.searchUserMix.value = "${searchVO.searchUserMix}";
		document.frm.searchOrgNm.value = "";
		document.frm.searchOrgId.value = "";
		usrMix.style.display = "";
		orgNm.style.display = "none";
		usrTree.style.display = "";
		orgTree.style.display = "none";
	}
	else if (n == 1) {
		document.frm.searchUserMix.value = "";
		document.frm.searchOrgNm.value = "${searchVO.searchOrgNm}";
		document.frm.searchOrgId.value = "${searchVO.searchOrgId}";
		usrMix.style.display = "none";
		orgNm.style.display = "";
		usrTree.style.display = "none";
		orgTree.style.display = "";
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
						<li class="stitle">근태 상세 내역</li>
						<li class="navi">홈 > 인사정보 > 근태정보 > 근태상세내역</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
			   		
				 	<!-- 버튼 시작 -->
	                <div class="btn_area02">
	                	<a href="${rootPath}/member/insertWorkStateExceptionView.do"><img src="${imagePath}/btn/btn_exemRegist.gif"/></a>
	                	<a href="javascript:search();"><img src="${imagePath}/btn/btn_workEthicStats.gif"/></a>
	                </div>
	                <!-- 버튼 끝 -->
	                
	                <print:date date="${searchVO.searchDateFrom}"/> ~ <print:date date="${searchVO.searchDateTo}"/> <br/>
			   		<print:user userNo="${resultList[0].userNo}" userNm="${resultList[0].userNm}" userId="${resultList[0].userId}" printId="true"/>
			   		
			   		<a href="${rootPath }/member/workStateDetail.do?searchUserNo=${resultList[0].userNo}&mode=week">
			   		<input type="button" value="1주일"></a>
			   		
			   		<a href="${rootPath }/member/workStateDetail.do?searchUserNo=${resultList[0].userNo}&mode=month">
			   		<input type="button" value="1개월"></a>
			   		
			   		<a href="${rootPath }/member/workStateDetail.do?searchUserNo=${resultList[0].userNo}&mode=year">
			   		<input type="button" value="올해"></a>
			   		
			   		<a href="${rootPath }/member/workStateDetail.do?searchUserNo=${resultList[0].userNo}&mode=lastyear">
			   		<input type="button" value="전년도"></a>
			   					   		
			   		<!-- 상단 검색창 시작 -->
			   		<form name="frm" method="POST" action="${rootPath}/member/workStateStatistic.do" style="display:none;">
						<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
						<input type="hidden" name="wsId" id="wsId" />
					<fieldset>
					<legend>상단 검색</legend>
	                    <div class="scheduleDate mB20">
	                		<ul>
	                		<li class="li_left">
	                			기간 :
	                			<input type="text" class="input01 span_4 calGen" name="searchDateFrom" value="${searchVO.searchDateFrom}"/>
	                			~
	                			<input type="text" class="input01 span_4 calGen" name="searchDateTo" value="${searchVO.searchDateTo}"/>
	                		</li>
	                		<li class="li_right">
	                			<label><input type="radio" class="radio" name="searchCondition" value="0" onclick="selRadio(0);"/> 사용자</label>
								<label><input type="radio" class="radio" name="searchCondition" value="1" onclick="selRadio(1);"/> 부서</label><span class="pL7"></span>
								<input type="text" class="search_txt02 userNameAuto" name="searchUserMix" id="usrMix"/>
								<input type="text" class="search_txt02" name="searchOrgNm" id="orgNm" value="${searchVO.searchOrgNm}" readonly="readonly" onclick="orgGen('orgNm','orgId',0);"/>
								<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" id="usrTree" onclick="usrGen('usrMix',1);"/>
								<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" id="orgTree" onclick="orgGen('orgNm','orgId',0);"/>
								<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색"/>
	                		</li>
	                		</ul>
	                		<script type="text/javascript">selRadio("${searchVO.searchCondition}");</script>
						</div>
	                </fieldset>
			   		</form>
	            	<!--// 상단 검색창 끝 -->

		            <!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>공지사항 보기</caption>
	                    <colgroup>
	                    	<col class="col80" />
	                    	<col class="col80" />
	                    	<col class="col80" />
	                    	<col width="px" />
	                    	<col class="col100" />
	                    	<col class="col40" />
	                   	</colgroup>
	                    <thead>
	                    	<tr>
	                    		<th>날짜</th>
	                    		<th>근태종류</th>
	                    		<th>출근시각</th>
	                    		<th>비고</th>
	                    		<th>IP</th>
	                    		<th class="td_last">&nbsp;</th>
	                    	</tr>
	                    </thead>
	                    <tbody>
	                    	<c:forEach items="${resultList}" var="result">
		                    	<tr>
			                    	<td class="txt_center">${result.attendDtPrint}</td>
			                    	<td class="txt_center">${result.attendCdPrint}</td>
			                    	<td class="txt_center">${result.attendTm}</td>
			                    	<td class="pL10">${result.attendNote}</td>
			                    	<td class="txt_center">${result.attendIp}</td>
			                    	<td class="txt_center td_last">
										<c:if test="${result.attendCd == 'ET' && user.admin}">
			                    			<a href="javascript:update('${result.wsId}')"><img src="${imagePath}/btn/btn_plus02.gif" /></a>
											<a href="javascript:delExp('${result.wsId}')"><img src="${imagePath}/btn/btn_minus02.gif" /></a>
										</c:if>
			                    	</td>
		                    	</tr>
	                    	</c:forEach>
	                    </tbody>
	                    </table>
	                </div>
	            	
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
