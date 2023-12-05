<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>한마음 시스템</title>
</head>
<body>
<form name="frm" action="${rootPath}/management/monthResultStatistic.do" method="POST">
	<input type="hidden" name="searchYear" value="${year}"/>
	<input type="hidden" name="searchMonth" value="${month}"/>
</form>
<script type="text/javascript">
	alert("실적자료 프로젝트 시작일 종료일 전체 업데이트가 성공적으로 완료되었습니다.");
	document.frm.submit();
</script>
</body>
</html>