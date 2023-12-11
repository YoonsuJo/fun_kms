<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
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
			<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
			<li class="popTitle">업무연락 인쇄</li>
		</ul>
 	</div>
 	
 	<div id="pop_con06">
 		<div class="print_board">
			<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
			<caption>전자결재</caption>
			<colgroup><col class="col90" /><col width="px" /><col class="col90" /><col width="px" /></colgroup>
			<tbody>
				<tr>
					<td class="title">제목</td>
					<td class="pL10" colspan="3">${result.bcSj}</td>
				</tr>
				<tr>
					<td class="title">작성자</td>
					<td class="pL10"><print:user userNo="${result.userNo}" userNm="${result.userNm}" userId="${result.userId}" printId="true"/></td>
					<td class="title">작성일시</td>
					<td class="pL10">${result.regDt}</td>
				</tr>
				<tr>
					<td class="title">수신자</td>
					<td class="pL10"  colspan="3">
						<c:forEach items="${result.recieveList}" var="rec" varStatus="c">
                   			<c:if test="${c.count != 1}">,</c:if>
                   			<print:user userNo="${rec.userNo}" userNm="${rec.userNm}"/>(
                   				<c:choose>
	                    			<c:when test="${empty rec.readtime}"><span class="txt_red">미열람</span></c:when>
                    				<c:otherwise>${rec.readtime } <span class="txt_blue">열람</span></c:otherwise>
                   				</c:choose>
                   			)
                   		</c:forEach>
               		</td>
				</tr>
				<tr>
					<td class="title">참조자</td>
					<td class="pL10" colspan="3">
                   		<c:forEach items="${result.referenceList}" var="ref" varStatus="c">
                   			<c:if test="${c.count != 1}">,</c:if>
                   			<print:user userNo="${ref.userNo}" userNm="${ref.userNm}"/>(
                   				<c:choose>
	                    			<c:when test="${empty ref.readtime}"><span class="txt_red">미열람</span></c:when>
                    				<c:otherwise>${ref.readtime } <span class="txt_blue">열람</span></c:otherwise>
                   				</c:choose>
                   			)
                   		</c:forEach>
	            	</td>
				</tr>
				<tr>
					<td class="title">프로젝트</td>
					<td class="pL10" colspan="3">[${result.prjCd}] ${result.prjNm}
	            	</td>
				</tr>
				<tr>
					<td class="title">내용</td>
					<td class="pL10 pT5 pB5" colspan="3">
						<c:out value="${result.bcCn}" escapeXml="false" />
					</td>
				</tr>
			</tbody>
			</table>
 		</div>
 		
 		<c:if test="${printIncComment=='on'}">
	 		<div id="commentArea">
				<c:import url="${rootPath}/cooperation/selectBusinessContactCommentList.do">
					<c:param name="type" value="body" />
					<c:param name="commentNo" value="${comment.no}" />
				</c:import>
			</div>
		</c:if>
 		
 	</div>
</div>

</body>
</html>
