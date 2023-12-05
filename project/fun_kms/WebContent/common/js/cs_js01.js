var DEBUG = {
	mode:false, textareaObj: null
	,idx: 1
	,setTextArea: function(obj){
		this.testareaObj = $E(obj);
	}
	,alert: function(msg){
		if(!this.mode) return;
		if(msg instanceof Error) msg = msg.description;
		
		var text = '[Develop Debug Mode '+ (this.idx++) +']\n'+msg;

		if(this.testareaObj) this.testareaObj.value += '\n' + text;
		else alert(text);
	}
}

try{
	document.execCommand("BackgroundImageCache",false,true);
}catch(e){}

var Class = {
	create: function(){
		return function(){ 
			this.init.apply(this, arguments);
		}
	}
}

var $break = '$ERROR_LOOP_BREAK';
var $continue = '$ERROR_LOOP_CONTINUE';

function $E(){
	var elements;
	for(var i=0, cnt=arguments.length; i<cnt; i++) {
		var el = arguments[i];
		if(typeof el != 'object') el = document.getElementById(String(el));
		if(arguments.length == 1) return el;
		if(!elements) elements = [];
		elements.push(el);
	}
	return elements;
}
function $N(nameObj){
	if(!nameObj) return null;
	if(El.isObject(nameObj)) nameObj = nameObj.name||'';
	return document.getElementsByName(nameObj);
}
function $TAG(tagnameObj, pobj){
	pobj = $E(pobj);
	if(!pobj) pobj = document;
	if(!tagnameObj) return null;
	if(El.isObject(tagnameObj)) tagnameObj = tagnameObj.nodeName||'';
	return pobj.getElementsByTagName(tagnameObj);
}

var Browser = {
	getAppName: function(){
		//navigator.appVersion
		return navigator.appName;
	},
	check: function(chk){
		return ( this.getAppName().indexOf(chk)!=-1 );
	},
	isIE: function(){
		return this.check('Microsoft Internet Explorer');
	},
	isNS: function(){
		return this.check('Netscape');
	},
	isOpera: function(){
		return this.check('Opera');
	}
}

var Cookie = {
	set: function(valueObj, expires, domain, path){
		var date = new Date();
		date.setDate( date.getDate() + expires );
		for(var key in valueObj){
			var t = [];
			t.push( key + '=' + escape(valueObj[key]) + '; expires='+date.toGMTString() + ';' );
			if(domain) t.push( 'domain='+domain+';' );
			if(path) t.push( 'path='+path+';' );
			document.cookie = t.join('');
		}
	}
	,get: function(key){
		var cookies = document.cookie.split(';');
		for(var i=0, cnt=cookies.length; i<cnt; ++i){
			var t = cookies[i].split('=');
			if(t[0] != key) continue;
			return unescape(t[1]);
		}
	}
}

function getEvent(){
	if(Browser.isIE()) return event;
	else if(Browser.isNS()) return Event;
	else null;
}
//try{ var Event = getEvent(); }catch(e){alert(e);}
//try{ var event = getEvent(); }catch(e){}

var DocumentUtil = {
	loadList: [], intervalObj: null
	,onload: function(func){
		if(typeof(func)!='function') return;
		this.loadList.push(func);
	
		if(this.intervalObj==null){
			this.intervalObj = window.setInterval('DocumentUtil.onloadAction()', 1);
		}
	}
	,onloadAction: function(){
		if(document.body==null) return;

		for(var i=0; i<this.loadList.length; ++i){
			this.loadList[i]();
		}

		window.clearInterval(this.intervalObj);
	}
}

var ObjectUtil = {
	append: function(obj, aObj){
		if(!aObj) return obj;
		for(var key in aObj) obj[key] = aObj[key];
		return obj;
	},
	getKeys: function(obj){
		obj = $E(obj);
		var list = [];
		for(var key in obj) list.push(key);
		return list;
	},
	getSize: function(obj){
		return this.getKeys(obj).length;
	},
	getProperties: function(obj){
		obj = $E(obj);
		var list = [];
		for(var key in obj) list.push(key + ' : ' + obj[key]);
		return list;
	},
	getPropertiesStr: function(obj, sep){
		return this.getProperties(obj).join(sep||'\n');
	},
	objToArray: function(obj, asc){
		if(asc==null || (asc!=true && asc!=false)) asc = true;
		var keys = [];
		for(var key in obj) keys.push(key);
		keys = keys.sort();
		if(asc == false) keys.reverse();

		var list = [];
		for(var i=0, cnt=keys.length; i<cnt; i++){
			list.push({
				key: keys[i]
				,value: obj[keys[i]]
			});
		}
		return list;
	},
	sort: function(obj, asc){
		var list = this.objToArray(obj, asc);
		var obj = {};
		for(var i=0, cnt=list.length; i<cnt; i++){
			var temp = list[i];
			obj[temp.key] = temp.value;
		}
		return obj;
	},
	bindObj: function(obj, exKeys){
		var exObj = {}
		if(exKeys){
			exKeys = exKeys.trim().split(',');
			for(var i=0, cnt=exKeys.length; i<cnt; i++){
				var temp;
				try{
					temp = exKeys[i].split(':');
				}catch(e){ temp[0]=exKeys[i]; temp[1]=' '; }
				exObj[temp[0]] = temp[1];
			}
		}
		var keys = this.getKeys(obj);
		for(var i=0, cnt=keys.length; i<cnt; i++){
			var k = v = keys[i];
			if(exObj[k] != null) v = exObj[k];
			Field.setValue(v, obj[k]);
		}
	}
}

Array.prototype.forEach = function(func){
	for(var i=0, cnt=this.length; i<cnt; i++){
		try{
			var rt = func(i, this[i]);
			if(rt != null) return rt;
		}catch(e){
			if(e==$break) break;
			else if(e==$continue) continue;
			else throw e;
		}
	}
}
Array.prototype.inArray = function(arg){
	for(var key in this) if(this[key] == arg) return true;
	return false;
}

//해당 스트링의 rep0이 들어간 부분을 모두 rep1로 변환.
String.prototype.replaceAll = function(rep0, rep1){
	var str = this;
	var str2;
	var arry = new Array();
	var idx = 0;
	while(str.indexOf(rep0) != -1) {
		idx = str.indexOf(rep0) + rep0.length;
		str2 = str.substring(0, idx);
		arry.push( str2.replace(rep0, rep1) );
		// str = str.replace(str2, "");
		str = str.substring(idx);
	}
	arry.push( str );

	return arry.join("");
}


//해당 스트링의 공백을 모두 제거. 첫번째 인자의 replace 문제로 임시수정. 양이 큰 문장의 경우 성능상 문제발생. 보안 요.
String.prototype.trimAll = function(){
	var str = this;
	if(!str) return '';
	var test = [' ', '　', '\t', '\r\n', '\r', '\n'];
	for(var i=0; i<test.length; i++){
		var t = test[i];
		while(str.indexOf(t)!=-1){
			var idx = str.indexOf(t);
			str = str.substring(0, idx) + str.substring(idx + t.length);
		}
	}
	return str;
}

//해당 스트링의 좌우 공백을 모두 제거.
String.prototype.trim = function(){
	if(!this) return '';
	// return this.replace(/(\s+$)/g,'');
	// return this.replace(/^\s*/g,'');
	return this.replace(/(^\s*)|(\s*$)/gi,'');
}

//해당 스트링의 문자열 왼쪽(처음)의 공백을 모두 제거.
String.prototype.lTrim = function(){
	var str =  this.replace(/^\s*/, '');
	// var str = this;
	if(!str) return '';
	var test = [' ', '　', '\t', '\r\n', '\r', '\n'];
	for(var i=0, cnt=test.length; i<cnt; i++){
		var t = test[i];
		while(str.substring(0,1) == t){ str = str.substring(1); }
	}
	return str;
}

//해당 스트링의 문자열 끝의 공백을 모두 제거.
String.prototype.rTrim = function(){
	var str = this.replace(/\s*$/, '');
	if(!str) return '';
	var test = [' ', '　', '\t', '\r\n', '\r', '\n'];
	for(var i=0, cnt=test.length; i<cnt; i++){
		var t = test[i];
		while(str.substring(str.length-1) == t){ str = str.substring(0, str.length-1); }
	}
	return str;
}

/* 
글자를 앞에서부터 원하는 바이트만큼 잘라 리턴.
한글의 경우 2바이트로 계산, 글자 중간에서 잘리지 않는다.
*/
String.prototype.cut = function(len){
	var str = this;
	var l = 0;
	for (var i=0, cnt=str.length; i<cnt; i++) {
		l += (str.charCodeAt(i) > 128) ? 2 : 1;
		if (l > len) {
			return str.substring(0,i);
		}
	}

	return str;
}

//해당스트링의 바이트단위 길이를 리턴.
String.prototype.bytes = function(){
	var str = this;
	var l = 0;
	for (var i=0, cnt=str.length; i<cnt; i++) l += (str.charCodeAt(i) > 128) ? 2 : 1;
	return l;
}

//해당 스트링의 f가 속해있는 갯수를 리턴.
String.prototype.findCnt = function(f){
	var str = this;
	var cnt=0;
	while(str.indexOf(f)!=-1){
		cnt++;
		str = str.replace(f,"");
	}
	return cnt;
}

//chk_str로 시작되는 문자열인지 여부
String.prototype.startWith = function(chk_str){
	var str = this;
	if(!str || str.trim().length==0) return false;
	return (str.indexOf(chk_str)==0);
}

//해당 스트링과 비교 문자열의 대소문자를 무시하고 비교.
String.prototype.equals = function(str){
	try{
		return ( this.toLowerCase() == str.toLowerCase() );
	}catch(e){ return false; }
}

//해당 스트링에 인자값이 포함되어 있는지 여부
String.prototype.comparewith = function(str){
	return (this.indexOf(str) > -1);
}
//해당 스트링에 인자값이 포함되어 있는지 여부
String.prototype.compareWith = function(str){
	return (this.indexOf(str) > -1);
}

//해당 스트링의 길이가 len보다 작으면 temp로 좌측을 채워서 리턴.
String.prototype.lpad = function(len, temp){
	var str = this;
	temp = String(temp);
	while(str.length < len) str = temp + str;
	return str;
}
//해당 스트링의 길이가 len보다 작으면 temp로 우측을 채워서 리턴.
String.prototype.rpad = function(len, temp){
	var str = this;
	temp = String(temp);
	while(str.length < len) str += temp;
	return str;
}
//해당 스트링의 byte가 len보다 작으면 temp로 좌측을 채워서 리턴.
String.prototype.lpadByte = function(len, temp){
	var str = this;
	temp = String(temp);
	while(str.bytes() < len) str = temp + str;
	return str.cut(len);
}
//해당 스트링의 byte가 len보다 작으면 temp로 좌측을 채워서 리턴.
String.prototype.rpadByte = function(len, temp){
	var str = this;
	temp = String(temp);
	while(str.bytes() < len) str += temp;
	return str.cut(len);
}

//스트링의 공백을 제외한 길이가 0인지 여부.
String.prototype.isNull = function(){
	return (this.trim().length < 1);
}

//스트링이 args에 포함되어있는지 여부.
String.prototype.inList = function(args){
	if(args==null) return false;
	if(!El.isArray(args)){
		args = String(args).split(',');
	}
	for(var i=0, cnt=args.length; i<cnt; i++){
		if(this == args[i]) return true;
	}
	return false;
}

var Link = {
	//over : function(obj, color, bg, styleStr){
	over : function(obj, styleStr){
		var obj = $E(obj);
		obj.cssText = obj.style.cssText;
		/*
		 * if(color) obj.style.color = color; if(bg) obj.style.backgroundColor =
		 * bg; if(!styleStr) obj.style.cursor = 'pointer';
		 */
		Style.append(obj, styleStr);
		obj.onmouseout = function(){
			try{
				this.style.cssText = this.cssText;
			}catch(e){}
		};
	}
	,btnOver: function(obj, str, rep){
		obj = $E(obj);
		if(!obj) obj = event.srcElement;
		if(obj.nodeName.equals('IMG')){
			obj.style.cursor = 'pointer';
			if(!str) str = '_off.';
			if(!rep) rep = '_on.';
			obj.src = obj.src.replace(str, rep);

			obj.onmouseout = function(){
				Link.btnOver(obj, rep, str);
			}
		}
	}
	,btnDim: function(obj, b, styleStr){
		if(El.isArray(obj)){
			obj.forEach(function(idx, value){ Link.btnDim(value.trim()) });
			return;
		}else if(El.isString(obj)){
			obj = obj.split(',');
			if(obj.length > 1){
				Link.btnDim(el);
				return;
			}
			obj = obj[0];
		}else obj = $E(obj);

		obj = $E(obj);
		if(b==null) b = true;
		// if(!styleStr) styleStr = "";
		if(obj.nodeName.equals('IMG')){
			if(b){
				El.disabled(obj);
				obj.src = obj.src.replace('_on.', '_dim.').replace('_off.', '_dim.');
			}else{
				El.enabled(obj);
				obj.src = obj.src.replace('_dim.', '_off.');
			}
			//El[(b?'disabled':'enabled')](obj);
		}
	}
	,dbtLinkMenuOn: function(obj, str, rep){
		if(!obj) obj = event.srcElement;
		if(obj.disabled) return false;
		obj.cssText = obj.style.cssText;
		// obj.style.cssText = 'background:url(img/btn/btn_bg.gif) no-repeat 0px
		// -20px; cursor:pointer;';
		obj.style.backgroundRepeat = 'no-repeat';
		obj.style.backgroundPosition = '0px -20px';
		obj.style.cursor = 'pointer';
		obj.onmouseout = function(){ Link.dbtLmOff(obj); }
	}
	,dbtLmOff: function(obj, str, rep){
		if(!obj) obj = event.srcElement;
		obj.style.cssText = obj.cssText;
	}
}

// AJAX 관련 S --------------------------------------------------------------------------------
// Request
var Request = {
	req : null, limit : 10, activeReq: {},
	create : function(url, duplicate){
		if(!duplicate){
			var chk_req = this.activeReq[url];
			if(chk_req && chk_req.readyState!=4){
				window.status = '선택하신 기능이 이미 수행중입니다.';
				return null;
			}
		}

		var req = this.req;
		if(!req) req = [];
		else{
			for(var i=0; i<req.length; i++){
				var r = req[i];
				if(r && r.readyState==4){
					this.activeReq[url] = r;
					return r;
				}
			}
		}

		if(req.length >= this.limit){
			alert('작업의 한계를 초과했습니다.');
			return false;
		}

		var req_temp;
		if(window.XMLHttpRequest) req_temp = new XMLHttpRequest();
		else if(window.ActiveXObject){
			try{
				req_temp = new ActiveXObject("Microsoft.XMLHTTP");
			}catch(e){
				req_temp = new ActiveXObject("Msxml2.XMLHTTP");
			}
		}
		if(!req_temp){
			alert('Request 객체 생성에 실패하였습니다.');
			return false;
		}

		req.push( req_temp );
		this.req = req;

		this.activeReq[url] = req_temp;
		return req_temp;
	},
	close : function(url){
		this.activeReq[url] = null;
		var req = this.req;
		if(!req || req.length==0) return false;
		for(var i=0; i<req.length; i++){
			if(i>0 && req[i].readyState==4) req.splice(i, 1);
		}
	}
}

var yAjax = Class.create(); 
yAjax.prototype = {
	init : function(url, method, send, encodeURI){
		this.loadingObj = { sort:'Div', targetObj:null, barrierMode:false, imgName:'kit' }

		if(El.isObject(url)){
			ObjectUtil.append(this, url);
			if(this.url.trim().length < 1){
				alert('요청한 URL이 올바르지 않습니다.');
				return false;
			}
			this.action();
		}else if(El.isString(url)){
			if(url.trim().length < 1){
				alert('요청한 URL이 올바르지 않습니다.');
				return false;
			}
			this.url = url;
			if(method) this.method = method;
			if(send) this.send = send;
			if(encodeURI != null)  this.encodeURI = encodeURI;
		}
	},
	req : null,
	duplicate: false,
	method : 'GET',
	url : null,
	sync : true,
	statechange : function(){},
	target : null,
	inner : 'HTML',
	scriptAct: false,
	header : 'application/x-www-form-urlencoded;',
	charset : 'utf-8',
	send : null,
	resText : '',
	resXML : null,
	resXmlObject: null,
	encodeURI: true,
	getResXmlObject: function(){
		if(this.resXmlObject == null) this.resXmlObject = new XmlObject(this.resXML);
		return this.resXmlObject;
	},
	action : function(target, inner){
		var obj = this;
		var req = this.req = Request.create(this.url, this.duplicate);
		if(!req) return false;

		var statechange = this.statechange;
		var scriptAct = this.scriptAct;
		if(target) target = $E(target);
		if(inner && inner.toLowerCase()=='text') inner = 'Text';
		else inner = this.inner;

		this.startAct();
		var url = this.url;
		if(this.method=='GET'){
			if(url.indexOf('?')<0) url += '?';
			if(url.indexOf('?&')>-1) url = url.replace('?&', '?');
			url += '&dm='+(new Date()).getTime();
		}
		//if(url.indexOf('?')==0) url += '?' + (this.method=='GET' ? '&dm='+(new Date()) : '');
		req.open(this.method, url, this.sync);
		req.onreadystatechange = function(){
			try{
				if(req.readyState != 4) return false;
				if(req.status != 200){
					//alert('Error : ' + req.status);
					obj.errorAct();
					return false;
				}
				obj.resText = req.responseText;
				obj.resXML = req.responseXML;

				if(target) eval('target.inner' + inner + ' = req.responseText');

				// Script 생성 여부, ※ src로 선언된 script 의 경우 Ajax 수행 후
				// setTimeout(function()) 으로 수행.
				if( scriptAct ) ReqInnerScript(req.responseText);
				obj.endAct();
			}catch(e){ obj.errorAct(e); }
			try{
				//statechange();
				statechange.apply(obj);
			}catch(e){
				//alert(e.description);
				throw e;
			}
		}
		try{
			req.setRequestHeader('Content-Type', this.header + 'charset=' + this.charset);
			var send = this.send;
			if(send && this.method.toLowerCase()=='post' && this.charset.toLowerCase()=='utf-8'){
				if(this.encodeURI && El.isString(send)){
					send = send.split('&');
					var str = [];
					for(var i=0, cnt=send.length; i<cnt; i++){
						var temp = send[i].split('=');
						try{
							str.push(temp.splice(0, 1) + '=' + encodeURIComponent(temp.join('')));
						}catch(e){str.push(temp.join('='));}
					}
					send = str.join('&');
				}else if(El.isObject(send)){
					var str = [];
					for(var key in send){
						var v = send[key];
						if(!v) continue;
						if(this.encodeURI) v = encodeURIComponent(v);
						str.push(key + '=' + v);
					}
					send = str.join('&');
				}
			}
			req.send(send);
		}catch(e){ this.errorAct(e);throw e; }
	},
	loadingOff: true,
	loading: null,
	loadingObj: {},
	loadingAct: function(sort, targetObj, barrierMode, imgName){
		if(!sort || sort==0) sort = 'Div';
		else if(sort==1) sort = '';

		this.loadingObj.sort = sort;
		this.loadingObj.targetObj = targetObj;
		this.loadingObj.barrierMode = barrierMode;
		this.loadingObj.imgName = imgName;

		var loading = this.loading;
		// if(!loading) this.loading = new parent.LoadingObj();
		if(!loading) this.loading = new LoadingObj();
	},
	startAct: function(){
		if(this.loadingOff != true){
			var lObj = this.loadingObj;
			if(!this.loading) this.loading = new LoadingObj();
			if(!this.loading) this.loading = new parent.LoadingObj();
	
			if(this.loading && (lObj.targetObj==null || lObj.targetObj=='' || lObj.targetObj!=false)){
				try{
					this.loading['on'+lObj.sort](lObj.targetObj, lObj.barrierMode, lObj.imgName);
				}catch(e){ alert('yAjax startAct Error : ' + e.description); }
			}
		}
		window.status = 'Loading...';
	},
	endAct: function(){
		if(this.loadingOff != true) this.loading.off();
		window.status = 'Complete...';
		Request.close(this.url);
	},
	errorAct: function(e){
		if(this.loadingOff != true) this.loading.off();
		// var err = 'yAjax 작업 도중 오류가 발생하였습니다.\n\n' + ((e)?e.description:'');
		// window.status = err;
		// alert(err);
		Request.close(this.url);
		// throw e;
	}
}

