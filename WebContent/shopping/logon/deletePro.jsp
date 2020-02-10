<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="usedcar.shopping.CustomerDataBean"%>
<%@ page import="usedcar.shopping.CustomerDBBean"%>
<%@ page import="usedcar.shopping.DealerDataBean"%>
<%@ page import="usedcar.shopping.DealerDBBean"%>

<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("user_id");
	String membertype = (String) session.getAttribute("membertype");
	
	//String id = request.getParameter("user_id");
	String passwd = request.getParameter("passwd");
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
	dealerList = dealerProcess.getMember(id);
	
	CustomerDBBean customerProcess = CustomerDBBean.getInstance();
	customerList = customerProcess.getMember(id);
	
	

	if (membertype.equals("딜러회원")) {
		dealer.setUser_id(id);
		dealer.setPasswd(passwd);

		int check = dealerProcess.deleteMember(id, passwd);

		if (check == 1) {
			//회원탈퇴를 하면 세션을 소멸시킨다.
			session.invalidate(); //만약 1을 반환받았으면 , 해당 정보를 지우는 invailidate()함수 사용
			response.sendRedirect("http://localhost:8888/UsedCar/ShopMain.jsp");
		}
		%><center>
		<form action="../../ShopMain.jsp" name="userinput" method="post">
			<!-- 확인버튼을 누르면 shopmain.jsp로 이동하는 <form>태크 -->
			<b><h2>회원정보가 삭제되었습니다.</h2></b> 10초 후 자동으로 이동 합니다.<br /> <br />
			<meta http-equiv="Refresh" content="10;url=../../ShopMain.jsp">
			<!-- 확인버튼을 누르지 않아도, 10초 되면 자동으로 shopmain.jsp로 이동한다. -->
			<input type="submit" value="확인">
		</form>
	</center>
	
	<% 
	
	} else if(membertype.equals("일반회원")){
		customer.setUser_id(id);
		customer.setPasswd(passwd);
		

		int check = customerProcess.deleteMember(id, passwd);

		if (check == 1) {
			//회원탈퇴를 하면 세션을 소멸시킨다.
			session.invalidate(); //만약 1을 반환받았으면 , 해당 정보를 지우는 invailidate()함수 사용
			response.sendRedirect("http://localhost:8888/UsedCar10/ShopMain.jsp");
		}
	
%>

<center>
	<form action="../../ShopMain.jsp" name="userinput" method="post">
		<!-- 확인버튼을 누르면 shopmain.jsp로 이동하는 <form>태크 -->
		<b><h2>회원정보가 삭제되었습니다.</h2></b> 10초 후 자동으로 이동 합니다.<br /> <br />
		<meta http-equiv="Refresh" content="10;url=../../ShopMain.jsp">
		<!-- 확인버튼을 누르지 않아도, 10초 되면 자동으로 shopmain.jsp로 이동한다. -->
		<input type="submit" value="확인">
	</form>
</center>

	<%
		// 비밀번호가 틀릴경우 - 삭제가 안되었을 경우
		} else {
	%>
	<script>
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>
	<%
		}
	%>

