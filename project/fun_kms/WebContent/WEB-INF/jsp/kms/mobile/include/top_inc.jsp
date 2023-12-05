<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="print" uri="print" %>

<html>
<script>
var UserAgent = navigator.userAgent;
var mobileOS = "";
if(navigator.userAgent.match(/iPhone/) != null || navigator.userAgent.match(/iPad/) != null) mobileOS = "IOS";
else if(navigator.userAgent.match(/Android/) != null) mobileOS = "Android";

</script>
<head>
	<title>한마음 시스템 모바일 - 도전하는 사람들</title>	
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<meta name="apple-mobile-web-app-capable" content="yes">

	<jsp:include page="${commonPath}/jsp/settingGlobalJs.jsp"></jsp:include>

	<!-- FAVORITEICON -->
	<link rel="apple-touch-icon" href="${commonMobilePath}/image/touch-icon-iphone.png">
	<link rel="apple-touch-icon" sizes="${commonMobilePath}/image/touch-icon-ipad.png">
	<link rel="apple-touch-icon" sizes="${commonMobilePath}/image/touch-icon-iphone4.png">
	
	<!-- JAVASCRIPT -->
	<script src="http://css3-mediaqueries-js.googlecode.com/files/css3-mediaqueries.js"></script> 
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<script src="${commonMobilePath}/library/jquery.min.js"></script>
	<script src="${commonMobilePath}/library/iscroll.js"></script>
	<script src="${commonMobilePath}/js/userScript.js"></script>
	<script type="text/javascript" src="${commonPath}/js/jquery.min.js"></script>
	<script type="text/javascript" src="${commonPath}/js/jquery.ui.min.js"></script>	
	<script type="text/javascript" src="${commonMobilePath}/js/jquery.ui.setting.js"></script>
	<script type="text/javascript" src="${commonMobilePath}/js/default.js"></script>
	<script type="text/javascript" src="${commonPath}/js/jquery.plugin.js"></script>

	<!-- MEDIA QUERY STYLE SHEETS --> 
	<link rel='stylesheet' href='${commonMobilePath}/style/css/kms.css' />
	<link rel='stylesheet' media='screen and (min-width: 480px) and (max-width: 1024px)' href='${commonMobilePath}/style/css/kms.css' />		
	<link rel='stylesheet' media='screen and (min-width: 1024px)' href='${commonMobilePath}/style/css/kms.css' />

	<jsp:include page="${commonPath}/jsp/commonTimer.jsp"></jsp:include>
	<jsp:include page="${commonPath}/jsp/noteTimer.jsp"></jsp:include>


</head>


<body>
<div id="wrap">	
	<div id="header">
		<div id="nav">
			<c:import url="${rootPath}/mobile/include/getCheckList.do"></c:import>
		</div>
	</div>
	<div id="section">
	<div id="viewarea">
	
	