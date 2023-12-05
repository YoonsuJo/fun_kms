<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="ProgId" content="Excel.Sheet">
<meta name="Generator" content="Microsoft Excel 11">
<%@ include file="../include/ajax_inc.jsp"%>
<style>
table {
	width:100%; 
	border-top:1px solid #d0d7e5; 
	border-left:1px solid #d0d7e5;
	font-family:"돋움" , doutm, tahoma, helvetica; 
	font-size:12px; 
	color:#444; 
	text-align:center;
	}
th {
	border-bottom:1px solid #d0d7e5; 
	border-right:1px solid #d0d7e5;
	background-color:#ebf0f6;
	height:26px;
	}
td {
	border-bottom:1px solid #d0d7e5;
	border-right:1px solid #d0d7e5; 
	height:26px;
	}
</style>
</head>
<body>

<table border="0" cellpadding="0" cellspacing="0">
	<caption></caption>
<!--	<caption>개인정보</caption>-->
	<colgroup>
		<col class="col180" />
		<col class="col120" />
		<col class="px" />
		<col class="col120" />
		<col width="px" />
	</colgroup>
	<tbody>
		<tr>
			<td class="pL10" rowspan="8">
				&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp 사진 
			</td>		
			<td class="txt_center bc01" style="background-color:#dbdbdb; ">이름</td>
			<td class="pL10" >
				${info.userNm} (${info.age}세)
			</td>
			<td class="txt_center bc01" style="background-color:#dbdbdb; ">영문이름</td>
			<td class="pL10" ><c:out value="${info.userEnm}" /></td>										
		</tr>
              				                    		
		<tr>
			<td class="txt_center bc01" style="background-color:#dbdbdb; ">소속부서</td>
			<td class="pL10" colspan="1" ><c:out value="${info.orgnztNm}" /></td>
            <td class="txt_center bc01" style="background-color:#dbdbdb; ">직급</td>
			<td class="pL10" ><c:out value="${info.rankNm}" /></td>
		</tr>									
		<tr>
			<td class="txt_center bc01" style="background-color:#dbdbdb; ">주민등록번호</td>
			<td class="pL10"><c:out value="${info.ihidNumPrint}" /></td>
			<td class="txt_center bc01" style="background-color:#dbdbdb; ">회사메일</td>
			<td class="pL10"><c:out value="${info.emailAdres}" /></td>
		</tr>									
		<tr>	
			<td class="txt_center bc01" style="background-color:#dbdbdb; ">입사일</td>
			<td class="pL10">
				${fn:substring(info.compinDt,0,4)}.${fn:substring(info.compinDt,4,6)}.${fn:substring(info.compinDt,6,8)}
			</td>
			<td class="txt_center bc01" style="background-color:#dbdbdb; ">휴대전화</td>
			<td class="pL10"><c:out value="${info.moblphonNo}" /></td>										
		</tr>
		<tr>
			<td class="txt_center bc01" style="background-color:#dbdbdb; ">주소</td>
			<td class="pL10" colspan="3"><c:out value="${info.homeAdres}" /></td>
		</tr>								
		<tr>
			<td class="txt_center bc01" style="background-color:#dbdbdb; ">면허종류</td>
            <td class="pL10" colspan="1">${info.carLicTypPrint}</td>	
			<td class="txt_center bc01" style="background-color:#dbdbdb; ">차량번호</td>
			<td class="pL10" ><c:out value="${info.carId}" /></td>					
		</tr>									
        <tr>
			<td class="txt_center bc01" style="background-color:#dbdbdb; ">SW기술등급</td>
			<td class="pL10" colspan="1">${careerMain.swLevel}</td>	
			<td class="txt_center bc01" style="background-color:#dbdbdb; ">경력기간</td>
			<td class="pL10"> 
				<c:if test="${careerMain.workMonth==null}">미입력</c:if>
				<c:if test="${careerMain.workMonth!=null}">
					${careerMain.workYear}년
					${careerMain.workMonth}개월
				</c:if>
			</td>
		</tr>		                    		
		<tr>
			<td class="txt_center bc01" style="background-color:#dbdbdb; ">병역사항</td>
			<td class="pL10" colspan="3">				                    	
				<c:if test="${careerMain.militaryService==null}">미입력</c:if>				                    		
				<c:if test="${careerMain.militaryService==''}">없음</c:if>				                    		
				<c:if test="${careerMain.militaryService!=null && careerMain.militaryService != ''}">								                    		
					<b>군별</b> :					                    	
					<c:if test="${careerMain.militaryService!=null}">${careerMain.militaryService}</c:if>
					
					<b>기간</b> :
					<c:if test="${careerMain.msStDt==null || careerMain.msStDt==''}">미입력</c:if>
					<c:if test="${careerMain.msStDt!=null && careerMain.msStDt!=''}">					                    	
					${fn:substring(careerMain.msStDt,0,4)}.${fn:substring(careerMain.msStDt,4,6)}.${fn:substring(careerMain.msStDt,6,8)} 
					~ 
					${fn:substring(careerMain.msEdDt,0,4)}.${fn:substring(careerMain.msEdDt,4,6)}.${fn:substring(careerMain.msEdDt,6,8)} 
					</c:if>		                    	   	
					<b>계급</b> :
					<c:if test="${careerMain.msLevel==null || careerMain.msLevel==''}">미입력</c:if>
					<c:if test="${careerMain.msLevel!=null && careerMain.msLevel!=''}">${careerMain.msLevel}</c:if>				
				</c:if>
			</td>
		</tr>              				                    		
