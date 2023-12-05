<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/ajax_inc.jsp"%>
<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
	<caption>사원연봉결정</caption>
	<colgroup>
		<col width="px" />
		<col class="col50" />
		<col class="col60" />									
		<col class="col80" />
			
		<col class="col80" />
		<col class="col90" />
		<col class="col80" />											
		<col class="col80" />
		
		<col class="col60" />
		
		<col class="col70" />
		<col class="col70" />
		
		<col class="col50" />
		
		<col class="col90" />
		
	</colgroup>
	<thead>	
		<tr>
		<th scope="col"
			<c:if test="${searchVO.orderBy != 'org'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'org'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('org');">부서</a></th>									
		<th scope="col" 
			<c:if test="${searchVO.orderBy != 'name'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'name'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('name');">이름</a></th>
		<th scope="col"
			<c:if test="${searchVO.orderBy != 'age'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'age'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('age');">나이</a></th>
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'degree'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'degree'}">class="th_a2"</c:if> > 
				<a href="javascript:clickOrderBy('degree');">학력</a></span><br>
				<span
			<c:if test="${searchVO.orderBy != 'rank'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'rank'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('rank');">직급</a></span></th>				
				
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'workIn'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'workIn'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('workIn');">재직기간</a></span><br>
			<span 
			<c:if test="${searchVO.orderBy != 'work'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'work'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('work');">(총경력)</a></span></th>
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'salary'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'salary'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('salary');">당해연봉</a></span><br>
			<span
			<c:if test="${searchVO.orderBy != 'salaryHope'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'salaryHope'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('salaryHope');">(희망연봉)</a></span></th>						
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'salarySuggest'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'salarySuggest'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('salarySuggest');">차년도연봉</a></span></th>											
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'increase'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'increase'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('increase');">인상금액</a></span><br>
			<span
			<c:if test="${searchVO.orderBy != 'rate'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'rate'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('rate');">인상률</a></span></th>	
			
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'score1'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'score1'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('score1');">1차점수</a></span><br>
			<span
			<c:if test="${searchVO.orderBy != 'score2'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'score2'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('score2');">2차점수</a></span></th>
		<th scope="col">최종점수<br/>특약(차년)</th>		
			
		<th scope="col">개인의견<br/>특약(금년)</th>	
				
	<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'status'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'status'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('status');">상태</a></span></th>
		<th scope="col">수정</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="result" varStatus="status">
			<tr>				
<!--				부서-->
				<td class="txt_center">${result.orgnztNm } </td>
<!--				이름-->
				<td class="txt_center">
					<print:user userNo="${result.userNo}" userNm="${result.userNm}"/>
				</td>
<!--				나이-->
				<td class="txt_center">
					만${result.age }세<br>
					(${result.ageKor }세) 
				</td>
<!--				학력 직급 년차-->
				<td class="txt_center">
				<c:forEach items="${degreeCode}" var="degree">								        		 
	        		<c:if test="${result.degree == degree.code}">
	        			<c:out value="${degree.codeNm}" />
	        		</c:if>	        			        		
        		</c:forEach>
        		<br>${result.rankNm }
					<c:if test="${year < result.promotionYear - 1}">진급이전</c:if>
					<c:if test="${year == result.promotionYear - 1}">진급예정</c:if>
					<c:if test="${year >= result.promotionYear}">${year - result.promotionYear + 1}년차 </c:if>									
				</td>
<!--				입사일-->
<!--				<td class="txt_center">				-->
<!--					${fn:substring(result.compinDt,0,4)}년-->
<!--					<br>-->
<!--					${fn:substring(result.compinDt,4,6)*1}월-->
<!--					${fn:substring(result.compinDt,6,8)*1}일									  -->
<!--				</td>										-->

<!--				재직기간 총경력-->
				<td class="txt_center">
				<c:if test="${result.workYearIn > 0}">${result.workYearIn}년</c:if>${result.workMonthIn}개월<br>
				(<c:if test="${result.workYear > 0}">${result.workYear}년</c:if>${result.workMonth}개월)
					
