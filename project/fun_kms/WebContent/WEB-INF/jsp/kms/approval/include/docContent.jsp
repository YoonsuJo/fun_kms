<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  문서 종류별 include -->

<c:if test="${appTyp.templtId>=20}">
	<script type="text/javascript" src="<c:url value='${commonPath}/js/approval${appTyp.templtId}.jquery.js'/>" ></script>
</c:if>

<jsp:include page="${jspPath}/approval/include/commonViewTop.jsp"></jsp:include>

<c:if test="${commonDoc.reWriteTyp!=0}">
	<jsp:include page="${jspPath}/approval/include/reWriteInform2.jsp"></jsp:include>
</c:if>

<c:if test="${suspensionTyp>0}">
	<jsp:include page="${jspPath}/approval/include/suspension.jsp"></jsp:include>
</c:if>

<!--2013-06-05 사장님 지시로 기안내용을 세부내용 앞으로 이동-->
<jsp:include page="${jspPath}/approval/include/commonViewBottom.jsp"></jsp:include>

<c:if test="${appTyp.templtId != 1}">
	<p class="th_stitle mB10">세부내용</p>
	<form:form commandName="specificVO" id="specificVOView" name="specificVOView" method="post" enctype="multipart/form-data" >
		<jsp:include page="${jspPath}/approval/include/view${appTyp.templtId}.jsp"></jsp:include>
	</form:form>
</c:if>
<!--2013-06-05 기안내용이 기존에 있던 위치-->

<c:if test="${commentView!='N'}">	
	<div id="approvalCommentView"" class="boardList mB20">
		<jsp:include page="${jspPath}/approval/include/commentView.jsp"></jsp:include>
	</div>	
	<jsp:include page="${jspPath}/approval/include/commentWrite.jsp"></jsp:include>	
</c:if>
<!-- 공통부분 하단 -->

							
							
							