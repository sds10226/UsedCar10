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


//-------------------------------------------------------------------------------
// public class CustomerDBBean - 김상헌
//-------------------------------------------------------------------------------
public class CustomerDBBean {

	private static CustomerDBBean instance = new CustomerDBBean();

	public static CustomerDBBean getInstance() {
		return instance;
	}

	// -------------------------------------------------------------------------------
	// 생성자
	// -------------------------------------------------------------------------------
	private CustomerDBBean() {
	}

	// -------------------------------------------------------------------------------
	// 커넥션 풀로부터 커넥션 객체를 얻어내는 메서드 - 김상헌
	// -------------------------------------------------------------------------------
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/usedcardb");
		return ds.getConnection();
	}
	// -------------------------------------------------------------------------------
	// 커넥션 풀로부터 커넥션 객체를 얻어내는 메서드 -김상헌
	// -------------------------------------------------------------------------------

	public int confirmId(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rtnVal = 0;
		String sql = "";

		try {
			conn = getConnection();
			sql = "select user_id from customer_join where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				rtnVal = 1;// id에 해당하는 회원이 존재하면
			} else {
				rtnVal = -1;// id에 해당하는 회원이 존재하지 않으면
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
		return rtnVal;

	}

	// --------------------------------------------------------------------------------------
	// 회원가입 - 김상헌
	// --------------------------------------------------------------------------------------
	public void insertMember(CustomerDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			conn = getConnection();
			sql = "insert into customer_join values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getUser_id());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getBirth());
			pstmt.setString(5, member.getQ_passwd());
			pstmt.setString(6, member.getAns_passwd());
			pstmt.setString(7, member.getGender());
			pstmt.setString(8, member.getAddress());
			pstmt.setString(9, member.getAddress1());
			pstmt.setString(10, member.getAddress2());
			pstmt.setString(11, member.getAddress3());
			pstmt.setString(12, member.getPhone());
			pstmt.setString(13, member.getTel());
			pstmt.setString(14, member.getEmail());
			pstmt.setString(15, member.getImg());
			pstmt.setTimestamp(16, member.getReg_date());
			pstmt.setString(17,member.getMembertype());
			
			
			

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
	}// End - public void insertMember(CustomerDataBean member) throws Exception

	// -------------------------------------------------------------------------------
	// 등록된 회원인지 검사한다. - 김상헌
	// -------------------------------------------------------------------------------
	public int userCheck(String id, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rtnVal = -1;
		String sql = "";
		String dbpasswd = "";

		try {
			conn = getConnection();
			sql = "select passwd from customer_join where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {// id에 해당하는 자료가 있ㅇ면
				dbpasswd = rs.getString("passwd");

				if (dbpasswd.equals(passwd)) {// 비밀번호가 맞으면
					rtnVal = 1;// 인증 성공
				} else {
					// id에 해당하는 자료가 없으면 등록된 회원이 아니다.
					rtnVal = 0;
				}
			} else {
				// id에 해당하는 자료가 없으면 등록된 회원이 아니다.
				rtnVal = -1;
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
		return rtnVal;
	}

	// -------------------------------------------------------------------------------
	// id에 해당하는 정보를 추출한다. - 김상헌
	// -------------------------------------------------------------------------------
	public CustomerDataBean getMember(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CustomerDataBean member = null;
		String sql = "";

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement(sql);
			sql = "select * from customer_join where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				member = new CustomerDataBean();
				member.setUser_id(rs.getString("user_id"));
				//member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setBirth(rs.getString("birth"));
				member.setGender(rs.getString("gender"));
				member.setQ_passwd(rs.getString("q_passwd"));
				member.setAns_passwd(rs.getString("ans_passwd"));		
				member.setAddress(rs.getString("address"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setAddress3(rs.getString("address3"));
				member.setPhone(rs.getString("phone"));
				member.setTel(rs.getString("tel"));
				member.setEmail(rs.getString("email"));
				member.setImg(rs.getString("img"));
				member.setReg_date(rs.getTimestamp("reg_date"));
				member.setMembertype(rs.getString("membertype"));
				
			
				
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
		return member;

	}
	//------------------------------------------------------------------------------------
	   //회원정보 수정 - 김상헌
	   public void updateMember(CustomerDataBean member) throws Exception{
	      
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      String sql = "";
	      
	      
	      try {
	         conn = getConnection();
	         sql = "UPDATE customer_join SET name=?, birth=?, gender=?, q_passwd=?, ans_passwd=?, "
	         		+ " address=?, address1=?, address2=?, address3=?, phone=?, tel=?, email=?, img=? where user_id=?";
	         pstmt = conn.prepareStatement(sql);
	        
				pstmt.setString(1, member.getName());
				pstmt.setString(2, member.getBirth());
				pstmt.setString(3, member.getGender());
				pstmt.setString(4, member.getQ_passwd());
				pstmt.setString(5, member.getAns_passwd());			
				pstmt.setString(6, member.getAddress());
				pstmt.setString(7, member.getAddress1());
				pstmt.setString(8, member.getAddress2());
				pstmt.setString(9, member.getAddress3());
				pstmt.setString(10, member.getPhone());
				pstmt.setString(11, member.getTel());
				pstmt.setString(12, member.getEmail());
				pstmt.setString(13, member.getImg());
				pstmt.setString(14, member.getUser_id());

	         pstmt.executeUpdate();
	      } catch (Exception ex) {
	         ex.printStackTrace();
	      } finally {
	         if(pstmt != null)
	            try {
	               pstmt.close();
	            } catch (SQLException ex) {}
	         if(conn != null)
	            try {
	               conn.close();
	            } catch (SQLException ex) {}
	      }
	      
	   }//end - public void updateMember(CustomerDataBean member) throws Exception
	   
	   //------------------------------------------------------------------------------------
	   //회원정보 탈퇴 - 김상헌
	   public int deleteMember(String id, String passwd) throws Exception{
	      
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      
	      int rtnVal = -1;
	      String sql = "";
	      String dbpasswd = "";
	      
	      try {
	         conn = getConnection();
	         
	         sql = "SELECT passwd FROM customer_join WHERE user_id=?";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, id);
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()){
	            dbpasswd = rs.getString("passwd");
	            if(dbpasswd.equals(passwd)){
	               sql = ""; //초기화
	               sql = "DELETE FROM customer_join WHERE user_id=?";
	               pstmt = conn.prepareStatement(sql);
	               pstmt.setString(1, id);
	               
	               pstmt.executeUpdate();
	               rtnVal = 1;
	            }else{
	               rtnVal = 0;
	            }
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         if(rs != null)
	            try {
	               rs.close();
	            } catch (SQLException ex) {}
	         if(pstmt != null)
	            try {
	               pstmt.close();
	            } catch (SQLException ex) {}
	         if(conn != null)
	            try {
	               conn.close();
	            } catch (SQLException ex) {}
	      }
	      
	      return rtnVal;
	      
	   }//end - public int deleteMember(String id, String passwd) throws Exception
	   
	 //------------------------------------------------------------------------------------
	   //회원정보 탈퇴 오버로딩 - 김상헌
	   public void deleteMember(String id) throws Exception{
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      
	      String sql = "";
	      
	      try {
	         conn = getConnection();
	         
	         sql = "delete from customer_join WHERE user_id=?";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, id);
	         pstmt.executeUpdate();
	         
	         System.out.println("삭제완료");
	         
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         if(pstmt != null)
	            try {
	               pstmt.close();
	            } catch (SQLException ex) {}
	         if(conn != null)
	            try {
	               conn.close();
	            } catch (SQLException ex) {}
	      }
	      
	      
	   }//end - public int deleteMember(String id, String passwd) throws Exception
	   
   		// -------------------------------------------------------------------------------
		// 회원 탈퇴시 비교할 비밀번호 가져오기 ////12월 19일 오후 2시 추가 김상헌
		// -------------------------------------------------------------------------------
   		public String customerCheckPassword(String id) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String passwd = "";
			String sql = "";

			try {
				conn = getConnection();

				sql = "select passwd from customer_join where user_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();

				if (rs.next()) {
					passwd = rs.getString("passwd");
					
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
			return passwd;

		}
   		// -------------------------------------------------------------------------------
   		// request로 받은 id에 해당하는 memberType을 추출한다. //12월 19일 오후 3시 추가 김상헌
   		// -------------------------------------------------------------------------------
   		public String checkMembertype(String id) throws Exception {
   			Connection conn = null;
   			PreparedStatement pstmt = null;
   			ResultSet rs = null;

   			String membertype = "";
   			String sql = "";

   			try {
   				conn = getConnection();
   				sql = "select membertype from customer_join where user_id=?";
   				pstmt = conn.prepareStatement(sql);
   				pstmt.setString(1, id);
   				rs = pstmt.executeQuery();

   				if (rs.next()) {
   					membertype = rs.getString("membertype");
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
   			return membertype;
   		} // end - public String checkMembertype(String id) throws Exception
   		
   	   // -------------------------------------------------------------------------------
   	   // 일반고객 id 중복 검사						//12월 19일 오후 4시 강한결
   	   // -------------------------------------------------------------------------------
   	   public int confirmCustomerId(String id) throws Exception {
   	      Connection conn = null;
   	      PreparedStatement pstmt = null;
   	      ResultSet rs = null;
   	      int rtnVal = 0;
   	      String sql = "";

   	      try {
   	         conn = getConnection();
   	         sql = "select user_id from customer_join where user_id=?";
   	         pstmt = conn.prepareStatement(sql);
   	         pstmt.setString(1, id);
   	         rs = pstmt.executeQuery();

   	         if (rs.next()) {
   	            rtnVal = 1;// id에 해당하는 회원이 존재하면
   	         } else {
   	            rtnVal = -1;// id에 해당하는 회원이 존재하지 않으면
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
   	      return rtnVal;

   	   }
   	   
   	   //------------------------------------------------------------------------------------
	   //회원정보 수정 -비밀번호 변경 -------------------------------12월 20일 20시 추가 김상헌
	   public void passwdUpdateMember(String passwd,String user_id) throws Exception{
	      
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      String sql = "";
	      
	      
	      try {
	         conn = getConnection();
	         sql = "UPDATE customer_join SET passwd=? where user_id=?";
	         pstmt = conn.prepareStatement(sql);
	        
				pstmt.setString(1, passwd);
				pstmt.setString(2, user_id);

	         pstmt.executeUpdate();
	      } catch (Exception ex) {
	         ex.printStackTrace();
	      } finally {
	         if(pstmt != null)
	            try {
	               pstmt.close();
	            } catch (SQLException ex) {}
	         if(conn != null)
	            try {
	               conn.close();
	            } catch (SQLException ex) {}
	      }
	      
	   }//end - public void updateMember(CustomerDataBean member) throws Exception
	   
	   //------------------------------------------------------------------------------------
	   // -------------------------------------------------------------------------------
	
	   	//비밀번호 변경을 위해 id에 해당하는 정보를 추출한다. -----------------------12월 20일 20시 추가 김상헌
		// -------------------------------------------------------------------------------
		public String passgetMember(String id) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			String ownpasswd = "";
			try {
				conn = getConnection();

				pstmt = conn.prepareStatement(sql);
				sql = "select passwd from customer_join where user_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();

				if (rs.next()) {	
				ownpasswd = rs.getString("passwd");
					
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
			return ownpasswd;

		}
		//-------------------------------------------------------------------------------
		//맴버타입에 따른 회원의 정보를 건수에 맞춰 추출한다. - 김상헌
		//------------------------------------------------------------------------------------

		public CustomerDataBean[] getCustomerMemberdata(String membertype, int count) throws Exception {
			Connection			conn		= null;
			PreparedStatement	pstmt		= null;
			ResultSet			rs			= null;
			CustomerDataBean	customerList[]	= null;
			String				sql 		= "";
			int					rtnCount	= 0;
			int					i 			= 0;

			try {
				conn  = getConnection();
				
				//limit의 조회건수보다 실제데이터가 적으면 NULL문제가 발생하므로
				//먼저 해당자료의 건수를 구한다.
				//조회할 건수보다 실제 데이터가 적으면 적은만큼만 limit로 검색한다.
				sql   = "SELECT COUNT(*) FROM customer_join WHERE membertype=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, membertype);
				rs = pstmt.executeQuery();
				if(rs.next())
					rtnCount = rs.getInt(1);
				
				//검색하려는 데이터 건수가 실제데이터보다 많으면
				//실제데이터 건수만큼만 추출한다.
				if(rtnCount > count) rtnCount = count;
				pstmt.close();
				rs.close();
				
				//데이터가 없으면 검색할 필요가 없다.
				if(rtnCount > 0) {
					sql  = "";
					sql += "SELECT * FROM customer_join WHERE membertype=? ";
					sql += "ORDER BY reg_date DESC limit ?,?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, membertype);
					pstmt.setInt(2, 0);
					pstmt.setInt(3, rtnCount);
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						customerList = new CustomerDataBean[count];
						do {
							CustomerDataBean customer = new CustomerDataBean();
							
							customer.setUser_id			(rs.getString("user_id"));
							customer.setName			(rs.getString("name"));
							customer.setBirth			(rs.getString("birth"));
							customer.setGender			(rs.getString("gender"));
							customer.setAddress			(rs.getString("address"));
							customer.setAddress1		(rs.getString("address1"));
							customer.setAddress2		(rs.getString("address2"));
							customer.setAddress3		(rs.getString("address3"));
							customer.setPhone			(rs.getString("phone"));
							customer.setTel				(rs.getString("tel"));
							customer.setEmail			(rs.getString("email"));
							customer.setReg_date		(rs.getTimestamp("reg_date"));
							customer.setMembertype		(rs.getString("membertype"));
							
							customerList[i] = customer;
							i++;
						} while(rs.next());
					}
				}
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if(rs    != null) try {rs.close();   } catch(SQLException ex) {}
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(conn  != null) try {conn.close(); } catch(SQLException ex) {}
			}
			return customerList;
		} // End - public ShopBookDataBean[] getBooks(String book_kind, int count) throws Exception
		//-------------------------------------------------------------------------------

		//-------------------------------------------------------------------------------
		// 딜러/일반 회원의 수를 구하는 메서드 - 김상헌
		//-------------------------------------------------------------------------------
	   public int getCustomerMemberCount(String membertype) throws Exception{
		      Connection conn = null;
		      PreparedStatement pstmt = null;
		      ResultSet rs = null;
		      int rtnCnt =0;
		      
		      
		      try{
		         conn = getConnection();
		         String sql1 = "SELECT COUNT(*) FROM customer_join ";
		        
		         
		         if(membertype.equals("일반회원")){
		         pstmt = conn.prepareStatement(sql1);
		        
		         }
		        
		         rs = pstmt.executeQuery();
		         if(rs.next()){
		            rtnCnt = rs.getInt(1);
		         }
		         
		      } catch (Exception e) {
		         e.printStackTrace();
		      } finally {
		         if (rs != null)   try {rs.close();} catch (SQLException ex) {}
		         if (pstmt != null)try {pstmt.close();} catch (SQLException ex) {}
		         if (conn != null)try {conn.close();} catch (SQLException ex) {}
		      }
		      return rtnCnt;
		   }// End - public int getmemberCount() throws Exception
		 //-------------------------------------------------------------------------------
	   
	   			// -------------------------------------------------------------------------------
				// customer_join 테이블의 전체 회원 건수를 구하는 메서드 2019.12.30 김상헌
				// -------------------------------------------------------------------------------
				public int getListCount() throws Exception {
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					int rtnCount = 0;

					try {
						conn = getConnection();

						pstmt = conn.prepareStatement("select count(*) from customer_join");
						rs = pstmt.executeQuery();

						if (rs.next()) {
							rtnCount = rs.getInt(1);
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
					return rtnCount;
				} // End - public int getListCount() throws Exception
	  
				// -------------------------------------------------------------------------------
				// customer_join 테이블에서 전체 회원 목록을 구하는 메서드 2019.12월 30일 김상헌
				// -------------------------------------------------------------------------------
				public List<CustomerDataBean> getCustomerMemberList() throws Exception {
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					CustomerDataBean customer_list = null;
					String sql = "";
					List<CustomerDataBean> lists = null;

					try {
						conn = getConnection();

						sql = "select * from customer_join";
						pstmt = conn.prepareStatement(sql);
						rs = pstmt.executeQuery();

						lists = new ArrayList<CustomerDataBean>();

						while (rs.next()) {

							customer_list = new CustomerDataBean();
							
							customer_list.setUser_id			(rs.getString("user_id"));
							customer_list.setName				(rs.getString("name"));
							customer_list.setBirth				(rs.getString("birth"));
							customer_list.setGender			(rs.getString("gender"));
							customer_list.setAddress			(rs.getString("address"));
							customer_list.setAddress1			(rs.getString("address1"));
							customer_list.setAddress2			(rs.getString("address2"));
							customer_list.setAddress3			(rs.getString("address3"));
							customer_list.setPhone				(rs.getString("phone"));
							customer_list.setTel				(rs.getString("tel"));
							customer_list.setEmail				(rs.getString("email"));
							customer_list.setReg_date			(rs.getTimestamp("reg_date"));
							customer_list.setMembertype		(rs.getString("membertype"));
						

							lists.add(customer_list);
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
					return lists;
				} // End - public List<CustomerDataBean> getCustomerMemberList() throws Exception
	   
	// --------------------------------------------------------------------------------------------------------------------------------
	// 12월 20일 오후 5시 추가 -- 강한결
	// --------------------------------------------------------------------------------------------------------------------------------
	public String searchCustomerId(String tel, String email) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String customerId = "";
		
		String showId = "";
		String hideId = "";
		int hideIdLength = 0;
		
		String sql = "";
		
		System.out.println(tel + "," + email);
		
		try {
			conn = getConnection();
			sql = "select user_id from customer_join where tel=? and email=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tel);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				customerId = rs.getString("user_id");	

				
				// 가져온 id를 앞에 5자리만 노출시키고 나머지는 *로 보이게 하기 위한 작업  
				showId = customerId.substring(0, 5);
				hideIdLength = customerId.length() - 5;
				String star = "";
				for(int i = 0; i < hideIdLength; i++) {
					String[] starArr = new String[hideIdLength];
					starArr[i] = "*";
					hideId += starArr[i];
				}
				// 위 작업이 끝난 후 두 id를 customerId에 merge
				customerId = showId + hideId;
			
			} else {
				customerId = "해당 조건에 맞는 ID가 없습니다.";
				
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
		
		return customerId;
		
	} // end - public String searchCustomerId(String email, String tel) throws Exception
		   
	
	// --------------------------------------------------------------------------------------------------------------------------------
	// 12월 23일 오후 8시 추가 -- 강한결
	// --------------------------------------------------------------------------------------------------------------------------------
	public String searchCustomerPasswd(String user_id, String passhint, String passans) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String customerPasswd = "";
		
		String showPasswd = "";
		String hidePasswd = "";
		int hidePasswdLength = 0;
		
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "select passwd from customer_join where user_id=? and q_passwd=? and ans_passwd=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setString(2, passhint);
			pstmt.setString(3, passans);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				customerPasswd = rs.getString("passwd");	

				// 가져온 id를 앞에 5자리만 노출시키고 나머지는 *로 보이게 하기 위한 작업  
				showPasswd = customerPasswd.substring(0, 4);
				hidePasswdLength = customerPasswd.length() - 4;
				for(int i = 0; i < hidePasswdLength; i++) {
					String[] starArr = new String[hidePasswdLength];
					starArr[i] = "*";
					hidePasswd += starArr[i];
				}
				// 위 작업이 끝난 후 두 id를 customerId에 merge
				customerPasswd = showPasswd + hidePasswd;
			
			} else {
				customerPasswd = "해당 조건에 맞는 비밀번호가 없습니다.";
				
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
		
		return customerPasswd;
		
	} // end - public String searchCustomerPasswd(String user_id, String passhint, String passans) throws Exception
		   
}
// End - public class CustomerDBBean
