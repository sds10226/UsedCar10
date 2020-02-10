package usedcar.master;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


//-------------------------------------------------------------------------------
// public class ManagerDBBean
//-------------------------------------------------------------------------------
public class ManagerDBBean { //김상헌

	private	static	ManagerDBBean instance = new ManagerDBBean();
	
	public static ManagerDBBean getInstance() {
		return instance;
	}
	
	//-------------------------------------------------------------------------------
	// 생성자
	//-------------------------------------------------------------------------------
	private ManagerDBBean() {}
	
	//-------------------------------------------------------------------------------
	// 커넥션 풀로부터 커넥션 객체를 얻어내는 메서드
	//-------------------------------------------------------------------------------
	private Connection getConnection() throws Exception {
		Context	initCtx	= new InitialContext();
		Context envCtx  = (Context)  initCtx.lookup("java:comp/env");
		DataSource ds   = (DataSource)envCtx.lookup("jdbc/usedcardb");
		return ds.getConnection();
	}
	
	//-------------------------------------------------------------------------------
	// 관리자 인증 메서드
	//-------------------------------------------------------------------------------
	public int managerCheck(String id, String passwd) throws Exception {
		Connection			conn	= null;
		PreparedStatement	pstmt	= null;
		ResultSet			rs		= null;
		
		String	dbpasswd = "";
		int		rtnVal   = -1;
		String	sql		= "";
		try {
			conn = getConnection();
			
			sql = "SELECT managerpw FROM manager WHERE managerid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { //해당 아이디 정보가 있으면
				dbpasswd = rs.getString("managerpw");
				if(dbpasswd.equals(passwd)) { //비밀번호가 맞으면
					rtnVal = 1; //인증 성공
				} else {
					rtnVal = 0; //비밀번호 틀림
				}
			} else { //문의한 아이디에 대한 정보가 없으면
				rtnVal = -1; //해당 아이디가 없다.
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs    != null) try {rs.close();   } catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn  != null) try {conn.close(); } catch(SQLException ex) {}
		}
		return rtnVal;
	} // End - public int managerCheck(String id, String passwd)
	} // End - public List<ShopBookDataBean> getBooks(String book_kind) throws Exception
	