// 문자열 중 Script 문을 찾아 생성
function ReqInnerScript(str){
	var ts = str.split('\n<script');
	// try{
	var slist = document.getElementsByTagName("script");
	t:for(var i=1; i<ts.length; i++){
		var tsS = ts[i];
		var ts_st = tsS.substring(0, tsS.indexOf('>')+1);
		var ts_ed = tsS.indexOf('<\/script>', ts_st.length);
		if(ts_ed==-1) break;
		var cont = tsS.substring(ts_st.length, ts_ed);

		var script = document.createElement('script');
		var srcIndex = ts_st.indexOf('src='); 
		if(srcIndex!=-1){
			var src = ts_st.substring(srcIndex+4);
			src = src.replaceAll("'", "");
			src = src.replaceAll("\"", "");
			src = src.replaceAll(">", "");
			var nn = src.indexOf(" ");
			if(nn >= 0) src = src.substring(0, nn);

			for(var k=0; k<slist.length; ++k){
				try{
					if(slist[k].src.indexOf(src) >= 0){
						continue t;
					}
				}catch(e){ continue; }
			}
			//alert(ts_st.substring(srcIndex+4) + "\n\n" +nn+ "\n\n" + src);
			script.setAttribute('src', src);
		}
		if(cont) script.text = cont;
		document.body.appendChild(script);
	}
	//}catch(e){alert(e.description);}
	return true;
}

// encodeURIComponent
function encURI(str){
	return encodeURIComponent(str);
}

// AJAX 관련 E --------------------------------------------------------------------------------

// Move El Basic S
// ----------------------------------------------------------------------------
var MoveElBasic = {
	me : null, meCopy : null, ex : 0, ey : 0,
	move : false, move_act : false, moveMode : 0,
	reFunc : null,
	setEl : function(obj, moveMode, execute){
		if(!execute && ((event.button!=0 && event.button!=1) || this.move)) return false;
		if(!moveMode || (moveMode != 0 && moveMode != 1)) moveMode = 0;
		this.moveMode = moveMode;

		this.reFunc = EventHandler.copy(document);
		document.onmousemove = function(){MoveElBasic.moving();};
		document.onmouseup = function(){MoveElBasic.stopMoving();};
		document.ondragstart = function(){return false;};
		document.onselectstart = function(){return false;};

		var me = obj = ($E(obj) || event.srcElement), mc;
		var os, ex, ey;
		var os = El.rect(obj);
		if(moveMode==1) mc = this.clone(obj, os);
		var ex = event.clientX - os.left;
		var ey = event.clientY - os.top;

		this.me = me;
		this.meCopy = mc;
		
		this.move = true;
		this.ex = ex;
		this.ey = ey;
	},
	clone : function(obj, os){
 		var cobj = obj.cloneNode(true); 
		cobj.id = '@copy_' + obj.id;
		cobj.style.left = os.left + document.body.scrollLeft;;
		cobj.style.top = os.top + document.body.scrollTop;
		cobj.style.position = 'absolute';
		cobj.style.filter = 'alpha(opacity=50)';
		cobj.style.opacity = '.5';
		cobj.onclick = this.stopMoving;
		cobj.onmousedown = null;

		document.body.appendChild(cobj);
		return cobj;
	},
	moving : function(){
		if(!this.move) return false;
		this.move_act = true;
		var mc = this.moveMode==0 ? this.me : this.meCopy;
		this.meCopy = mc;
		var x = event.clientX, y = event.clientY;
		var ex = this.ex - document.body.scrollLeft, ey = this.ey - document.body.scrollTop;
		if(mc.length){
			for(var i=0; i<mc.length; i++){
				var mm = mc[i];
				mm.style.left = x - ex[i];
				mm.style.top = y - ey[i];
			}
		}else{
			mc.style.left = x - ex;
			mc.style.top = y - ey;
		}
	},
	stopMoving : function(){
		if(!this.move) return false;
		EventHandler.restore(document, this.reFunc);

		var me = this.me;
		var mc = this.meCopy;
		if(me && mc){
			if(me.length){
				for(var i=0; i<me.length; i++){
					var m1 = me[i];
					var m2 = mc[i];
					m1.style.left = m2.style.left;
					m1.style.top = m2.style.top;
					El.remove(m2);
				}
			}else{
				if(me!=mc){
					me.style.left = mc.style.left;
					me.style.top = mc.style.top;
					El.remove(mc);
				}
			}
		}
		this.meCopy = null;
		this.move = this.move_act = false;
	}
}
// Move El Basic E ----------------------------------------------------------------------------
// Move El S
// ----------------------------------------------------------------------------------
var MoveEl = {
	obj: null, me : null, meCopy : null, ex : 0, ey : 0,
	move : false, move_act : false,
	reFunc : null, selectMode : false,
	setEl : function(obj, resetScanRull){
	 	if((event.button!=0 && event.button!=1) || this.move) return false;

		document.onmousemove = function(){MoveEl.moving();};
		document.onmouseup = function(){MoveEl.stopMoving();};
		this.reFunc = [document.ondragstart, document.onselectstart];
		document.ondragstart = function(){return false;};
		document.onselectstart = function(){return false;};

		var selectMode = this.selectMode = DrawRange.selectMode;
		var selectObjs = DrawRange.selectObjs;

		var me = this.obj = $E(obj), mc;
		var os, ex, ey;
		if(selectMode && selectObjs && selectObjs.length>0){
			me = selectObjs;
			mc = new Array();
			os = new Array();
			ex = new Array();
			ey = new Array(); 
			for(var i=0; i<me.length; i++){
				var sobj = me[i];
				var oo = El.rect(sobj);

				os.push(oo);
				mc.push( this.clone(sobj, oo) );
				ex.push(event.clientX - oo.left - document.body.scrollLeft);
				ey.push(event.clientY - oo.top - document.body.scrollTop);
			}
		}else{
			os = El.rect(obj);
	 		mc = this.clone(obj, os);
	 		ex = event.clientX - os.left - document.body.scrollLeft;
	 		ey = event.clientY - os.top - document.body.scrollTop;
		}
		this.me = me;
		this.meCopy = mc;
		this.move = true;
		this.ex = ex;
		this.ey = ey;

		if(resetScanRull==null) resetScanRull = true;
		Locate.scan(resetScanRull);
	},
	clone : function(obj, os){
 		var cobj = obj.cloneNode(true); 
		cobj.id = '@copy_' + (obj.id || obj.uniqueID);
		cobj.style.left = os.left + document.body.scrollLeft;
		cobj.style.top = os.top + document.body.scrollTop;
		cobj.style.position = 'absolute';
		cobj.style.filter = 'alpha(opacity=50)';
		cobj.style.opacity = '.5';
		cobj.style.cursor = 'default';
		cobj.onclick = function(){ this.stopMoving() };
		cobj.onmousedown = null;

		document.body.appendChild(cobj);
		return cobj;
	},
	moving : function(){
		if(!this.move) return false;
		this.move_act = true;
		var mc = this.meCopy;
		var x = event.clientX, y = event.clientY;
		var ex = this.ex, ey = this.ey;
		try{
			if(mc.length){
				for(var i=0; i<mc.length; i++){
					var mm = mc[i];
					mm.style.left = x - ex[i];
					mm.style.top = y - ey[i];
				}
			}else{
				mc.style.left = x - ex;
				mc.style.top = y - ey;
			}
	
			Locate.detect();
		}catch(e){
			this.stopMoving();
		}
	},
	stopMoving : function(){
		if(!this.move) return false;
		document.ondragstart = this.reFunc[0];
		document.onselectstart = this.reFunc[1];

		if(this.selectMode && !this.move_act){
			// 점검요.
			DrawRange.resetSelectMode();
			DrawRange.select(this.obj);
			this.selectMode = false;
		}

		var me = this.me;
		var mc = this.meCopy;
		if(me && mc){
			if(me.length){
				for(var i=0; i<me.length; i++){
					var m1 = me[i];
					var m2 = mc[i];
					m1.style.left = m2.style.left;
					m1.style.top = m2.style.top;
					El.remove(m2);
				}
			}else{
				me.style.left = mc.style.left;
				me.style.top = mc.style.top;
				El.remove(mc);
			}
		}
		this.meCopy = null;
		this.move = this.move_act = false;

		Locate.end( me );
	}
}
// Move El E ----------------------------------------------------------------------------------

// Move Element V2 S
// --------------------------------------------------------------------------
var MoveElement = {
	init: true, moveList: []
	,addMove: function(obj, force){
		obj = $E(obj);
		if(!obj) return;

		var idx = -1;
		this.moveList.forEach(function(r, v){
			if(obj==v) idx = r;
		});
		if(idx == -1) this.moveList.push( obj );
		else if(!force){
			this.moveList.splice(idx, 1);
		}
		window.status = this.moveList.length;
	}
	,setMove: function(obj){
		//this.init = false;

		if(event.button!=1){
			return;
		}

		obj = $E(obj);
		if(!obj) return;

		if(event.shiftKey){
			this.addMove(obj);
			return;
		}

		if( this.moveList.length > 0 ){
			this.addMove(obj, true);
			this.moveList.forEach(function(r, v){
				MoveElement.setMoveDefault(v, v);
			});
		}else{
			this.setMoveDefault(obj, obj);
		}
	}
	,setMoveShadow: function(obj){
		//this.init = false;

		obj = $E(obj);
		if(!obj) return;

		var rt = El.rect(obj);
		var dv = document.createElement('div');
		dv.style.cssText = "position:absolute;filter:alpha(opacity=50);opacity:.5;background:#C9D9EE;border:1 solid #3C76C2;";
		dv.style.width = rt.width;
		dv.style.height = rt.height;
		dv.style.left = rt.left + document.body.scrollLeft;
		dv.style.top = rt.top + document.body.scrollTop;
		document.body.appendChild(dv);

		this.setMoveDefault(obj, dv);
	}
	,setMoveDefault: function(oriObj, obj){
		var ev = window.event;

		obj.oriObj = oriObj;
		var rt = El.rect(obj);
		obj.moveOptions = {
			init: true
			,oriMode: (oriObj==obj)
			,moving: true
			,cssText: obj.style.cssText
			,ex: ev.clientX - rt.left
			,ey: ev.clientY - rt.top
			,onmousemove: function(){
				MoveElement.moving.apply(obj);
			}
			,onmouseup: function(){
				MoveElement.stopMoving.apply(obj);
			}
			,ondragstart: function(){ return false; }
			,onselectstart: function(){ return false; }
		}

		EventHandler.add(document.body, "onmousemove", obj.moveOptions.onmousemove);
		EventHandler.add(document.body, "onmouseup", obj.moveOptions.onmouseup);
		EventHandler.add(document.body, "ondragstart", obj.moveOptions.ondragstart);
		EventHandler.add(document.body, "onselectstart", obj.moveOptions.onselectstart);
	}
	,fillCopyElement: function(obj){
		if(obj.style.position=="absolute") return;

		var rt = El.rect(obj);
		var co = obj.cloneNode(false);
		for(var kk in co){
			try{
				co[kk] = "";
			}catch(e){}
		}

		co.innerHTML = "";
		co.style.cssText = "";
		co.style.width = rt.width;
		co.style.height = rt.height;

		obj.parentNode.insertBefore(co, (obj.nextSibling?obj.nextSibling:null));
	}
	,moving: function(){
		var obj = this;
		var mo = obj.moveOptions;
		if(!mo.moving) return;

		if(mo.init==true && mo.oriMode==true){
			mo.init = false;
			MoveElement.fillCopyElement(obj);
		}

		var ev = window.event;
		var x = ev.clientX, y = ev.clientY;
		var ex = mo.ex - document.body.scrollLeft, ey = mo.ey - document.body.scrollTop;

		obj.style.position = "absolute";
		obj.style.left = x - ex;
		obj.style.top = y - ey;
	}
	,stopMoving: function(){
		var obj = this;
		var mo = obj.moveOptions;
		mo.moving = false;

		EventHandler.remove(document.body, "onmousemove", mo.onmousemove);
		EventHandler.remove(document.body, "onmouseup", mo.onmouseup);
		EventHandler.remove(document.body, "ondragstart", obj.moveOptions.ondragstart);
		EventHandler.remove(document.body, "onselectstart", obj.moveOptions.onselectstart);

		if(obj != obj.oriObj){
			MoveElement.fillCopyElement(obj.oriObj);
			obj.oriObj.style.position = "absolute";
			obj.oriObj.style.left = obj.style.left;
			obj.oriObj.style.top = obj.style.top;
			El.remove(obj);
		}
	}
}
// Move Element V2 E --------------------------------------------------------------------------

// -- EventHandler S ---------------------------
var EventHandler = {
	copy : function(obj){
		obj = $E(obj);
		if(!obj) return false;
		var events = {};
		for(var key in obj){
			if(key.indexOf('on')!=0) continue;
			events[key] = obj[key];
		}
		return events;
	},
	restore : function(obj, events){
		obj = $E(obj);
		if(!obj) return false;
		for(var key in events){
			obj[key] = events[key];
		}
		return obj;
	},
	add: function(obj, evtStr, func, b){
		obj = $E(obj);
		if(b==null) b = false;
		if(window.addEventListener){
			return obj.addEventListener(evtStr, func, b);
		}else if(window.attachEvent){
			return obj.attachEvent(evtStr, func);
		}else{
			alert("EventHandler add 메소드가 지원되지 않는 환경입니다.");
			return false;
		}
	},
	remove: function(obj, evtStr, func, b){
		obj = $E(obj);
		if(b==null) b = false;
		if(window.addEventListener){
			//return obj.addEventListener(evtStr, func, b)
			alert("미완 기능입니다.");
			return false;
		}else if(window.detachEvent){
			return obj.detachEvent(evtStr, func);
		}else{
			alert("EventHandler add 메소드가 지원되지 않는 환경입니다.");
			return false;
		}
	}
}
//-- EventHandler E ---------------------------

// -- Display S -------------------------
var Display = {
	toggle: function(){
		for(var i=0; i<arguments.length; i++){
			var el = $E(arguments[i]);
			if(!el) continue;
			el.style.display = (el.style.display.toLowerCase() == 'none' ? '' : 'none');
		}
	},
	show: function(){
		for(var i=0; i<arguments.length; i++){
			var el = arguments[i];
			if(El.isArray(el)){
				el.forEach(function(idx, value){ Display.show(value.trim()) });
				return;
			}else if(El.isString(el)){
				el = el.split(',');
				if(el.length > 1){
					Display.show(el);
					return;
				}
				el = $E(el[0]);
			}else el = $E(el);

			if(!el) continue;
			// if(!this.isShow(el)) el.style.display = 'inline';

			el.style.display = '';
		}
	},
	hide: function(){
		for(var i=0; i<arguments.length; i++){
			var el = arguments[i];
			if(El.isArray(el)){
				el.forEach(function(idx, value){ Display.hide(value.trim()) });
				return;
			}else if(El.isString(el)){
				el = el.split(',');
				if(el.length > 1){
					Display.hide(el);
					return;
				}
				el = $E(el[0]);
			}else el = $E(el);

			if(!el) continue;
			// if(!this.isHide(el)) el.style.display = 'none';
			el.style.display = 'none';
		}
	},
	inline: function(){
		for(var i=0; i<arguments.length; i++){
			var el = arguments[i];
			if(El.isArray(el)){
				el.forEach(function(idx, value){ Display.inline(value.trim()) });
				return;
			}else if(El.isString(el)){
				el = el.split(',');
				if(el.length > 1){
					Display.inline(el);
					return;
				}
				el = $E(el[0]);
			}else el = $E(el);

			if(!el) continue;
			el.style.display = 'inline';
		}
	},
	block: function(){
		for(var i=0; i<arguments.length; i++){
			var el = arguments[i];
			if(El.isArray(el)){
				el.forEach(function(idx, value){ Display.block(value.trim()) });
				return;
			}else if(El.isString(el)){
				el = el.split(',');
				if(el.length > 1){
					Display.block(el);
					return;
				}
				el = $E(el[0]);
			}else el = $E(el);
			
			if(!el) continue;
			// if(!this.isBlock(el)) el.style.display = 'block';
			el.style.display = 'block';
		}
	},
	isShow: function(obj){
		obj = $E(obj);
		var d = obj.style.display;
		if(!d) d = '';
		return (d=='inline' || d!='none');
	},
	isHide: function(obj){
		obj = $E(obj);
		var d = obj.style.display;
		return (d=='none');
	},
	isBlock: function(obj){
		obj = $E(obj);
		var d = obj.style.display;
		return (d=='block');
	}
}
//-- Display E -------------------------
// -- Field S ---------------------------
function $F(v){ return Field.getValue(v); }
var Field = {
	clear:function(){
		var el;
		for (var i=0; i<arguments.length; i++){
			el = $E(arguments[i]);
			Field.setValue(arguments[i], '');
		}
	},
	focus: function(obj, select){
		obj = $E(obj);
		if(!obj) return;
		try{
			obj.focus();
			if(select) obj.select();
		}catch(e){}
	},
	hasFocus: function(obj){
		try{ return $E(obj).hasFocus(); }catch(e){ return false; }
	},
	selectIndex:function(obj){
		obj = $E(obj);
		if(!obj) return;
		try{ obj.select(); }catch(e){}
	},
	activate:function(obj){
		obj = $E(obj);
		if(obj) obj.focus();obj.select();
	},
	input:function(obj){
		switch(obj.type.toLowerCase()){
			case 'submit' :
			case 'hidden': return {name:obj.name||obj.id, value:obj.value};
			case 'password': return {name:obj.name||obj.id, value:obj.value};
			case 'text': return {name:obj.name||obj.id, value:obj.value};
			case 'checkbox': return this.checkbox(obj);
			case 'radio': return this.radio(obj);
		}
		return false;
	},
	radio:function(obj){
		var obj = document.getElementsByName(obj.name);
		for(var i=0; i<obj.length; i++){
			var o = obj[i];
			if(o.checked) return {name:o.name||o.id, value:o.value};
		}
		return {name:'', value:''};
	},
	checkbox:function(obj){
		if(obj.checked) return {name:obj.name||obj.id, value:obj.value||''};
		return {name:obj.name, value:''}
	},
	select:function(obj){
		var value = '';
		if(obj.type == 'select-one'){
			var index = obj.selectedIndex;
			if(index==-1) return [obj.name, ''];
			value = obj.options[index].value;// || obj.options[index].text;
		}else{
			value = new Array();
			var opt;
			for(var i=0; i<obj.length; i++){
				opt = obj.options[i];
				if(opt.selected) value.push(opt.value || opt.text);
			}
		}
		return {name:obj.name||obj.id, value:value, selectOption:obj.options[obj.selectedIndex]};
	},
	textarea:function(obj){
		return {name:obj.name||obj.id, value:obj.value};
	},
	object:function(obj){ // Gauce
		return {name:obj.name||obj.id, value:obj.Text};
	},
	getValue:function(obj){
		if(El.isArray(obj)){
			var vObj = {};
			obj.forEach(function(r, v){
				vObj[v] = Field.getValue(v);
			});
			return vObj;
		}else if(El.isString(obj)){
			obj = obj.trimAll().split(',');
			if(obj.length > 1){
				var vObj = {};
				obj.forEach(function(r, v){
					vObj[v] = Field.getValue(v);
				});
				return vObj;
			}
			obj = $E(obj[0]);
		}else obj = $E(obj);
		if(!obj) return '';
		// var method = obj.tagName.toLowerCase();
		if(!obj.nodeName) return '';
		var method = obj.nodeName.toLowerCase();
		var param;
		try{
			param = Field[method](obj);
		}catch(e){
			param = { value:obj.value } 
		}
		if(param) return param.value;
	},
	setValue:function(obj, v, inputOnly){
		obj = $E(obj);
		if(!obj) return false;
		if(v==null) v = '';
		try{
			var tn = obj.tagName.toLowerCase();
		}catch(e){return true;}
		try{
			if(tn=='input' || tn=='select' || tn=='textarea'){
				var type = obj.type.toLowerCase();
				if(type=="checkbox"){
					obj.checked = true;
					if(obj.value == v) obj.checked = true;
					else obj.checked = false;
				}else if(type=="radio"){
					//obj.checked = (obj.value == v);
					var list = document.getElementsByName(obj.name);
					for(var i=0; i<list.length; ++i){
						if(list[i].value == v){
							list[i].checked = true;
						}else{
							list[i].checked = false;
						}
					}
					//obj.checked = false;
				}else{
					obj.value = v;
				}
			}else if(tn=='object') try{ obj.Text = v; }catch(e){}
			else{
				if(!inputOnly && obj.id) obj.innerHTML = v;
			}
		}catch(e){}
		return true;
	},
	reset:function(obj, b, exList, inputOnly){
		obj = $E(obj);
		if(!obj) return false;
		if(!b) return this.setValue(obj, '', inputOnly);
		if(!obj.hasChildNodes()){
			var chk = true;
			t:for(var j=0; j<exList.length; j++){
				var exEl = exList[j];
				if(exEl && exEl==el){
					chk = false;
					exList.splice(j, 1);
					break t;

				}
			}
			if(chk) this.setValue(el, '', inputOnly);
			return true;
		}
		if(!exList) exList = '';
		else if((typeof exList) == 'string'){
			exList = exList.trim().split(',');
			for(var i=0; i<exList.length; i++) exList[i] = $E( exList[i] );
		}
		var cn = obj.childNodes;
		for(var i=0; i<cn.length; i++){
			var el = cn[i];
			var chk = true;
			if(exList){
				t:for(var j=0; j<exList.length; j++){
					var exEl = exList[j];
					if(exEl && exEl==el){
						chk = false;
						exList.splice(j, 1);
						break t;
					}
				}
			}
			if(chk) this.setValue(el, '', inputOnly);
			this.reset(el, b, exList, inputOnly);
		}
		return true;
	},
	resetList: function(list, exList){
		if(El.isString(list)) list = list.trim().split(',');
		if(!exList) exList = [];
		if(El.isString(exList)) exList = exList.trim().split(',');

		list.forEach(function(idx, value){
			var b = false;
			for(var i=0; i<exList.length; i++){
				if(value==exList[i]){
					b = true;
					exList.splice(i, 1);
					break;
				} 
			}
			if(!b) Field.setValue(value, '');
		});
	},
	dateMask: function(obj, sep){
		return DateUtil.dateMask(obj, sep);
	},
	focusEffect: function(obj){
		obj = $E(obj);
		
	}
}
//-- Field E ---------------------------

