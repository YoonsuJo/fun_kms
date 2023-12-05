package kms.com.support.service;

public class Equip {
	private String equip_no;
	private String serial_no;
	private String model;
	private String cpu;
	private String memory;
	private String vga;
	private String hdd;
	private String odd;
	private String etc;
	private String status;
	private String reg_dt;
	private String udt_dt;
	private String user_id;
	private String user_nm;
	private String place;
	private String idx;
	private String user_yn;
	private String team_name;
	private String equip_type;
	private String rankNm;
	private String orgnztNm;
	private String use_purps;	// 사용이력 -> 사용목적 추가
	
	private int desctop;
	private int monitor;
	private int notebook;
	private int server;
	private int tool;
	private String userMix;

	private String buy_place;
	private String buy_addr;
	private String buy_tel;
	private String buy_dt;
	private String sirial_no;
	private Long buy_price;

	private String type_no;
	private String type_name;
	private String type_value;
	private int type_cnt;
	
	//수리이력 시작
	private int regNo;
	private String regNm;	
	private int udtNo;
	private String udtNm;
	private String repairDt;
	private int cost;
	private String content;
	private String note;
	//수리이력 끝
	
	
	public int getDesctop() {
		return desctop;
	}
	public void setDesctop(int desctop) {
		this.desctop = desctop;
	}
	public int getMonitor() {
		return monitor;
	}
	public void setMonitor(int monitor) {
		this.monitor = monitor;
	}
	public int getNotebook() {
		return notebook;
	}
	public void setNotebook(int notebook) {
		this.notebook = notebook;
	}
	public int getServer() {
		return server;
	}
	public void setServer(int server) {
		this.server = server;
	}
	public int getTool() {
		return tool;
	}
	public void setTool(int tool) {
		this.tool = tool;
	}
	public String getEquip_no() {
		return equip_no;
	}
	public void setEquip_no(String equip_no) {
		this.equip_no = equip_no;
	}
	public String getSerial_no() {
		return serial_no;
	}
	public void setSerial_no(String serial_no) {
		this.serial_no = serial_no;
	}
	public Long getBuy_price() {
		return buy_price;
	}
	public void setBuy_price(Long buy_price) {
		this.buy_price = buy_price;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getMemory() {
		return memory;
	}
	public void setMemory(String memory) {
		this.memory = memory;
	}
	public String getVga() {
		return vga;
	}
	public void setVga(String vga) {
		this.vga = vga;
	}
	public String getHdd() {
		return hdd;
	}
	public void setHdd(String hdd) {
		this.hdd = hdd;
	}
	public String getOdd() {
		return odd;
	}
	public void setOdd(String odd) {
		this.odd = odd;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getUdt_dt() {
		return udt_dt;
	}
	public void setUdt_dt(String udt_dt) {
		this.udt_dt = udt_dt;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getUser_yn() {
		return user_yn;
	}
	public void setUser_yn(String user_yn) {
		this.user_yn = user_yn;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public void setEquip_type(String equip_type) {
		this.equip_type = equip_type;
	}
	public String getEquip_type() {
		return equip_type;
	}
	public void setCpu(String cpu) {
		this.cpu = cpu;
	}
	public String getCpu() {
		return cpu;
	}
	public void setUserMix(String userMix) {
		this.userMix = userMix;
	}
	public String getUserMix() {
		return userMix;
	}
	public void setBuy_place(String buy_place) {
		this.buy_place = buy_place;
	}
	public String getBuy_place() {
		return buy_place;
	}
	public void setBuy_addr(String buy_addr) {
		this.buy_addr = buy_addr;
	}
	public String getBuy_addr() {
		return buy_addr;
	}
	public void setBuy_tel(String buy_tel) {
		this.buy_tel = buy_tel;
	}
	public String getBuy_tel() {
		return buy_tel;
	}
	public void setBuy_dt(String buy_dt) {
		this.buy_dt = buy_dt;
	}
	public String getBuy_dt() {
		return buy_dt;
	}
	public void setSirial_no(String sirial_no) {
		this.sirial_no = sirial_no;
	}
	public String getSirial_no() {
		return sirial_no;
	}
	public void setType_no(String type_no) {
		this.type_no = type_no;
	}
	public String getType_no() {
		return type_no;
	}
	public void setType_name(String type_name) {
		this.type_name = type_name;
	}
	public String getType_name() {
		return type_name;
	}
	public void setType_value(String type_value) {
		this.type_value = type_value;
	}
	public String getType_value() {
		return type_value;
	}
	public void setType_cnt(int type_cnt) {
		this.type_cnt = type_cnt;
	}
	public int getType_cnt() {
		return type_cnt;
	}
	public void setRankNm(String rankNm) {
		this.rankNm = rankNm;
	}
	public String getRankNm() {
		return rankNm;
	}
	public void setOrgnztNm(String orgnztNm) {
		this.orgnztNm = orgnztNm;
	}
	public String getOrgnztNm() {
		return orgnztNm;
	}
	public void setRegNo(int regNo) {
		this.regNo = regNo;
	}
	public int getRegNo() {
		return regNo;
	}
	public void setUdtNo(int udtNo) {
		this.udtNo = udtNo;
	}
	public int getUdtNo() {
		return udtNo;
	}
	public void setCost(int cost) {
		this.cost = cost;
	}
	public int getCost() {
		return cost;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getContent() {
		return content;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getNote() {
		return note;
	}
	public void setRepairDt(String repairDt) {
		this.repairDt = repairDt;
	}
	public String getRepairDt() {
		return repairDt;
	}
	public void setRegNm(String regNm) {
		this.regNm = regNm;
	}
	public String getRegNm() {
		return regNm;
	}
	public void setUdtNm(String udtNm) {
		this.udtNm = udtNm;
	}
	public String getUdtNm() {
		return udtNm;
	}
	public String getUse_purps() {
		return use_purps;
	}
	public void setUse_purps(String use_purps) {
		this.use_purps = use_purps;
	}
}
