<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
 /**
  * @Class Name : mainBoardMaster.jsp
  * @Description : 게시판 관리자 메인페이지
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.04.08   이삼섭          최초 생성
  *
  *  @author 양진환
  *  @since 2011.06.23
  *  @version 1.0 
  *  @see
  *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<c:import url="/common.jsp" />
<link href="<c:url value='/css/egovframework/cop/bbs/com.css' />" rel="stylesheet" type="text/css">
<script type="text/javascript">
	
</script>
<title>게시판 정보</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}


</style>

</head>
<body>
	<div class="bbsMasterMainHead">
		this is head
	</div>
	<c:import url="/cop/bbs/leftMenu.do" />
	
	<div class="bbsMasterMainCenter">
		this is center

	</div>
	<div class="bbsMasterMainRight">
		this is right
	</div>
	<div class="clear">
	</div>
	<div class="bbsMasterMainFooter">
		this is footer
	</div>
	
</body>
</html>