</tbody>
</table>

<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption >기술</caption>
	<colgroup>
		<col class="col180" />
		<col class="col120" />
		<col class="px" />
		<col class="col120" />
		<col width="px" />
	</colgroup>
	<tbody>			                    	                    		
<!--		<tr>-->
<!--			<td class="txt_center bc01" colspan="5"  style="background-color:#dbdbdb;">-->
<!--			기   술</td>-->
<!--		</tr>-->
		<tr>		                    			
			<td class="txt_center bc01" style="background-color:#dbdbdb; ">개발언어</td>
		  	<td class="pL10" colspan="4">
		  		<print:textarea text="${careerMain.skillLang}"/>
		  	</td>
		</tr>
        <tr>
			<td class="txt_center bc01" style="background-color:#dbdbdb; ">DBMS</td>
		  	<td class="pL10" colspan="4">
		  		<print:textarea text="${careerMain.skillDbms}"/>
		  	</td>
		</tr>		                    		
		<tr>
			<td class="txt_center bc01" style="background-color:#dbdbdb; ">Tool</td>
		  	<td class="pL10" colspan="4">
		  		<print:textarea text="${careerMain.skillTool}"/>
		  	</td>
		</tr>		                    		
		<tr>
			<td class="txt_center bc01" style="background-color:#dbdbdb; ">OS</td>
		  	<td class="pL10" colspan="4">
		   		<print:textarea text="${careerMain.skillOs}"/>
		  	</td>
		</tr>	
		<tr>
          	<td class="txt_center bc01" style="background-color:#dbdbdb; ">
          		비밀취급인가 근거 &nbsp&nbsp&nbsp&nbsp&nbsp 
          	</td>
          	<td class="pL10" colspan="2">${careerMain.securityBasis}</td>
          	<td class="txt_center bc01" style="background-color:#dbdbdb; ">비밀취급인가증 번호</td>
          	<td class="pL10" colspan="1">${careerMain.securityNo}</td>
         </tr>		                    		
	</tbody>
</table>					

<c:if test="${memberCareerAuthority!=true}">학력 정보는 본인, 팀장, 부서장, 본부장만 조회 가능합니다.</c:if>
<c:if test="${memberCareerAuthority==true}">

