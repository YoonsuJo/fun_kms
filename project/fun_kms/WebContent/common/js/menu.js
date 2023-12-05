/*======================================================================
*�ۼ��� : 2011-05-04
*��  �� : �޴���ũ��Ʈ
======================================================================*/

// image rollover 
function dr( obj ) {
    obj.src = obj.src.replace( 'off.gif', 'on.gif' );
}
function outImg( obj ) {
    obj.src = obj.src.replace( 'on.gif', 'off.gif' );
}

// gnb

function top2menuView(a) //2���޴�����
{

	if(this.id){
		eidStr = this.id;
		eidNum=eidStr.substring(eidStr.lastIndexOf("m",eidStr.length)+1,eidStr.length);
		a = parseInt(eidNum);
	}
	top2menuHideAll();
	top1Menu = document.getElementById("top1m"+a);
	top2Menu = document.getElementById("snbmenu_m"+a);
	if(a<10){ann=a;} else {ann=''+a;}
	if (a=0) { //������2���޴�Ȱ��ȭ����
	} else {
		if (top1Menu) {
			top1Menu.getElementsByTagName("img")[0].src="images/inc/gnb/gnb0" + ann + "on.gif";

			if (top2Menu) { top2Menu.style.display = 'inline'; }
		}
	}
}
function top2menuHide(a) //2���޴����߱�
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
		
		//top1Menu.getElementsByTagName("img")[0].src="images/inc/gnb/gnb0" + ann + ".gif";

		if (top2Menu) { top2Menu.style.display = 'inline'; }
		if (top1MenuCurr) {
			top1MenuCurr.getElementsByTagName("img")[0].src = "images/inc/gnb/gnb"+sMenuTopMain+"on.gif";

			}
		//if (top2MenuCurr) { top2MenuCurr.style.display = 'inline'; }
	}
}
function top2menuHideAll() //2���޴���ΰ��߱�
{
	top1menuEl = document.getElementById("gnbmenu").childNodes;
	for (i=1;i<=top1menuEl.length;i++)
	{
		top1Menu = document.getElementById("top1m"+i);
		top2Menu = document.getElementById("snbmenu_m"+i);
		if(i<10){inn='0'+i;} else {inn=''+i;}
		if (top1Menu) {
			top1Menu.getElementsByTagName("img")[0].src="images/inc/gnb/gnb" + inn + ".gif";

			if (top2Menu) { top2Menu.style.display = 'none'; }
		}
	}
}
 
function initTopMenu() {
 	top1menuEl = document.getElementById("gnbmenu").childNodes;

 	
	for (var i=0;i<=top1menuEl.length;i++)
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
 	
	if (top2MenuCurrAct) { top2MenuCurrAct.getElementsByTagName("a")[0].style.color="#fff"; }
	if (top2MenuCurrAct) { top2MenuCurrAct.getElementsByTagName("a")[0].style.fontWeight="bold"; }
}




