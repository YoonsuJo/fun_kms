<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../include/ajax_inc.jsp"%>

<span class="th_stitle">전자결재 <img src="${imagePath}/btn/btn_refresh.gif" class="cursorPointer" onclick="eappRefresh();"/></span>
<div class="sboard_tab">
	<ul id="statusBoardTab">
		<li class="on cursorPointer"  title="todo" onclick="changeTab(this);">결재할문서</li>
		<li class="off cursorPointer" title="reject" onclick="changeTab(this);">반려된문서</li>
		<li class="off cursorPointer" title="write" onclick="changeTab(this);">기안한문서</li>
		<li class="off cursorPointer" title="refer" onclick="changeTab(this);">참조할문서</li>
		<li class="off cursorPointer" title="handle" onclick="changeTab(this);">처리할문서</li>
	</ul>
	<div class="btn_area06 mB5">
		<a href="${rootPath}/approval/appr_NewDraft.do"><img src="${imagePath}/btn/btn_write01.gif"/></a>
		<a href="${rootPath}/approval/main.do"><img src="${imagePath}/btn/btn_more.gif"/></a>
	</div>
</div>
<div class="boardList" id="todo">
	<table cellpadding="0" cellspacing="0" summary="결재할 문서 목록입니다.">
		<caption>결재할 문서</caption>
		<colgroup>
			<col class="col130" />
			<col width="px" />
			<col class="col50" />
			<col class="col100" />
			<col class="col120" />
		</colgroup>
		<thead>
			<tr>
			<th scope="col">구분</th>
			<th scope="col">제목</th>
			<th scope="col">기안자</th>
			<th scope="col">기안일시</th>
			<th scope="col">결재상태</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty resultMap.todo}">
				<tr>
					<td colspan="5" class="txt_center">문서가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach items="${resultMap.todo}" var="result">
				<tr>
					<td class="txt_center">${result.templtNm}</td>
					<td class="pL10">
						<span <c:if test="${empty result.srchDt}"> class="txt_red"</c:if>><a href="${rootPath}/approval/approvalV.do?docId=${result.docId}&mode=2">${result.subject}</a></span>
					</td>
					<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
					<td class="txt_center">${result.writeDt}</td>
					<td class="txt_center">
						<c:choose>
							<c:when test="${result.docStat=='APP000'}">기안대기</c:when>
							<c:when test="${result.docStat=='APP001'}"><span class="txtB_green">검토중</span></c:when>
							<c:when test="${result.docStat=='APP002'}"><span class="txtB_blue2">협조중</span></c:when>
							<c:when test="${result.docStat=='APP003'}"><span class="txtB_orange">전결중</span></c:when>
							<c:when test="${result.docStat=='APP004'}"><span class="txtB_blue">참조중</span></c:when>
							<c:when test="${result.docStat=='APP005'}"><span class="txtB_grey">완료</span></c:when>
							<c:otherwise>결재실패</c:otherwise>
						</c:choose>(<print:date date="${result.preAppDtShort}" printType='S'/>)
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<div class="boardList" id="reject" style="display:none">
	<table cellpadding="0" cellspacing="0" summary="반려된 문서 목록입니다.">
		<caption>반려된 문서</caption>
		<colgroup>
			<col class="col130" />
			<col width="px" />
			<col class="col50" />
			<col class="col100" />
			<col class="col120" />
		</colgroup>
		<thead>
			<tr>
			<th scope="col">구분</th>
			<th scope="col">제목</th>
			<th scope="col">기안자</th>
			<th scope="col">기안일시</th>
			<th scope="col">결재상태</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty resultMap.reject}">
				<tr>
					<td colspan="5" class="txt_center">문서가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach items="${resultMap.reject}" var="result">
				<tr>
					<td class="txt_center">${result.templtNm}</td>
					<td class="pL10">
						<span <c:if test="${empty result.srchDt}"> class="txt_red"</c:if>>
						<a href="${rootPath}/approval/approvalV.do?docId=${result.docId}&mode=5">${result.subject}</a>
						</span>
					</td>
					<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
					<td class="txt_center">${result.writeDt}</td>
					<td class="txt_center">
						<c:choose>
							<c:when test="${result.docStat=='APP000'}">기안대기</c:when>
							<c:when test="${result.docStat=='APP001'}"><span class="txtB_green">검토중</span></c:when>
							<c:when test="${result.docStat=='APP002'}"><span class="txtB_blue2">협조중</span></c:when>
							<c:when test="${result.docStat=='APP003'}"><span class="txtB_orange">전결중</span></c:when>
							<c:when test="${result.docStat=='APP004'}"><span class="txtB_blue">참조중</span></c:when>
							<c:when test="${result.docStat=='APP005'}"><span class="txtB_grey">완료</span></c:when>
							<c:otherwise>결재실패</c:otherwise>
						</c:choose>(<print:date date="${result.preAppDtShort}" printType='S'/>)
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<div class="boardList" id="write" style="display:none">
	<table cellpadding="0" cellspacing="0" summary="기안한 문서 목록입니다.">
		<caption>기안한 문서</caption>
		<colgroup>
			<col class="col130" />
			<col width="px" />
			<col class="col50" />
			<col class="col100" />
			<col class="col120" />
		</colgroup>
		<thead>
			<tr>
			<th scope="col">구분</th>
			<th scope="col">제목</th>
			<th scope="col">기안자</th>
			<th scope="col">기안일시</th>
			<th scope="col">결재상태</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty resultMap.write}">
				<tr>
					<td colspan="5" class="txt_center">문서가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach items="${resultMap.write}" var="result">
				<tr>
					<td class="txt_center">${result.templtNm}</td>
					<td class="pL10">
						<span <c:if test="${empty result.srchDt}"> class="txt_red"</c:if>><a href="${rootPath}/approval/approvalV.do?docId=${result.docId}&mode=3">${result.subject}</a></span>
					</td>
					<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
					<td class="txt_center">${result.writeDt}</td>
					<td class="txt_center">
						<c:choose>
							<c:when test="${result.docStat=='APP000'}">기안대기</c:when>
							<c:when test="${result.docStat=='APP001'}"><span class="txtB_green">검토중</span></c:when>
							<c:when test="${result.docStat=='APP002'}"><span class="txtB_blue2">협조중</span></c:when>
							<c:when test="${result.docStat=='APP003'}"><span class="txtB_orange">전결중</span></c:when>
							<c:when test="${result.docStat=='APP004'}"><span class="txtB_blue">참조중</span></c:when>
							<c:when test="${result.docStat=='APP005'}"><span class="txtB_grey">완료</span></c:when>
							<c:otherwise>결재실패</c:otherwise>
						</c:choose>(<print:date date="${result.preAppDtShort}" printType='S'/>)
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<div class="boardList" id="refer" style="display:none">
	<table cellpadding="0" cellspacing="0" summary="참조할 문서 목록입니다.">
		<caption>참조할 문서</caption>
		<colgroup>
			<col class="col130" />
			<col width="px" />
			<col class="col50" />
			<col class="col100" />
			<col class="col120" />
		</colgroup>
		<thead>
			<tr>
			<th scope="col">구분</th>
			<th scope="col">제목</th>
			<th scope="col">기안자</th>
			<th scope="col">기안일시</th>
			<th scope="col">결재상태</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty resultMap.refer}">
				<tr>
					<td colspan="5" class="txt_center">문서가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach items="${resultMap.refer}" var="result">
				<tr>
					<td class="txt_center">${result.templtNm}</td>
					<td class="pL10">
						<span <c:if test="${empty result.srchDt}"> class="txt_red"</c:if>><a href="${rootPath}/approval/approvalV.do?docId=${result.docId}&mode=12">${result.subject}</a></span>
					</td>
					<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
					<td class="txt_center">${result.writeDt}</td>
					<td class="txt_center">
						<c:choose>
							<c:when test="${result.docStat=='APP000'}">기안대기</c:when>
							<c:when test="${result.docStat=='APP001'}"><span class="txtB_green">검토중</span></c:when>
							<c:when test="${result.docStat=='APP002'}"><span class="txtB_blue2">협조중</span></c:when>
							<c:when test="${result.docStat=='APP003'}"><span class="txtB_orange">전결중</span></c:when>
							<c:when test="${result.docStat=='APP004'}"><span class="txtB_blue">참조중</span></c:when>
							<c:when test="${result.docStat=='APP005'}"><span class="txtB_grey">완료</span></c:when>
							<c:otherwise>결재실패</c:otherwise>
						</c:choose>(<print:date date="${result.preAppDtShort}" printType='S'/>)
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<div class="boardList" id="handle" style="display:none">
	<table cellpadding="0" cellspacing="0" summary="처리할 문서 목록입니다.">
		<caption>처리할 문서</caption>
		<colgroup>
			<col class="col130" />
			<col width="px" />
			<col class="col50" />
			<col class="col100" />
			<col class="col120" />
		</colgroup>
		<thead>
			<tr>
			<th scope="col">구분</th>
			<th scope="col">제목</th>
			<th scope="col">기안자</th>
			<th scope="col">기안일시</th>
			<th scope="col">결재상태</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty resultMap.handle}">
				<tr>
					<td colspan="5" class="txt_center">문서가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach items="${resultMap.handle}" var="result">
				<tr>
					<td class="txt_center">${result.templtNm}</td>
					<td class="pL10">
						<span <c:if test="${empty result.srchDt}"> class="txt_red"</c:if>><a href="${rootPath}/approval/approvalV.do?docId=${result.docId}&mode=13">${result.subject}</a></span>
					</td>
					<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
					<td class="txt_center">${result.writeDt}</td>
					<td class="txt_center">
						<c:choose>
							<c:when test="${result.docStat=='APP000'}">기안대기</c:when>
							<c:when test="${result.docStat=='APP001'}"><span class="txtB_green">검토중</span></c:when>
							<c:when test="${result.docStat=='APP002'}"><span class="txtB_blue2">협조중</span></c:when>
							<c:when test="${result.docStat=='APP003'}"><span class="txtB_orange">전결중</span></c:when>
							<c:when test="${result.docStat=='APP004'}"><span class="txtB_blue">참조중</span></c:when>
							<c:when test="${result.docStat=='APP005'}"><span class="txtB_grey">완료</span></c:when>
							<c:otherwise>결재실패</c:otherwise>
						</c:choose>(<print:date date="${result.preAppDtShort}" printType='S'/>)
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- E: 전자결재 -->
