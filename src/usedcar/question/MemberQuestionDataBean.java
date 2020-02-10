package usedcar.question;

import java.sql.Timestamp;

public class MemberQuestionDataBean { //김상헌

	int q_idx;
	int car_idx;
	String user_id;
	int car_own;
	String inquiry;
	String dealer_id;
	Timestamp reg_date;
	
	public int getQ_idx() {
		return q_idx;
	}
	public void setQ_idx(int q_idx) {
		this.q_idx = q_idx;
	}
	public int getCar_idx() {
		return car_idx;
	}
	public void setCar_idx(int car_idx) {
		this.car_idx = car_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getCar_own() {
		return car_own;
	}
	public void setCar_own(int car_own) {
		this.car_own = car_own;
	}
	public String getInquiry() {
		return inquiry;
	}
	public void setInquiry(String inquiry) {
		this.inquiry = inquiry;
	}
	public String getDealer_id() {
		return dealer_id;
	}
	public void setDealer_id(String dealer_id) {
		this.dealer_id = dealer_id;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	@Override
	public String toString() {
		return "memberQuestionDataBean [q_idx=" + q_idx + ", car_idx=" + car_idx + ", user_id=" + user_id + ", car_own="
				+ car_own + ", inquiry=" + inquiry + ", dealer_id=" + dealer_id + ", reg_date=" + reg_date + "]";
	}
	
}