<!--					fmt가 왜인지 안먹혀서 그냥 DB에서 계산처리 -->
<!--					<fmt:formatNumber value="${(result.careerMonth + result.workMonth) / 12}" pattern="#,##" />년<br>-->
<!--					${(result.careerMonth + result.workMonth) % 12}개월										-->					
<!--					fmt 예제-->
<!--					<c:set var="number" value="1234567.898" />-->
<!--					Input Number : <c:out value="${number}" /><br/><br/>-->
<!--					type="percent" : <fmt:formatNumber value="${number}" type="percent" /><br/>-->
<!--					type="number" : <fmt:formatNumber value="${number}" type="number" /><br/>-->
<!--					type="currency" : <fmt:formatNumber value="${number}" type="currency" currencySymbol="￦" /><br/>-->
<!--					maxIntegerDigits="4" : <fmt:formatNumber value="${number}" maxIntegerDigits="4" /><br/>-->
<!--					minIntegerDigits="10" : <fmt:formatNumber value="${number}" minIntegerDigits="10" /><br/>-->
<!--					maxFractionDigits ="2" : <fmt:formatNumber value="${number}" maxFractionDigits="2" /><br/>-->
<!--					minFractionDigits ="4" : <fmt:formatNumber value="${number}" minFractionDigits="4" /><br/>-->
<!--					pattern=".0000" : <fmt:formatNumber value="${number}" pattern="#,#0.0000" /><br/>-->
<!--					pattern="#,#0.0#" : <fmt:formatNumber value="${number}" pattern="#,#0.0#" /><br/><br/>-->
<!--					fmt:formatNumber 정수 추출 : <fmt:formatNumber value="${number}" pattern="#,##" /><br/>-->
<!--					<fmt:parseNumber var="parseNumber" value="${number}" type="number" />-->
<!--					<fmt:parseNumber var="parseNumberIntOnly" value="${number}" type="number" integerOnly="true" />-->
<!--					fmt:parseNumber integerOnly 사용 X 정수 추출 : <fmt:formatNumber value="${parseNumber}" pattern="#,##" /><br/>-->
<!--					fmt:parseNumber integerOnly 사용 정수 추출 : <fmt:formatNumber value="${parseNumberIntOnly}" pattern="#,##" />-->
				</td>
<!--				당해연봉 희망연봉-->
				<td class="txt_center userSalary1">
<!--				<input type="hidden" name="note${result.userNo }" id="note${result.userNo }" value="${result.note}" />-->
				<input type="hidden" name="hopeNote${result.userNo }" id="hopeNote${result.userNo }" value="${result.hopeNote}" />

				<input type="hidden" name="status${result.userNo }" id="status${result.userNo }" value="${result.status}" />
				<input type="hidden" name="salaryName${result.userNo }" id="salaryName${result.userNo }" value="${result.userNm}" />
				<input type="hidden" name="salaryReal${result.userNo }" id="salaryReal${result.userNo }" value="${result.salaryReal }"/>
				<input type="hidden" name="salaryHope${result.userNo }" id="salaryHope${result.userNo }" value="${result.salaryHope }"/>
				<input type="hidden" name="carCost${result.userNo }" id="carCost${result.userNo }" value="${result.carCost }"/>
				<input type="hidden" name="mealCost${result.userNo }" id="mealCost${result.userNo }" value="${result.mealCost }"/>
				<a href="javascript:historySR('${result.userNo }', '${result.salaryReal }')">
					<print:currency cost='${result.salaryReal }'/>
				</a><br/>
				<a href="javascript:historySR('${result.userNo }', '${result.salaryHope }')">
					(<print:currency cost='${result.salaryHope }'/>)
				</a></td>
<!--				차년도연봉-->
				<td class="txt_center userSalary3">
				<input type="text" name="salarySuggest${result.userNo }" id="salarySuggest${result.userNo }" class="write_input04" maxlength="12"
				onclick="showUserHistory(${result.userNo }, ${result.year }, this)" 
				onkeyup="calRate('${result.userNo }');inputjsMakeCurrency(this);" value="<print:currency cost='${result.salarySuggest }'/>"				
				onKeyPress="onlyNumber();enterUserSalary('${result.userNo}', acceptBtn${result.userNo});" />				
				</td>
<!--				인상금액 인상률-->
				<td class="txt_center">
				<input type="text" name="increaseAmount${result.userNo }" id="increaseAmount${result.userNo }" class="read_input2" maxlength="12" readonly="readonly" 
					value="<print:currency cost="${result.salarySuggest - result.salaryReal}"/>" />
				<br>				
				<input type="text" name="increaseRate${result.userNo }" id="increaseRate${result.userNo }" class="write_input11" maxlength="5" 
					onkeyup="calIncreaseRate('${result.userNo }');"  value="${result.increaseRate }" />%
				</td>
				
<!--				1차 2차 평가자점수-->
				<td class="txt_center">
					<p id="score1_${result.userNo }" onmouseover="javascript:showToolTip('ToolTipBox','score1_${result.userNo }','평가자 : ${result.eva1Nm}','left');" onmouseout="javascript:hideToolTip();"><print:user userNo="${result.eva1 }" userNm="${result.score1 }"/></p>
					<p id="score2_${result.userNo }" onmouseover="javascript:showToolTip('ToolTipBox','score2_${result.userNo }','평가자 : ${result.eva2Nm}','left');" onmouseout="javascript:hideToolTip();"><print:user userNo="${result.eva2 }" userNm="${result.score2 }"/></p>
				</td>