// -- Window S ------------------------------
var Window = {
	getGlobalParent: function(){
		var p = window.parent;
		while(p!=p.parent) p = p.parent;
		return p;
	}
	,getParentWindow: function(winName){
		var p = window;
		do{
			p = p.parent
			// alert("name:"+p.name);
			if(p.name == winName){
				return p;
			}
		}while(p!=p.parent);
		return null;
	}
	,hasParent: function(){
		return (window.parent != window);
	}
	,getScreenCenterPosition: function(width, height){
		var x, y;
		if(Browser.isIE()){
			x = window.screen.availWidth;
			y = window.screen.availHeight;
		}else{
			x = window.outerWidth;
			y = window.outerHeight;
		}
		x -= width || 0;
		y -= height || 0;
		return {x:parseInt(x/2), y:parseInt(y/2)};
	}
	,popup: function(url, name, width, height, options){
		var layout = this.getScreenCenterPosition(width, height);
		var opt = 'left=' + layout.x + ',top=' + layout.y + ',width=' +width + ',height=' + height + ',resize=no,toolbar=no,statusbar=no,menu=no';
		if(options && options.length > 0) opt += ',' + options;
		window.open(url, name, opt);
		try{
			//El.focus(name);
			eval(name+'.focus();');
		}catch(e){}
	}
}
//-- Window E ------------------------------

// -- El S ------------------------------
var El = {
	position:function(obj){
		if(obj.style.position.toLowerCase()=='absolute'){
			return {left:obj.style.left, top:obj.style.top};
		}
	},
	offset:function(obj){
		var obj = $E(obj);
		if(!obj) return false;
		var vLeft = 0;
		var vTop = 0;
		var vWidth = obj.offsetWidth;
		var vHeight = obj.offsetHeight;

		do{
			vLeft += obj.offsetLeft || 0;
			vTop += obj.offsetTop || 0;
			obj = obj.offsetParent;
		}while(obj);

		return { left:vLeft, top:vTop, right:vLeft+vWidth, bottom:vTop+vHeight,
				width:vWidth, height:vHeight };
	},
	rect:function(obj){
		var obj = $E(obj);
		if(!obj) return false;
		if(!Browser.isIE()) return this.offset(obj);
		var rect = obj.getBoundingClientRect();
		var x = 2;
		if( Window.hasParent() ) x = 0;
		return {
			left:rect.left-x, top:rect.top-x, right:rect.right-x, bottom:rect.bottom-x,
			width:(rect.right-rect.left), height:(rect.bottom-rect.top)
		};
	},
	clone:function(obj, b){
		/*
		var obj = $E(obj);
		var el = this.rect(obj);
		var dv = obj.cloneNode(true);
		dv.id = obj.id + '_clone';
		dv.style.position = 'absolute';
		dv.style.left = el.left + 'px';
		dv.style.top = el.top + 'px';
		if(b==true) document.body.appendChild(dv);
		return dv;
		*/
	},
	remove:function(obj){
		var obj = $E(obj);
		if(!obj) return false;

		if(Browser.isIE()) obj.removeNode(true);
		else document.body.removeChild(obj);

		if($E(obj.id || obj.name)) return false;
		else return true;
	},
	undefinedId: function(funcId){
		if(!funcId) funcId = 'anonymous';
		var func;
		var i = 0;
		var rId = '';
		do{
			rId = funcId + ++i;
			try{
				func = eval(rId);
			}catch(e){
				return rId;
			}
		}while(true);
	},
	centerPosition: function(srcObj, targetObj){
		targetObj = $E(targetObj);
		if(!targetObj) targetObj = document.body;
		srcObj = $E(srcObj);

		var rt1 = this.rect(targetObj);
		var x = Math.round( (rt1.right-rt1.left)/2 );
		var y = Math.round( (rt1.bottom-rt1.top)/2 );

		var x1=0, y1=0;
		if(srcObj){
			var display = srcObj.style.display;
			Display.show(srcObj);
			var rt2 = this.rect(srcObj);
			srcObj.style.display = display;

			x1 = String(rt2.width || srcObj.style.width || srcObj.width);
			y1 = String(rt2.height || srcObj.style.height || srcObj.height);

			x1 = parseInt( x1.replace('px', '') ) / 2;
			y1 = parseInt( y1.replace('px', '') ) / 2;
		}

		return { x:x-x1, y:y-y1 }
	},
	getUniqueID: function(obj){
		obj = $E(obj);
		if(!obj) return null;
		var uid = obj.uniqueID;
		if(uid) return uid;
		uid = String(new Date()).trimAll();
		obj.uniqueID = uid;
		return uid;
	},
	focus: function(obj, select){
		obj = $E(obj);
		if(!obj) return;
		try{
			obj.focus();
			if(select) this.select(obj);
		}catch(e){
		}
	},
	blur: function(obj){
		obj = $E(obj);
		if(!obj) return;
		try{
			obj.blur();
		}catch(e){}
	},
	select: function(obj){
		obj = $E(obj);
		if(!obj) return;
		try{
			obj.select();
		}catch(e){}
	},
	isObject: function(obj){
		if(!obj) return false;
		return (typeof obj).equals('object');
	},
	isArray: function(obj){
		if(!obj) return false;
		return (obj instanceof Array);
	},
	isString: function(obj){
		if(!obj) return false;
		return (typeof obj).equals('string');
	},
	isFunction: function(obj){
		if(!obj) return false;
		return (typeof obj).equals('function');
	},
	getGlobalParent: function(){
		var p = window.parent;
		while(p!=window.parent) p = window.parent;
		return p;
	},
	disabled: function(obj, styleStr){
		obj = $E(obj);
		if(!obj) return;
		if(!obj.disabled) obj.enableStyle = obj.style.cssText;
		if(obj.nodeName.equals('IMG')) obj.enSrc = obj.src;
		obj.disabled = true;
		try{
			if(styleStr) obj.style.cssText = styleStr;
		}catch(e){}
	},
	enabled: function(obj, styleStr){
		obj = $E(obj);
		if(!obj) return;
		if(obj.disabled) obj.disableStyle = obj.style.cssText;
		obj.disabled = false;
		try{
			if(obj.enSrc!=null && obj.enSrc!=obj.src) obj.src = obj.enSrc;
		}catch(e){}
		try{
			if(styleStr) obj.style.cssText = styleStr;
		}catch(e){}
	},
	readOnly: function(obj, b){
		if(b==null) b = true;
		obj = $E(obj);
		if(obj instanceof Array){
			for(var i=0; i<obj.length; ++i) obj[i].readOnly = b;
		}else{
			obj.readOnly = b;
		}
	},
	isEnable: function(obj){
		obj = $E(obj);
		var chk = true;
		try{
			if(Gauce.isEMEdit(obj)) chk = (obj.ReadOnly!=true && obj.Enable==true);
		}catch(e){}
		return (chk && obj.offsetWidth>0 && Display.isShow(obj) && obj.disabled!=true && obj.readOnly!=true && obj.type!='hidden');
	},
	isDisable: function(obj){
		obj = $E(obj);
		var chk = false;
		try{
			if(Gauce.isEMEdit(obj)) chk = (obj.ReadOnly==true || obj.Enable!=true);
		}catch(e){}
		return (chk || obj.offsetWidth<=0 || Display.isHide(obj) || obj.disabled==true || obj.readOnly==true || obj.type=='hidden');
	},
	isShow: function(obj){
		obj = $E(obj);
		if(!obj) return false;
		if(Display.isHide(obj)) return false;
		var os = this.offset(obj);
		return (os.width > 0 && os.height > 0);
	}
}
//-- El E ------------------------------

// -- Form S ----------------------------
var Form = {
	enterNextFocus: function(obj, ev, n){
		if(!ev) ev = event;
		if(!n && ev.keyCode!=13) return false;
		if(obj){
			var objStr = obj;
			obj = $E(objStr);
			if(!obj){
				var type = (typeof objStr);
				if(type.equals('function')){
					try{ objStr(); }catch(e){}
				}else if(type.equals('string')){
					try{ eval(objStr); }catch(e){}
				}
				return true;
			}
		}else obj = ev.srcElement;
		if(obj.tagName.toLowerCase() == 'textarea') return false;

		var fm = obj.form;
		if(!fm) return false;
		var fmCnt = fm.length;
		var loop = 0;
		for(var i=0; i<fmCnt; i++){
			if(loop++ > fmCnt*2) break;
			var o = fm[i];
			if(o != obj) continue;

			if(i == (fmCnt-1)){
				//fm.submit();
				// ev.returnValue = false;
				// return true;
				// El.focus(fm[0]);
				i = -1;
			}

			o = fm[i+1];
			// if(o.readOnly){

			if(El.isDisable(o)){
				obj = o;
				continue;
			}

			El.focus(o);
			if(o.tagName.equals('textarea')){
				ev.returnValue = false;
				ev.cancelBubble = true;
				return true;
			}
			//El.focus(o, true);
			return true;
		}
	},
	// formEl form 안의 Element 들을 찾아 AJAX POST 로 send 할 value 문장을 만든다.
	getFormParamStr: function(formEl){
		formEl = $E(formEl);
		if(!formEl || !formEl.tagName.equals('form')){
			alert('Form error : 객체가 없거나 form 객체가 아닙니다.');
			return '';
		}
		var str = '';
		for(var i=0; i<formEl.length; i++){
			var el = formEl[i];
			var tn = el.tagName.toUpperCase();
			var type = el.type.toUpperCase();
			if( (tn=='INPUT' && type!='BUTTON') || tn=='SELECT' || tn=='TEXTAREA' ){
				var tt = (el.id || el.name);
				if(!tt) continue;
				if(type=='RADIO' && !el.checked) continue;
				str += '&' + tt + '=' + encodeURIComponent($F(el));
			}
		}

		return str;
	},
	// 해당 객체들을 get 방식 파라미터 문자열을 만들어 return.
	makeParamStr: function(objs, hidden, readOnly){
		if(hidden==null) hidden = true;
		if(readOnly==null) readOnly = true;
		objs = objs.trim().split(",");
		var param = [];
		for(var i=0,cnt=objs.length; i<cnt; i++){
			var idStr = objs[i];
			var obj = $E(idStr);
			if(!obj) continue;
			if(hidden==false){
				try{
					if(obj.offsetWidth <= 0) continue;
				}catch(e){ continue; }
			}
			if(readOnly==false && obj.readOnly && obj.disabled) continue;
			if(i > 0) param.push("&");
			param.push(idStr);
			param.push("=");
			param.push(encodeURIComponent($F(obj)));
		}
		return param.join("");
	},
	// ※ 객체가 아닌 id 리스트들을 리턴.
	findElements: function(obj, tags, list){
		obj = $E(obj);
		if(typeof tags == 'string') tags = tags.toUpperCase().split(',');
		if(!list) list = [];

		for(var i=0; i<tags.length; i++){
			var tlist = $TAG(tags[i].trim(), obj);
			for(var j=0; j<tlist.length; ++j){
				var c = tlist[j];
				try{
					if(!c.id) continue;
					list.push(c.id);
				}catch(e){}
			}
		}
		return list;

		/*
		 * if(!obj || !obj.hasChildNodes) return list; var cns = obj.childNodes;
		 * t:for(var i=0, cnt=cns.length; i<cnt; i++){ var c = cns[i]; for(var
		 * j=0; j<tags.length; j++){ if(c.tagName != tags[j]) continue;
		 * if(!c.id) continue t; list.push(c.id); break; } list =
		 * this.findElements(c, tags, list); } return list;
		 */
	}
	,changeProperty: function(obj, tags, propName, value){
		obj = $E(obj);
		var list = this.findElements(obj, tags);
		for(var i=0, cnt=list.length; i<cnt; i++){
			var el = $E(list[i]);
			el[propName] = value;
		}
		return obj;
	}
	,validate: function(obj, trimChk, numberChk){
		if(El.isArray(obj)){
		}else if(El.isString(obj)){
			obj = obj.split(",");
		}else if(El.isObject(obj)){
			obj = [obj];
		}
		if(trimChk==null) trimChk = true;
		if(numberChk==null) numberChk = true;

		var vObj = $F(obj);
		for(var k in vObj){
			try{
				var v = vObj[k];
				if(trimChk) v = v.trim();

				if(v.length > 0){
					if(!numberChk) continue;
					if(numberChk && v!=0) continue;
				}
			}catch(e){}
			try{
				return $E(k);
			}catch(e){
				return k;
			}
		}
		return null;
	}
}
//-- Form E ----------------------------

var Locate = {
	act : false, el : null, els : null,
	// position 대상이 될 규칙
	rull_default : function(){
			var arg = arguments[0];
			if(arg.id.indexOf('ts_')==0){
				return true;
			}
			return false;
	},
	rull : function(){
			var arg = arguments[0];
			if(arg.id.indexOf('ts_')==0){
				return true;
			}
			return false;
	},
	resetRull : function(){
		this.rull = this.rull_default;
	},
	scan : function(resetRull){
		if(resetRull) this.resetRull();
		var items = document.body.all;
		var el = this.el;
		var els = this.els
		this.el = null;
		els = new Object();
		var rull = this.rull;
		for(var i=0; i<items.length; i++){
			var item = items[i];
			if(rull(item)){
				els[item.uniqueID] = {rect:El.rect(item), cssText:item.style.cssText};
			}
		}
		this.els = els;
	},
	detect : function(){
		var els = this.els;
		var locateEl = new Array();
		for(var ids in els){
			var el = $E(ids);
			if(!el) continue;

			var info = els[ids];
			var rect = info.rect;
			var x = event.clientX;
			var y = event.clientY;
			if( (rect.left<x && x<(rect.right)) && (rect.top<y && y<(rect.bottom)) ){
				locateEl.push(el);
			}

			//el.style.background = info.cssText;
			el.style.cssText = info.cssText;
		}
		if(locateEl.length>0){
			for(var i=0; i<locateEl.length; i++){
				locateEl[i].style.backgroundColor = 'skyblue';
			}
			this.el = locateEl;
		}else this.el = null;
	},
	end : function(objs){
		var el = this.el;
		if(!el || el.length==0) return false;

		var els = this.els;
		var e = el[0];
		e.style.cssText = this.els[e.uniqueID].cssText;

		try{
			e.appendChild(objs);
		}catch(exc){
			for(var i=0; i<objs.length; i++){
				e.appendChild(objs[i]);
			}
		}
	}
}

var DrawRange = {
	draw : false, canvas : null, mx : null, my : null, limitX : null, limitY : null,
	dObj : null, reFunc : null,
	selectMode : false, selectObjs : null, selectObjsInfo : null, selectObjsBefore : null,
	selectColor : 'skyblue',
	ready : function(obj, selectMode){
		if(MoveEl.move || event.button!=1) return false;
		if(this.dObj) this.drawEnd();
		this.draw = true;
		this.canvas = El.rect(obj);
		this.selectMode = selectMode;
		if(selectMode){
			this.resetSelectMode();
			Locate.rull = function(){
				var arg = arguments[0];
				if(arg.file) return true;
				return false;
			}
			Locate.scan();
		}
		this.reFunc = [document.onmousemove, document.onmouseup, document.onselectstart];
		document.onmousemove = function(){ DrawRange.drawing(); };
		document.onmouseup = function(){ DrawRange.drawEnd(); };
		document.onselectstart = function(){ return false; };

		var x = this.mx = event.clientX + document.body.scrollLeft;
		var y = this.my = event.clientY + document.body.scrollTop;
		
		var dv = document.createElement('div');
		dv.style.cssText = 'position:absolute;width:0;height:0;background-color:#DCF0FF;border:#3C76FF 1 solid;font-size:0pt;filter:alpha(Opacity=60)';
		dv.style.left = x;
		dv.style.top = y;
		document.body.appendChild(dv);

		this.dObj = dv;
	},
	drawing : function(){
		if(!this.draw) return false;
		var dObj = this.dObj;
		var canvas = this.canvas;
		var sLeft = document.body.scrollLeft;
		var sTop = document.body.scrollTop;
		var x = event.clientX;
		var y = event.clientY;
		var mx = x + sLeft - this.mx;
		var my = y + sTop - this.my;

		if(x <= canvas.left+1){
			x = canvas.left + sLeft;
			mx = this.mx - x - 2;
		}else if(x >= canvas.right){
			x = this.mx - 2;
			mx = canvas.right - x + sLeft;
		}else{
			if(mx>=0) x = this.mx - 2;
			else x += sLeft - 2;
		}

		if(y <= canvas.top+1){
			y = canvas.top + sTop;
			my = this.my - y - 2;
		}else if(y > canvas.bottom){
			y = this.my - 2;
			my = canvas.bottom - y + sTop;
		}else{
			if(my>=0) y = this.my - 2;
			else y += sTop - 2;
		}

		dObj.style.left = x;
		dObj.style.top = y;
		dObj.style.width = Math.abs(mx);
		dObj.style.height = Math.abs(my);

		if(this.selectMode){
			var els = Locate.els;
			var selectObjs = new Array();
			var d_rect = El.rect(this.dObj);
			for(var uid in els){
				var el = document.all[uid];
				if(!el) continue;
	
				var info = els[uid];
				var rect = info.rect;
				var r1 = false, r2 = false;
				if( (rect.left>d_rect.left && rect.left<d_rect.right) || (rect.right>d_rect.left && rect.right<d_rect.right) ) r1 = true;
				if( (d_rect.left>rect.left && d_rect.left<rect.right) || (d_rect.right>rect.left && d_rect.right<rect.right) ) r1 = true;
				if( (rect.top>d_rect.top && rect.top<d_rect.bottom) || (rect.bottom>d_rect.top&& rect.bottom<d_rect.bottom) ) r2 = true;
				if( (d_rect.top>rect.top && d_rect.top<rect.bottom) || (d_rect.bottom>rect.top&& d_rect.bottom<rect.bottom) ) r2 = true;

				if(r1 && r2) selectObjs.push(el);
				el.style.cssText = info.cssText;
			}
			if(selectObjs.length>0){
				for(var i=0; i<selectObjs.length; i++){
					selectObjs[i].style.background = this.selectColor;
				}
				this.selectObjs = this.selectObjsBefore = selectObjs;
				this.selectObjsInfo = Locate.els;
			}else{
				this.selectObjs = null;
			}
		}
	},
	drawEnd : function(){
		this.draw = false;
		var dObj = this.dObj;
		dObj.removeNode(true);
		this.dObj = null;
		document.onmousemove = this.reFunc[0];
		document.onmouseup = this.reFunc[1];
		document.onselectstart = this.reFunc[2];

		if(this.selectMode){
			var selectObjs = this.selectObjs;
			var selectObjsInfo = this.selectObjsInfo;
			if(!selectObjs && this.selectObjsBefore){
				selectObjs = this.selectObjsBefore;
				for(var i=0; i<selectObjs.length; i++){
					var sobj = selectObjs[i];
					sobj.style.cssText = selectObjsInfo[sobj.uniqueID].cssText;
				}
				this.selectObjsInfo = this.selectObjsBefore = null;
			}
		}
	},
	select : function(item){
		if(event.button!=1) return;
		var selectObjs = this.selectObjs;
		var chk = false;
		var e_ctrl = event.ctrlKey;
		if(selectObjs){
			for(var i=0; i<selectObjs.length; i++){
				if(item == selectObjs[i]){
					if(e_ctrl) this.deselect(item, i);
					chk = true;
					break;
				}
			}
		}
		if(chk) return;
		try{
			var uid = item.uniqueID;
		}catch(e){ return; }

		if(!e_ctrl) this.resetSelectMode();

		var selectObjs = this.selectObjs;
		if(!selectObjs) selectObjs = new Array();
		selectObjs.push(item);

		var els = this.selectObjsInfo;
		if(!els) els = new Object();
		els[uid] = {rect:El.rect(item), cssText:item.style.cssText};

		this.selectObjs = this.selectObjsBefore = selectObjs;
		this.selectObjsInfo = els;

		item.style.background = this.selectColor;
	},
	deselect : function(obj, i){
		this.selectObjs.splice(i, 1);
		obj.style.cssText = this.selectObjsInfo[obj.uniqueID].cssText;
		return true;
	},
	resetSelectMode : function(){
		var selectObjs = this.selectObjs;
		var selectObjsInfo = this.selectObjsInfo;
		if(selectObjs && selectObjsInfo){
			for(var i=0; i<selectObjs.length; i++){
				var sobj = selectObjs[i];
				sobj.style.cssText = selectObjsInfo[sobj.uniqueID].cssText;
			}
			this.selectObjs = this.selectObjsInfo = this.selectObjsBefore = null;
		}
	}
}