<ul> </ul>
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>학력</caption>
		<colgroup>
			<col width="50px" />
			<col width="180px" />
			<col width="px" />
			<col width="200px" />
			<col width="80px" />
		</colgroup>
		<thead>
			<tr> 
				<th scope="col" style="background-color:#dbdbdb;">번호</th>
				<th scope="col" style="background-color:#dbdbdb;">학교</th>
				<th scope="col" style="background-color:#dbdbdb;">전공</th>
				<th scope="col" style="background-color:#dbdbdb;">기간</th>
				<th scope="col" style="background-color:#dbdbdb;">졸업유무</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${careerEdu}" var="edu" varStatus="c">
				<tr> 
					<td class="txt_center" >${c.count }</td>
					<td class="txt_center">${edu.schoolName}</td>
					<td class="txt_center">${edu.major}</td>
					<td class="txt_center">
						<c:if test="${edu.stDt==null && edu.edDt==null}">미입력</c:if>												
						<c:if test="${edu.stDt!=null}">					                    	
							${fn:substring(edu.stDt,0,4)}.${fn:substring(edu.stDt,4,6)}.${fn:substring(edu.stDt,6,8)} ~
		 					</c:if>
						<c:if test="${edu.stDt==null && edu.edDt!=null}">~</c:if>							
						<c:if test="${edu.edDt!=null}">													
							${fn:substring(edu.edDt,0,4)}.${fn:substring(edu.edDt,4,6)}.${fn:substring(edu.edDt,6,8)}
		                  	</c:if>												
					</td>
					<td class="txt_center">
						<c:if test="${edu.graduationYn=='graduation'}">졸업</c:if>
						<c:if test="${edu.graduationYn=='leave'}">중퇴</c:if>
						<c:if test="${edu.graduationYn=='stop'}">휴학</c:if>
						<c:if test="${edu.graduationYn=='being'}">재학</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>												
</c:if>


<ul> </ul>
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
    <caption>교육</caption>
    <colgroup>
    	<col width="50px" />
    	<col width="180px" />
    	<col width="px" />
    	<col width="200px" />
    	<col width="80px" />
    </colgroup>
    <thead>
   		<tr> 
			<th scope="col" style="background-color:#dbdbdb;">번호</th>
			<th scope="col" style="background-color:#dbdbdb;">교육과정명</th>
			<th scope="col" style="background-color:#dbdbdb;">교육기관</th>
			<th scope="col" style="background-color:#dbdbdb;">교육기간</th>
			<th scope="col" style="background-color:#dbdbdb;">수료번호</th>
		</tr>
   	</thead> 
    <tbody>
		<c:forEach items="${careerTrain}" var="train" varStatus="c">
			<tr> 
				<td class="txt_center" >${c.count }</td>
				<td class="txt_center">${train.trainNm}</td>
				<td class="txt_center">${train.trainOrgNm}</td>
				<td class="txt_center">													
	                  	<c:if test="${train.stDt==null && train.edDt==null}">미입력</c:if>												
	                  	<c:if test="${train.stDt!=null}">					                    	
	                   	${fn:substring(train.stDt,0,4)}.${fn:substring(train.stDt,4,6)}.${fn:substring(train.stDt,6,8)} ~
	                   </c:if>
	                   <c:if test="${train.stDt==null && edu.edDt!=null}">~</c:if>							
					<c:if test="${train.edDt!=null}">													
						${fn:substring(train.edDt,0,4)}.${fn:substring(train.edDt,4,6)}.${fn:substring(train.edDt,6,8)}
	                  	</c:if>														
				</td>
				<td class="txt_center">${train.trainNo}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>


				
               		
<ul></ul>
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
    <caption>자격증</caption>
    <colgroup>
    	<col width="50px" />
    	<col width="180px" />
    	<col width="px" />
    	<col width="200px" />
    	<col width="80px" />
    </colgroup>
    <thead>
   		<tr> 
			<th scope="col" style="background-color:#dbdbdb;">번호</th>
			<th scope="col" style="background-color:#dbdbdb;">종목 및 등급</th>
			<th scope="col" style="background-color:#dbdbdb;">발급기관</th>
			<th scope="col" style="background-color:#dbdbdb;">자격등록번호</th>
			<th scope="col" style="background-color:#dbdbdb;">합격년월일</th>
		</tr>
	</thead> 
	<tbody>									
		<c:forEach items="${careerLicense}" var="license" varStatus="c">
			<tr> 
				<td class="txt_center" >${c.count }</td>
				<td class="txt_center">${license.licenseNm}</td>
				<td class="txt_center">${license.issuedOrg}</td>
				<td class="txt_center">${license.licenseNo}</td>
				<td class="txt_center">
					<c:if test="${license.passedDate==null }">미입력</c:if>												
	                  	<c:if test="${license.passedDate!=null}">					                    	
	                   	${fn:substring(license.passedDate,0,4)}.${fn:substring(license.passedDate,4,6)}.${fn:substring(license.passedDate,6,8)}
	                   </c:if>							                   
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>



