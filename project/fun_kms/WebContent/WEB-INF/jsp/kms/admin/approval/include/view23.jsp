<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../include/ajax_inc.jsp"%>

<script>
	
</script>
<!-- 부서 및 사업기간  -->
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
				<print:user userNo="${specificVO.userNo}" userNm="${specificVO.userNm}"/> 
			</td>
		</tr>
		<tr>
			<td class="title">년도</td>
			<td class="pL10">
				${specificVO.year}년
			</td>
		</tr>
	</tbody>
</table>
</div>
<div id="expenseAllD">
	<p class="th_stitle2 mB10">기초영업비 예산 <span class="th_plus02">[단위 :천원]</span></p>
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
                   		<print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}"/>
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
                   		<print:currency cost="${result.month1}" divideBy="1000"/>
                   	</td>
                   	<td class="Br02">
                   		<print:currency cost="${result.month2}" divideBy="1000"/>
                   	</td>
                   	<td class="Br02">
                   		<print:currency cost="${result.month3}" divideBy="1000"/>
                   	</td>
                   	<td class="Br02">
                   		<print:currency cost="${result.month4}" divideBy="1000"/>
                   	</td>
                   	<td class="Br02">
                   		<print:currency cost="${result.month5}" divideBy="1000"/>
                   	</td>
                   	<td class="Br02">
                   		<print:currency cost="${result.month6}" divideBy="1000"/>
                   	</td>
                   	<td class="Br02">
                   		<print:currency cost="${result.month7}" divideBy="1000"/>
                   	</td>
                   	<td class="Br02">
                   		<print:currency cost="${result.month8}" divideBy="1000"/>
                   	</td>
                   	<td class="Br02">
                   		<print:currency cost="${result.month9}" divideBy="1000"/>
                   	</td>
                   	<td class="Br02">
                   		<print:currency cost="${result.month10}" divideBy="1000"/>
                   	</td>
                   	<td class="Br02">
                   		<print:currency cost="${result.month11}" divideBy="1000"/>
                   	</td>
                   	<td class="Br02">
                   		<print:currency cost="${result.month12}" divideBy="1000"/>
                   	</td>
                  	</tr>
                  </tbody>
             </table>
		</div>
	</c:forEach>
</div>


