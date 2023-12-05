<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript">
function register() {
	document.frm.submit();
}
function list() {
	document.frm.action = "${rootPath}/member/diningMoneyBudget.do";
	document.frm.submit();
}
</script>
</head>

<body>

<div id="wrap">
	<%@ include file="../common/menu/head.jsp"%>
	<!-- S: container -->
	<div id="container">
		<ul class="container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="contents">
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
			<!-- S: center -->
			<div id="center">
				<div class="path_navi">
					<ul>
						<li class="stitle">팀장경비 추가예산 등록</li>
						<li class="navi">홈 > 인사정보 > 복리후생 > 팀장경비 사용내역</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
	            	
		            <!-- 게시판 시작  -->
		            <form name="frm" method="POST" action="${rootPath}/member/insertDiningMoneyAdd.do">
                	<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
                	<input type="hidden" name="searchOrgId" value="${searchVO.searchOrgId}"/>
                	<input type="hidden" name="searchOrgNm" value="${searchVO.searchOrgNm}"/>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>공지사항 보기</caption>
	                    <colgroup>
	                    	<col class="col200" />
	                    	<col width="px" />
	                   	</colgroup>
	                    <tbody>
	                    	<tr>
		                    	<td class="bG txt_center">부서</td>
		                    	<td class="td_last pL10">
		                    		<input type="text" class="input01 span_29" name="orgnztNm" id="orgNm" readonly="readonly" onclick="orgGen('orgNm','orgId',1)"/>
		                    		<input type="hidden" name="orgnztId" id="orgId"/>
		                    		<img src="${imagePath}/btn/btn_tree.gif" class="search_btn02 cursorPointer" onclick="orgGen('orgNm','orgId',1)"/>
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="bG txt_center">년/월</td>
		                    	<td class="td_last pL10"><input type="text" class="input01 span_4 calGen" name="yyyymm"/></td>
	                    	</tr>
	                    	<tr>
		                    	<td class="bG txt_center">금액</td>
		                    	<td class="td_last pL10"><input type="text" class="input01 span_6" name="money"/></td>
	                    	</tr>
	                    	<tr>
		                    	<td class="bG txt_center">사유</td>
		                    	<td class="td_last pL10"><input type="text" class="input01 span_12" name="note"/></td>
	                    	</tr>
	                    </tbody>
	                    </table>
	                </div>
		            </form>
	                
	            	<!-- 버튼 시작 -->
	                <div class="btn_area">
	                	<a href="javascript:register();"><img src="${imagePath}/btn/btn_regist.gif"/></a>
	                	<a href="javascript:list();"><img src="${imagePath}/btn/btn_cancel.gif"/></a> 
	                </div>
	                <!-- 버튼 끝 -->
				</div>
				<!-- E: section -->
			</div>
			<!-- E: center -->				
			<%@ include file="../include/right.jsp"%>
			</div>	
			<!-- E: centerBg -->
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
