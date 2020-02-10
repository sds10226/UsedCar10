package usedcar.question;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


//-------------------------------------------------------------------------------
// public class CustomerDBBean
//-------------------------------------------------------------------------------
public class DealerQuestionDBBean { //김상헌

	private static DealerQuestionDBBean instance = new DealerQuestionDBBean();

	public static DealerQuestionDBBean getInstance() {
		return instance;
	}

	// -------------------------------------------------------------------------------
	// 생성자
	// -------------------------------------------------------------------------------
	private DealerQuestionDBBean() {
	}

	// -------------------------------------------------------------------------------
	// 커넥션 풀로부터 커넥션 객체를 얻어내는 메서드
	// -------------------------------------------------------------------------------
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/usedcardb");
		return ds.getConnection();
	}
	
			// -------------------------------------------------------------------------------
			// id에 해당하는 question정보를 추출한다.
			// -------------------------------------------------------------------------------
			public List<MemberQuestionDataBean> getQuestionId(String dealer_id) throws Exception {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				MemberQuestionDataBean member = null;
				String sql = "";
				List<MemberQuestionDataBean> Q_List = null;
				

				try {
					
					conn = getConnection();
					Q_List = new ArrayList<>();
					sql = "select * from question_list where dealer_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, dealer_id);
					rs = pstmt.executeQuery();

					while (rs.next()) {
						member = new MemberQuestionDataBean();
						member.setUser_id	(rs.getString("user_id"));
						member.setQ_idx		(rs.getInt("q_idx"));
						member.setCar_idx	(rs.getInt("car_idx"));
						member.setCar_own	(rs.getInt("car_own"));
						member.setInquiry	(rs.getString("inquiry"));
						member.setDealer_id (rs.getString("dealer_id"));
						member.setReg_date	(rs.getTimestamp("reg_date"));	
						
						Q_List.add(member);
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
				return Q_List;

			}
			// -------------------------------------------------------------------------------
			// Question_list 테이블의 회원 id에 따른 문의 건수를 구하는 메서드 2019.12.30 김상헌
			// -------------------------------------------------------------------------------
			public int getQusetionCount(String user_id) throws Exception {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				int rtnCount = 0;

				try {
					conn = getConnection();
					String sql = "select count(*) from question_list where dealer_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, user_id);
					rs = pstmt.executeQuery();

					if (rs.next()) 
						rtnCount = rs.getInt(1);
					
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
				return rtnCount;
			} // End - public int getListCount() throws Exception
		
}// END - public class CustomerQuestionDBBean