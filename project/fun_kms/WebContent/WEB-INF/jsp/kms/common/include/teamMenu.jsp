<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

			<c:forEach items="${mVOList}" var="ea" varStatus="s" begin="0" end="19" step="1">		
				<c:if test="${s.count < 21}"> 
					<li id="snbmenu02m${s.count}"><a href="${ea.url}">${ea.title}</a></li>
				</c:if>
			</c:forEach>
			
<script  type="text/javascript">

</script>
			