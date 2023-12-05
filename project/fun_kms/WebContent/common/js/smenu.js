/*======================================================================
*
*
======================================================================*/

// image rollover 
function dr( obj ) {
    obj.src = obj.src.replace( 'off.gif', 'on.gif' );
}
function outImg( obj ) {
    obj.src = obj.src.replace( 'on.gif', 'off.gif' );
}

// gnb

var sMenuTopMain = "";
var sMenuTopSub = "";

function setMenu(main, sub) {
	sMenuTopMain = main;
	sMenuTopSub = sub;
}

function top2menuView(a) //2
{

	if(this.id){
		eidStr = this.id;
		eidNum=eidStr.substring(eidStr.lastIndexOf("m",eidStr.length)+1,eidStr.length);
		a = parseInt(eidNum);
	}
	top2menuHideAll();
	top1Menu = document.getElementById("top1m"+a);
	top2Menu = document.getElementById("snbmenu_m"+a);
	if(a<10){
		ann=a;
	}else {
		ann=''+a;
	}
	if (a=0) { 
	} else {
		if (top1Menu) {
			top1Menu.getElementsByTagName("img")[0].src="/images/inc/gnb/gnb0" + ann + "on.gif";

			if (top2Menu) { top2Menu.style.display = 'inline'; }
		}
	}
}
function top2menuHide(a) 
{

	if(this.id){
		eidStr = this.id;
		eidNum=eidStr.substring(eidStr.lastIndexOf("m",eidStr.length)+1,eidStr.length);
		a = parseInt(eidNum);
		
	}

	top2menuHideAll();
	top1Menu = document.getElementById("top1m"+a);
	top2Menu = document.getElementById("snbmenu_m"+a);
	top1MenuCurr = document.getElementById("top1m"+sMenuTopMain);
	top2MenuCurr = document.getElementById("snbmenu_m"+sMenuTopMain);
	
	if(a<10){ann=a;} else {ann=''+a;}
	if (top1Menu) {
		
		if (top2Menu) { top2Menu.style.display = 'none'; }
		if (top1MenuCurr) {
			top1MenuCurr.getElementsByTagName("img")[0].src = "/images/inc/gnb/gnb0"+sMenuTopMain+"on.gif";
			top2MenuCurr.style.display = 'none';
		}
	}
}
function top2menuHideAll()
{
	top1menuEl = document.getElementById("gnbmenu").childNodes;
	for (var i=1;i<=top1menuEl.length;i++)
	{
		top1Menu = document.getElementById("top1m"+i);
		top2Menu = document.getElementById("snbmenu_m"+i);
		if(i<10){inn='0'+i;} else {inn=''+i;}
		if (top1Menu) {
			top1Menu.getElementsByTagName("img")[0].src="/images/inc/gnb/gnb" + inn + ".gif";

			if (top2Menu) { top2Menu.style.display = 'none'; }
		}
	}
}
 
function initTopMenu() {
 	top1menuEl = document.getElementById("gnbmenu").childNodes;
	for (var i=1;i<=top1menuEl.length;i++)
	{
		top1Menu = document.getElementById("top1m"+i);
		top2Menu = document.getElementById("snbmenu_m"+i);

		if (top1Menu) {
			top1Menu.onmouseover = top1Menu.onfocus = top2menuView;
			//top1Menu.onmouseout = top2menuHide;
			if (top2Menu) {
				top2Menu.onmouseover = top2Menu.onfocus = top2menuView;
				//alert(top2Menu.outerHTML);
				top2Menu.onmouseout = top2menuHide;
			}
		}
	}
	top2MenuCurrAct = document.getElementById("snbmenu0"+sMenuTopMain+"m"+sMenuTopSub);

	document.getElementById("container").onmouseover = top2menuHide;
	document.body.onkeyup = chkHotKey;

	if (top2MenuCurrAct) {
		top2MenuCurrAct.getElementsByTagName("a")[0].style.color="#3662a3";
		top2MenuCurrAct.getElementsByTagName("a")[0].style.textDecoration="underline";
	}
}


function chkHotKey() {
	if (event.altKey && event.shiftKey) {
		if (event.keyCode == 79) {//o
			location.href = rootPath + "/member/insertOvertimeView.do";
		}
		if (event.keyCode == 68) {//d
			location.href = rootPath + "/cooperation/selectDayReport.do";
		}
		if (event.keyCode == 87) {//w
			location.href = rootPath + "/member/insertAbsenceView.do";
		}
		if (event.keyCode == 66) {//b 
			location.href = rootPath + "/cooperation/selectBusinessContactList.do";
		}
		if (event.keyCode == 77) {//m
			location.href = rootPath + "/community/selectRecieveMailList.do";
		}
		if (event.keyCode == 83) {//s
			location.href = rootPath + "/member/selectMemberMain.do";
		}
		if (event.keyCode == 71) {//g
			location.href = rootPath + "/community/selectUnreadBoardList.do";
		}
		if (event.keyCode == 81) {//q
			location.href = rootPath + "/member/dailyWorkStateStatistic.do";
		}
	}
}