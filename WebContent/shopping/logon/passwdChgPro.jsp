<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="usedcar.shopping.DealerDBBean"%>
<%@ page import="usedcar.shopping.CustomerDBBean"%>


<%
String user = (String) session.getAttribute("user_id");
String membertype = (String)session.getAttribute("membertype");
String passwd =request.getParameter("newpasswd");
%>
<jsp:useBean id="dealer" scope="page"
	class="usedcar.shopping.DealerDataBean">
</jsp:useBean>

<jsp:useBean id="customer" scope="page"
	class="usedcar.shopping.CustomerDataBean">
</jsp:useBean>

<%
if(membertype.equals("딜러회원")){
	dealer.setUser_id(user);
	dealer.setPasswd(passwd);
	
	DealerDBBean dealerProcess = DealerDBBean.getInstance();

	dealerProcess.passwdUpdateMember(passwd,user);
		
		response.sendRedirect("http://localhost:8888/UsedCar10/ShopMain.jsp");//새로고침으로 바꾸던가 생각해보자
		
} else if(membertype.equals("일반회원")){
	customer.setUser_id(user);
	customer.setPasswd(passwd);
	
	CustomerDBBean customerProcess = CustomerDBBean.getInstance();

	customerProcess.passwdUpdateMember(passwd,user);
		
		response.sendRedirect("http://localhost:8888/UsedCar10/ShopMain.jsp");//새로고침으로 바꾸던가 생각해보자
}

%>