// Resize
var Resize = {
	bfX: 0, bfY: 0, acting: false,
	obj: null, mode: 0, limit: null, rectObj: null, width: 0, height: 0, eventObj: null,
	resizeMode: false, funcObj: null,
	set: function(obj, mode, limit, funcObj){
		var RS = this;
		obj = $E(obj);
		if(!obj) obj = event.srcElement.previousSibling;
		if(!obj){
			alert('Error : 객체 확인요망.');
			return false;
		}
		this.obj = obj;
		this.mode = (mode || 0); // 0:width, 1:height, 2:all

		if(!limit) limit = '';
		limit = String(limit).trim().split(',');
		var len = limit.length;
		if(len==0) limit = [0,0,0,0];
		else if(len==1){
			limit = limit[0].split(':');
			if(this.mode==1){
				if(limit.length == 1) limit = [0,0, 10,parseInt(limit[0])];
				else limit = [0,0, parseInt(limit[0]),parseInt(limit[1])];
			}else{
				if(limit.length == 1) limit = [10,parseInt(limit[0]), 0,0];
				else limit = [parseInt(limit[0]),parseInt(limit[1]), 0,0];
			}
		}else if(len==2){
			var lim1 = limit[0].split(':'), lim2 = limit[1].split(':');
			if(lim1.length==1) lim1 = [10, parseInt(lim1[0])];
			else lim1 = [parseInt(lim1[0]), parseInt(lim1[1])];
			if(lim2.length==1) lim2 = [10, parseInt(lim1[0])];
			else lim2 = [parseInt(lim2[0]), parseInt(lim2[1])];

			limit = [ lim1[0], lim1[1], lim2[0], lim2[1] ];
		}
		this.limit = limit;

		this.bfX = event.clientX;
		this.bfY = event.clientY;
		var rectObj = this.rectObj = El.rect(obj);
		this.width = rectObj.width - event.clientX;
		this.height = rectObj.height - event.clientY;

		var bd = document.body;
		this.eventObj = EventHandler.copy(bd);
		bd.onmousemove = function(){ RS.act(); }
		bd.onmouseup = function(){ RS.end(); }
		bd.ondragstart = bd.onselectstart = function(){ return false; }

		this.acting = true;
		this.funcObj = funcObj;
		try{ funcObj.start(); }catch(e){}
	},
	act: function(){
		if(!this.acting) return;
		if(this.mode==0 || this.mode == 2){
			var w = this.width + event.clientX;
			if(!w || w<this.limit[0]) w = this.limit[0];
			else if(w>this.limit[1]) w = this.limit[1];
			this.obj.style.width = w;
		}
		if(this.mode==1 || this.mode == 2){
			var h = this.height + event.clientY;
			if(!h || h<this.limit[2]) h = this.limit[2];
			else if(h>this.limit[3]) h = this.limit[3];
			this.obj.style.height = h;
		}
	},
	end: function(){
		this.acting = false;
		try{ this.funcObj.end(); }catch(e){}
		EventHandler.restore(document.body, this.eventObj);
	},
	Animate: {
		execName: 'Resize.Animate',
		actObj: {
			/*
			obj: null, w: null, h: null, rectDv: null, iW: null, iH: null,
			finallyAct: null, actStatus: {w:false, h:false},
			intervalW: null, intervalH: null
			*/
		},
		act: function(obj, iW, iH, finallyFunc){
			var obj = $E(obj);
			if(!obj) return false;

			var uid = obj.uniqueID;
			var actObj = this.actObj;
			var aObj = actObj[uid];
			if(!aObj) aObj = actObj[uid] = {};
			aObj.obj = obj;

			var rt = aObj.rectDv = El.rect(obj);
			aObj.w = obj.style.width = rt.width;
			aObj.h = obj.style.height = rt.height;
			aObj.iW = iW;
			aObj.iH = iH;
			aObj.finallyFunc = finallyFunc;
			aObj.actStatus = {w:false, h:false}

			if(iW && aObj.w!=iW){
				aObj.actStatus.w = true;
				aObj.intervalW = setInterval('Resize.Animate.actW("'+uid+'")', 1);
			}
			if(iH && aObj.h!=iH){
				aObj.actStatus.h = true;
				aObj.intervalH = setInterval('Resize.Animate.actH("'+uid+'")', 1);
			}
			
			this.actObj[uid] = aObj;
		},
		calcTerm: function(chkN){
			var n = 10;
			var absN = Math.abs(chkN);
			if(absN > 10){
				n = Math.floor(absN/10*2);
				if(n==1) n = 3;
			}else n = 1;
			n = (chkN < 0) ? n : -n;
			return n;
		},
		actW: function(uid){
			var aObj = this.actObj[uid];
			if(!aObj) return;

			var w = aObj.w;
			var iW = aObj.iW;
			var chkN = w - iW;
			if(chkN==0){
				try{
					clearInterval(aObj.intervalW);
					aObj.actStatus.w = false;
					this.finallyAct(uid);
				}catch(e){}
				return true;
			}

			var term = this.calcTerm(chkN);
			aObj.w = aObj.obj.style.width = w + term;
		},
		actH: function(uid){
			var aObj = this.actObj[uid];
			if(!aObj) return;

			var h = aObj.h;
			var iH = aObj.iH;
			var chkN = h - iH;
			if(chkN==0){
				try{
					clearInterval(aObj.intervalH);
					aObj.actStatus.h = false;
					this.finallyAct(uid);
				}catch(e){}
				return true;
			}

			var term = this.calcTerm(chkN);
			aObj.h = aObj.obj.style.height = h + term;
		},
		finallyAct: function(uid){
			var aObj = this.actObj[uid];
			if(!aObj) return;

			if(aObj.actStatus.w || aObj.actStatus.h) return;
			if(aObj.finallyFunc){
				try{
					aObj.finallyFunc();
				}catch(e){ alert('Resize Animate finallyAct\n'+e.description); }
			}
		}
	}
}


// Loading Div
try{
	//ImgRoot = parent.ImgRoot;
	ImgRoot = 'img';
}catch(e){ ImgRoot=''; }
var LoadingObj = Class.create();
LoadingObj.prototype = {
	init: function(){
	},
	loadingImgFocusInterval: null,
	barrierDivObj: null,
	barrierDiv: function(b){
		if(b==null) b = true;
		var dv = this.barrierDivObj;
		if(!dv){
			dv = document.createElement('div');
			dv.style.cssText = 'display:none;position:absolute;left:0;top:0;width:110%;height:200%;z-index:10;';
			var src = '<table width=100% height=100% cellspacing=0 cellpadding=0 style="filter:alpha(opacity=50);opacity:.5;background:#666666;"><tr><td>&nbsp;</td></tr></talbe>';
			dv.innerHTML = src;
			document.body.appendChild(dv);
			this.barrierDivObj = dv;
		}
		dv.style.width = dv.style.height = '200%';
		Display[ b ? 'show' : 'hide' ](dv);
		dv.style.width = dv.style.height = '100%';

		return dv;
	},
	barrierFrm: null,
	getBarrierFrm: function(){
		return this.barrierFrm;
	},
	barrierReady: function(){
		var bFrm = new IFrame('LOADINGFRM000' + String(new Date()).trimAll());
		bFrm.frm.style.cssText = 'display:none;position:absolute;left:0;top:0;filter:alpha(opacity=30);opacity:.3;width:110%;height:200%;z-index:10;';
		bFrm.onload = function(){
			bFrm.frm.contentWindow.document.body.bgColor = '#000000';
		}
		bFrm.create(false);
		// bFrm.frm.style.width = '102%';
		// bFrm.frm.style.height = '102%';

		function rs_t(){
			var ooss = El.offset(document.documentElement);
			bFrm.frm.style.width = document.body.offsetWidth;// ooss.width +
																// document.body.scrollLeft;
			bFrm.frm.style.height = document.body.offsetHeight + 50;// ooss.height
																	// +
																	// document.body.scrollTop;
		}
		rs_t();
		EventHandler.add(window, 'onresize', rs_t);
		EventHandler.add(window, 'onscroll', rs_t);

		this.barrierFrm = bFrm;
		return bFrm;
	},
	barrier: function(b){
		if(b==null) b = true;
		var bFrm = this.barrierFrm;
		if(b==true && !bFrm){
			bFrm = this.barrierReady();
		}
		if(b){
			bFrm.frm.style.width = document.body.offsetWidth;
			bFrm.frm.style.height = document.body.offsetHeight + 50;
			Display.show(bFrm.frm);
		}else{
			Display.hide(bFrm.frm);
		}

		return bFrm;
	},
	imgLocate: ImgRoot+'/etc', commonImgName: 'loading_', defaultImgName: 'kit',
	loadingWindow: null, loadImgSrc: '', imgObj: null,
	on: function(obj, barrierMode, imgName){
		obj = $E(obj);
		if(!obj) obj = document.body;
		/*
		 * while(obj.tagName.toLowerCase()=='body' &&
		 * obj!=parent.document.body){ obj = parent.document.body; }
		 */
		var ld = this.loadingDiv;

		var winObj = this.loadingWindow;
		// if(winObj && winObj.style.display!='none') return true;
		var rt = El.rect(obj);

		var imgObj = this.imgObj;
		if(imgObj) El.remove(imgObj);
		imgObj = document.createElement('img');
		imgObj.src = ( this.imgLocate + '/' + this.commonImgName + (imgName||this.defaultImgName) + '.gif' );
		this.imgObj = imgObj;

		var width = imgObj.width;
		var height = imgObj.height;
		var x = rt.left + Math.round((rt.right-rt.left)/2) - (width/2);
		var y = rt.top + Math.round((rt.bottom-rt.top)/2) - (height/2) - 3;

		if(!winObj){
			winObj = document.createElement('div');

			var frm1 = document.createElement('iframe');
			frm1.frameBorder = frm1.scrolling = 'no';
			var os = El.offset(obj);
			/*
			 * var scrolls; if(obj == document.body) scrolls =
			 * [obj.scrollLeft-obj.leftMargin, obj.scrollTop-obj.topMargin];
			 * else scrolls = [0, 0];
			 */

			frm1.style.cssText = 'position:absolute;left:'+os.left+';top:'+os.top+';filter:alpha(opacity=50);opacity:.5;z-index:50;width:200%;height:200%;background-color:#555555;';
			frm1.onreadystatechange = function(){
				if(this.readyState!='complete') return false;
				var db = frm1.contentWindow.document.body;
				db.leftMargin = 0;
				db.topMargin = 0;
				db.bgColor = '#555555';
			}
			if(obj.tagName.toLowerCase() == 'body'){
				//frm1.style.width = frm1.style.height = '101%';
				function rs_t(){
					var ooss = El.offset(document.body);
					frm1.style.width = ooss.width + document.body.scrollLeft;
					frm1.style.height = ooss.height + document.body.scrollTop;
				}
				rs_t();
				EventHandler.add(window, 'onresize', rs_t);
				EventHandler.add(window, 'onscroll', rs_t);
			}else{
				frm1.style.width = os.width;
				frm1.style.height = os.height;
			}

			var frm2 = document.createElement('iframe');
			frm2.src = imgObj.src;
			frm2.onreadystatechange = function(){
				if(this.readyState!='complete') return false;
				var db = frm2.contentWindow.document.body;
				db.leftMargin = 0;
				db.topMargin = 0;
			}
			frm2.style.cssText = 'display:;position:absolute;width:'+width+';height:'+height+';border:#cccccc 0 solid;z-index:999999;';
			frm2.frameBorder = 'no';
			frm2.scrolling = 'no';

			winObj.appendChild(frm1);
			winObj.appendChild(frm2);

			document.body.appendChild(winObj);
			this.loadingWindow = winObj;
		}

		var cns = winObj.getElementsByTagName('iframe');
		var ld;
		for(var i=0; i<cns.length; i++){
			ld = cns[i];
			if(ld.src) break;
			else Display[ (barrierMode) ? 'show' : 'hide' ](ld);
		}
		if(imgObj.src != this.loadImgSrc){
			ld.src = imgObj.src;
			ld.style.width = width;
			ld.style.height = height;
			this.loadImgSrc = imgObj.src;
		}
		ld.style.left = x;
		ld.style.top = y;
		Display.show(winObj);

		try{
			LDLDLDLDLDLDLDLDLDLD = ld;
			this.loadingImgFocusInterval = window.setInterval('try{ if(document.hasFocus()) LDLDLDLDLDLDLDLDLDLD.focus(); }catch(e){}', 1);
		}catch(e){}

		return true;
	},
	loadingDiv2: null, loadingWindow2: null,
	onDiv: function(obj, barrierMode, imgName){
		obj = $E(obj);
		if(!obj) obj = document.body;

		var aa = 1;
		while(obj.tagName.equals('body') && obj!=parent.document.body){
			obj = parent.document.body;
		}
		var ld = this.loadingDiv2;

		var rt = El.rect(obj);

		var imgObj = this.imgObj;
		if(imgObj) El.remove(imgObj);
		imgObj = document.createElement('img');
		imgObj.src = ( this.imgLocate + '/' + this.commonImgName + (imgName||this.defaultImgName) + '.gif' );
		this.imgObj = imgObj;

		var width = imgObj.width;
		var height = imgObj.height;
		var x = rt.left + Math.round((rt.right-rt.left)/2) - (width/2);
		var y = rt.top + Math.round((rt.bottom-rt.top)/2) - (height/2) - 3;

		var winObj;
		if(!this.loadingWindow2){
			winObj = document.createElement('div');
			winObj.style.cssText = 'display:none;position:absolute;left:0;top:0;width:200%;height:200%;z-index:10000;';
			var src = '<table width=100% height=100% cellspacing=0 cellpadding=0 style="filter:alpha(opacity=50);opacity:.5;background:#DEDEDE;"><tr><td>&nbsp;</td></tr></talbe>';
			winObj.innerHTML = src;

			document.body.appendChild(winObj);
			this.loadingWindow2 = winObj;
		}else{
			winObj = this.loadingWindow2;
		}
		imgObj.style.cssText = 'position:absolute;';
		winObj.appendChild(imgObj);

		winObj.style.width = winObj.style.height = '200%';
		if(obj.tagName.toLowerCase() == 'body') winObj.style.width = winObj.style.height = '100%';
		else{
			var os = El.offset(obj);
			winObj.style.width = os.width;
			winObj.style.height = os.height;
		}

		Display[ (barrierMode) ? 'show' : 'hide' ]( winObj.getElementsByTagName('table')[0] );
		imgObj.style.left = x;
		imgObj.style.top = y;
		Display.show(winObj);

		return true;
	},
	off: function(){
		try{
			window.clearInterval(this.loadingImgFocusInterval);
		}catch(e){}
		try{
			El.remove(this.loadingWindow);
			if(this.loadingWindow2){
				//해당focus를 설정하지 않으면 본래의 page에 focus가 가지 않는 알수없는 버그가 발생. loadingWindow2 만 발생하는듯.
				El.focus(document.body);
				El.remove(this.loadingWindow2);
			}
		}catch(e){
		}finally{
			this.loadingWindow = null;
			this.loadingWindow2 = null;
		}
		//Display.hide(this.loadingWindow, this.loadingWindow2);
		Display.hide(this.barrierDivObj);
		if(this.barrierFrm) Display.hide(this.barrierFrm.frm);
	},
	remove: function(){
		El.remove(this.barrierFrm);
		this.barrierFrm = null;
	}
}
var Loading = new LoadingObj();

var Numeric = {
	loop : 0,
	//n : 소수 허용여부(0이나 null:미허용, 1:허용), cm : 콤마 출력 여부 (true/false)
	keyup : function(obj, n, cm, ev){
		if(!n) n = 0;
		if(!ev) ev = event;
		if(!obj){
			obj = ev.srcElement;
			if(!obj) return false;
		}

		if(!obj.addEvent){
			obj.style.imeMode = 'disabled';
			var func = function(){
				var v = $F(this);
				if(v.trim().length==0){
					Field.setValue(this, '');
					return;
				}
				if(cm) v = parseFloat(v);
				else{
					if(isNaN(v)) v = '';
				}
				if(isNaN(v)) v = 0;
				this.value = (cm) ? Numeric.insComma(v) : v;
				Numeric.loop = 0;
			};
			if(!obj.onblur){
				obj.onblur = func;
			}else{
				EventHandler.add(obj, 'onblur', func);
			}
			obj.addEvent = true;
		}
		
		var v = $F(obj);
		if(v.trim().length==0){
			Field.setValue(obj, '');
			return '';
		}
		if(this.loop==0){
			this.loop = 1;
			if(v.indexOf(',')!=-1) v = this.rmComma(v);
		}
		var dot = 0;
		var minus = false;
		var str = '';
		var e = false;
		for(var i=0; i<v.length; i++){
			var va = v.charAt(i);
			if(va=='.'){
				dot++;
				if(dot>n) continue;
			}else if(va=='-' && i==0){
				str += va;
				continue;
			}else{
				if(va.trim().length==0 || isNaN(va)){ e=true;continue; }
			}
			str += va;
		}
		if(dot>n || e){
			if(str=='.') str = '';
			obj.value = str;
		}

		v = parseFloat(str);
		if(isNaN(v)) v = 0;
		return v;
	},
	// String 을 세자리마다 , 삽입
	insComma : function(str){
		var isObj = El.isObject(str);
		var obj, rv;
		if(isObj){
			obj = $E(str);
			str = $F(obj);
		}
		if(!str || str==0) return '0';
	
		var txtNumber = '' + str;
		var re = /^\$|,/g;
		txtNumber = txtNumber.replace(re, "");
	
		var rxSplit = new RegExp('([0-9])([0-9][0-9][0-9][,.])');
		var arrNumber = txtNumber.split('.');
		arrNumber[0] += '.';
		do{
			arrNumber[0] = arrNumber[0].replace(rxSplit, '$1,$2');
		}while(rxSplit.test(arrNumber[0]));
	
		if(arrNumber.length > 1) rv = arrNumber.join('');
		else rv = arrNumber[0].split('.')[0];

		if(isObj){
			Field.setValue(obj, rv);
			rv = obj;
		}
		return rv;
	},
	// , 제거
	rmComma : function(str, n) {
		if(!str) return 0;
		re = /^\$|,/g;
		str = '' + str;
		str = str.replace(re, '');
		if(!isNaN(str)) str = parseFloat(str);
		if(n==1 && isNaN(str)) str = 0;
		return str;
	},
	rmCommaObj : function(obj){
		obj = $E(obj);
		var value = $F(obj);
		if(value.trim().length==0) return;
		obj.value = this.rmComma(obj.value);
		obj.select();
	},
	nvl: function(obj, n){
		if(El.isObject(obj)) obj = $F(obj);
		if(!n) n = 0;
		if(!obj) return n;
		return obj;
	}
}


