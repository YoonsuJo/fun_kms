<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../include/top_inc.jsp"%>

						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>공지사항 보기</caption>	                    
	                    <colgroup>
	                    	<col class="col60" />
	                    	<col class="col100" />
	                    	<col class="col90" />
	                    	<col width="px" />
	                    	<col class="col60" />
	                    	<col class="col60" />
	                    	<col class="col70" />
	                    	<col class="col40" />
                    	</colgroup>
	                    <thead>
	                    	<tr>
	                    		<th>이름</th>
	                    		<th>날짜</th>
	                    		<th>시간</th>
	                    		<th>사유</th>
	                    		<th>등록자</th>
	                    		<th>비고</th>
	                    		<th>등록일시</th>
	                    		<th class="td_last">변경</th>
	                    	</tr>
	                    </thead>
	                    <tbody>
	                    	<c:forEach items="${resultList}" var="result">
		                    	<tr>
			                    	<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>				                    	
			                    	<td class="txt_center">${result.wsBgnDe}</td>
			                    	<td class="txt_center">18:00 ~ ${result.wsBgnTm}:00</td>
			                    	<td class="txt_center"><print:textarea text="${result.wsPurpose}" /></td>
			                    	<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
			                    	<td class="txt_center">				                    	 				                    	 
			                    	 <c:if test="${result.isRegBeforeTen == 'Y'}">10시이전</c:if>
<!--				                    	 <c:if test="${result.isRegBefore == 'Y'}">미리등록</c:if>-->
			                    	 <c:if test="${result.isInnerNetwork == 'N'}">외부등록 </c:if>				                    	 
			                    	</td>				                    	
			                    	<td class="txt_center">${result.regDt}</td>
			                    	<td class="td_last txt_center">
			                    		<a href="javascript:updateOT('${result.wsId}');"><img src="${imagePath}/btn/btn_plus02.gif"/></a>
			                    		<a href="javascript:deleteOT('${result.userNo}','${searchVO.searchMonth}','${result.wsId}');"><img src="${imagePath}/btn/btn_minus02.gif"/></a>
			                    	</td>
		                    	</tr>
	                    	</c:forEach>
	                    	<c:if test="${empty resultList}">
	                    		<tr>
	                    			<td class="txt_center td_last" colspan="6">조회된 데이터가 없습니다.</td>
	                    		</tr>
	                    	</c:if>     
	                    </tbody>
	                    </table>
