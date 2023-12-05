<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../include/ajax_inc.jsp"%>

<script>
	
</script>
<!-- 부서 및 사업기간  -->
<form:form commandName="specificVO" id="specificVO" name="specificVO" method="post" enctype="multipart/form-data">
	<!-- 예산 승인 대상 프로젝트 및 기간  -->
	<p class="th_stitle2 mB10">예산 배정 대상자 및 기간</p>
	<div class="boardWrite02 mB20">
	<table cellpadding="0" cellspacing="0"
		summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>예산 배정 대상자 및 기간</caption>
		<colgroup>
			<col class="col120" />
			<col width="px" />
		</colgroup>
		<tbody>
			<tr>
				<td class="title">사용자</td>
				<td class="pL10">
					<input type="text" name="userMix" id="userMix" 
						<c:if test="${not empty specificVO.userNm}">
						 value="${specificVO.userNm}(${specificVO.userId})"
						 </c:if>
					 class="span_12 userNameAuto userValidateCheck" /> 
					<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" id="userTreeB"/>
				</td>
			</tr>
			<tr>
				<td class="title">년도</td>
				<td class="pL10">
					<select name="year">
					<c:forEach items="${yearList}" var="result">  
						<option value="${result}" <c:if test="${specificVO.year==result}">selected</c:if>>
							${result}
						</option>
					</c:forEach>
					
				</select>
				</td>
			</tr>
		</tbody>
	</table>
	</div>
	<div id="expenseAllD">
		<p class="th_stitle2 mB10">기초영업비 예산 <img src="${imagePath}/btn/btn_add.gif" id="expenseAddB" class="cursorPointer"><span class="th_plus02">[단위 :천원]</span></p>
		<c:forEach items="${expenseList}" var="result">
			<div class="boardWrite02 mB20">
				<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                  <caption>기초영업비 예산</caption>
	                  <colgroup>
	                  	<col class="col120" />
	                  	<col width="px" />
	                  	<col width="px" />
	                  	<col width="px" />
	                  	<col width="px" />
	                  	<col width="px" />
	                  	<col width="px" />
	                  	<col width="px" />
	                  	<col width="px" />
	                  	<col width="px" />
	                  	<col width="px" />
	                  	<col width="px" />
	                  	<col width="px" />
	                  </colgroup>
	                  <tbody>
	                  	<tr>
	                   	<td class="title">프로젝트</td>
	                   	<td class="pL10 Br02" colspan="12">
	                   		<input type="text" name="prjNm" class="span_12" readonly="true" value="${result.prjNm }"/>
	                   		<input type="hidden" name="prjId" value="${result.prjId }"/>
	                   		<img src="${imagePath }/btn/btn_tree.gif" class="cursorPointer prjTreeB">
	                   		<img src="${imagePath }/btn/btn_delete03.gif" class="cursorPointer deleteB">
	                   	</td>
	                  	</tr>
	                  	<tr>
	                   	<td class="title" >월</td>
	                   	<td class="Br">1월</td>
	                   	<td class="Br">2월</td>
	                   	<td class="Br">3월</td>
	                   	<td class="Br">4월</td>
	                   	<td class="Br">5월</td>
	                   	<td class="Br">6월</td>
	                   	<td class="Br">7월</td>
	                   	<td class="Br">8월</td>
	                   	<td class="Br">9월</td>
	                   	<td class="Br">10월</td>
	                   	<td class="Br">11월</td>
	                   	<td class="Br">12월</td>
	                  	</tr>
	                  	<tr>
	                   	<td class="title">금액</td>
	                   	<td class="Br02">
	                   		<input type="text" name="month[]" class="span_1 currency1000" value="<print:currency cost="${result.month1}" divideBy="1000"/>" />
	                   	</td>
	                   	<td class="Br02">
	                   		<input type="text" name="month[]" class="span_1 currency1000" value="<print:currency cost="${result.month2}" divideBy="1000"/>" />
	                   	</td>
	                   	<td class="Br02">
	                   		<input type="text" name="month[]" class="span_1 currency1000" value="<print:currency cost="${result.month3}" divideBy="1000"/>" />
	                   	</td>
	                   	<td class="Br02">
	                   		<input type="text" name="month[]" class="span_1 currency1000" value="<print:currency cost="${result.month4}" divideBy="1000"/>" />
	                   	</td>
	                   	<td class="Br02">
	                   		<input type="text" name="month[]" class="span_1 currency1000" value="<print:currency cost="${result.month5}" divideBy="1000"/>" />
	                   	</td>
	                   	<td class="Br02">
	                   		<input type="text" name="month[]" class="span_1 currency1000" value="<print:currency cost="${result.month6}" divideBy="1000"/>" />
	                   	</td>
	                   	<td class="Br02">
	                   		<input type="text" name="month[]" class="span_1 currency1000" value="<print:currency cost="${result.month7}" divideBy="1000"/>" />
	                   	</td>
	                   	<td class="Br02">
	                   		<input type="text" name="month[]" class="span_1 currency1000" value="<print:currency cost="${result.month8}" divideBy="1000"/>" />
	                   	</td>
	                   	<td class="Br02">
	                   		<input type="text" name="month[]" class="span_1 currency1000" value="<print:currency cost="${result.month9}" divideBy="1000"/>" />
	                   	</td>
	                   	<td class="Br02">
	                   		<input type="text" name="month[]" class="span_1 currency1000" value="<print:currency cost="${result.month10}" divideBy="1000"/>" />
	                   	</td>
	                   	<td class="Br02">
	                   		<input type="text" name="month[]" class="span_1 currency1000" value="<print:currency cost="${result.month11}" divideBy="1000"/>" />
	                   	</td>
	                   	<td class="Br02">
	                   		<input type="text" name="month[]" class="span_1 currency1000" value="<print:currency cost="${result.month12}" divideBy="1000"/>" />
	                   	</td>
	                  	</tr>
	                  </tbody>
	             </table>
			</div>
		</c:forEach>
	</div>


</form:form>