<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>�Ѹ��� �ý���</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function modify(no) {
	document.subForm.no.value = no;
	document.subForm.action = '<c:url value="${rootPath}/mypage/modifyMymenu.do" />';
	document.subForm.submit();
}
function del(no) {
	if (confirm("�����Ͻðڽ��ϱ�?")) {
		document.subForm.no.value = no;
		document.subForm.action = '<c:url value="${rootPath}/mypage/deleteMymenu.do" />';
		document.subForm.submit();
	}
}

var fixHelper = function(e, ui) {
	ui.children().each(function() {
		$(this).width($(this).width());
	});
	return ui;
};

$(document).ready(function(){
	$('#tableBody').sortable({
		helper: fixHelper,
		update: function(event, ui) { 

			var order = new Object();
			$('#tableBody').children('tr').each(function(idx, elm) {
				var no = (elm.id).toString().substring(3);
				order[idx] = no;
			});

			order = JSON.stringify(order);
			order = escape(order);
			$.post("/mypage/ajaxOrderUpdate.do",
				{"orderResult" : order}
				, function(data) {}
			);
		}
	});
	$('#tableBody').disableSelection();
});

</script>
</head>

<body>

<div id="wrap">
	<%@ include file="../common/menu/head.jsp"%>
	<!-- S: container -->
	<div id="container">
		<ul class="container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="contents">
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
			<!-- S: center -->
			<div id="center">
				<div class="path_navi">
					<ul>
						<li class="stitle">��ü�޴� (�����޴�)</li>
						<li class="navi">Ȩ > ��ü�޴�</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
						
					<!-- �������� ���� -->
					<p class="th_stitle">��������</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0">
						<colgroup>
							<col class="col200" />
							<col class="col200" />
							<col class="col200" />
							<col class="col200" />
						</colgroup>
						<thead>
							<tr>
								<th>���Ǿ���</th>
								<th>����</th>
								<th>������Ʈ����</th>
								<th>��������</th>
							</tr>
						</thead>
						<tbody id="tableBody">
								<tr>
									<td class="txt_left">
										<ul ><img src="../../images/inc/bullet_01.gif" />&nbsp;<a href="http://hm.hanmam.kr/cooperation/selectDayReportMyList.do">���Ǿ���</a>
											<li>- <a href="http://hm.hanmam.kr/cooperation/selectDayReportMyDList.do">�������� ��ȸ</a></li>
											<li>- <a href="http://hm.hanmam.kr/cooperation/selectDayReportOrderList.do">�������� ��Ȳ</a></li>
											<li>- <a href="http://hm.hanmam.kr/cooperation/searchProcessList.do">�ְ���������</a></li>
											<li>- <a href="http://hm.hanmam.kr/cooperation/selectWeekReportList.do">�������೻�� �˻�</a></li>
											<li>- <a href="http://hm.hanmam.kr/cooperation/selectDayReportUserList.do">�������� �ۼ���Ȳ</a></li>
										</ul>
									</td>
									<td class="txt_left">
										<ul><a href="http://hm.hanmam.kr/cooperation/selectBusinessContactList.do">����</a>
											<li>- <a href="http://hm.hanmam.kr/cooperation/selectBusinessContactList.do">��������</a></li>
											<li>- <a href="http://hm.hanmam.kr/cooperation/selectMeetingRoomList.do">ȸ�ǽ�</a></li>
											<li>- <a href="http://hm.hanmam.kr/cooperation/selectMeetingRoomList.do?inputType=all">��� ȸ�ǽ� ����</a></li>
											<li>- <a href="http://hm.hanmam.kr/cooperation/selectPrjBoardMain.do">������Ʈ �Խ���</a></li>
										</ul>
									</td>
									<td class="txt_left">
										<ul><a href="http://hm.hanmam.kr/cooperation/selectProjectList.do">������Ʈ ����</a>
											<li>- <a href="http://hm.hanmam.kr/cooperation/selectProjectList.do">������Ʈ ��Ȳ</a></li>
											<li>- <a href="http://hm.hanmam.kr/cooperation/selectProjectList2.do">������Ʈ �˻�</a></li>
											<li>- <a href="http://hm.hanmam.kr/cooperation/selectProjectDetailList.do?searchPrjType=S">�������� ������Ȳ</a></li>
											<li>- <a href="http://hm.hanmam.kr/cooperation/selectProjectDetailList.do?searchPrjType=B">�������� �����Ȳ</a></li>
											<li>- <a href="http://hm.hanmam.kr/cooperation/selectProjectDetailList.do?searchPrjType=P">�������� ������Ȳ</a></li>
										</ul>
									</td>
									<td class="txt_left">
										<ul><a href="http://hm.hanmam.kr/approval/approvalL.do?mode=2">��������</a>
											<li>- <a href="http://hm.hanmam.kr/approval/approvalL.do?mode=2">��������</a></li>
										</ul>
										<ul><a href="http://hm.hanmam.kr/cooperation/selectSalesProjectList.do">��������</a>
											<li>- <a href="http://hm.hanmam.kr/cooperation/selectSalesProjectList.do">���� ������</a></li>
											<li>- <a href="http://hm.hanmam.kr/cooperation/selectSalesProjectListAll.do">������ ����</a></li>
										</ul>
									</td>
								</tr>
						</tbody>
						</table>
					</div>
					<!-- �������� ��  -->
					
					<!-- ���ڰ��� ���� -->
					<p class="th_stitle">������</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0">
						<colgroup>
							<col class="col200" />
							<col class="col200" />
							<col class="col200" />
							<col class="col200" />
						</colgroup>
						<thead>
							<tr>
								<th>���ڰ��� - ���</th>
								<th>���ڰ��� - ����</th>
								<th>���ڰ��� - ��Ȳ</th>
								<th>���ڰ��� - �˻�</th>
							</tr>
						</thead>
						<tbody id="tableBody">
								<tr>
									<td class="txt_left">
										<ul><a href="http://hm.hanmam.kr/approval/main.do">���ڰ���</a>
											<li>- <a href="http://hm.hanmam.kr/approval/main.do">���ڰ�����Ȳ</a></li>
											<li>- <a href="http://hm.hanmam.kr/approval/appr_NewDraft.do">����ϱ�</a></li>
											<li>- <a href="http://hm.hanmam.kr/approval/approvalL.do?mode=1">����� ����</a></li>
											<li>- <a href="http://hm.hanmam.kr/approval/selectCardSpendList.do">����ī�� �̻�� ����</a></li>
										</ul>
									</td>
									<td class="txt_left">
										<ul><a href="http://hm.hanmam.kr/approval/approvalL.do?mode=2">�����ϱ�</a>
											<li>- <a href="http://hm.hanmam.kr/approval/approvalL.do?mode=2">������ ����</a></li>
											<li>- <a href="http://hm.hanmam.kr/approval/approvalL.do?mode=12">������ ����</a></li>
											<li>- <a href="http://hm.hanmam.kr/approval/approvalL.do?mode=13">ó���ҹ���</a></li>
											<li>- <a href="http://hm.hanmam.kr/approval/approvalL.do?mode=5">�ݷ��� ����</a></li>
										</ul>
									</td>
									<td class="txt_left">
										<ul><a href="http://hm.hanmam.kr/approval/approvalL.do?mode=7">������Ȳ����</a>
											<li>- <a href="http://hm.hanmam.kr/approval/approvalL.do?mode=3">����� ����</a></li>
											<li>- <a href="http://hm.hanmam.kr/approval/approvalL.do?mode=7">�������� ����</a></li>
											<li>- <a href="http://hm.hanmam.kr/approval/approvalL.do?mode=4">�������� ����</a></li>
										</ul>
									</td>
									<td class="txt_left">
										<ul><a href="http://hm.hanmam.kr/approval/approvalL.do?mode=14">�ϷṮ�� �˻�</a>
											<li>- <a href="http://hm.hanmam.kr/approval/approvalL.do?mode=14">��� ���� ����</a></li>
											<li>- <a href="http://hm.hanmam.kr/approval/approvalL.do?mode=10">����� ����</a></li>
											<li>- <a href="http://hm.hanmam.kr/approval/approvalL.do?mode=11">������ ����</a></li>
										</ul>
									</td>
								</tr>
						</tbody>
						</table>
					</div>
					<!-- ���ڰ��� ��  -->

					<!-- Ŀ�´�Ƽ ���� -->
					<p class="th_stitle">Ŀ�´�Ƽ</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0">
						<colgroup>
							<col class="col200" />
							<col class="col200" />
							<col class="col200" />
							<col class="col200" />
						</colgroup>
						<thead>
							<tr>
								<th>�Խ���</th>
								<th>�Խ��� 2</th>
								<th>�系����</th>
								<th>�����</th>
							</tr>
						</thead>
						<tbody id="tableBody">
								<tr>
									<td class="txt_left">
										<ul><a href="http://hm.hanmam.kr/community/selectAllBoardList.do">�Խ���</a>
											<li>- <a href="http://hm.hanmam.kr/community/selectAllBoardList.do">Ŀ�´�Ƽ ��Ȳ</a></li>
											<li>- <a href="http://hm.hanmam.kr/support/selectBoardList.do?bbsId=BBSMSTR_000000000031">��������</a></li>
											<li>- <a href="http://hm.hanmam.kr/support/selectBoardList.do?bbsId=BBSMSTR_000000000033">�˸�����</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectUnreadBoardList.do">�̿��� �Խù�</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectBoardList.do?bbsId=BBSMSTR_000000000001">�����Խ���</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectBoardList.do?bbsId=BBSMSTR_000000000082">ù��� �λ縻</a></li>
										</ul>
									</td>
									<td class="txt_left">
										<ul><a href="http://hm.hanmam.kr/community/selectAllBoardList.do">�Խ��� 2</a>
											<li>- <a href="http://hm.hanmam.kr/community/selectBoardList.do?bbsId=BBSMSTR_000000000029">���</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectBoardList.do?bbsId=BBSMSTR_000000000030">������</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectBoardList.do?bbsId=BBSMSTR_000000000034">����TIP</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectBoardList.do?bbsId=BBSMSTR_000000000001">�����Խ���</a></li>
											<li>- <a href="http://hm.hanmam.kr/support/bpManualList.do">����ó������</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectBoardList.do?bbsId=BBSMSTR_000000000081">��ǰ����</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectBoardList.do?bbsId=BBSMSTR_000000000083">���ȰԽ���</a></li>
										</ul>
									</td>
									<td class="txt_left">
										<ul><a href="http://hm.hanmam.kr/community/selectRecieveMailList.do">�系����</a>
											<li>- <a href="http://hm.hanmam.kr/community/sendMailView.do">�ۼ��ϱ�</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectRecieveMailList.do">����������</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectSendMailList.do">����������</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectSaveMailList.do">�ۼ����� ����</a></li>
										</ul>
										<ul><a href="http://hm.hanmam.kr/community/selectRecieveMailList.do">��������</a>
											<li>- <a href="http://hm.hanmam.kr/community/scheduleCalendar.do">�ֿ�����</a></li>
										</ul>
									</td>
									<td class="txt_left">
										<ul><a href="http://hm.hanmam.kr/community/selectRecieveNoteList.do">����</a>
											<li>- <a href="http://hm.hanmam.kr/community/sendNoteView.do">�ۼ��ϱ�</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectRecieveNoteList.do">��������</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectSendNoteList.do">��������</a></li>
										</ul>
										<ul><a href="http://hm.hanmam.kr/support/selectBoardList.do?bbsId=BBSMSTR_000000000061">�����</a>
											<li>- <a href="http://hm.hanmam.kr/support/selectBoardList.do?bbsId=BBSMSTR_000000000062">����/���� </a></li>
											<li>- <a href="http://hm.hanmam.kr/support/selectBoardList.do?bbsId=BBSMSTR_000000000061">�Ѹ��� ������û</a></li>
										</ul>
									</td>
								</tr>
						</tbody>
						</table>
					</div>
					<!-- Ŀ�´�Ƽ ��  -->

					<!-- �濵���� ���� -->
					<p class="th_stitle">Ŀ�´�Ƽ</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0">
						<colgroup>
							<col class="col200" />
							<col class="col200" />
							<col class="col200" />
							<col class="col200" />
						</colgroup>
						<thead>
							<tr>
								<th>�Խ���</th>
								<th>�Խ��� 2</th>
								<th>�系����</th>
								<th>�����</th>
							</tr>
						</thead>
						<tbody id="tableBody">
								<tr>
									<td class="txt_left">
					<ul class="menu_list">
						<li><a href="${rootPath}/management/monthResultStatistic.do">�濵�м�</a>
							<ul class="smenu">
								<li><a href="#" onclick="javascript:MM_openBrWindow('${rootPath}/management/saleResultStatistic.do', '_SALE_STATISTIC_POP_', 'width=1040px,height=803px,scrollbars=yes');">����� ��������</a></li>
								<li><a href="#" onclick="javascript:MM_openBrWindow('${rootPath}/management/perfResultStatistic.do', '_PERF_STATISTIC_POP_', 'width=1030px,height=803px,scrollbars=yes');">����� ��������</a></li>
								<li><a href="#" onclick="javascript:MM_openBrWindow('${rootPath}/management/commResultStatistic.do', '_COMM_STATISTIC_POP_', 'width=1030px,height=803px,scrollbars=yes');">����� ��������</a></li>
								 
							</ul>
						</li>
						<li><a href="${rootPath}/management/monthResultStatistic.do">�������</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/monthResultStatistic.do?searchRecalcYn=Y">����������� (�ǽð�)</a></li>
								<li><a href="${rootPath}/management/monthResultStatistic.do">����������� (��������)</a></li>
								<li><a href="${rootPath}/management/projectResultStatistic.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">������Ʈ�� ����</a></li>
								<li><a href="${rootPath}/management/planResultStatistic.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">�ǰ��������</a></li>
								<li><a href="${rootPath}/management/stepResultStatistic.do">�ٴܰ� �����м�</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/management/selectAnnualBusinessPlan.do">�����ȹ</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/selectAnnualBusinessPlan.do">���������ȹ</a></li>
								<li><a href="${rootPath}/management/prjPlanCostList.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">������Ʈ�� ����</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/management/salesList.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">�������</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/salesList.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">����ǰ���</a></li>
								<li><a href="${rootPath}/management/innerSalesList.do">�系���⳻��</a></li>
								<li><a href="${rootPath}/management/outerPurchaseList.do?searchType=ORG">��ܸ��Գ���</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/fund/chckOrgSalesList.do">ä�ǰ���</a>
							<ul class="smenu">
								<li><a href="${rootPath}/fund/chckOrgSalesList.do">ä�ǰ���</a></li>
								<li><a href="${rootPath}/fund/chckProjectSalesCheckList.do">���ݳ���</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/management/bondOrg.do">ä�ǰ���(����)</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/bondOrg.do">ä�ǰ���</a></li>
								<li><a href="${rootPath}/management/collectionFullL.do">���ݳ���</a></li>
							</ul>
						</li>
						<li><a href="${rootPath}/management/selectExpenseStatistic.do">������</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/selectExpenseStatistic.do">������⳻��</a></li>
								<!-- <li><a href="javascript:alert('�غ����Դϴ�.');">����ī���볻��</a></li> -->
							</ul>
						</li>
						<li><a href="${rootPath}/management/selectInputResultPerson.do">�η����԰���</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/selectInputResultPlanPersonStatus.do">���κ� ���� ��ȹ ��Ȳ</a></li>
								<li><a href="${rootPath}/management/selectInputResultPlanPerson.do">���κ� ���� ��ȹ/����</a></li>
								<li><a href="${rootPath}/management/selectInputResultPlanProject.do?searchCondition=1&searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">������Ʈ�� ���� ��ȹ/����</a></li>
								<li><a href="${rootPath}/management/selectInputResultPerson.do">���κ� ���Խ���</a></li>
								<li><a href="${rootPath}/management/selectInputResultDept.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">�μ��� ���Խ���</a></li>
								<li><a href="${rootPath}/management/selectInputResultProject.do?searchOrgId=${user.orgnztId}&searchOrgNm=${user.orgnztNm}">������Ʈ�� ���Խ���</a></li>
								<!-- <li><a href="${rootPath}/management/prjInputPlanMgmt.do">������Ʈ ���԰�ȹ</a></li> -->
							</ul>
						</li>
						<li><a href="${rootPath}/management/contractL.do?searchTyp=W">���ǰ���</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/contractL.do?searchTyp=W">���ְ��</a></li>
								<li><a href="${rootPath}/management/contractL.do?searchTyp=O">���ְ��</a></li>
							</ul>
						</li>
						<c:if test="${user.admin }">
						<li><a href="${rootPath}/management/fundWeekly.do">�ڱݰ���</a>
							<ul class="smenu">
								<li><a href="${rootPath}/management/fundWeekly.do">�ְ��ڱݺ���</a></li>
								<li><a href="${rootPath}/management/fundMonthly.do">�����ڱݺ���</a></li>
							</ul>
						</li>
						</c:if>
					</ul>
									</td>
									<td class="txt_left">
										<ul><a href="http://hm.hanmam.kr/community/selectAllBoardList.do">�Խ��� 2</a>
											<li>- <a href="http://hm.hanmam.kr/community/selectBoardList.do?bbsId=BBSMSTR_000000000029">���</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectBoardList.do?bbsId=BBSMSTR_000000000030">������</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectBoardList.do?bbsId=BBSMSTR_000000000034">����TIP</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectBoardList.do?bbsId=BBSMSTR_000000000001">�����Խ���</a></li>
											<li>- <a href="http://hm.hanmam.kr/support/bpManualList.do">����ó������</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectBoardList.do?bbsId=BBSMSTR_000000000081">��ǰ����</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectBoardList.do?bbsId=BBSMSTR_000000000083">���ȰԽ���</a></li>
										</ul>
									</td>
									<td class="txt_left">
										<ul><a href="http://hm.hanmam.kr/community/selectRecieveMailList.do">�系����</a>
											<li>- <a href="http://hm.hanmam.kr/community/sendMailView.do">�ۼ��ϱ�</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectRecieveMailList.do">����������</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectSendMailList.do">����������</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectSaveMailList.do">�ۼ����� ����</a></li>
										</ul>
										<ul><a href="http://hm.hanmam.kr/community/selectRecieveMailList.do">��������</a>
											<li>- <a href="http://hm.hanmam.kr/community/scheduleCalendar.do">�ֿ�����</a></li>
										</ul>
									</td>
									<td class="txt_left">
										<ul><a href="http://hm.hanmam.kr/community/selectRecieveNoteList.do">����</a>
											<li>- <a href="http://hm.hanmam.kr/community/sendNoteView.do">�ۼ��ϱ�</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectRecieveNoteList.do">��������</a></li>
											<li>- <a href="http://hm.hanmam.kr/community/selectSendNoteList.do">��������</a></li>
										</ul>
										<ul><a href="http://hm.hanmam.kr/support/selectBoardList.do?bbsId=BBSMSTR_000000000061">�����</a>
											<li>- <a href="http://hm.hanmam.kr/support/selectBoardList.do?bbsId=BBSMSTR_000000000062">����/���� </a></li>
											<li>- <a href="http://hm.hanmam.kr/support/selectBoardList.do?bbsId=BBSMSTR_000000000061">�Ѹ��� ������û</a></li>
										</ul>
									</td>
								</tr>
						</tbody>
						</table>
					</div>
					<!-- �������� ��  -->

					<!-- ��ư ���� -->
					<div class="btn_area">
						<a href="${rootPath}/mypage/addMymenu.do"><img src="${imagePath}/btn/btn_add.gif"/></a>
					</div>
					<!-- ��ư �� -->
					
				</div>
				<!-- E: section -->
			</div>
			<!-- E: center -->
			<%@ include file="../include/right.jsp"%>
			</div>	
			<!-- E: centerBg -->
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
