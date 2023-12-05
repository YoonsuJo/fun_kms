<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="../../include/ajax_inc.jsp"%>


			<!-- 프로젝트 투입입력 상세정보 레이어 -->
			<div class="Pdetail">
				<p class="th_stitle">프로젝트 투입인력 변경</p>
				<div class="th_txt">프로젝트 투입인력을 변경할 수 있습니다.<br/>삭제하시려면 모든 월의 체크를 해제하신 상태에서 저장해 주시기 바랍니다.</div>
					
				<!-- 상단 검색창 시작 -->
				<fieldset>
				<legend>상단 검색</legend>
					<div class="scheduleDate mB20">
						<ul>
							<li class="li_left">
								<a id="moveYearPrev" class="pR10 cursorPointer"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
								<span class="option_txt" id="projectInputYear">${projectInputVO.year }</span>
								<a id="moveYearNext" class="pL10 cursorPointer"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
							</li>
							<li class="li_right">
								<span class="option_txt">사용자</span><span class="pL7"></span>
								<input type="text" class="search_txt02 userNamesAuto userValidateCheck" id="userInput"/>
								<img src="${imagePath}/btn/btn_tree.gif" id="userTreeB" class="cursorPointer"/>
								<img src="${imagePath}/btn/btn_add.gif" id="userAddB" class="cursorPointer"/>
							</li>
						</ul>
					</div>
				</fieldset>
				<!-- 상단 검색창 끝 -->
				<form:form commandName="projectInputVO" name="projectInputVO" method="post" enctype="multipart/form-data" >
				<form:hidden path="year"/>
				<form:hidden path="prjId"/>
				<div class="boardList02 mB20">
				<table id="userInputTable" cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
					<caption>공지사항 보기</caption>
					<colgroup><col class="col10" /><col class="col10" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col10" /></colgroup>
					<thead>
						<tr class="height_th">
							<th>번호</th>
							<th>이름</th>
							<th>1월<br/><input class="verticalAll mT2" type="checkbox" value="1"/></th>
							<th>2월<br/><input class="verticalAll mT2" type="checkbox" value="2"/></th>
							<th>3월<br/><input class="verticalAll mT2" type="checkbox" value="3"/></th>
							<th>4월<br/><input class="verticalAll mT2" type="checkbox" value="4"/></th>
							<th>5월<br/><input class="verticalAll mT2" type="checkbox" value="5"/></th>
							<th>6월<br/><input class="verticalAll mT2" type="checkbox" value="6"/></th>
							<th>7월<br/><input class="verticalAll mT2" type="checkbox" value="7"/></th>
							<th>8월<br/><input class="verticalAll mT2" type="checkbox" value="8"/></th>
							<th>9월<br/><input class="verticalAll mT2" type="checkbox" value="9"/></th>
							<th>10월<br/><input class="verticalAll mT2" type="checkbox" value="10"/></th>
							<th>11월<br/><input class="verticalAll mT2" type="checkbox" value="11"/></th>
							<th>12월<br/><input class="verticalAll mT2" type="checkbox" value="12"/></th>
							<th class="td_last">일괄<br/><input class="checkboxAll mT2" type="checkbox"/></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList}" varStatus="status" var="result">
							<input type="hidden" name="userIdList" value="${result.userId }"/>
							<tr>
								<td class="txt_center">${status.count}</td>
								<td class="txt_center userNm"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
								<td class="txt_center"><input name="monthList" class="monthList1" type="checkbox" value="1" <c:if test="${result.month1List==1 }">checked="checked"</c:if>/></td>
								<td class="txt_center"><input name="monthList" class="monthList2" type="checkbox" value="1" <c:if test="${result.month2List==1 }">checked="checked"</c:if>/></td>
								<td class="txt_center"><input name="monthList" class="monthList3" type="checkbox" value="1" <c:if test="${result.month3List==1 }">checked="checked"</c:if>/></td>
								<td class="txt_center"><input name="monthList" class="monthList4" type="checkbox" value="1" <c:if test="${result.month4List==1 }">checked="checked"</c:if>/></td>
								<td class="txt_center"><input name="monthList" class="monthList5" type="checkbox" value="1" <c:if test="${result.month5List==1 }">checked="checked"</c:if>/></td>
								<td class="txt_center"><input name="monthList" class="monthList6" type="checkbox" value="1" <c:if test="${result.month6List==1 }">checked="checked"</c:if>/></td>
								<td class="txt_center"><input name="monthList" class="monthList7" type="checkbox" value="1" <c:if test="${result.month7List==1 }">checked="checked"</c:if>/></td>
								<td class="txt_center"><input name="monthList" class="monthList8" type="checkbox" value="1" <c:if test="${result.month8List==1 }">checked="checked"</c:if>/></td>
								<td class="txt_center"><input name="monthList" class="monthList9" type="checkbox" value="1" <c:if test="${result.month9List==1 }">checked="checked"</c:if>/></td>
								<td class="txt_center"><input name="monthList" class="monthList10" type="checkbox" value="1" <c:if test="${result.month10List==1 }">checked="checked"</c:if>/></td>
								<td class="txt_center"><input name="monthList" class="monthList11" type="checkbox" value="1" <c:if test="${result.month11List==1 }">checked="checked"</c:if>/></td>
								<td class="txt_center"><input name="monthList" class="monthList12" type="checkbox" value="1" <c:if test="${result.month12List==1 }">checked="checked"</c:if>/></td>
								<td class="td_last txt_center"><input name="monthAll" type="checkbox" <c:if test="${result.monthAll==1 }">checked="checked"</c:if>/></td>
							</tr>  
						</c:forEach>                			                    			                    	
					</tbody>
					</table>
				</div>
				<div class="btn_area04">
					<c:choose>
						<c:when test="${user.admin || prjAuth=='Y' || prjAuth2=='Y' || user.isProjectadmin == 'Y'}" >
							<img src="${imagePath}/btn/btn_save.gif" class="cursorPointer" id="prjInputSaveB"/>
							<img src="${imagePath}/btn/btn_cancel.gif" class="cursorPointer" id="prjInputCancleB"/>
						</c:when>
						<c:otherwise>
							<img src="${imagePath}/btn/btn_close.gif" class="cursorPointer" id="prjInputCancleB"/>
						</c:otherwise>
					</c:choose>
				</div>
				</form:form>
			</div>
			<!--// 프로젝트 투입입력 상세정보 레이어 -->