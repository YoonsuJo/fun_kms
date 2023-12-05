<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="print" uri="print" %>


<%
   //치환 변수 선언
    pageContext.setAttribute("cr", "\r"); //Space
    pageContext.setAttribute("cn", "\n"); //Enter
    pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
    pageContext.setAttribute("br", "<br/>"); //br 태그
%>


<link rel="stylesheet" href="${commonPath}/css/style.css" type="text/css" media="all" />
<link rel="stylesheet" href="${commonPath}/css/default.css" type="text/css" media="all" />
<link rel="stylesheet" href="${commonPath}/css/jquery.ui.css" type="text/css" media="all" />
<link rel="stylesheet" type="text/css" href="${commonPath}/css/jquery.checkboxtree.css"/><!-- 체크Tree추가 -->
<link rel="shortcut icon" href="${imagePath}/ico/KMS.ico">
<link rel="icon" href="${imagePath}/ico/KMS.ico" type="image/gif">

<jsp:include page="${commonPath}/jsp/settingGlobalJs.jsp"></jsp:include>
<script type="text/javascript" src="${commonPath}/js/cs_js01.js"></script>
<script type="text/javascript" src="${commonPath}/js/jquery.min.js"></script>
<script type="text/javascript" src="${commonPath}/js/jquery.ui.min.js"></script>
<script type="text/javascript" src="${commonPath}/js/jquery.ui.setting.js"></script>
<script type="text/javascript" src="${commonPath}/js/default.js"></script>
<script type="text/javascript" src="${commonPath}/js/jquery.plugin.js"></script>
<script type="text/javascript" src="${commonPath}/js/jquery.scrollTo-1.4.3.1-min.js"></script>
<script type="text/javascript" src="${commonPath}/js/jsnow.js"></script>

<script type="text/javascript" src="${commonPath}/js/smenu.js"></script>
<script type="text/javascript" src="${commonPath}/js/json2.js"></script>
<jsp:include page="${commonPath}/jsp/commonTimer.jsp"></jsp:include>
<jsp:include page="${commonPath}/jsp/noteTimer.jsp"></jsp:include>