<!--				최종점수 특약(차년)-->
				<td class="txt_center Dover cursorPointer"
					<c:if test="${result.noteYn == 'Y'}">onmouseover="showNoteLayer('${result.userNo}','${year}',this)" 
							onmouseout="hideNoteLayer('${result.userNo}')" onclick="writeNote('${result.userNo}','${year}',this)"</c:if>
					<c:if test="${result.noteYn == 'N'}">onclick="writeNote('${result.userNo}','${year}',this);"</c:if> >
					${result.grade }<br/>
					<c:if test="${result.noteYn == 'Y' }">있음</c:if>
					<c:if test="${result.noteYn == 'N' }">-</c:if>
					<!-- 특약(차년) 레이어  -->
					<div id="noteLayerView${result.userNo }" style="display:none; z-index:5">
						<print:textarea text="${result.note}"/>
					</div>
					<div id="noteLayer${result.userNo }" style="display:none; z-index:5; overflow:hidden">
						<textarea name="note${result.userNo }" id="note${result.userNo }" class="span_95p height_95p">${result.note }</textarea>
					</div>
					<!-- 특약(차년) 레이어  끝  -->
				</td>
				
<!--				개인의견 특약(금년)-->
				<td class="txt_center Dover cursorPointer">
					<c:if test="${result.hopeNoteYn == 'Y' }">
						<p onclick="showNoteLayer('${result.userNo}_A2','${year}',this)" onmouseover="showNoteLayer('${result.userNo}_A','${year}',this)" onmouseout="hideNoteLayer('${result.userNo}_A')">
							있음
						</p>
					</c:if>
					<c:if test="${result.hopeNoteYn == 'N' }"><p>-</p></c:if>
					<!-- 개인의견 레이어  -->
					<div id="noteLayerView${result.userNo}_A" style="display:none; z-index:5">
						<print:textarea text="${result.hopeNote}"/>
					</div>
					<div id="noteLayerView${result.userNo}_A2" style="display:none; z-index:5">
						<print:textarea text="${result.hopeNote}"/>
					</div>
					<!-- 개인의견 레이어  끝  -->
					<c:if test="${result.lastNoteYn == 'Y' }">
						<p onclick="showNoteLayer('${result.userNo}_B2','${year}',this)" onmouseover="showNoteLayer('${result.userNo}_B','${year}',this)" onmouseout="hideNoteLayer('${result.userNo}_B')">
							있음
						</p>
					</c:if>
					<c:if test="${result.lastNoteYn == 'N' }"><p>-</p></c:if>
					<!-- 특약(금년) 레이어  -->
					<div id="noteLayerView${result.userNo }_B" style="display:none; z-index:5">
						<print:textarea text="${result.lastNote}"/>
					</div>
					<div id="noteLayerView${result.userNo }_B2" style="display:none; z-index:5">
						<print:textarea text="${result.lastNote}"/>
					</div>
					<!-- 특약(금년)  끝  -->
					
				</td>				
				
				
<!--				상태-->
				<td class="txt_center">
					<c:forEach items="${statusCode}" var="status">
						<c:if test="${status.code == result.status}">
							<input type="text" name="statusStr${result.userNo }" id="statusStr${result.userNo }" class="read_input" maxlength="12" readonly="readonly" 
							value="${status.codeNm }" />
						</c:if>
					</c:forEach>
				</td>
<!--				수정-->
				<td class="txt_center">		
