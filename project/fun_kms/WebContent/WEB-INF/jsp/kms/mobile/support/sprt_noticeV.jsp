<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    
    
    
    
    
<%@ include file="../include/top_inc.jsp"%>



<script>

/*
function moveArticle() {
	var position = $("#moveImg").position();
	var height = $("#moveImg").height();
	var width = $("#moveImg").width();
	document.getElementById("boardLayer").style.top = position.top + height + "px";
	document.getElementById("boardLayer").style.left = position.left + width + "px";
	
	$.post("${rootPath}/mobile/community/selectBBSMasterInfs.do?bbsIdFrom=" + document.moveLayer.bbsIdFrom.value,
			function(data){
				$('#boardLayer').html(data);
				$('#boardLayer').show();
			}
	);
}
function moveBBS() {
	document.moveLayer.action = "<c:url value='${rootPath}/mobile/community/moveBoard.do' />";
	document.moveLayer.submit();
}

function modifyArticle() {
	document.frm.action = "<c:url value='${rootPath}/mobile/support/forUpdateBoardArticle.do'/>";
	document.frm.submit();		
}
function deleteArticle() {
	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.action = "<c:url value='${rootPath}/mobile/support/deleteBoardArticle.do'/>";
		document.frm.submit();
	}	
}
*/

function goAddReplyComment() {
	document.frm.action = "<c:url value='${rootPath}/mobile/support/goAddReplyComment.do'/>";
	document.frm.submit();
}
/*
function view(nttId, bbsId, readBool) {
	document.subForm.nttId.value = nttId;
	document.subForm.bbsId.value = bbsId;
	document.subForm.readBool.value = readBool;
	document.subForm.action = "<c:url value='${rootPath}/mobile/support/selectBoardArticle.do'/>";
	document.subForm.submit();
}*/

function answerArticle() {
	document.frm.action = "<c:url value='${rootPath}/mobile/support/addReplyBoardArticle.do'/>";
	document.frm.submit();
}

function listArticle() {
	document.frm.action = "<c:url value='${rootPath}/mobile/support/selectBoardList.do'/>";  
	<c:if test="${searchVO.fromUnread == 'Y'}">
	document.frm.action = "<c:url value='${rootPath}/mobile/support/selectUnreadBoardList.do'/>";
	</c:if>
	document.frm.submit();
}

function viewReload(){
	document.frm.action = "<c:url value='${rootPath}/mobile/support/selectBoardArticle.do'/>";
	document.frm.submit();
}
</script>

<script>
function confirms(){
	var result = confirm('댓글을 삭제하시겠습니까?');
	if (result) {
		location.href = "./notice_view.html";
	}
	else {
		location.href = "./notice_view.html";
	}
}
</script>

		<div id="showhidden"></div>
		<ul class="sectionttl bgTop">
			<li><img src="${commonMobilePath}/image/btn_menuS.png" alt="" id="secbtnA" /></li>
			<li>공지사항</li>
			<div class="bgTopBtn shadowBtn bgTopBtnBor" style="width:34px;">
				<font class="fontShadow"><a href="javascript:listArticle();" alt="">목록</a></font>
			</div>
		</ul>
				
		<!-- S:콘텐츠 들어가는곳 -->
		<ul class="view_vclip">
		<li class="listG">
		
			<span class="cont">
				<!--  <span class="txt_user bgBtn shadowBtn hitnumv"><span> <c:out value="${result.inqireCo}"/></span></span> -->
				<span class="tit_txt list_shadow"><c:out value="${result.nttSj}" /></span>				
				<span class="txt_sub"><a href="${rootPath}/mobile/member/selectMember.do?userId=${result.ntcrId}"><print:user userNo="${result.frstRegisterId}" userNm="${result.ntcrNm}" userId="${result.ntcrId}" printId="true"/></a></span>				
				<span class="txt_date"><c:out value="${result.frstRegisterPnttm}" /></span>
			</span>				
		</li>
		</ul>
		
		<hr class="hr_e1e1e1" />
		<!-- 본문 들어가는곳 -->
		
		<div class="notice_view"> 
			<c:out value="${result.nttCn}" escapeXml="false" />
		</div>
		<br />
		
		
		<h1 class="zipttl">첨부파일</h1>
		<hr class="officehr" />
		<table cellspacing="0" border="1" summary="" class="office_v">
		<caption></caption>
		<colgroup>
		<col width="*">
		</colgroup>
		<tbody>
		<tr>
			<td scope="col" style="text-align:left; padding-left:10px; font-size:12px;">
				<c:import url="${rootPath}/selectFileInfsForMobile.do" charEncoding="utf-8">
					<c:param name="param_atchFileId" value="${result.atchFileId}" />
				</c:import>
			</td>
		</tr>
		</tbody>
		</table>
		<br />		
		
		
		<!-- 게시판 시작  -->
		<form name="frm" method="post">
		<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
		<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>"/>
		<input type="hidden" name="searchWrd" value="<c:out value='${searchVO.searchWrd}'/>"/>
		<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" >
		<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" >
		<input type="hidden" name="parnts" value="<c:out value='${result.parnts}'/>" >
		<input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>" >
		<input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>" >
		<input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>" >
		<input type="hidden" name="userId"/>
			<!-- 댓글목록 들어가는곳 -->
			<div id="commd">
				<c:import url="${rootPath}/mobile/support/selectCommentList.do" charEncoding="utf-8">
					<c:param name="type" value="body" />
				</c:import>
			</div>
			
		</form>
				
		<!-- 댓글쓰기 버튼 들어가는곳 -->
		<br />
		<p>
			<a href="javascript:goAddReplyComment();">
			
			<button class="bgBtn shadowBtn btnRadius" style="width:96%;">댓글쓰기<span class="bl_up"><img src="${commonMobilePath}/image/bl_doarowa.png" alt=""/></span></button>
		   </a>
		</p>
				
				
		<div id="btn_ext">
			<div class="bgBtn shadowBtn btnTop btn_ext" style="width:50px; float:left;"><a href="javascript:viewReload();" class="">위로<span class="bl_select"><img src="${commonMobilePath}/image/bl_select.png" alt="선택"/></span></a></div>
		</div>

		<!--// 게시판 끝  -->

		<form name="moveLayer" method="POST">
			<input type="hidden" name="bbsIdFrom" value="${result.bbsId}" />
			<input type="hidden" name="nttId" value="${result.nttId}" />
			
			<div id="boardLayer" class="board_layer" style="display:none;">
           	</div>
		</form>
						
<%@ include file="../include/footer.jsp"%>

