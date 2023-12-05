// 세로 중앙정렬
function verticalAlign(obj){
	result=(obj.offsetParent.offsetHeight - obj.offsetHeight)/2+"px";
	if(obj.readyState == "complete"){
		obj.style.marginTop="0";
		obj.style.marginTop=result;
	}else{
		return result;
	}
}

//max-width, max-height
function maxSize(obj,w,h){
	if(obj.readyState != "complete") return "auto";
	real_w=obj.offsetWidth;
	real_h=obj.offsetHeight;
	virt_w=obj.offsetWidth;
	virt_h=obj.offsetHeight;
	if(w>0 && virt_w>w){
		virt_w = w
		virt_h = real_h * (virt_w/real_w);
	}
	if(h>0 && virt_h>h){
		virt_h = h;
		virt_w = real_w * (virt_h/real_h);
	}

	obj.style.width="0";
	obj.style.height="0";
	obj.style.width=virt_w+"px";
	obj.style.height=virt_h+"px";

}

//min-height
function min_height(obj,h){
	if(obj.readyState != "complete") return "auto";
	if(obj.offsetHeight<h){
		obj.style.height="0";
		obj.style.height=h+"px";
	}
}

//라디오,체크버튼 border 없애기
function input_nb(obj){
	obj.style.zIndex="1";
	if(obj.type.toLowerCase()=="radio" || obj.type.toLowerCase()=="image" 
		|| obj.type.toLowerCase()=="checkbox"){
		obj.style.border="0";
	}
}


function getCookie( name )
{
	var nameOfCookie = name + "=";
	var x = 0;
	while ( x <= document.cookie.length )
	{
		var y = (x+nameOfCookie.length);
		if ( document.cookie.substring( x, y ) == nameOfCookie ) {
			if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
				endOfCookie = document.cookie.length;
			return unescape( document.cookie.substring( y, endOfCookie ) );
		}
		x = document.cookie.indexOf( " ", x ) + 1;
		if ( x == 0 )
			break;
	}
	return "";
}



function MM_openBrWindow(theURL,winName,features) { //v2.0
	var popup = window.open(theURL,winName,features);
	popup.focus();
}



var isClick = false;
function searchClick() {
	if (isClick == false) {
		document.quickSearch.searchQuery.value = "";
		isClick = true;
	}
}


// check Numeric number
function isNumeric(checkStr) {
	var checkOK = "0123456789";
	
	for (i = 0;  i < checkStr.length;  i++) {
		ch = checkStr.charAt(i);
		for (j = 0;  j < checkOK.length;  j++) {
			if (ch == checkOK.charAt(j)) {break;}
		}
		
		if (j == checkOK.length) {return false;	break;}
	}
	
	return true;
}

// 주민번호 체크
function JuminCheck(jumin1, jumin2){
	check = false;
	total = 0;
	temp = new Array(13);

	for(i=1; i<=6; i++)
		temp[i] = jumin1.charAt(i-1);
	for(i=7; i<=13; i++)
		temp[i] = jumin2.charAt(i-7);
	
	for(i=1; i<=12; i++){
		k = i + 1;
		if(k >= 10)
			k = k % 10 + 2;
		total = total + temp[i] * k;
	}
	mm = temp[3] + temp[4];
	dd = temp[5] + temp[6];

	totalmod = total % 11;
	chd = 11 - totalmod;
	if(chd == temp[13] && mm < 13 && dd < 32 && (temp[7]==1 || temp[7]==2))
		check=true;
	return check;
}

// 개미점선없애기

function bluring(){
	if(event.srcElement.tagName=="A"||event.srcElement.tagName=="IMG") document.body.focus();
}

document.onfocusin=bluring;

function hidden_right(bool){
	var right = document.getElementById('right');
	if(right.style.display=='none'){
		right.style.display='';
		document.getElementById('center').style.width='747px';
		$('#center').trigger('showRightEvent');
		
		document.getElementById('arrowImg').src = imagePath + "/inc/arrow_right.gif";
		$('#mainnav').css('left', (parseInt($('#mainnav').css('left')) - 195) + 'px');
		
		if (bool)
			$.post("/member/updateUiSetting.do?showRight=1", function() {});
	}
	else if(right.style.display==''){
		right.style.display='none';
		document.getElementById('center').style.width='942px';
		$('#center').trigger('hideRightEvent');
		
		document.getElementById('arrowImg').src = imagePath + "/inc/arrow_left.gif";
		$('#mainnav').css('left', (parseInt($('#mainnav').css('left')) + 195) + 'px');

		if (bool)
			$.post("/member/updateUiSetting.do?showRight=0", function() {});
	}
}

//hidden_right 수정메소드 DB에 설정값 UPDATE 안함
//hidden_right_true(true) = 우측메뉴 숨기기
//hidden_right_true(false) = 우측메뉴 보이기
function hidden_right_true(bool){
	var right = document.getElementById('right');
	if(!bool && right.style.display=='none'){
		right.style.display='';
		document.getElementById('center').style.width='747px';
		$('#center').trigger('showRightEvent');
		
		document.getElementById('arrowImg').src = imagePath + "/inc/arrow_right.gif";		
	}
	else if(bool && right.style.display==''){
		right.style.display='none';
		document.getElementById('center').style.width='942px';
		$('#center').trigger('hideRightEvent');
		
		document.getElementById('arrowImg').src = imagePath + "/inc/arrow_left.gif";	
	}
}

/**
 * 조직도 가져오기 Ajax Use Jquery 
 * @param {string} elem : 클릭 이벤트를 받을 객체
 * 		  {string} hiddenTarget : form에 orgId 값들을 저장할 hidden input id	  
 *        {string} mode : 1=단일선택, 1외에 모든값=다중선택
 *        {string} orgnztId : 예하부서만 보이는 기능
 */
function orgGen(elem, hiddenTarget, mode, orgnztId){ 
	if(typeof(elem)=='object')
		elem = $(elem);
	else
		elem = $('#' + elem);
	if(typeof(hiddenTarget)=='object')
		hiddenTarget= $(hiddenTarget);
	else
		hiddenTarget= $('#' + hiddenTarget);
	var position = elem.offset();
	var left = elem.offset().left ;
	var top = elem.offset().top + elem.height() + 5 ;
	var orgTreeDiv;
	if($('#_orGDiv').length>0) {
		$('#_orGDiv').dialog('destroy');
		$('#_orGDiv').remove();
	}
	//2013년 2월 7일 추가기능. 예하부서만 보이는 기능. 조직도에 문제 생기면 이 부분부터 검사할것.
	if(typeof(orgnztId)=="undefined")
		orgnztId = ''; 
		
	$.post("/ajax/organ/OrganTree.do?orgnztId=" + orgnztId,
	function(data){
		orgTreeDiv = $('<div class="_orGDiv">'+
						'<div class="ui_layer">'+
						'<div class="ui_List" >'+
						'</div>'+
						'</div>'+
					'</div>');
		orgTreeDiv.find('.ui_List').html("<div id='_usrDiv'>"+ data + "</div>");
		orgTreeDiv.hide().appendTo('body');
		var height =650;
		if(mode==2);
			height = 680;
		orgTreeDiv.dialog({
				height: height
			 ,width: 415 
			 ,closeOnEscape: true 
			 ,resizable: true 
			 ,draggable: true
			 ,autoOpen: true 		
			 ,position : [left,top]   
				 });	
		orgTreeDiv.checkboxTree({
			 onCheck : {ancestors : "uncheck"},
				 collapseUiIcon: 'ui-icon-plus',
				 expandUiIcon: 'ui-icon-minus',
				 leafUiIcon: 'ui-icon-bullet'		
	 });
		
		//making the checkbox checked
		hiddenTargetArray =hiddenTarget.val().split(",");
		//alert(hiddenTargetArray.length);
		for (var i =0; i <hiddenTargetArray.length; i++ ) {
			if(hiddenTargetArray[i]=="" || hiddenTargetArray[i]==null)
				continue;
			orgTreeDiv.find(":checkbox[name=v_org][value^="+ hiddenTargetArray[i]+"\\/]" ).attr("checked", "checked");				
		}
		
		if(mode==1) {
			orgTreeDiv.find(":checkbox[name=v_org]").click(function(){
				if($(this).is(':checked')) {
					var organInfo =$(this).val().split("/"); 
					hiddenTarget.val(organInfo[0]);
					$(elem).val(organInfo[1]);						
				} else {
					hiddenTarget.val(null);
					$(elem).val(null);
				}
				orgTreeDiv.parent().remove();
			});
		} else {
			$('<div class="ui_btn">'+
					'<img src="'+imagePath+'/btn/btn_apply.gif"  class="cursorPointer" id="_sendOrganList"/>'+
					'<img src="'+imagePath+'/btn/btn_cancel.gif"  class="cursorPointer" id="_cancelOrgGen"/>'+
				'</div>').appendTo(orgTreeDiv);
			orgTreeDiv.find("#_sendOrganList").click(function(){
				var hiddenTargetVar = "";
				var hiddenTargetVar2 = "";
				var checkedOrganList = orgTreeDiv.find(":checkbox[name=v_org]:checked");
				for(var i =0; i< checkedOrganList.length;i++)
				{
					var organInfo =checkedOrganList[i].value.split("/"); 
					hiddenTargetVar +=organInfo[0]+",";
					hiddenTargetVar2 +=organInfo[1]+",";
					
				}
				hiddenTarget.val(hiddenTargetVar);
				elem.val(hiddenTargetVar2);
				orgTreeDiv.parent().remove();
			});
			orgTreeDiv.find("#_cancelOrgGen").click(function(){orgTreeDiv.dialog('destroy');});
		}
		
	});
}
	

