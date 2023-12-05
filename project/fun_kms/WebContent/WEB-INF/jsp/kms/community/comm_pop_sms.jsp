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
<div id="pop_message">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
			<li class="popTitle">SMS 전송</li>
		</ul>
 	</div>
 	
 	<div id="pop_con02">
 		<table cellpadding="0" cellspacing="0">
 			<colgroup><col class="col180" /><col width="px" /></colgroup>
 			<thead>
 				 <tr>
					<th colspan="2" scope="col">SMS 전송시 건당 XX원의 비용이 발생합니다.<br/>
									업무상 꼭 필요한 경우에만 아껴서 사용해 주시기 바랍니다.<br/>
									과다하게 사용하실 경우 기능이 제한될 수 있습니다.
					</th>
				</tr>
 			</thead>
 			<tbody>
 				<tr>
 					<td class="title" >수신자</td>
 					<td><input type="text" class="write_input05" /></td>
 				</tr>
 				<tr>
 					<td class="title" >내용<br/>(70자 이내)</td>
 					<td><textarea name="text" class="span_19 height_170"></textarea></td>
 				</tr>
 			</tbody>
 		</table>
      
 	    <div class="pop_btn_area">
            <img src="${imagePath}/btn/btn_send_pop.gif"/>
            <img src="${imagePath}/btn/btn_cancel.gif"/>
        </div>
 		
 	</div>
</div>

</body>
</html>
