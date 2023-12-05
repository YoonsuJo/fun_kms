<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../include/ajax_inc.jsp"%>

<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup><col class="col250" /><col class="col70" /><col class="col70" /><col width="px" /><col class="col40" /></colgroup>
	<thead>
		<tr>
			<th>기간</th>
			<th>종류</th>
			<th>일수</th>
			<th>사유</th>
			<th class="td_last">변경</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="result">
			<tr>
				<td class="txt_center">${result.st} ~ ${result.ed}</td>
				<td class="txt_center">
					<c:if test="${result.vacTyp == '1'}">연차</c:if>
					<c:if test="${result.vacTyp == '2'}">경조휴가</c:if>
					<c:if test="${result.vacTyp == '3'}">특별휴가</c:if>
					<c:if test="${result.vacTyp == '4'}">기타</c:if>
					<%-- <c:if test="${result.vacTyp == '5'}">하계휴가</c:if> --%>
				</td>
				<td class="txt_center">${result.sumDate}</td>
				<td class="txt_center">				
					<a href="/approval/approvalV.do?docId=${result.docId}" >
						${result.content}
					</a>
				</td>
				<td class="td_last txt_center">
					<c:if test="${(result.userNo == user.userNo) == true}">
						<a href="javascript:modifyAppVac('${result.docId}')" ><img src="${imagePath}/btn/btn_plus02.gif"/></a>
					</c:if>
					<c:if test="${user.admin == true}">
						<a href="javascript:showVacTyp('${result.docId}')" ><img src="${imagePath}/btn/btn_plus.gif"/></a>						
					</c:if>
				</td>
			</tr>
		</c:forEach>
		<c:if test="${empty resultList}">
			<tr>
				<td class="txt_center td_last" colspan="5">조회된 휴가사용내역이 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>

<div class="mT10 txt_right T11">
	<img src="${imagePath}/btn/btn_plus02.gif" class="mT5"/> 버튼 : 수정기안 기능
	<c:if test="${user.admin == true}">
		<img src="${imagePath}/btn/btn_plus.gif" class="mT5"/> 버튼 : 휴가종류 수정(관리자 기능)
	</c:if>
</div>
			
<div class="boardList02 mB20" id="vacationTypChange"  style="display:none;">
	<form name="formVacTyp" method="GET">
		<input type="hidden" name="docId" id="vacTypDocId"/>
		<input type="hidden" name="vacTyp" id="vacTyp"/>
		<p class="th_stitle">휴가종류 변경</p>
		<select id="selectVacTyp" class="select01" onchange="vactyp()">
			<option value="" label="종류"/>
			<option value="1" label="연차"/>
			<option value="2" label="경조휴가"/>
			<option value="3" label="특별휴가"/>
			<option value="4" label="기타"/>
			<!-- <option value="5" label="하계휴가"/> -->
		</select>
		<a href="javascript:modifyAppVacTyp();">
			<img src="${imagePath}/btn/btn_save2.gif" class="mT5" alt="저장" class="cursorPointer" id="vacTypChgBtn"/>
		</a>
	</form>
</div>