function numGen(inputTxtObj, startNum, endNum, rowCnt){
	
	if(typeof(inputTxtObj)=='object')
		inputTxtObj = $(inputTxtObj);
	else
		inputTxtObj = $('#'+ inputTxtObj);
	
	var position = inputTxtObj.offset();

	var left = position.left ;
	var top = position.top + 5 ;
	if($('.mouseOver_numGen').length>0)
	{
		$('.mouseOver_numGen').remove();
	}

	var layer = $('<div class="mouseOver_numGen"></div>');
	layer.appendTo('body');
	layer.css("left",left-20+"px");
	layer.css("top",top+15+"px");
	layer.css("width",(rowCnt*20)+"px");
	$('<table cellpadding="0" cellspacing="0" id="_numGenTable">').appendTo($('.mouseOver_numGen'));
	$('<tbody id="_numGenTbody"></tbody>').appendTo($('#_numGenTable'));
	
	var row = 0;
	var column = 0;

	for(var i=startNum; i <= endNum; i++){
		if (column == 0) {
			row++;
			$('<tr id="_numGenTr' + row + '"></tr>').appendTo($('#_numGenTbody'));
		}
		
		var td = $('<td>'+ i +'</td>');
		td.bind('click.numGen',function(){
			inputTxtObj.val($(this).html());
			$('body').unbind('click.numGen');
			layer.remove();
		});
		td.addClass('cursorPointer');
		td.appendTo($('#_numGenTr' + row));
		
		if (column == 4) column = 0;
		else column++;
	}
	console.log(layer.html());

	$('body').bind('click', function numGenLayerClickEvent(event){
			if (!$(event.target).closest(layer).length && event.target !== inputTxtObj.get(0)) {
						$('body').unbind('click.numGen');
						layer.remove();
				};
		}
	);
	/*
	function numGenLayerClickEvent(event){
		alert("why");
		if (!$(event.target).closest(layer).length) {
			alert("why2");
					layer.remove();
					$('body').unbind(numGenLayerClickEvent);
			};
	}
	*/
}
function getModLeft(up, down) {
	var val = up;
	while (val < 0) {
		val += down
	}
	return val%down;
}
//user tree 가져오기
function usrGen(usrNmObj, usrIdObj, mode, callback, orgnztId){
	var keyCode = $.ui.keyCode;
	console.log("usrGen start");
	var usrNmObj;
	if(typeof(usrNmObj)=='object')
		usrNmObj = $(usrNmObj);
	else
		usrNmObj = $('#' + usrNmObj);
	if(typeof(usrIdObj)=='object')
		usrIdObj= $(usrIdObj);
	else if(typeof(usrIdObj)=='number') {
		callback = mode;
		mode = usrIdObj;
		usrIdObj = null;
	} else
		usrIdObj= $('#' + usrIdObj);
	
	if($('#_usrDiv').length>0) {
		$('#_usrDiv').dialog('destroy');
		$('#_usrDiv').remove();
	}	
	
	var position = usrNmObj.offset();
	var searchKeyword ="";
	var usrTreeDiv = $('<div id="_usrDiv" style="z-index:300">'+
			'<div class="ui_layer">'+
			'	<dl>'+
			'		<dd>'+
			'		<label><input type="radio" name="_usrTree_searchCondition" value="1" /> 검색</label>'+ 
			'		<label><input type="radio" name="_usrTree_searchCondition" value="2" /> 조직도</label>'+
			'		<label><input type="radio" name="_usrTree_searchCondition" value="3" checked/> 팀원</label>'+
			'		</dd>'+
			'	</dl>'+
			'	<div class="ui_List">'+
			'	</div>'+
			'</div>'+
		'</div>');
	//2013년 2월 7일 추가기능. 예하부서만 보이는 기능. 사용자트리에 문제 생기면 이 부분부터 검사할것.
	if(typeof(orgnztId)=="undefined")
		orgnztId = '';
	if(orgnztId != '') {
		var usrTreeDiv = $('<div id="_usrDiv">'+
				'<div class="ui_layer usr">'+
				'	<dl>'+
				'		<dd>'+
				'		<label><input type="radio" name="_usrTree_searchCondition" value="3" checked/> 팀원</label>'+
				'		</dd>'+
				'	</dl>'+
				'	<div class="ui_List">'+
				'	</div>'+
				'</div>'+
			'</div>');
	}
	
	var usrSearchBox = $('<dd class="usrSearchBox">검색어 : <input type="text" name="searchKeyword"/></dd>');
	usrTreeDiv.find('[name=_usrTree_searchCondition]').change(function(){
		searchCondition = usrTreeDiv.find('[name=_usrTree_searchCondition]:checked').val();
		if(searchCondition == 1)
			usrSearchLayer();
		else if(searchCondition == 2)
			usrTree();
		else
			usrTreeTeam();
	});
	usrTreeDiv.hide().appendTo('body');
	var height = 680;
	if(mode!=1) {
		height = 680;
		$('<div class="ui_btn">'+
			'<img src="'+imagePath+'/btn/btn_apply.gif"  class="cursorPointer" id="_sendUsrList"/>'+
			'<img src="'+imagePath+'/btn/btn_cancel.gif"  class="cursorPointer" id="_cancelUsrGen"/>'+
		'</div>').appendTo(usrTreeDiv);
	}
	var usrList = new Object(); 
	if(usrIdObj!=null) {
		;
	} else {
		var usrIdList = makeUserIdArray(usrNmObj.val());
		var usrNmList = makeUserNmArray(usrNmObj.val());
		//usrGen 호출시 usrNmObj에 있는 userMix 불러와서 usrList 배열에 넣는다. 여기서 key 값은 userId
		for(var i = 0; i< usrIdList.length; i++) {
			usrList[usrIdList[i]] = {
					usrId : usrIdList[i],
					usrNm : usrNmList[i]
			}
		}
	}
	usrTreeDiv.dialog({
				height: height
			 ,width:420
			 ,closeOnEscape: true 
			 ,resizable: true 
			 ,draggable: true
			 ,autoOpen: true 		
			 ,position : [position.left,position.top+20]   
	});	
	
	usrSearchBox.find('[name=searchKeyword]').get(0).autocomplete="off";
	usrSearchBox.find('[name=searchKeyword]').keydown(function(){
		
	var uiList =  usrTreeDiv.find('.ui_List');
		if (event.which == keyCode.UP || event.which ==  keyCode.DOWN) {
			event.preventDefault();
			var aa = event.which == keyCode.UP ?  -1 : 1;
			var index ;
			if(uiList.find('li.state-hover').length==0)
				index = -1;
			else
				index = uiList.find('li.state-hover').index();
			index = index + aa;
			 
			if(uiList.find('li').length<=index)
				index = uiList.find('li').length--;
			uiList.find('li').removeClass('state-hover');
			if(index>=0)
				uiList.find('li:eq('+index+')').addClass("state-hover");
		 } else if(event.which == keyCode.SPACE){
			 event.preventDefault();
			 if(uiList.find('li.state-hover').length==1){
				liChecked(uiList.find('li.state-hover'));
			 }
		 } else if(event.which == keyCode.ENTER){
			 event.preventDefault();			 
			 //리스트에 있는거 다 선택해주고 닫기. //작업하다가 중단
			 //endUsrGen(); 			 	 
		 }		 
	});
	
	var searchAction = null;
	usrSearchBox.find('[name=searchKeyword]').keyup(function(){
		searchKeyword = this.value;
		if(searchAction)
			clearTimeout(searchAction);
		if (event.which == keyCode.UP || event.which ==  keyCode.DOWN ||  event.which ==keyCode.SPACE) 
			;
		else
			searchAction = setTimeout(function(){usrSearch(encodeURI(searchKeyword));},200);
	});
	
	usrTreeDiv.find("#_sendUsrList").click(endUsrGen);
	usrTreeDiv.find("#_cancelUsrGen").click(function(){usrTreeDiv.dialog('destroy');});

	//usrTree();
	usrTreeTeam();	
	
	//함수 선언 시작
	function usrSearch(searchKeyword,usrIdList){ //검색부분 0번 처음탭
		$.post("/ajax/member/usrSearchLayer.do",{searchKeyword:searchKeyword,usrIdList:usrIdList},function(data){
			usrTreeDiv.find('.ui_List').html(data);
			usrTreeDiv.find('.ui_List').find('li').each(function(){
				if(typeof(usrList[$(this).find('[name$=usrId]').val()])!="undefined")
					$(this).addClass('state-checked');				
			});
			usrTreeDiv.find('.ui_List').find('li').click(function(){
				liChecked($(this));
			});
		});
	};
	
	function liChecked(li){		
		li = $(li);
		var usrId = li.find('[name$=usrId]').val();
		if(typeof(usrList[usrId])=="undefined") {
			if(mode==1) usrList = new Object();		// [20140708, 김동우] mode 1인경우 한명만 선택되도록
			usrList[usrId] = {
				usrNo : li.find('[name$=usrNo]').val(),
				usrId : li.find('[name$=usrId]').val(),
				usrNm : li.find('[name$=usrNm]').val()
			};
			
			li.addClass('state-checked');			
			if(mode==1){
				endUsrGen();
			}
		} else {			
			delete usrList[usrId];
			li.removeClass('state-checked');
		}
	};
		
	function usrSearchLayer() {
		usrSearchBox.appendTo(usrTreeDiv.find('dl'));
		usrSearchBox.find('[name=searchKeyword]').focus();
		usrSearch(searchKeyword);
	};
	
	function endUsrGen() {
		if(usrIdObj==null) {
			var userMixs = "";
			$.each(usrList, function(key,val){
				userMixs = userMixs + val.usrNm + "(" + val.usrId + ")" +",";
			});
			if(userMixs.substring(userMixs.length-1) == ",")
				userMixs = userMixs.substring(0, userMixs.length-1);
			usrNmObj.val(userMixs);
			usrTreeDiv.dialog('destroy');
			if(typeof callback != "undefined") {
				callback.call(this, usrNmObj, usrIdObj);
			}
		}
	};
		
	function usrTree(){
		$.post("/ajax/member/userTree.do",function(data){
			usrSearchBox.detach();
			usrTreeDiv.find('.ui_List').html("<div id='_usrDiv'>"+ data + "</div>");
			usrTreeDiv.find('#_usrDiv').checkboxTree({
				 onCheck : {ancestors : "uncheck"},
					 collapseUiIcon: 'ui-icon-plus',
					 expandUiIcon: 'ui-icon-minus',
					 leafUiIcon: 'ui-icon-bullet'		
			});
			
			$.each(usrList,function(key,val){
				var tmpList = usrTreeDiv.find(":checkbox[name=v_usr]");
				tmpList.each(function() {
					var usrInfo = $(this).val().split("/");
					if(usrInfo[2] == val['usrId']) {
						$(this).attr("checked", "checked");
					}
				});
				// usrTreeDiv.find(":checkbox[name=v_usr][value$=\\/"+ "." +"]" ).attr("checked", "checked");
			});
			
			if(mode==1) { //usr한명만 선택할 수 있게 함.
				usrTreeDiv.find(":checkbox[name=v_org]").remove();
				usrTreeDiv.find(":checkbox[name=v_usr]").click(function(){
					var usrInfo =$(this).val().split("/");
					usrList = new Object();
					usrList[usrInfo[2]] = {
							usrNo : usrInfo[0],
							usrId : usrInfo[2],
							usrNm : usrInfo[1]
						};
					endUsrGen();
				});
			} else {
				//making the checkbox checked
				usrTreeDiv.find(":checkbox[name=v_org]" ).each(function(index) {
						if($(this).parent().find(":checkbox[name=v_usr]:checked").length>0 && 
							$(this).parent().find(":checkbox[name=v_usr]").length == $(this).parent().find(":checkbox[name=v_usr]:checked").length)
						$(this).attr("checked","checked");
				});
				
				usrTreeDiv.find(":checkbox[name=v_usr]").change(function() {
					var usrInfo =$(this).val().split("/");//0 -> no , 1-> nm, 2-> id
					if($(this).is(":checked")) {
						usrList[usrInfo[2]] = { //키값 변경 usrNo -> usrId
							usrNo : usrInfo[0],
							usrId : usrInfo[2],
							usrNm : usrInfo[1]
						}
					} else {
						//delete usrList[usrInfo[0]]; // usrGen 로딩시 usrId 값을 키값으로 다시 불러와서 변경
						delete usrList[usrInfo[2]]; 
					}
					console.log(usrList);
				});
			}
		});
	}
	//function usrTree 끝
		
	function usrTreeTeam() {
		$.post("/ajax/member/userTreeTeam.do",function(data){
			usrSearchBox.detach();
			usrTreeDiv.find('.ui_List').html("<div id='_usrDiv'>"+ data + "</div>");
			usrTreeDiv.find('#_usrDiv').checkboxTree({
				 onCheck : {ancestors : "uncheck"},
					 collapseUiIcon: 'ui-icon-plus',
					 expandUiIcon: 'ui-icon-minus',
					 leafUiIcon: 'ui-icon-bullet'		
			});
			
			$.each(usrList, function(key, val){
				var tmpList = usrTreeDiv.find(":checkbox[name=v_usr]");
				tmpList.each(function() {
					var usrInfo = $(this).val().split("/");
					if(usrInfo[2] == val['usrId']) {
						$(this).attr("checked", "checked");
					}
				});
				// usrTreeDiv.find(":checkbox[name=v_usr][value$=\\/"+ "." +"]" ).attr("checked", "checked");
			});
			
			if(mode==1) { //usr한명만 선택할 수 있게 함.
				usrTreeDiv.find(":checkbox[name=v_org]").remove();
				usrTreeDiv.find(":checkbox[name=v_usr]").click(function(){
					var usrInfo =$(this).val().split("/");
					usrList = new Object();
					usrList[usrInfo[2]] = {
							usrNo : usrInfo[0],
							usrId : usrInfo[2],
							usrNm : usrInfo[1]
						};
					endUsrGen();
				});
			} else {				
				//making the checkbox checked
				usrTreeDiv.find(":checkbox[name=v_org]" ).each(function(index) {
						if($(this).parent().find(":checkbox[name=v_usr]:checked").length > 0 && 
							 $(this).parent().find(":checkbox[name=v_usr]").length == 
							 $(this).parent().find(":checkbox[name=v_usr]:checked").length)
						$(this).attr("checked","checked");
				});
				
				usrTreeDiv.find(":checkbox[name=v_usr]").change(function(){
					var usrInfo = $(this).val().split("/");//0 -> no , 1-> nm, 2-> id
					if($(this).is(":checked")){
						usrList[usrInfo[2]] = { //키값 변경 usrNo -> usrId
							usrNo : usrInfo[0],
							usrId : usrInfo[2],
							usrNm : usrInfo[1]
						}
					} else {
						//delete usrList[usrInfo[0]]; // usrGen 로딩시 usrId 값을 키값으로 다시 불러와서 변경
						delete usrList[usrInfo[2]]; 
					}
					console.log(usrList);
				});
			}
		});		
	}
	//function usrTreeTeam 끝
}
//function usrGen 끝

/**
 * project tree 가져오기
 * @param {string} prjNmObj
 * 		  {string} prjIdObj	  
 *        {string} mode -> 단순히 1,2로도 받고, object일 경우 year , month 등을 받는다.
 *        {string} prjId -> prjId 가 define 되어있을 경우 해당 프로젝트 및 해당 프로젝트 하위 프로젝트의 체크박스를 없앰.
 *        {string} callback -> 콜백함수
 */
