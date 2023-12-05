<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>

//검색
function search(pageNo) {
	document.frm.pageIndex.value = pageNo;
	document.frm.submit();
}

//고객사관리 상세화면 이동
function view(no) {
	//document.frm.no.value = no;
	//document.frm.action = "${rootPath}/cooperation/selectClient.do";
	//document.frm.submit();
	var popup = window.open("/cooperation/selectClient.do?no="+no,"_POP_CLIENT_","width=580px,height=374px,scrollbars=no");
	popup.focus();
}

//고객사등록 화면 이동
function clientRegister(){
	//document.frm.action = "${rootPath}/cooperation/insertConsultCustomerView.do";
	//document.frm.submit();
	var popup = window.open("/cooperation/writeClient.do?","_POP_CLIENT_","width=580px,height=374px,scrollbars=no");
	popup.focus();
}

//페이지당 출력갯수 선택
function selectPageUnit(cnt) {
	$('input[name=pageUnit]').val(cnt);
	search(1);
}

//상담등록 화면 이동
function consultRegister() {
	document.frm.action = "${rootPath}/cooperation/writeConsultManage.do";
	document.frm.submit();
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
				<div id="center2">
					<div class="path_navi">
						<ul>
							<li class="stitle">고객사관리</li>
							<li class="navi">홈 > 상담관리 > 고객사관리</li>
						</ul>
					</div>
					<br/>
					<span class="mT30 mL20">※ 고객사 정보를 '고객사, 고객명, 연락처, 이메일' 항목을 모두 포함하여 검색하는 화면입니다.</span>
					
				<!-- S: section -->
				<div class="section01">
			    	
			    	<!-- 상단 검색창 시작 -->
			    	<form name="frm" method="POST" action="${rootPath}/cooperation/selectClientList.do" onsubmit="search(1); return false;">
			    	<input type="hidden" name="pageIndex" value="1"/>
			    	<input type="hidden" name="pageUnit" value="${paginationInfo.recordCountPerPage}"/>
			    	<input type="hidden" name="consult_no"/>
			    	<input type="hidden" name="directConsult"/>
			    	<input type="hidden" name="custNm"/>
			    	<input type="hidden" name="custManager"/>
			    	<input type="hidden" name="custTelno"/>
			    	<input type="hidden" name="custEmail"/>
					<fieldset>
					<legend>상단 검색</legend>
						<div class="top_search07 mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<tbody>
							<tr>
								<td class="pT5">
									<span class="mL10">통합검색</span>
									<input type="text" class="span_13 input01" name="searchCust" value="${searchVO.searchCust}"/>
									<%-- <span class="pL7"></span>담당자 <input type="text" class="span_5 input01" name="searchCustManager" value="${searchVO.searchCustManager}"/>--%>
									<%-- 등록자 <input type="text" class="span_5 input01 userNameAuto" name="searchUserMix" id="searchUserMix" value="${searchVO.searchUserMix}"/>
									<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchUserMix',1);">--%>
									<span class="pL15"></span>
									<input type="image" src="${imagePath}/btn/btn_search02.gif" class="fr search_btn02 cursorPointer" alt="검색" onclick="search(1); return false;"/>
								</td>
							</tr>
						</tbody>
						</table>
	                    </div>
	                </fieldset>
	                </form>
                	<!-- 상단 검색창 끝 -->
					
					<!-- 상단 바 시작 -->
					<div class="pB10">
						<select class="select01" onchange="selectPageUnit(this.options[this.selectedIndex].value)">
							<option value="15" <c:if test="${paginationInfo.recordCountPerPage==15}">selected="selected"</c:if> >15줄</option>
							<option value="30" <c:if test="${paginationInfo.recordCountPerPage==30}">selected="selected"</c:if> >30줄</option>
							<option value="50" <c:if test="${paginationInfo.recordCountPerPage==50}">selected="selected"</c:if> >50줄</option>
						</select>
						<span class="txtB_Black">총 : ${paginationInfo.totalRecordCount}건</span>
						<a href="javascript:clientRegister();" class="fr"><img src="${imagePath}/btn/btn_regist.gif"/></a><!--등록버튼  -->
						<a href="javascript:consultRegister();" class="fr"><img src="${imagePath}/btn/btn_goConsul.gif"/></a>
					</div>
					<!-- 상단 바 끝 -->
					
					<!-- 게시판 시작 -->
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="고객사정보 목록입니다.">
						<caption>고객사정보</caption>
						<colgroup>
							<col width="40px" />
							<col width="px" />
							<col width="100px" />
							<col width="150px" />
							<col width="230px" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">번호</th>
							<th scope="col">고객사</th>
							<th scope="col">고객명</th>
							<th scope="col">연락처</th>
							<th scope="col">이메일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/></td>
									<td class="pL10"><a href="javascript:view('${result.no}');">${result.custNm}</a> </td>
									<td class="txt_center">${result.custManager}</td>
									<td class="txt_center">${result.custTelno}</td>
									<td class="txt_center">${result.custEmail}</td>
								</tr>						
							</c:forEach>
						</tbody>
						</table>
					</div>
					<!--// 게시판 끝 -->
					
					<!-- 페이징 시작 -->
					<div class="paginate">
	                	<ui:pagination paginationInfo="${paginationInfo}" jsFunction="search" type="image"/>
					</div>
					<!-- 페이징 끝 -->
					
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
                		<a href="javascript:consultRegister();"><img src="${imagePath}/btn/btn_goConsul.gif"/></a>
                		<a href="javascript:clientRegister()"><img src="${imagePath}/btn/btn_regist.gif"/></a><!--등록버튼  -->
               	    </div>
                 	<!-- 버튼 끝 -->
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
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
