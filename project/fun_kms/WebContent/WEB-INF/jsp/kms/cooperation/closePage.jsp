<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>Insert title here</title>
<script>

var param_returnUrl = "${param_returnUrl}";

if(param_returnUrl == 'main.do'){
	location.href = '${rootPath}/main.do';
}else if(param_returnUrl != '' && param_returnUrl != null){
	opener.location.href = param_returnUrl;
	self.close();
}else{
	opener.location.reload();
	self.close();
}


</script>
</head>
<body>

</body>
</html>