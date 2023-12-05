<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<script type="text/javascript">

//고객사관리 수정화면이동
function modifyArticle(no) {
	document.frm.no.value = no;
	document.frm.action = "<c:url value='${rootPath}/cooperation/modifyClient.do'/>";
	document.frm.submit();		
}
//고객사관리 삭제
function deleteArticle(no) {
	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.no.value = no;
		document.frm.action = "<c:url value='${rootPath}/cooperation/deleteClient.do'/>";
		document.frm.submit();
	}	
}
</script>
<body>
<form name="frm" method="POST" >
<input type="hidden" name="no"/>
</form>
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
							<li class="stitle">업무공유</li>
							<li class="navi">홈 > 업무공유 > 고객사관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						
						<p class="th_stitle">고객사관리</p>
						
						<!-- 고객사관리 게시판 시작  -->
						<div class="boardView">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>고객사관리 상세보기</caption>
		                   <%-- 
		                    <colgroup>
		                    	<col class="col5" />
		                    	<col class="col80" />
		                    	<col class="col120" />
		                    	<col class="col80"  />
		                    	<col width="px" />
		                    	<col class="col80 "  />
		                    	<col class="col120" />
		                    	<col class="col5" />
		                    </colgroup>
		                    --%>
		                    <colgroup>
			                    <col class="col100" />
			                    <col width="px" />
			                    <col class="col100" />
			                    <col width="px" />
		                    </colgroup>
		                    <thead>
		                    	<tr>
			                    	<th class="write_info">고객사</th>
			                    	<th class="write_info2" >${result.custNm}</th>
			                    	<th class="write_info">담당자</th>			                    	
			                    	<th class="write_info2">${result.custManager}</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">연락처</th>
			                    	<th class="write_info2">${result.custTelno}</th>
			                    	<th class="write_info">유형</th>
			                    	<th class="write_info2">			                    		
										<c:forEach items="${rankList}" var="rank">
											<c:if test="${rank.code == result.typ}">
												<c:out value="${rank.codeNm}"/>
											</c:if>												
										</c:forEach>	
			                    	</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">서버정보</th>
			                    	<th class="write_info2" colspan="3">${result.remoteInfo}&nbsp;</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">기타정보</th>
			                    	<th class="write_info2" colspan="3" >${result.etcInfo}&nbsp;</th>
		                        </tr>
		                    </thead>                  
		                   </table>
						</div>					
				
						<!--//고객사관리 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<a href="${rootPath}/cooperation/writeConsultManage.do?directInsert=Y&no=${result.no}"><img src="${imagePath}/btn/btn_Consul02.gif"/></a><!--상담하기 -->		                	
		                	<a href="javascript:modifyArticle('${result.no}');"><img src="${imagePath}/btn/btn_modify.gif"/></a><!--수정  -->
		                	<a href="javascript:deleteArticle('${result.no}');"><img src="${imagePath}/btn/btn_delete.gif"/></a><!--삭제  -->
		                	<a href="${rootPath}/cooperation/selectClientList.do"><img src="${imagePath}/btn/btn_list.gif"/></a><!--목록보기  -->
		                </div>
		                <!-- 버튼 끝 -->
		                <%-- 
		                <p class="th_stitle">탑재정보</p>
		               <!-- 게시판 시작 -->
						<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="고객사정보 목록입니다.">
							<caption>고객사정보</caption>
							<colgroup>
								<col class="col40" />
								<col width="px" />
								<col class="col90" />
								<col class="col90" />
								<col class="col70" />
								<col class="col70" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">번호</th>
								<th scope="col">내용</th>
								<th scope="col">버전</th>
								<th scope="col">작성자</th>
								<th scope="col">탑재일</th>
								<th scope="col">작성일</th>
								</tr>
							</thead>
							<tbody>
								<%--
								<c:forEach items="${resultList}" var="result" varStatus="c">
									<tr>
										<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/></td>
										<td class="pL10"><a href="javascript:view('${result.no}');">${result.custNm}</a> </td>
										<td class="txt_center">${result.custManager}</td>
										<td class="txt_center">${result.custTelno}</td>
										<td class="txt_center">${result.etcInfo}</td>
									</tr>						
								</c:forEach>
								
							</tbody>
							
						</table>
						</div>
						
					<!--// 게시판 끝 -->
					
						<!-- 버튼 시작 -->
		                <div class="btn_area02">		                	
		                	<a href="${rootPath}/cooperation/selectClientRegister.do"><img src="${imagePath}/btn/btn_regist.gif"/></a>
		                </div>
		                <!-- 버튼 끝 -->
						--%>
	
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
