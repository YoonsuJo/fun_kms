<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>FUNNET KMS 시스템</title>
<link rel="stylesheet" href="/common/css/default.css" type="text/css" media="all" />
<script language="javascript">
function fncGoAfterErrorPage(){
    history.back(-2);
}
</script>
</head>

<body>
<div class="errorBg">
	<ul>
		<li class="mB20">수행중 오류가 발생하였습니다.</li>
		<li><a href="javascript:fncGoAfterErrorPage();"><img src="/images/egovframework/cmm/go_history.jpg" border="0"/></a></li>
	</ul>
</div>
</body>
</html>
