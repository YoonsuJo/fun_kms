<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<style>
@page a4sheet { size: 21.0cm 29.7cm }
.a4 { page: a4sheet; page-break-after: always }
</style>

</head>
<body>
<div id="wrap">
	<!-- S: section -->
	<div class="salary a4">
		<div class="salary_tl" >연봉제 근로계약서</div>
			<!-- 게시판 시작  -->
		<p>(주)${company.codeNm } (이하 '갑'이라 칭함)와 ${memberVO.userNmLong }(이하 '을'이라 칭함)은(는) 상호합의 하에 아래사항에 대하여 성실히 준수할 것을 서약하며 본 근로계약을 체결한다.</p>
		
		<dl>
			<dt>제 1조 (근로계약 조건)</dt>
			<dd>
				<div class="mT5 mB5">
				<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
				<caption>근로계약서</caption>
					<colgroup>
						<col class="col130" />
						<col width="px" />
						<col class="col130" />
						<col class="col130" />
						<col class="col130" />
					</colgroup>
					<thead>
						<tr>
							<th class="left_line">입사일</th>
							<th>연봉계약기간<br/>(근로계약기간)</th>
							<th>근무일</th>
							<th>근무시간</th>
							<th>근무지</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="left_line txt_center">					                                
								${salaryVO.acceptCompinDtPrint }
							</td>
							<td class="txt_center">
								<c:if test="${salaryVO.year == salaryVO.acceptCompinDtYear }"> ${salaryVO.acceptCompinDtPrint } ~ ${salaryVO.year }. 12. 31 </c:if>
								<c:if test="${salaryVO.year != salaryVO.acceptCompinDtYear }"> ${salaryVO.year }. 01. 01 ~ ${salaryVO.year }. 12. 31 </c:if>
								<br/>(정함이 없음)
							</td>
							<td class="txt_center">평일근무 (월~금)</td>
							<td class="txt_center">09:00 ~ 18:00<br/><span style="font-size:10px;">(휴계시간 12:00~13:00)</span></td>
							<td class="txt_center">본사</td>
						</tr>
					</tbody>
				</table>
				</div>
			</dd>
			<dd>1) 단, '을'은 '갑'이 업무상 행하는 담당업무 및 근무장소 등의  전환배치에 따르기로 한다</dd>
			<dd>2) 근무시간은 근무지의 여건에 따라 변경될 수 있으며, 토요일은 무급 휴일로 한다.</dd>
		</dl>
		
		<dl>
			<dt>제2조 (휴일ㆍ휴가)</dt>
			<dd>1. 유급휴일 : 근로자의 날, 주휴일(매주 1일 일요일), 기타 '갑' 이 정하는 날로 한다.</dd>
			<dd>2. 연차유급휴가 : 1년간 8할 이상 근무 시 15일의 유급휴가를 부여하되, 그 구체적인 내용은 근로기준법 및 취업규칙에 정한 기준에 따른다.</dd>
		</dl>

		<dl>
			<dt>제3조 (연봉의 구성)</dt>
			<dd>1. 연봉, 연봉의 구성 및 월 지급액</dd>
			<dd>
				<div class="mT5 mB5">
				<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
				<caption>근로계약서</caption>
					<colgroup>
						<col width="px" />
						<col class="col100" />
						<col class="col100" />
						<col class="col100" />
						<col class="col100" />
						<col class="col100" />
						<col class="col100" />
					</colgroup>
					<thead>
						<tr>
							<th class="left_line" rowspan="2">연봉</th>
							<th colspan="6">월지급액</th>
						</tr>
						<tr>
							<th>기본급</th>
							<th>차량유지비</th>
							<th>식대</th>
							<th>보육수당</th>
							<th>통신비</th>
							<th>월지급총액</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="left_line txt_right pR10"><print:currency cost="${salaryVO.salaryReal }" />원</td>
							<td class="txt_right pR10"><print:currency cost="${salary1 }" />원</td>
							<td class="txt_right pR10"><print:currency cost="${salary2 }" />원</td>
							<td class="txt_right pR10"><print:currency cost="${salary3 }" />원</td>
							<td class="txt_right pR10"><print:currency cost="${salary5 }" />원</td>
							<td class="txt_right pR10"><print:currency cost="${salary6 }" />원</td>
							<td class="txt_right pR10"><print:currency cost="${salary4 }" />원</td>
						</tr>
					</tbody>
				</table>
				</div>
			</dd>
			<dd>2. 지급방법은 연봉액을 12로 나눈 금액으로 익월 10일에 지급한다.</dd>
			<dd>3. 수습기간은 입사일로부터 3개월로 한다. 단, 수습기간 중 급여는 100% 지급한다.</dd>
		</dl>
		
		<dl>
			<dt>제4조 (퇴직급여제도)</dt>
			<dd>1. 관계법령에 의거 1년 이상 근로한 경우에는 퇴직금을 지급한다.</dd>
			<dd>2. '갑'은 퇴직급여제도에 대하여 확정기여형 퇴직연금제도를 설정하여 운용한다.</dd>
		</dl>
		
		<dl>
			<dt>제5조 (기타)</dt>
			<dd>
				<ol class="mT5">
					<li class="underline">1. '을'은 자신의 연봉액을 동료 근로자에게 절대 누설하지 않으며 이를 어길 경우 본사 취업규칙에 의거 징계처분 받을 수 있음을 확인한다.</li>
					<li class="underline">2. '을'은 재직중 업무상 취득한 갑의 영업상 기밀사항에 대하여 재직기간 및 퇴직이후에도 비밀엄수의 의무를 지니며, 이를 위반할 경우 갑에 대하여 환산 가능한 경제적 손실범위 내에서 손해배상의 책임을 지며, 퇴사후 2년이내에 당사와 협의없이 경쟁사로 이직하지 아니한다.</li>
					<li class="underline">3. 갑'은 신규로 채용내정된 자에 대하여 입사일로부터 3개월의 수습기간을 적용하며, 그 기간 중 채용부적격자는 근로기준법 35조에 의거 본 채용을 거부할 수 있다.</li>
					<li>4. 계약기간중 '을'에게 퇴직 및 해고사유가 발생시 '갑'은 '을'과의 근로계약을 해지할 수 있으며, '을'이 계약기간 중 계약을 해지하고자 하는 경우는 30일 전에 사직서를 제출하며 후임자를 선임하여 업무를 인계하고 인수인계 완료시까지 성실하게 근무하여야 한다.</li>
					<li>5. 본 계약을 체결함에 있어 명시되지 않은 사항에 대해서는 취업규칙 및 기타규정에 정한 바에 따르고 이에도 정함이 없는 사항은 근로기준법, 기타 노동 관계법령 및 통상 관례에 따른다.</li>
				</ol>
			</dd>
		</dl>
		
		<c:if test="${salaryVO.noteYn == 'Y' }">
			<dl>
         		<dt>제6조 (특약사항)</dt>
             	<dd>
             		<p><print:textarea text="${salaryVO.note}"/></p>
             	</dd>
        	</dl>
        </c:if>
					            
		<p class="mT5">본 계약서는 후일 입증자료로 활용될 수 있으며, 갑과 을이 각각 1부씩 보관한다.</p>
		<p class="txt_center mT5">상기 내용과 같이 근로계약을 체결함.</p>
		<p class="txt_center mT5" style="page-break-after:avoid">
			<c:if test="${salaryVO.year == salaryVO.acceptCompinDtYear }"> ${salaryVO.acceptCompinDtPrintLong } </c:if>
			<c:if test="${salaryVO.year != salaryVO.acceptCompinDtYear }"> ${salaryVO.year } 년 01 월  01 일</c:if>
		</p>

		<div class="mT5 mB5">
			<table cellpadding="0" cellspacing="0" summary="">
			<caption>근로계약서</caption>
				<colgroup>
					<col width="50%" />
					<col width="50%" />
				</colgroup>
				<thead>
					<tr>
						<th class="left_line">갑</th>
						<th>을</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="left_line pL10">${company.codeDc }</td>
						<td class="txt_left pL10">
							${memberVO.userNmLong } (서명 또는 직인)<br>
							주민번호 : ${memberVO.ihidNumFront }-${memberVO.ihidNumBack }<br>
							주      소 : ${memberVO.homeAdres }
						</td>
					</tr>
				</tbody>
			</table>
			<!--// 게시판  끝  -->
		</div>
	</div>								
	<!-- E: section -->
</div>
<script>
$(document).ready(function(){
	window.print();
	/* window.close(); */
});
</script></body>
</html>