<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../include/top_inc.jsp"%>
						<!-- 레이어  -->
						<form name="frm" method="POST" action="<c:url value='${rootPath}/admin/member/insertPositionHistory.do' />">
						<input type="hidden" name="no" value="${result.member.no}" />
						<input type="hidden" name="userNo" value="${result.member.no}" />
						<input type="hidden" name="userNm" value="${result.member.userNm}" />
						<input type="hidden" name="bfrChngDt" value="${new.chngDt}" />
						<input type="hidden" name="bfrRankId" value="${new.aftRankId}" />
						<input type="hidden" name="bfrCompId" value="${new.aftCompId}" />
						<input type="hidden" name="bfrOrgnztId" value="${new.aftOrgnztId}" />
						<input type="hidden" name="bfrPosition" value="${new.aftPosition}" />
						<div id="member_appointment" style="display:none;">
							<p class="th_stitle">인사발령</p>
							
							<p class="appointment_name"><c:out value="${result.member.userNm}" /> <span>(${result.member.orgnztNm})</span></p>
							<table cellpadding="0" cellspacing="0" >
							<caption>인사발령</caption>
							<colgroup><col class="col70" /><col width="px" /></colgroup>
							<tbody>
								<tr>
									<td class="title">발령일</td>
									<td class="pL10" ><input type="text" class="calGen" name="chngDt" maxlength="8" /></td>
								</tr>
								<tr>
									<td class="title">구분</td>
									<td class="pL10">
										<c:if test="${not empty new && result.member.workSt == 'W'}">
										<label><input type="radio" name="chngCode" value="CH" onclick="disableSetting(this);" /> 변경</label>
										</c:if>
										<c:if test="${empty new}">
										<label><input type="radio" name="chngCode" value="EN" onclick="disableSetting(this);" /> 입사</label>
										</c:if>
										<c:if test="${not empty new && result.member.workSt != 'R'}">
										<label><input type="radio" name="chngCode" value="RT" onclick="disableSetting(this);" /> 퇴직</label>
										</c:if>
										<c:if test="${not empty new && result.member.workSt == 'R'}">
										<label><input type="radio" name="chngCode" value="RE" onclick="disableSetting(this);" /> 재입사</label>
										</c:if>
										<c:if test="${not empty new && result.member.workSt == 'W'}">
										<label><input type="radio" name="chngCode" value="LV" onclick="disableSetting(this);" /> 휴직</label>
										</c:if>
										<c:if test="${not empty new && result.member.workSt == 'L'}">
										<label><input type="radio" name="chngCode" value="BK" onclick="disableSetting(this);" /> 복귀</label>
										</c:if>
									</td>
								</tr>
								<tr>
									<td class="title" >직급</td>
									<td class="pL10" >
										<select name="aftRankId">
											<option value="">선택</option>
											<c:forEach items="${rankList}" var="rank">
												<option value="${rank.code}" <c:if test="${rank.code== new.aftRankId}">selected="selected"</c:if> ><c:out value="${rank.codeNm}"/></option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td class="title">소속회사</td>
									<td class="pL10" >
										<select name="aftCompId">
											<option value="">선택</option>
											<c:forEach items="${compList}" var="comp">
												<option value="${comp.code}" <c:if test="${comp.code== new.aftCompId}">selected="selected"</c:if> ><c:out value="${comp.codeNm}"/></option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td class="title">소속부서</td>
									<td class="pL10" >
										<input type="text" name="aftOrgnzt" id="aftOrgnzt" class="span_27" value="${new.aftOrgnztNm}" readonly="readonly" onclick="orgGen('aftOrgnzt','aftOrgnztId',1)"/>
										<img src="${imagePath}/btn/btn_tree.gif" id="orgTree" class="cursorPointer" onclick="orgGen('aftOrgnzt','aftOrgnztId',1)"/>
										<input type="hidden" name="aftOrgnztId" id="aftOrgnztId" value="${new.aftOrgnztId}"/>
									</td>
								</tr>
								<tr>
									<td class="title">보직</td>
									<td class="pL10" >
										<label><input type="radio" name="aftPosition" value="N" <c:if test="${new.aftPosition == 'N'}">checked="checked"</c:if> /> 없음</label>
										<label><input type="radio" name="aftPosition" value="D" <c:if test="${new.aftPosition == 'D'}">checked="checked"</c:if> /> 대표</label>
										<label><input type="radio" name="aftPosition" value="H" <c:if test="${new.aftPosition == 'H'}">checked="checked"</c:if> /> 부서장</label>
										<label><input type="radio" name="aftPosition" value="S" <c:if test="${new.aftPosition == 'S'}">checked="checked"</c:if> /> 부서장 대행</label>
									</td>
								</tr>
								<tr>
									<td class="title">비고</td>
									<td class="pL10" >
										<input type="text" name="note" />
									</td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="2">
										<a href="javascript:register();"><img src="${imagePath}/admin/btn/btn_appointment02.gif"/></a>
								 	    <a href="javascript:cancel();"><img src="${imagePath}/admin/btn/btn_cancel.gif"/></a>
									</td>
								</tr>
							</tfoot>	
							</table>
						</div>
						</form>
						<!-- // 레이어 끝-->
