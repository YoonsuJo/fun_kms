<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- S: section -->
<div class="section01">
	<!-- 상단 검색창 시작 -->
<fieldset>
<legend>하단 검색</legend>
<div class="top_search mT20">
		<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
		<caption>공지사항</caption>
		<colgroup><col width="px" /><col class="col350" /><col class="col40" /></colgroup>
		<tbody>
			<tr>
				<td colspan="2" class="txt_right">
					<select name="approvalForm">
						<option>모든 결재양식</option>
					</select> 제목 
					<input type="text" name="title" class="span_8"/> 기안자 <input type="text" name="name" class="span_8"/></td>
				<td rowspan="2" class="pL10"><img src="${imagePath}/btn/btn_search03.gif" /></td>
			</tr>
			<tr>
				<td class="txt_right pR20">결재상태 : <input type="checkbox" class="check" name="approval" value="1" /> 참조중 <input type="checkbox" class="check" name="approval" value="2" /> 참조완료</td>
				<td class="txt_right">처리상태 : <input type="checkbox" class="check" name="handling" value="1" /> 처리중 <input type="checkbox" class="check" name="handling" value="2" /> 처리완료 <input type="checkbox" class="check" name="handling" value="3" /> 취소 <input type="checkbox" class="check" name="handling" value="4" /> 처리불필요</td>
			</tr>
		</tbody>
		</table>
                </div>
            </fieldset>
           </div>