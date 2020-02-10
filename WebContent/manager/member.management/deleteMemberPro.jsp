<%@page import="usedcar.shopping.CustomerDBBean"%>
<%@page import="usedcar.shopping.DealerDBBean"%>
<%@page import="usedcar.shopping.CustomerDataBean"%>
<%@page import="usedcar.shopping.DealerDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
    request.setCharacterEncoding("utf-8");
	String user_id = request.getParameter("user_id");
    
	String membertype = "";
	
	membertype = (String)request.getParameter("membertype").trim();
	
	System.out.println(user_id + "," + membertype);
	
    
    %>
    <jsp:useBean id="customer" scope="page"
	class="usedcar.shopping.CustomerDataBean">
</jsp:useBean>

<jsp:useBean id="dealer" scope="page"
	class="usedcar.shopping.DealerDataBean">
</jsp:useBean>
    <%
    DealerDataBean dealerList = null;
	CustomerDataBean customerList =null;

	//세션id에 해당하는 정보를 DB에서 가져온다.
	DealerDBBean dealerProcess = DealerDBBean.getInstance();
	CustomerDBBean customerProcess = CustomerDBBean.getInstance();

	if(membertype.equals("딜러회원")) {
		dealerProcess.deleteMember(user_id);	
	} else {
		customerProcess.deleteMember(user_id);	
	}
	
	
    %>
    <script>
    	alert("회원탈퇴가 완료 되었습니다.");
    	location.href = "http://localhost:8888/UsedCar10/manager/managerMain.jsp";
    
    </script>