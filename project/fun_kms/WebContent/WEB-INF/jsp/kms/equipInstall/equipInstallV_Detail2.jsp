<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
$(function(){
	$('#btn_close').click(function(){
		self.close();
	});
});
</script>
</head>

<body>
<div id="pop_regist02">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
			<li class="popTitle">작업 진행내역</li>
		</ul>
 	</div>
 	<div class="pop_con08">
 		
       	<p class="th_stitle">진행내역	</p>
		<div class="boardView">
			<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	        <caption>솔루션 장비 납품 설치요청 접수</caption>
                    
            <colgroup>
	            <col class="col100" />
	            <col class="col100" />
	            <col class="col140" />
	            <col class="col100" />
            </colgroup>
            <thead>
	           	<tr>
	                <th class="write_info">구분</th>
	                <th class="write_info2" colspan="2">
	               		<c:choose>
		               	<c:when test="${element.gubunCd == '1'}">
		                <input type="radio"checked="checked" disabled="disabled"/>접수
		                <input type="radio" disabled="disabled"/>완료
		                <input type="radio" disabled="disabled"/>재요청
		                </c:when>
		                <c:when test="${element.gubunCd == '2'}">
		                <input type="radio" disabled="disabled"/>접수
		                <input type="radio" checked="checked" disabled="disabled"/>완료
		                <input type="radio" disabled="disabled"/>재요청
		                </c:when>
		                <c:when test="${element.gubunCd == '3'}">
		                <input type="radio" disabled="disabled"/>접수
		                <input type="radio" disabled="disabled"/>완료
		                <input type="radio" checked="checked" disabled="disabled"/>재요청
		                </c:when>
		                </c:choose>
					</th>
		            <th class="write_info">완료(예정)일</th>
		        	<th class="write_info2">
		        		${element.completeDate}
		        	</th>
	            </tr>
	            <tr>
	               	<th class="write_info">내용</th>
	               	<th class="write_info2" colspan="4">
	               		${element.content}
	            </th>
	        </tr>
	        <tr>
	        	<th class="write_info">첨부파일</th>
	            <th class="write_info2" colspan="5">
				<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
					<c:param name="param_atchFileId" value="${element.atchFileId}" />
				</c:import>
				</th>
	        </tr>
        </thead>
        <tbody>
        </tbody>
        </table>
        <br><br>
        
           	<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
			<caption>수정 내역</caption>
			<colgroup>
				<col class="col40"/>
				<col class="col140"/>
				<col width="px" />
			</colgroup>
			<thead>
				<tr>
				<th scope="col">번호</th>
				<th scope="col">수정자</th>
				<th scope="col">수정일</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
				<c:when test="${!empty history}">
				<c:forEach items="${history}" var="hlist" varStatus="index">
				<tr>
					<td style="text-align:center;">${index.count}</td>
					<td style="text-align:center;">${hlist.chgId}</td>
					<td style="text-align:center;">
						${hlist.chgDate }
					</td>
				</tr>
				</c:forEach>
				</c:when>
				<c:otherwise>
				<tr>
					<td style="text-align:center;" colspan="3">
						Data Not Found
					</td>
				</tr>
				</c:otherwise>
				</c:choose>
			</tbody>
			</table>
		</div>
	</div>
	<!-- E: section -->
	<div class="pop_btn_area04">
		<img src="${imagePath}/btn/btn_close.gif" id="btn_close"/>
	</div>
</div>
		
</body>
</html>