<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
 /**
  * @Class Name : mainBoardMaster.jsp
  * @Description : 게시판 관리자 메인페이지
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.04.08   이삼섭          최초 생성
  *
  *  @author 양진환
  *  @since 2011.06.23
  *  @version 1.0 
  *  @see
  *  
  */
%>

	<div class="bbsMasterMainLeft">
		this is left
		
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<ul class="bbsList">
				<li class="bbsElem">
					<a href="<c:url value='/cop/bbs/selectBoardList.do'/>?bbsId=<c:out value='${result.bbsId}'/>"; onclick="event(this.href); return false;">
						<c:out value="${result.bbsNm}"/>
					</a>
				</li>
			</ul>	
		</c:forEach>
	</div>
		

