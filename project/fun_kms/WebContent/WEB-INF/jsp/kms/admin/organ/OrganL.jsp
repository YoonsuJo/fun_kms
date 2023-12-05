<%
 /**
  * @Class Name  : OrganL.jsp
  * @Description : OrganList 화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2011.09.07   민형식              최초 생성
  *
  *  @author 민형식
  *  @since 2011.09.07
  *  @version 1.0
  *  @see
  *  
  */
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<title>한마음 시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<%@ include file="../include/top_inc.jsp"%>
 

   <!-- styles for demo purpose>
    <style type="text/css">
        body {
            font-family: verdana, arial;
            font-size: 0.8em;
        }

        code {
            white-space: pre;
        }
    </style -->

 
    
    

<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/admin/organ/OrganList.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
function fnSearch_OrganList(){
	document.listForm.pageIndex.value = 1;
	document.listForm.action = "<c:url value='/admin/organ/OrganList.do'/>";
   	document.listForm.submit();

}
/* ********************************************************
 * 등록 처리 함수 
 ******************************************************** */
function fnRegist(orgnztId,orgLv){
		var varForm				 = document.all["Form"];
		varForm.action           = "<c:url value='/admin/organ/OrganRegist.do'/>";
		varForm.orgUp.value     = orgnztId;
		varForm.orgLv.value     = orgLv+1;
		
		varForm.orgnztId.value     = "";
		varForm.submit();
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fnModify(orgnztId){

	var varForm				 = document.all["Form"];
	varForm.action           = "<c:url value='/admin/organ/OrganModify.do'/>";
	varForm.orgnztId.value     = orgnztId;
	varForm.submit();
		
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fnDetail(orgnztId){
	var varForm				 = document.all["Form"];
	varForm.action           = "<c:url value='/admin/organ/OrganDetail.do'/>";
	varForm.orgnztId.value     = orgnztId;
	varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){

	
	// 
}
 


 -->
</script>

</head>
<body>
<a name="noscript" id="noscript">
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
</a>
<input type="text" id="vm" name="mv" value="" class="hidden"/>
<form id="listForm" name="listForm" action="<c:url value='/admin/organ/OrganList.do'/>" method="post">
 
<div id="admin_wrap">
	<!-- S: container -->
	<div id="admin_container">
		<ul class="admin_container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="admin_contents">
		<%@ include file="../left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">조직관리</li>
						</ul>
					</div>

					<span class="stxt">조직 현황을 조회합니다.</span>
					<span class="stxt_right"><img src="${imagePath}/admin/btn/btn_regist.gif" onclick="fnRegist('0',0); return false;" style="cursor:hand;"/></span>

					<!-- S: section -->
					<div class="section01">	

					<!-- 상단 검색창 시작 -->
					<!-- 2013.08.02 김대현 조직개편 검색 기능 추가  -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<tbody>
								<tr>
									<td class="txt_center">
										<input type="radio" id="searchCondition" name="searchCondition" value="1" <c:if test="${searchVO.searchCondition == '1'}">checked="checked"</c:if>>레벨
									   	<select name="searchLV" class="span_4" title="" onKeyPress="javascript:if(event.keyCode==13) fnSearch_OrganList();">
											   <option selected value=''><label for="searchLV">-선택-</label></option>
											   <option value='1' <c:if test="${searchVO.searchLV == '1'}">selected="selected"</c:if>><label for="searchLV">1</label></option>
											   <option value='2' <c:if test="${searchVO.searchLV == '2'}">selected="selected"</c:if>><label for="searchLV">2</label></option>
											   <option value='3' <c:if test="${searchVO.searchLV == '3'}">selected="selected"</c:if>><label for="searchLV">3</label></option>
											   <option value='4' <c:if test="${searchVO.searchLV == '4'}">selected="selected"</c:if>><label for="searchLV">4</label></option>
											   <option value='5' <c:if test="${searchVO.searchLV == '5'}">selected="selected"</c:if>><label for="searchLV">5</label></option>
 									    </select>										
										<span class="pL7" ></span>
										<input type="radio" name="searchCondition" value="2"  <c:if test="${searchVO.searchCondition == '2'}">checked="checked"</c:if>>상위조직<span class="pL7"></span>
										<input id="findOrgan2"  type="text" name="searchUp" class="search_txt02" value="${searchVO.searchUp}"  onkeyup="javascript:if(event.keyCode==40) lfn_searchWord();"  onclick="orgGen(this,'findOrgan2');"/>
										<input type="radio" name="searchCondition" value="3"  <c:if test="${searchVO.searchCondition == '3'}">checked="checked"</c:if>>조직명
										<input id="findOrgan" type="text" name="searchOrgNm" class="search_txt02" value="${searchVO.searchOrgNm}" onclick="orgGen(this,'findOrgan');"/><!-- 조직도 트리 fn_org(입력창id명,Form id명) src="${commonPath}/js/default.js 에 소스있음-->
										<img src="${imagePath}/admin/btn/btn_search02.gif" alt="검색" onclick="fnSearch_OrganList(); return false;"/>
									</td>
								</tr>
							</tbody>
							</table>
		                    </div>
		                </fieldset>
		                <!-- 상단 검색창 끝 -->
		                
						<!-- 게시판 시작 -->
						<p class="th_stitle">조직목록</p>
						<div class="boardList">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>사원조회</caption>
							<colgroup>
								<col class="col5" />
								<col class="col100" />
								<col width="px" />
								<col class="col70" />
								<col class="col70" />
								<col class="col70" />
															
								<col class="col90" />		
								<col class="col70" />
								<col class="col40" />
								<col class="col20" />
								<col class="col5" />
							</colgroup>
							<thead>
								<tr>
								<th class="th_left"></th>
								<th scope="col">상위조직</th>
								<th scope="col">조직명</th>
								<th scope="col">조직레벨</th>
								<th scope="col">정렬순서</th>
								
								<th scope="col">수정자</th>								
								<th scope="col">수정일</th>
								<th scope="col">사용여부</th>
								<th scope="col" colspan="2">생성/변경</th>
								<th class="th_right"></th>
								</tr>
							</thead> 
							<tbody>
								<c:forEach items="${resultList}" var="result" varStatus="status">							
								<tr  style="cursor:pointer;cursor:hand;" >
									<td class="txt_center" colspan="2"  onclick="javascript:fnDetail('${result.orgnztId}');"><c:out value="${result.orgUpNm}"/></td>
									<td class="txt_center" onclick="javascript:fnDetail('${result.orgnztId}');"><c:out value="${result.orgnztNm}"/></td>
									<td class="txt_center" onclick="javascript:fnDetail('${result.orgnztId}');"><c:out value="${result.orgLv}"/></td>
									<td class="txt_center" onclick="javascript:fnDetail('${result.orgnztId}');"><c:out value="${result.ord}"/></td>
									<td class="txt_center" onclick="javascript:fnDetail('${result.orgnztId}');"><c:out value="${result.lastUpdusrId}"/></td>
									<td class="txt_center" onclick="javascript:fnDetail('${result.orgnztId}');"><c:out value="${result.lastUpdusrPnttm}"/></td>
									<td class="txt_center" onclick="javascript:fnDetail('${result.orgnztId}');"><c:if test="${result.useYn == 'Y'}">사용</c:if><c:if test="${result.useYn == 'N'}">미사용</c:if></td>
									<td class="txt_center" ><img src="${imagePath}/admin/btn/btn_plus.gif" onclick="javascript:fnRegist('${result.orgnztId}',${result.orgLv});" style="cursor:hand;"/></td>
									<td colspan="2" class="txt_center"><img src="${imagePath}/admin/btn/btn_write01.gif" onclick="javascript:fnModify('${result.orgnztId}');" style="cursor:hand;"/></td>
								</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						<!-- 게시판 끝  -->		                


						<!-- 하단 숫자 시작 -->
						<div class="paginate">
							<c:if test="${fn:length(resultList) == 0}">
								<tr> 
									<td class="lt_text3" colspan=8>
										<spring:message code="common.nodata.msg" />
									</td>
								</tr>   	          				 			   
							</c:if>

							<ui:pagination paginationInfo = "${paginationInfo}"
									type="image"
									jsFunction="linkPage"				/>
						</div>
						<!-- 하단 숫자 끝 -->
 
					</div>
					<!-- E: section -->	
				</div>
				<!-- E: center -->
			</div>	
			<!-- E: centerBg -->		
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/admin_footer.jsp"%>
</div>
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>

</form>
    
<form name="Form" method="post">
	<input type=hidden name="orgnztId" >
	<input type=hidden name="orgUp"> 
	<input type=hidden name="orgLv">
	<!-- input type="submit" id="invisible" class="invisible"/-->
</form>
<form name="ListFormName" id="listFormName" method="post"> 
	<input type=hidden name="workSt" value="W"> <!--사용자 검색 구분값 1:사용자, 2:부서 -->
	<input type=hidden name="searchCondition" value="1"> <!--사용자 검색 구분값 1:사용자, 2:부서 -->
	<input type=hidden name="searchKeyword" id="searchKeyword" value="aa"> <!--설명 검색 -->
</form>

<!-- 조직 목록 레이어 -->
<div id="tabs-1">
</div>

<div id="names">
</div>


</body>
</html>