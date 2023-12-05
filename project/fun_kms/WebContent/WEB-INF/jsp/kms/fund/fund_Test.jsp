<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>

<style>
	body{
		font-size:9pt;
		font-family:"굴림";
	}
	div, p, ul, li {
		border:1px #eeeeee solid;
		margin:10px;
	}
	ul {
		padding:10px;
	}
	li.select {
		backhground-color:#ccc;
	}
</style>
</head>

<script>
$(document).ready(function() {
	$('#push').click(function() {
		$(this).html("버튼클릭");
	})
	
});

function ClickButton() {
/* 	var $liList = $("ul.menu li");
	$liList.each(function(index) {
		console.log("index : " + index);
	});
 */

}

</script>


<body>
	<div id="samplePage" class="page">
		샘플 페이지(div, id=samplePage, class=page)
		<div id="header">
			헤더 영역(div, id=header)
		</div>
		<div id="content" class="sample-content">
			노드 찾기(div, id=content, class=sample=content)
			<ul class="menu">
				일반 노드 찾기(ul, class=menu)
				<li>id로 찾기(li)</li>
				<li class="select">tag로 찾기(li, class=select)</li>
				<li>class로 찾기(li)</li>
				<li class="test1">속성으로 찾기(li, class=test1)</li>
			</ul>
			<div class="content-date">
				자식 노드 찾기(div, class=content-data)
				<p class="test1">1. 모든 자식 노드 찾기(p, class=test1)</p>
				<p>2. 특정 자식 노드만 찾기(p)</p>
				<p class="test2">3. 마지막 자식 노드 찾기(p, class=test2)</p>
			</div>
		</div>
		<div>
			푸터 영역(div, id=footer)
		</div>
	</div>
	<button id="push" onClick="javascript:ClickButton();">버튼</button>
</body>
</html>
