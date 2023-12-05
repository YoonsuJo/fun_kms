<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/ajax_inc.jsp"%>

<form id="rankSalaryForm" name="rankSalaryForm">
<div id="pop_expense">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/admin/inc/pop_bullet.gif" /></li>
			<li class="popTitle">직급별 기준인건비 등록</li>
		</ul>
 	</div>
 	
 	<!-- 게시판  -->
 	<div id="pop_con07">
 		<div class="expense_stxt">
			<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
            <caption>공지사항 보기</caption>
            <colgroup><col class="col10" /><col class="col10" /><col class="col10" /><col class="col10" /><col class="col10" /><col class="col10" /></colgroup>
            	<tbody>
           			<tr>
						<td class="title">직급코드</td>
		          	  	<td class="pL10">${resultList[0].rankCode }</td>
			            <td class="title">직급명</td>
			            <td class="pL10">${resultList[0].rankNm }</td>
			            <td class="title">상태</td>
			            <td class="pL10">${resultList[0].useAt }</td>
	                </tr>
                </tbody>
            </table>
			</div>
 		
 		<table cellpadding="0" cellspacing="0">
 			<colgroup><col class="col5" /><col class="col90" /><col class="col90" /><col class="col90" /><col class="col90" /><col class="col90" /><col class="col90" /><col class="col5" /></colgroup>
 			<thead>
 				<tr>
 					<th class="th_left" ></th>
 					<th class="th_center" colspan="6">${resultList[0].year }년도 월별 기준인건비</th>
 					<th class="th_right"></th>
 				</tr>
 			</thead>
 			<tbody>
				<tr class="subtitle">
					<td colspan="2">1월</td>
					<td>2월</td>
					<td>3월</td>
					<td>4월</td>
					<td>5월</td>
					<td colspan="2">6월</td>
				</tr>
				<tr>
					<c:forEach items="${resultList}" var="elem" begin="0" end="5" varStatus="status">
						<td <c:if test="${status.index==0 || status.index==5}">colspan="2"</c:if>>
							<input type="text" name ="salaryList" value="<print:currency cost='${elem.salary}'/>" />
						</td>					
					</c:forEach>					
				</tr>
				<tr class="subtitle02">
					<td colspan="2">7월</td>
					<td>8월</td>
					<td>9월</td>
					<td>10월</td>
					<td>11월</td>
					<td colspan="2">12월</td>
				</tr>
				<tr>
					<c:forEach items="${resultList}" var="elem" begin="6" end="12" varStatus="status">
						<td <c:if test="${status.index==6 ||status.index==11}">colspan="2"</c:if>>
							<input type="text" name ="salaryList" value="<print:currency cost='${elem.salary}'/>" />
						</td>					
					</c:forEach>
				</tr>
 			</tbody>
 			
 		</table>
 		<!--// 게시판 끝 -->
 		
 		<!-- 버튼  -->
 	    <div class="pop_btn_area04">
 		    <img class="cursorPointer" id="copyB" src="${imagePath}/admin/btn/btn_january_copy.gif" />
            <img class="cursorPointer" id="saveB" src="${imagePath}/admin/btn/btn_save.gif"/>
            <img class="cursorPointer" id="cancleB" src="${imagePath}/admin/btn/btn_cancel.gif"/>
        </div>
 		<!--// 버튼 끝 -->
 	</div>
</div>
</form>