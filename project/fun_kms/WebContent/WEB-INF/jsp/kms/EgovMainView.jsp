<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<c:import url="/common.jsp" />
<link rel="stylesheet" href="/css/egovframework/sym/mpm/mpm.css" type="text/css">
<title>도사 프레임워크 테스트 메인 페이지 </title>
<script language="javascript" src="/js/egovframework/main.js"></script>
<script language="javascript">
function chk_all(val) {
	
	var arr_chk = document.getElementsByName("chk");
	
		if (val == "Y") {
		
			for(i=0;i< arr_chk.length; i++) {
				arr_chk[i].checked =true;
			}
		}
		else if(val == "N") {
			for(i=0;i< arr_chk.length; i++) {
				arr_chk[i].checked =false;
			}
		}
}
</script>
</head>

<body topmargin="0" leftmargin="0">
<c:import url="./commonHeader.jsp" />
<c:import url="./commonLeftMenu.jsp" />
<div class="commonCenter">
중앙이당
</div>
<!-- 배너추가 -->    
<table border="0" cellspacing="0" cellpadding="0" width="900">
  <tr>
    <td align="center">
        <table border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td align="center">
                <c:import url="/uss/ion/bnr/getBannerImage.do" charEncoding="utf-8">
                    <c:param name="atchFileId" value="${banner.bannerImageFile}" />
                </c:import>
            </td>
          </tr>  
        </table>        
    </td>
  </tr>
</table>
<!-- 배너추가 -->     

<!-- bottom -->
<c:import url="./main_bottom.jsp" />
</div>
</body>
</html>