//-- Pop Menu S --------------------
var PopMenu = {
	popFrames: {}, popMenuOn: false,
	menusPositionHover: false,
	setMenusPosition: function(obj){
		obj = $E(obj);
		if(!obj) return false;
		var popMenu = PopMenu;
		obj.onmouseover = function(){ popMenu.menusPositionHover = true; }
		obj.onmouseout = function(){ popMenu.menusPositionHover = false; }
		//FunctionHandler.add(document.body, 'onclick', function(){ if(!popMenu.menusPositionHover) popMenu.hideAll(); });
		EventHandler.add(document.body, 'onclick', function(){ if(!popMenu.menusPositionHover) popMenu.hideAll(); });
	},
	create: function(idStr, srcObj, mode, x, y){
		if(!mode) mode = 'basic';
		return this.createMode[mode](idStr, srcObj, mode, x, y);
	},
	createSub: function(parentId, idStr, srcObj, mode, x, y){
		if(!mode) mode = 'submenu';
		return this.createMode[mode](parentId, idStr, srcObj, mode, x, y);
	},
	createMode: {
		basic: function(menuId, srcObj, mode){
			var popMenu = PopMenu;
			var menu = $E(menuId);
			var srcObj = $E(srcObj);
			if(!menu || !srcObj){
				alert('PopMenu 대상 객체가 없음');
				return false;
			}

			EventHandler.add(menu, 'onclick', function(){
					popMenu.toggle(menuId, false, true);
			});
			FunctionHandler.add(menu, 'onmouseover', function(){
					if(popMenu.popMenuOn && !arguments[0].popOn){
						popMenu.toggle(menuId, false, true);
					}
				}, 'this'
			);

			Display.show(srcObj);
			var srcObj_rt = El.offset(srcObj);
			var width = srcObj_rt.width;
			var height = srcObj_rt.height;
			var menu_width = El.rect(menu).width;
			if(width <= menu_width) srcObj.style.width = width = menu_width+1; // ※ +1
																				// 여부
																				// 이후
																				// 검토.
			srcObj.style.width = width;
			srcObj.style.height = height;
			var srcStr = srcObj.outerHTML;
			Display.hide(srcObj);

			var menu_rect = El.rect(menu);

			var menu_frm_id = El.undefinedId();
			var menu_frm = "";
			menu_frm += "<iframe id="+menu_frm_id+" frameborder=no scrolling=no style='width:"+width+";height:"+height+";position:absolute;display:none;z-index:10000;'></iframe>";
			document.write(menu_frm);
			menu_frm = $E(menu_frm_id);

			var menu_frm_doc = menu_frm.contentWindow.document;
			menu_frm.onreadystatechange = function(){
				if(this.readyState!='complete') return false;
				var ss = document.styleSheets;
				try{
					for(var i=0; i<ss.length; i++){
						menu_frm_doc.createElement('style');
						menu_frm_doc.appendChild(menu_frm_doc.createElement('style'));
						menu_frm_doc.styleSheets[menu_frm_doc.styleSheets.length-1].cssText = ss[i].cssText;
					}
				}catch(e){alert('css 적용 오류\n' + e.description);}
				with(menu_frm_doc.body){
					leftMargin = topMargin = rightMargin = bottomMargin = 0;
					style.marginLeft = style.marginTop = style.marginRight = style.marginBottom = 0;
					innerHTML = srcStr;
				}
			}

			popMenu.popFrames[menuId] = {};
			popMenu.popFrames[menuId].mode = mode;
			var btn = popMenu.popFrames[menuId].button = menu;
			var frm = popMenu.popFrames[menuId].frame = menu_frm;
		},
		submenu: function(parentId, menuId, srcObj, mode){
			var popMenu = PopMenu;
			var prt = popMenu.popFrames[parentId].frame;
			if(!prt || !prt.tagName.equals('iframe')){
				alert('정상적인 Parent 객체가 아님.');
				return false;
			}
			if(prt.readyState!='complete'){
				setTimeout('PopMenu.createSub(\"'+parentId+'\",\"'+menuId+'\",\"'+srcObj+'\",\"'+mode+'\")', 100);
				return;
			}
			var menu = prt.contentWindow.document.getElementById(menuId);// $E(menuId);
			var srcObj = $E(srcObj);
			if(!menu || !srcObj){
				alert('정상적인 PopMenu 객체가 아님.');
				return false;
			}
			EventHandler.add(menu, 'onclick', function(){
					popMenu.toggle(menuId, false, true);
			});
			FunctionHandler.add(menu, 'onmouseover', function(){
					if(popMenu.popMenuOn && !arguments[0].popOn){
						popMenu.toggle(menuId, false, true, true);
					}
				}, 'this'
			);

			Display.show(srcObj);
			var srcObj_rt = El.offset(srcObj);
			var width = srcObj_rt.width;
			var height = srcObj_rt.height;
			var menu_width = El.rect(menu).width;
			if(width <= menu_width) srcObj.style.width = width = menu_width+1; // ※ +1
																				// 여부
																				// 이후
																				// 검토.
			srcObj.style.width = width;
			srcObj.style.height = height;
			var srcStr = srcObj.outerHTML;

			Display.hide(srcObj);

			var menu_rect = El.rect(menu);

			var menu_frm_id = El.undefinedId();
			/*
			 * var menu_frm = ""; menu_frm += "<iframe id="+menu_frm_id+"
			 * frameborder=no scrolling=no
			 * style='width:"+width+";height:"+height+";position:absolute;display:none;z-index:10000;'></iframe>";
			 * document.write(menu_frm); menu_frm = $E(menu_frm_id);
			 */
			var menu_frm = new IFrame(menu_frm_id, "width:"+width+";height:"+height+";position:absolute;display:none;z-index:10000;");
			menu_frm = menu_frm.create();

			var menu_frm_doc = menu_frm.contentWindow.document;
			menu_frm.onreadystatechange = function(){
				if(this.readyState!='complete') return false;
				var ss = document.styleSheets;
				try{
					for(var i=0; i<ss.length; i++){
						menu_frm_doc.createElement('style');
						menu_frm_doc.appendChild(menu_frm_doc.createElement('style'));
						menu_frm_doc.styleSheets[menu_frm_doc.styleSheets.length-1].cssText = ss[i].cssText;
					}
				}catch(e){alert('css 적용 오류\n' + e.description);}
				with(menu_frm_doc.body){
					leftMargin = topMargin = rightMargin = bottomMargin = 0;
					style.marginLeft = style.marginTop = style.marginRight = style.marginBottom = 0;
					innerHTML = srcStr;
				}
			}

			popMenu.popFrames[menuId] = {};
			popMenu.popFrames[menuId].mode = mode;
			var btn = popMenu.popFrames[menuId].button = menu;
			var frm = popMenu.popFrames[menuId].frame = menu_frm;
			popMenu.popFrames[menuId].parent = prt;
		},
		bar: function(frmId, obj, mode, x, y){
			var popMenu = PopMenu;
			var frm_doc = eval(frmId + '.document');
			obj = $E(obj);
			obj.style.cursor = 'default';
			popMenu.popFrames[frmId] = {}
			popMenu.popFrames[frmId].mode = mode;
			var frm = popMenu.popFrames[frmId].frame = $E(frmId);
			frm.popOn = false;
			frm.position = {
				init: {x:frm.style.left, y:frm.style.top},
				pop: {
					x:(x==null) ? frm.style.left : x,
					y:(y==null) ? frm.style.top : y
				}
			}
			frm.style.zIndex = 10000;
			frm.style.width = obj.style.width || obj.width;
			frm.style.height = obj.style.height || obj.height;

			frm.onreadystatechange = function(){
				if(this.readyState!='complete') return false;
				var ss = document.styleSheets;
				for(var i=0; i<ss.length; i++){
					frm_doc.createElement('style');
					frm_doc.appendChild(frm_doc.createElement('style'));
					frm_doc.styleSheets[frm_doc.styleSheets.length-1].cssText = ss[i].cssText;
				}
				frm_doc.body.leftMargin = frm_doc.body.topMargin = 0;
				Display.show(obj);
				frm_doc.body.innerHTML = obj.outerHTML;
				Display.hide(obj);

				EventHandler.add(frm_doc, 'onmouseover', function(){
						if(popMenu.popMenuOn) popMenu.show(frmId);
				});
			}

			Display.show(frm);
			return frm;
		}
	},
	toggle: function(frmId, hide, onlyOne, show){
		var frm = this.popFrames[frmId];
		try{
			this.toggleAct[frm.mode](frmId, hide, onlyOne, show);
		}catch(e){
			this.toggleAct['basic'](frmId, hide, onlyOne, show);
		}
	},
	toggleAct: {
		basic: function(frmId, hide, onlyOne, show){
			var popMenu = PopMenu;
			var btn = popMenu.popFrames[frmId].button;
			var frm = popMenu.popFrames[frmId].frame;
			if(onlyOne){
				for(var key in popMenu.popFrames){
					if(key != frmId) popMenu.toggle(key, true);
				}
			}

			var rt = El.rect(btn);
			frm.style.left = rt.left-1;
			frm.style.top = rt.bottom;
			if(show){
				Display.show(frm);
			}else{
				if(hide) Display.hide(frm);
				else Display.toggle(frm);
			}

			popMenu.popMenuOn = btn.popOn = (frm.style.display=='none') ? false : true;
		},
		submenu: function(frmId, hide, onlyOne, show){
			var popMenu = PopMenu;
			var btn = popMenu.popFrames[frmId].button;
			var frm = popMenu.popFrames[frmId].frame;
			var p_frm = popMenu.popFrames[frmId].parent;

			if(onlyOne){
				var md = popMenu.popFrames[frmId].mode;
				for(var key in popMenu.popFrames){
					if(key == frmId) continue;
					if(md!=popMenu.popFrames[key].mode) continue;
					popMenu.toggle(key, true);
				}
			}

			function setPosition(){
				var d = Display.isHide(p_frm);
				if(d) Display.show(p_frm);
				var rt_p = El.rect(p_frm);
				if(d) Display.hide(p_frm);
	
				var rt = El.rect(btn);
				frm.style.left = rt_p.left+rt.right;// rt_p.left + rt.left + 40;
				frm.style.top = rt_p.top+rt.top;// rt_p.top + rt.bottom - 7;
			}

			if(!hide) setPosition();
			if(show) Display.show(frm);
			else{
				if(hide) Display.hide(frm);
				else Display.toggle(frm);
			}

			//popMenu.popMenuOn = btn.popOn = (frm.style.display=='none') ? false : true;
		},
		bar: function(frmId, hide, onlyOne, show){
			var popMenu = PopMenu;
			var frm = popMenu.popFrames[frmId].frame;
			if(onlyOne){
				for(var key in popMenu.popFrames){
					if(key != frmId) popMenu.toggle(key, true);
				}
			}
			var position = frm.position;
			if( (hide || frm.popOn) && !show ){
				popMenu.popMenuOn = frm.popOn = false;
				position = position.init;
			}else{
				popMenu.popMenuOn = frm.popOn = true;
				position = position.pop;
			}
			frm.style.left = position.x;
			frm.style.top = position.y;
		}
	},
	show: function(frmId){
		return this.toggle(frmId, false, true, true);
	},
	hide: function(obj){
		var obj_doc = obj.document;
		var popFrames = this.popFrames;
		for(var key in popFrames){
			var vObj = popFrames[key].frame.contentWindow.document;
			if(vObj==obj_doc){
				this.toggle(key, true);
				break;
			}
		}
	},
	hideAll: function(){
		var popFrames = this.popFrames;
		for(var key in popFrames) this.toggle(key, true);
	}
}
//-- Pop Menu E --------------------

