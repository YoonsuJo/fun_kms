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
		
		if (bool)
			$.post("/member/updateUiSetting.do?showRight=1", function() {});
	}
	else if(right.style.display==''){
		right.style.display='none';
		document.getElementById('center').style.width='942px';
		$('#center').trigger('hideRightEvent');
		
		document.getElementById('arrowImg').src = imagePath + "/inc/arrow_left.gif";

		if (bool)
			$.post("/member/updateUiSetting.do?showRight=0", function() {});
	}
}


/*
	조직도 가져오기. 변수로는 클릭 이벤트를 받을 객체, form에 조직 id값들을 저장할 hidden 으로 setting된 input의 id를 넣어주어야 함.
	  
*/
//조직도 가져오기 Ajax Use Jquery
function orgGen(elem, hiddenTarget, mode){ 
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
	if($('#_orGDiv').length>0)
	{
		$('#_orGDiv').dialog('destroy');
		$('#_orGDiv').remove();
	}

	$.post("/ajax/organ/OrganTree.do",
	function(data){
		orgTreeDiv = $('<div class="_orGDiv">'+
						'<div class="ui_layer">'+
						'<div class="ui_List" >'+
						'</div>'+
						'</div>'+
					'</div>');
		orgTreeDiv.find('.ui_List').html("<div id='_usrDiv'>"+ data + "</div>");
		orgTreeDiv.hide().appendTo('body');
		var height =550;
		if(mode==2);
			height = 565;
		orgTreeDiv.dialog({
 		    height: height
 		   ,width: 400 
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
		for (var i =0; i <hiddenTargetArray.length; i++ )
		{
			if(hiddenTargetArray[i]=="" || hiddenTargetArray[i]==null)
				continue;
			orgTreeDiv.find(":checkbox[name=v_org][value^="+ hiddenTargetArray[i]+"\\/]" ).attr("checked", "checked");
				
		}
		
		if(mode==1)
		{
			orgTreeDiv.find(":checkbox[name=v_org]").click(function(){
				if($(this).is(':checked'))
				{
					var organInfo =$(this).val().split("/"); 
					hiddenTarget.val(organInfo[0]);
					$(elem).val(organInfo[1]);
						
				}
				else
				{
					hiddenTarget.val(null);
					$(elem).val(null);
				}
				orgTreeDiv.parent().remove();
			});
		}
		else{
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
function usrGen(usrNmObj, usrIdObj, mode, callback){ 
	var keyCode = $.ui.keyCode;
	console.log("usrGen start");
	var usrNmObj;
	if(typeof(usrNmObj)=='object')
		usrNmObj = $(usrNmObj);
	else
		usrNmObj = $('#' + usrNmObj);
	if(typeof(usrIdObj)=='object')
		usrIdObj= $(usrIdObj);
	else if(typeof(usrIdObj)=='number')
	{
		callback = mode;
		mode = usrIdObj;
		usrIdObj =null;
	}
	else
		usrIdObj= $('#' + usrIdObj);
	
	if($('#_usrDiv').length>0)
	{
		$('#_usrDiv').dialog('destroy');
		$('#_usrDiv').remove();
	}
	
	
	var position = usrNmObj.offset();
	var searchKeyword ="";
	var usrTreeDiv = $('<div id="_usrDiv">'+
			'<div class="ui_layer usr">'+
			'	<dl>'+
			'		<dd>'+
			'		<label><input type="radio" name="_usrTree_searchCondition" value="1" /> 검색</label>'+ 
			'		<label><input type="radio" name="_usrTree_searchCondition" value="2" checked/> 조직도에서 찾기</label>'+ 
			'		</dd>'+
			'	</dl>'+
			'	<div class="ui_List">'+
			'	</div>'+
			'</div>'+
		'</div>');
	var usrSearchBox = $('<dd class="usrSearchBox">검색어 : <input type="text" name="searchKeyword"/></dd>');
	usrTreeDiv.find('[name=_usrTree_searchCondition]').change(function(){
		searchCondition = usrTreeDiv.find('[name=_usrTree_searchCondition]:checked').val();
		if(searchCondition == 1)
			usrSearchLayer();
		else
			usrTree();
	});
	usrTreeDiv.hide().appendTo('body');
	var height = 550;
	if(mode!=1){
		height = 565;
		$('<div class="ui_btn">'+
			'<img src="'+imagePath+'/btn/btn_apply.gif"  class="cursorPointer" id="_sendUsrList"/>'+
			'<img src="'+imagePath+'/btn/btn_cancel.gif"  class="cursorPointer" id="_cancelUsrGen"/>'+
		'</div>').appendTo(usrTreeDiv);
	}
	var usrList = new Object(); 
	if(usrIdObj!=null)
	{
		;
	}
	else
	{
		var usrIdList=makeUserIdArray(usrNmObj.val());
		var usrNmList =makeUserNmArray(usrNmObj.val());
		for(var i = 0; i< usrIdList.length; i++){
			usrList[usrIdList[i]] = {
					usrId : usrIdList[i],
					usrNm : usrNmList[i]
			}
		}
	}
	usrTreeDiv.dialog({
		    height: height
		   ,width:400
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
		 }
		 else if(event.which == keyCode.SPACE){
			 event.preventDefault();
			 if(uiList.find('li.state-hover').length==1){
				 liChecked(uiList.find('li.state-hover'));
			 }
		 }
		 else if(event.which == keyCode.ENTER){
			 event.preventDefault();
			 endUsrGen();
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

	usrTree();
	
	
	//함수 선언
	
	function usrSearch(searchKeyword,usrIdList){
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
		if(typeof(usrList[usrId])=="undefined")
		{
			usrList[usrId] = {
				usrNo : li.find('[name$=usrNo]').val(),
				usrId : li.find('[name$=usrId]').val(),
				usrNm : li.find('[name$=usrNm]').val()
			};
			
			li.addClass('state-checked');
			if(mode==1){
				endUsrGen();
			}
		}
		else
		{
			delete usrList[usrId];
			li.removeClass('state-checked');
		}
		
			
	};
		
	function usrSearchLayer(){
		usrSearchBox.appendTo(usrTreeDiv.find('dl'));
		usrSearchBox.find('[name=searchKeyword]').focus();
		usrSearch(searchKeyword);
	};
	
	function endUsrGen(){
		if(usrIdObj==null){
			var userMixs = "";
			 $.each(usrList, function(key,val){
				 userMixs = userMixs + val.usrNm + "(" + val.usrId + ")" +",";
			 });
			 if(userMixs.substring(userMixs.length-1)==",")
				 userMixs = userMixs.substring(0,userMixs.length-1);
			 usrNmObj.val(userMixs);
			 usrTreeDiv.dialog('destroy');
			 if(typeof callback!= "undefined")
			{
				callback.call(this,usrNmObj, usrIdObj);
			}
		}
	};
	
	
	
	function usrTree(){
		$.post("/ajax/member/userTree.do",function(data){
			usrSearchBox.detach();
			usrTreeDiv.find('.ui_List').html("<div id='_usrDiv'>asdfasdf"+ data + "</div>");
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
			
			if(mode==1)//usr한명만 선택할 수 있게 함.
			{
				usrTreeDiv.find(":checkbox[name=v_org]").remove();
				usrTreeDiv.find(":checkbox[name=v_usr]").click(function(){
					var usrInfo =$(this).val().split("/");
					usrList = new Object();
					usrList[usrInfo[0]] = {
							usrNo : usrInfo[0],
							usrId : usrInfo[2],
							usrNm : usrInfo[1]
						};
					endUsrGen();
				});
			}
			else{
				
				//making the checkbox checked
				usrTreeDiv.find(":checkbox[name=v_org]" ).each(function(index)
				{
						if($(this).parent().find(":checkbox[name=v_usr]:checked").length>0 && 
							$(this).parent().find(":checkbox[name=v_usr]").length == $(this).parent().find(":checkbox[name=v_usr]:checked").length)
						$(this).attr("checked","checked");
				});
				
				usrTreeDiv.find(":checkbox[name=v_usr]").change(function(){
					var usrInfo =$(this).val().split("/");//0 -> no , 1-> nm, 2-> id
					if($(this).is(":checked")){
						usrList[usrInfo[0]] = {
							usrNo : usrInfo[0],
							usrId : usrInfo[2],
							usrNm : usrInfo[1]
						}
					}
					else
						delete usrList[usrInfo[0]];
					console.log(usrList);
				});
			}
		});
		
	}
}

//project tree 가져오기
//prjId 가 define되어있을 경우, 해당 프로젝트 및 해당 프로젝트 하위 프로젝트의 체크박스를 없앰.
//mode -> 단순히 1,2로도 받고, object일 경우 year , month 등을 받는다.
function prjGen(prjNmObj, prjIdObj, mode , prjId, callback){ 
	console.log("projectGen start");
	
	//click event로 바인딩 할 경우 변수 설정
	if(typeof prjIdObj== "undefined" && typeof mode== "undefined" && typeof prjId== "undefined"&& typeof callback== "undefined")
	{
		prjId = prjNmObj.data.prjId;
		mode = prjNmObj.data.mode;
		prjIdObj= prjNmObj.data.prjIdObj;
		callback = prjNmObj.callback;
		prjNmObj = prjNmObj.data.prjNmObj;
		
	}
	else
	{
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
	var prjTreeDiv = $('<div id="_prjDiv" class="prjBox" style="width:100%; position:absolute; left:0px; top:32px; background:#fff; ">'+
							'<div id="prj" class="ui_layer project" style="width;100%;">'+
							'	<dl style="height:87px; display:none">'+
							'		<dd>'+
							'		<label><input type="radio" name="_prjTree_searchCondition" value="1" /> 참여중인 프로젝트</label>'+ 
							'		<label><input type="radio" name="_prjTree_searchCondition" value="2" /> 모든 프로젝트</label>'+ 
							'		</dd>'+
							'		<dd><input type="checkbox" name="_prjTree_includeEndPrj" value="Y"/> 중단/완료된 프로젝트 포함</dd>'+
							'		<dd class="prjSearchBox">검색어 : <input type="text" name="_prjTree_searchKeyword"/></dd>'+
							'	</dl>'+
							'	<p class="bgTopBtn shadowBtn bgTopBtnBor" style="color:#fff; margin-top;10px; font-size:14px;">프로젝트 리스트</p>'+
							'	<div class="ui_List" style="font-size:14px;">'+
							'	</div>'+
							'</div>'+
						'</div>');
	prjTreeDiv.find('[name=_prjTree_searchCondition][value='+searchCondition+']').attr("checked","checked");
	prjTreeDiv.find('[name=_prjTree_searchKeyword]').val(searchKeyword);
	var searchAction = null;
	prjTreeDiv.find('[name=_prjTree_searchKeyword]').keyup(function(){
		searchKeyword = this.value;
		prjIdObj.data("searchKeyword",searchKeyword);
		if(searchAction)
		{
			clearTimeout( searchAction );
        }
		if (searchCondition==1) 
			searchAction = setTimeout(projectUserIncluded,200);
		else
			searchAction = setTimeout(projectOrganTree,200);
	});
	prjTreeDiv.hide().appendTo('body');
	var width = prjTreeDiv.find(".ui_layer").css("width");
	width = parseInt(width.substr(0, width.indexOf("px"))) + 8;
	prjTreeDiv.dialog({
		width : screen.width
		,height:350	
		,closeOnEscape: true 
		,resizable: true 
		,draggable: true
		,autoOpen: true 		
		,position : [position.left,position.top]   
	});	
	
	prjTreeDiv.find('[name=_prjTree_searchCondition]').change(function(){
		searchCondition = prjTreeDiv.find('[name=_prjTree_searchCondition]:checked').val();
		if(searchCondition == 1)
		{
			prjIdObj.data('searchCondition',1);
			projectUserIncluded();
		}
		else
		{
			prjIdObj.data('searchCondition',2);
			projectOrganTree();
		}
	});
	
	
	prjTreeDiv.find('[name=_prjTree_includeEndPrj]').change(function(){
		if($(this).attr('checked'))
		{
			includeEndPrj = '';
		}
		else
		{
			includeEndPrj = 'N';
		}
		if(searchCondition == 1)
			projectUserIncluded();
		else
			projectOrganTree();
	});
	if(searchCondition==1)
		projectUserIncluded();
	else
		projectOrganTree();
	
	function projectOrganTree(){
		$.post("/ajax/projectOrganTree.do?includeEndPrj="+includeEndPrj +"&searchKeyword=" +encodeURI(searchKeyword),
				function(data){
			prjTreeDiv.find('[name=_prjTree_searchKeyword]').focus();
			prjTreeDiv.find('.ui_List').html('<div class="_prj_checkBoxTree">'+data+'</div');
			/*prjTreeDiv.find('._prj_checkBoxTree').checkboxTree({
				onCheck : {ancestors : "uncheck"},
				collapseUiIcon	: 'ui-icon-plus',
				expandUiIcon: 'ui-icon-minus',
				leafUiIcon: 'ui-icon-bullet'		
			});*/
			/* 모든 프로젝트 리스트 출력 */
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
			for (var i =0; i <prjListArray.length; i++ )
			{
				prjTreeDiv.find(":checkbox[name=v_prj][value^="+ prjListArray[i]+"\\/]" ).attr("checked", "checked");
			}
			if(typeof prjId != "undefined")
			{
				prjTreeDiv.find(":checkbox[name=v_prj][value^="+ prjId+"\\/]" ).parent().find(":checkbox").remove();
				prjTreeDiv.find(":checkbox[name=v_prj][value^="+ prjId+"\\/]" ).remove();
			}
			
			prjTreeDiv.find(":checkbox[name=v_org]").remove();
			prjTreeDiv.find(":checkbox[name=v_prj]").click(function(){
				if($(this).is(':checked'))
				{
					var prjInfo =$(this).val().split("/"); 
					prjIdObj.val(prjInfo[0]);
					prjNmObj.val(printProject(prjInfo[1],prjInfo[2]));
				}
				else
				{
					prjIdObj.val('');
					prjNmObj.val('');
				}
				if(typeof callback!= "undefined")
				{
					callback.call(this,prjNmObj, prjIdObj);
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
				if(typeof callback!= "undefined")
				{
					callback.call(this,prjNmObj, prjIdObj);
				}
				prjTreeDiv.dialog('destroy');
				prjTreeDiv.remove();
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
        	height : 300
            ,width : 300 
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

function printProject(prjNm, prjCd, prjId, link)
{
	if (link == true) {
		return "<a href=\"/cooperation/selectProjectV.do?prjId=" + prjId + "\">" + "[" + prjCd +"] " + prjNm + "</a>";
	}
	return "[" + prjCd +"] " + prjNm;
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
			if (!$(event.target).closest(layer).length) {
				$('body').unbind('click.usrLayer');
		        layer.remove();
		        
		    };
		}
	});
		
};

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
				popup[i] = window.open(rootPath + "/community/selectNote.do?readChk=Y&noteId=" + noteIdList[i] + "&recieveMode=Y", "recieveNoteView_" + noteIdList[i], 'top=0px, left=0px, width=500px, height=415px, ,scrollbars=yes');
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

function commonTimer() {
	if (boolDelayCount > 0) {
		boolDelayCount = boolDelayCount - 1;
	} else {
		refreshChkList();
		connectionChk();
	}
	setTimeout("commonTimer()",60000);
}

function delayCommonTimer(count) {
	boolDelayCount = count;
}

function noteTimer() {
	noteChk();
	setTimeout("noteTimer()",60000);
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