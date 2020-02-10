<%@page import="usedcar.shopping.CarListDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String model = request.getParameter("model");
String ccQuery = request.getParameter("cc");

CarListDBBean dao = CarListDBBean.getInstance();
int cc_min = 0;
int cc_max = 0;
int cc_cnt = 0;
if(ccQuery.contains("lt")&&ccQuery.contains("gt")){
	int minValue = Integer.parseInt(ccQuery.substring(ccQuery.indexOf("g")+2, ccQuery.indexOf("l")));
	int maxValue = Integer.parseInt(ccQuery.substring(ccQuery.indexOf("l")+2, ccQuery.length()));
	cc_min = minValue;
	cc_max = maxValue;
	cc_cnt = dao.getcarListCount("car_model", model, "car_cc", minValue, maxValue);
} else if(ccQuery.contains("lt")){
	int maxValue = Integer.parseInt(ccQuery.substring(ccQuery.indexOf("l")+2, ccQuery.length()));
	cc_cnt = dao.getcarListCount("car_model", model, "car_cc", 0, maxValue);
} else if(ccQuery.contains("gt")){
	int minValue = Integer.parseInt(ccQuery.substring(ccQuery.indexOf("g")+2, ccQuery.length()));
	cc_cnt = dao.getcarListCount("car_model", model, "car_cc", minValue, 0);
}
%>
min:<%=cc_min %>|max:<%=cc_max %>|cnt:<%=cc_cnt %>