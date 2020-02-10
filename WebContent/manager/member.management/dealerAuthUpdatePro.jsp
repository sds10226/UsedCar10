<%@page import="javax.websocket.SendResult"%>
<%@page import="usedcar.shopping.DealerDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
String dealer_id = request.getParameter("user_id");
int modify_auth = Integer.parseInt(request.getParameter("modify_auth"));

System.out.println(dealer_id + ", " + modify_auth);


String set_auth = "";
if(modify_auth == 1) {
   set_auth = "권한있음";
} else {
   set_auth = "권한없음";
}

DealerDBBean dealerProcess = DealerDBBean.getInstance();
dealerProcess.modifyAuth(dealer_id, set_auth);


/* response.sendRedirect("http://localhost:8888/UsedCar/manager/member.management/dealerList.jsp"); */

%>

<script>
	alert('수정이 완료되었습니다.');
	location.href = "http://localhost:8888/UsedCar10/manager/member.management/dealerList.jsp";
</script>