<ul></ul>
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>근무처 경력</caption>
	<colgroup>
		<col width="50px" />
		<col width="180px" />
		<col width="px" />
		<col width="80px" />
		<col width="100px" />
		<col width="80px" />
	</colgroup>
	<thead>
  		<tr>
  			<th scope="col" style="background-color:#dbdbdb;">번호</th>
			<th scope="col" style="background-color:#dbdbdb;">회사명</th>
			<th scope="col" style="background-color:#dbdbdb;">근무기간</th>
			<th scope="col" style="background-color:#dbdbdb;">담당업무</th>
			<th scope="col" style="background-color:#dbdbdb;">부서</th>
			<th scope="col" style="background-color:#dbdbdb;">직위</th>
		</tr>
   	</thead>
    <tbody>									
		<c:forEach items="${careerWork}" var="work" varStatus="c">
			<tr> 
				<td class="txt_center" >${c.count }</td>
				<td class="txt_center">${work.companyNm}</td>
				<td class="txt_center">												
	                  	<c:if test="${work.stDt==null && work.edDt==null}">미입력</c:if>												
	                  	<c:if test="${work.stDt!=null}">					                    	
	                   	${fn:substring(work.stDt,0,4)}.${fn:substring(work.stDt,4,6)}.${fn:substring(work.stDt,6,8)} ~
	                   </c:if>
	                   <c:if test="${work.stDt==null && work.edDt!=null}">~</c:if>							
					<c:if test="${work.edDt!=null}">													
						${fn:substring(work.edDt,0,4)}.${fn:substring(work.edDt,4,6)}.${fn:substring(work.edDt,6,8)}
	                  	</c:if>									
				</td>											
				<td class="txt_center">${work.task}</td>											
				<td class="txt_center">${work.orgnztNm}</td>											
				<td class="txt_center">${work.rankNm}</td>
			</tr>											
		</c:forEach>
	</tbody>
</table>



<ul></ul>
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>경력</caption>
	<colgroup>
		<col width="50px" />
		<col width="180px" />
		<col width="px" />
		<col width="80px" />
		<col width="100px" />
		<col width="80px" />
	</colgroup>
	<thead>
  		<tr>
  			<th scope="col" style="background-color:#dbdbdb;">번호</th>
			<th scope="col" style="background-color:#dbdbdb;">사업명</th>
			<th scope="col" style="background-color:#dbdbdb;">참여기간</th>
			<th scope="col" style="background-color:#dbdbdb;">담당업무</th>
			<th scope="col" style="background-color:#dbdbdb;">발주처</th>
			<th scope="col" style="background-color:#dbdbdb;">비고</th>
		</tr>
	</thead> 
	<tbody>
	   	<c:forEach items="${careerSkill}" var="skill" varStatus="c">
			<tr> 
				<td class="txt_center">${c.count }</td>
				<td class="pL10" >${skill.prjNm}</td>
				<td class="txt_center" >
					<c:if test="${skill.stDt==null && skill.edDt==null}">미입력</c:if>												
	                  	<c:if test="${skill.stDt!=null}">					                    	
	                   	${fn:substring(skill.stDt,0,4)}.${fn:substring(skill.stDt,4,6)}.${fn:substring(skill.stDt,6,8)} ~
	                   </c:if>
	                   <c:if test="${skill.stDt==null && skill.edDt!=null}">~</c:if>							
					<c:if test="${skill.edDt!=null}">													
						${fn:substring(skill.edDt,0,4)}.${fn:substring(skill.edDt,4,6)}.${fn:substring(skill.edDt,6,8)}
	                  	</c:if>	
				</td>
				<td class="txt_center" >${skill.task}</td>
				<td class="txt_center" >${skill.clientNm}</td>
				<td class="txt_center" >${skill.note}</td>
			</tr>										
		</c:forEach>
	</tbody>
</table>


					
<!--// 게시판 끝  -->
</body>
</html>
