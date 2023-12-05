// Browser ToolBar Hidden
window.addEventListener('load', function() { setTimeout(scrollTo, 0, 0, 1); }, false);

// ui control
$(document).ready(function() {
	if($("#nav").height() > screen.height) {
		var result_navh = ($("#nav").height());
	} else {
		var result_navh = (screen.height);
	}
	$("#showhidden,").toggle(function(){
		$("#header").css('left','0px');
		$("#nav").css('left','0px');
		$("#nav").css('overflow-y','scroll');
		$("#header").css('height',screen.height + 50);
		$("#section").css('margin-left','260px');
		$("#section").css('height', '200px');
		$("#section").css('overflow', 'hidden');
		$("#showhidden").css('left','260px');
		$("#showhidden").css('width',screen.width-260);
		$("#showhidden").css('background','url(../image/gdw.png) repeat-y #1c6ac1');
		$("#showhidden").css('height',result_navh + 50);
		$("#sches").css('left','-3000px');
	}, function() {
		$("#header").css('left','-3000px');
		$("#nav").css('left','-3000px');
		$("#section").css('margin-left','0px');
		$("#section").css('overflow','scroll-y');
		$("#section").css('height','');
		$("#section").css('width','');
		$("#showhidden").css('left','0px');
		$("#showhidden").css('width','45px');
		$("#showhidden").css('background','');
		$("#showhidden").css('height','43px');
	});

	$("#searchbtn").toggle(function(){
		$("#sches").css('left','0px');
		$("#sches").css('height',$("#section").height());
		$("#secbtnA").css('visibility','hidden');
	}, function() {
		$("#sches").css('left','-3000px');	
		$("#secbtnA").css('visibility','visible');
	});
	

	$("#addresseeClick").toggle(function(){
		$("#addressee").css('display','');
	}, function() {
		$("#addressee").css('display','none');
	});

	$("#popbtn").toggle(function(){
		$("#searchpoppp").css('display','');
	}, function() {
		$("#searchpoppp").css('display','none');
	});

	$("#popbtno").toggle(function(){
		$("#searchpoppp").css('display','none');
	}, function() {
		$("#searchpoppp").css('display','none');
	});

	$("#popbtnoo").toggle(function(){
		$("#searchpoppp").css('display','none');
	}, function() {
		$("#searchpoppp").css('display','none');
	});
})


$(document).ready(function () {
init(); 
getEvent(); 
});

function init() {
//첫번째 Tab Title부분을 활성화
$("#tab_one") 
.css("background-color", "white") 
.css("font-weight", "bold")
.css("border-bottom", "none");

//첫번째 Tab이 활성화일 경우 첫번째 Tab Contents 부분을 display:block 
//시키고,
//나머지 부분 Tab Title, Tab Contents부분을 비활성화 시킴
//changeValue(비활성시킬 Tab Title1, 비활성시킬 Tab Title2, 활성화 시킬 
//Tab Contens, 비활성화 시킬 Tab Contents들..)
changeValue("#tab_two", "#tab_three", "#tabcontents_one", 
"#tab_contents_two", "#tab_contents_three");
}

function getEvent() {
//Mouseover Event 적용
$("#tab_one, #tab_two, #tab_three").mouseover(
 function () {
	 //아이디 구분을 위해 Attribute에서
	 //id값을 찾아 저장 
	 var idval = $(this).attr("id");
	 var id = idval.substring(4);

	 $(this) //Mouseover가 적용된 Tab Title 부분 활성화
	 .css("background-color", "white")
	 .css("font-weight", "bold")
	 .css("color", "#000")
	 .css("border-bottom", "none");

	 if (id == "one") {
		 //첫번째 Tab title에 마우스가 올라가, 나머지 두개는 비활성화 및
		 //나머지 두개의 Contents 부분도 display:none 시키고 활성화 된
		 //Tab의 Contents 한 개를 display:block화 시킴
		 // *CSS상 Tab Contents 부분은 display:none이 기본값임
		 changeValue("#tab_two", "#tab_three", "#tabcontents_one", 
		 "#tabcontents_two", "#tabcontents_three");
	  }
	  else if (id == "two") {
		 //상기 동일
		 changeValue("#tab_one", "#tab_three", "#tabcontents_two", 
		 "#tabcontents_one", "#tabcontents_three");
	 }
	 else {
		 //상기 동일
		 changeValue("#tab_one", "#tab_two", "#tabcontents_three", 
		 "#tabcontents_one", "#tabcontents_two");
	 }
 });
}


function changeValue(tabtitle1, tabtitle2, thiscontents, contents1, contents2) {
$(tabtitle1)    //Tab title 비활성화
.css("background-color", "#f6f9fb")
.css("font-weight", "normal")
.css("border-bottom", "1px solid #cdd4dc");

$(tabtitle2)   //Tab title 비활성화
.css("background-color", "#f6f9fb")
.css("font-weight", "normal")
.css("border-bottom", "1px solid #cdd4dc");

$(thiscontents) //Mouseover된 Tab의 Contents 부분 활성화
.css("display", "block");

$(contents1)    //나머지 비활성화
.css("display", "none");
$(contents2)
.css("display", "none");
}


//* 달력
