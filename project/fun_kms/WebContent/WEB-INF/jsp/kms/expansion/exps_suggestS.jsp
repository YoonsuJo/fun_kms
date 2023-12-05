<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<script type="text/javascript" src="${commonPath}/js/jquery.min.js"></script>
<script type="text/javascript" src="${commonPath}/js/jquery.ui.min.js"></script>
<script type="text/javascript" src="${commonPath}/js/jquery.ui.setting.js"></script>
<script type="text/javascript" src="${commonPath}/js/default.js"></script>
<script type="text/javascript" src="${commonPath}/js/smenu.js"></script>
<script type="text/javascript" src="${commonPath}/js/cs_js01.js"></script>

<!-- 현황 요약 시작  -->	
<p class="th_stitle">현황 요약</p>
<span class="stxt">건수를 클릭하면 아래쪽 목록을 통해 상세 정보를 확인하실 수 있습니다.</span>
<div class="boardList02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>현황 요약 보기</caption>
		<colgroup>
			<col class="col16" />
			<col class="col16" />
			<col class="col16" />
			<col class="col16" />
			<col class="col16" />
			<col class="col16" />
		</colgroup>
		<thead>
			<tr>
				<th>총 건수</th>
				<th>작업예정</th>
				<th>향후작업</th>
				<th>기각</th>
				<th>작업중</th>
				<th class="td_last">처리완료</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="txt_center">
					<c:if test="${empty summary.sum}">0</c:if>
					<a href="javascript:exSearch('');">${summary.sum}</a>
				</td>
				<td class="txt_center">
					<c:if test="${empty summary.e}">0</c:if>
					<a href="javascript:exSearch('E');">${summary.e}</a>
				</td>
				<td class="txt_center">
					<c:if test="${empty summary.h}">0</c:if>
					<a href="javascript:exSearch('H');">${summary.h}</a>
				</td>
				<td class="txt_center">
					<c:if test="${empty summary.r}">0</c:if>
					<a href="javascript:exSearch('R');">${summary.r}</a>
				</td>
				<td class="txt_center">
					<c:if test="${empty summary.c}">0</c:if>
					<a href="javascript:exSearch('C');">${summary.c}</a>
				</td>
				<td class="td_last txt_center">
					<c:if test="${empty summary.f}">0</c:if>
					<a href="javascript:exSearch('F');">${summary.f}</a>
				</td>
			</tr>		                    			                    			                    	
		</tbody>
	</table>
</div>
<!--// 현황 요약  끝  -->
