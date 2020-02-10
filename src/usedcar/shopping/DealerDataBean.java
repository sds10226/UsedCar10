package usedcar.shopping;

import java.sql.Timestamp;

public class DealerDataBean implements membertype{ // 김상헌

	private String user_id; // 딜러 아이디
	private String passwd; // 딜러 비밀번호
	private String name; // 딜러 이름
	private String birth; // 딜러 생년월일
	private String gender; // 딜러 성별
	private String q_passwd;// 딜러 비밀번호 질문
	private String ans_passwd; //딜러 비밀번호 찾기 질문
	private String address; // 딜러 주소
	private String address1; // 딜러 주소1
	private String address2; // 딜러 주소2
	private String address3; // 딜러 주소3
	private String phone; // 딜러 전화번호
	private String tel; // 딜러 핸드폰 번호
	private String email; // 딜러 이메일
	private Timestamp reg_date; // 딜러 회원가입일
	private String union; // 조합 상호
	private String company_name; // 사업장 상호
	private String bussiness_num; // 사업자 등록번호
	private String company_addr; // 사업장 주소
	private String company_addr1; // 사업장 주소1
	private String company_addr2; // 사업장 주소2
	private String company_addr3; // 사업장 주소3
	private String company_tel; // 사업장 전화번호
	private String company_fax; // 사업장 팩스번호
	private String emp_id; // 사원번호
	private String img; // 증명사진
	private String introduction; // 자기소개글
	private int auth; // 권한승인여부
	private String membertype; // 고객 타입
	
	public DealerDataBean() {
		
	}
	
	
	public DealerDataBean(String user_id, String passwd, String name, String birth, String gender, String q_passwd,
			String ans_passwd, String address, String address1, String address2, String address3, String phone,
			String tel, String email, Timestamp reg_date, String union, String company_name, String bussiness_num,
			String company_addr, String company_addr1, String company_addr2, String company_addr3, String company_tel,
			String company_fax, String emp_id, String img, String introduction, int auth, String membertype) {
		this.user_id = user_id;
		this.passwd = passwd;
		this.name = name;
		this.birth = birth;
		this.gender = gender;
		this.q_passwd = q_passwd;
		this.ans_passwd = ans_passwd;
		this.address = address;
		this.address1 = address1;
		this.address2 = address2;
		this.address3 = address3;
		this.phone = phone;
		this.tel = tel;
		this.email = email;
		this.reg_date = reg_date;
		this.union = union;
		this.company_name = company_name;
		this.bussiness_num = bussiness_num;
		this.company_addr = company_addr;
		this.company_addr1 = company_addr1;
		this.company_addr2 = company_addr2;
		this.company_addr3 = company_addr3;
		this.company_tel = company_tel;
		this.company_fax = company_fax;
		this.emp_id = emp_id;
		this.img = img;
		this.introduction = introduction;
		this.auth = auth;
		this.membertype = membertype;
	}


	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getQ_passwd() {
		return q_passwd;
	}
	public void setQ_passwd(String q_passwd) {
		this.q_passwd = q_passwd;
	}
	public String getAns_passwd() {
		return ans_passwd;
	}
	public void setAns_passwd(String ans_passwd) {
		this.ans_passwd = ans_passwd;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getAddress3() {
		return address3;
	}
	public void setAddress3(String address3) {
		this.address3 = address3;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public String getUnion() {
		return union;
	}
	public void setUnion(String union) {
		this.union = union;
	}
	public String getCompany_name() {
		return company_name;
	}
	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	public String getBussiness_num() {
		return bussiness_num;
	}
	public void setBussiness_num(String bussiness_num) {
		this.bussiness_num = bussiness_num;
	}
	public String getCompany_addr() {
		return company_addr;
	}
	public void setCompany_addr(String company_addr) {
		this.company_addr = company_addr;
	}
	public String getCompany_addr1() {
		return company_addr1;
	}
	public void setCompany_addr1(String company_addr1) {
		this.company_addr1 = company_addr1;
	}
	public String getCompany_addr2() {
		return company_addr2;
	}
	public void setCompany_addr2(String company_addr2) {
		this.company_addr2 = company_addr2;
	}
	public String getCompany_addr3() {
		return company_addr3;
	}
	public void setCompany_addr3(String company_addr3) {
		this.company_addr3 = company_addr3;
	}
	public String getCompany_tel() {
		return company_tel;
	}
	public void setCompany_tel(String company_tel) {
		this.company_tel = company_tel;
	}
	public String getCompany_fax() {
		return company_fax;
	}
	public void setCompany_fax(String company_fax) {
		this.company_fax = company_fax;
	}
	public String getEmp_id() {
		return emp_id;
	}
	public void setEmp_id(String emp_id) {
		this.emp_id = emp_id;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public int getAuth() {
		return auth;
	}
	public void setAuth(int auth) {
		this.auth = auth;
	}
	public String getMembertype() {
		return membertype;
	}
	public void setMembertype(String membertype) {
		this.membertype = membertype;
	}
	@Override
	public String toString() {
		return "DealerDataBean [user_id=" + user_id + ", passwd=" + passwd + ", name=" + name + ", birth=" + birth
				+ ", gender=" + gender + ", q_passwd=" + q_passwd + ", ans_passwd=" + ans_passwd + ", address="
				+ address + ", address1=" + address1 + ", address2=" + address2 + ", address3=" + address3 + ", phone="
				+ phone + ", tel=" + tel + ", email=" + email + ", reg_date=" + reg_date + ", union=" + union
				+ ", company_name=" + company_name + ", bussiness_num=" + bussiness_num + ", company_addr="
				+ company_addr + ", company_addr1=" + company_addr1 + ", company_addr2=" + company_addr2
				+ ", company_addr3=" + company_addr3 + ", company_tel=" + company_tel + ", company_fax=" + company_fax
				+ ", emp_id=" + emp_id + ", img=" + img + ", introduction=" + introduction + ", auth=" + auth
				+ ", membertype=" + membertype + "]";
	}

}