// -- TabWindows S ---------------------
function goTabWindows(obj, url, groupNo, refresh){
	try{
		var tw = parent.TabWindows;
		if(tw){
			tw.createTab(obj, url, groupNo, refresh);
			return true;
		}
	}catch(e){}
	return false;
}
function createTabOfPopMenu(obj, url, groupNo, title, hide){
	TabWindows.createTab(title || obj, url, groupNo);
	try{
		if(hide) PopMenu.hideAll();
		else PopMenu.hide(obj);
	}catch(e){}
}
var TabWindows = {
	tabMenuDiv: null, tabWindowDiv: null, tabWindowDivContent: null, initStyle: null, activeCssText: '',
	tabMenuShowArea: null,
	tabs: {}, tabWins: {}, tabWidth: 80, tabHeight: 18, tabCssText: '', activeTab: null, tabCnt: 12,
	subMenu: null, subMenuModeObj: null, subMenuId: 'TabWindowsSubMenu',
	defaultBgImg: 'tabBgline_off.gif', groupBgImg: {}, urlParam: '',
	globalWindowTitle: '',
	setPosition: function(tabMenuDiv, tabWindowDiv){
		var tabWindows = this;
		var tabDiv = this.tabMenuDiv = $E(tabMenuDiv || 'tabMenuDiv');
		var tabWinDiv = this.tabWindowDiv = $E(tabWindowDiv || 'tabWindowDiv');
		// this.tabWindowDivContent = tabWinDiv.innerHTML;
		tabDiv.ondragstart = tabDiv.onselectstart = function(){ return false; }
		this.tabWidth = Math.round( (El.offset(this.tabMenuDiv).width-24)/this.tabCnt );

		this.subMenuCreate();
		this.globalWindowTitle = Window.getGlobalParent().document.title;
	},
	setGroupBgImg: function(imgList){
		imgList = imgList.split(',');
		for(var i=0; i<imgList.length; i++) this.groupBgImg[i+1] = imgList[i].lTrim().rTrim();
	},
	activeStyle: function(obj, b){
		if(!obj) return false;
		if(!this.initStyle) this.initStyle = obj.style.cssText;
		var fontWeight = '';
		var bgimg = obj.style.backgroundImage;
		if(!bgimg) bgimg = 'url(tabBgline_off.gif)';
		var bgimg_old = bgimg;
		if(b){
			bgimg = bgimg.replace('_off', '_on');
			fontWeight = 'bold';
		}else{
			bgimg = bgimg.replace('_on', '_off');
		}
		if(bgimg_old != bgimg){
			if(!b){ obj.style.cssText = this.initStyle; return true; }
			obj.style.backgroundImage = bgimg;
			obj.style.fontWeight = fontWeight;
			Style.append(obj, this.activeCssText);
		}
		return true;
	},
	subMenuOn: function(obj){
		this.subMenuModeObj = $E(obj);
		var tabWindows = this;
		var subMenu = this.subMenu;
		var left = event.clientX + document.body.scrollLeft, top = event.clientY + document.body.scrollTop;

		subMenu.style.left = left;
		subMenu.style.top = top;

		Display.show(subMenu);
		El.focus(subMenu);

		return true;
	},
	subMenuCreate: function(){
		//var left = event.clientX + document.body.scrollLeft, top = event.clientY + document.body.scrollTop;
		var f1 = document.createElement('div');
		var f2 = document.createElement('div');
		var f3 = document.createElement('div');
		var f4 = document.createElement('div');
		var f5 = document.createElement('div');
		f1.style.cssText = f2.style.cssText = f3.style.cssText = f4.style.cssText = f5.style.cssText = 'font-size:9pt;color:#333333;cursor:pointer;padding:1 10 0 3;';

		f1.innerHTML = '닫기';
		f2.innerHTML = '이외 모두닫기';
		f3.innerHTML = '모두 닫기';
		f4.innerHTML = '새로고침';
		f5.innerHTML = '새창으로 열기';

		var dv = document.createElement('div');
		// dv.style.cssText =
		// 'position:absolute;left:'+left+';top:'+top+';border:black 1
		// solid;padding:2px;background:#ffffff;';
		dv.style.cssText = 'width:95;height:85;border:black 1 solid;padding:2px;background:#ffffff;';
		dv.appendChild(f1); dv.appendChild(f2); dv.appendChild(f3); dv.appendChild(f4); dv.appendChild(f5);

		var frm = "";
		frm += "<iframe id="+this.subMenuId+" frameborder=no scrolling=no style='width:95;height:85;position:absolute;z-index:10000;display:none;'></iframe>";
		document.write(frm);
		frm = $E(this.subMenuId);

		frm.onreadystatechange = function(){
			if(this.readyState!='complete') return false;
			var frm_doc = frm.contentWindow.document;
			frm_doc.body.leftMargin = frm_doc.body.topMargin = 0;
			frm_doc.body.innerHTML = dv.outerHTML;

			var els = frm_doc.getElementsByTagName('div')[0].childNodes;
			els[0].onclick = function(){
				TabWindows.removeTab();
				Display.hide(frm);
			}
			els[1].onclick = function(){
				TabWindows.removeTab(1);
				Display.hide(frm);
			}
			els[2].onclick = function(){
				TabWindows.removeTab(2);
				Display.hide(frm);
			}
			els[3].onclick = function(){
				TabWindows.reload();
				Display.hide(frm);
			}
			els[4].onclick = function(){
				TabWindows.newWindow();
				Display.hide(frm);
			}
			els[0].onmouseover = els[1].onmouseover = els[2].onmouseover = els[3].onmouseover = els[4].onmouseover = function(){
				Link.over(this, 'red', '#f5f5f5');
			}
		}
		frm.onblur = function(){ Display.hide(frm); }

		this.subMenu = frm;
		return frm;
	},
	resetTabs: function(obj){
		var tabs = this.tabs;
		var tabWins = this.tabWins;
		for(var key in tabs){
			if(obj && obj==tabs[key]) continue;
			this.activeStyle(tabs[key], false);
		}
		for(var key in tabWins){
			Display.hide( tabWins[key] );
		}
		return true;
	},
	selectTab: function(tab){
		if(typeof tab == 'string') tab = this.tabs[tab];
		this.resetTabs(tab);
		this.activeTab = tab;
		this.activeStyle(tab, true);
		try{
			Window.getGlobalParent().document.title = this.globalWindowTitle + ' / ' + tab.innerText.lTrim().rTrim();
		}catch(e){}
		Display.show(this.tabWins[tab.linkStr]);
		this.status(false);
		return true;
	},
	getMappingUrlParamObj: function(linkStr){
		var linkParam = '';
		var paramIdx = linkStr.indexOf('?');
		if(paramIdx!=-1){
			linkParam = linkStr.substring(paramIdx);
			linkStr = linkStr.substring(0, paramIdx);
	
			if(this.urlParam){
				linkParam = linkParam.substring(1).split('&');
				for(var i=0; i<linkParam.length; i++){
					var temp = linkParam[i];
					if(!temp || !temp.startWith(this.urlParam+'=')) continue;
					linkStr += '?' + temp;
					delete linkParam[i];
					linkParam = linkParam.join('&');
					break;
				}
				if(!linkParam.startWith('&')) linkParam = '&' + linkParam;
				if(linkParam.substring(linkParam.length-1) == '&') linkParam = linkParam.substring(0, linkParam.length-1);
			}
		}
		return { linkParam:linkParam, linkStr:linkStr }
	},
	createTab: function(tabTitle, linkStr, groupNo, refresh){
		if(this.getTabCnt() < 1){
			var tw = this.tabWindowDiv;
			var twd = document.createElement('div');
			while(tw.hasChildNodes()){
				twd.appendChild(tw.firstChild);
			}
			this.tabWindowDivContent = twd;
		}
	
		this.status(true);
		if(typeof tabTitle == 'object') tabTitle = tabTitle.innerText;

		var linkParam = '';
		if(typeof linkStr == 'object'){
			linkParam = linkStr.linkParam;
			linkStr = linkStr.linkStr;
		}
		else if(typeof linkStr == 'string'){
			var linkObj = this.getMappingUrlParamObj(linkStr);
			linkParam = linkObj.linkParam;
			linkStr = linkObj.linkStr;
		}

		var tabWindows = this;
		var tabs = this.tabs;
		var tabWins = this.tabWins;
		var tab = tabs[linkStr];
		var tabWin = tabWins[linkStr];

		/*
		 * //보류 if( tab && tab==this.activeTab ){ return true; } else
		 * this.resetTabs();
		 */

		if( tab ){
			this.selectTab(tab);
			if(refresh || linkParam!=tab.linkParam){
				tab.linkParam = linkParam;
				tabs[linkStr] = tab;
				return this.reload(tab);
			}
			return true;
		}

		this.resetTabs();

		var tabObj = document.createElement('div');
		tabObj.name = tabObj.uniqueID;
		tabObj.title = tabObj.innerText = tabTitle;
		tabObj.style.cssText = 'float:left;width:'+this.tabWidth+';height:'+this.tabHeight+';border:black 1 solid;padding:2 4 2 4;cursor:pointer;overflow:hidden;text-align:center;font-family:돋움,tahoma;font-size:8pt;';
		tabObj.style.backgroundColor = '#ffffff';// '#D3E5EF';
		var tabCssText = this.tabCssText;
		Style.append(tabObj, tabCssText);

		var bgimg = this.groupBgImg[groupNo] || this.defaultBgImg;
		tabObj.style.backgroundImage = 'url('+ bgimg + ')';

		tabObj.onmouseover = function(){ tabWindows.subMenuModeObj = this; }
		tabObj.onmousedown = function(){
			//tabWindows.createTab(tabTitle, linkStr, groupNo);
			if(event.button==4) return TabWindows.removeTab(0, tabObj);
			tabWindows.selectTab(linkStr);
			Locate.rull = function(){
				var arg = arguments[0];
				var tmd = tabWindows.tabMenuDiv;
				if( tmd!=arg && tmd.contains(arg) ){ return true; }
				return false;
			}
		}
		tabObj.onselectstart = function(){
			MoveEl.setEl(this, false);
			return false;
		}
		Locate.end = function(){
			var tmd = tabWindows.tabMenuDiv;
			var arg = arguments[0];
			var el = Locate.el;
			if(!el || el.length==0) return false;

			var els = Locate.els;
			var e = el[0];
			e.style.cssText = Locate.els[e.uniqueID].cssText;

			if(arg.offsetLeft < e.offsetLeft){
				e = e.nextSibling;
			}

			try{ tmd.insertBefore(arg, e); }catch(e){}
		}

		tabObj.onclick = function(){ tabWindows.selectTab(linkStr);	}
		tabObj.oncontextmenu = function(){
			tabWindows.subMenuOn(this);
			return false;
		}

		this.activeStyle(tabObj, true);
		this.tabMenuDiv.appendChild( tabObj );

		var rect = El.rect(this.tabWindowDiv);
		var tabWinObj = document.createElement('iframe');
		tabWinObj.frameBorder = 'no';
		tabWinObj.scrolling = 'no';
		tabWinObj.style.cssText = 'width:'+(rect.right-rect.left)+';height:'+(rect.bottom-rect.top)+';';
		tabWinObj.src = linkStr + linkParam;
		this.tabWindowDiv.appendChild( tabWinObj );
		tabWinObj.onreadystatechange = function(){
			tabWindows.status(true);
			if(this.readyState!='complete') return false;
			tabWindows.status(false);
			try{
				var tabWinObj_doc = tabWinObj.contentWindow.document;
				EventHandler.add(tabWinObj_doc, 'onclick', function(){ PopMenu.hideAll(); });
			}catch(e){}
		}

		this.selectTab(tabObj);
		tabs[ linkStr ] = tabObj;
		tabObj.linkStr = linkStr;
		tabObj.linkParam = linkParam;
		tabWins[ linkStr ] = tabWinObj;
		return true;
	},
	removeTab: function(n, obj){
		try{
			if(!obj) obj = this.subMenuModeObj;
			var tabs = this.tabs;
			var tabWins = this.tabWins;
			for(var key in tabs){
				var v = tabs[key];
				if( (!n || n==0) && v==obj ){
					var nobj = v.nextSibling || v.previousSibling;
					if(obj==this.activeTab && nobj) nobj.click();
					// v.removeNode(true);
					El.remove(v);
					El.remove(tabWins[key]);
					tabs[key] = tabWins[key] = null;
	
					return true;
				}else if( n==1 && v!=obj ){
					try{ El.remove(v); }catch(e){}
					try{ El.remove(tabWins[key]); }catch(e){}
					tabs[key] = tabWins[key] = null;
				}else if( n==2 ){
					try{ El.remove(v); }catch(e){}
					try{ El.remove(tabWins[key]); }catch(e){}
					tabs[key] = tabWins[key] = null;
				}
			}
			if(n==1) obj.click();
		}catch(EE){
		}finally{
			if(this.getTabCnt() < 1){
				var tw = this.tabWindowDiv;
				var twd = this.tabWindowDivContent;
				if(twd){
					while(twd.hasChildNodes()){
						tw.appendChild(twd.firstChild);
					}
					this.tabWindowDivContent = null;
				}
			}
		}
	},
	status: function(mode){
		this.loading(mode);
		if(mode) window.status = 'TabWindow 구동중..';
		else{
			if(this.activeTab){
				var param = location.search;
				var idx = param.indexOf('#');
				if(idx==-1) idx = param.length;
				param = param.substring(0, idx);
				var focusUrl = location.pathname+param+'#'+this.activeTab.uniqueID;

				if((location.pathname+location.hash) != focusUrl){
					var tms = $E(this.tabMenuShowArea);
					if(
						tms
						&&
						tms.scrollLeft <= this.activeTab.offsetLeft
						&&
						(tms.scrollLeft+tms.offsetWidth) >= (this.activeTab.offsetLeft+this.activeTab.offsetWidth)
					){
					}else{
						var doc = document;
						var temp = { top:doc.body.scrollTop, left:doc.body.scrollLeft };
						location.href = focusUrl;
						try{
							doc.body.scrollTop = temp.top;
							doc.body.scrollLeft = temp.left;
						}catch(e){window.status=e.description;}
					}
				}
			}
			window.status = '완료';
		}
	},
	loadingDiv: null,
	loading: function(mode){
		var ld = this.loadingDiv;
		if(mode){
			var twd = this.tabWindowDiv;
			var rt = El.rect(twd);
			var width = 350;
			var height = 35;
			var x = Math.round((rt.right-rt.left)/2) - (width/2);
			var y = Math.round((rt.bottom-rt.top)/2) - (height/2);
			// alert((rt.left) + '/' + (rt.top) + '\n' + x + '/' + y);
			if(!ld){
				ld = document.createElement('div');
				ld.style.cssText = 'position:absolute;width:'+width+';height:'+height+';border:#cccccc 1 solid;background:#f5f5f5;display:none;text-align:center;padding-top:10px;z-index:5;';
				ld.innerHTML = '프로그램이 구동중입니다. 잠시만 기다려주세요..';
				document.body.appendChild(ld);
				this.loadingDiv = ld;
			}
			ld.style.left = x;
			ld.style.top = y;
			Display.show(ld);
		}else{
			Display.hide(ld);
		}
	},
	moveTab: function(n){
		if(!n) n = 1;
		var m = n>0 ? 1 : -1;
		var b = true;
		var obj = this.activeTab;
		for(var i=0; b; i+=m){
			var reObj = obj;
			if(n > 0){
				b = (i < n);
				if(!b) break;
				try{obj = obj.nextSibling;}catch(e){ obj = reObj; break; }
			}else{
				b = (i > n);
				if(!b) break;
				try{obj = obj.previousSibling;}catch(e){ obj = reObj; break; }
			}
			if(!obj){ obj = reObj; break; }
		}
		if(obj && obj!=this.activeTab) obj.click();
	},
	reload: function(obj, onlyHost){
		obj = $E(obj);
		if(!obj) obj = this.activeTab;
		if(!obj) return false;
		var tabWin = this.tabWins[obj.linkStr];
		if(!tabWin) return false;
		tabWin.src = obj.linkStr + (onlyHost?'':obj.linkParam);
		return obj;
	},
	newWindow: function(obj){
		obj = $E(obj);
		if(!obj) obj = this.activeTab;
		if(!obj) return false;
		var wname = (obj.linkStr).replaceAll('.','').replaceAll('/','').replaceAll('?','').replaceAll('=','');
		var win = window.open(obj.linkStr+obj.linkParam, wname);
		try{
			win.focus();
		}catch(e){alert(e);}
	}
	,getTabCnt: function(){
		var tabs = this.tabs;
		var cnt = 0;
		for(var key in tabs){
			if(!tabs[key]) continue;
			cnt++;
		}
		return cnt;
	}
}
TabWindows.viewTabs = {
	btnObj: null, div: null, frm: null,
	create: function(obj){
		obj = $E(obj);
		if(!obj) obj = this.btnObj;
		if(!obj) obj = event.srcElement;
		this.btnObj = obj;
		var tabWindows = TabWindows;
		var rt = El.rect(obj);
		var dv = this.div;
		var frm = this.frm;
		if(!dv){
			dv = document.createElement('div');
			dv.style.cssText = 'position:absolute;border:#666666 1 solid;padding:10px;background:#ffffff;display:none;';
			document.body.appendChild(dv);
			this.div = dv;
		}
		if(!dv){
			alert('viewTabs div 생성실패.');
			return false;
		}
		if(!frm){
			frm = document.createElement('iframe');
			frm.frameBorder = 'no'; frm.scrolling = 'no';
			frm.style.cssText = 'display:none;position:absolute;';
			document.body.appendChild(frm);
			this.frm = frm;
		}

		if(frm.style.display != 'none'){
			//Display.hide(frm);
			// return false;
		}

		dv.innerHTML = '<div style="padding:0 2 5 2;font-size:9pt;"><b>[사용중인 탭]</b></div>';
		var tabs = tabWindows.tabs;
		var cnt = 0;
		for(var key in tabs){
			var tab = tabs[key];
			if(!tab) continue;
			var t = document.createElement('div');
			var t_src = [];
			t_src.push( "<div onmouseover='parent.Link.over(this, \"#ffffff\", \"#555555\");'" );
			t_src.push( " onclick='parent.TabWindows.selectTab(\""+key+"\");parent.TabWindows.viewTabs.create();'" );
			t_src.push( " style='cursor:pointer;overflow:hidden;font-size:9pt;padding:1;" + (tabWindows.activeTab==tab?"font-weight:bold;":"") + "'" );
			t_src.push( ">"+tab.title+"</div>" );
			t.innerHTML = t_src.join('');
			dv.appendChild( t );
			cnt++;
		}
		if(cnt==0) return false;

		Display.show(dv);
		var dv_rt = El.rect(dv);
		dv.style.width = dv_rt.width;
		dv.style.height = dv_rt.height;
		var dv_ot = dv.outerHTML;
		Display.hide(dv);

		var frm_doc = frm.contentWindow.document;
		frm.onreadystatechange = function(){
			if(this.readyState!='complete') return false;
			var ss = document.styleSheets;
			try{
				for(var i=0; i<ss.length; i++){
					//frm_doc.createElement('style');
					frm_doc.appendChild(frm_doc.createElement('style'));
					frm_doc.styleSheets[frm_doc.styleSheets.length-1].cssText = ss[i].cssText;
				}
			}catch(e){alert('Tabwindows viewTabs css 적용 오류\n' + e.description);}
			with(frm_doc.body){
				leftMargin = topMargin = 0;
				style.marginLeft = style.marginTop = style.marginRight = style.marginBottom = 0;
				innerHTML = dv_ot;
			}
		}
		try{
			frm_doc.body.leftMargin = frm_doc.body.topMargin = 0;
			frm_doc.body.innerHTML = dv_ot;
		}catch(e){}
		frm.onblur = function(){ Display.hide(frm); }
		frm.style.width = dv_rt.width;
		frm.style.height = dv_rt.height;
		frm.style.left = rt.right - dv_rt.width + 1 + document.body.scrollLeft;
		frm.style.top = rt.bottom + document.body.scrollTop;
		Display.show(frm);
		El.focus(frm);
		return true;
	},
	hide: function(){
		Display.hide(this.frm);
	}
}
//-- TabWindows  E ---------------------


// -- MainWindow S ---------------------
// TabWindows minimum 임시버전.
var MainWindow = {
	curWindow: window
	,menuBtnLoc: '', menuFrmLoc: '', bindObj: '', menuFrmLocInnerHTML: ''
	,menuObjs: {}
	,menuCnt: 0
	,globalTitle: ''
	,set: function(param){
		ObjectUtil.append(MainWindow, param);
		this.globalTitle = document.title;
		this.menuFrmLocInnerHTML = $E(this.menuFrmLoc).innerHTML;
	}
	,activeMenu: null
	,menuFrmLocSet: function(createMode){
		if(this.menuCnt != 0) return;
		if(createMode){
			$E(this.menuFrmLoc).innerHTML = '';
		}else{
			$E(this.menuFrmLoc).innerHTML = this.menuFrmLocInnerHTML;
			this.activeMenu = null;
		}
	}
	,create: function(objStr, url){
		obj = $E(objStr);
		var title, url;
		if(obj!=null && El.isObject(obj)){
			var tn = obj.tagName.toLowerCase();
			if(tn=='select'){
				var opt = obj.options[obj.selectedIndex];
				title=opt.text; url=opt.value;
			}else{
				title = obj.innerHTML;
			}
		}else if(El.isString(objStr)){
			title = objStr;
		}
		this.menuFrmLocSet(true);
		var btn = this.createBtn(title||'', url);
		this.setActive(btn);
	}
	,createBtn: function(title, url){
		if(!title || !url) return;
		var mObj = this.menuObjs;
		var btn = mObj[url];
		if(btn){
			return btn;
		}
		var btn = document.createElement('span');
		btn.style.cssText = 'padding:2 3 1 3;border:1 solid #555555;cursor:pointer;width:100;text-align:center;';
		btn.onmouseover = function(){ Link.over(this, '#ffffff', '#000000'); }
		btn.onclick = function(){ MainWindow.setActive(this); }
		btn.title = title;
		btn.url = url;

		var tObj = document.createElement("<font style='padding-top:1;padding-right:2;'>");
		tObj.innerHTML = title;
		btn.appendChild(tObj);
		/*
		 * var cBtn = document.createElement("<img src='img/btn/btn_close.gif'
		 * align=absmiddle style='cursor:pointer;'>"); cBtn.onclick =
		 * function(){ MainWindow.closeWindow(btn); } btn.appendChild(cBtn);
		 */

		this.createWindow(btn);

		var mbLoc = $E(this.menuBtnLoc);
		if(mbLoc) mbLoc.appendChild(btn);
		mObj[url] = btn;
		this.menuObjs = mObj;
		return btn;
	}
	,createWindow: function(btn){
		var frm = document.createElement('iframe');
		frm.frameBorder = frm.scrolling = 'no';
		frm.width = frm.height = '100%';
		frm.src = btn.url;
		$E(this.menuFrmLoc).appendChild(frm);

		btn.frm = frm;
		btn.no = ++this.menuCnt;
		return btn;
	}
	,setActive: function(btn){
		if(!btn) return;
		var mObj = this.menuObjs;
		var url = btn.url;
		Field.setValue(this.bindObj, btn.url);
		for(var key in mObj){
			var obj = mObj[key];
			if(!obj) continue;
			Display.hide(obj.frm);
		}
		Display.show(btn.frm);
		El.focus(btn.frm);

		var bfActiveMenu = this.activeMenu;
		if(bfActiveMenu) bfActiveMenu.wTitle = document.title;
		if(btn.wTitle) document.title = btn.wTitle;
		else{
			var gt = this.globalTitle;
			btn.frm.onreadystatechange = function(){
				if(this.readyState!='complete') return false;
				document.title = gt + ' / ' + btn.frm.contentWindow.document.title;
				try{
					btn.frm.contentWindow.TabWindows.globalWindowTitle = document.title;
				}catch(e){}
			}
		}
		this.activeMenu = btn;

	}
	,closeWindow: function(btn, n){
		var no = btn.no;
		if(!n || n==0){
			this.menuObjs[btn.url] = null;
			El.remove(btn.frm);
			El.remove(btn);
			var mObj = this.menuObjs;
			var chkObj, chkKey;
			for(var key in mObj){
				var obj = mObj[key];
				if(!obj) continue;
				chkKey = key;
				if(obj.no < n) continue;
				if(obj.no == n) chkObj = obj;
				obj.no--;
			}
			this.setActive(chkObj || mObj[chkKey]);
		}
		this.menuCnt--;
		this.menuFrmLocSet();
	}
}
//-- MainWindow  E ---------------------




// -- Function S -----------------------
Function.prototype.getName = function(){
	var src = this.toString();
	var fn = 'function';
	var name = src.substring(src.indexOf(fn)+fn.length, src.indexOf('('));
	return name.lTrim().rTrim();
}
Function.prototype.toSourceStr = function(){
	var src = this.toString();
	src = src.substring(src.indexOf('{')+1, src.lastIndexOf('}'));
	return src;
}

var FunctionHandler = {
	add: function(obj, targetFuncStr, addFunc, args){
		if(!obj){
			alert('FunctionHandler 대상 객체가 없음');
			return false;
		}
		var targetFunc = obj[targetFuncStr];
		if(targetFunc) targetFunc = targetFunc.toSourceStr();
		else targetFunc = '';

		var type = typeof addFunc;
		if(type=='function'){
			var fn = addFunc.getName();
			if(!fn || fn.trim().length==0 || fn == 'anonymous'){
				var fn = El.undefinedId();
				eval(fn + ' = addFunc');
			}
			targetFunc += fn + '('+ (args||'') +')';
		}else if(type=='string'){
			targetFunc += '\n' + addFunc;
		}else{
			return false;
		}
		var innerFunc = new Function(targetFunc);
		obj[targetFuncStr] = innerFunc;
		return obj;
	}
	,sourceStr: function(obj){
		var str = obj.toString().split('\n');
		str.shift();
		str.pop();
		return str.join('\n');
	}
}
//-- Function  E -----------------------

// -- Style S --------------------------
var Style = {
	append: function(obj, cssText){
		obj = $E(obj);
		if(!obj) return null;
		if(!cssText) return obj;
		cssText = cssText.split(';');
		for(var i=0; i<cssText.length; i++){
			var st = cssText[i].lTrim().rTrim();
			st = st.split(':');
			try{
				var param = st[0];
				if(!param) continue;
				var status = st[1];
				var cn = param.indexOf('-');
				if(cn!=-1){
					var ch = param.substring(cn+1, cn+2);
					param = param.replace('-'+ch, ch.toUpperCase());
				}
				obj.style[param] = status;
			}catch(e){alert(e.description + '\n' + param + '/' + status);}
		}
		return obj;
	}
	,documentAppend: function(doc1, doc2){
		if(doc1.nodeName!='#document' || doc2.nodeName!='#document'){
			alert('잘못된 document 객체.');
			return;
		}
		var ss = doc1.styleSheets;
		var ss_target = doc2.styleSheets;
		try{
			t:for(var i=0; i<ss.length; i++){
				var sss = ss[i];
				var ttt = sss.cssText;
				if(ttt.length < 1) continue;
				for(var j=0; j<ss_target.length; j++){
					if(ss_target[j].cssText==ttt){ continue t; }
				}
				doc2.appendChild(doc2.createElement('style'));
				doc2.styleSheets[doc2.styleSheets.length-1].cssText = ttt;
			}
		}catch(e){alert('Style documentAppend Error\n' + e.description);}
	}
}
//-- Style  E --------------------------

// -- IFrame S --------------------------
var IFrame = Class.create();
IFrame.prototype = {
	id:null , name:null, cssText:'' ,src:'' ,onload:null ,doc:null ,win:null ,frm:null
	,init: function(id, cssText, property, src){
		id = id.split(';');
		this.id = id[0];
		try{ this.name=id[1]; }catch(e){ this.name=id[0]; }
		this.cssText = cssText;
		this.src = src;

		var frm = $E(this.id);
		if(!frm) frm = document.createElement('iframe');
		else this.complete = true;

		frm.id = this.id;
		frm.name = this.name;
		frm.frameBorder = 'no';
		frm.scrolling = 'no';
		frm.style.cssText = cssText;
		try{
			property = property.split(';');
			for(var i=0; i<property.length; i++){
				var pp = property[i].split(':');
				frm[ pp[0] ] = pp[1];
			}
		}catch(e){}
		if(src) frm.src = src;
		if(!frm.style.width) frm.style.width = 1;
		if(!frm.style.height) frm.style.height = 1;
		Display.hide(frm);

		document.body.appendChild(frm);
		var doc = this.doc = frm.contentWindow.document;
		var win = this.win = frm.contentWindow.window;

		this.frm = frm;
	}
	,complete:false
	,create: function(extend){
		if(extend==null) extend = true;
		var IFrame = this;
		var frm = this.frm;
		var doc = this.doc;
		var win = this.win;
		var onload = this.onload;

		try{
			if(this.complete){
				if(onload && (typeof onload=='function')){
					try{ onload(doc, win); }catch(e){alert(e.description);}
					IFrame.autoFitSize(true);
				}
			}else{
				frm.onreadystatechange = function(){
					if(this.readyState!='complete') return false;
					if( doc == frm.contentWindow.document ){
						doc.body.leftMargin = doc.body.topMargin = doc.body.rightMargin = doc.body.bottomMargin = 0;
						if(extend){
							IFrame.setStyleSheets(document, doc);
						}
						if(onload && (typeof onload=='function')){
							try{ onload(doc, win); }catch(e){alert('IFrame onload\n'+e.description);}
						}
					}
					IFrame.autoFitSize();
				}
			}
		}catch(e){alert('IFrame create\n'+e.description)}

		//Display.show(frm);
		try{ if(parent.document.hasFocus() && Display.isShow(frm)) frm.focus(); }catch(e){}
		this.complete = true;
		return frm;
	}
	,autoFitSize: function(act){
		var frm = this.frm;
		// var win = this.win;
		// var doc = this.doc;
		var win = frm.contentWindow.window;
		var doc = frm.contentWindow.document;

		if(!act && (frm.style.width!='1px' || frm.style.height!='1px')) return false;
		var n = 0;
		while(n++ < 3){
			try{
				win.self.resizeTo(doc.body.scrollWidth, doc.body.scrollHeight);
				break;
			}catch(e){}
		}
		return true;
	}
	,setStyleSheets: function(doc, doc_target){
		var ss = doc.styleSheets;
		var ss_target = doc_target.styleSheets;
		try{
			t:for(var i=0, cnt=ss.length; i<cnt; ++i){
				var sss = ss[i];
				var ttt = sss.cssText;
				/*
				 * 자원소모가 큼 if(ttt.length < 1) continue; for(var j=0,
				 * cnt_t=ss_target.length; j<cnt_t; ++j){
				 * if(ss_target[j].cssText==ttt){ continue t; } }
				 */
				doc_target.appendChild(doc_target.createElement('style'));
				doc_target.styleSheets[doc_target.styleSheets.length-1].cssText = ttt;
			}
		}catch(e){alert('IFrame styleSheet 적용 오류\n' + e.description);}
	}
	,remove: function(){
		var frm = this.frm;
		if(frm) El.remove(frm);
	}
	,hide: function(){
		Display.hide(this.frm);
	}
}
//-- IFrame E --------------------------

