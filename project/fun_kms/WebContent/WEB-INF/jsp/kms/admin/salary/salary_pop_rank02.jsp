<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>

<body><div id="pop_expense02">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/admin/inc/pop_bullet.gif" /></li>
			<li class="popTitle">개인별 기준인건비 등록</li>
		</ul>
 	</div>
 	
 	<!-- 게시판  -->
 	<div id="pop_con08">
 		<div class="expense_stxt">
			<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
            <caption>공지사항 보기</caption>
            <colgroup><col class="col10" /><col class="col10" /><col class="col10" /><col class="col10" /><col class="col10" /><col class="col10" /></colgroup>
            	<tbody>
           			<tr>
						<td class="title">사번</td>
		          	  	<td class="pL10">0023</td>
			            <td class="title">이름</td>
			            <td class="pL10">문성숙</td>
			            <td class="title">상태</td>
			            <td class="pL10">근무</td>
	                </tr>
                </tbody>
            </table>
			</div>
 		
 		<table cellpadding="0" cellspacing="0">
 			<colgroup><col class="col5" /><col class="col90" /><col class="col90" /><col class="col90" /><col class="col90" /><col class="col90" /><col class="col90" /><col class="col5" /></colgroup>
 			<thead>
 				<tr>
 					<th class="th_left" ></th>
 					<th class="th_center" colspan="6">2011년도 월별 인건비</th>
 					<th class="th_right"></th>
 				</tr>
 			</thead>
 			<tbody>
				<tr class="subtitle">
					<td colspan="2">1월</td>
					<td>2월</td>
					<td>3월</td>
					<td>4월</td>
					<td>5월</td>
					<td colspan="2">6월</td>
				</tr>
				<tr>
					<td colspan="2"><input type="text" value="6,300,000" /></td>
					<td><input type="text"/></td>
					<td><input type="text"/></td>
					<td><input type="text" /></td>
					<td><input type="text"/></td>
					<td colspan="2"><input type="text" /></td>
				</tr>
				<tr>
					<td colspan="2"><input type="text" value="6,300,000" /></td>
					<td><input type="text"/></td>
					<td><input type="text"/></td>
					<td><input type="text" /></td>
					<td><input type="text"/></td>
					<td colspan="2"><input type="text" /></td>
				</tr>
				<tr>
					<td colspan="2"><input type="text" value="6,300,000" /></td>
					<td><input type="text"/></td>
					<td><input type="text"/></td>
					<td><input type="text" /></td>
					<td><input type="text"/></td>
					<td colspan="2"><input type="text" /></td>
				</tr>
				<tr class="subtitle02">
					<td colspan="2">7월</td>
					<td>8월</td>
					<td>9월</td>
					<td>10월</td>
					<td>11월</td>
					<td colspan="2">12월</td>
				</tr>
				<tr>
					<td colspan="2"><input type="text"/></td>
					<td><input type="text"/></td>
					<td><input type="text"/></td>
					<td><input type="text"/></td>
					<td><input type="text"/></td>
					<td colspan="2"><input type="text"/></td>
				</tr>
				<tr>
					<td colspan="2"><input type="text"/></td>
					<td><input type="text"/></td>
					<td><input type="text"/></td>
					<td><input type="text"/></td>
					<td><input type="text"/></td>
					<td colspan="2"><input type="text"/></td>
				</tr>
				<tr>
					<td colspan="2"><input type="text"/></td>
					<td><input type="text"/></td>
					<td><input type="text"/></td>
					<td><input type="text"/></td>
					<td><input type="text"/></td>
					<td colspan="2"><input type="text"/></td>
				</tr>
 			</tbody>
 			
 		</table>
 		<!--// 게시판 끝 -->
 		
 		<!-- 버튼  -->
 	    <div class="pop_btn_area04">
 		    <img src="${imagePath}/admin/btn/btn_january_copy.gif"/>
            <img src="${imagePath}/admin/btn/btn_save.gif"/>
            <img src="${imagePath}/admin/btn/btn_cancel.gif"/>
        </div>
 		<!--// 버튼 끝 -->
 	</div>
</div>

</body>
</html>
