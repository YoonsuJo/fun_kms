<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../include/ajax_inc.jsp"%>
<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
	<caption>개인별 인건비</caption>
	<colgroup>
		<col class="col5" />
		
		<col class="col30" />
		<col class="col50" />
		<col width="px" />
		<col class="col50" />		
		<col class="col50" />
		
		<col class="col100" />
		<col class="col90" />
		<col class="col90" />
				
		<col class="col100" />
		<col class="col70" />
		<col class="col60" />
		<col class="col70" />
		<col class="col70" />
		
		<col class="col5" />
	</colgroup>
	<thead>
		<tr>
		<th></th>					
		
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'sabun'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'sabun'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('sabun');">사번</a></span></th>
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'name'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'name'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('name');">이름</a></span></th>
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'org'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'org'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('org');">부서</a></span></th>
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'age'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'age'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('age');">나이</a></span></th>
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'rank'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'rank'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('rank');">직급</a></span></th>
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'promotionYear'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'promotionYear'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('promotionYear');">진급년도</a></span><br>
			<span
			<c:if test="${searchVO.orderBy != 'degree'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'degree'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('degree');">학력</a></span></th>		
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'promotionYear'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'promotionYear'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('promotionYear');">입사전<br>인정경력</a></span></th>			
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'salary'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'salary'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('salary');">실제연봉</a></span></th>		
		
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'salaryHope'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'salaryHope'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('salaryHope');">희망연봉</a></span><br>
			<span
			<c:if test="${searchVO.orderBy != 'salarySuggest'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'salarySuggest'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('salarySuggest');">제안연봉</a></span></th>
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'carCost'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'carCost'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('carCost');">차량유지비</a></span><br>
			<span
			<c:if test="${searchVO.orderBy != 'mealCost'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'mealCost'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('mealCost');">식대</a></span><br>		
			<span	
			<c:if test="${searchVO.orderBy != 'babyCost'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'babyCost'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('babyCost');">보육수당</a></span><br>			
			<span	
			<c:if test="${searchVO.orderBy != 'communicationCost'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'communicationCost'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('communicationCost');">통신비</a></span></th>			
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'status'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'status'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('status');">상태</a></span></th>
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'adminNote'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'adminNote'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('adminNote');">관리자<br/>메모</a></span></th>

		<th scope="col">수정</th>
		
		<th></th>
		
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList2}" var="result" varStatus="status">
			<tr>
<!--				사번-->
				<td class="txt_center" colspan="2">${result.sabun}</td>
<!--				이름-->
				<td class="txt_center">
					<print:user userNo="${result.userNo}" userNm="${result.userNm} "/>
				<input type="hidden" name="salaryName${result.userNo }" id="salaryName${result.userNo }" value="${result.userNm}" />
				</td>
<!--				소속부서-->
				<td class="txt_center">${result.orgnztNm}</td>
<!--				나이-->
				<td class="txt_center">${result.age}세<br>(${result.ageKor}세)</td>
<!--				직급-->
				<td class="txt_center">${result.rankNm}<br>
				<c:if test="${result.year < result.promotionYear - 1}">진급이전</c:if>
				<c:if test="${result.year == result.promotionYear - 1}">진급예정</c:if>
				<c:if test="${result.year >= result.promotionYear}">${result.year - result.promotionYear + 1}년차 </c:if>
				</td>	
											
<!--				진급년도 학력-->
			    <td class="pL10">								   
					<input type="text" maxlength=4 id="promotionYear${result.userNo }" name="promotionYear${result.userNo }" 
					value="<c:out value="${result.promotionYear}" />" class="span_3" />
					<select id= "degree${result.userNo }" name="degree${result.userNo }" class="span_5">
			    		<option value="" <c:if test="${result.degree == ''}">selected="selected"</c:if>>== 선택 ==</option>
		        		<c:forEach items="${degreeCode}" var="degree">
			        		<option value="${degree.code}" 
			        		<c:if test="${result.degree == degree.code}">selected="selected"</c:if> >
			        		<c:out value="${degree.codeNm}" /></option>
		        		</c:forEach>
		        	</select>											
			    </td>
<!--				입사전 인정경력-->
			    <td class="pL10">
			    <input type="text" maxlength=3 id="careerMonthYear${result.userNo }" name="careerMonthYear${result.userNo }" 
			    value="<c:out value="${result.workYear}" />" class="span_1" /> 년
			    <br>
			    <input type="text" maxlength=2 id="careerMonthMonth${result.userNo }" name="careerMonthMonth${result.userNo }" 
			    value="<c:out value="${result.workMonth}" />" class="span_1" /> 개월								   
			    </td>
<!--				실제연봉-->

				<td class="txt_center userSalary1">
				<input type="text" name="salaryReal${result.userNo }" id="salaryReal${result.userNo }" class="write_input04" maxlength="14"
				onkeyup="javascript:inputjsMakeCurrency('salaryReal${result.userNo }');" value="<print:currency cost='${result.salaryReal }'/>"/>
				</td>