function prjGen(prjNmObj, prjIdObj, mode , prjId, callback){ 
	console.log("projectGen start");
	
	//click event로 바인딩 할 경우 변수 설정
	if(typeof prjIdObj== "undefined" && typeof mode== "undefined" 
		&& typeof prjId== "undefined"&& typeof callback== "undefined") {
		prjId = prjNmObj.data.prjId;
		mode = prjNmObj.data.mode;
		prjIdObj= prjNmObj.data.prjIdObj;
		callback = prjNmObj.callback;
		prjNmObj = prjNmObj.data.prjNmObj;
		
	} else {
		if(typeof(prjNmObj)=='object')
			prjNmObj = $(prjNmObj);
		else 
			prjNmObj = $('#' + prjNmObj);
		if(typeof(prjIdObj)=='object')
			prjIdObj = $(prjIdObj);
		else
			prjIdObj = $('#' + prjIdObj);
		
	}
	var d = new Date();
	var searchData = new Object();
	searchData.year = d.getFullYear();
	searchData.month =  (d.getMonth() + 1);
	
	//mode가 object일 경우.. 
	if(typeof(mode)=='object'){
		$.extend( searchData, mode);
		mode = searchData.mode;
	}
	
		
	var position = prjNmObj.offset();
	var prjTreeDiv;
	var includeEndPrj = "N";
	var searchKeyword ="";
	if(prjIdObj.data("searchKeyword"))
		searchKeyword =prjIdObj.data("searchKeyword"); 
	if($('#_prjDiv').length>0)
	{
		$('#_prjDiv').dialog('destroy');
		$('#_prjDiv').remove();
	}
		
	var searchCondition = 1; 
	if(prjIdObj.data('searchCondition')==2)
		searchCondition = 2;
	var addBtnDiv = '';
	if(mode!=1) {
		addBtnDiv = '<div class="ui_btn">' +
			'<img src="'+imagePath+'/btn/btn_apply.gif"  class="cursorPointer" id="_sendPrjList"/>'+
			'<img src="'+imagePath+'/btn/btn_cancel.gif"  class="cursorPointer" id="_cancelPrjGen"/>'+
		'</div>';
	}
	var prjTreeDiv = $('<div id="_prjDiv">'+
							'<div class="ui_layer project">'+
							'	<dl style="height:87px;">'+
							'		<dd>'+
							'		<label><input type="radio" name="_prjTree_searchCondition" value="1" /> 참여중인 프로젝트</label>'+ 
							'		<label><input type="radio" name="_prjTree_searchCondition" value="2" /> 모든 프로젝트</label>'+
							'		<label><input type="radio" name="_prjTree_searchCondition" value="3" /> 부서 프로젝트</label>'+
							'		</dd>'+
							'		<dd><input type="checkbox" name="_prjTree_includeEndPrj" value="Y"/> 중단/완료된 프로젝트 포함</dd>'+
							'		<dd class="prjSearchBox">검색어 : <input type="text" name="_prjTree_searchKeyword"/></dd>'+
							'	</dl>'+
							'	<div class="ui_List" style="height:530px;">'+
							'	</div>'+
							'</div>'+
							addBtnDiv +		// 다중선택일 경우, 적용/취소 버튼 추가
						'</div>');
	prjTreeDiv.find('[name=_prjTree_searchCondition][value='+searchCondition+']').attr("checked","checked");
	prjTreeDiv.find('[name=_prjTree_searchKeyword]').val(searchKeyword);
	var searchAction = null;
	prjTreeDiv.find('[name=_prjTree_searchKeyword]').keyup(function(){
		searchKeyword = this.value;
		prjIdObj.data("searchKeyword",searchKeyword);
		if(searchAction) {
			clearTimeout( searchAction );
				}
		if (searchCondition==1) 
			searchAction = setTimeout(projectUserIncluded,200);
		else
			searchAction = setTimeout(projectOrganTree,200);
	});
	
	prjTreeDiv.hide().appendTo('body');	
	//ui_layer.project{width:492px; height: 530px;}
	//'	<div class="ui_List" style="height:433px;">'+ //이 부분은 수기로 수정 height - 97 
	var width = prjTreeDiv.find(".ui_layer").css("width");
	width = parseInt(width.substr(0, width.indexOf("px")) ); 
	var height = prjTreeDiv.find(".ui_layer").css("height");
	height = parseInt(height.substr(0, height.indexOf("px")) ); 
	
	var addHeight = 37;
	if(mode!=1) addHeight += 33;
	prjTreeDiv.dialog({
		width : width + 8 // +8
		,height: height + addHeight //height: 567 = 기존 css 530 + 37
		,closeOnEscape: true 
		,resizable: true 
		,draggable: true
		,autoOpen: true 		
		,position : [position.left,position.top]   
	});	
	
	prjTreeDiv.find('[name=_prjTree_searchCondition]').change(function(){
		searchCondition = prjTreeDiv.find('[name=_prjTree_searchCondition]:checked').val();
		if(searchCondition == 1) {
			prjIdObj.data('searchCondition',1);
			projectUserIncluded();
		} else if(searchCondition == 2) {
			prjIdObj.data('searchCondition',2);
			projectOrganTree();
		} else {
			prjIdObj.data('searchCondition',3);
			projectOrganTree('T');
		}
	});
	
	
	prjTreeDiv.find('[name=_prjTree_includeEndPrj]').change(function(){
		if($(this).attr('checked')) {
			includeEndPrj = '';
		} else {
			includeEndPrj = 'N';
		}
		if(searchCondition == 1)
			projectUserIncluded();
		else if(searchCondition == 2)
			projectOrganTree();
		else
			projectOrganTree('T');
	});
	if(searchCondition==1)
		projectUserIncluded();
	else if(searchCondition == 2)
		projectOrganTree();
	else
		projectOrganTree('T');
	
	// Type (A: 모든 프로젝트, T: 우리팀) 
	function projectOrganTree(type){
		
		// 모든 프로젝트 조회인지, 팀 프로젝트 조회인지 구분
		var url = "/ajax/projectOrganTree.do";
		if (type=='T') url = "/ajax/projectMyOrganTree.do";
		
		$.post(url+"?includeEndPrj="+includeEndPrj +"&searchKeyword=" +encodeURI(searchKeyword),
				function(data){
			prjTreeDiv.find('[name=_prjTree_searchKeyword]').focus();
			prjTreeDiv.find('.ui_List').html('<div class="_prj_checkBoxTree">'+data+'</div>');
			/*prjTreeDiv.find('._prj_checkBoxTree').checkboxTree({
				onCheck : {ancestors : "uncheck"},
				collapseUiIcon	: 'ui-icon-plus',
				expandUiIcon: 'ui-icon-minus',
				leafUiIcon: 'ui-icon-bullet'		
			});*/
			prjTreeDiv.find('ul').parent().addClass('expanded').css('position','relative').prepend('<span class="ui-icon ui-icon-minus" style="position:absolute; top :0px; left : -16px;"></span>');
			prjTreeDiv.find('li').children('span.ui-icon').click(function(){
				var li = $(this).parent();
				if(li.hasClass('expanded')){
					$(this).removeClass('ui-icon-minus');
					$(this).addClass('ui-icon-plus');
					li.children('ul').hide();
					li.addClass('collapsed');
					li.removeClass('expanded');
				}
				else{
					$(this).addClass('ui-icon-minus');
					$(this).removeClass('ui-icon-plus');
					li.children('ul').show();
					li.addClass('expanded');
					li.removeClass('collapsed');
				}				
			});
			
			prjTreeDiv.find('[name=_prjTree_searchCondition]').change(function(){
				searchCondition = prjTreeDiv.find('[name=_prjTree_searchCondition]:checked').val();
			});
			//making the checkbox checked
			var prjIdObjArray =prjIdObj.val().split(",");
			for (var i =0; i <prjIdObjArray.length; i++ ) {
				if(prjIdObjArray[i]=="" || prjIdObjArray[i]==null) continue;
				prjTreeDiv.find(":checkbox[name=v_prj][value^="+ prjIdObjArray[i]+"\\/]" ).attr("checked", "checked");
			}
			if(typeof prjId != "undefined") {
				prjTreeDiv.find(":checkbox[name=v_prj][value^="+ prjId+"\\/]" ).parent().find(":checkbox").remove();
				prjTreeDiv.find(":checkbox[name=v_prj][value^="+ prjId+"\\/]" ).remove();
			}
			
			prjTreeDiv.find(":checkbox[name=v_org]").remove();
			if (mode!=2) {	// 단일 선택
				prjTreeDiv.find(":checkbox[name=v_prj]").click(function(){
					if($(this).is(':checked')) {
						var prjInfo =$(this).val().split("/"); 
						prjIdObj.val(prjInfo[0]);
						prjNmObj.val(printProject(prjInfo[1],prjInfo[2]));
					} else {
						prjIdObj.val('');
						prjNmObj.val('');
					}
					if(typeof callback!= "undefined") {
						callback.call(this, prjNmObj, prjIdObj);
					}
					prjTreeDiv.dialog('destroy');
				});
			} else if (mode==2) {	// 다중 선택일 경우
				prjTreeDiv.find("#_sendPrjList").click(function(){
					var prjIdList = "";
					var prjNmList = "";
					var checkedPrjList = prjTreeDiv.find(":checkbox[name=v_prj]:checked");
					for(var i =0; i< checkedPrjList.length;i++)
					{
						var prjInfo = checkedPrjList[i].value.split("/"); 
						prjIdList += prjInfo[0] + ",";
						prjNmList += printProject(prjInfo[1], prjInfo[2]) + ",";
						
					}
					prjIdObj.val(prjIdList);
					prjNmObj.val(prjNmList);

					closePrjTreeDiv();
				});
				
				prjTreeDiv.find("#_cancelPrjGen").click(function(){
					closePrjTreeDiv();
				});
			}
		});
	};
	
	function projectUserIncluded(){

		$.post("/ajax/projectUserIncluded.do?searchKeyword=" + encodeURI(searchKeyword),
				{includeEndPrj: includeEndPrj
				,searchYear : searchData.year
				,searchMonth : searchData.month},function(data){
			prjTreeDiv.find('[name=_prjTree_searchKeyword]').focus();
			prjTreeDiv.find('.ui_List').html(data);
			
			// make clicked list
			var prjIdObjArray =prjIdObj.val().split(",");
			for (var i =0; i <prjIdObjArray.length; i++ ) {
				if(prjIdObjArray[i]=="" || prjIdObjArray[i]==null) continue;
				$('.prjUserIncludedLi input[name=prjUserIncluded_prjId][value='+prjIdObjArray[i] +']').parent().addClass('txtB_blue2');
			}
			if (mode!=2) {	// 단일 선택
				$('.prjUserIncludedLi').click(function(){
					prjNmObj.val($(this).find('[name=prjUserIncluded_prjNm]').val());
					prjIdObj.val($(this).find('[name=prjUserIncluded_prjId]').val());
					if(typeof callback!= "undefined")
					{
						callback.call(this,prjNmObj, prjIdObj);
					}
					closePrjTreeDiv();
				});
			} else if (mode==2) {	// 다중 선택일 경우
				$('.prjUserIncludedLi').click(function(){
					if ($(this).hasClass('txtB_blue2')) {
						$(this).removeClass('txtB_blue2');
					} else {
						$(this).addClass('txtB_blue2');
					}
				});
				
				prjTreeDiv.find("#_sendPrjList").click(function(){
					var prjIdList = "";
					var prjNmList = "";
					var clickedPrjList = $('.prjUserIncludedLi[class*=txtB_blue2]');
					for(var i =0; i< clickedPrjList.length;i++) {
						prjIdList += $(clickedPrjList[i]).find('[name=prjUserIncluded_prjId]').val() + ',';
						prjNmList += $(clickedPrjList[i]).find('[name=prjUserIncluded_prjNm]').val() + ',';
						
					}
					
					prjIdObj.val(prjIdList);
					prjNmObj.val(prjNmList);

					closePrjTreeDiv();
				});
				
				prjTreeDiv.find("#_cancelPrjGen").click(function(){
					closePrjTreeDiv();
				});
			}
		});
	};
	
	function closePrjTreeDiv(){
		prjTreeDiv.dialog('destroy');
		prjTreeDiv.remove();
	}
}	


