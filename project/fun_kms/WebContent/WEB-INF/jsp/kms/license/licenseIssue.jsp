<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>

<script>
function save() {
	if(!fn_validation()){
		return;
	}
	
	//document.frm.action = "${rootPath}/license/licenseIssueSave2.do";
	document.frm.page.value = 1;
	//document.frm.licenseId.value = licenseId;
	document.frm.action = "${rootPath}/license/licenseIssueSave.do";
	document.frm.submit();
}

function getExpireTyp() {
	var unlimited = document.frm.unlimited;
	var result;
	for (var i=0; i<unlimited.length; i++) {
		if (unlimited[i].checked)
			result = unlimited[i].value;
	}
	return result;
}
function fn_validation(){

	var valueArr = new Array();
	var today = fn_today();
	var expireType = getExpireTyp();
	var rd = $(':input:radio[name=unlimited]:checked').val();

	if(document.all.companyName.value.length == 0){
		alert("회사명을 입력해 주시기 바랍니다.");
		document.all.companyName.focus();
		return false;
	}
	if(document.all.person.value.length == 0){
		alert("업체 담당자를 입력해 주시기 바랍니다.");
		document.all.person.focus();
		return false;
	}
	if(document.all.phone.value.length == 0){
		alert("연락처를 입력해 주시기 바랍니다.");
		document.all.phone.focus();
		return false;
	}
	if(document.all.serverIpAddr.value.length == 0){
		alert("설치서버 IP를 입력해 주시기 바랍니다.");
		document.all.serverIpAddr.focus();
		return false;
	}
	if(document.all.serverMacAddr.value.length == 0){
		alert("설치서버 Mac Address를 입력해 주시기 바랍니다.");
		document.all.serverMacAddr.focus();
		return false;
	}
	if(document.all.maxUserLimit.value < document.all.maxUser.value){
		alert("최대제한수는 접속제한수보다 커야 합니다.");
		document.all.maxUser.value = "";
		document.all.maxUser.focus();
		return false;
	}
    var list = $("input[name='clientList']");
	if(list[0].checked == false && list[1].checked == false && list[2].checked == false){
		alert("대상단말을 선택해 주시기 바랍니다.");
		return false;	
    }
    var list2 = $("input[name='functionList']");
	if(list2[0].checked == false && list2[1].checked == false && list2[2].checked == false && list2[3].checked == false){
		alert("제공기능을 선택해 주시기 바랍니다.");
		return false;	
    }
	if(rd == 'false'){
		if(document.all.expireDate.value.length < 7 && document.all.expireDate.value.length > 0 ){
			alert("만료일을 잘못 입력하셨습니다.");
			document.all.expireDate.value = "";
			document.all.expireDate.focus();
			return false;
		}
		if(document.all.expireDate.value.length == 0){
			alert("만료일을 입력해 주시기 바랍니다.");
			document.all.expireDate.focus();
			return false;
		}else{
			if(today >= document.all.expireDate.value){
				alert("만료일이 오늘보다 이전 입니다.");
				document.all.expireDate.value = "";
				document.all.expireDate.focus();
				return false;
			}
		}
	}
    
	return true;
}

function fn_today(){
	var now = new Date();
    var year= now.getFullYear();
    var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
    var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
    
    return year+mon+day;
}

function controlLimited(flag){
	var expire = document.getElementById("expire");
	if(flag == "L"){//무한
		expire.style.display = "none";
	}else if(flag == "D"){//데모
		expire.style.display = "";
	}
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
		
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">라이선스 발급 </li>
							<li class="navi">홈 > 업무공유 > 정보공유 > 라이선스 발급</li>
						</ul>
					</div>
					
					<!-- S: section -->
					<div class="section01">
						
						<!-- 게시판 시작 -->
						<form name="frm" method="POST">
						
						<input type="hidden" name="licenseId" >
						<input type="hidden" name="page" value="${searchVO.page}">
						
						<p class="th_stitle">라이선스 발급</p>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>라이선스 발급</caption>
		                    <colgroup>
			                    <col class="col180" />
			                    <col width="px" />
			                    <col class="col120" />
			                    <col width="px" />
		                    </colgroup>
		                    <tbody>
		                    	<tr>
			                    	<td class="title">제품선택</td>
			                    	<td class="pL10" colspan="3">
			                    		<input type="radio" name="product" value="ChorusVC" checked="checked"> ChorusVC &nbsp;&nbsp;
			                    		<input type="radio" name="product" value="Multiview"> Multiview
			                    	</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">회사명</td>
			                    	<td class="pL10" colspan="3"><input type="text" class="span_16" name="companyName"/></td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">업체담당자</td>
			                    	<td class="pL10"><input type="text" style="width: 184px" name="person"/></td>
			                    	<td class="title">연락처</td>
			                    	<td class="pL10"><input type="text" style="width: 159px" name="phone"/></td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">설치서버 IP</td>
			                    	<td class="pL10" colspan="3"><input type="text" class="span_16" name="serverIpAddr"/></td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">설치서버 MAC Address</td>
			                    	<td class="pL10" colspan="3"><input type="text" class="span_16" name="serverMacAddr" maxlength="17"/></td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">접속제한수</td>
			                    	<td class="pL10">최대 제한 수 <input type="text" style="width: 112px" name="maxUserLimit" value="520"/></td>
			                    	<td class="pL5" colspan="2">계약 제한 수 : <input type="text" style="width: 120px" name="maxUser" value="500"/> &nbsp;(*참여자기준)</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">대상단말</td>
			                    	<td class="pL10" colspan="3">
			                    		<input type="checkbox" class="check" name="clientList" value="pc" checked="checked"/> PC &nbsp;
			                    		<input type="checkbox" class="check" name="clientList" value="mobile"/> 모바일 &nbsp;
			                    		<input type="checkbox" class="check" name="clientList" value="codec"/> H/W코덱
			                    	</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">제공기능</td>
			                    	<td class="pL10" colspan="3">
			                    		<input type="checkbox" class="check" name="functionList" value="video" checked="checked"/> 영상회의<br/>
			                    		<input type="checkbox" class="check" name="functionList" value="document" /> 문서공유<br/>
			                    		<input type="checkbox" class="check" name="functionList" value="media"/> 미디어공유<br/>
			                    		<input type="checkbox" class="check" name="functionList" value="seminar" /> 화면공유
			                    	</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">만료일</td>
			                    	<td class="pL10" colspan="3">
			                    		<input type="radio" class="radio" name="unlimited" value="true" onclick="javascript:controlLimited('L');"/> 무한 &nbsp;&nbsp;
			                    		<input type="radio" class="radio" name="unlimited" value="false" onclick="javascript:controlLimited('D');" checked="checked"/> 데모
			                    		<span id="expire"><input type="text" class="span_5 calGen" maxlength="8" name="expireDate"/></span>
			                    	</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">메모</td>
			                    	<td class="pL10 pT5 pB5" colspan="3">
			                    		<textarea class="span_16 height_35" name="memo"></textarea>
			                    	</td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						</form>
						<!--// 게시판 끝-->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02 pB20">
		                	<ul>
		                		<li class="right">
		                			<a href="javascript:save('2');"><img src="${imagePath}/btn/btn_regist.gif"/></a>
		                		</li>
		                	</ul>
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
