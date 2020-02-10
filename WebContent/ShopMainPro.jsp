<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.util.ArrayList"%>
<%@page import="usedcar.shopping.CarListDBBean"%>

<%
	request.setCharacterEncoding("utf-8");
	
	/* ajax로 main에서 car_brand select 값을 받아옴 */
	String car_brand = request.getParameter("car_brand");
	
	System.out.println("### ShopMainPro에서 찍는 car_brand :" + car_brand);
	
	/* dao로 보내서 model값 받아오는 작업 */
	CarListDBBean carListProcess = CarListDBBean.getInstance();
	List<String> carModelList = carListProcess.getModelList(car_brand);

	/* ajax로 출력할 내용들 */
	%>
	<option value="" hidden>Model</option>
	<% for(int i = 0; i < carModelList.size(); i++) { %> 
		<option value="<%=carModelList.get(i) %>"><%=carModelList.get(i) %></option>
	<%} %>
	
	<%
		carModelList.clear();
	%>