function missionPrjGen(prjNmObj, prjIdObj, missionNmObj, mode , prjId, callback){ 
	console.log("projectGen start");
	
	//click event로 바인딩 할 경우 변수 설정
	if(typeof prjIdObj== "undefined" && typeof mode== "undefined" 
		&& typeof prjId== "undefined"&& typeof callback== "undefined") {
		prjId = prjNmObj.data.prjId;
		mode = prjNmObj.data.mode;
		prjIdObj= prjNmObj.data.prjIdObj;
		callback = prjNmObj.callback;
		prjNmObj = prjNmObj.data.prjNmObj;
		missionNmObj = prjNmObj.data.missionNmObj;
		
	} else {
		if(typeof(prjNmObj)=='object')
			prjNmObj = $(prjNmObj);
		else 
			prjNmObj = $('#' + prjNmObj);
		if(typeof(prjIdObj)=='object')
			prjIdObj = $(prjIdObj);
		else
			prjIdObj = $('#' + prjIdObj);
		if(typeof(missionNmObj)=='object')
			missionNmObj = $(missionNmObj);
		else
			missionNmObj = $('#' + missionNmObj);		
		
	}
	var d = new Date();
	var searchData = new Object();
	searchData.year = d.getFullYear();
	searchData.month =  (d.getMonth() + 1);
	
	//mode가 object일 경우.. 
	if(typeof(mode)=='object'){
		$.extend( searchData, mode);
		mode = searchData.mode;
	}
	
		
	var position = prjNmObj.offset();
	var prjTreeDiv;
	var includeEndPrj = "N";
	var searchKeyword ="";
	if(prjIdObj.data("searchKeyword"))
		searchKeyword =prjIdObj.data("searchKeyword"); 
	if($('#_prjDiv').length>0)
	{
		$('#_prjDiv').dialog('destroy');
		$('#_prjDiv').remove();
	}
		
	var searchCondition = 1; 
	if(prjIdObj.data('searchCondition')==2)
		searchCondition = 2;
	var prjTreeDiv = $('<div id="_prjDiv">'+
							'<div class="ui_layer project">'+
							'	<dl style="height:87px;">'+
							'		<dd>'+
							'		<label><input type="radio" name="_prjTree_searchCondition" value="1" /> 참여중인 프로젝트</label>'+ 
							'		<label><input type="radio" name="_prjTree_searchCondition" value="2" /> 모든 프로젝트</label>'+ 
							'		<label><input type="radio" name="_prjTree_searchCondition" value="3" /> 부서 프로젝트</label>'+ 
							'		</dd>'+
							'		<dd><input type="checkbox" name="_prjTree_includeEndPrj" value="Y"/> 중단/완료된 프로젝트 포함</dd>'+
							'		<dd class="prjSearchBox">검색어 : <input type="text" name="_prjTree_searchKeyword"/></dd>'+
							'	</dl>'+
							'	<div class="ui_List" style="height:633px;">'+
							'	</div>'+
							'</div>'+
						'</div>');
	prjTreeDiv.find('[name=_prjTree_searchCondition][value='+searchCondition+']').attr("checked","checked");
	prjTreeDiv.find('[name=_prjTree_searchKeyword]').val(searchKeyword);
	var searchAction = null;
	prjTreeDiv.find('[name=_prjTree_searchKeyword]').keyup(function(){
		searchKeyword = this.value;
		prjIdObj.data("searchKeyword",searchKeyword);
		if(searchAction) {
			clearTimeout( searchAction );
				}
		if (searchCondition==1) 
			searchAction = setTimeout(projectUserIncluded,200);
		else
			searchAction = setTimeout(projectOrganTree,200);
	});
	
	prjTreeDiv.hide().appendTo('body');	
	//ui_layer.project{width:492px; height: 530px;}
	//'	<div class="ui_List" style="height:433px;">'+ //이 부분은 수기로 수정 height - 97 
	var width = prjTreeDiv.find(".ui_layer").css("width");
	width = parseInt(width.substr(0, width.indexOf("px")) ); 
	var height = prjTreeDiv.find(".ui_layer").css("height");
	height = parseInt(height.substr(0, height.indexOf("px")) ); 
	
	prjTreeDiv.dialog({
		width : width + 8 // +8
		,height: height + 37 //height: 567 = 기존 css 530 + 37
		,closeOnEscape: true 
		,resizable: true 
		,draggable: true
		,autoOpen: true 		
		,position : [position.left,position.top]   
	});	
	
	prjTreeDiv.find('[name=_prjTree_searchCondition]').change(function(){
		searchCondition = prjTreeDiv.find('[name=_prjTree_searchCondition]:checked').val();
		if(searchCondition == 1) {
			prjIdObj.data('searchCondition',1);
			projectUserIncluded();
		} else {
			prjIdObj.data('searchCondition',2);
			projectOrganTree();
		}
	});
	
	
	prjTreeDiv.find('[name=_prjTree_includeEndPrj]').change(function(){
		if($(this).attr('checked')) {
			includeEndPrj = '';
		} else {
			includeEndPrj = 'N';
		}
		if(searchCondition == 1)
			projectUserIncluded();
		else if(searchCondition == 2)
			projectOrganTree();
		else
			projectOrganTree('T');
	});
	if(searchCondition==1)
		projectUserIncluded();
	else if(searchCondition == 2)
		projectOrganTree();
	else
		projectOrganTree('T');
	
	function projectOrganTree(){
		$.post("/ajax/projectOrganTree.do?includeEndPrj="+includeEndPrj +"&searchKeyword=" +encodeURI(searchKeyword),
				function(data){
			prjTreeDiv.find('[name=_prjTree_searchKeyword]').focus();
			prjTreeDiv.find('.ui_List').html('<div class="_prj_checkBoxTree">'+data+'</div>');
			/*prjTreeDiv.find('._prj_checkBoxTree').checkboxTree({
				onCheck : {ancestors : "uncheck"},
				collapseUiIcon	: 'ui-icon-plus',
				expandUiIcon: 'ui-icon-minus',
				leafUiIcon: 'ui-icon-bullet'		
			});*/
			prjTreeDiv.find('ul').parent().addClass('expanded').css('position','relative').prepend('<span class="ui-icon ui-icon-minus" style="position:absolute; top :0px; left : -16px;"></span>');
			prjTreeDiv.find('li').children('span.ui-icon').click(function(){
				var li = $(this).parent();
				if(li.hasClass('expanded')){
					$(this).removeClass('ui-icon-minus');
					$(this).addClass('ui-icon-plus');
					li.children('ul').hide();
					li.addClass('collapsed');
					li.removeClass('expanded');
				}
				else{
					$(this).addClass('ui-icon-minus');
					$(this).removeClass('ui-icon-plus');
					li.children('ul').show();
					li.addClass('expanded');
					li.removeClass('collapsed');
				}				
			});
			
			prjTreeDiv.find('[name=_prjTree_searchCondition]').change(function(){
				searchCondition = prjTreeDiv.find('[name=_prjTree_searchCondition]:checked').val();
			});
			var prjListArray =prjIdObj.val().split(",");
			for (var i =0; i <prjListArray.length; i++ ) {
				prjTreeDiv.find(":checkbox[name=v_prj][value^="+ prjListArray[i]+"\\/]" ).attr("checked", "checked");
			}
			if(typeof prjId != "undefined") {
				prjTreeDiv.find(":checkbox[name=v_prj][value^="+ prjId+"\\/]" ).parent().find(":checkbox").remove();
				prjTreeDiv.find(":checkbox[name=v_prj][value^="+ prjId+"\\/]" ).remove();
			}
			
			prjTreeDiv.find(":checkbox[name=v_org]").remove();
			prjTreeDiv.find(":checkbox[name=v_prj]").click(function(){
				if($(this).is(':checked')) {
					var prjInfo =$(this).val().split("/"); 
					prjIdObj.val(prjInfo[0]);
					prjNmObj.val(printProject(prjInfo[1],prjInfo[2]));
					missionNmObj.val('');
				} else {
					prjIdObj.val('');
					prjNmObj.val('');
					missionNmObj.val('');
				}
				if(typeof callback!= "undefined") {
					callback.call(this, prjNmObj, prjIdObj,missionNmObj);
				}
				prjTreeDiv.parent().remove();
			});
		});
	};
	
	function projectUserIncluded(){

		$.post("/ajax/projectUserIncluded.do?searchKeyword=" + encodeURI(searchKeyword),
				{includeEndPrj: includeEndPrj
				,searchYear : searchData.year
				,searchMonth : searchData.month},function(data){
			prjTreeDiv.find('[name=_prjTree_searchKeyword]').focus();
			prjTreeDiv.find('.ui_List').html(data);
			selectedPrjId = prjIdObj.val();
			if(selectedPrjId!="")
				$('.prjUserIncludedLi input[name=prjUserIncluded_prjId][value='+selectedPrjId +']').parent().addClass('txtB_blue2');
			$('.prjUserIncludedLi').click(function(){
				prjNmObj.val($(this).find('[name=prjUserIncluded_prjNm]').val());
				prjIdObj.val($(this).find('[name=prjUserIncluded_prjId]').val());
				missionNmObj.val('');
				if(typeof callback!= "undefined")
				{
					callback.call(this,prjNmObj, prjIdObj,missionNmObj);
				}
				prjTreeDiv.dialog('destroy');
				prjTreeDiv.remove();
				
			});
		});
	};
	
}





function missionPrjGen_del(prjNmObj, prjIdObj, missionNmObj, mode , prjId, callback){ 
	console.log("projectGen start");
	
	//click event로 바인딩 할 경우 변수 설정
	if(typeof prjIdObj== "undefined" && typeof mode== "undefined" 
		&& typeof prjId== "undefined"&& typeof callback== "undefined") {
		prjId = prjNmObj.data.prjId;
		mode = prjNmObj.data.mode;
		prjIdObj= prjNmObj.data.prjIdObj;
		callback = prjNmObj.callback;
		prjNmObj = prjNmObj.data.prjNmObj;
		missionNmObj = prjNmObj.data.missionNmObj;
		
	} else {
		if(typeof(prjNmObj)=='object')
			prjNmObj = $(prjNmObj);
		else 
			prjNmObj = $('#' + prjNmObj);
		if(typeof(prjIdObj)=='object')
			prjIdObj = $(prjIdObj);
		else
			prjIdObj = $('#' + prjIdObj);
		if(typeof(missionNmObj)=='object')
			missionNmObj = $(missionNmObj);
		else
			missionNmObj = $('#' + missionNmObj);		
		
	}
	var d = new Date();
	var searchData = new Object();
	searchData.year = d.getFullYear();
	searchData.month =  (d.getMonth() + 1);
	
	//mode가 object일 경우.. 
	if(typeof(mode)=='object'){
		$.extend( searchData, mode);
		mode = searchData.mode;
	}
	
		
	var position = prjNmObj.offset();
	var prjTreeDiv;
	var includeEndPrj = "N";
	var searchKeyword ="";
	if(prjIdObj.data("searchKeyword"))
		searchKeyword =prjIdObj.data("searchKeyword"); 
	if($('#_prjDiv').length>0)
	{
		$('#_prjDiv').dialog('destroy');
		$('#_prjDiv').remove();
	}
		
	var searchCondition = 1; 
	if(prjIdObj.data('searchCondition')==2)
		searchCondition = 2;
	var prjTreeDiv = $('<div id="_prjDiv">'+
							'<div class="ui_layer project">'+
							'	<dl style="height:87px;">'+
							'		<dd>'+
							'		<label><input type="radio" name="_prjTree_searchCondition" value="1" /> 참여중인 프로젝트</label>'+ 
							'		<label><input type="radio" name="_prjTree_searchCondition" value="2" /> 모든 프로젝트</label>'+ 
							'		</dd>'+
							'		<dd><input type="checkbox" name="_prjTree_includeEndPrj" value="Y"/> 중단/완료된 프로젝트 포함</dd>'+
							'		<dd class="prjSearchBox">검색어 : <input type="text" name="_prjTree_searchKeyword"/></dd>'+
							'	</dl>'+
							'	<div class="ui_List" style="height:633px;">'+
							'	</div>'+
							'</div>'+
						'</div>');
	prjTreeDiv.find('[name=_prjTree_searchCondition][value='+searchCondition+']').attr("checked","checked");
	prjTreeDiv.find('[name=_prjTree_searchKeyword]').val(searchKeyword);
	var searchAction = null;
	prjTreeDiv.find('[name=_prjTree_searchKeyword]').keyup(function(){
		searchKeyword = this.value;
		prjIdObj.data("searchKeyword",searchKeyword);
		if(searchAction) {
			clearTimeout( searchAction );
				}
		if (searchCondition==1) 
			searchAction = setTimeout(projectUserIncluded,200);
		else
			searchAction = setTimeout(projectOrganTree,200);
	});
	
	prjTreeDiv.hide().appendTo('body');	
	//ui_layer.project{width:492px; height: 530px;}
	//'	<div class="ui_List" style="height:433px;">'+ //이 부분은 수기로 수정 height - 97 
	var width = prjTreeDiv.find(".ui_layer").css("width");
	width = parseInt(width.substr(0, width.indexOf("px")) ); 
	var height = prjTreeDiv.find(".ui_layer").css("height");
	height = parseInt(height.substr(0, height.indexOf("px")) ); 
	
	prjTreeDiv.dialog({
		width : width + 8 // +8
		,height: height + 37 //height: 567 = 기존 css 530 + 37
		,closeOnEscape: true 
		,resizable: true 
		,draggable: true
		,autoOpen: true 		
		,position : [position.left,position.top]   
	});	
	
	prjTreeDiv.find('[name=_prjTree_searchCondition]').change(function(){
		searchCondition = prjTreeDiv.find('[name=_prjTree_searchCondition]:checked').val();
		if(searchCondition == 1) {
			prjIdObj.data('searchCondition',1);
			projectUserIncluded();
		} else {
			prjIdObj.data('searchCondition',2);
			projectOrganTree();
		}
	});
	
	
	prjTreeDiv.find('[name=_prjTree_includeEndPrj]').change(function(){
		if($(this).attr('checked')) {
			includeEndPrj = '';
		} else {
			includeEndPrj = 'N';
		}
		if(searchCondition == 1)
			projectUserIncluded();
		else if(searchCondition == 2)
			projectOrganTree();
		else
			projectOrganTree('T');
	});
	if(searchCondition==1)
		projectUserIncluded();
	else if(searchCondition == 2)
		projectOrganTree();
	else
		projectOrganTree('T');
	
	function projectOrganTree(){
		$.post("/ajax/projectOrganTree.do?includeEndPrj="+includeEndPrj +"&searchKeyword=" +encodeURI(searchKeyword),
				function(data){
			prjTreeDiv.find('[name=_prjTree_searchKeyword]').focus();
			prjTreeDiv.find('.ui_List').html('<div class="_prj_checkBoxTree">'+data+'</div>');
			/*prjTreeDiv.find('._prj_checkBoxTree').checkboxTree({
				onCheck : {ancestors : "uncheck"},
				collapseUiIcon	: 'ui-icon-plus',
				expandUiIcon: 'ui-icon-minus',
				leafUiIcon: 'ui-icon-bullet'		
			});*/
			prjTreeDiv.find('ul').parent().addClass('expanded').css('position','relative').prepend('<span class="ui-icon ui-icon-minus" style="position:absolute; top :0px; left : -16px;"></span>');
			prjTreeDiv.find('li').children('span.ui-icon').click(function(){
				var li = $(this).parent();
				if(li.hasClass('expanded')){
					$(this).removeClass('ui-icon-minus');
					$(this).addClass('ui-icon-plus');
					li.children('ul').hide();
					li.addClass('collapsed');
					li.removeClass('expanded');
				}
				else{
					$(this).addClass('ui-icon-minus');
					$(this).removeClass('ui-icon-plus');
					li.children('ul').show();
					li.addClass('expanded');
					li.removeClass('collapsed');
				}				
			});
			
			prjTreeDiv.find('[name=_prjTree_searchCondition]').change(function(){
				searchCondition = prjTreeDiv.find('[name=_prjTree_searchCondition]:checked').val();
			});
			var prjListArray =prjIdObj.val().split(",");
			for (var i =0; i <prjListArray.length; i++ ) {
				prjTreeDiv.find(":checkbox[name=v_prj][value^="+ prjListArray[i]+"\\/]" ).attr("checked", "checked");
			}
			if(typeof prjId != "undefined") {
				prjTreeDiv.find(":checkbox[name=v_prj][value^="+ prjId+"\\/]" ).parent().find(":checkbox").remove();
				prjTreeDiv.find(":checkbox[name=v_prj][value^="+ prjId+"\\/]" ).remove();
			}
			
			prjTreeDiv.find(":checkbox[name=v_org]").remove();
			prjTreeDiv.find(":checkbox[name=v_prj]").click(function(){
				if($(this).is(':checked')) {
					var prjInfo =$(this).val().split("/"); 
					prjIdObj.val(prjInfo[0]);
					prjNmObj.val(printProject(prjInfo[1],prjInfo[2]));
					missionNmObj.val('');
				} else {
					prjIdObj.val('');
					prjNmObj.val('');
					missionNmObj.val('');
				}
				if(typeof callback!= "undefined") {
					callback.call(this, prjNmObj, prjIdObj,missionNmObj);
				}
				prjTreeDiv.parent().remove();
				
				if(document.frm.prjNm.value != ''){
					document.getElementById("PrjDel").style.visibility = "visible";
					document.getElementById("prntMissionDel").style.visibility = "hidden";
				}
			});
		});
	};
	
	function projectUserIncluded(){

		$.post("/ajax/projectUserIncluded.do?searchKeyword=" + encodeURI(searchKeyword),
				{includeEndPrj: includeEndPrj
				,searchYear : searchData.year
				,searchMonth : searchData.month},function(data){
			prjTreeDiv.find('[name=_prjTree_searchKeyword]').focus();
			prjTreeDiv.find('.ui_List').html(data);
			selectedPrjId = prjIdObj.val();
			if(selectedPrjId!="")
				$('.prjUserIncludedLi input[name=prjUserIncluded_prjId][value='+selectedPrjId +']').parent().addClass('txtB_blue2');
			$('.prjUserIncludedLi').click(function(){
				prjNmObj.val($(this).find('[name=prjUserIncluded_prjNm]').val());
				prjIdObj.val($(this).find('[name=prjUserIncluded_prjId]').val());
				missionNmObj.val('');
				if(typeof callback!= "undefined")
				{
					callback.call(this,prjNmObj, prjIdObj,missionNmObj);
				}
				prjTreeDiv.dialog('destroy');
				prjTreeDiv.remove();
				
				if(document.frm.prjNm.value != ''){
					document.getElementById("PrjDel").style.visibility = "visible";
					document.getElementById("prntMissionDel").style.visibility = "hidden";
				}
			});
		});
	};
	
}