<!--				result.status  1 : 제시,  2 : 동의 , 3 : 면담 -->
<!--			TENY_170127
				직원이 면담을 누른경우 면담을 마치고 금액을 수정하여 수정버튼을 누르면 상태가 동의가 아니라 제시로 바뀌게 수정 
				javascript:editUserSalary의 두번째 파라미터를 '2' 에서 '1'로 수정함 -->
				<c:choose>							
					<c:when test="${result.status=='1'}">						
						<img  class="cursorPointer" id="acceptBtn${result.userNo}" name="acceptBtn${result.userNo}"
						onclick="javascript:editUserSalary('${result.userNo}', '1', this);" src="${imagePath}/btn/btn_modify03.gif"/>
					</c:when>
					<c:when test="${result.status=='2'}">
						<img  class="cursorPointer" id="acceptBtn${result.userNo}" name="acceptBtn${result.userNo}"
						onclick="javascript:editUserSalary('${result.userNo}', '2, cancelBtn${result.userNo});" src="${imagePath}/btn/btn_modify03.gif"/>
						<img  class="cursorPointer" id="cancelBtn${result.userNo}" name="cancelBtn${result.userNo}"
						onclick="javascript:editUserSalary('${result.userNo}', '1', this);" src="${imagePath}/btn/btn_cancel03.gif"/>
					</c:when>
					<c:when test="${result.status=='3'}">
						<img  class="cursorPointer" id="acceptBtn${result.userNo}" name="acceptBtn${result.userNo}"
						onclick="javascript:editUserSalary('${result.userNo}', '1', cancelBtn${result.userNo});" src="${imagePath}/btn/btn_modify03.gif"/>
						<img  class="cursorPointer" id="cancelBtn${result.userNo}" name="cancelBtn${result.userNo}"
						onclick="javascript:editUserSalary('${result.userNo}', '1', this);" src="${imagePath}/btn/btn_cancel03.gif"/>
					</c:when>
					<c:otherwise>
						<img  class="cursorPointer" id="acceptBtn${result.userNo}" name="acceptBtn${result.userNo}"
						onclick="javascript:editUserSalary('${result.userNo}', '1', this);" src="${imagePath}/btn/btn_modify03.gif"/>
					</c:otherwise>
				</c:choose>						
				</td>
			</tr>									
		</c:forEach>
		
		<c:if test="${totCnt == 0}">
			<tr>
				<td class="txt_center" colspan="12">데이터 없음</td>
			</tr>	
		</c:if>
		
		<c:if test="${totCnt != 0}">		
			<tr>
<!--부서-->		<td class="txt_center">평균</td>
<!--이름-->		<td class="txt_center"></td>
<!--나이-->		<td class="txt_center">
					만${resultListSum.age }세<br>
					(${resultListSum.ageKor }세)	</td>
<!--학력 직급 년차-->	<td class="txt_center"></td>
<!--재직기간 총경력-->	<td class="txt_center">
					<c:if test="${resultListSum.workYearIn > 0 }">${resultListSum.workYearIn }년</c:if>${resultListSum.workMonth }개월	<br>
					(<c:if test="${resultListSum.workYear > 0 }">${resultListSum.workYear }년</c:if>${resultListSum.workMonth }개월)		</td>
<!--당해연봉 희망연봉-->
				<td class="txt_center userSalary1">			
					<print:currency cost='${resultListSum.salaryRealAvg }'/>	<br/>
					(<print:currency cost='${resultListSum.salaryHopeAvg }'/>)	</td>
<!--차년도연봉-->	<td class="txt_center userSalary3">
					<print:currency cost='${resultListSum.salarySuggestAvg }'/>	</td>
<!--인상금액 인상률-->	<td class="txt_center">
					<print:currency cost="${resultListSum.salarySuggestAvg - resultListSum.salaryRealAvg }"/>	<br>
					${resultListSum.increaseRateAvg }%	</td>				
<!--1차 2차 평가자점수-->	<td class="txt_center">
					${resultListSum.score1Avg }<br/>
					${resultListSum.score2Avg }</td>
<!--최종점수 -->	<td class="txt_center Dover cursorPointer">	${resultListSum.gradeAvg }		</td>
<!--상태-->		<td class="txt_center"></td>
<!--수정-->		<td class="txt_center"></td>
			</tr>
			
			<tr>
<!--부서-->		<td class="txt_center">총계</td>
<!--이름-->		<td class="txt_center">총 ${totCnt } 명</td>
<!--나이-->		<td class="txt_center">	</td>
<!--학력 직급 년차-->	<td class="txt_center"></td>
<!--재직기간 총경력-->	<td class="txt_center"></td>
<!--당해연봉 희망연봉-->
				<td class="txt_center userSalary1">			
					<print:currency cost='${resultListSum.salaryReal }'/>	<br/>
					(<print:currency cost='${resultListSum.salaryHope }'/>)	</td>
<!--차년도연봉-->	<td class="txt_center userSalary3">
					<print:currency cost='${resultListSum.salarySuggest }'/>	</td>
<!--인상금액 인상률-->	<td class="txt_center">
					<print:currency cost="${resultListSum.salarySuggest - resultListSum.salaryReal }"/>	<br>
					${resultListSum.increaseRate }%	</td>				
<!--1차 2차 평가자점수-->	<td class="txt_center">
					${resultListSum.score1 }<br/>
					${resultListSum.score2 }</td>
<!--최종점수 -->	<td class="txt_center Dover cursorPointer">	${resultListSum.grade }		</td>
<!--상태-->		<td class="txt_center"></td>
<!--수정-->		<td class="txt_center"></td>
			</tr>
		</c:if>
												
	</tbody>
	</table>