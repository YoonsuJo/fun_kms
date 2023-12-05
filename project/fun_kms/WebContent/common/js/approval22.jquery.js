

(function( $ ){
	
	
	$.fn.summingUp = function(options)
	{
   
        var element = $(this);
        var summingUp = new SummingUp(this);
	    summingUp.init(options);
	};
	
	var SummingUp = function(target)
	{
		var globalData = {};
		var obj = this;
	    var target = $(target);
	    //첫 번째 값은 필요 없음.
	    var salesOut = [0,0,0,0,0,0,0,0,0,0,0,0,0];
	    var salesIn = [0,0,0,0,0,0,0,0,0,0,0,0,0];
	    var purchaseOut= [0,0,0,0,0,0,0,0,0,0,0,0,0]; 
	    var purchaseIn= [0,0,0,0,0,0,0,0,0,0,0,0,0]; 
	    var labor= [0,0,0,0,0,0,0,0,0,0,0,0,0]; 
	    var expense= [0,0,0,0,0,0,0,0,0,0,0,0,0]; 
	    var common= [0,0,0,0,0,0,0,0,0,0,0,0,0]; 
	    var profitOnSales= [0,0,0,0,0,0,0,0,0,0,0,0,0]; 
		var operatingProfit= [0,0,0,0,0,0,0,0,0,0,0,0,0];  
		this.init = function(options){
			 if ( options ) { 
			        $.extend( globalData, options );
			        
			 }
			 var year = $('select[name=year]').val();
			 target.find('.year').html(year);
			 
			 $('select[name=year]').bind('change',function(){
				 target.find('.year').html($(this).val());	
			 });
			 $(globalData.salesPurchase).find('[name=salesOutList]').each(function(idx,elm){
			 	 salesOut[idx+1] = parseInt(jsDeleteComma($(this).val()));
				 $(this).keyup(function(){
					 jsMakeCurrency(this);
					 salesOut[idx+1] = parseInt(jsDeleteComma($(this).val()));
					 obj.updateSalesOut(idx+1, $(this).val());
				 });
			 });
			 $(globalData.salesPurchase).find('[name=salesInList]').each(function(idx,elm){
			 	 salesIn[idx+1] = parseInt(jsDeleteComma($(this).val()));
				 $(this).keyup(function(){
					 jsMakeCurrency(this);
					 salesIn[idx+1] = parseInt(jsDeleteComma($(this).val()));
					 obj.updateSalesIn(idx+1, $(this).val());
				 });
			 });
			 $(globalData.salesPurchase).find('[name=purchaseOutList]').each(function(idx,elm){
			 	 purchaseOut[idx+1] = parseInt(jsDeleteComma($(this).val()));
				 $(this).keyup(function(){
					 jsMakeCurrency(this);
					 purchaseOut[idx+1] = parseInt(jsDeleteComma($(this).val()));
					 obj.updatePurchaseOut(idx+1, $(this).val());
				 });
			 });
			 $(globalData.salesPurchase).find('[name=purchaseInList]').each(function(idx,elm){
			 	 purchaseIn[idx+1] = parseInt(jsDeleteComma($(this).val()));
				 $(this).keyup(function(){
					 jsMakeCurrency(this);
					 purchaseIn[idx+1] = parseInt(jsDeleteComma($(this).val()));
					 obj.updatePurchaseIn(idx+1, $(this).val());
				 });
			 });
			 $(globalData.laborExpense).find('[name=laborList]').each(function(idx,elm){
			 	 labor[idx+1] = parseInt(jsDeleteComma($(this).val()));
				 $(this).keyup(function(){
					 jsMakeCurrency(this);
					 labor[idx+1] = parseInt(jsDeleteComma($(this).val()));
					 obj.updateLabor(idx+1, $(this).val());
				 });
			 });
			 $(globalData.laborExpense).find('[name=expenseList]').each(function(idx,elm){
			 	 expense[idx+1] = parseInt(jsDeleteComma($(this).val()));
				 $(this).keyup(function(){
					 jsMakeCurrency(this);
					 expense[idx+1] = parseInt(jsDeleteComma($(this).val()));
					 obj.updateExpense(idx+1, $(this).val());
				 });
			 });
			 $(globalData.common).find('[name=purchaseInCommonList]').each(function(idx,elm){
			 	 common[idx+1] = parseInt(jsDeleteComma($(this).val()));
				 $(this).keyup(function(){
					 jsMakeCurrency(this);
					 common[idx+1] = parseInt(jsDeleteComma($(this).val()));
					 obj.updateCommon(idx+1, $(this).val());
				 });
			 });
			 
			 
		};
		var divideby=1000;
		this.updateSalesOut = function(month, cost){
			var sum = 0;
			target.find(".salesOut.month"+month).html(jsAddComma(roundXL(jsDeleteComma(cost)/divideby,1)));
			for(var i=1; i<=12;i++)
			{
				sum += salesOut[i];
			}
			target.find(".salesOut.horizonTotal").html(jsAddComma(roundXL(sum/divideby,1)));
			
			obj.updateProfit(month);
		};
		
		this.updateSalesIn = function(month, cost){
			var sum = 0;
			target.find(".salesIn.month"+month).html(jsAddComma(roundXL(jsDeleteComma(cost)/divideby,1)));
			for(var i=1; i<=12;i++)
			{
				sum += salesIn[i];
			}
			target.find(".salesIn.horizonTotal").html(jsAddComma(roundXL(sum/divideby,1)));
			
			obj.updateProfit(month);
		};

		this.updatePurchaseOut = function(month, cost){
			var sum = 0;
			target.find(".purchaseOut.month"+month).html(jsAddComma(roundXL(jsDeleteComma(cost)/divideby,1)));
			for(var i=1; i<=12;i++)
			{
				sum += purchaseOut[i];
			}
			target.find(".purchaseOut.horizonTotal").html(jsAddComma(roundXL(sum/divideby,1)));
			obj.updateProfit(month);
		};
		this.updatePurchaseIn = function(month, cost){
			var sum = 0;
			target.find(".purchaseIn.month"+month).html(jsAddComma(roundXL(jsDeleteComma(cost)/divideby,1)));
			for(var i=1; i<=12;i++)
			{
				sum += purchaseIn[i];
			}
			target.find(".purchaseIn.horizonTotal").html(jsAddComma(roundXL(sum/divideby,1)));
			obj.updateProfit(month);
		};
		
		this.updateLabor =  function(month, cost){
			var sum = 0;
			target.find(".labor.month"+month).html(jsAddComma(roundXL(jsDeleteComma(cost)/divideby,1)));
			for(var i=1; i<=12;i++)
			{
				sum += labor[i];
			}
			target.find(".labor.horizonTotal").html(jsAddComma(roundXL(sum/divideby,1)));
			obj.updateProfit(month);
		};
		this.updateExpense = function(month, cost){
			var sum = 0;
			target.find(".expense.month"+month).html(jsAddComma(roundXL(jsDeleteComma(cost)/divideby,1)));
			for(var i=1; i<=12;i++)
			{
				sum += expense[i];
			}
			target.find(".expense.horizonTotal").html(jsAddComma(roundXL(sum/divideby,1)));
			obj.updateProfit(month);
		};
		this.updateCommon = function(month, cost){
			var sum = 0;
			target.find(".common.month"+month).html(jsAddComma(roundXL(jsDeleteComma(cost)/divideby,1)));
			for(var i=1; i<=12;i++)
			{
				sum += common[i];
			}
			target.find(".common.horizonTotal").html(jsAddComma(roundXL(sum/divideby,1)));
			obj.updateProfit(month);
		};
		this.updateProfit = function(month){
			profitOnSales[month] = salesOut[month] + salesIn[month] - purchaseOut[month] - purchaseIn[month];
			operatingProfit[month] = profitOnSales[month] - expense[month]  -labor[month] - common[month];
			target.find(".profitOnSales.month"+month).html(jsAddComma(roundXL(profitOnSales[month]/divideby,1)));
			globalData.salesPurchase.find('tfoot td.month'+month).html(jsAddComma(roundXL(profitOnSales[month],1)));
			target.find(".operatingProfit.month"+month).html(jsAddComma(roundXL(operatingProfit[month]/divideby,1)));
			
			//매출이익 합계 구함
			var sum=0;
			target.find(".profitOnSales").each(function(idx,elm){
				if(idx>=0 && idx<12)
					sum +=  profitOnSales[idx+1];
				else
					$(this).html(jsAddComma(roundXL(sum/divideby,1)));
			});	
			//영업이익 합계 구함
			var sum=0;
			target.find(".operatingProfit").each(function(idx,elm){
				if(idx>=0 && idx<12)
					sum +=  operatingProfit[idx+1];
				else
					$(this).html(jsAddComma(roundXL(sum/divideby,1)));
			});	
			
		};
	
	};
	 
})( jQuery );