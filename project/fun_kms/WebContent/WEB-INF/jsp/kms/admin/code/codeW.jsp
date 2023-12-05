<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>

<body>
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
							<li class="stitle">공통코드 등록</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">	
						
						<!-- 게시판 시작  -->
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공통코드</caption>
		                    <colgroup><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr> 
			                    	<td class="title">분류코드</td>
			                    	<td class="pL10" ><select name="list" class="span_8"><option>1레벨</option></select></td>
		                    	</tr>
		                    	<tr> 
			                    	<td class="title">코드ID</td>
			                    	<td class="pL10" ><input type="text" name="title" class="span_23" /></td>
		                    	</tr>
								<tr>
								    <td class="title">코드ID명</td>
									<td class="pL10" ><input type="text" name="title" class="span_23" /></td>
 								</tr>
 								<tr>
								    <td class="title">코드ID설명</td>
									<td class="pL10 pT5 pB5" ><textarea name="text" class="span_23 height_35"></textarea></td>
 								</tr>
 								<tr>
								    <td class="title">사용여부</td>
									<td class="pL10"><select name="list" class="span_4"><option>예</option></select></td>
 								</tr>                    	
		                    </tbody>
		                    </table>
						</div>
						<!-- 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="#"><img src="${imagePath}/admin/btn/btn_list.gif"/></a><a href="#"><img src="${imagePath}/admin/btn/btn_save.gif"/></a>
		                </div>
		                <!-- 버튼 끝 -->						
						
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
</body>
</html>
