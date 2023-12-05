<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
 /**
  * @Class Name : EgovMainMenuIndex.jsp
  * @Description : MainMenuIndex Page
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.10    이용          최초 생성
  *
  *  @author 공통서비스 개발팀 이용
  *  @since 2009.03.10
  *  @version 1.0
  *  @see
  *  ?vStartP=<c:out value="${result.menuNo}"/> <c:out value="${result.chkURL}"/>
  */

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Menu Index frame</title>
</head>

<frameset rows="122,*,50" frameborder="0" >
	<frame src="/sym/mms/EgovMainMenuHead.do" name="main_top" marginwidth="0" marginheight="0">
	<frameset cols="273,*" frameborder="0">
		<frame src="/sym/mms/EgovMainMenuLeft.do?vStartP=<c:out value="${resultVO.menuNo}"/>" scrolling="no" name="main_left" marginwidth="0" marginheight="0">
		<frame src="/sym/mms/EgovMainMenuRight.do?vStartP=<c:out value="${resultVO.menuNo}"/>" name="main_right" marginwidth="0" marginheight="0">
	</frameset> 
	<frame src="/EgovPageLink.do?link=/main_bottom" scrolling="no" name="main_bottom" marginwidth="0" marginheight="0">
</frameset>
</html>