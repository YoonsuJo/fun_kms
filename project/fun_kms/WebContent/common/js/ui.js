$(function(){	
	$('.popup_div').css({top:'50%',left:'50%',margin:'-'+($('.popup_div').height() / 2)+'px 0 0 -'+($('.popup_div').width() / 2)+'px'});

	$(".main").mouseover(function(){
		$(".bg_main_navi").hide();
		$(".sub_navi").hide();
		
	});
});

function toggle_gnbover(idx) {
	if(idx) {
        var obj;
    
        for (var z=1; z<7; z++){
            obj = $('#sub0' + z).attr('id');

            if (z == idx){
            	$('#'+obj).show();
            	$(".bg_sub_navi").show();
            	$(".bg_main_navi").show();
            } else {
            	$('#'+obj).hide();
            }
        }
    }
    return;

}

// lnb
function MenuLoad(a,b,c){

    var obj_mtopimg = $('#gmsub_b_'+a+'_'+b).attr('id');
   
    
    if(obj_mtopimg){
    	$('#'+obj_mtopimg).addClass('gnb_hover');
   	}

     for(var i=1; i < 13; i++)
     {

        var obj_top2menu = $('#gmsub_b_'+a+'_'+b).attr('id');
        var obj_menus =  $('#lms_'+i).attr('id');
        
        if (i == b)
        {
            if(obj_top2menu){
            	$('#'+obj_top2menu).addClass('gnb_hover');
            }
            if(obj_menus){
            	$('#'+obj_menus).addClass('on');
           	}
           	
			if(c){
	                for(var j=1; j < 3; j++)
	                {
	                    var obj_3dmenus =  $("#lms_"+b+"_"+j).attr('id');
	                  
	                    if (j == c){
	                            if(obj_3dmenus){
	                            	$('#'+obj_3dmenus).addClass('on');
	                            }
	                    }
	                }
	            }
        }
       
     }
    toggle_gnbover(a);
}
