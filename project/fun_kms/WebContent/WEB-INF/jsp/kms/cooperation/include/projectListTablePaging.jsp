<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>

<script>

$(document).ready(function(){
	// 투입된 프로젝트 수가 5개 이하일 때 더보기 버튼을 없앰
	if (${paginationInfo.totalRecordCount} <= 5)
		$('#btnMoreInterestProject').remove();
});

function switchProjectList() {
	if ($('#shortProjectList').css('display') == 'none') {
		$('#shortProjectList').css('display', 'block');
		$('#fullProjectList').css('display', 'none');
	} else {
		$('#shortProjectList').css('display', 'none');
		$('#fullProjectList').css('display', 'block');
	}
}

</script>
	
	<div id="shortProjectList">
		<table id="projectListT" cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	    <caption>프로젝트 현황</caption>
	    <colgroup>
		    <col class="col120" />
		    <col width="px"/>
		    <col class="col70" />
		    <col class="col70" />
		    <col class="col70" />
		    <col class="col70" />
		    <col class="col70" />
	    </colgroup>
	    <thead>
	    	<tr>
	    		<th>주관부서</th>
	    		<th>프로젝트</th>
	    		<th>PL</th>
	    		<th>상태</th>
	    		<th>인건비</th>
	    		<th>판관비</th>
	    		<th class="td_last">예산관리</th>
	    	</tr>
	    </thead>
	    <tbody>
	    <c:choose>
	    	<c:when test="${empty resultList }">
				<tr><td colspan="6" class="td_last txt_center pT10 pB10" ><a href="/cooperation/selectProjectList.do">※ 투입된 프로젝트가 없습니다.</a></td></tr>
			</c:when>
			<c:otherwise>
	    	<c:forEach items="${resultList}" varStatus="status" var="result">
	    	<c:if test="${status.count < 6}">
	     	<tr>
	     		<td class="hidden">
			     	<input name="type" type="hidden" value="${result.type }"/>
			     	<input name="prntPrjId" type="hidden" value="${result.prntPrjId }"/>
			     	<input name="prjId" type="hidden" value="${result.prjId }"/>
			     	<input name="prjSn" type="hidden" value="${result.prjSn }"/>
			     	<input name="prjLv" type="hidden" value="${result.prjLv }"/>
			    </td>
		      	<td class="txt_center">${result.orgnztNm }</td>
		      	<td class="pL10">
		      		<c:if test="${treeMode=='Y'}">
			      		<c:forEach begin="1" end="${result.prjLv}">
			      			&nbsp;&nbsp;&nbsp;
			      		</c:forEach>
			      		<span class="plusMinus midPlusB pL10"></span>
		      		</c:if>
		      		
		      		
		      		
		      		<a class="cursorPointer" onclick="viewProject('${result.prjId }');"><span class="txtB_grey">[${result.prjCd }]</span> ${result.prjNm }</a>
		      	</td>
		      	<td class="txt_center"><print:user userNo="${result.leaderNo}" userNm="${result.leaderNm}"/></td>
		      	<td class="txt_center">${result.statNm }</td>
		      	<td class="txt_center">${result.dayReportRule }</td>
		      	<td class="txt_center">${result.manageCostRule }</td>
		      	<td class="td_last txt_center">${result.budgetExceedRule }</td>
	     	</tr>
	     	</c:if>
	    	</c:forEach>
	    	</c:otherwise>
	    </c:choose>           			                    			                    	
	    </tbody>
	    </table>
    </div>
    
    <div id="fullProjectList" style="display:none;">
   		<table id="projectListT" cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	    <caption>프로젝트 현황</caption>
	    <colgroup>
		    <col class="col120" />
		    <col width="px"/>
		    <col class="col70" />
		    <col class="col70" />
		    <col class="col70" />
		    <col class="col70" />
		    <col class="col70" />
	    </colgroup>
	    <thead>
	    	<tr>
	    		<th>주관부서</th>
	    		<th>프로젝트</th>
	    		<th>PL</th>
	    		<th>상태</th>
	    		<th>인건비</th>
	    		<th>판관비</th>
	    		<th class="td_last">예산관리</th>
	    	</tr>
	    </thead>
	    <tbody>
	    
	    	<c:forEach items="${resultList}" varStatus="status" var="result">
	    	
	     	<tr>
	     		<td class="hidden">
			     	<input name="type" type="hidden" value="${result.type }"/>
			     	<input name="prntPrjId" type="hidden" value="${result.prntPrjId }"/>
			     	<input name="prjId" type="hidden" value="${result.prjId }"/>
			     	<input name="prjSn" type="hidden" value="${result.prjSn }"/>
			     	<input name="prjLv" type="hidden" value="${result.prjLv }"/>
			    </td>
		      	<td class="txt_center">${result.orgnztNm }</td>
		      	<td class="pL10">
		      		<c:if test="${treeMode=='Y'}">
			      		<c:forEach begin="1" end="${result.prjLv}">
			      			&nbsp;&nbsp;&nbsp;
			      		</c:forEach>
			      		<span class="plusMinus midPlusB pL10"></span>
		      		</c:if>
		      		
		      		
		      		
		      		<a class="cursorPointer" onclick="viewProject('${result.prjId }');"><span class="txtB_grey">[${result.prjCd }]</span> ${result.prjNm }</a>
		      	</td>
		      	<td class="txt_center"><print:user userNo="${result.leaderNo}" userNm="${result.leaderNm}"/></td>
		      	<td class="txt_center">${result.statNm }</td>
		      	<td class="txt_center">${result.dayReportRule }</td>
		      	<td class="txt_center">${result.manageCostRule }</td>
		      	<td class="td_last txt_center">${result.budgetExceedRule }</td>
	     	</tr>	   
	    	</c:forEach>                 			                    			                    	
	    </tbody>
    </table>
    </div>
    <!-- 
    <div class="paginate">
		<ui:pagination paginationInfo="${paginationInfo}" jsFunction="projectSearch" type="image"/>
	</div>
	 -->