// 차후 이상요인 가능.
var Calc = {
	math: function(){
		var str = '';
		for(var i=0; i<arguments.length; ++i){
			str += String(arguments[i]);
		}
		str = str.trimAll();

		var len = str.length;
		var c = '', s = '';
		var n1 = '', n2 = '';
		var result = 0;
		for(var i=0; i<len; ++i){
			c = str.charAt(i);

			// if(c=='*'||c=='/'||c=='%'||c=='+'||c=='-'){
			if((/[\-||\+||\*||\/||\%]/g).test(c)){
				s = c;
				n2 = '';
				t:while(i++<len){
					c = str.charAt(i);
					if(i==len-1 || (isNaN(c)&&c!='.')){
						if(i==len-1) n2 += c;
						if(s=='*')  result = this.multiply(n1, n2);
						else if(s=='/') result = this.devide(n1, n2);
						else if(s=='%') result = this.mod(n1, n2);
						else{
							result = eval(n1 + s + n2);
						}
						n1 = result;
						i--;
						break t;
					}else n2 += c;
				}

			}else if(c=='('){
				var j = str.indexOf(')', i);
				n1 = result = this.math( str.substring(i+1, j) );
				i = j;
			}else{
				if( !isNaN(c)||c=='.' ) n1 += c;
			}
		}
		return result;
	},
	multiply: function(){
		var obj = this.changeObj(arguments);
		var args = obj.args;
		var t = obj.t;
		var result = 0;
		for(var i=0; i<args.length; i++){
			if(i==0){
				result = args[i];
				continue;
			}
			t = t * t;
			result = result * args[i];
		}

		return (result/t);
	},
	devide: function(){
		var obj = this.changeObj(arguments);
		var args = obj.args;
		var t = obj.t;
		var reulst = 0;
		for(var i=0; i<args.length; i++){
			if(i==0){
				result = args[i];
				continue;
			}
			t = t * t;
			result = result / args[i];
		}
		return result;
	},
	mod: function(){
		var obj = this.changeObj(arguments);
		var args = obj.args;
		var t = obj.t;
		var result = 0;
		for(var i=0; i<args.length; i++){
			if(i==0){
				result = args[i];
				continue;
			}
			t = t * t;
			result = result % args[i];
		}
		return (result/t);
	},
	floor: function(num, dec){
		if(!dec) dec = 0;
		else dec++;
		num = String(num);
		var idx = num.indexOf('.');
		if(idx!=-1) num = num.substring(0, idx+dec);
		return parseFloat( num );
	},
	round: function(num, dec){
		if(!dec) dec = 0;
		num = parseFloat( this.floor(num, dec+1) );

		var t = 10;
		while(dec > 1){
			t = t*10;
			dec--;
		}

		num = this.multiply(num, t);

		var dot = String(num).indexOf('.');
		if(dot!=-1){
			var n = String(num).substring(dot+1);
			num = parseInt( String(num).substring(0, dot) );
			if(n >= 5) num += 1;
		}

		return ( num/t );
	},
	changeObj: function(obj){
		var args = obj;
		var len1 = 0, len2 = 0;
		for(var i=0; i<args.length; i++){
			var num = String(args[i]);
			try{
				var idx = num.indexOf('.');
				if(idx==-1) num = '';
				else num = num.substring(num.indexOf('.')+1);
				len2 = num.length;
				if(len2 > len1) len1 = len2;
			}catch(e){ continue; }
		}

		var t = 1;
		len2 = len1;
		while(len2 > 0){
			t = t * 10;
			len2--;
		}

		//for(var i=0; i<args.length; i++){ args[i] = args[i] * t; }

		for(var i=0; i<args.length; i++){
			var num = String(args[i]);
			var num2 = '';
			try{
				var idx = num.indexOf('.');
				if(idx==-1) num1 = '';
				else num2 = num.substring(idx+1);
			}catch(e){ alert(e.description); }
			var n = len1 - num2.length;
			while(n > 0){
				num += '0';
				n--;
			}
			args[i] = parseInt(num.replace('.', ''));
		}

		return {args:args, t:t}
	}
}

//미완
var SelectObj = {
	sObjs: {}
	,create: function(key, idStr, selectedStyle){
		var objs = idStr.trim().split(',');
		for(var i=0; i<objs.length; i++){
			var obj = $E(objs[i]);
			objs[i] = obj;
			obj.oriCssText = obj.style.cssText;
			var func = function(){SelectObj.select(key, this)};
			if(obj.onmousedown) EventHandler.add(obj, 'onclick', func);
			else obj.onmousedown = func;
		}
		this.sObjs[key] = objs;
		this.sObjs[key].selectedStyle = selectedStyle;
	}
	,select: function(key, obj){
		var objs = this.sObjs[key];
		for(var i=0; i<objs.length; i++){
			var temp = objs[i];
			temp.style.cssText = temp.oriCssText;
		}
		obj.style.cssText = objs.selectedStyle;
	}
}

/*------------------------------------------------------------
 * SelectInput - SelectBox 와 Input 을 결합한 객체.
 * 생성 : SelectInput.create(아이디, '첫째:1;둘째:2;셋째:3:checked;', style, property);
 * 값 : 객체.value or $F(객체).
 * 값 강제 셋팅 : SelectInput.setValue(객체, 값);
------------------------------------------------------------*/
var SelectInput = {
	irObjs: {}, btnImg: 'img/radio_show.gif', currObj: null
	, act: false
	, itemFrmID: '_itemFrm'
	, create: function(idStr, items, styleStr, propStr){
		if($E(idStr) || this.irObjs[idStr]){
			alert(idStr + ' 객체가 이미 존재합니다.');
			return false;
		}

		document.write("<span id='"+idStr+"' style='height:0;font-size:0pt;'>null</span>");
		obj = $E(idStr);
		obj.innerHTML = '';

		var inp = document.createElement('input');
		var btn = document.createElement('img');

		obj.appendChild(inp);
		obj.appendChild(btn);

		// obj.id = '';
		// inp.id = idStr;
		inp.style.cssText = 'height:18;';
		Style.append(inp, styleStr);
		inp.onfocus = function(){
			//SelectInput.showItemList(obj);
		}
		inp.onclick = function(){
			//if(!obj.disabled) inp.disabled = false;
			// SelectInput.showItemList(obj);
		}
		inp.onkeyup = function(){
			//보류
			// SelectInput.keyup(obj);
		}
		inp.onkeydown = function(){
			SelectInput.keydown(obj);
		}
		inp.onchange = function(){
			SelectInput.chkValue(obj);
		}
		inp.onblur = function(){
			if(SelectInput.act) return;
			SelectInput.closeItemList(obj);
			SelectInput.chkValue(obj);
		}
		inp.cssText = inp.style.cssText;
		btn.src = this.btnImg;
		btn.align = 'absmiddle';
		btn.style.cssText = 'cursor:default';
		btn.onclick = function(){
			SelectInput.showItemList(obj);
			// SelectInput.chkValue(obj);
		}

		obj.inp = inp;
		obj.btn = btn;
		this.irObjs[idStr] = this.currObj = obj;

		if(!items || items.trim().length==0){
			inp.disabled = true;
			return inp;
		}

		this.createItems(obj, items);

		return obj;
	}
	, createItems: function(obj, items){
		if(!obj) obj = this.currObj;
		var itemFrm = [];
		var itemObj = [];
		var names = [];
		var itemFrmID = obj.inp.id+this.itemFrmID;
		var selectIndex = 0;
		itemFrm.push('<iframe style="position:absolute;" frameborder=no scrolling=no id=');
		itemFrm.push(itemFrmID);
		itemFrm.push('></iframe>');

		itemObj.push('<table border=0 cellspacing=0 cellpadding=0');
		itemObj.push(' ondragstart="return false;" onselectstart="return false;"');
		itemObj.push(' onmouseover="parent.SelectInput.act=true;"');
		itemObj.push(' onmouseout="parent.SelectInput.act=false;"');
		itemObj.push(' style="padding:2px;border:#666666 1 solid;background:#ffffff;">');
		itemObj.push('<tr><td>');
		items = items.split(';');
		var maxLen = 0;
		for(var i=0, cnt=items.length; i<cnt; i++){
			var item = items[i].split(':');
			items[i] = item;
			if(!item[0]) continue;

			for(var j=0; j<item.length; j++) item[j] = item[j].lTrim().rTrim();

			var name = item[0];
			var value = item[1];
			names.push(name);
			if(name.length > maxLen) maxLen = name.length;

			itemObj.push("<div style='' value='");
			itemObj.push(value || name);
			itemObj.push("' onclick='parent.SelectInput.setValue(\""+obj.id+"\", \""+name+"\", \""+value+"\", "+i+");parent.SelectInput.closeItemList(\""+obj.id+"\");parent.SelectInput.chkValue(\""+obj.id+"\");parent.El.focus(parent.$E(\""+obj.id+"\").inp);'");
			itemObj.push(" onmouseover='parent.Link.over(this, \"blue\", \"#f5f5f5\");'>");
			itemObj.push(name);
			itemObj.push("</div>");

			if(i==0 || item[2]=='checked'){
				selectIndex = i;
				this.setValue( obj, name, value, i );
			}
		}
		itemObj.push('</td></tr></table>');
		itemObj = itemObj.join('');

		document.write(itemFrm.join(''));
		itemFrm = $E(itemFrmID);

		itemFrm.onreadystatechange = function(){
			if(this.readyState!='complete') return false;
			var doc = itemFrm.contentWindow.document;
			doc.body.leftMargin = doc.body.topMargin = 0;
			(new IFrame('tempFrm')).setStyleSheets(document, doc);
			doc.body.innerHTML = itemObj;

			Display.show(itemFrm);
			var rt = El.rect(doc.body.firstChild);
			Display.hide(itemFrm);
			itemFrm.style.width = rt.width;
			itemFrm.style.height = rt.height;

			SelectInput.setSelectIndex( obj, selectIndex );
		}

		var os = El.offset(obj);
		if( El.offset(itemFrm).width < os.width ){
			itemFrm.style.width = os.width;
		}
		Display.hide(itemFrm);
		obj.itemFrm = itemFrm;
		obj.itemRestore = function(){
			itemFrm.contentWindow.document.body.innerHTML = itemObj;
		}
		obj.names = names;
		obj.items = items;
		obj.inp.maxLength = maxLen;

	}
	, showItemList: function(obj, show){
		obj = $E(obj);
		var itemFrm = obj.itemFrm;
		if(show!=true && itemFrm.style.display!='none'){
			Display.hide(itemFrm);
			return;
		}
		El.focus(obj.inp);
		var os = El.offset(obj);
		itemFrm.style.left = os.left;
		itemFrm.style.top = os.bottom;
		Display.show(itemFrm);

	}
	, closeItemList: function(obj){
		Display.hide($E(obj).itemFrm);
		this.act = false;
	}
	, setValue: function(obj, name, value, selectIndex){
		obj = $E(obj);
		obj.value = value||name;
		Field.setValue(obj.inp, name);
		if(selectIndex==null){
			var v = obj.value;
			var items = obj.items;

			for(var i=0,cnt=items.length; i<cnt; i++){
				var item = items[i];
				var iv = item[1]||item[0];
				if(iv!=v) continue;
				selectIndex = i;
				break;
			}
		}
		this.setSelectIndex(obj, selectIndex);
	}
	, setSelectIndex: function(obj, selectIndex){
		obj = $E(obj);
		obj.selectIndex = selectIndex;
		try{
			obj.itemRestore();
			var itemObj = obj.itemFrm.contentWindow.document.getElementsByTagName('div')[selectIndex];
		}catch(e){return;}
		itemObj.style.color = 'blue';
		itemObj.style.backgroundColor = '#f5f5f5';
	}
	, chkAct: false
	, chkValue: function(obj){
		if(this.chkAct) return;
		this.chkAct = true;
		obj = $E(obj);
		var inp = obj.inp;
		var v = inp.value;
		var items = obj.items;
		var chk = false;
		for(var i=0, cnt=items.length; i<cnt; i++){
			var item = items[i];
			if(item[0] != v) continue;
			this.setValue(obj, item[0], item[1], i);
			chk = true;
			break;
		}
		//inp.disabled = !chk;
		if(chk){
			inp.style.cssText = inp.cssText;
		}else{
			inp.style.color = '#ffffff';
			inp.style.backgroundColor = '#444444';
			obj.value = '';
			this.closeItemList(obj);
		}
		this.chkAct = false;
	}
	, keyup: function(obj){
		obj = $E(obj);
		var v = obj.inp.value;
		var itemFrm = obj.itemFrm;
		var itemObjs = itemFrm.getElementsByTagName('div');
		var itemObjsLen = itemObjs.length;
		var items = obj.items;
		for(var i=0, cnt=items.length; i<cnt; i++){
			var item = items[i];
			var name = item[0];

			if(name.indexOf(v)!=0){
				Display.hide(itemObjs[i]);
				continue;
			}
			var temp = '<font style="color:red;">'+v+'</font>';
			itemObjs[i].innerHTML = name.replace(v, temp);
		}
	}
	, keydown: function(obj){
		obj = $E(obj);
		var itemFrm = obj.itemFrm;
		var items = itemFrm.contentWindow.document.getElementsByTagName('div');
		var itemsLen = items.length-1;
		var si = obj.selectIndex;
		if(si==null) si = -1;

		var kc = event.keyCode;
		if(kc==13) items[si].click();
		else if(kc==27) this.closeItemList(obj);

		if(kc!=38 && kc!=40) return false;
		if(kc==38) si--;
		else if(kc==40) si++;

		if(si==-1) si = itemsLen;
		else if(si > itemsLen) si = 0;

		var itemObj = items[si];
		if(itemObj.style.display == 'none') this.keydown(obj);
		
		this.showItemList(obj, true);
		this.setValue(obj, obj.items[si][0], obj.items[si][1], si);
	}
}

/*------------------------------------------------------------
 * SWF - swf 오브젝트 소스생성 or 생성
 * 생성 : SWF.write( {id:아이디, style:StyleStr, param:ParametersStr(:;구분)} );
 ------------------------------------------------------------*/
var SWF = {
	classid: 'clsid:D27CDB6E-AE6D-11cf-96B8-444553540000'
	,getSource: function(pObj){
		var objStr = [];
		var paramStr = '<param name=/name/ value="/value/">';

		objStr.push('<object id='+pObj.id+' classid="'+this.classid+'"');
		objStr.push('	codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" ');
		objStr.push('	style="'+(pObj.style||'')+'">');
		objStr.push('	<param name=movie value="'+pObj.src+'">');
		objStr.push('	<param name=quality value=high>');
		objStr.push('	<param name=bgcolor value=#FFFFFF>');

		if(pObj.param && pObj.param.trim().length!=0){
			var paramList = pObj.param.split(';');
			for(var i=0; i<paramList.length; i++){
				var pr = paramList[i].lTrim().rTrim().split(':');
				try{
					objStr.push( paramStr.replace('/name/', pr[0]).replace('/value/', pr[1]) );
				}catch(e){}
			}
		}

		objStr.push('	<embed src="'+pObj.src+'" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" style="'+pObj.style+'"></embed>');
		objStr.push('</object>');

		return objStr.join('');
	}
	,write: function(pObj){
		document.write(this.getSource(pObj));
	}
}

var DateUtil = {
	today: ''
	,setToday: function(today){
		this.today = today;
	}
	,getToday: function(){
		if(!this.today){
			var d = new Date();
			var y = d.getYear();
			var m = d.getMonth()+1;
			var d = d.getDate();
			// if(m<10) m = '0'+m;
			m = String(m).lpad(2, '0');
			d = String(d).lpad(2, '0');
			this.today = y+''+m+''+d;
		}
		return this.today;
	}
	,dateMask: function(obj, sep){
		var rv = '';
		if(!sep) sep = '/';
		var isObj = El.isObject(obj);
		var str = obj;
		if(isObj) str = $F(obj);

		try{
			rv = str.substring(0, 4);
			rv += sep+str.substring(4,6);
			rv += sep+str.substring(6);
		}catch(e){}

		if(isObj) Field.setValue(obj, rv);
		return rv;
	}
	,getDateObj: function(str){
		if(!str) return null;
		str = str.trim();
		if(str.length < 8) return null;

		var year = parseInt(str.substring(0, 4));
		var month = str.substring(4, 6);
		if(month.substring(0,1) == '0') month = month.substring(1);
		month = parseInt(month);
		var date = str.substring(6);
		if(date.substring(0,1) == '0') date = date.substring(1);
		date = parseInt(date);
		if(month==0) month = 0;
		if(date==0) date = 1;
		
		return new Date(year, month-1, date);
	}
	,getStr: function(dateObj){
		var year = dateObj.getYear();
		var month = dateObj.getMonth()+1;
		var date = dateObj.getDate();
		return String(year).lpad(4, 0) + String(month).lpad(2, 0) + String(date).lpad(2, 0);
	}
	,plus: function(obj, gbn, n, targetObj, basis){
		var isObj = El.isObject(obj);
		var str = obj;
		n = parseInt(n);
		if(isObj){
			str = $F(obj);
			if(!str){
				str = this.getToday();
				Field.setValue(obj, str);
			}
		}

		if(basis){
			n = Math.round(n/2);
			this.plus(basis, 2, n, obj);
			this.plus(basis, 2, n*-1, targetObj);
			return;
		}

		str = str.rpad(8, 0);
		var year = parseInt(str.substring(0, 4));
		var month = str.substring(4, 6);
		if(month.substring(0,1) == '0') month = month.substring(1);
		month = parseInt(month);
		var date = str.substring(6);
		if(date.substring(0,1) == '0') date = date.substring(1);
		date = parseInt(date);
		if(month==0) month = 0;
		if(date==0) date = 1;
		// alert(str+'\n' + year + ' / ' + (month) + ' / ' + (date));
		
		var dateObj;
		if(gbn==0) dateObj = new Date(year+n, month-1, date);
		else if(gbn==1) dateObj = new Date(year, month-1+n, date);
		else if(gbn==2) dateObj = new Date(year, month-1, date+n);
		// alert(year + ' / ' + (month-1) + ' / ' + (date+n));
		dateObj = this.getStr(dateObj);

		if(targetObj) Field.setValue(targetObj, dateObj);
		return dateObj;
	}
	,plusObj: function(obj, gbn, n, targetObj, basis){
		var str = $F(obj);
		var dateObj = this.plus($E(obj), gbn, n, targetObj, basis);
		if(dateObj) Field.setValue(targetObj, dateObj);
		return dateObj;
	}
	,getParseStr: function(obj, gbn){
		if( El.isObject(obj) ) obj = $F(obj);
		obj = String(obj);
		if(!gbn) gbn = '.';
		var str;
		if(gbn==1){
			try{
				str = obj.substring(0,4) + '년';
				if(obj.length > 4)
					str += ' ' + obj.substring(4,6) + '월';
				if(obj.length > 6)
					str += ' ' + obj.substring(6,8) + '일';
			}catch(e){ return str; }
		}else if(gbn==2){
		}else{
			var list = [];
			try{
				list.push(obj.substring(0,4));
				list.push(obj.substring(4,6));
				list.push(obj.substring(6,8));
			}catch(e){}
			str = list.join( gbn+' ' );
		}
		return str;
	}
	,getDay: function(str, lang){
		var dateObj = this.getDateObj(str);
		if(!dateObj) return null;
		if(!lang) lang = "kor";

		var day = {
			kor: ["일", "월", "화", "수", "목", "금", "토"]
			,eng: ["Sun", "Mon", "Tue", "Wen", "Thu", "Fri", "Sat"]
		}
		return day[lang.toLowerCase()][dateObj.getDay()];
	}
}

