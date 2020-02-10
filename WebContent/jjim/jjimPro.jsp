<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import = "usedcar.shopping.JjimListDBBean" %>

<jsp:useBean id="jjim" scope="page" class="usedcar.shopping.JjimListDataBean"></jsp:useBean>

<%
request.setCharacterEncoding("utf-8");

String mode = request.getParameter("mode");
String id = (String)session.getAttribute("user_id");
int car_idx = 0;
if(request.getParameter("car_idx") != null){
	car_idx = Integer.parseInt(request.getParameter("car_idx"));
}

jjim.setUser_id(id);
jjim.setCar_idx(car_idx);

JjimListDBBean jjimProcess = JjimListDBBean.getInstance();

if(mode.equals("insert")){
	jjimProcess.insertJjim(jjim);
}
else if(mode.equals("delete")){
	jjimProcess.deleteJjim(jjim);
}
else if(mode.equals("deleteAll")){
	jjimProcess.deleteAllJjim(id);
}

response.sendRedirect(request.getHeader("referer"));//바로 직전페이지로

%>
