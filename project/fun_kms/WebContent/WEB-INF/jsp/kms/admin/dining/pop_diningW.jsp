<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/adminMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="KmsBanner" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function register() {
	if(!validateKmsDining(document.frm)) {
		return;
	}
	document.frm.action = "<c:url value='${rootPath}/admin/dining/insertDining.do'/>";
	document.frm.submit();
}
function validateKmsDining(frm) {
	if(frm.dinYear.value.length != 4) {
		alert('년도를 확인하세요.(4자리 수)');
		frm.dinYear.focus();
		return false;
	}
	frm.dinMoney.value = rtnnumber(frm.dinMoney.value);
	if(frm.dinMoney.value.length > 11 || frm.dinMoney.value < 0) {
		alert('금액을 확인하세요. (11자리 미만)');
		frm.dinMoney.value = addComma(frm.dinMoney.value);
		frm.dinMoney.focus();
		return false;
	}
	if(frm.dinDate.value > 31 || frm.dinDate.value < 1) {
		alert('날짜를 확인하세요.');
		frm.dinDate.focus();
		return false;
	}
	return true;
}
function display(){
	var tmp = rtnnumber(document.frm.dinMoney.value);
	document.frm.dinMoney.value = addComma(tmp);
}
function rtnnumber(n){
 n=n.replace(/,/g,"");
 if(isNaN(n)){return 0;} else{return n;}
}
function addComma(n) {
 if(isNaN(n)){return 0;}
  var reg = /(^[+-]?\d+)(\d{3})/;   
  n += '';
  while (reg.test(n))
    n = n.replace(reg, '$1' + ',' + '$2');
  return n;
}
function check(obj){
	e = window.event;
	
	//입력 허용 키
	if( ( e.keyCode >=  48 && e.keyCode <=  57 ) ||   //숫자열 0 ~ 9 : 48 ~ 57
	     ( e.keyCode >=  96 && e.keyCode <= 105 ) ||   //키패드 0 ~ 9 : 96 ~ 105
	       e.keyCode ==   8 ||    //BackSpace
	       e.keyCode ==  46 ||    //Delete
	       e.keyCode ==  37 ||    //좌 화살표
	       e.keyCode ==  39 ||    //우 화살표
	       e.keyCode ==  35 ||    //End 키
	       e.keyCode ==  36 ||    //Home 키
	       e.keyCode ==   9       //Tab 키
	   ) {
	       return; //-->입력시킨다.
	}else //숫자가 아니면 넣을수 없다.
	{
		alert('숫자만 입력가능합니다.');
		e.returnValue = false;
	}
}
</script>
</head>

<body><div id="pop_dining">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/admin/inc/pop_bullet.gif" /></li>
			<li class="popTitle">팀장경비 등록</li>
		</ul>
 	</div>
 	
	<form:form commandName="KmsDining" name="frm" method="POST" enctype="multipart/form-data">
 	<div id="pop_con09">
 		<table cellpadding="0" cellspacing="0">
 			<colgroup>
 				<col class="col180" />
 				<col width="px" />
 			</colgroup>
 			<tbody>
				<tr>
					<td class="subtitle" >년도</td>
					<td class="subtitle2">
						<input type="text" name="dinYear" class="input_01 span_1" maxlength="4"/>
					</td>
				</tr>
				<tr>
					<td class="subtitle">부서별 인원수 기준일자</td>
					<td class="subtitle2">
						<input type="text" name="dinDate" id="dinDate" class="input_01 span_1" onfocus="numGen('dinDate',1,31,10);"/> 일
					</td>
				</tr> 
				<tr>
					<td class="subtitle">1인당 월별 배정금액</td>
					<td class="subtitle2">
						<input type="text" name="dinMoney" class="input_01 span_5" id="dinMoney" onkeydown="check(this);" onkeyup="display();"/> 원
					</td>
				</tr>
 			</tbody>
 		</table>
 		
 	    <div class="pop_btn_area">
            <a href="javascript:register();"><img src="${imagePath}/admin/btn/btn_regist.gif"/></a>
            <a href="javascript:self.close();"><img src="${imagePath}/admin/btn/btn_cancel.gif"/></a>
        </div>
 		
 	</div>
	</form:form>
</div>

</body>
</html>
