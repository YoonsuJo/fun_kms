function ChangeImg(imgdiv) {

    var imgdivc = imgdiv.childNodes;
    var imga = null;
    var imgac = null;
    var img = null;
    var span = null;
    var loading = null;
    var content_img = imgdiv.parentNode;
    if ( content_img.nodeName.toLowerCase() != 'div' ) {
        var content_img = document.getElementById('content_img');           // 컨텐츠 내에 포함된 이미지 (중복클래스 유지)
    }

    var one_content_img = document.getElementById('one_content_img');   // 상단에 첨부된 이미지가 한개 일 경우 (중복클래스 유지 x)

    for(var i=0; i<imgdivc.length; i++) {
        if( imgdivc.item(i).nodeName == 'A' ) {
            imga = imgdivc.item(i);
            imgac = imga.childNodes;
            for(var j=0; j<imgac.length; j++) {
                if ( imgac.item(j).nodeName == 'IMG' ) {
                    img = imgac.item(j);
                } else if( imgac.item(j).nodeName == 'SPAN') {
                    span = imgac.item(j);
                }
            }
        } else if ( imgdivc.item(i).nodeName == 'DIV' ) {
            loading = imgdivc.item(i);
        }
    }

    // 이미지 swap
    var cururl = img.src;
    var tobewidth = 300;
    if(cururl.indexOf('/mnews138/') >-1 ) {
        // 확대
        imgurl = cururl.replace('/mnews138/','/mnews300/');
        tobewidth = 300;
    } else {
        // 축소
        imgurl = cururl.replace('/mnews300/','/mnews138/');
        tobewidth = 138;
    }

    var loaded = false;

    var showloading = function() {
        loading.style.display = 'block';
        img.style.display = 'none';
        span.style.display = 'none';
        operaRerender();
    }
    var hideloading = function() {
        loading.style.display = 'none';
        img.width=tobewidth;
        img.style.display = 'block';
        span.style.display = 'block';
        operaRerender();
    }
    img.onreadystatechange = function() {
        if (this.readyState == 'loaded' || this.readyState == 'complete') {
            if (loaded) { hideloading(); return; }
            loaded = true;
        }
    }
    img.onload = function () {
        hideloading();
    }
    
    showloading();
    img.src = imgurl;

    // ie6인 경우 강제로 hideloading함
    var isie6 = (/msie 6.0/i).test(navigator.userAgent);
    if ( isie6 ) {
        hideloading();
    }

    // 블릿 swap
    if(span.className == 'toggle enlarge') {
        // 확대
        span.className = 'toggle reduce';
        span.innerText = '-';
        if ( content_img != null ) {
            content_img.className = 'viewImage viewbImg';
        }
        if ( one_content_img != null ) {
            one_content_img.className = 'viewImage viewbImg';
        }
    } else {
        // 축소
        span.className = 'toggle enlarge';
        span.innerText = '+';
        if ( content_img != null ) {
            content_img.className = 'viewImage viewbImg';
        }
        if ( one_content_img != null ) {
            one_content_img.className = 'viewImage';
        }
    }

    // 기사 이미지 클릭 ndr 호출
    ndrclick('RAM50');
}

//---------------------------------------------------------------------------------------------------
// 오페라 모바일용 강제 리렌더링
//---------------------------------------------------------------------------------------------------
function operaRerender() {
    var isoperamobile = (/opera/i.test(navigator.userAgent) && !/opera mini/i.test(navigator.userAgent));
    if (isoperamobile) scrollTo(window.pageXOffset, window.pageYOffset);
}

//---------------------------------------------------------------------------------------------------
// 기사 이미지 사이즈 체크 후 크게보기 취소 여부 결정
//---------------------------------------------------------------------------------------------------
function checkChangeImg(img,force_disable) {
    var spanclick = img.parentNode.parentNode;
    var spanguide = img.nextSibling;
    if (img.width < 138 || force_disable == true) {
        spanclick.style.cursor='default';
        spanclick.onclick=null;
        spanguide.className='';
        spanguide.className=null;
        spanguide.innerHTML='';
    }
}