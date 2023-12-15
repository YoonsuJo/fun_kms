<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html xmlns="http://www.w3.org/TR/REC-html40">
<head>
<meta name="ProgId" content="Excel.Sheet">
<meta name="Generator" content="Microsoft Excel 11">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="print" uri="print" %>
<style>
table {
	width:100%; 
	border-top:1px solid #d0d7e5; 
	border-left:1px solid #d0d7e5;
	font-family:"돋움" , doutm, tahoma, helvetica; 
	font-size:12px; 
	color:#444; 
	text-align:center;
	}
th {
	border-bottom:1px solid #d0d7e5; 
	border-right:1px solid #d0d7e5;
	background-color:#ebf0f6;
	height:26px;
	}
td {
	border-bottom:1px solid #d0d7e5;
	border-right:1px solid #d0d7e5; 
	height:26px;
	}
</style>
</head>
<body>
<table cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<th>이름</th>
			<c:forEach items="${dateList}" var="date">
			<th><print:date date="${date}"/></th>
			</c:forEach>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="result">
		<tr>
			<td>${result.userNm}</td>
			<c:forEach items="${dateList}" var="date">
			<td>${result[date]}</td>
			</c:forEach>
		</tr>
		</c:forEach>
	</tbody>
</table>
</body>
</html>