<%@page import="usedcar.shopping.JjimListDBBean"%>
<%@page import="usedcar.shopping.CarListDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
   request.setCharacterEncoding("UTF-8");

	int sel_status = Integer.parseInt(request.getParameter("sel_status"));
	int getCarIdx = Integer.parseInt(request.getParameter("getCarIdx"));

   CarListDBBean carListProcess = CarListDBBean.getInstance();
   JjimListDBBean jjimListProcess = JjimListDBBean.getInstance(); 
   
   if(sel_status == 0 || sel_status == 1) {
      carListProcess.setSel_status(sel_status, getCarIdx);
      response.sendRedirect("http://localhost:8888/UsedCar10/manager/total.usedcarList/allCarList.jsp");
   } else {
      carListProcess.deleteCar(getCarIdx);
      jjimListProcess.deleteCar(getCarIdx);
      response.sendRedirect("http://localhost:8888/UsedCar10/manager/total.usedcarList/allCarList.jsp");
   }
   
   


%>


