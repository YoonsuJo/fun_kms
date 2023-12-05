<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<!--  문서 종류별 include -->
<c:if test="${appTyp.templtId>=20}">
	<script type="text/javascript" src="<c:url value='${commonPath}/js/approval${appTyp.templtId}.jquery.js'/>" ></script>
</c:if>
<body><div id="pop_print">
 	<div id="pop_top02">
 	   <ul>
			<li><img src="${imagePath}/inc/pop_bullet02.gif" /></li>
			<li>결재문서 인쇄</li>
		</ul>
 	</div>
 	
 	<div id="pop_Pcon">
 		<div class="print_board">
			<span class="th_stitle_print mB10">${appTyp.docSj} </span>
			<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
			<caption>전자결재</caption>
			<colgroup>
				<col class="col90" />
				<col width="px" />
				<col class="col90" />
				<col width="px" />
			</colgroup>
			<tbody>
				<tr>
					<td class="title">제목</td>
					<td class="pL10" colspan="3">${commonDoc.subject }
					<c:if test="${commonDoc.docStat=='APP000'}">
						<span class="txtS_blue">(저장문서)</span>	
					</c:if>
					</td>
				</tr>
				<tr>
					<td class="title">문서번호</td>
					<td class="pL10">${commonDoc.docId }</td>
					<td class="title">검토자</td>
					<td class="pL10">
						<c:forEach var="reader" items="${reviewerList}" varStatus="status">
							${reader.readerNm} <span>(서명)</span>
						</c:forEach>	
					</td>
				</tr>
				<tr>
					<td class="title">기안일</td>
					<td class="pL10"><print:date date="${commonDoc.writeDt}" printMin="Y"/> </td>
					<td class="title">협조자</td>
					<td class="pL10">
						<c:forEach var="reader" items="${cooperatorList}" varStatus="status">
								${reader.readerNm} <span>(서명)</span>
						</c:forEach>
					</td>	
				</tr>
				<tr>
					<td class="title">기안자</td>
					<td class="pL10">
						<c:forEach var="writer" items="${writerList}" varStatus="status">
							${writer.readerNm} <span>(서명)</span>
						</c:forEach>	
					</td>
					<td class="title">전결자</td>
					<td class="pL10">
						<c:forEach var="reader" items="${deciderList}" varStatus="status">
								${reader.readerNm} <span>(서명)</span>
						</c:forEach>
					</td>
				</tr>
			</tbody>
			</table>
			
			<c:if test="${commonDoc.reWriteTyp!=0}">
				<jsp:include page="${jspPath}/approval/include/reWriteInform2.jsp"></jsp:include>
			</c:if>
			
			<c:if test="${suspensionTyp>0}">
				<jsp:include page="${jspPath}/approval/include/suspension.jsp"></jsp:include>
			</c:if>
			
			<p class="mB10"></p>
			<p class="th_stitle_print mB10">세부내용</p>
			
			<form:form commandName="specificVO" id="specificVOView" name="specificVOView" method="post" enctype="multipart/form-data" >
				<jsp:include page="${jspPath}/approval/include/view${appTyp.templtId}.jsp"></jsp:include>
			</form:form>
			<jsp:include page="${jspPath}/approval/include/commonViewBottom.jsp"></jsp:include>
 		</div>
 		
 		<div class="txt_con"></div>
      
 	    
 		
 	</div>
</div>

<script>
$(document).ready(function(){
	window.print();
	//window.close();
});
</script>

</body>
</html>