//mission tree 가져오기
//missionId 가 define 되어있을 경우 해당 프로젝트 및 해당 프로젝트 하위 프로젝트의 체크박스를 없앰.
//mode -> 단순히 1,2로도 받고, object일 경우 year , month 등을 받는다.
function missionGen_del(prjId, prjNm, missionNmObj, missionIdObj, missionDueDtObj, missionLvObj, prjIdObj, prjNmObj, mode , missionId, callback){
	console.log("missionGen start");
	//click event로 바인딩 할 경우 변수 설정
	if(typeof missionIdObj== "undefined" && typeof mode== "undefined" 
		&& typeof missionId== "undefined"&& typeof callback== "undefined") {
		missionId = missionNmObj.data.missionId;
		mode = missionNmObj.data.mode;
		missionIdObj= missionNmObj.data.missionIdObj;
		callback = missionNmObj.callback;
		missionNmObj = missionNmObj.data.missionNmObj;
		missionDueDtObj = missionNmObj.data.missionDueDtObj;
		missionLvObj = missionNmObj.data.missionLvObj;
		prjIdObj = missionNmObj.data.prjIdObj;
		prjNmObj = missionNmObj.data.prjNmObj;
		
	} else {
		if(typeof(missionNmObj)=='object')
			missionNmObj = $(missionNmObj);
		else 
			missionNmObj = $('#' + missionNmObj);
		if(typeof(missionIdObj)=='object')
			missionIdObj = $(missionIdObj);
		else
			missionIdObj = $('#' + missionIdObj);
		if(typeof(missionDueDtObj)=='object')
			missionDueDtObj = $(missionDueDtObj);
		else 
			missionDueDtObj = $('#' + missionDueDtObj);
		if(typeof(missionLvObj)=='object')
			missionLvObj = $(missionLvObj);
		else 
			missionLvObj = $('#' + missionLvObj);
		
		if(typeof(prjIdObj)=='object')
			prjIdObj = $(prjIdObj);
		else 
			prjIdObj = $('#' + prjIdObj);
		
		if(typeof(prjNmObj)=='object')
			prjNmObj = $(prjNmObj);
		else 
			prjNmObj = $('#' + prjNmObj);
		
	}
	var d = new Date();
	var searchData = new Object();
	searchData.year = d.getFullYear();
	searchData.month =  (d.getMonth() + 1);
	
	//mode가 object일 경우.. 
	if(typeof(mode)=='object'){
		$.extend( searchData, mode);
		mode = searchData.mode;
	}
	
		
	var position = missionNmObj.offset();
	var missionTreeDiv;
	var includeEndMission = "N";
	var searchKeyword ="";
	var searchPrjId ="";
	var searchPrjNm ="";
	
	var type = "P";;
	if(missionIdObj.data("searchKeyword"))
		searchKeyword = missionIdObj.data("searchKeyword"); 
	
	if(missionIdObj.data("searchPrjId"))
		searchPrjId = missionIdObj.data("searchPrjId"); 
	
	if(missionIdObj.data("searchPrjNm"))
		searchPrjNm = missionIdObj.data("searchPrjNm");;
	
	if($('#_missionDiv').length>0)
	{
		$('#_missionDiv').dialog('destroy');
		$('#_missionDiv').remove();
	}
		
	//var searchCondition = 1;
	if (prjId != null && prjId != "") {
		var searchCondition = 0;
	}else{
		var searchCondition = 1;
	}
	
	if(missionIdObj.data('searchCondition')==1)
		searchCondition = 1;
	
	if(missionIdObj.data('searchCondition')==2)
		searchCondition = 2;
	
	if(missionIdObj.data('searchCondition')==3)
		searchCondition = 3;
	
	var missionTreeDiv = $('<div id="_missionDiv">'+
							'<div class="ui_layer mission">'+
										'		<dd>'+
											'		 프로젝트 : <input type="text" name="_missionTree_searchPrjNm" id="_missionTree_searchPrjNm"/>'+
											'		 <input type="hidden" name="_missionTree_searchPrjId" id="_missionTree_searchPrjId"/>'+
											'		 <img src="../../images/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen(\'_missionTree_searchPrjNm\',\'_missionTree_searchPrjId\',1)" />'+
							'		</dd>'+
												'	<dl style="height:87px;">'+
							'		<dd>'+
							'		<label><input type="radio" name="_missionTree_searchCondition" value="0" /> 프로젝트 미션</label>'+
							'		<label><input type="radio" name="_missionTree_searchCondition" value="1" /> 담당 미션</label>'+ 
							'		<label><input type="radio" name="_missionTree_searchCondition" value="2" /> 작성한 미션</label>'+
							'		<label><input type="radio" name="_missionTree_searchCondition" value="3" /> 모든 미션</label>'+ 
							'		</dd>'+
							'		<dd><input type="checkbox" name="_missionTree_includeEndMission" value="Y"/> 완료된 미션 포함</dd>'+
							'		<dd class="missionSearchBox">검색어 : <input type="text" name="_missionTree_searchKeyword"/></dd>'+
							'	</dl>'+
							'	<div class="ui_List" style="height:633px;">'+
							'	</div>'+
							'</div>'+
						'</div>');
	missionTreeDiv.find('[name=_missionTree_searchCondition][value='+searchCondition+']').attr("checked","checked");
	missionTreeDiv.find('[name=_missionTree_searchKeyword]').val(searchKeyword);
	missionTreeDiv.find('[name=_missionTree_searchPrjId]').val(searchPrjId);
	// 프로젝트 관련 상위미션 선택하기 위한 조건문 추가
	if (prjId != null && prjId != "") {
		missionTreeDiv.find('[name=_missionTree_searchPrjNm]').val(prjNm);
	}else{
		missionTreeDiv.find('[name=_missionTree_searchPrjNm]').val(searchPrjNm);
	}

	var searchAction = null;
	missionTreeDiv.find('[name=_missionTree_searchKeyword]').keyup(function(){
		searchKeyword = this.value;
		missionIdObj.data("searchKeyword",searchKeyword);
		if(searchAction) {
			clearTimeout( searchAction );
		}
		if(searchCondition==0){ 
			type = "P";
			searchAction = setTimeout(missionTree,200);
		}if(searchCondition==1){ 
			type = "L";
			searchAction = setTimeout(missionTree,200);
		}else if(searchCondition==2){
			type = "W";
			searchAction = setTimeout(missionTree,200);
		}else if(searchCondition==3){
			type = "A"
			searchAction = setTimeout(missionTree,200);
		}
	
	});
	

		
	missionTreeDiv.find('[name=_missionTree_searchPrjNm]').click(function(){
	
		searchPrjId = missionTreeDiv.find('[name=_missionTree_searchPrjId]').val();

		missionIdObj.data("searchPrjId",searchPrjId);
		if(searchAction) {
			clearTimeout( searchAction );
		}
		if(searchCondition==0){ 
			type = "P";
			searchAction = setTimeout(missionUserIncluded,200);
		}if(searchCondition==1){ 
			type = "L";
			searchAction = setTimeout(missionUserIncluded,200);
		}else if(searchCondition==2){
			type = "W";
			searchAction = setTimeout(missionUserIncluded,200);
		}else if(searchCondition==3){
			type = "A"
			searchAction = setTimeout(missionTree,200);
		}
	
	});

	
	
	missionTreeDiv.hide().appendTo('body');	
	//ui_layer.mission{width:492px; height: 530px;}
	//'	<div class="ui_List" style="height:433px;">'+ //이 부분은 수기로 수정 height - 97 
	var width = missionTreeDiv.find(".ui_layer").css("width");
	width = parseInt(width.substr(0, width.indexOf("px")) ); 
	var height = missionTreeDiv.find(".ui_layer").css("height");
	height = parseInt(height.substr(0, height.indexOf("px")) ); 
	
	missionTreeDiv.dialog({
		width : width + 8 // +8
		,height: height + 37 //height: 567 = 기존 css 530 + 37
		,closeOnEscape: true 
		,resizable: true 
		,draggable: true
		,autoOpen: true 		
		,position : [position.left,position.top]   
	});	
	
	missionTreeDiv.find('[name=_missionTree_searchCondition]').change(function(){
		searchCondition = missionTreeDiv.find('[name=_missionTree_searchCondition]:checked').val();
		if(searchCondition==0){ 
			type = "P";
			missionIdObj.data('searchCondition',0);
			missionUserIncluded();
		}if(searchCondition==1){ 
			type = "L";
			missionIdObj.data('searchCondition',1);
			missionUserIncluded();
		}else if(searchCondition==2){
			type = "W";
			missionIdObj.data('searchCondition',2);
			missionUserIncluded();
		}else if(searchCondition==3){
			type = "A"
			missionIdObj.data('searchCondition',3);
			missionTree();
		}
		
	});
	
	
	missionTreeDiv.find('[name=_missionTree_includeEndMission]').change(function(){
		
		if($(this).attr('checked')) {
			includeEndMission = 'Y';
		} else {
			includeEndMission = 'N';
		}
		
		
		if(searchCondition==0){ 
			type = "P";
			missionUserIncluded();
		}if(searchCondition==1){ 
			type = "L";
			missionUserIncluded();
		}else if(searchCondition==2){
			type = "W";
			missionUserIncluded();
		}else if(searchCondition==3){
			type = "A"
			missionTree();
		}
		
	});
	
	if(searchCondition==0){ 
		type = "P";
		missionUserIncluded();
	}if(searchCondition==1){ 
		type = "L";
		missionUserIncluded();
	}else if(searchCondition==2){
		type = "W";
		missionUserIncluded();
	}else if(searchCondition==3){
		type = "A"
		missionTree();
	}
	
	
	function missionTree(){
		$.post("/ajax/missionTree.do?includeEndMission="+includeEndMission +"&searchKeyword=" +encodeURI(searchKeyword)+"&type="+type+"&searchPrjId="+searchPrjId+"&prjId="+prjId,
				function(data){
			missionTreeDiv.find('[name=_missionTree_searchKeyword]').focus();
			missionTreeDiv.find('.ui_List').html('<div class="_mission_checkBoxTree">'+data+'</div>');
			/*missionTreeDiv.find('._mission_checkBoxTree').checkboxTree({
				onCheck : {ancestors : "uncheck"},
				collapseUiIcon	: 'ui-icon-plus',
				expandUiIcon: 'ui-icon-minus',
				leafUiIcon: 'ui-icon-bullet'		
			});*/
			missionTreeDiv.find('ul').parent().addClass('expanded').css('position','relative').prepend('<span class="ui-icon ui-icon-minus" style="position:absolute; top :0px; left : -16px;"></span>');
			missionTreeDiv.find('li').children('span.ui-icon').click(function(){
				var li = $(this).parent();
				if(li.hasClass('expanded')){
					$(this).removeClass('ui-icon-minus');
					$(this).addClass('ui-icon-plus');
					li.children('ul').hide();
					li.addClass('collapsed');
					li.removeClass('expanded');
				}
				else{
					$(this).addClass('ui-icon-minus');
					$(this).removeClass('ui-icon-plus');
					li.children('ul').show();
					li.addClass('expanded');
					li.removeClass('collapsed');
				}				
			});
			
			missionTreeDiv.find('[name=_missionTree_searchCondition]').change(function(){
				searchCondition = missionTreeDiv.find('[name=_missionTree_searchCondition]:checked').val();
			});
			var missionListArray =missionIdObj.val().split(",");
			for (var i =0; i <missionListArray.length; i++ ) {
				missionTreeDiv.find(":checkbox[name=v_mission][value^="+ missionListArray[i]+"\\/]" ).attr("checked", "checked");
			}
			if(typeof missionId != "undefined") {
				missionTreeDiv.find(":checkbox[name=v_mission][value^="+ missionId+"\\/]" ).parent().find(":checkbox").remove();
				missionTreeDiv.find(":checkbox[name=v_mission][value^="+ missionId+"\\/]" ).remove();
			}
			
			//missionTreeDiv.find(":checkbox[name=v_org]").remove();
			missionTreeDiv.find(":checkbox[name=v_mission]").click(function(){
				if($(this).is(':checked')) {
					var missionInfo =$(this).val().split("/"); 
					missionIdObj.val(missionInfo[0]);
					missionNmObj.val(missionInfo[1]);
					missionDueDtObj.val(missionInfo[2]);
					missionLvObj.val(missionInfo[3]);
					prjIdObj.val(missionInfo[4]);
					prjNmObj.val(missionInfo[5]);
				} else {
					missionIdObj.val('');
					missionNmObj.val('');
					missionDueDtObj.val('');
					missionLvObj.val('');
					prjIdObj.val('');
					prjNmObj.val('');
				}
				if(typeof callback!= "undefined") {
					callback.call(this, missionNmObj, missionIdObj,missionDueDtObj,missionLvObj,prjIdObj,prjNmObj);
				}
				missionTreeDiv.parent().remove();
				
				if(document.frm.prntMissionNm.value != ''){
					document.getElementById("prntMissionDel").style.visibility = "visible";
					document.getElementById("PrjDel").style.visibility = "hidden";
				}
			});
		});
	};
	
	
	
	function missionUserIncluded(){
		$.post("/ajax/missionTree.do?includeEndMission="+includeEndMission +"&searchKeyword=" +encodeURI(searchKeyword)+"&type="+type+"&searchPrjId="+searchPrjId+"&prjId="+prjId,
				function(data){
			missionTreeDiv.find('[name=_missionTree_searchKeyword]').focus();
			missionTreeDiv.find('.ui_List').html(data);
			selectedmissionId = missionIdObj.val();
			
			$('.missionUserIncludedLi').click(function(){
				missionNmObj.val($(this).find('[name=missionUserIncluded_missionNm]').val());
				missionIdObj.val($(this).find('[name=missionUserIncluded_missionId]').val());				
				missionDueDtObj.val($(this).find('[name=missionUserIncluded_dueDt]').val());
				missionLvObj.val($(this).find('[name=missionUserIncluded_missionLv]').val());
				prjIdObj.val($(this).find('[name=missionUserIncluded_prjId]').val());
				prjNmObj.val($(this).find('[name=missionUserIncluded_prjNm]').val());
				
				
				if(typeof callback!= "undefined")
				{
					callback.call(this, missionNmObj, missionIdObj,missionDueDtObj,missionLvObj,prjIdObj,prjNmObj);
					alert("callback.call");
				}
				missionTreeDiv.dialog('destroy');
				missionTreeDiv.remove();
				
				if(document.frm.prntMissionNm.value != ''){
					document.getElementById("prntMissionDel").style.visibility = "visible";
					document.getElementById("PrjDel").style.visibility = "hidden";
				}
			});
		});
	};
	
}




