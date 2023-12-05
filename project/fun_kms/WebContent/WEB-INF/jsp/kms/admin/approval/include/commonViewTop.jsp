<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../include/ajax_inc.jsp"%>
<p class="th_stitle mB10">결재정보</p>
<!-- 게시판 시작  -->
<div class="boardWrite02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
                <caption>공지사항 보기</caption>
                <colgroup><col class="col120" /><col width="px" /></colgroup>
                <tbody>
                	<tr>
                 	<td class="title">문서종류</td>
                 	<td class="pL10">${appTyp.docSj}</td>
                	</tr>
                	<tr>
                 	<td class="title">제목</td>
                 	<td class="pL10">${commonDoc.subject}</td>
                	</tr>
					<tr>
                 	<td class="title">기안자</td>
                 	<td class="pL10">
                 		<c:forEach var="writer" items="${writerList}" varStatus="status">
						<print:user userNo="${writer.readerNo}" userNm="${writer.readerNm}"/> (${writer.srchDt}
						<c:choose>
							<c:when test="${commonDoc.docStat=='APP000'}">
								<span class="txtS_blue">저장</span>)	
							</c:when>
							<c:otherwise>
								<span class="txtS_red">기안</span>)
							</c:otherwise>
						</c:choose> 
						
				</c:forEach>	
                 	</td>
                	</tr>		                    	
                	<tr>
                 	<td class="title">검토자</td>
                 	<td class="pL10">
	                 	<c:forEach var="reader" items="${reviewerList}" varStatus="status">
						 	<print:user userNo="${reader.readerNo}" userNm="${reader.readerNm}"/>
						 	<c:choose>
							    <c:when test="${0== reader.stat}">
							       	 <span class="txtS_yellow"> 미결재 </span>
							    </c:when>
							     <c:when test="${1== reader.stat}">
							       	 (<print:date date="${reader.appDt}" printMin="Y"/> <span class="txtS_blue">승인</span>)
							    </c:when>
							    <c:otherwise>
							        (<print:date date="${reader.appDt}" printMin="Y"/> 반려)      
							    </c:otherwise>
							</c:choose>	 	
						</c:forEach>				
					</td>
                	</tr>
                	<tr>
	                 	<td class="title">협조자</td>
	                 	<td class="pL10">
                 		<c:forEach var="reader" items="${cooperatorList}" varStatus="status">
						 	<print:user userNo="${reader.readerNo}" userNm="${reader.readerNm}"/>
						 	<c:choose>
							    <c:when test="${0== reader.stat}">
							       	 <span class="txtS_yellow"> 미결재 </span>
							    </c:when>
							     <c:when test="${1== reader.stat}">
							       	 (<print:date date="${reader.appDt}" printMin="Y"/>  <span class="txtS_blue">승인</span>)
							    </c:when>
							    <c:otherwise>
							        (<print:date date="${reader.appDt}" printMin="Y"/> 반려)      
							    </c:otherwise>
							</c:choose>	 	
						</c:forEach>
						</td>
                	</tr>
                	<tr>
                 	<td class="title">전결자</td>
                 	<td class="pL10"> 
                 	<c:forEach var="reader" items="${deciderList}" varStatus="status">
						 	<print:user userNo="${reader.readerNo}" userNm="${reader.readerNm}"/>
						 	<c:choose>
							    <c:when test="${0== reader.stat}">
							       	 <span class="txtS_yellow"> 미결재 </span>
							    </c:when>
							     <c:when test="${1== reader.stat}">
							       	 (<print:date date="${reader.appDt}" printMin="Y"/>  <span class="txtS_blue">승인</span>)
							    </c:when>
							    <c:otherwise>
							        (<print:date date="${reader.appDt}" printMin="Y"/> 반려)      
							    </c:otherwise>
							</c:choose>	 	
					</c:forEach>
					</td>
                	</tr>
                	<tr>
                 	<td class="title">참조자</td>
                 	<td class="pL10"><print:date date="${reader.appDt}" printMin="Y"/>
                 	<c:forEach var="reader" items="${referencerList}" varStatus="status">
						 	<print:user userNo="${reader.readerNo}" userNm="${reader.readerNm}"/>
						 	<c:choose>
							    <c:when test="${0== reader.stat}">
							       	 <span class="txtS_yellow"> 미결재 </span>
							    </c:when>
							     <c:when test="${1== reader.stat}">
							       	 (<print:date date="${reader.appDt}" printMin="Y"/>  <span class="txtS_blue">승인</span>)
							    </c:when>
							    <c:otherwise>
							        (<print:date date="${reader.appDt}" printMin="Y"/> 반려)      
							    </c:otherwise>
							</c:choose>	 	
						</c:forEach>
					</td>
                	</tr>
                	<c:if test="${commonDoc.docStat=='APP004'||commonDoc.docStat=='APP005'}"></c:if>
					<tr>
	                 	<td class="title">처리담당자</td>
	                 	<td class="pL10">
	                 	<c:forEach var="reader" items="${handlerList}" varStatus="status">
							 	<print:user userNo="${reader.readerNo}" userNm="${reader.readerNm}"/>
							 	<c:choose>
								    <c:when test="${0== reader.stat}">
								       	 <span class="txtS_yellow"> 미처리 </span>
								    </c:when>
								     <c:when test="${1== reader.stat}">
								       	 (<print:date date="${reader.appDt}" printMin="Y"/>  <span class="txtS_blue">처리완료</span>)
								    </c:when>
								    <c:otherwise>
								        (<print:date date="${reader.appDt}" printMin="Y"/> 처리취소)      
								    </c:otherwise>
								</c:choose>	 	
							</c:forEach>
	                 	</td>
                	</tr>
                </tbody>
                </table>
</div>
