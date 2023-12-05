<%
 /**
  * @Class Name  : OrganL.jsp
  * @Description : OrganList 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2011.09.07   민형식              최초 생성
  *
  *  @author 민형식
  *  @since 2011.09.07
  *  @version 1.0
  *  @see
  *  
  */
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="section01">	
<form name="listForm" action="<c:url value='/admin/organ/OrganList.do'/>" method="post">
					<!-- 상단 검색창 시작 

						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<tbody>
								<tr>
									<td class="txt_center">
										<input type="radio" name="searchCondition" value="1">레벨
									   	<select name="searchKeyword" class="span_4" title="">
											   <option selected value=''><label for="searchKeyword">-선택-</label></option>
											   <option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>><label for="searchKeyword">조직명</label></option>
											   <option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>><label for="searchKeyword">부서장명</label></option>
 									    </select>										
										<span class="pL7"></span>
										<input type="radio" name="searchCondition" value="2">상위조직<span class="pL7"></span>
										<input type="text" name="searchKeyword" class="search_txt02"/>
										<input type="radio" name="searchCondition" checked value="3">조직명
										<input type="text" name="searchKeyword" class="search_txt02" value="${searchVO.searchKeyword}"/>
										<img src="${imagePath}/admin/btn/btn_search02.gif" alt="검색" onclick="fnSearch(); return false;"/>
									</td>
								</tr>
							</tbody>
							</table>
		                    </div>
		                </fieldset>
		                <!-- 상단 검색창 끝 -->
		                
	                
		                
						<!-- 게시판 시작 -->
						<p class="th_stitle">조직목록</p>
						<div class="boardList">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>사원조회</caption>
							<colgroup><col class="col5" /><col class="col90" /><col width="px" /><col class="col100" /><col class="col70" /><col class="col70" /><col class="col90" /><col class="col70" /><col class="col40" /><col class="col20" /><col class="col5" /></colgroup>
							<thead>
								<tr>
								<th class="th_left"></th>
								<th scope="col">선택</th>
								<th scope="col">조직명</th>
								<th scope="col">상위조직</th>
								<th scope="col">조직코드</th>
								<th scope="col">조직레벨</th>
								<th scope="col">사용여부</th>
								</tr>
							</thead> 
							<tbody>
								<c:forEach items="${resultList}" var="result" varStatus="status">							
								<tr  style="cursor:pointer;cursor:hand;"  onclick="javascript:fnSelect('${result.orgnztId}',${result.orgLv});">
									<td class="txt_center" colspan="2"><input type="radio" name="selectedv" /></td>								
									<td class="txt_center" ><c:out value="${result.orgnztNm}"/></td>
									<td class="txt_center" ><c:out value="${result.orgUp}"/></td>
									<td class="txt_center" ><c:out value="${result.orgnztId}"/></td>
									<td class="txt_center" ><c:out value="${result.orgLv}"/></td>
									<td class="txt_center" ><c:if test="${result.useYn == 'Y'}">사용</c:if><c:if test="${result.useYn == 'N'}">미사용</c:if></td>
								</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						<!-- 게시판 끝  -->		                
						<!-- 하단 숫자 시작 -->
						<div class="paginate">
							<c:if test="${fn:length(resultList) == 0}">
								<tr> 
									<td class="lt_text3" colspan=7>
										<spring:message code="common.nodata.msg" />
									</td>
								</tr>   	          				 			   
							</c:if>

							<ui:pagination paginationInfo = "${paginationInfo}"
									type="image"
									jsFunction="linkPage"				/>
						</div>
						<!-- 하단 숫자 끝 -->
	<!-- E: container -->
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>

</form>
					</div>
					<!-- E: section -->	
				</div>
				<!-- E: center -->
			</div>	
			<!-- E: centerBg -->

			
		
			