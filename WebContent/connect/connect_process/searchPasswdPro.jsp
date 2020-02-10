<%@page import="usedcar.shopping.DealerDBBean"%>
<%@page import="usedcar.shopping.CustomerDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	/* searchId.jsp에서 받은 값 정리 */
	String user_id = request.getParameter("user_id");
	String passhint = request.getParameter("passhint");
	String passans = request.getParameter("passans");
	
	/* dto 인스턴스 생성 */
	CustomerDBBean customerProcess = CustomerDBBean.getInstance();
	DealerDBBean dealerProcess = DealerDBBean.getInstance();
	
	/* dao에 있는 method를 거쳐서 id값 받아오기 */	
	String customerPasswd = customerProcess.searchCustomerPasswd(user_id, passhint, passans);
	String dealerPasswd = dealerProcess.searchDealerPasswd(user_id, passhint, passans);
	
	String resPasswd = "";
	/* request.setAttribute("customerId", customerId);
	request.setAttribute("dealerId", dealerId); */

	if(customerPasswd.equals("해당 조건에 맞는 비밀번호가 없습니다.") || customerPasswd == "해당 조건에 맞는 비밀번호가 없습니다.") {
		resPasswd = dealerPasswd;
	} else {
		resPasswd = customerPasswd;
	}
%>

<% if(resPasswd == "해당 조건에 맞는 비밀번호가 없습니다." || resPasswd.equals("해당 조건에 맞는 비밀번호가 없습니다.") ) { %>
<%=resPasswd %>
<% } else { %>
<%=resPasswd %>
<% } %>