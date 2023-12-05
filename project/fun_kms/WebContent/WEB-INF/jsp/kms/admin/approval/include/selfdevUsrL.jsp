	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../../include/ajax_inc.jsp"%>

<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
<caption>인사발령 이력</caption>
<colgroup>
	<col class="col5" />
	<col class="col50" />
	<col class="col70" />
	<col class="col120" />
	<col class="col70" />
	<col class="col120" />
	<col width="px" />
	<col class="col90" />
	<col class="col5" /></colgroup>
<thead>
	<tr>
	<th class="th_left"></th>
	<th scope="col">사번</th>
	<th scope="col">이름</th>
	<th scope="col">소속부서</th>
	<th scope="col">조정비율</th>
	<th scope="col">할증금액</th>
	<th scope="col">사유</th>
	<th scope="col">수정/삭제</th>
	<th class="th_right"></th>
	</tr>
</thead>
<tbody>
	<c:forEach items="${resultList2}" var="result"  varStatus="status">
	<tr>
		<td class="hidden"><input type="hidden" value="${result.selfdevUsrNo }" name="selfdevUsrNo"/></td>
		<td class="txt_center" colspan="2">${result.sabun}</td>
		<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
		<td class="txt_center">${result.orgnztNm}</td>
		<td class="txt_center">${result.percent}%</td>
		<td class="txt_center"><print:currency cost="${result.extraCharge}"/>원</td>
		<td class="txt_center">${result.description }</td>
		<td colspan="2" class="txt_center">
			<img src="${imagePath}/admin/btn/btn_modify03.gif" class="cursorPointer selfdevUsrModifyB" />
			<img src="${imagePath}/admin/btn/btn_delete04.gif" class="cursorPointer selfdevUsrDeleteB"/>
		</td>
	</tr>
	</c:forEach>
</tbody>
</table>