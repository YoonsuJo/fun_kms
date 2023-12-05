<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript">
function onLoad() {
	window.print();
	window.close();
}
</script>
</head>

<body onload="onLoad();">
<div id="pop_print">
 	<div id="pop_top">
 	   <ul>
			<li><img src="../images/inc/pop_bullet.gif" /></li>
			<li class="popTitle">사내메일 인쇄</li>
		</ul>
 	</div>
 	
 	<div id="pop_con06">
 		<div class="print_board">
			<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
			<caption>사내메일  인쇄</caption>
			<colgroup>
				<col class="col90" />
				<col width="px" />
				<col class="col90" />
				<col width="px" />
			</colgroup>
			<tbody>
				<tr>
					<td class="title">제목</td>
					<td class="pL10" colspan="3"><c:out value="${result.mailSj}"/></td>
				</tr>
				<tr>
					<td class="title">보낸사람</td>
					<td class="pL10">${result.senderNm}</td>
					<td class="title">송신일시</td>
					<td class="pL10">${result.sendDt}</td>
				</tr>
				<tr>
					<td class="title">받는사람</td>
					<td class="pL10"  colspan="3">
                   		<c:forEach items="${resultList}" var="r" varStatus="c">
                   			<c:if test="${c.count != 1}"> / </c:if>
                   			${r.recieverNm}
                   		</c:forEach>
                   	</td>
				</tr>
				<tr>
					<td class="title">SMS 전송</td>
					<td class="pL10" colspan="3">
						<input type="checkbox" <c:if test="${result.smsSend == 'Y'}">checked="checked"</c:if> disabled="disabled"/>
						문자메시지로 메일 도착을 알려줍니다.
<!--						<c:if test="${result.smsSend == 'F'}"><span class="txt_red">문자전송 실패</span></c:if>-->
	            	</td>
				</tr>
				<tr>
					<td class="title">첨부파일</td>
					<td class="pL10" colspan="3">
						<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${result.atchFileId}" />
						</c:import>
					</td>
				</tr>
				<tr>
					<td class="title">내용</td>
					<td class="pL10 pT5 pB5" colspan="3">
						<c:out value="${result.mailCn}" escapeXml="false"/>
					</td>
				</tr>
			</tbody>
			</table>
 		</div>
 		
 	</div>
</div>

</body>
</html>
