<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="usedcar.master.ManagerDBBean" %>

<%
request.setCharacterEncoding("utf-8");

String	id 		= request.getParameter("id");
String	passwd	= request.getParameter("passwd");

//System.out.println(id + " : " + passwd);

ManagerDBBean manager = ManagerDBBean.getInstance();

int check = manager.managerCheck(id, passwd);

if(check == 1) {
	//아이디와 비밀번호가 맞으면 세션을 발급한다.
	session.setAttribute("managerid", id);
	response.sendRedirect("../managerMain.jsp");
} else if(check == 0) {
%>	
	<script>
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>
<%
} else {
%>
	<script>
		alert("아이디가 맞지 않습니다.");
		history.go(-1);
	</script>
<%
}
%>












