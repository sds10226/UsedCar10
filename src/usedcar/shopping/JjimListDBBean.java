package usedcar.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class JjimListDBBean { //이영기
	private static JjimListDBBean instance = new JjimListDBBean();

	public static JjimListDBBean getInstance() {
		return instance;// 싱글톤
	}

	private JjimListDBBean() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/usedcardb");
		return ds.getConnection();
	}
	
	public List<JjimListDataBean> getJjimListByUserId(String user_id){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<JjimListDataBean> jjimList = null;

		try {
			conn = getConnection();
			String sql = "SELECT * FROM jjim_list WHERE user_id=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				jjimList = new ArrayList<>();// 한번만 실행됨

				do {
					JjimListDataBean jjim = new JjimListDataBean();

					jjim.setJjim_idx(rs.getInt("jjim_idx"));
					jjim.setUser_id(rs.getString("user_id"));
					jjim.setCar_idx(rs.getInt("car_idx"));

					jjimList.add(jjim);
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
		return jjimList;
	}
	
	public List<JjimCarDataBean> getJjimListByUserId(String user_id, String sort){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<JjimCarDataBean> jjimCarList = null;

		try {
			conn = getConnection();
			String sql = "SELECT * "
					+ "FROM jjim_list j, car_list c "
					+ "WHERE j.car_idx=c.car_idx and j.user_id=? "
					+ "order by 0 + " + sort;

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				jjimCarList = new ArrayList<>();// 한번만 실행됨

				do {
					JjimCarDataBean jjimCar = new JjimCarDataBean();

					jjimCar.setJjim_idx(rs.getInt("jjim_idx"));
					jjimCar.setUser_id(rs.getString("user_id"));
					jjimCar.setCar_idx(rs.getInt("car_idx"));
					jjimCar.setCar_img1(rs.getString("car_img1"));
					jjimCar.setTitle(rs.getString("title"));
					jjimCar.setCar_brand(rs.getString("car_brand"));
					jjimCar.setCar_model(rs.getString("car_model"));
					jjimCar.setCar_oilType(rs.getString("car_oilType"));
					jjimCar.setCar_birth(rs.getString("car_birth"));
					jjimCar.setCar_mileage(rs.getString("car_mileage"));
					jjimCar.setCar_price(rs.getString("car_price"));
					jjimCar.setCar_location(rs.getString("car_location"));

					jjimCarList.add(jjimCar);
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
		return jjimCarList;
	}
	
	public void insertJjim(JjimListDataBean jjim){
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();
			String sql = "INSERT INTO jjim_list VALUES (?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, jjim.getJjim_idx());
			pstmt.setString(2, jjim.getUser_id());
			pstmt.setInt(3, jjim.getCar_idx());
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
	
	public void deleteJjim(JjimListDataBean jjim){
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();
			String sql = "DELETE FROM jjim_list WHERE user_id=? and car_idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, jjim.getUser_id());
			pstmt.setInt(2, jjim.getCar_idx());
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
	
	public int getJjimCountByCarIdx(int car_idx){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rtnCnt = 0;

		try {
			conn = getConnection();
			String sql = "SELECT COUNT(*) FROM jjim_list WHERE car_idx=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, car_idx);
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
	
	public int getJjimCountByUserId(String user_id){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rtnCnt = 0;

		try {
			conn = getConnection();
			String sql = "SELECT COUNT(*) FROM jjim_list WHERE user_id=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
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
	
	// 2019.12.30  오후 2시 추가 - 강한결(자동차 거래 상태 delete method)
		public void deleteCar(int getCarIdx) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			String sql = "";
			
			try {
				conn = getConnection();
				sql = "DELETE FROM jjim_list WHERE car_idx=?";
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
	
	public void deleteAllJjim(String user_id){
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();
			String sql = "DELETE FROM jjim_list WHERE user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
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
}