<!--				희망연봉 제안연봉 -->
				<td class="txt_center userSalary3">
				<input type="text" name="salaryHope${result.userNo }" id="salaryHope${result.userNo }" class="write_input04" maxlength="14"
				onkeyup="javascript:inputjsMakeCurrency('salaryHope${result.userNo }');" value="<print:currency cost='${result.salaryHope }'/>"/>
				<input type="text" name="salarySuggest${result.userNo }" id="salarySuggest${result.userNo }" class="write_input04" maxlength="14"
				onkeyup="javascript:inputjsMakeCurrency('salarySuggest${result.userNo }');" value="<print:currency cost='${result.salarySuggest }'/>"/>				
				</td>
<!--				차량유지비, 식대 , 보육수당-->
				<td class="txt_center">
				<input type="text" name="carCost${result.userNo }" id="carCost${result.userNo }" class="write_input10" maxlength="14"
				onkeyup="javascript:inputjsMakeCurrency('carCost${result.userNo }');" value="<print:currency cost='${result.carCost }'/>"/>
				<input type="text" name="mealCost${result.userNo }" id="mealCost${result.userNo }" class="write_input10" maxlength="14"
				onkeyup="javascript:inputjsMakeCurrency('mealCost${result.userNo }');" value="<print:currency cost='${result.mealCost }'/>"/>
				<input type="text" name="babyCost${result.userNo }" id="babyCost${result.userNo }" class="write_input10" maxlength="14"
				onkeyup="javascript:inputjsMakeCurrency('babyCost${result.userNo }');" value="<print:currency cost='${result.babyCost }'/>"/>
				<input type="text" name="communicationCost${result.userNo }" id="communicationCost${result.userNo }" class="write_input10" maxlength="14"
				onkeyup="javascript:inputjsMakeCurrency('communicationCost${result.userNo }');" value="<print:currency cost='${result.communicationCost }'/>"/>
				</td>
<!--				상태 특약사항-->
				<td class="txt_center isRegistered">
					<input type="hidden" name="status${result.userNo }" id="status${result.userNo }" value="${result.status}" />
					<c:forEach items="${statusCode}" var="status">					 
						<c:if test="${status.code == result.status}">
							${status.codeNm }<br/>
						</c:if>					
					</c:forEach>		
					<c:choose>
						<c:when test="${result.workSt=='L'}">
							휴직
						</c:when>
						<c:when test="${result.isRegistered=='N'}">
							<span class="txtS_red">미등록</span>
						</c:when>
						<c:when test="${result.salaryReal<10}">
							<span class="txtS_red">실제연봉<br/>이상</span>
						</c:when>						
						<c:when test="${result.promotionYear<1900}">
							<span class="txtS_red">진급년도<br/>이상</span>
						</c:when>
						<c:when test="${result.workYear>70}">
							<span class="txtS_red">입사전 인정경력 이상</span>
						</c:when>						
						<c:when test="${result.mealCost<20001 && result.mealCost!=0}">
							<span class="txtS_red">식대 적음</span>
						</c:when>
						<c:when test="${result.carCost<20001 && result.carCost!=0}">
							<span class="txtS_red">차량유지비 적음</span>
						</c:when>
					</c:choose>
					
<!--				특약사항-->				
<!--					<c:if test="${result.noteYn == 'Y'}">onmouseover="showNoteLayer('${result.userNo}','${year}',this)" -->
<!--							onmouseout="hideNoteLayer('${result.userNo}')" onclick="writeNote('${result.userNo}','${year}',this)"</c:if>-->
<!--					<c:if test="${result.noteYn == 'N'}">onclick="writeNote('${result.userNo}','${year}',this);"</c:if> 					-->
<!--					<c:if test="${result.noteYn == 'Y' }">있음</c:if>-->
					<!-- 특약사항 레이어  -->
					<div id="noteLayerView${result.userNo }" style="display:none; z-index:5">
						${result.note }
					</div>
					<div id="noteLayer${result.userNo }" style="display:none; z-index:5">
						<textarea name="note${result.userNo }" id="note${result.userNo }" class="span_25 height_274">${result.note }</textarea>
					</div>
					<!-- 특약사항  끝  -->
					<!-- 사장님께 하고 싶은 말 레이어  -->
					<div id="hopeNoteLayerView${result.userNo }" style="display:none; z-index:5">
						${result.hopeNote }
					</div>
					<div id="hopeNoteLayer${result.userNo }" style="display:none; z-index:5">
						<textarea name="hopeNote${result.userNo }" id="hopeNote${result.userNo }" class="span_25 height_274">${result.hopeNote }</textarea>
					</div>
					<!-- 사장님께 하고 싶은 말 레이어  끝  -->
					
				</td>
				<td>
					<input type="text" name="adminNote${result.userNo }" id="adminNote${result.userNo }" class="write_input11"
						value="${result.adminNote }"/>
				</td>
<!--				수정-->
				<td class="txt_center" colspan="2">
				<img  class="cursorPointer" onclick="javascript:editUserSalary('${result.userNo}', this);" src="${imagePath}/admin/btn/btn_modify02.gif"/>
				</td>
			</tr>		
		</c:forEach>
		
	</tbody>
	</table>