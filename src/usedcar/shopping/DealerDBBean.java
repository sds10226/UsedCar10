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
// public class DealerDataBean - 김상헌
//-------------------------------------------------------------------------------
public class DealerDBBean {

	private static DealerDBBean instance = new DealerDBBean();

	public static DealerDBBean getInstance() {
		return instance;
	}

	// -------------------------------------------------------------------------------
	// 생성자
	// -------------------------------------------------------------------------------
	private DealerDBBean() {
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
	// 커넥션 풀로부터 커넥션 객체를 얻어내는 메서드 - 김상헌
	// -------------------------------------------------------------------------------

	public int confirmId(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rtnVal = 0;
		String sql = "";

		try {
			conn = getConnection();
			sql = "select user_id from dealer_join where user_id=?";
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
	public void insertMember(DealerDataBean member) throws Exception {
		Connection conn = null;
	      PreparedStatement pstmt = null;
	      String sql = "";
	      try {
	         conn = getConnection();
	         sql = "insert into dealer_join values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, member.getUser_id());
	         pstmt.setString(2, member.getPasswd());
	         pstmt.setString(3, member.getName());
	         pstmt.setString(4, member.getBirth());
	         pstmt.setString(5, member.getGender());
	         pstmt.setString(6, member.getQ_passwd());
	         pstmt.setString(7, member.getAns_passwd());
	         pstmt.setString(8, member.getAddress());
	         pstmt.setString(9, member.getAddress1());
	         pstmt.setString(10, member.getAddress2());
	         pstmt.setString(11, member.getAddress3());
	         pstmt.setString(12, member.getPhone());
	         pstmt.setString(13, member.getTel());
	         pstmt.setString(14, member.getEmail());
	         pstmt.setTimestamp(15, member.getReg_date());
	         pstmt.setString(16, member.getUnion());
	         pstmt.setString(17, member.getCompany_name());
	         pstmt.setString(18, member.getBussiness_num());
	         pstmt.setString(19, member.getCompany_addr());
	         pstmt.setString(20, member.getCompany_addr1());
	         pstmt.setString(21, member.getCompany_addr2());
	         pstmt.setString(22, member.getCompany_addr3());
	         pstmt.setString(23, member.getCompany_tel());
	         pstmt.setString(24, member.getCompany_fax());
	         pstmt.setString(25, member.getEmp_id());
	         pstmt.setString(26, member.getImg());
	         pstmt.setString(27, member.getIntroduction());
	         pstmt.setInt(28, member.getAuth());
	         pstmt.setString(29, member.getMembertype());
	         

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
	}// End - public void insertMember(DealerDataBean member) throws Exception

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
			sql = "select passwd from dealer_join where user_id=?";
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
	public DealerDataBean getMember(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DealerDataBean member = null;
		String sql = "";

		try {
			conn = getConnection();

			sql = "select * from dealer_join where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				member = new DealerDataBean();
				
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
				member.setReg_date(rs.getTimestamp("reg_date"));
				member.setUnion(rs.getString("union_name"));
				member.setCompany_name(rs.getString("company_name"));
				member.setBussiness_num(rs.getString("bussiness_num"));
				member.setCompany_addr(rs.getString("company_addr"));
				member.setCompany_addr1(rs.getString("company_addr1"));
				member.setCompany_addr2(rs.getString("company_addr2"));
				member.setCompany_addr3(rs.getString("company_addr3"));
				member.setCompany_tel(rs.getString("company_tel"));
				member.setCompany_fax(rs.getString("company_fax"));
				member.setEmp_id(rs.getString("emp_id"));
				member.setImg(rs.getString("img"));
				member.setIntroduction(rs.getString("introduction"));
				//member.setAuth(rs.getInt("auth"));
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
	 public void updateMember(DealerDataBean member) throws Exception{
	       
	       Connection conn = null;
	       PreparedStatement pstmt = null;
	       String sql = "";
	       
	       try {
	          conn = getConnection();
	          sql = "UPDATE dealer_join SET name=?, birth=?, q_passwd=?, ans_passwd=?, address=?, address1=?, address2=?, address3=?, gender=?, phone=?, tel=?, email=?, union_name=?, company_name=?, bussiness_num=?, company_addr=?, company_addr1=?, company_addr2=?, company_addr3=?, company_tel=?, company_fax=?, emp_id=?, img=?, introduction=? WHERE user_id=?";
	          pstmt = conn.prepareStatement(sql);
	         
	          pstmt.setString(1, member.getName());
	          pstmt.setString(2, member.getBirth());
	          pstmt.setString(3, member.getQ_passwd());
	          pstmt.setString(4, member.getAns_passwd());
	          pstmt.setString(5, member.getAddress());
	          pstmt.setString(6, member.getAddress1());
	          pstmt.setString(7, member.getAddress2());
	          pstmt.setString(8, member.getAddress3());
	          pstmt.setString(9, member.getGender());
	          pstmt.setString(10, member.getPhone());
	          pstmt.setString(11, member.getTel());
	          pstmt.setString(12, member.getEmail());
	          pstmt.setString(13, member.getUnion());
	          pstmt.setString(14, member.getCompany_name());
	          pstmt.setString(15, member.getBussiness_num());
	          pstmt.setString(16, member.getCompany_addr());
	          pstmt.setString(17, member.getCompany_addr1());
	          pstmt.setString(18, member.getCompany_addr2());
	          pstmt.setString(19, member.getCompany_addr3());
	          pstmt.setString(20, member.getCompany_tel());
	          pstmt.setString(21, member.getCompany_fax());
	          pstmt.setString(22, member.getEmp_id());
	          pstmt.setString(23, member.getImg());
	          pstmt.setString(24, member.getIntroduction());
	          pstmt.setString(25, member.getUser_id());

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
	       
	    }//end - public void updateMember(DealerDataBean member) throws Exception
	   
	   //------------------------------------------------------------------------------------
	   //회원정보 탈퇴 오버로딩 - 김상헌 
	   public int deleteMember(String id, String passwd) throws Exception{
	      
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      
	      int rtnVal = -1;
	      String sql = "";
	      String dbpasswd = "";
	      
	      try {
	         conn = getConnection();
	         
	         sql = "SELECT passwd FROM dealer_join WHERE user_id=?";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, id);
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()){
	            dbpasswd = rs.getString("passwd");
	            if(dbpasswd.equals(passwd)){
	               sql = ""; //초기화
	               sql = "DELETE FROM dealer_join WHERE user_id=?";
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
	   //회원정보 탈퇴 - 김상헌
	   public void deleteMember(String id) throws Exception{
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      
	      String sql = "";
	      System.out.println(id);
	      
	      try {
	         conn = getConnection();
	         
	         sql = "delete from dealer_join WHERE user_id=?";
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
		// 회원 탈퇴시 비교할 비밀번호 가져오기			//12월 19일 오후 2시 추가 - 김상헌
		// -------------------------------------------------------------------------------
		public String dealerCheckPassword(String id) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String passwd = "";
			String sql = "";

			try {
				conn = getConnection();

				sql = "select passwd from dealer_join where user_id=?";
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
	      // request로 받은 id에 해당하는 memberType을 추출한다.  // 2019.12.28 오전 11시 추가 -- 강한결
	      // -------------------------------------------------------------------------------
	      public String checkMembertype(String id) throws Exception {
	         Connection conn = null;
	         PreparedStatement pstmt = null;
	         ResultSet rs = null;
	         
	         String membertype = ""; 
	         String sql = "";
	         
	         try {
	            conn = getConnection();
	            sql = "select membertype from dealer_join where user_id=?";
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
      // 딜러고객 id 중복검사 - 김상헌
      // -------------------------------------------------------------------------------
      public int confirmDealerId(String id) throws Exception {
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         int rtnVal = 0;
         String sql = "";

         try {
            conn = getConnection();
            sql = "select user_id from dealer_join where user_id=?";
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
	   //회원정보 수정 -------------------------------12월 20일 20시 추가 김상헌
	   public void passwdUpdateMember(String passwd,String user_id) throws Exception{
	      
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      String sql = "";
	      
	      
	      try {
	         conn = getConnection();
	         sql = "UPDATE dealer_join SET passwd=? where user_id=?";
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
		// id에 해당하는 정보를 추출한다. -------------------------------12월 20일 20시 추가 김상헌
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
				sql = "select passwd from dealer_join where user_id=?";
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
		//------------------------------------------------------------------------------------

		//-------------------------------------------------------------------------------
		//맴버타입에 따른 회원의 정보를 건수에 맞춰 추출한다. - 김상헌
		//------------------------------------------------------------------------------------

		public DealerDataBean[] getDealerMemberdata(String membertype, int count) throws Exception {
			Connection			conn		= null;
			PreparedStatement	pstmt		= null;
			ResultSet			rs			= null;
			DealerDataBean		dealerList[]	= null;
			String				sql 		= "";
			int					rtnCount	= 0;
			int					i 			= 0;

			try {
				conn  = getConnection();
				
				//limit의 조회건수보다 실제데이터가 적으면 NULL문제가 발생하므로
				//먼저 해당자료의 건수를 구한다.
				//조회할 건수보다 실제 데이터가 적으면 적은만큼만 limit로 검색한다.
				sql   = "SELECT COUNT(*) FROM dealer_join WHERE membertype=?";
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
					sql += "SELECT * FROM dealer_join WHERE membertype=? ";
					sql += "ORDER BY reg_date DESC limit ?,?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, membertype);
					pstmt.setInt(2, 0);
					pstmt.setInt(3, rtnCount);
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						dealerList = new DealerDataBean[count];
						do {
							DealerDataBean dealer = new DealerDataBean();
							
							dealer.setUser_id			(rs.getString("user_id"));
							dealer.setName				(rs.getString("name"));
							dealer.setBirth				(rs.getString("birth"));
							dealer.setGender			(rs.getString("gender"));
							dealer.setAddress			(rs.getString("address"));
							dealer.setAddress1			(rs.getString("address1"));
							dealer.setAddress2			(rs.getString("address2"));
							dealer.setAddress3			(rs.getString("address3"));
							dealer.setPhone				(rs.getString("phone"));
							dealer.setTel				(rs.getString("tel"));
							dealer.setEmail				(rs.getString("email"));
							dealer.setReg_date			(rs.getTimestamp("reg_date"));
							dealer.setMembertype		(rs.getString("membertype"));
							dealer.setAuth				(rs.getInt("auth"));
							dealerList[i] = dealer;
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
			return dealerList;
		} // End - public DealerDataBean[] getBooks(String book_kind, int count) throws Exception
		//-------------------------------------------------------------------------------

		//-------------------------------------------------------------------------------
		// 딜러 회원의 수를 구하는 메서드 - 김상헌
		//-------------------------------------------------------------------------------
		   public int getDealerMemberCount(String membertype) throws Exception{
			      Connection conn = null;
			      PreparedStatement pstmt = null;
			      ResultSet rs = null;
			      int rtnCnt =0;
			      
			      
			      try{
			         conn = getConnection();
			         String sql1 = "SELECT COUNT(*) FROM dealer_join ";
			        
			         
			         if(membertype.equals("딜러회원")){
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
			   }// End - public int getDealerMemberCount() throws Exception
		 //-------------------------------------------------------------------------------
			// -------------------------------------------------------------------------------
			// dealer_join 테이블의 전체 회원 건수를 구하는 메서드 2019.12.30 김상헌
			// -------------------------------------------------------------------------------
			public int getListCount() throws Exception {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				int rtnCount = 0;

				try {
					conn = getConnection();

					pstmt = conn.prepareStatement("select count(*) from dealer_join");
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
			// dealer_join 테이블에서 전체 회원 목록을 구하는 메서드 2019.12월 30일 김상헌
			// -------------------------------------------------------------------------------
			public List<DealerDataBean> getDealerMemberList() throws Exception {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				DealerDataBean dealer_list = null;
				String sql = "";
				List<DealerDataBean> lists = null;

				try {
					conn = getConnection();

					sql = "select * from dealer_join";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();

					lists = new ArrayList<DealerDataBean>();

					while (rs.next()) {

						dealer_list = new DealerDataBean();
						
						dealer_list.setUser_id			(rs.getString("user_id"));
						dealer_list.setName				(rs.getString("name"));
						dealer_list.setBirth				(rs.getString("birth"));
						dealer_list.setGender			(rs.getString("gender"));
						dealer_list.setAddress			(rs.getString("address"));
						dealer_list.setAddress1			(rs.getString("address1"));
						dealer_list.setAddress2			(rs.getString("address2"));
						dealer_list.setAddress3			(rs.getString("address3"));
						dealer_list.setPhone				(rs.getString("phone"));
						dealer_list.setTel				(rs.getString("tel"));
						dealer_list.setEmail				(rs.getString("email"));
						dealer_list.setReg_date			(rs.getTimestamp("reg_date"));
						dealer_list.setMembertype		(rs.getString("membertype"));
						dealer_list.setAuth				(rs.getInt("auth"));

						lists.add(dealer_list);
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
			} // End - public List<BuyDataBean> getBuyList() throws Exception
     
		   
		   
		 
		// --------------------------------------------------------------------------------------------------------------------------------
		// 12월 26일 오후 7시 추가 (딜러 차량 등록 권한 변경 메소드) -- 강한결
		// --------------------------------------------------------------------------------------------------------------------------------
	  	public void modifyAuth(String id, String set_auth) throws Exception {
	  		int auth_num = 0;

	  		if(set_auth.equals("권한있음")) {
	  			auth_num = 1;
	  		} else {
	  			auth_num = 0;
	  		}

	  		Connection conn = null;
	  		PreparedStatement pstmt = null;
	  		
	  		String sql = "";
	  		
	  		try {
	 			conn = getConnection();
	 			
	 			sql = "update dealer_join set auth=? where user_id=?";
	  			
	  			pstmt = conn.prepareStatement(sql);
	  			pstmt.setInt(1, auth_num);
	  			pstmt.setString(2, id);
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
 
    // --------------------------------------------------------------------------------------------------------------------------------
  	// 12월 20일 오후 5시 추가 -- 강한결
  	// --------------------------------------------------------------------------------------------------------------------------------
  	public String seachDealerId(String tel, String email) throws Exception {
  		Connection conn = null;
  		PreparedStatement pstmt = null;
  		ResultSet rs = null;

  		String dealerId = "";
  		
  		String showId = "";
  		String hideId = "";
  		int hideIdLength = 0;
  		
  		String sql = "";
  		
  		System.out.println(tel + "," + email);
  		
  		try {
  			conn = getConnection();
  			sql = "select user_id from dealer_join where tel=? and email=?";
  			
  			pstmt = conn.prepareStatement(sql);
  			pstmt.setString(1, tel);
  			pstmt.setString(2, email);
  			rs = pstmt.executeQuery();
  			
  			if(rs.next()) {
  				dealerId = rs.getString("user_id");	

  				
  				// 가져온 id를 앞에 5자리만 노출시키고 나머지는 *로 보이게 하기 위한 작업  
  				showId = dealerId.substring(0, 5);
  				hideIdLength = dealerId.length() - 5;
  				String star = "";
  				for(int i = 0; i < hideIdLength; i++) {
  					String[] starArr = new String[hideIdLength];
  					starArr[i] = "*";
  					hideId += starArr[i];
  				}
  				// 위 작업이 끝난 후 두 id를 customerId에 merge
  				dealerId = showId + hideId;
  			
  			} else {
  				dealerId = "해당 조건에 맞는 ID가 없습니다.";
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
  		
  		return dealerId;
  		
  	} // end - public String searchCustomerId(String email, String tel) throws Exception
	    
 
  	
  	// --------------------------------------------------------------------------------------------------------------------------------
  	// 12월 23일 오후 8시 추가 -- 강한결
  	// --------------------------------------------------------------------------------------------------------------------------------
  	public String searchDealerPasswd(String user_id, String passhint, String passans) throws Exception {
  		Connection conn = null;
  		PreparedStatement pstmt = null;
  		ResultSet rs = null;

  		String dealerPasswd = "";
  		
  		String showPasswd = "";
  		String hidePasswd = "";
  		int hidePasswdLength = 0;
  		
  		String sql = "";
  		
  		try {
  			conn = getConnection();
  			sql = "select passwd from dealer_join where user_id=? and q_passwd=? and ans_passwd=?";
  			
  			pstmt = conn.prepareStatement(sql);
  			pstmt.setString(1, user_id);
  			pstmt.setString(2, passhint);
  			pstmt.setString(3, passans);
  			rs = pstmt.executeQuery();
  			
  			if(rs.next()) {
  				dealerPasswd = rs.getString("passwd");	

  				
  				// 가져온 id를 앞에 5자리만 노출시키고 나머지는 *로 보이게 하기 위한 작업  
  				showPasswd = dealerPasswd.substring(0, 4);
  				hidePasswdLength = dealerPasswd.length() - 4;
  				for(int i = 0; i < hidePasswdLength; i++) {
  					String[] starArr = new String[hidePasswdLength];
  					starArr[i] = "*";
  					hidePasswd += starArr[i];
  				}
  				// 위 작업이 끝난 후 두 id를 customerId에 merge
  				dealerPasswd = showPasswd + hidePasswd;
  			
  			} else {
  				dealerPasswd = "해당 조건에 맞는 비밀번호가 없습니다.";
  				
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
  		
  		return dealerPasswd;
  		
  	} // end - public String searchDealerPasswd(String user_id, String passhint, String passans) throws Exception
  	
  	
  	// --------------------------------------------------------------------------------------------------------------------------------
    // 12월 27일 오후 4시 추가 (딜러 차량 등록 권한 get 메소드) -- 강한결
    // --------------------------------------------------------------------------------------------------------------------------------
  	public int getAuth(String id) throws Exception {
  		int auth = 0;
  		
  		Connection conn = null;
  		PreparedStatement pstmt = null;
  		ResultSet rs = null;
  		
  		String sql = "";
  		
  		try {
 			conn = getConnection();
 			sql = "select auth from dealer_join where user_id=?";
 			pstmt = conn.prepareStatement(sql);
 			pstmt.setString(1, id);
 			rs = pstmt.executeQuery();
 			if(rs.next()) {
 				auth = rs.getInt("auth");
 				
 				System.out.println("있음=1, 없음=0 : " + auth + "| ID : " + id);
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
  		return auth;
  	} // end - public int getAuth(String id) throws Exception
			   
}
// End - public class CustomerDBBean