//mission tree 가져오기
//missionId 가 define 되어있을 경우 해당 프로젝트 및 해당 프로젝트 하위 프로젝트의 체크박스를 없앰.
//mode -> 단순히 1,2로도 받고, object일 경우 year , month 등을 받는다.
function missionGen(prjId, prjNm, missionNmObj, missionIdObj, missionDueDtObj, missionLvObj, prjIdObj, prjNmObj, mode , missionId, callback){
	console.log("missionGen start");
	//click event로 바인딩 할 경우 변수 설정
	if(typeof missionIdObj== "undefined" && typeof mode== "undefined" 
		&& typeof missionId== "undefined"&& typeof callback== "undefined") {
		missionId = missionNmObj.data.missionId;
		mode = missionNmObj.data.mode;
		missionIdObj= missionNmObj.data.missionIdObj;
		callback = missionNmObj.callback;
		missionNmObj = missionNmObj.data.missionNmObj;
		missionDueDtObj = missionNmObj.data.missionDueDtObj;
		missionLvObj = missionNmObj.data.missionLvObj;
		prjIdObj = missionNmObj.data.prjIdObj;
		prjNmObj = missionNmObj.data.prjNmObj;
		
	} else {
		if(typeof(missionNmObj)=='object')
			missionNmObj = $(missionNmObj);
		else 
			missionNmObj = $('#' + missionNmObj);
		if(typeof(missionIdObj)=='object')
			missionIdObj = $(missionIdObj);
		else
			missionIdObj = $('#' + missionIdObj);
		if(typeof(missionDueDtObj)=='object')
			missionDueDtObj = $(missionDueDtObj);
		else 
			missionDueDtObj = $('#' + missionDueDtObj);
		if(typeof(missionLvObj)=='object')
			missionLvObj = $(missionLvObj);
		else 
			missionLvObj = $('#' + missionLvObj);
		
		if(typeof(prjIdObj)=='object')
			prjIdObj = $(prjIdObj);
		else 
			prjIdObj = $('#' + prjIdObj);
		
		if(typeof(prjNmObj)=='object')
			prjNmObj = $(prjNmObj);
		else 
			prjNmObj = $('#' + prjNmObj);
		
	}
	var d = new Date();
	var searchData = new Object();
	searchData.year = d.getFullYear();
	searchData.month =  (d.getMonth() + 1);
	
	//mode가 object일 경우.. 
	if(typeof(mode)=='object'){
		$.extend( searchData, mode);
		mode = searchData.mode;
	}
	
		
	var position = missionNmObj.offset();
	var missionTreeDiv;
	var includeEndMission = "N";
	var searchKeyword ="";
	var searchPrjId ="";
	var searchPrjNm ="";
	
	var type = "P";;
	if(missionIdObj.data("searchKeyword"))
		searchKeyword = missionIdObj.data("searchKeyword"); 
	
	if(missionIdObj.data("searchPrjId"))
		searchPrjId = missionIdObj.data("searchPrjId"); 
	
	if(missionIdObj.data("searchPrjNm"))
		searchPrjNm = missionIdObj.data("searchPrjNm");;
	
	if($('#_missionDiv').length>0)
	{
		$('#_missionDiv').dialog('destroy');
		$('#_missionDiv').remove();
	}
		
	//var searchCondition = 1;
	if (prjId != null && prjId != "") {
		var searchCondition = 0;
	}else{
		var searchCondition = 1;
	}
	
	if(missionIdObj.data('searchCondition')==1)
		searchCondition = 1;
	
	if(missionIdObj.data('searchCondition')==2)
		searchCondition = 2;
	
	if(missionIdObj.data('searchCondition')==3)
		searchCondition = 3;
	
	var missionTreeDiv = $('<div id="_missionDiv">'+
							'<div class="ui_layer mission">'+
										'		<dd>'+
												'		 프로젝트 : <input type="text" name="_missionTree_searchPrjNm" id="_missionTree_searchPrjNm"/>'+
												'		 <input type="hidden" name="_missionTree_searchPrjId" id="_missionTree_searchPrjId"/>'+
												'		 <img src="../../images/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen(\'_missionTree_searchPrjNm\',\'_missionTree_searchPrjId\',1)" />'+
								'		</dd>'+
													'	<dl style="height:87px;">'+
							'		<dd>'+
							'		<label><input type="radio" name="_missionTree_searchCondition" value="0" /> 프로젝트 미션</label>'+
							'		<label><input type="radio" name="_missionTree_searchCondition" value="1" /> 담당 미션</label>'+ 
							'		<label><input type="radio" name="_missionTree_searchCondition" value="2" /> 작성한 미션</label>'+
							'		<label><input type="radio" name="_missionTree_searchCondition" value="3" /> 모든 미션</label>'+ 
							'		</dd>'+
							'		<dd><input type="checkbox" name="_missionTree_includeEndMission" value="Y"/> 완료된 미션 포함</dd>'+
							'		<dd class="missionSearchBox">검색어 : <input type="text" name="_missionTree_searchKeyword"/></dd>'+
							'	</dl>'+
							'	<div class="ui_List" style="height:633px;">'+
							'	</div>'+
							'</div>'+
						'</div>');
	missionTreeDiv.find('[name=_missionTree_searchCondition][value='+searchCondition+']').attr("checked","checked");
	missionTreeDiv.find('[name=_missionTree_searchKeyword]').val(searchKeyword);
	missionTreeDiv.find('[name=_missionTree_searchPrjId]').val(searchPrjId);
	// 프로젝트 관련 상위미션 선택하기 위한 조건문 추가
	if (prjId != null && prjId != "") {
		missionTreeDiv.find('[name=_missionTree_searchPrjNm]').val(prjNm);
	}else{
		missionTreeDiv.find('[name=_missionTree_searchPrjNm]').val(searchPrjNm);
	}

	var searchAction = null;
	missionTreeDiv.find('[name=_missionTree_searchKeyword]').keyup(function(){
		searchKeyword = this.value;
		missionIdObj.data("searchKeyword",searchKeyword);
		if(searchAction) {
			clearTimeout( searchAction );
			}
		if(searchCondition==0){ 
			type = "P";
			searchAction = setTimeout(missionTree,200);
		}if(searchCondition==1){ 
			type = "L";
			searchAction = setTimeout(missionTree,200);
		}else if(searchCondition==2){
			type = "W";
			searchAction = setTimeout(missionTree,200);
		}else if(searchCondition==3){
			type = "A"
			searchAction = setTimeout(missionTree,200);
		}
	
	});
	

		
	missionTreeDiv.find('[name=_missionTree_searchPrjNm]').click(function(){
	
		searchPrjId = missionTreeDiv.find('[name=_missionTree_searchPrjId]').val();

		missionIdObj.data("searchPrjId",searchPrjId);
		if(searchAction) {
			clearTimeout( searchAction );
			}
		if(searchCondition==0){ 
			type = "P";
			searchAction = setTimeout(missionUserIncluded,200);
		}if(searchCondition==1){ 
			type = "L";
			searchAction = setTimeout(missionUserIncluded,200);
		}else if(searchCondition==2){
			type = "W";
			searchAction = setTimeout(missionUserIncluded,200);
		}else if(searchCondition==3){
			type = "A"
			searchAction = setTimeout(missionTree,200);
		}
	
	});

	
	
	missionTreeDiv.hide().appendTo('body');	
	//ui_layer.mission{width:492px; height: 530px;}
	//'	<div class="ui_List" style="height:433px;">'+ //이 부분은 수기로 수정 height - 97 
	var width = missionTreeDiv.find(".ui_layer").css("width");
	width = parseInt(width.substr(0, width.indexOf("px")) ); 
	var height = missionTreeDiv.find(".ui_layer").css("height");
	height = parseInt(height.substr(0, height.indexOf("px")) ); 
	
	missionTreeDiv.dialog({
		width : width + 8 // +8
		,height: height + 37 //height: 567 = 기존 css 530 + 37
		,closeOnEscape: true 
		,resizable: true 
		,draggable: true
		,autoOpen: true 		
		,position : [position.left,position.top]   
	});	
	
	missionTreeDiv.find('[name=_missionTree_searchCondition]').change(function(){
		searchCondition = missionTreeDiv.find('[name=_missionTree_searchCondition]:checked').val();
		if(searchCondition==0){ 
			type = "P";
			missionIdObj.data('searchCondition',0);
			missionUserIncluded();
		}if(searchCondition==1){ 
			type = "L";
			missionIdObj.data('searchCondition',1);
			missionUserIncluded();
		}else if(searchCondition==2){
			type = "W";
			missionIdObj.data('searchCondition',2);
			missionUserIncluded();
		}else if(searchCondition==3){
			type = "A"
			missionIdObj.data('searchCondition',3);
			missionTree();
		}
		
	});
	
	
	missionTreeDiv.find('[name=_missionTree_includeEndMission]').change(function(){
		
		if($(this).attr('checked')) {
			includeEndMission = 'Y';
		} else {
			includeEndMission = 'N';
		}
		
		
		if(searchCondition==0){ 
			type = "P";
			missionUserIncluded();
		}if(searchCondition==1){ 
			type = "L";
			missionUserIncluded();
		}else if(searchCondition==2){
			type = "W";
			missionUserIncluded();
		}else if(searchCondition==3){
			type = "A"
			missionTree();
		}
		
	});
	
	if(searchCondition==0){ 
		type = "P";
		missionUserIncluded();
	}if(searchCondition==1){ 
		type = "L";
		missionUserIncluded();
	}else if(searchCondition==2){
		type = "W";
		missionUserIncluded();
	}else if(searchCondition==3){
		type = "A"
		missionTree();
	}
	
	
	function missionTree(){
		$.post("/ajax/missionTree.do?includeEndMission="+includeEndMission +"&searchKeyword=" +encodeURI(searchKeyword)+"&type="+type+"&searchPrjId="+searchPrjId+"&prjId="+prjId,
				function(data){
			missionTreeDiv.find('[name=_missionTree_searchKeyword]').focus();
			missionTreeDiv.find('.ui_List').html('<div class="_mission_checkBoxTree">'+data+'</div>');
			/*missionTreeDiv.find('._mission_checkBoxTree').checkboxTree({
				onCheck : {ancestors : "uncheck"},
				collapseUiIcon	: 'ui-icon-plus',
				expandUiIcon: 'ui-icon-minus',
				leafUiIcon: 'ui-icon-bullet'		
			});*/
			missionTreeDiv.find('ul').parent().addClass('expanded').css('position','relative').prepend('<span class="ui-icon ui-icon-minus" style="position:absolute; top :0px; left : -16px;"></span>');
			missionTreeDiv.find('li').children('span.ui-icon').click(function(){
				var li = $(this).parent();
				if(li.hasClass('expanded')){
					$(this).removeClass('ui-icon-minus');
					$(this).addClass('ui-icon-plus');
					li.children('ul').hide();
					li.addClass('collapsed');
					li.removeClass('expanded');
				}
				else{
					$(this).addClass('ui-icon-minus');
					$(this).removeClass('ui-icon-plus');
					li.children('ul').show();
					li.addClass('expanded');
					li.removeClass('collapsed');
				}				
			});
			
			missionTreeDiv.find('[name=_missionTree_searchCondition]').change(function(){
				searchCondition = missionTreeDiv.find('[name=_missionTree_searchCondition]:checked').val();
			});
			var missionListArray =missionIdObj.val().split(",");
			for (var i =0; i <missionListArray.length; i++ ) {
				missionTreeDiv.find(":checkbox[name=v_mission][value^="+ missionListArray[i]+"\\/]" ).attr("checked", "checked");
			}
			if(typeof missionId != "undefined") {
				missionTreeDiv.find(":checkbox[name=v_mission][value^="+ missionId+"\\/]" ).parent().find(":checkbox").remove();
				missionTreeDiv.find(":checkbox[name=v_mission][value^="+ missionId+"\\/]" ).remove();
			}
			
			//missionTreeDiv.find(":checkbox[name=v_org]").remove();
			missionTreeDiv.find(":checkbox[name=v_mission]").click(function(){
				if($(this).is(':checked')) {
					var missionInfo =$(this).val().split("/"); 
					missionIdObj.val(missionInfo[0]);
					missionNmObj.val(missionInfo[1]);
					missionDueDtObj.val(missionInfo[2]);
					missionLvObj.val(missionInfo[3]);
					prjIdObj.val(missionInfo[4]);
					prjNmObj.val(missionInfo[5]);
				} else {
					missionIdObj.val('');
					missionNmObj.val('');
					missionDueDtObj.val('');
					missionLvObj.val('');
					prjIdObj.val('');
					prjNmObj.val('');
				}
				if(typeof callback!= "undefined") {
					callback.call(this, missionNmObj, missionIdObj,missionDueDtObj,missionLvObj,prjIdObj,prjNmObj);
				}
				missionTreeDiv.parent().remove();
			});
		});
	};
	
	
	
	function missionUserIncluded(){

		$.post("/ajax/missionTree.do?includeEndMission="+includeEndMission +"&searchKeyword=" +encodeURI(searchKeyword)+"&type="+type+"&searchPrjId="+searchPrjId+"&prjId="+prjId,
				function(data){
			missionTreeDiv.find('[name=_missionTree_searchKeyword]').focus();
			missionTreeDiv.find('.ui_List').html(data);
			selectedmissionId = missionIdObj.val();
			
			$('.missionUserIncludedLi').click(function(){
				missionNmObj.val($(this).find('[name=missionUserIncluded_missionNm]').val());
				missionIdObj.val($(this).find('[name=missionUserIncluded_missionId]').val());				
				missionDueDtObj.val($(this).find('[name=missionUserIncluded_dueDt]').val());
				missionLvObj.val($(this).find('[name=missionUserIncluded_missionLv]').val());
				prjIdObj.val($(this).find('[name=missionUserIncluded_prjId]').val());
				prjNmObj.val($(this).find('[name=missionUserIncluded_prjNm]').val());
				
				
				if(typeof callback!= "undefined")
				{
					callback.call(this, missionNmObj, missionIdObj,missionDueDtObj,missionLvObj,prjIdObj,prjNmObj);
				}
				missionTreeDiv.dialog('destroy');
				missionTreeDiv.remove();
			});
		});
	};
	
}	











