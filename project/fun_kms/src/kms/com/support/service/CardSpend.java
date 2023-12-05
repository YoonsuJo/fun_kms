package kms.com.support.service;

import java.io.Serializable;


/**
 * @Class Name : TblCardSpendVO.java
 * @Description : TblCardSpend VO class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.11.16
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class CardSpend implements Serializable{
    private static final long serialVersionUID = 1L;
    
    /** CARD_SPEND_NO */
    private int cardSpendNo;
    
    /** RECEIVE_INFO_TYP */
    private String receiveInfoTyp;
    
    /** CARD_ID */
    private String cardId;
    
    /** CARD_TYP */
    private String cardTyp;
    
    /** PAY_ACCOUNT_NUMBER */
    private String payAccountNumber;
    
    /** PAY_BANK_NM */
    private String payBankNm;
    
    /** SPECIFIER_NM */
    private String specifierNm;
    
    /** DOMESTIC_FOREIGN */
    private String domesticForeign;
    
    /** APPROVAL_NO */
    private String approvalNo;
    
    /** APPROVAL_DT */
    private String approvalDt;
    
    /** APPROVAL_TM */
    private String approvalTm;
    
    /** SALES_TYP */
    private String salesTyp;
    
    /** APPROVED_SPEND */
    private int approvedSpend;
    
    /** APPROVED_SPEND_FOREIGN_CURRENCY */
    private int approvedSpendForeignCurrency;
    
    /** SPNED_SIGN_CD */
    private String spendSignCd;
    
    /** REAL_SPEND */
    private int realSpend;
    
    /** SURTAX */
    private int surtax;
    
    /** SERVICE_CHARGE */
    private int serviceCharge;
    
    /** INSTALLMENT_PERIOD */
    private String installmentPeriod;
    
    /** EXCHANGE_RATE */
    private String exchangeRate;
    
    /** EXCHANGE_NATION_CD */
    private String exchangeNationCd;
    
    /** EXCHANGE_NATION_NM */
    private String exchangeNationNm;
    
    /** STORE_BUSINESS_NO */
    private String storeBusinessNo;
    
    /** STORE_BUSINESS_NM */
    private String storeBusinessNm;
    
    /** STORE_BUSINESS_TYP */
    private String storeBusinessTyp;
    
    /** STORE_ZIP_CD */
    private String storeZipCd;
    
    /** STORE_ADDRESS1 */
    private String storeAddress1;
    
    /** STORE_ADDRESS2 */
    private String storeAddress2;
    
    /** STORE_PHONE_NUMBER */
    private String storePhoneNumber;
    
    /** ACCOUNT_CD */
    private String accountCd;
    
    /** ACCOUNT_NM */
    private String accountNm;
    
    /** HEADQUATER_NM */
    private String headquaterNm;
    
    /** DEPARTMENT_NM */
    private String departmentNm;
    
    public int getCardSpendNo() {
        return this.cardSpendNo;
    }
    
    public void setCardSpendNo(int cardSpendNo) {
        this.cardSpendNo = cardSpendNo;
    }
    
    public String getReceiveInfoTyp() {
        return this.receiveInfoTyp;
    }
    
    public void setReceiveInfoTyp(String receiveInfoTyp) {
        this.receiveInfoTyp = receiveInfoTyp;
    }
    
    public String getCardId() {
        return this.cardId;
    }
    
    public void setCardId(String cardId) {
        this.cardId = cardId;
    }
    
    public String getCardTyp() {
        return this.cardTyp;
    }
    
    public void setCardTyp(String cardTyp) {
        this.cardTyp = cardTyp;
    }
    
    public String getPayAccountNumber() {
        return this.payAccountNumber;
    }
    
    public void setPayAccountNumber(String payAccountNumber) {
        this.payAccountNumber = payAccountNumber;
    }
    
    public String getPayBankNm() {
        return this.payBankNm;
    }
    
    public void setPayBankNm(String payBankNm) {
        this.payBankNm = payBankNm;
    }
    
    public String getSpecifierNm() {
        return this.specifierNm;
    }
    
    public void setSpecifierNm(String specifierNm) {
        this.specifierNm = specifierNm;
    }
    
    public String getDomesticForeign() {
        return this.domesticForeign;
    }
    
    public void setDomesticForeign(String domesticForeign) {
        this.domesticForeign = domesticForeign;
    }
    
    public String getApprovalNo() {
        return this.approvalNo;
    }
    
    public void setApprovalNo(String approvalNo) {
        this.approvalNo = approvalNo;
    }
    
    public String getApprovalDt() {
        return this.approvalDt;
    }
    
    public void setApprovalDt(String approvalDt) {
        this.approvalDt = approvalDt;
    }
    
    public String getApprovalTm() {
        return this.approvalTm;
    }
    
    public void setApprovalTm(String approvalTm) {
        this.approvalTm = approvalTm;
    }
    
    public String getSalesTyp() {
        return this.salesTyp;
    }
    
    public void setSalesTyp(String salesTyp) {
        this.salesTyp = salesTyp;
    }
    
    public int getApprovedSpend() {
        return this.approvedSpend;
    }
    
    public void setApprovedSpend(int approvedSpend) {
        this.approvedSpend = approvedSpend;
    }
    
    public int getApprovedSpendForeignCurrency() {
        return this.approvedSpendForeignCurrency;
    }
    
    public void setApprovedSpendForeignCurrency(int approvedSpendForeignCurrency) {
        this.approvedSpendForeignCurrency = approvedSpendForeignCurrency;
    }
    
    public int getRealSpend() {
        return this.realSpend;
    }
    
    public void setRealSpend(int realSpend) {
        this.realSpend = realSpend;
    }
    
    public int getSurtax() {
        return this.surtax;
    }
    
    public void setSurtax(int surtax) {
        this.surtax = surtax;
    }
    
    public int getServiceCharge() {
        return this.serviceCharge;
    }
    
    public void setServiceCharge(int serviceCharge) {
        this.serviceCharge = serviceCharge;
    }
    
    public String getInstallmentPeriod() {
        return this.installmentPeriod;
    }
    
    public void setInstallmentPeriod(String installmentPeriod) {
        this.installmentPeriod = installmentPeriod;
    }
    
    public String getExchangeRate() {
        return this.exchangeRate;
    }
    
    public void setExchangeRate(String exchangeRate) {
        this.exchangeRate = exchangeRate;
    }
    
    public String getExchangeNationCd() {
        return this.exchangeNationCd;
    }
    
    public void setExchangeNationCd(String exchangeNationCd) {
        this.exchangeNationCd = exchangeNationCd;
    }
    
    public String getExchangeNationNm() {
        return this.exchangeNationNm;
    }
    
    public void setExchangeNationNm(String exchangeNationNm) {
        this.exchangeNationNm = exchangeNationNm;
    }
    
    public String getStoreBusinessNo() {
        return this.storeBusinessNo;
    }
    
    public void setStoreBusinessNo(String storeBusinessNo) {
        this.storeBusinessNo = storeBusinessNo;
    }
    
    public String getStoreBusinessNm() {
        return this.storeBusinessNm;
    }
    
    public void setStoreBusinessNm(String storeBusinessNm) {
        this.storeBusinessNm = storeBusinessNm;
    }
    
    public String getStoreBusinessTyp() {
        return this.storeBusinessTyp;
    }
    
    public void setStoreBusinessTyp(String storeBusinessTyp) {
        this.storeBusinessTyp = storeBusinessTyp;
    }
    
    public String getStoreZipCd() {
        return this.storeZipCd;
    }
    
    public void setStoreZipCd(String storeZipCd) {
        this.storeZipCd = storeZipCd;
    }
    
    public String getStoreAddress1() {
        return this.storeAddress1;
    }
    
    public void setStoreAddress1(String storeAddress1) {
        this.storeAddress1 = storeAddress1;
    }
    
    public String getStoreAddress2() {
        return this.storeAddress2;
    }
    
    public void setStoreAddress2(String storeAddress2) {
        this.storeAddress2 = storeAddress2;
    }
    
    public String getStorePhoneNumber() {
        return this.storePhoneNumber;
    }
    
    public void setStorePhoneNumber(String storePhoneNumber) {
        this.storePhoneNumber = storePhoneNumber;
    }
    
    public String getAccountCd() {
        return this.accountCd;
    }
    
    public void setAccountCd(String accountCd) {
        this.accountCd = accountCd;
    }
    
    public String getAccountNm() {
        return this.accountNm;
    }
    
    public void setAccountNm(String accountNm) {
        this.accountNm = accountNm;
    }
    
    public String getHeadquaterNm() {
        return this.headquaterNm;
    }
    
    public void setHeadquaterNm(String headquaterNm) {
        this.headquaterNm = headquaterNm;
    }
    
    public String getDepartmentNm() {
        return this.departmentNm;
    }
    
    public void setDepartmentNm(String departmentNm) {
        this.departmentNm = departmentNm;
    }

	public void setSpendSignCd(String spendSignCd) {
		this.spendSignCd = spendSignCd;
	}

	public String getSpendSignCd() {
		return spendSignCd;
	}
    
}
