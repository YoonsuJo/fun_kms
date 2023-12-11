<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>

<body>
	<div id="pop_Nmessage">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
			<li class="popTitle">업무연락 열람상태</li>
		</ul>
 	</div>
 	
 	<div id="pop_Ncon"> 		
 		<table cellpadding="0" cellspacing="0">
 			<caption>업무연락 열람상태</caption>
 			<colgroup>
	 			<col class="col40" />
	 			<col class="col60" />
	 			<col class="col60" />
	 			<col width="px" />
 			</colgroup>
 			<thead>
 				 <tr>
					<th scope="col">번호</th>
					<th scope="col">이름</th>
					<th scope="col">구분</th>
					<th scope="col">상태</th>
				</tr> 
 			</thead> 			
			<tbody>
				<c:forEach items="${resultList}" var="result" varStatus="c">
					<tr>
						<td>${c.count}</td>
						<td><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
						<td>${result.recieveTypPrint}</td>
						<td>
							<c:choose>
                   				<c:when	test="${empty result.readtime}"><span class="txt_blue">미열람</span></c:when>
				                <c:otherwise>열람 (${result.readtime})</c:otherwise>
			                </c:choose>
						</td>
					</tr>
				</c:forEach>
			</tbody>
 		</table>
      	
      	<div class="pop_btn_area">
            <img src="${imagePath}/btn/btn_close.gif" alt="창닫기" class="cursorPointer" onclick="window.close();">
        </div>
 	</div>
</div>

</body>
</html>
