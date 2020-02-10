package usedcar.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import usedcar.shopping.CarListDataBean;

public class CarListDBBean { //이영기
	private static CarListDBBean instance = new CarListDBBean();

	public static CarListDBBean getInstance() {
		return instance;// 싱글톤
	}

	private CarListDBBean() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/usedcardb");
		return ds.getConnection();
	}

	// 차량 등록
	public void insertCar(String car_img1, String car_img2, String car_img3, String title, String dealer_id,
			String description, String car_type, String car_brand, String car_model, String car_cc, String car_oilType,
			String car_birth, String car_mileage, String car_price, String car_location, String car_color,
			String car_gear, String car_option, String car_regNum) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();
			String sql = "INSERT INTO car_list (car_img1, car_img2, car_img3, title, dealer_id, description, "
					+ "car_type, car_brand, car_model, car_cc, car_oilType, car_birth, car_mileage, car_price, car_location, "
					+ "car_color, car_gear, car_option, car_regNum) VALUES" + "(?, ?, ?, ?, ?, ?, "
					+ "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, car_img1);
			pstmt.setString(2, car_img2);
			pstmt.setString(3, car_img3);
			pstmt.setString(4, title);
			pstmt.setString(5, dealer_id);
			pstmt.setString(6, description);
			pstmt.setString(7, car_type);
			pstmt.setString(8, car_brand);
			pstmt.setString(9, car_model);
			pstmt.setString(10, car_cc);
			pstmt.setString(11, car_oilType);
			pstmt.setString(12, car_birth);
			pstmt.setString(13, car_mileage);
			pstmt.setString(14, car_price);
			pstmt.setString(15, car_location);
			pstmt.setString(16, car_color);
			pstmt.setString(17, car_gear);
			pstmt.setString(18, car_option);
			pstmt.setString(19, car_regNum);
			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
	}

	public void updateCar(String car_idx, String car_img1, String car_img2, String car_img3, String title,
			String dealer_id, String description, String car_type, String car_brand, String car_model, String car_cc,
			String car_oilType, String car_birth, String car_mileage, String car_price, String car_location,
			String car_color, String car_gear, String car_option, String car_regNum) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();
			String sql = "UPDATE car_list SET car_img1=?, car_img2=?, car_img3=?, title=?, dealer_id=?, "
					+ "description=?, car_type=?, car_brand=?, car_model=?, car_cc=?, car_oilType=?, "
					+ "car_birth=?, car_mileage=?, car_price=?, car_location=?, car_color=?, car_gear=?, "
					+ "car_option=?, car_regNum=? WHERE car_idx=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, car_img1);
			pstmt.setString(2, car_img2);
			pstmt.setString(3, car_img3);
			pstmt.setString(4, title);
			pstmt.setString(5, dealer_id);
			pstmt.setString(6, description);
			pstmt.setString(7, car_type);
			pstmt.setString(8, car_brand);
			pstmt.setString(9, car_model);
			pstmt.setString(10, car_cc);
			pstmt.setString(11, car_oilType);
			pstmt.setString(12, car_birth);
			pstmt.setString(13, car_mileage);
			pstmt.setString(14, car_price);
			pstmt.setString(15, car_location);
			pstmt.setString(16, car_color);
			pstmt.setString(17, car_gear);
			pstmt.setString(18, car_option);
			pstmt.setString(19, car_regNum);
			pstmt.setString(20, car_idx);
			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
	}
	
	public int getcarListCount(
			String car_type, String car_brand, String car_model, String car_cc, String car_oilType, 
			String car_birth, String car_mileage, String car_price, String car_location, String car_color, 
			String car_gear, String car_option, String car_regNum
			){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rtnCnt = 0;
		
		String sql = "SELECT COUNT(*) FROM car_list ";
		String[] keyArr = {"car_type", "car_brand", "car_model", "car_cc", "car_oilType", 
				"car_birth", "car_mileage", "car_price", "car_location", "car_color", 
				"car_gear", "car_option", "car_regNum"};
		String[] valArr = {car_type, car_brand, car_model, car_cc, car_oilType, 
				car_birth, car_mileage, car_price, car_location, car_color, 
				car_gear, car_option, car_regNum};
		
		//기본으로 들어가는 조건문
		sql += "WHERE sel_status=0 AND ";
		
		for(int i=0; i < keyArr.length; i++){
			if(valArr[i] == null || valArr[i].equals("")){//매개변수에 값이 없으면
				continue;//넘어가기
			}
			
			if(!sql.contains("WHERE")){//값을 처음으로 받으면
				sql += "WHERE ";//조건절 붙이기
			}
			
			if(keyArr[i].equals("car_option")){//car_option에 대한 값을 받았을 경우
				//받은 옵션들만 쿼리에 넣기
				String[] options = valArr[i].split("/");//구분자는 일단 ,으로 정함
				for(int j=0; j < options.length; j++){
					sql += "car_option like '%" + options[j] + "%' AND ";
				}
			}
			else if(keyArr[i].equals("car_birth") || keyArr[i].equals("car_mileage") || keyArr[i].equals("car_price")){

				//~부터~까지 - 두개 인자 받기(값이 없더라도 null을 꼭 받음)
				//하나만 받으면 그 값이 ~부터 값인지 ~까지 값인지 알 수 없기 때문..!
				//구분자 뒤에 있는 값이 반드시 ~까지 값임을 가정한다.
				String[] conditions = valArr[i].split(",",2);
				int[] range = new int[2];//디폴트 0
				
				for(int j=0; j<conditions.length; j++){
					if(conditions[j] != null && !conditions[j].equals("")){
						range[j] = Integer.parseInt(conditions[j]);//정수로 변경
					}
				}
				
				// mysql automatically casts a string to number when it's in the context of a number operation
				sql += keyArr[i] + ">=" + range[0] + " AND ";
				if(range[0] <= range[1]){
					sql += keyArr[i] + "<=" + range[1] + " AND ";
				}
			}
			else{
				//여러개의 선택지가 있는 경우
				String[] conditions = valArr[i].split(",");
				sql += "(";
				for(int j=0; j < conditions.length; j++){
					sql += keyArr[i] + "='" + conditions[j] + "' OR ";
				}

				//마지막에 붙은 or 삭제하기
				sql = sql.substring(0, sql.length()-4);//" OR "의 인덱스 개수: 4
				sql += ") AND ";
				
				//sql += keyArr[i] + "='" + valArr[i] + "' AND ";
			}			
		}
		//마지막에 붙은 and 삭제하기
		if(sql.contains("WHERE")){//값을 받은 적이 있으면
			sql = sql.substring(0, sql.length()-4);//"AND "의 인덱스 개수: 4
		}

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
				rtnCnt = rs.getInt(1);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return rtnCnt;
	}

	public int getcarListCount() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rtnCnt = 0;

		try {
			conn = getConnection();
			String sql = "SELECT COUNT(*) FROM car_list WHERE sel_status=0";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
				rtnCnt = rs.getInt(1);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return rtnCnt;
	}

	// 특정 조건(검색 column명, 검색 value)의 car list의 count 확인 함수 메소드 오버로딩
	public int getcarListCount(String conditionName, String conditionValue) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rtnCnt = 0;
		try {
			conn = getConnection();
			String sql = "SELECT COUNT(*) FROM car_list";
			if (conditionName != null && conditionValue != null) {
				if (conditionName == "car_location"	|| conditionName == "car_option") {
					sql += " WHERE " + "sel_status=0 and " + conditionName + " like \'%" + conditionValue + "%\'";
				} else {
					sql += " WHERE " + "sel_status=0 and " + conditionName + " = \'" + conditionValue + "\'";
				}
			} else {return -1;}
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()){
				rtnCnt = rs.getInt(1);
			}
		} catch (Exception ex) {System.out.println("Query excute ERROR!!");} 
		finally {
			if (rs != null){
				try {rs.close();} 
				catch(SQLException ex) {System.out.println("rs ERROR!!");}
			}
			if (pstmt != null){
				try {pstmt.close();} 
				catch (SQLException ex) {System.out.println("pstmt ERROR!!");}
			}
			if (conn != null){
				try {conn.close();} 
				catch (SQLException ex) {System.out.println("conn ERROR!!");}
			}
		}
		return rtnCnt;
	}

	// 2개 조건(1개)의 car list의 count 확인 함수 메소드 오버로딩
	public int getcarListCount(String condition1Name, String condition1Value, String condition2Name, int condition2Min,
			int condition2Max) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rtnCnt = 0;

		try {
			conn = getConnection();
			String sql = "SELECT COUNT(*) FROM car_list";
			if (condition1Name != null && condition1Value != null && condition2Name != null && condition2Min >= 0
					&& condition2Max > 0) {
				sql += " WHERE " + "sel_status=0 and " + condition1Name + " = \'" + condition1Value + "\' and " + condition2Name + " between "
						+ condition2Min + " and " + condition2Max;
			} else {
				return -1;
			}
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
				rtnCnt = rs.getInt(1);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return rtnCnt;
	}

	// 범위 조건(검색 column명, 검색 minvalue, 검색 maxvalue)의 car list의 count 확인 함수
	public int getcarListCount(String conditionName, int conditionMinValue, int conditionMaxValue) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rtnCnt = 0;
		try {
			conn = getConnection();
			String sql = "SELECT COUNT(*) FROM car_list";
			if (conditionName != null && conditionMinValue >= 0 && conditionMaxValue > 0) {
				sql += " WHERE " + "sel_status=0 and " + conditionName + " between " + conditionMinValue + " and " + conditionMaxValue;
			} else if (conditionName != null && conditionMinValue >= 0 && conditionMaxValue == 0) {
				sql += " WHERE " + "sel_status=0 and " + conditionName + " >= " + conditionMinValue;
			} else {
				return -1;
			}
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) rtnCnt = rs.getInt(1);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {rs.close();} 
				catch (SQLException ex) {}
			if (pstmt != null)
				try {pstmt.close();} 
				catch (SQLException ex) {}
			if (conn != null)
				try {conn.close();} 
				catch (SQLException ex) {}
		}
		return rtnCnt;
	}

	public CarListDataBean getCarInfo(int car_idx) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CarListDataBean car = new CarListDataBean();
		String sql = "SELECT * FROM car_list WHERE car_idx = ?";

		System.out.println(sql);

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, car_idx);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				car.setCar_idx(rs.getInt("car_idx"));
				car.setCar_img1(rs.getString("car_img1"));
				car.setCar_img2(rs.getString("car_img2"));
				car.setCar_img3(rs.getString("car_img3"));
				car.setTitle(rs.getString("title"));
				car.setDealer_id(rs.getString("dealer_id"));
				car.setDescription(rs.getString("description"));
				car.setReg_date(rs.getTimestamp("reg_date"));
				car.setSel_status(rs.getInt("sel_status"));
				car.setCar_type(rs.getString("car_type"));
				car.setCar_brand(rs.getString("car_brand"));
				car.setCar_model(rs.getString("car_model"));
				car.setCar_cc(rs.getString("car_cc"));
				car.setCar_oilType(rs.getString("car_oilType"));
				car.setCar_birth(rs.getString("car_birth"));
				car.setCar_mileage(rs.getString("car_mileage"));
				car.setCar_price(rs.getString("car_price"));
				car.setCar_location(rs.getString("car_location"));
				car.setCar_color(rs.getString("car_color"));
				car.setCar_gear(rs.getString("car_gear"));
				car.setCar_option(rs.getString("car_option"));
				car.setCar_regNum(rs.getString("car_regNum"));
			}

		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("!!");
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return car;
	}

	public List<CarListDataBean> getCarList(String sort, int curPage, int countList, String car_type, String car_brand,
			String car_model, String car_cc, String car_oilType, String car_birth, String car_mileage, String car_price,
			String car_location, String car_color, String car_gear, String car_option, String car_regNum)
			throws Exception {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CarListDataBean> carList = null;

		// 값이 있는 것들 끼리만 엔드 조건절로 묶기
		// 그러려면 값이 있는지 아닌지 판별해서
		// 에스큐엘문을 다시짜야하는데
		// 배열에 넣어서 포문 돌려서 값이 있을 때마다 에스큐엘에 플러스하기
		// 셋할때도 값이 있는것들 순서대로 넣어주기 포문으로

		String sql = "SELECT * FROM car_list ";
		String[] keyArr = { "car_type", "car_brand", "car_model", "car_cc", "car_oilType", "car_birth", "car_mileage",
				"car_price", "car_location", "car_color", "car_gear", "car_option", "car_regNum" };
		String[] valArr = { car_type, car_brand, car_model, car_cc, car_oilType, car_birth, car_mileage, car_price,
				car_location, car_color, car_gear, car_option, car_regNum };

		// 기본으로 들어가는 조건문
		sql += "WHERE sel_status=0 AND ";

		for (int i = 0; i < keyArr.length; i++) {
			if (valArr[i] == null || valArr[i].equals("")) {// 매개변수에 값이 없으면
				continue;// 넘어가기
			}

			if (!sql.contains("WHERE")) {// 값을 처음으로 받으면
				sql += "WHERE ";// 조건절 붙이기
			}

			if (keyArr[i].equals("car_option")||keyArr[i].equals("car_location")) {// car_option에 대한 값을 받았을 경우
				if(keyArr[i].equals("car_option")){
					// 받은 옵션들만 쿼리에 넣기
					String[] options = valArr[i].split(",");// 구분자는 일단 ,으로 정함
					for (int j = 0; j < options.length; j++) {
						sql += "car_option like '%" + options[j] + "%' AND ";
					}
				}else if(keyArr[i].equals("car_location")){
					// 받은 옵션들만 쿼리에 넣기
					String[] locations = valArr[i].split(",");// 구분자는 일단 ,으로 정함
					sql += "(";
					for (int j = 0; j < locations.length; j++) {
						sql += "car_location like '%" + locations[j] + "%' OR ";
					}
					// 마지막에 붙은 or 삭제하기
					sql = sql.substring(0, sql.length() - 4);// " OR "의 인덱스 개수: 4
					sql += ") AND ";
				}
			} else if (keyArr[i].equals("car_birth") || keyArr[i].equals("car_mileage")
					|| keyArr[i].equals("car_price") || keyArr[i].equals("car_cc")) {

				// ~부터~까지 - 두개 인자 받기(값이 없더라도 null을 꼭 받음)
				// 하나만 받으면 그 값이 ~부터 값인지 ~까지 값인지 알 수 없기 때문..!
				// 구분자 뒤에 있는 값이 반드시 ~까지 값임을 가정한다.
				String[] conditions = valArr[i].split(",", 2);
				int[] range = new int[2];// 디폴트 0

				for (int j = 0; j < conditions.length; j++) {
					if (conditions[j] != null && !conditions[j].equals("")) {
						range[j] = Integer.parseInt(conditions[j]);// 정수로 변경
					}
				}

				// mysql automatically casts a string to number when it's in the
				// context of a number operation
				sql += keyArr[i] + ">=" + range[0] + " AND ";
				if (range[0] <= range[1]) {
					sql += keyArr[i] + "<=" + range[1] + " AND ";
				}
			} else {
				// 여러개의 선택지가 있는 경우
				String[] conditions = valArr[i].split(",");
				sql += "(";
				for (int j = 0; j < conditions.length; j++) {
					sql += keyArr[i] + "='" + conditions[j] + "' OR ";
				}

				// 마지막에 붙은 or 삭제하기
				sql = sql.substring(0, sql.length() - 4);// " OR "의 인덱스 개수: 4
				sql += ") AND ";

				// sql += keyArr[i] + "='" + valArr[i] + "' AND ";
			}
		}
		// 마지막에 붙은 and 삭제하기
		if (sql.contains("WHERE")) {// 값을 받은 적이 있으면
			sql = sql.substring(0, sql.length() - 4);// "AND "의 인덱스 개수: 4
		}

		sql += "ORDER BY 0 + " + sort + " ";

		// mysql은 limit가 있지만 oracle은 rownum 사용해야함
		sql += "LIMIT " + ((curPage - 1) * countList) + "," + countList;

		System.out.println(sql);

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				carList = new ArrayList<>();// 한번만 실행됨

				do {
					CarListDataBean car = new CarListDataBean();

					car.setCar_idx(rs.getInt("car_idx"));
					car.setCar_img1(rs.getString("car_img1"));
					car.setCar_img2(rs.getString("car_img2"));
					car.setCar_img3(rs.getString("car_img3"));
					car.setTitle(rs.getString("title"));
					car.setDealer_id(rs.getString("dealer_id"));
					car.setDescription(rs.getString("description"));
					car.setReg_date(rs.getTimestamp("reg_date"));
					car.setSel_status(rs.getInt("sel_status"));
					car.setCar_type(rs.getString("car_type"));
					car.setCar_brand(rs.getString("car_brand"));
					car.setCar_model(rs.getString("car_model"));
					car.setCar_cc(rs.getString("car_cc"));
					car.setCar_oilType(rs.getString("car_oilType"));
					car.setCar_birth(rs.getString("car_birth"));
					car.setCar_mileage(rs.getString("car_mileage"));
					car.setCar_price(rs.getString("car_price"));
					car.setCar_location(rs.getString("car_location"));
					car.setCar_color(rs.getString("car_color"));
					car.setCar_gear(rs.getString("car_gear"));
					car.setCar_option(rs.getString("car_option"));
					car.setCar_regNum(rs.getString("car_regNum"));

					carList.add(car);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("!!");
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return carList;
	}

	public CarListDataBean getCar(int car_idx) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CarListDataBean car = null;

		try {
			conn = getConnection();
			String sql = "SELECT * FROM car_list WHERE car_idx=? and sel_status=0";//파는 것만 보기

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, car_idx);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				car = new CarListDataBean();

				car.setCar_idx(rs.getInt("car_idx"));
				car.setCar_img1(rs.getString("car_img1"));
				car.setCar_img2(rs.getString("car_img2"));
				car.setCar_img3(rs.getString("car_img3"));
				car.setTitle(rs.getString("title"));
				car.setDealer_id(rs.getString("dealer_id"));
				car.setDescription(rs.getString("description"));
				car.setReg_date(rs.getTimestamp("reg_date"));
				car.setSel_status(rs.getInt("sel_status"));
				car.setCar_type(rs.getString("car_type"));
				car.setCar_brand(rs.getString("car_brand"));
				car.setCar_model(rs.getString("car_model"));
				car.setCar_cc(rs.getString("car_cc"));
				car.setCar_oilType(rs.getString("car_oilType"));
				car.setCar_birth(rs.getString("car_birth"));
				car.setCar_mileage(rs.getString("car_mileage"));
				car.setCar_price(rs.getString("car_price"));
				car.setCar_location(rs.getString("car_location"));
				car.setCar_color(rs.getString("car_color"));
				car.setCar_gear(rs.getString("car_gear"));
				car.setCar_option(rs.getString("car_option"));
				car.setCar_regNum(rs.getString("car_regNum"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return car;
	}

	public int getOnSale(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rtnCnt = 0;

		try {
			conn = getConnection();
			String sql = "SELECT COUNT(*) FROM car_list WHERE dealer_id=? AND sel_status=0";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next())
				rtnCnt = rs.getInt(1);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return rtnCnt;
	}

	public int getCompletedSale(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rtnCnt = 0;

		try {
			conn = getConnection();
			String sql = "SELECT COUNT(*) FROM car_list WHERE dealer_id=? AND sel_status=2";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next())
				rtnCnt = rs.getInt(1);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return rtnCnt;
	}

	// -----------------------------------------------------------------------------------
	// 2019.12.24 오후 5시 추가 + 2019.12.24 오후 4시 수정 -- 강한결 // 자동차 브랜드만 뽑는 작업
	// -----------------------------------------------------------------------------------
	public List<String> getCarBrandList() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<String> car_brandList = null;

		String sql = "SELECT DISTINCT car_brand FROM car_list where sel_status=0" ;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			car_brandList = new ArrayList<>();
			while (rs.next()) {
				car_brandList.add(rs.getString("car_brand"));
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return car_brandList;
	}

	// -----------------------------------------------------------------------------------
	// 2019.12.27 오후 5시 추가 -- 강한결 // 자동차 브랜드에 맞는 모델만 뽑는 작업
	// -----------------------------------------------------------------------------------
	public List<String> getModelList(String car_brand) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<String> car_modelList = new ArrayList<>();
		String sql = "";

		/* 불안하니까 trim붙여서 넘어온 car_brand 물갈이 한 번 해주고... */
		String carBrand = car_brand.trim();

		try {
			conn = getConnection();

			sql = "SELECT DISTINCT car_model FROM car_list WHERE car_brand=? and sel_status=0";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, carBrand);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				car_modelList.add(rs.getString("car_model"));
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}

		return car_modelList;
	} // end - method
	
	// 등록된 차량 전체 리스트 추출 - 2019.12.30 오후 5시 추가
	public List<CarListDataBean> getCarList(int car_idx) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<CarListDataBean> carList = null;
		CarListDataBean carDTO= new CarListDataBean();
		
		String sql = "SELECT * FROM car_list WHERE car_idx = ?";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, car_idx);
			rs = pstmt.executeQuery();

			carList = new ArrayList<>();
			while (rs.next()) {
				carDTO.setCar_idx(rs.getInt("car_idx"));
				carDTO.setCar_img1(rs.getString("car_img1"));
				carDTO.setCar_img2(rs.getString("car_img2"));
				carDTO.setCar_img3(rs.getString("car_img3"));
				carDTO.setTitle(rs.getString("title"));
				carDTO.setDealer_id(rs.getString("dealer_id"));
				carDTO.setDescription(rs.getString("description"));
				carDTO.setReg_date(rs.getTimestamp("reg_date"));
				carDTO.setSel_status(rs.getInt("sel_status"));
				carDTO.setCar_type(rs.getString("car_type"));
				carDTO.setCar_brand(rs.getString("car_brand"));
				carDTO.setCar_model(rs.getString("car_model"));
				carDTO.setCar_cc(rs.getString("car_cc"));
				carDTO.setCar_oilType(rs.getString("car_oilType"));
				carDTO.setCar_birth(rs.getString("car_birth"));
				carDTO.setCar_mileage(rs.getString("car_mileage"));
				carDTO.setCar_price(rs.getString("car_price"));
				carDTO.setCar_location(rs.getString("car_location"));
				carDTO.setCar_color(rs.getString("car_color"));
				carDTO.setCar_gear(rs.getString("car_gear"));
				carDTO.setCar_option(rs.getString("car_option"));
				carDTO.setCar_regNum(rs.getString("car_regNum"));
				
				carList.add(carDTO);
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return carList;
	} // end - method
	

	// 2019.12.30  오후 12시 추가 - 강한결(딜러가 올린 상품 목록 보기 method)
	public List<CarListDataBean> getCarListByDealerId(String sort, int curPage, int countList, String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<CarListDataBean> carList = null;
		
		String sql = "SELECT * FROM car_list WHERE dealer_id=?";
		sql += " ORDER BY " + sort + " ";
		sql += "LIMIT " + ((curPage - 1) * countList) + "," + countList;
		

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				carList = new ArrayList<>(); // 한번만 실행됨

				do {
					CarListDataBean car = new CarListDataBean();

					car.setCar_idx(rs.getInt("car_idx"));
					car.setCar_img1(rs.getString("car_img1"));
					car.setCar_img2(rs.getString("car_img2"));
					car.setCar_img3(rs.getString("car_img3"));
					car.setTitle(rs.getString("title"));
					car.setDealer_id(rs.getString("dealer_id"));
					car.setDescription(rs.getString("description"));
					car.setReg_date(rs.getTimestamp("reg_date"));
					car.setSel_status(rs.getInt("sel_status"));
					car.setCar_type(rs.getString("car_type"));
					car.setCar_brand(rs.getString("car_brand"));
					car.setCar_model(rs.getString("car_model"));
					car.setCar_cc(rs.getString("car_cc"));
					car.setCar_oilType(rs.getString("car_oilType"));
					car.setCar_birth(rs.getString("car_birth"));
					car.setCar_mileage(rs.getString("car_mileage"));
					car.setCar_price(rs.getString("car_price"));
					car.setCar_location(rs.getString("car_location"));
					car.setCar_color(rs.getString("car_color"));
					car.setCar_gear(rs.getString("car_gear"));
					car.setCar_option(rs.getString("car_option"));
					car.setCar_regNum(rs.getString("car_regNum"));

					carList.add(car);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		
		return carList;
	} // end method

	
	
	// 2019.12.30  오후 2시 추가 - 강한결(자동차 거래 상태 update method)
	public void setSel_status(int sel_status, int getCarIdx) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "UPDATE car_list SET sel_status=? where car_idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sel_status);
			pstmt.setInt(2, getCarIdx);
			int res = pstmt.executeUpdate();
			
			if(res == 1) {
				System.out.println("### setSel_status update 됨");
			} else {
				System.out.println("### setSel_status update 안됨");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		
	} // end - method
	
	// 2019.12.30  오후 2시 추가 - 강한결(자동차 거래 상태 delete method)
	public void deleteCar(int getCarIdx) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "DELETE FROM car_list WHERE car_idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getCarIdx);
			int res = pstmt.executeUpdate();
			
			if(res == 1) {
				System.out.println("### deleteCar 완료");
			} else {
				System.out.println("### deleteCar 안 됨");
			}
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
	} // end - method
  
	// 20.01.02 오후 6시 추가 -- 강한결 // 딜러 아이디에 따른 등록 상품 개수 구하는 메소드
   public int getcarListCountByDealerId(String id) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      int rtnCnt = 0;

      try {
         conn = getConnection();
         String sql = "SELECT COUNT(*) FROM car_list WHERE dealer_id=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         rs = pstmt.executeQuery();
         if (rs.next())
            rtnCnt = rs.getInt(1);
      } catch (Exception ex) {
         ex.printStackTrace();
      } finally {
         if (rs != null)
            try {
               rs.close();
            } catch (SQLException ex) {
            }
         if (pstmt != null)
            try {
               pstmt.close();
            } catch (SQLException ex) {
            }
         if (conn != null)
            try {
               conn.close();
            } catch (SQLException ex) {
            }
      }
      return rtnCnt;
   }
   
   
   
   
   
   
   
   // 2019.12.30  오후 8시 추가 - 강한결(딜러가 올린 상품 목록 보기 method :: overloading)
   public List<CarListDataBean> getCarList(String sort) throws Exception {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      List<CarListDataBean> carList = null;
      
      String sql = "SELECT * FROM car_list";
      sql += " ORDER BY " + sort + " ";

      try {
         conn = getConnection();
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         
         if (rs.next()) {
            carList = new ArrayList<>(); // 한번만 실행됨

            do {
               CarListDataBean car = new CarListDataBean();

               car.setCar_idx(rs.getInt("car_idx"));
               car.setCar_img1(rs.getString("car_img1"));
               car.setCar_img2(rs.getString("car_img2"));
               car.setCar_img3(rs.getString("car_img3"));
               car.setTitle(rs.getString("title"));
               car.setDealer_id(rs.getString("dealer_id"));
               car.setDescription(rs.getString("description"));
               car.setReg_date(rs.getTimestamp("reg_date"));
               car.setSel_status(rs.getInt("sel_status"));
               car.setCar_type(rs.getString("car_type"));
               car.setCar_brand(rs.getString("car_brand"));
               car.setCar_model(rs.getString("car_model"));
               car.setCar_cc(rs.getString("car_cc"));
               car.setCar_oilType(rs.getString("car_oilType"));
               car.setCar_birth(rs.getString("car_birth"));
               car.setCar_mileage(rs.getString("car_mileage"));
               car.setCar_price(rs.getString("car_price"));
               car.setCar_location(rs.getString("car_location"));
               car.setCar_color(rs.getString("car_color"));
               car.setCar_gear(rs.getString("car_gear"));
               car.setCar_option(rs.getString("car_option"));
               car.setCar_regNum(rs.getString("car_regNum"));

               carList.add(car);
            } while (rs.next());
         }
      } catch (Exception ex) {
         ex.printStackTrace();
      } finally {
         if (rs != null)
            try {
               rs.close();
            } catch (SQLException ex) {
            }
         if (pstmt != null)
            try {
               pstmt.close();
            } catch (SQLException ex) {
            }
         if (conn != null)
            try {
               conn.close();
            } catch (SQLException ex) {
            }
      }
      
      return carList;
   } // end method
}