var Timer = Class.create();
Timer.prototype = {
	startDate: null
	,init: function(){
		this.reset();
	}
	,reset: function(){
		this.startDate = new Date();
	}
	,getTime: function(){
		var d = new Date();
		return d.getTime() - this.startDate.getTime(); 
	}
}

var Check = {
	//주민번호 체크 - copy source
	idBusiNo: function(strNo1, strNo2){
	    var retValue = false;
	    var strTempNo;
	    var strSex;

	    if(strNo1.length == 13){
	        strTempNo = strNo1;

			strSex = strNo1.substring(6,7);
	        // alert(strSex);
	        if(strSex  == '1' || strSex == '2' || strSex =='3' || strSex == '4'){
	            retValue = this.idNo(strTempNo);
	        }
			// 외국인
			else{
	            retValue = this.fgnNo(strTempNo);
	        }
	    }else{
	        if(strNo1.length != 10){
	            strSex = strNo1.substring(1,2) ;
	            // alert(strSex);

	            if(strSex  == '1' || strSex == '2' || strSex =='3' || strSex == '4')
	            {
	                retValue = this.idNo(strNo1, strNo2);
	            }
	            else
	            {
	                retValue = this.fgnNo(strNo1);
	            }
	        }
		// 사업자등록번호 유효성
	        else{
	            retValue = this.busiNo(strNo1);
	        }
	    }
	    return retValue;
	}
	//사업자등록번호 체크 - copy source
	,busiNo: function(vencod){
	    var sum = 0;
	    var getlist = new Array(10);
	    var chkvalue = new Array("1","3","7","1","3","7","1","3","5");

	    try{
	        for(var i=0; i<10; i++){
	            getlist[i] = vencod.substring(i, i+1);
	        }

	        for(var i=0; i<9; i++){
	            sum += getlist[i]*chkvalue[i];
	        }

	        sum = sum + parseInt((getlist[8]*5)/10);
	        sidliy = sum % 10;
	        sidchk = 0;

	        if(sidliy != 0){
	            sidchk = 10 - sidliy;
	        }else{
	            sidchk = 0;
	        }

	        if(sidchk != getlist[9]){
	            return false;
	        }
	        return true;
	    }catch(e){
	        return false;
	    }
	}
	//형식오류(0),법인(1),개인(2) 여부
	,busiType: function(busino){
		if(!busino) return 0;
		busino = busino.trim().replaceAll('-', '');
		if(busino.length < 1) return 0;
		if( this.busiNo(busino) == false ) return 0;

		// var n = busino.substring(5, 6);
		var n = busino.substring(busino.length-5, busino.length-4);
		if(n==8) return 2;
		return 1;
	}
	//재외국인 번호 체크 - copy source
	,fgnNo: function(fgnno){
	    var sum=0;
	    var odd=0;
	    buf = new Array(13);
	    try{
	        for(i=0; i<13; i++){
	            buf[i]=parseInt(fgnno.charAt(i));
	        }

	        odd = buf[7]*10 + buf[8];

	        if(odd%2 != 0){
	            return  false;
	        }

	        if( (buf[11]!=6) && (buf[11]!=7) && (buf[11]!=8) && (buf[11]!=9) ){
	                return false;
	        }
	        multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];
	        for(i=0, sum=0; i<12; i++){
	            sum +=  (buf[i] *= multipliers[i]);
	        }
	        sum = 11 - (sum%11);

	        if(sum >= 10){
	            sum -= 10;
	        }
	        sum += 2;
	        if(sum >= 10){
	            sum -= 10;
	        }
	        if(sum != buf[12]) return  false
	        return true;
	    }
	    catch(e){
	        return false;
	    }
	}
	//주민등록번호 체크 - copy source
	,idNo: function(strValue1, strValue2){
	    var str_f_num;
	    var str_l_num;
	    try{
	        if(strValue1.length == 13){
				str_f_num = strValue1.substring(0,6);
				str_l_num = strValue1.substring(6);
	        }else{
				str_f_num = strValue1;
				str_l_num = strValue2;
	        }

	        var i3=0
	        for (var i=0;i<str_f_num.length;i++){
			var ch1 = str_f_num.substring(i,i+1);
			if (ch1<'0' || ch1>'9') i3=i3+1;
	        }
	        if ((str_f_num == '') || ( i3 != 0 )) return false;
	        var i4=0;
	        for (var i=0;i<str_l_num.length;i++){
			var ch1 = str_l_num.substring(i,i+1);
			if (ch1<'0' || ch1>'9') i4=i4+1;
	        }
	        if((str_l_num == '') || ( i4 != 0 )) return false;
	        if(str_f_num.substring(0,1) < 4) return false;
	        if(str_l_num.substring(0,1) > 2) return false;
	        if((str_f_num.length > 7) || (str_l_num.length > 8)) return false;
	        if((str_f_num == '72') || ( str_l_num == '18'))  return false;

	        var f1 = str_f_num.substring(0,1);
	        var f2 = str_f_num.substring(1,2);
	        var f3 = str_f_num.substring(2,3);
	        var f4 = str_f_num.substring(3,4);
	        var f5 = str_f_num.substring(4,5);
	        var f6 = str_f_num.substring(5,6);
	        var hap = f1*2+f2*3+f3*4+f4*5+f5*6+f6*7;
	        var l1 = str_l_num.substring(0,1);
	        var l2 = str_l_num.substring(1,2);
	        var l3 = str_l_num.substring(2,3);
	        var l4 = str_l_num.substring(3,4);
	        var l5 = str_l_num.substring(4,5);
	        var l6 = str_l_num.substring(5,6);
	        var l7 = str_l_num.substring(6,7);
	        hap = hap + l1*8+l2*9+l3*2+l4*3+l5*4+l6*5;
	        hap = hap%11;
	        hap = 11 - hap;
	        hap = hap%10;
	        // window.status = hap + ' / ' + l7;
	        if(hap != l7) return false;
	        return true;
	    }catch(e){
	        return false;
	    }
	}
}


var MaskEdit = {
	create: function(type, obj){
	}
}
MaskEdit.Type = {
	date: function(obj){
	}
}

var XmlObject = Class.create();
XmlObject.prototype = {
	xml: null
	,init: function(xml){
		this.xml = xml;
	}
	,getValue: function(tagName, idx, nullValue){
		var v = null;
		if(!nullValue) nullValue = '';
		if(!idx) idx = 0;
		try{
			v = this.xml.getElementsByTagName(tagName)[idx].firstChild.nodeValue;
		}catch(e){
			v = nullValue;
		}
		return v;
	}
	,getSize: function(tagName){
		return this.xml.getElementsByTagName(tagName).length;
	}
}

var XmlHandler = {
	getValue: function(xml, tagName, idx, nullValue){
		if(idx==null) idx = 0;
		var v = '';
		try{
			v = xml.getElementsByTagName(tagName)[idx].firstChild.nodeValue;
		}catch(e){
			v = nullValue;
		}
		return v;
	}
	,getValueObject: function(node){
		if(!node) return null;
		if(!node.hasChildNodes()) return null;
		var cns = node.childNodes;
		var obj = {};

		for(var i=0, cnt=cns.length; i<cnt; ++i){
			var nn = cns[i].nodeName;
			try{
				obj[nn] = cns[i].firstChild.nodeValue;
			}catch(e){
				obj[nn] = '';
			}
		}
		return obj;
	}
}


var Sort = {
	chr: function(list, asc, valueFunc){
		if(list.length <= 1) return list;
		
		if(!valueFunc){
			valueFunc = function(v){ return v; }
		}

		var chk = (asc==true) ? 0 : 1;

		var n = list.length - 1;
		var left = 0, right = 0;
		for(var i=0; i<list.length-1; ++i){
			var v1 = valueFunc(list[i]);
			var v2 = valueFunc(list[n]);
			var chkList = [v1, v2];
			chkList = chkList.sort();
			if(chkList[chk] == v1){
				var chObj = list[i];
				list[i] = list[left];
				list[left] = chObj;
				left++;
				right++;
			}else{
				right++;
			}
		}
	
		var v = list.pop();
		var list1 = list.slice(0, left);
		var list2 = list.slice(left);
	
		if(list1.length > 1){
			list1 = this.chr(list1, asc, valueFunc);
		}
		if(list2.length > 1){
			list2 = this.chr(list2, asc, valueFunc);
		}

		list1.push(v);
		list = list1.concat(list2);
		return list;
	}
	,number: function(){
		//미완
	}
}



//jsMakeCurrency를 사용한 키 입력 검사 확장모듈 //현재 model 단에서 받는게 int라서 21억까지만 들어감
function inputjsMakeCurrency(input){

	var length = input.value.length;
	var s = getSelectionStart(input);
	var v = input.value;
	var vn = v.replace(/,/g, ''); // 콤마 제거한 숫자만
	var rs = v.substring(s, length).length; // caret 위치 이후 문자 길이 remain string length after position s
	var rn = v.substring(s, length).replace(/,/g, '').length; // caret 위치 이후 숫자 길이 remain number length after position s
	var nc = rs - rn; // number of comma 전체 콤마 개수
	var bs = v.substring(s-1, s); // 커서 앞글자 before selection start
	var as = v.substring(s, s+1)//커서 뒤글자 after selection start
	var added = 0;
	
	if(event.keyCode == 8) { //Back space 키		
		if(rn != 0 && rn%3 == 0 && as != ','){
			input.value = v.substring(0, s-1) + v.substring(s, length);
			if(vn.length%3 == 1){ //맨 앞 콤마가 하나 없어질 때 예외처리 
				s--;
			}
		}
		if(vn.length%3 == 0){ //맨 앞 콤마가 하나 없어질 때 예외처리 
			s--;
		}
	}
	if(event.keyCode == 46) {//Delete 키		
		if(rn != 0 && rn%3 == 0 && bs != ','){
			input.value = v.substring(0, s) + v.substring(s+1, length);
			s++;
			if(vn.length%3 == 1){ //맨 앞 콤마가 하나 없어질 때 예외처리 
				s--;
			}
		}
		if(vn.length%3 == 0){ //맨 앞 콤마가 하나 없어질 때 예외처리 
			s--;
		}
		//alert(rn + ' ' + rs + ' ' + vn.length); // 6 7 9
	}	
	//숫자 0~9 || 키패드 0~9 || 백스페이스 || Delete
	if( ((event.keyCode > 47) && (event.keyCode < 58))			 
			|| ((event.keyCode > 95) && (event.keyCode < 106)) 
			|| (event.keyCode == 8) || (event.keyCode == 46) ) {
		jsMakeCurrency(input);
		added = input.value.length - length;		
		if(added > 0) s += added; 
		setCaretPosition(input, s);
	}
}
//커서 위치 찾기
function getSelectionStart(o) {
	if (o.createTextRange) {
		var r = document.selection.createRange().duplicate()
		r.moveEnd('character', o.value.length)
		if (r.text == '') return o.value.length
		return o.value.lastIndexOf(r.text)
	} else return o.selectionStart
}
//텍스트 선택한 경우 선택영역 끝 위치
function getSelectionEnd(o) {
	if (o.createTextRange) {
		var r = document.selection.createRange().duplicate()
		r.moveStart('character', -o.value.length)
		return r.text.length
	} else return o.selectionEnd
}
//커서 위치 셋
function setCaretPosition(elem, caretPos) {
  //var elem = document.getElementById(elemId);

  if(elem != null) {
      if(elem.createTextRange) {
          var range = elem.createTextRange();
          range.move('character', caretPos);
          range.select();
      } else {
          if(elem.selectionStart) {
              elem.focus();
              elem.setSelectionRange(caretPos, caretPos);
          } else
              elem.focus();
      }
  }
}

//숫자만 입력받는다. 32~47 특수문자('-','.',...) 는 불허
//한글은 keypress에서 못잡아내는 버그가 있음. 
function onlyNumber() {
	//alert(event.keyCode);	
	//숫자 0~9 및 특수키 || 키패드 0~9
	if( (event.keyCode > 47) && (event.keyCode < 58) ) {					
	} else {		
		//if((event.keyCode > 31) && (event.keyCode < 45) || (event.keyCode > 57)) {
		event.returnValue = false;
	}
}
//한글 인식은 keydown으로 연결하면 되지만 이 경우 특수키 조합이 작동을 안함
function onlyNumber2() {
	//alert(event.keyCode);
	//숫자 0~9 및 특수키 || 키패드 0~9	
	if( (event.keyCode < 58) 
		|| (event.keyCode > 95) && (event.keyCode < 106) ) {					
	} else {		
		//if((event.keyCode > 31) && (event.keyCode < 45) || (event.keyCode > 57)) {
		event.returnValue = false;
	}
}		
//숫자만 입력받는다. "-"도 받지않는다. 사용법 예제 : onBlur=onlyNumber2(this);
function onlyNumber3(loc) {
	if(/[^0123456789]/g.test(loc.value)) {
		//alert("숫자가 아닙니다.\n\n0-9의 정수만 허용합니다.");
		loc.value = "";
		loc.focus();
	}
}
//엔터키 입력 검사 true 리턴
function inputEnter(){
	if(event.keyCode ==13){
		return true;
	}else{
		return false;
	}
}

function jsMakeCurrency(varTextObj) {
    varTextObj.value = jsDeleteComma(varTextObj.value);
    var varLength = varTextObj.value.length;
    var varText = "";
    var isPointed = false;
    for ( var inx = 0; inx < varLength; inx++) {
        if (jsCheckNumber(varTextObj.value.substring(inx, inx + 1))) {
            varText = varText + varTextObj.value.substring(inx, inx + 1);
        }
    }
    varTextObj.value = jsAddComma(varText);
}

function jsDeleteComma(varNumber) {
	try {
	    var varLength = varNumber.length;
	    varReturnNumber = "";
	    for ( var inx = 0; inx < varLength; inx++) {
	        if (varNumber.substring(inx, inx + 1) != ",") {
	            varReturnNumber = varReturnNumber
	                    + varNumber.substring(inx, inx + 1);
	        }
	    }
	} catch(e) {
		varReturnNumber = '-';
	}
    return varReturnNumber;
}

function jsCheckNumber(toCheck) {
    var chkstr = toCheck + "";
    var isNum = true;
    if (jsCheckNull(toCheck))
        return false;

    for (j = 0; isNum && (j < toCheck.length); j++) {
        if ((toCheck.substring(j, j + 1) < "0")
                || (toCheck.substring(j, j + 1) > "9")) {
            if (toCheck.substring(j, j + 1) == "-") {
                if (j != 0) {
                    isNum = false;
                }
            } else {
                isNum = false;
            }
        }
    }
    // if (chkstr == "+" || chkstr == "-") isNum = true;
    return isNum;
}

function jsCheckNull(toCheck) {
    var chkstr = toCheck + "";
    var is_Space = true;
    if ((chkstr == "") || chkstr == null ||chkstr == "null" )
        return (true);
    for (j = 0; is_Space && (j < chkstr.length); j++) {
        if (chkstr.substring(j, j + 1) != " ") {
            is_Space = false;
        }
    }
    return (is_Space);
}
function jsAddComma(varNumber) {
	if(typeof(varNumber) =="number")
		varNumber = varNumber.toString();
    // 숫자가 아니면 -1을 리턴한다.
    if (jsCheckNull(varNumber))
        return "";
    if (!jsCheckFloat(varNumber)) {
        return -1;
    }

    // 소수 이상, 이하 부분을 따로 보관.
    var PointIndex = varNumber.indexOf(".");
    var varUnderPoint = "";
    var isPointed = false;
    // 소수 이하가 없을때
    if (PointIndex < 0) {
        isPointed = false;
        // 소수 이하 부분
        varUnderPoint = "";
        // 소수 이상 부분
        varOverPoint = varNumber;
        // 소수 이하가 있을때
    } else {
        isPointed = true;
        // 소수 이하 부분
        varUnderPoint = varNumber.substring(PointIndex + 1, varNumber.length);
        // 소수 이상 부분
        varOverPoint = varNumber.substring(0, PointIndex);
    }

    // 음수일때 앞의 "-" 따로 보관
    var negativeFlag = false;
    if (varOverPoint.substring(0, 1) == "-") {
        negativeFlag = true;
        varOverPoint = varOverPoint.substring(1, varOverPoint.length + 1);
    }
    // 소수 이상 부분에 comma 넣기
    var varLength = varOverPoint.length;
    var varCnt = 0;
    var varTempReturnNumber = "";
    for ( var inx = varLength - 1; inx >= 0; inx--) {
        varCnt++;
        // 소수점 찍기
        if (varCnt == 4) {
            varTempReturnNumber = varOverPoint.substring(inx, inx + 1) + ","
                    + varTempReturnNumber;
            varCnt = 1;
            // 소수점 안찍기
        } else {
            varTempReturnNumber = varOverPoint.substring(inx, inx + 1)
                    + varTempReturnNumber;
        }
    }

    // 앞에 붙은 0 없애기 (예) 00200 -> 200
    varLength = varTempReturnNumber.length;
    var varReturnNumber = "";
    for ( var inx = 0; inx < varLength; inx++) {
        if (varTempReturnNumber.substring(inx, inx + 1) == '0') {
            // '0' 이 넘어왔을 경우 '0'을 그대로 리턴해야 한다.
            if (varLength == 1)
                varReturnNumber = "0";
            else if (eval(jsDeleteComma(varTempReturnNumber)) == '0') {
                varReturnNumber = "0";
                break;
            }
        } else {
            varReturnNumber = varTempReturnNumber.substring(inx, varLength + 1);
            break;
        }
    }

    // 소수점 이하 붙이기
    if (isPointed) {
        varReturnNumber = varReturnNumber + "." + varUnderPoint;
    }
    // 음수 붙이기
    if (negativeFlag) {
        varReturnNumber = "-" + varReturnNumber;
    }
    return varReturnNumber;
}

function jsCheckFloat(toCheck) {
    var chkstr = toCheck + "";
    var isFloat = true;
    var chkPoint = false;
    var chkMinus = false;
    if (jsCheckNull(toCheck)) {
        return false;
    }
    for (j = 0; isFloat && (j < toCheck.length); j++) {
        if ((toCheck.substring(j, j + 1) < "0")
                || (toCheck.substring(j, j + 1) > "9")) {
            if (toCheck.substring(j, j + 1) == ".") {
                if (!chkPoint)
                    chkPoint = true;
                else
                    isFloat = false;
            } else if (toCheck.substring(j, j + 1) == "-"
                    || toCheck.substring(j, j + 1) == "+") {
                if ((j == 0) && (!chkMinus))
                    chkMinus = true;
                else
                    isFloat = false;
            } else
                isFloat = false;
        }
    }
    return isFloat;
}


function roundXL(n, digits) {
	  if (digits >= 0) return parseFloat(n.toFixed(digits)); // 소수부 반올림

	  digits = Math.pow(10, digits); // 정수부 반올림
	  var t = Math.round(n * digits) / digits;

	  return parseFloat(t.toFixed(0));
	}


function isFloat(value){
		if(parseFloat(value)==0)
			return true;
	   if(isNaN(value)){
	     return false;
	   } else {
	      if(parseFloat(value)) {
	              return true;
	          } else {
	              return false;
	          }
	   }
	}

//주의 : string 타입을 리턴
function getYm(year, month){
	if(month<10)
		return year + "0" + month;
	else
		return year + "" + month;
}

//주의 : int 타입을 리턴
function parseYear(dateString){
	date = dateString.toString();
	return parseInt(date.substr(0,4));
}

//주의 : int Type 을 리턴
function parseMonth(dateString){
	date = dateString.toString();
	return parseInt(date.substr(4,1) + "0") + parseInt(date.substr(5,1));
	
}

function escapeJQuerySelector( str) {
	 if( str)
	     return str.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g,'\\$1')
	 else
	     return str;
}