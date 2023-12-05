
$(document).ready(function(){
	var expenseTable = $(
	'<div class="boardWrite02 mB20">'+
	'	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">'+
	'		<caption>기초영업비 예산</caption>'+
	'		<colgroup>'+
	'			<col width="px" />'+
	'			<col class="col50" />'+
	'			<col class="col50" />'+
	'			<col class="col50" />'+
	'			<col class="col50" />'+
	'			<col class="col50" />'+
	'			<col class="col50" />'+
	'			<col class="col50" />'+
	'			<col class="col50" />'+
	'			<col class="col50" />'+
	'			<col class="col50" />'+
	'			<col class="col50" />'+
	'			<col class="col50" />'+
	'		</colgroup>'+
	'		<tbody>'+
	'			<tr>'+
	'				<td class="title">프로젝트</td>'+
	'				<td class="pL10 Br02" colspan="12">'+
	'					<input type="text" name="prjNm" class="span_12" readonly="true"/>'+ 
	'					<input type="hidden" name="prjId"/>'+ 
	'					<img src="'+imagePath+'/btn/btn_tree.gif" class="cursorPointer prjTreeB">'+ 
	'					<img src="'+imagePath+'/btn/btn_delete03.gif" class="cursorPointer deleteB"></td>'+
	'			</tr>'+
	'			<tr>'+
	'				<td class="title">월</td>'+
	'				<td class="Br">1월</td>'+
	'				<td class="Br">2월</td>'+
	'				<td class="Br">3월</td>'+
	'				<td class="Br">4월</td>'+
	'				<td class="Br">5월</td>'+
	'				<td class="Br">6월</td>'+
	'				<td class="Br">7월</td>'+
	'				<td class="Br">8월</td>'+
	'				<td class="Br">9월</td>'+
	'				<td class="Br">10월</td>'+
	'				<td class="Br">11월</td>'+
	'				<td class="Br">12월</td>'+
	'			</tr>'+
	'			<tr>'+
	'				<td class="title">금액</td>'+
	'				<td class="Br02"><input type="text" name="month[]" class="span_1 currency1000"'+
	'					value="0" /></td>'+
	'				<td class="Br02"><input type="text" name="month[]" class="span_1 currency1000"'+
	'					value="0" /></td>'+
	'				<td class="Br02"><input type="text" name="month[]" class="span_1 currency1000"'+
	'					value="0" /></td>'+
	'				<td class="Br02"><input type="text" name="month[]" class="span_1 currency1000"'+
	'					value="0" /></td>'+
	'				<td class="Br02"><input type="text" name="month[]" class="span_1 currency1000"'+
	'					value="0" /></td>'+
	'				<td class="Br02"><input type="text" name="month[]" class="span_1 currency1000"'+
	'					value="0" /></td>'+
	'				<td class="Br02"><input type="text" name="month[]" class="span_1 currency1000"'+
	'					value="0" /></td>'+
	'				<td class="Br02"><input type="text" name="month[]" class="span_1 currency1000"'+
	'					value="0" /></td>'+
	'				<td class="Br02"><input type="text" name="month[]" class="span_1 currency1000"'+
	'					value="0" /></td>'+
	'				<td class="Br02"><input type="text" name="month[]" class="span_1 currency1000"'+
	'					value="0" /></td>'+
	'				<td class="Br02"><input type="text" name="month[]" class="span_1 currency1000"'+
	'					value="0" /></td>'+
	'				<td class="Br02"><input type="text" name="month[]" class="span_1 currency1000"'+
	'					value="0" /></td>'+
	'			</tr>'+
	'		</tbody>'+
	'	</table>'+
	'</div>');
	
	var expenseCnt = 0;
	function settingExpenseTable(table)
	{
		table.find('[name]').each(function(){
			$(this).attr("name",'expense['+ expenseCnt + '].'+$(this).attr('name'));
		});
		
		table.find('.deleteB').click(function(){
			table.remove();
		});
		
		table.find('[name*=prjNm],.prjTreeB').click(function(){
			prjGen(table.find('[name*=prjNm]'),table.find('[name*=prjId]'),1);
		});
		
		table.find('[name*=month]').keyup(function(){
			jsMakeCurrency(this);
		});
		expenseCnt++;
	}
	
	
	//재기안일 경우.
	$('#expenseAllD table').each(function(){
		var table = $(this); 
		settingExpenseTable(table);
	});
	
	
	$('#expenseAddB').click(function(){
		var table = expenseTable.clone();
		table.appendTo('#expenseAllD');
		settingExpenseTable(table);
		
	});
	
	

	
	$('#userTreeB').click(function(){
		usrGen('userMix',1);
	});
});