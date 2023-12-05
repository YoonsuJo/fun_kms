package kms.com.license.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.saeha.chorusvc.license.client.LicenseView.Client;
import com.saeha.chorusvc.license.client.LicenseView.Function;

public class LicenseVO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	/** 검색Keyword */
	private String searchCompanyName;
	private String searchExpireDateStart;
	private String searchExpireDateEnd;
	private String searchProduct;
	
	/*페이지 관련*/
	private int rowLen = 15;
	private int page = 1;
	private int rowTotalCount;
	private int pageTotalCount;
	
	private String flagVM;
	private String licenseId;
	private String historyId;
	private String licenseView;
	private String product;
	private String companyName;
	private String person;			//담당자명
	private String phone;			//연락처
	private String serverIpAddr;
	private String serverMacAddr;
	private List<Function> functionList = new ArrayList<Function>();
	private List<Client> clientList = new ArrayList<Client>();
	private int maxUser;
	private int maxUserLimit;
	private String expireDate;
	private boolean unlimited;
	private String memo;
	private String count;
	private int gubun;

	
	
	public int getGubun() {
		return gubun;
	}
	public void setGubun(int gubun) {
		this.gubun = gubun;
	}
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	public String getSearchCompanyName() {
		return searchCompanyName;
	}
	public void setSearchCompanyName(String searchCompanyName) {
		this.searchCompanyName = searchCompanyName;
	}
	public String getSearchExpireDateStart() {
		return searchExpireDateStart;
	}
	public void setSearchExpireDateStart(String searchExpireDateStart) {
		this.searchExpireDateStart = searchExpireDateStart;
	}
	public String getSearchExpireDateEnd() {
		return searchExpireDateEnd;
	}
	public void setSearchExpireDateEnd(String searchExpireDateEnd) {
		this.searchExpireDateEnd = searchExpireDateEnd;
	}
	public String getSearchProduct() {
		return searchProduct;
	}
	public void setSearchProduct(String searchProduct) {
		this.searchProduct = searchProduct;
	}
	public String getLicenseId() {
		return licenseId;
	}
	public void setLicenseId(String licenseId) {
		this.licenseId = licenseId;
	}
	public String getHistoryId() {
		return historyId;
	}
	public void setHistoryId(String historyId) {
		this.historyId = historyId;
	}
	public String getLicenseView() {
		return licenseView;
	}
	public void setLicenseView(String licenseView) {
		this.licenseView = licenseView;
	}
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getPerson() {
		return person;
	}
	public void setPerson(String person) {
		this.person = person;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getServerIpAddr() {
		return serverIpAddr;
	}
	public void setServerIpAddr(String serverIpAddr) {
		this.serverIpAddr = serverIpAddr;
	}
	public String getServerMacAddr() {
		return serverMacAddr;
	}
	public void setServerMacAddr(String serverMacAddr) {
		this.serverMacAddr = serverMacAddr;
	}
	public List<Function> getFunctionList() {
		return functionList;
	}
	public void setFunctionList(List<Function> functionList) {
		this.functionList = functionList;
	}
	public List<Client> getClientList() {
		return clientList;
	}
	public void setClientList(List<Client> clientList) {
		this.clientList = clientList;
	}
	public int getMaxUser() {
		return maxUser;
	}
	public void setMaxUser(int maxUser) {
		this.maxUser = maxUser;
	}
	public int getMaxUserLimit() {
		return maxUserLimit;
	}
	public void setMaxUserLimit(int maxUserLimit) {
		this.maxUserLimit = maxUserLimit;
	}
	public String getExpireDate() {
		return expireDate;
	}
	public void setExpireDate(String expireDate) {
		this.expireDate = expireDate;
	}
	public boolean isUnlimited() {
		return unlimited;
	}
	public void setUnlimited(boolean unlimited) {
		this.unlimited = unlimited;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getFlagVM() {
		return flagVM;
	}
	public void setFlagVM(String flagVM) {
		this.flagVM = flagVM;
	}
	public int getRowLen() {
		return rowLen;
	}
	public void setRowLen(int rowLen) {
		this.rowLen = rowLen;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRowTotalCount() {
		return rowTotalCount;
	}
	public void setRowTotalCount(int rowTotalCount) {
		this.rowTotalCount = rowTotalCount;
	}
	public int getPageTotalCount() {
		return pageTotalCount;
	}
	public void setPageTotalCount(int pageTotalCount) {
		this.pageTotalCount = pageTotalCount;
	}
	
}