//userComplex를 id로 이루어진 user Array로 변경해준다.
function makeUserIdArray(userComplexs){
	userComplexs = userComplexs.trimAll();
	if(userComplexs.charAt(userComplexs.length -1)==",")
		userComplexs = userComplexs.substr(0,userComplexs.length -1);
	if(userComplexs=="" || userComplexs== null)
		return new Array();		
	userComplexsArray = userComplexs.split(",");
	for(var i =0; i < userComplexsArray.length; i++)
	{
		userComplexsArray[i] = userComplexsArray[i].substr(userComplexsArray[i].indexOf("(")+1,userComplexsArray[i].indexOf(")")- userComplexsArray[i].indexOf("(")-1 );
	}

	return userComplexsArray;
}
//userComplex를 Nm로 이루어진 user Array로 변경해준다.
function makeUserNmArray(userComplexs){
	userComplexs = userComplexs.trimAll();
	if(userComplexs.charAt(userComplexs.length -1)==",")
		userComplexs = userComplexs.substr(0,userComplexs.length -1);
	if(userComplexs=="" || userComplexs== null)
		return new Array();		
	userComplexsArray = userComplexs.split(",");
	for(var i =0; i < userComplexsArray.length; i++)
	{
		userComplexsArray[i] = userComplexsArray[i].substr(0,userComplexsArray[i].indexOf("("));
	}
	
	return userComplexsArray;
}


//mode 0-> 전체 계정 불러오기. 10-> 업무경비 11-> 자기개발비 12-> 회식비 13-> 매출등록
function accGen(target, hiddenTarget, mode)
{
		console.log("accountGen start");
		//click event로 바인딩 할 경우 변수 설정
		if(typeof hiddenTarget== "undefined" && typeof mode== "undefined")
		{
				mode = target.data.mode;
				if(mode==null || mode =="undefined")
					mode = 0;
				hiddenTarget= target.data.hiddenTarget;
				target = target.data.target;
				
		}
		else
		{
				if(typeof(target)=='object')
						target = $(target);
				else 
						target = $('#' + target);
				if(typeof(hiddenTarget)=='object')
						hiddenTarget = $(hiddenTarget);
				else
						hiddenTarget = $('#' + hiddenTarget);
				
		}
		var position = target.offset();
		var treeDiv;
		if($('#_accDiv').length>0)
		{
				$('#_accDiv').dialog('destroy');
		}
		$.post("/ajax/accountTree.do?searchChildTyp="+mode,
						function(data){
				treeDiv = $("<div>temp</div>");
				treeDiv.html("<div id='_accDiv'>"+ data + "</div>").hide().appendTo('body');
				treeDiv.dialog({
					height : 475
						,width : 900 
						,closeOnEscape : true 
						,resizable : true 
						,draggable : true
						,autoOpen : true         
						,position : [position.left, position.top + 15]   
				});
				
				/* accTarget, accHiddenTarget, accTreeDiv
				 * default.js에 글로벌 변수로 정의되어있음. 이 함수(accGen) 바로 아래 */
				accTarget = target;
				accHiddenTarget = hiddenTarget;
				accTreeDiv = treeDiv;
				/*
				alert('accTarget:' + accTarget);
				alert('accHiddenTarget:' + accHiddenTarget);
				alert('accTreeDiv:' + accTreeDiv);
				*/
				/*
				treeDiv.find("li.accLeaf").click(function(){
						target.val($(this).find("[name=_prntAccNm]").val() + "(" + $(this).find("[name=_accNm]").val()+")");
						hiddenTarget.val($(this).find("[name=_accId]").val());
						treeDiv.parent().remove();
				});
				*/
		});
}

var accTarget;
var accHiddenTarget;
var accTreeDiv;

function selectAcc(obj) {
	accTarget.val($(obj).find("[name=_prntAccNm]").val() + "(" + $(obj).find("[name=_accNm]").val()+")");
	accHiddenTarget.val($(obj).find("[name=_accId]").val());
	accTreeDiv.parent().remove();
}

function setValue(name, value) {
	var l = document.getElementsByName(name);
	for (var i=0; i<l.length; i++) {
		if (l[i].value == value) {
			l[i].checked = true;
			l[i].selected = true;
		}
	}
}


function checkValidUserMixs(input){
	var mixs;
	var error;
	if(typeof(input) == "object")
	{
		input = $(input);
		if(input.val()==null || input.val()=="")
			mixs = input.html();
		else
			mixs = input.val();
	}
	else
		mixs = input;
	if(mixs=="")
	{
		var error = {"errorCode" : 1};
		return error;
	}
	$.ajax({
				url: "/ajax/checkValidUserMixs.do", 
				dataType: "html",
				type: 'POST', //I want a type as POST
				data: "userMixs="+mixs, 
				async: false,
				success: function(data){
			error = JSON.parse(data);
				}
		 });
	return error;
	/*return ($.post('/ajax/checkValidUserMixs.do',{userMixs : mixs},async: true, function(data){
		alert(data);	
		return  JSON.parse(data);
	}));*/

}


function checkValidUserMixsAuth(input){
	var mixs;
	var error;
	if(typeof(input) == "object")
	{
		input = $(input);
		if(input.val()==null || input.val()=="")
			mixs = input.html();
		else
			mixs = input.val();
	}
	else
		mixs = input;
	if(mixs=="")
	{
		var error = {"errorCode" : 1};
		return error;
	}
	$.ajax({
				url: "/ajax/checkValidUserMixsAuth.do", 
				dataType: "html",
				type: 'POST', //I want a type as POST
				data: "userMixs="+mixs, 
				async: false,
				success: function(data){
			error = JSON.parse(data);
				}
		 });
	return error;
	/*return ($.post('/ajax/checkValidUserMixs.do',{userMixs : mixs},async: true, function(data){
		alert(data);	
		return  JSON.parse(data);
	}));*/

}




function checkValidLaborUserMixs(reviewerMixs,laborUserMixs){	
	var error;
	$.ajax({
				url: "/ajax/checkValidLaborUserMixs.do", 
				dataType: "html",
				type: 'POST',
				data: "data="+reviewerMixs+"AND"+laborUserMixs, 
				async: false,
				success: function(data){
			error = JSON.parse(data);
				}
		 });
	return error;

}


function printProject(prjNm, prjCd, prjId, link) {
	if (link == true) {
		return "<a href=\"/cooperation/selectProjectV.do?prjId=" + prjId + "\" target=\"_blank\">" + "[" + prjCd +"] " + prjNm + "</a>";
	}
	return "[" + prjCd +"]" + prjNm;
}
var console;
if (console === undefined) {
	console = { log : function(){} };
}

function openUsrLayer(userNo,target){
	var position = $(target).offset();
	var left = position.left ;
	var top = position.top + 5 ;
	$.post('/ajax/openUserLayer.do?userNo='+userNo,function(data){
		if($('.mouseOver_User').length>0)
		{
			delete $('.mouseOver_User');
		}
		var layer = $('<div class="mouseOver_User"></div>');
		layer.html(data);
		layer.appendTo('body');
		layer.css("left",left+20+"px");
		layer.css("top",top+"px");
		layer.focus();
		$('body').bind('click.usrLayer', usrLayerClickEvent );
		function usrLayerClickEvent(event){
			//2012-11-15 Arvin : Admin 페이지에서 layer를 못찾는 문제가 있어서 닫는 방식 변경했다가 원복
			//$('body').unbind('click.usrLayer');
			//layer.remove();	         
					
			if (!$(event.target).closest(layer).length) {
				$('body').unbind('click.usrLayer');
				layer.remove();
			};
		}
	});		
};
function displayMessageSimple(msg, color, target, delay) {
		
	var position = $(target).offset();
	var left = position.left + 65;
	var top = position.top - 2 ;
	
//	if(delay == undefined)	
//		var delay = 1000;		

	//calling message.jsp	
	$.post(rootPath + "/common/displayMessageSimple.do?msg=" + encodeURIComponent(msg) + "&color=" + color, function(data) {
		var cemterMessageLayer = '<div class="center_Message" style="left: ' + left + 'px; top: ' + top +'px; "></div>';
		cemterMessageLayer = $(cemterMessageLayer);
		cemterMessageLayer.html(data);
		cemterMessageLayer.appendTo('body');
		
		cemterMessageLayer.hide();
		if(delay == "short"){		
			cemterMessageLayer.fadeIn(400).delay(200).fadeOut(400, function() {
				cemterMessageLayer.remove();
			});		
		}else{
			cemterMessageLayer.fadeIn(800).delay(400).fadeOut(800, function() {
				cemterMessageLayer.remove();
			});
		}
	});
}
function refreshChkList() {
	$.post(rootPath + "/common/getCheckList.do", function(data) {
			$('#chkList').html(data);
	});
}
function noteChk() {
	var act = new yAjax(rootPath + "/ajax/getNoteIdXml.do", "POST");
	var popup = {};
	act.statechange = function(){
		var xml = act.getResXmlObject();
		var noteIds = xml.getValue("noteIds",0);
		if (noteIds != "") {
			var noteIdList = noteIds.split(",");
			for (var i=0; i<noteIdList.length; i++) {
				popup[i] = window.open(rootPath + "/community/selectNote.do?readChk=Y&noteId=" + noteIdList[i] + "&recieveMode=Y", "recieveNoteView_" + noteIdList[i], 'top=0px, left=0px, width=600px, height=565px, ,scrollbars=yes');
			}
			for (var key in popup) {
				popup[key].focus();
			}
		}
	};
	act.action();
}
function connectionChk() {
	$.post(rootPath + "/common/updateCurrentUser.do", function(data) {
		;
	});
}
function displayMessage() {
	$.post(rootPath + "/common/displayMessage.do", function(data) {
		
		var cemterMessageLayer = '<div class="center_Message" style="left: 20px; top: 94px; "></div>';
		cemterMessageLayer = $(cemterMessageLayer);
		cemterMessageLayer.html(data);
		cemterMessageLayer.appendTo('body');
		
		cemterMessageLayer.hide();
		cemterMessageLayer.fadeIn(1000).delay(15000).fadeOut(1000, function() {
			cemterMessageLayer.remove();
		});
	});
}

