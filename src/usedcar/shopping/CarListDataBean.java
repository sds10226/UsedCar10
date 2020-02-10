package usedcar.shopping;

import java.sql.Timestamp;

public class CarListDataBean { // - 신동수
	private int car_idx;
	private String car_img1;
	private String car_img2;
	private String car_img3;
	private String title;
	private String dealer_id;
	private String description;
	private Timestamp reg_date;
	private int sel_status;
	private String car_type;
	private String car_brand;
	private String car_model;
	private String car_cc;
	private String car_oilType;
	private String car_birth;
	private String car_mileage;
	private String car_price;
	private String car_location;
	private String car_color;
	private String car_gear;
	private String car_option;
	private String car_regNum;

	public CarListDataBean() {
		// TODO Auto-generated constructor stub
	}
	
	public CarListDataBean(int car_idx, String car_img1, String car_img2, String car_img3, String title,
			String dealer_id, String description, Timestamp reg_date, int sel_status, String car_type, String car_brand,
			String car_model, String car_cc, String car_oilType, String car_birth, String car_mileage, String car_price,
			String car_location, String car_color, String car_gear, String car_option, String car_regNum) {
		super();
		this.car_idx = car_idx;
		this.car_img1 = car_img1;
		this.car_img2 = car_img2;
		this.car_img3 = car_img3;
		this.title = title;
		this.dealer_id = dealer_id;
		this.description = description;
		this.reg_date = reg_date;
		this.sel_status = sel_status;
		this.car_type = car_type;
		this.car_brand = car_brand;
		this.car_model = car_model;
		this.car_cc = car_cc;
		this.car_oilType = car_oilType;
		this.car_birth = car_birth;
		this.car_mileage = car_mileage;
		this.car_price = car_price;
		this.car_location = car_location;
		this.car_color = car_color;
		this.car_gear = car_gear;
		this.car_option = car_option;
		this.car_regNum = car_regNum;
	}


	public int getCar_idx() {
		return car_idx;
	}


	public void setCar_idx(int car_idx) {
		this.car_idx = car_idx;
	}


	public String getCar_img1() {
		return car_img1;
	}


	public void setCar_img1(String car_img1) {
		this.car_img1 = car_img1;
	}


	public String getCar_img2() {
		return car_img2;
	}


	public void setCar_img2(String car_img2) {
		this.car_img2 = car_img2;
	}


	public String getCar_img3() {
		return car_img3;
	}


	public void setCar_img3(String car_img3) {
		this.car_img3 = car_img3;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getDealer_id() {
		return dealer_id;
	}


	public void setDealer_id(String dealer_id) {
		this.dealer_id = dealer_id;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public Timestamp getReg_date() {
		return reg_date;
	}


	public void setReg_date(Timestamp timestamp) {
		this.reg_date = timestamp;
	}


	public int getSel_status() {
		return sel_status;
	}


	public void setSel_status(int sel_status) {
		this.sel_status = sel_status;
	}


	public String getCar_type() {
		return car_type;
	}


	public void setCar_type(String car_type) {
		this.car_type = car_type;
	}


	public String getCar_brand() {
		return car_brand;
	}


	public void setCar_brand(String car_brand) {
		this.car_brand = car_brand;
	}


	public String getCar_model() {
		return car_model;
	}


	public void setCar_model(String car_model) {
		this.car_model = car_model;
	}


	public String getCar_cc() {
		return car_cc;
	}


	public void setCar_cc(String car_cc) {
		this.car_cc = car_cc;
	}


	public String getCar_oilType() {
		return car_oilType;
	}


	public void setCar_oilType(String car_oilType) {
		this.car_oilType = car_oilType;
	}


	public String getCar_birth() {
		return car_birth;
	}


	public void setCar_birth(String car_birth) {
		this.car_birth = car_birth;
	}


	public String getCar_mileage() {
		return car_mileage;
	}


	public void setCar_mileage(String car_mileage) {
		this.car_mileage = car_mileage;
	}


	public String getCar_price() {
		return car_price;
	}


	public void setCar_price(String car_price) {
		this.car_price = car_price;
	}


	public String getCar_location() {
		return car_location;
	}


	public void setCar_location(String car_location) {
		this.car_location = car_location;
	}


	public String getCar_color() {
		return car_color;
	}


	public void setCar_color(String car_color) {
		this.car_color = car_color;
	}


	public String getCar_gear() {
		return car_gear;
	}


	public void setCar_gear(String car_gear) {
		this.car_gear = car_gear;
	}


	public String getCar_option() {
		return car_option;
	}


	public void setCar_option(String car_option) {
		this.car_option = car_option;
	}


	public String getCar_regNum() {
		return car_regNum;
	}


	public void setCar_regNum(String car_regNum) {
		this.car_regNum = car_regNum;
	}


	@Override
	public String toString() {
		return "CarListDataBean [car_idx=" + car_idx + ", car_img1=" + car_img1 + ", car_img2=" + car_img2
				+ ", car_img3=" + car_img3 + ", title=" + title + ", dealer_id=" + dealer_id + ", description="
				+ description + ", reg_date=" + reg_date + ", sel_status=" + sel_status + ", car_type=" + car_type
				+ ", car_brand=" + car_brand + ", car_model=" + car_model + ", car_cc=" + car_cc + ", car_oilType="
				+ car_oilType + ", car_birth=" + car_birth + ", car_mileage=" + car_mileage + ", car_price=" + car_price
				+ ", car_location=" + car_location + ", car_color=" + car_color + ", car_gear=" + car_gear
				+ ", car_option=" + car_option + ", car_regNum=" + car_regNum + "]";
	}
}
