<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript">
function search() {
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
function detail(userNo) {
	document.frm.searchUserNo.value = userNo;
	document.frm.action = "${rootPath}/member/workStateDetail.do";
	document.frm.submit();
}

function dateSetToday(){
	var year = new Date().getFullYear();
	var month = new Date().getMonth();
	var date = new Date().getDate();
	month = month + 1;
	if ((month + "").length == 1)
		month = "0" + month;
	if ((date + "").length == 1)
		date = "0" + date;	
	var today = year + "" + month + "" + date;
	
	document.frm.searchDateFrom.value = today; 
	document.frm.searchDateTo.value = today;
}

function dateSetInit(){
	var year = new Date().getFullYear();
	var month = new Date().getMonth();
	var date = new Date().getDate();
	month = month + 1;
	if ((month + "").length == 1)
		month = "0" + month;
	if ((date + "").length == 1)
		date = "0" + date;	
	var today = year + "" + month + "" + date;
	var initDay = year + "0101";
	
	document.frm.searchDateFrom.value = initDay; 
	document.frm.searchDateTo.value = today;
}

function dateSetMonth(){
	var from = document.frm.searchDateTo.value;
	lastD = new Date(new Date(from.substring(0,4), from.substring(4,6), 1) - 1).getDate();	 
	from = from.substring(0,6) + "01";
	var to = from.substring(0,6) + lastD;
	
	document.frm.searchDateFrom.value = from; 
	document.frm.searchDateTo.value = to;
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
						<li class="stitle">근태통계</li>
						<li class="navi">홈 > 인사정보 > 근태정보 > 근태통계</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
				
			   		<!-- 상단 검색창 시작 -->
			   		<form name="frm" method="POST" action="${rootPath}/member/workStateStatistic.do" onsubmit="search(); return false;">
					<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
					<input type="hidden" name="searchUserNo" value="0"/>
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
	                		
	                			<span class="button"><input type="button" value="당일" 
	                			onclick="javascript:dateSetToday();" ></span>                			
	                			<span class="button"><input type="button" value="월선택" 
	                			onclick="javascript:dateSetMonth();" ></span>
	                			<span class="button"><input type="button" value="초기화" 
	                			onclick="javascript:dateSetInit();" ></span> 
	                			    
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
						<table border="0" cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>공지사항 보기</caption>
	                    <colgroup>
	                    	<col class="col60" />
	                    	<col class="col80" />
	                    	<col class="col35" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                   	</colgroup>
	                    <thead>
	                    	<tr>
	                    		<th rowspan="2">이름</th>
	                    		<th rowspan="2">소속부서</th>
	                    		<th rowspan="2">근무일수</th>
	                    		<th colspan="5">부재일수</th>
	                    		<th colspan="3">면제일수</th>
	                    		<th rowspan="2">유효일수</th>
	                    		<th colspan="3">출근일수</th>
	                    		<th rowspan="2">지각일수</th>
	                    		<th rowspan="2" class="td_last">지각율</th>
	                    	</tr>
	                    	<tr>
	                    		<th>휴가</th>
	                    		<th>출장</th>
	                    		<th>파견</th>
	                    		<th>외근</th>
	                    		<th>소계</th>
	                    		<th>전일야근</th>
	                    		<th>기타</th>
	                    		<th>소계</th>
	                    		<th>조기출근</th>
	                    		<th>정상출근</th>
	                    		<th>소계</th>
	                    	</tr>
	                    </thead>
	                    <tbody>
	                    	<c:forEach items="${resultList}" var="result">
		                    	<tr>
			                    	<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
			                    	<td class="txt_center">${result.orgnztNm}</td>
			                    	<td class="bG txt_center"><a href="${rootPath}/member/workStateDetail.do?searchUserNo=${result.userNo}">${result.dateCnt}</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/workStateDetail.do?searchUserNo=${result.userNo}">${result.vac}</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/workStateDetail.do?searchUserNo=${result.userNo}">${result.bizTrip}</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/workStateDetail.do?searchUserNo=${result.userNo}">${result.send}</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/workStateDetail.do?searchUserNo=${result.userNo}">${result.workOut}</a></td>
			                    	<td class="bG02 txt_center"><a href="${rootPath}/member/workStateDetail.do?searchUserNo=${result.userNo}">${result.abs}</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/workStateDetail.do?searchUserNo=${result.userNo}">${result.night}</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/workStateDetail.do?searchUserNo=${result.userNo}">${result.etc}</a></td>
			                    	<td class="bG02 txt_center"><a href="${rootPath}/member/workStateDetail.do?searchUserNo=${result.userNo}">${result.exception}</a></td>
			                    	<td class="bG txt_center"><a href="${rootPath}/member/workStateDetail.do?searchUserNo=${result.userNo}">${result.valid}</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/workStateDetail.do?searchUserNo=${result.userNo}">${result.earlyAtnd}</a></td>
			                    	<td class="txt_center"><a href="${rootPath}/member/workStateDetail.do?searchUserNo=${result.userNo}">${result.atnd}</a></td>
			                    	<td class="bG02 txt_center"><a href="${rootPath}/member/workStateDetail.do?searchUserNo=${result.userNo}">${result.attend}</a></td>
			                    	<td class="bG txt_center"><a href="${rootPath}/member/workStateDetail.do?searchUserNo=${result.userNo}">${result.late}</td>
			                    	<td class="bG txt_center td_last">${result.latePercent}%</td>
		                    	</tr>
	                    	</c:forEach>
	                    </tbody>
	                    <tfoot>
	                    	<tr>
		                    	<td class="T13B txt_center" colspan="2">종합</td>
		                    	<td class="bG txt_center">${resultSum.dateCnt}</td>
		                    	<td class="txt_center">${resultSum.vac}</td>
		                    	<td class="txt_center">${resultSum.bizTrip}</td>
		                    	<td class="txt_center">${resultSum.send}</td>
		                    	<td class="txt_center">${resultSum.workOut}</td>
		                    	<td class="bG02 txt_center">${resultSum.abs}</td>
		                    	<td class="txt_center">${resultSum.night}</td>
		                    	<td class="txt_center">${resultSum.etc}</td>
		                    	<td class="bG02 txt_center">${resultSum.exception}</td>
		                    	<td class="bG txt_center">${resultSum.valid}</td>
		                    	<td class="txt_center">${resultSum.earlyAtnd}</td>
		                    	<td class="txt_center">${resultSum.atnd}</td>
		                    	<td class="bG02 txt_center">${resultSum.attend}</td>
		                    	<td class="bG txt_center">${resultSum.late}</td>
		                    	<td class="bG txt_center td_last">${resultSum.latePercent}%</td>
	                    	</tr>
	                    </tfoot>
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
