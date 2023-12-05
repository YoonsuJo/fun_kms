<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel"xmlns="http://www.w3.org/TR/REC-html40">
<head>
<meta name="ProgId" content="Excel.Sheet">
<meta name="Generator" content="Microsoft Excel 11">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="print" uri="print" %>
<style>

</style>
</head>
<body>
	<table border="0" cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<colgroup>
    	<col class="col60" />
    	<col class="col80" />
    	<col class="col35" />
    	<col width="px" />
    	<col width="px" />
    	<col width="px" />
    	<col width="px" />
	</colgroup>
	<thead>
		<tr>
			<th colspan="7">업무일지 작성현황 (기간 : ${searchVO.searchDateFrom } ~ ${searchVO.searchDateTo })</th>
		</tr>
     	<tr>
     		<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;" rowspan="2">이름</th>
     		<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;" rowspan="2">소속부서</th>
     		<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;" rowspan="2">작성유효일수</th>
     		<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;" colspan="3">작성</th>	                    		
     		<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;" rowspan="2" class="td_last">미작성</th>
     	</tr>
     	<tr>
     		<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">당일(기본)</th>
     		<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">당일(상세)</th>
     		<th style="background-color:#dbdbdb;border-top:2px solid #666666;border-bottom:1px solid #666666;">기한초과</th>	                    		
     	</tr>
	</thead>
	<tbody>
    	<c:forEach items="${resultList}" var="result" varStatus="i">
<!--			bg02-->
	    	<c:if test="${i.count%2==0}"> <c:set var="bgColor" value="#dbf0ff"/> </c:if>
<!--			bg04-->
	    	<c:if test="${i.count%2==1}"> <c:set var="bgColor" value="#e5f5e7"/> </c:if>	                    	
	     	<tr>
		      	<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
		      	<td class="txt_center">${result.orgnztNm}</td>
		      	<td style="background-color:#fff5ce;" class="bG txt_center">${result.dateCnt}</td>
		      	<td style="background-color:${bgColor };" class="txt_center">${result.normal}</td>
		      	<td style="background-color:${bgColor };" class="txt_center">${result.over}</td>
		      	<td style="background-color:${bgColor };" class="txt_center">${result.late}</td>
		      	<td style="background-color:${bgColor };" class="txt_center">${result.noinput}</td>			                    	
	     	</tr>
    	</c:forEach>
	</tbody>
	<tfoot>
<!--	       	<tr>-->
<!--	        	<td class="T13B txt_center" colspan="2">종합</td>-->
<!--	        	<td class="bG txt_center">${resultSum.dateCnt}</td>-->
<!--	        	<td class="txt_center">${resultSum.normal}</td>-->
<!--	        	<td class="txt_center">${resultSum.over}</td>-->
<!--	        	<td class="txt_center">${resultSum.late}</td>-->
<!--	        	<td class="txt_center">${resultSum.noinput}</td>		                    	-->
<!--	       	</tr>-->
	</tfoot>
	</table>	          
</body>
</html>
