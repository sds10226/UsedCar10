package usedcar.shopping;

import java.sql.Timestamp;

//-------------------------------------------------------------------------------------------------
//start - public class CustomerDataBean
//-------------------------------------------------------------------------------------------------
public class CustomerDataBean implements membertype{ //김상헌

	private String user_id; // 고객 아이디
	private String passwd; // 고객 비밀번호
	private String name; // 고객 이름
	private String birth; // 고객 생년월일
	private String q_passwd; //고객 비밀번호 찾기 질문
	private String ans_passwd; //고객 비밀번호 찾기 답변
	private String gender; // 고객 성별
	private String address; // 고객 주소
	private String address1; // 고객 주소
	private String address2; // 고객 주소
	private String address3; // 고객 주소
	private String phone; // 고객 전화번호
	private String tel; // 고객 핸드폰 번호
	private String email; // 고객 이메일
	private String img;	//고객 사진
	private Timestamp reg_date; // 고객 회원가입일
	private String membertype; // 고객 타입
	
	
	
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
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
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
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public String getMembertype() {
		return membertype;
	}
	public void setMembertype(String membertype) {
		this.membertype = membertype;
	}
	
	
	@Override
	public String toString() {
		return "CustomerDataBean [user_id=" + user_id + ", passwd=" + passwd + ", name=" + name + ", birth=" + birth
				+ ", q_passwd=" + q_passwd + ", ans_passwd=" + ans_passwd + ", gender=" + gender + ", address="
				+ address + ", address1=" + address1 + ", address2=" + address2 + ", address3=" + address3 + ", phone="
				+ phone + ", tel=" + tel + ", email=" + email + ", img=" + img + ", reg_date=" + reg_date
				+ ", membertype=" + membertype + "]";
	}
	
	




	




}
// -------------------------------------------------------------------------------------------------
// End - public class CustomerDataBean
// -------------------------------------------------------------------------------------------------