function processUnloadNoteV(wndHandle, noteId, readDt) {
	setTimeout(function(){updateNoteReadStat(wndHandle, noteId, readDt);}, 0);
}
function updateNoteReadStat(wndHandle, noteId, readDt) {
	if (wndHandle == null || wndHandle.closed) {
		if (readDt == null || readDt == '') {
			$.post(rootPath + "/community/setNoteReadDt.do?noteId=" + noteId, function(data) {
				;
			});
			setTimeout(function(){refreshChkList();}, 1000);
		}
	}
	else {
		;
	}
}

var boolDelayCount = 0;

var containHeadPage = false;

function commonTimer() {
	if (boolDelayCount > 0) {
		boolDelayCount = boolDelayCount - 1;
	} else {
		refreshChkList();
		//connectionChk();//현재접속 상태 갱신. 1분 초과 딜레이일 경우 의미 없음
		if (containHeadPage)
			displayMessage();
	}
	//setTimeout("commonTimer()",60000); //1분 기존방식
	setTimeout("commonTimer()",600000); //10분 
}

function delayCommonTimer(count) {
	boolDelayCount = count;
}
//쪽지 불러오는 타이머
function noteTimer() {
	connectionChk();//현재접속 상태 갱신 1분 이하 딜레이
	noteChk();
	setTimeout("noteTimer()",60000); //1분 기존방식
}

// 프로젝트에 마우스 오버 시 프로젝트 풀네임 표시
// mgmt_projectResultStatistic.jsp
function showPrjFullNm(prjName, obj) {

	if($('.mouseOver_prjName').length>0)
	{
		$('.mouseOver_prjName').remove();
	}
	
	var layer = $('<div class="mouseOver_prjName">' + prjName + '</div>');
	
	layer.css("left",($(obj).offset().left+20)+"px");
	layer.css("top",($(obj).offset().top+15)+"px");

	layer.css("width", (prjName.length*10));
	
	layer.appendTo('body');
}

// 프로젝트에 마우스 아웃 시 레이어 없앰
//mgmt_projectResultStatistic.jsp
function hidePrjFullNm() {
	$('.mouseOver_prjName').remove();
}

//부재중현황에 마우스 오버 시 프로젝트 풀네임 표시
//left_status.jsp
function showState(obj) {

	if($('.mouseOver_state').length>0)
	{
		$('.mouseOver_state').remove();
	}
	
	var layer = $('<div class="mouseOver_state">' + $(obj).next().val() + '</div>');
	
	layer.css("left",($(obj).offset().left+20)+"px");
	layer.css("top",($(obj).offset().top+15)+"px");

	var size = ($(obj).next().val().length*12);
	if (size > 400)
		size = 400;
	layer.css("width", size);
	
	layer.appendTo('body');
}

//부재중현황에 마우스 아웃 시 레이어 없앰
//left_status.jsp
function hideState() {
	$('.mouseOver_state').remove();
}

function scrapArticle(typ, articleId) {
	if (confirm('스크랩하시겠습니까?')) {
		$.post("/mypage/insertScrap.do?typ=" + typ + "&articleId=" + articleId,
				function(data){
					;
				}
		);
	}
}

//도움말 창
function showHelp(content, obj) {
	if($('.mouseOver_help').length>0)
	{
		$('.mouseOver_help').remove();
	}
	
	var layer = $('<div class="mouseOver_help">' + content + '</div>');
	
	layer.css("left",($(obj).offset().left+20)+"px");
	layer.css("top",($(obj).offset().top+15)+"px");

	var size = (content.length*12);
	if (size > 400)
		size = 400;
	layer.css("width", size);
	
	layer.appendTo('body');
}
function hideHelp() {
	$('.mouseOver_help').remove();
}

//그 달의 마지막 일자 리턴
function lastDaySelect(DMonth) {
	var Dyear = parseInt(DMonth.substr(0, 4));
	if (DMonth.substr(4, 1) == "0")
		DMonth = parseInt(DMonth.substr(5, 1));
	else
		DMonth = parseInt(DMonth.substr(4, 2));
	var tempDay = 0;
		switch (DMonth) {
			case 1: case 3: case 5: case 7: case 8: case 10: case 12:
				{ tempDay = 31; break; }
			case 4: case 6: case 9: case 11:
				{ tempDay = 30; break; }
			case 2: {
				if ((Dyear % 4 == 0 && Dyear % 100 != 0) || Dyear % 400 == 0) {
					tempDay = 29; break;
				} else {
					tempDay = 28; break;
				}
				}
		}
		return tempDay;
}
//그 달의 1일 날짜 리턴
function getFirstDayOfMonth(yyyymmdd) {
	yyyymmdd = yyyymmdd.substring(0,6) + "01";
	return yyyymmdd;
}
//그 달의 마지막 날짜 리턴
function getLastDayOfMonth(yyyymmdd) {
	var tDate = new Date(parseInt(yyyymmdd.substring(0,4)), parseInt(yyyymmdd.substring(4,6)), 0 );
	var year = tDate.getFullYear();
	var month = tDate.getMonth();
	var date = tDate.getDate();
	month = month + 1;
	if ((month + "").length == 1)
		month = "0" + month;
	if ((date + "").length == 1)
		date = "0" + date;	
	var resultDate = year + "" + month + "" + date;
	return resultDate;
}
//날짜 차이 계산 함수
//사용예 : var getDiff = getDateDiff("2008-12-03", "2008-12-01");
//사용예 : var getDiff = getDateDiff("20081203", "20081201");
function getDateDiff(date1, date2) {
	var arrDate1 = new Array();
	var arrDate2 = new Array();
	if(date1.indexOf("-") > -1) { // date1 : 기준 날짜(YYYY-MM-DD), date2 : 대상 날짜(YYYY-MM-DD)
		arrDate1 = date1.split("-");
		arrDate2 = date2.split("-");
	} else { //date1 : 기준 날짜(YYYYMMDD), date2 : 대상 날짜(YYYYMMDD)
		arrDate1[0] = date1.substring(0,4);
			arrDate1[1] = date1.substring(4,6);
			arrDate1[2] = date1.substring(6,8);   
			arrDate2[0] = date2.substring(0,4);
			arrDate2[1] = date2.substring(4,6);
			arrDate2[2] = date2.substring(6,8);    
	}    
		var getDate1 = new Date(parseInt(arrDate1[0]), parseInt(arrDate1[1])-1, parseInt(arrDate1[2]) );    
		var getDate2 = new Date(parseInt(arrDate2[0]), parseInt(arrDate2[1])-1, parseInt(arrDate2[2]) );    
		var getDiffTime = getDate1.getTime() - getDate2.getTime();
		
		return Math.floor(getDiffTime / (1000 * 60 * 60 * 24));
}
//Date 객체에서 YYYYmmdd 문자열로 변환
function getDate(tDate, add){
	if(typeof tDate == "number" || typeof tDate == "string"){ // YYYYmmdd
		tDate = new Date(parseInt(tDate.substring(0,4)), parseInt(tDate.substring(4,6))-1, parseInt(tDate.substring(6,8)) );
	}
	if(typeof add == "number" || typeof add == "string"){
		tDate.setDate(tDate.getDate() + add);
	}
	var year = tDate.getFullYear();
	var month = tDate.getMonth();
	var date = tDate.getDate();
	month = month + 1;
	if ((month + "").length == 1)
		month = "0" + month;
	if ((date + "").length == 1)
		date = "0" + date;	
	var resultDate = year + "" + month + "" + date;
	return resultDate;
}
//Date 객체에서 YYYYmmdd 문자열로 변환
function getDateAdd(tDate, add){
	tDate.setDate(tDate.getDate() + add);
	var year = tDate.getFullYear();
	var month = tDate.getMonth();
	var date = tDate.getDate();
	month = month + 1;
	if ((month + "").length == 1)
		month = "0" + month;
	if ((date + "").length == 1)
		date = "0" + date;	
	var resultDate = year + "" + month + "" + date;
	return resultDate;
}

/**
 * 이메일 유효성 검사
 */
function isValidEmail(email) {
	var re = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
		return re.test(email);
}


/**
 * 이메일 유효성 검사
 */
/*
function isValidEmail(email) {
	var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
	return isValidFormat(input, format);
}
 */
/**
 * 지정한 포맷에 맞는 형식인지 유효성 검사
 */
/*
function isValidFormat(input, format) {
	if (input.value.search(format) != -1) {
		return true; // 올바른 포맷 형식
	}
	return false;
}
 */


//date format 함수  : Date 내장 객체에 format함수 추가
Date.prototype.format = function(f) {
	if (!this.valueOf()) return " ";
	
		var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
		var d = this;
		
		return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
			switch ($1) {
				case "yyyy": return d.getFullYear();
				case "yy": return (d.getFullYear() % 1000).zf(2);
				case "MM": return (d.getMonth() + 1).zf(2);
				case "dd": return d.getDate().zf(2);
				case "E": return weekName[d.getDay()];
				case "HH": return d.getHours().zf(2);
				case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
				case "mm": return d.getMinutes().zf(2);
				case "ss": return d.getSeconds().zf(2);
				case "a/p": return d.getHours() < 12 ? "오전" : "오후";
				default: return $1;
			 }
		});
	};

//한자리일경우 앞에 0을 붙여준다.
String.prototype.string = function(len){
		var s = '', i = 0; 
		while (i++ < len) { s += this; } 
		return s;
}; 
String.prototype.zf = function(len){
	return "0".string(len - this.length) + this;
};
Number.prototype.zf = function(len){
	return this.toString().zf(len);
};

//초성검색 autocomplete 이벤트 제거
function removeAutoComplete(searchKeyword) {
	searchKeyword.die();
	searchKeyword.autocomplete({
	}).data( "autocomplete" )._renderItem = function( ul, item ) {
		return ul.html('');
	};
}

function setCookie(cName, cValue, cDay) {
	var expire = new Date();
	expire.setDate(expire.getDate() + cDay);
	cookies = cName + '=' + escape(cValue) + '; path=/ ';	// 한글 깨짐을 막기 위해 escape(cValue)를 합니다.
	if(typeof cDay != 'undefined') cookies += '; expires=' + expire.toGMTString() + ';';
	document.cookie = cookies;
}

function getCookie(cName) {
	cName = cName + '=';
	var cookieData = document.cookie;
	var start = cookieData.indexOf(cName);
	var cValue = '';
	if (start != -1) {
		start += cName.length;
		var end = cookieData.indexOf(';', start);
		if (end == -1) end = cookieData.length;
		cValue = cookieData.substring(start, end);
	}
	return unescape(cValue);
}

/**
 * 도움말 툴팁 메세지 바인드 함수 
 * @param {obj as object, nttId as String, width as String} 
 *         obj : 호출한 객체
 *         nttId : 
 *         width : 도움말 툴팁의 너비(px)  
 * @return {number} This returns something that has a description too long to
 *     fit in one line.
 */
var objTooltipList = new Object();	// 전역 툴팁 객체
function bindTooltip(obj, nttId, width) {
	var bbsId = 'BBSMSTR_000000000003';	// 도움말 툴팁 게시판 구분ID
	
	// 해당 nttId의 Tooltip을 가져온 이력 경우, ajax로 툴팁 내용 가져옴
	if (!objTooltipList.hasOwnProperty('nttId'+nttId)) {
		// jQuery ajax
		var divContent = $('<div>');
		divContent.addClass('tooltipContent');
		
		var tooltipWidth = '200';
		$.ajax({
			url: "/ajax/admin/selectBoardArticle.do",
			data: {
				bbsId: bbsId,
				nttId: nttId
			},
			type: "POST",
			async: false,
			dataType: "json",
			success: function(data) {
				if (width!=undefined) tooltipWidth = width;
				divContent.html(data.content);
			},
			error: function(xhr, testStatus, errorThrown) {
				divContent.html('툴팁 메세지를 가져오지 못했습니다.');
	  	 	}
		});
		divContent.css('width', tooltipWidth+'px');
		objTooltipList['nttId'+nttId] = divContent;
	}
	
	// 이미 툴팁을 바인딩 했다면, Pass~
	if ($(obj).find('.tooltipContent').length == 1) {
		return false;
	}
	
	// 툴팁이 비어있다면, Pass~
	var tooltipContent = objTooltipList['nttId'+nttId];
	
	$(obj).append(tooltipContent);
}