function chngDate(date) {
	document.rightCalFrm.date.value = date;
	loadCalendar();
	loadSchedule();
}	

//우측 부분 load script
function loadCalendar() {
	$.post("/common/getCalendar.do?calYear=" + document.rightCalFrm.calYear.value + "&calMonth=" + document.rightCalFrm.calMonth.value + "&date=" + document.rightCalFrm.date.value,
		function(data){
			$('#calBody').html(data);
		}
		);
}
function loadSchedule() {
	$.post("/common/getSchedule.do?date=" + document.rightCalFrm.date.value,
		function(data){
			$('#scheBody').html(data);
		}
		);
}
function chngYear(i) {
	var year = new Number(document.rightCalFrm.calYear.value) + i;
	
	document.rightCalFrm.calYear.value = year;
	loadCalendar();
}
function chngMonth(i) {
	var year = new Number(document.rightCalFrm.calYear.value);
	var month = new Number(document.rightCalFrm.calMonth.value) + i;

	if(month >= 1 && month < 10) {
		month = "0" + month;
	} else if (month > 12){
		year = year + 1;
		month = "01";
	} else if (month < 1){
		year = year - 1;
		month = 12;
	}

	document.rightCalFrm.calYear.value = year;
	document.rightCalFrm.calMonth.value = month;
	loadCalendar();
}

function positionTooltip(obj) {
	var position = $(obj).position();
	var height = $(obj).height();
	var width = $(obj).width();

	var width2 = $('#sdetail_info').width();

	var tPosX = position.left - width2 + 10;
	var tPosY = position.top + height - 10;
	document.getElementById("sdetail_info").style.left = tPosX + "px";
	document.getElementById("sdetail_info").style.top = tPosY + "px";
}
function showTooltip(obj) {
	obj.className="on";
	$('#sdetail_info').show();
	positionTooltip(obj);
	$('#sSj').html($(obj).find('[name$=scheSj]').html());
	if ($(obj).find('[name$=scheTmTyp]').val() == '0') {
		$('#sTm').html("하루종일");
	}
	else {
		$('#sTm').html($(obj).find('[name$=scheTmFrom]').val() + " ~ " + $(obj).find('[name$=scheTmTo]').val());
	}
	$('#sOrg').html($(obj).find('[name$=scheOrgnztNm]').val());
	$('#sNo').html($(obj).find('[name$=userNm]').val());
	$('#sCn').html($(obj).find('[name$=scheCn]').html());
	
	// [20140930, dwkim] 팀일정이 아닐때는, 부서X
	if ($(obj).find('[name$=scheTyp]').val()=='T') {
		$('#hOrg').show();
		$('#sOrg').show();
	} else {
		$('#hOrg').hide();
		$('#sOrg').hide();
	}
	
	obj.lastChild.style.display = "";
}
/*
function showTooltip(obj,scheTmTyp,scheTmFrom,scheTmTo,scheCn,userNm,scheSj) {
	obj.className="on";
	$('#sdetail_info').show();
	positionTooltip(obj);
	$('#sSj').html(scheSj);
	if (scheTmTyp == '0') {
		$('#sTm').html("하루종일");
	}
	else {
		$('#sTm').html(scheTmFrom + " ~ " + scheTmTo);
	}
	$('#sNo').html(userNm);
	$('#sCn').html(scheCn);
	
	obj.lastChild.style.display = "";
}
* */

function hideTooltip(obj) {
	obj.className="";
	$('#sdetail_info').hide();
	obj.lastChild.style.display = "none";
}
function chngSchedule(no) {
	var t1 = document.getElementById("tab_1");
	var s1 = document.getElementById("sche_1");
	var t2 = document.getElementById("tab_2");
	var s2 = document.getElementById("sche_2");

	if (no == 1) {
		t1.className="on";
		t2.className="off";
		s1.style.display = "";
		s2.style.display = "none";
	}
	else if (no == 2) {
		t1.className="off";
		t2.className="on";
		s1.style.display = "none";
		s2.style.display = "";
	}
}

var userArray =null;	

$(document).ready(function() {
	
	//commonTimer();
	
	if($('#rightCalFrm').length>0)
	{
		loadCalendar();
		loadSchedule();
	}

	//datepicker script
	//setting datepicker
	$.datepicker.setDefaults({
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		,dayNamesMin: ['일', '월', '화', '수', '목', '금', '토']
		,showMonthAfterYear:true
		,buttonImageOnly: true
		,buttonText: "달력"
		,buttonImage: "/ui/images/calendar.gif"
		,selectOtherMonths : true
		,showOtherMonths : true
		,showMonthAfterYear : true
		,changeMonth: true
		,changeYear: true
		,dateFormat : 'yymmdd'
		,regional : 'ko'
		,position : 'top'
		,beforeShow: function(input, inst) 
		{ 
					//do nothing	
				} 
			});
	
	//load datepicker
	$('.calGen').live('focus', function () {
		if (!$(this).data("datepicker")) {
			$(this).datepicker();
		}
	});
	
	//load datepicker
	$('.calGenMonth').live('focus', function () {
		if (!$(this).data("datepicker")) {
			$(this).datepicker({ dateFormat: 'yymm' , defaultDate:'yymm',
				beforeShow : function(input, inst) {
					if ((datestr = $(this).val()).length > 0) {
						year = parseYear(datestr);
						month = parseMonth(datestr)-1;
						$(this).datepicker('option', 'defaultDate', new Date(year, month, 1));
						$(this).datepicker('setDate', new Date(year, month, 1));
					}
				}
			});
		}
	});
		
	//$('.calGen').datepicker();
	
	//load userAutoComplete
	
	$.post("/ajax/selectUserListJson.do",function(data)
			{
				userArray = JSON.parse(data);
			});
			
	function split( val ) {
		return val.split( /,\s*/ );
	}
	function extractLast( term ) {
		return split( term ).pop();
	}		

	
	
	
//	if($('.userNameAuto').length){
/*	if($('.userNameAuto').length > 0 || $('.userNamesAuto').length > 0){	
		$.post("/ajax/selectUserListJson.do",function(data)
				{
			userArray = JSON.parse(data);
				});
	}
*/
/*	$('.userNameAuto').live('keyup.autocomplete', function(){
		$(this).autocomplete({
*/
	var userNameAutos = $('.userNameAuto');
	$.each(userNameAutos, function(index, ele){
		$(ele).autocomplete({
			minLength : 1 ,
			source: function( request, response ) {
				// delegate back to autocomplete, but extract the last term
				response( $.ui.autocomplete.filter(
						userArray, extractLast( request.term ) ) );
			},
			focus: function() {
				// prevent value inserted on focus
				return false;
			},
			select: function( event, ui ) {
				this.value =ui.item.userNm + "(" + ui.item.userId + ")";
				return false;
			}
		}).data( "autocomplete" )._renderItem = function( ul, item ) {
			return $( "<li></li>" )
			.data( "item.autocomplete", item )
			.append( '<a><img src="'+imagePath+'/ico/ico_peo.gif">' + item.label + '</a>')
			.appendTo( ul );
		};
	});

	$('.userNameAuto.userValidateCheck').live('blur',function(){
		//auto complete 가 active 일 경우 검사하지 않음.
		if(!$( this ).data("autocomplete").menu.active ){
			var error = checkValidUserMixs($(this).val());
			if(error["errorCode"]==1)
				;
			else if(error["errorCode"]==2)
			{
				alert("입력형식이 잘못되었습니다.");
				$(this).val('');
				$(this).focus();
			}
			else if(error["errorCode"]==3)
			{
				alert("유효하지 않은 사용자입니다.")
				;$(this).val('');
				console.log(error["errorCode"]);
				$(this).focus();
			}
		}
	});
	
	
	$('.userNameAuto.userValidateCheckAuth').live('blur',function(){
		//auto complete 가 active 일 경우 검사하지 않음.
		if(!$( this ).data("autocomplete").menu.active ){
			var error = checkValidUserMixsAuth($(this).val());
			if(error["errorCode"]==1)
				;
			else if(error["errorCode"]==2)
			{
				alert("입력형식이 잘못되었습니다.");
				$(this).val('');
				$(this).focus();
			}
			else if(error["errorCode"]==3)
			{
				alert("유효하지 않은 사용자입니다.")
				;$(this).val('');
				console.log(error["errorCode"]);
				$(this).focus();
			}	    	
			else if(error["errorCode"]==4)
			{
				alert("검색 권한이 없는 사용자 입니다.");
				$(this).val('');
				$(this).focus();
			}
		}
	});
	
	
/*	$('.userNamesAuto').live('keyup.autocomplete', function(){
		$(this).bind( "keydown", function( event ) {
*/
	var userNamesAutos = $('.userNamesAuto');
	$.each(userNamesAutos, function(index, ele){
		$(ele).bind( "keydown", function( event ) {
			if ( event.keyCode === $.ui.keyCode.TAB &&
				$( this ).data( "autocomplete" ).menu.active ) {
						event.preventDefault();
			}
		}).autocomplete({
			minLength : 1 ,
			source:function( request, response ) {
			// delegate back to autocomplete, but extract the last term
			response( $.ui.autocomplete.filter(
				userArray, extractLast( request.term ) ) );
		},
		focus: function() {
			// prevent value inserted on focus
			return false;
		},
		select: function( event, ui ) {
			var terms = split( this.value );
			terms.pop();
			terms.push( ui.item.userNm + "(" + ui.item.userId + ")");
			terms.push( "" );
			this.value = terms.join( "," );
			return false;
		}}).data("autocomplete")._renderItem = function( ul, item ) {
			return $( "<li></li>" )
			.data( "item.autocomplete", item )
			.append( '<a><img src="'+imagePath+'/ico/ico_peo.gif">' + item.label + '</a>')
			.appendTo( ul );
		};
	});
	
	$('.userNamesAuto.userValidateCheck').live('blur',function(){
		//auto complete 가 active 일 경우 검사하지 않음.
		if($( this ).data( "autocomplete" ) == null){
			//IE8 에서 autocomplete 객체를 못찾고 두번째부터 인식하는 버그로 인해 예외처리
			return;
		}
		
		if(!$( this ).data( "autocomplete" ).menu.active ){
			var error = checkValidUserMixs($(this).val());
			if(error["errorCode"]==1)
				;
			else if(error["errorCode"]==2) {
				alert("입력형식이 잘못되었습니다.");
				$(this).val('');
				$(this).focus();
			} else if(error["errorCode"]==3) {
				var bf = $(this).val();
				bfArray = bf.split(",");
				$.each(error["errorInform"],function(key,val){
					bfArray.splice(val,1);
				});
				var af = bfArray.join();
				alert("유효하지 않은 사용자입니다.");
				$(this).val(af);
				console.log(error);
				$(this).focus();
			}
	
		}
	});
	
	$('.userNamesAuto.userValidateCheckAuth').live('blur',function(){
		//auto complete 가 active 일 경우 검사하지 않음.
		if($( this ).data( "autocomplete" ) == null){
			//IE8 에서 autocomplete 객체를 못찾고 두번째부터 인식하는 버그로 인해 예외처리
			return;
		}
		
		if(!$( this ).data( "autocomplete" ).menu.active ){
			var error = checkValidUserMixsAuth($(this).val());
			if(error["errorCode"]==1)
				;
			else if(error["errorCode"]==2) {
				alert("입력형식이 잘못되었습니다.");
				$(this).val('');
				$(this).focus();
			} else if(error["errorCode"]==3) {
				var bf = $(this).val();
				bfArray = bf.split(",");
				$.each(error["errorInform"],function(key,val){
					bfArray.splice(val,1);
				});
				var af = bfArray.join();
				alert("유효하지 않은 사용자입니다.");
				$(this).val(af);
				console.log(error);
				$(this).focus();
			}
			else if(error["errorCode"]==4)
			{
				alert("검색 권한이 없는 사용자 입니다.");
				$(this).val('');
				$(this).focus();
			}
		}
	});

/*	$('.userNameAutoHead').live('keyup.autocomplete', function(){
		$(this).autocomplete({
*/
	var userNameAutoHeads = $('.userNameAutoHead');
	$.each(userNameAutoHeads, function(index, ele){
		$(ele).autocomplete({
			minLength : 1 ,
			source: function( request, response ) {
				// delegate back to autocomplete, but extract the last term
				response( $.ui.autocomplete.filter(
				userArray, extractLast( request.term ) ) );
			},
			focus: function() {
				// prevent value inserted on focus
				return false;
			},
			select: function( event, ui ) {
				this.value =ui.item.userNm;
				return false;
			}
		}).data( "autocomplete" )._renderItem = function( ul, item ) {
			return $( "<li></li>" )
			.data( "item.autocomplete", item )
			.append( '<a><img src="'+imagePath+'/ico/ico_peo.gif">' + item.label + '</a>')
			.appendTo( ul );
		};
	});

});

