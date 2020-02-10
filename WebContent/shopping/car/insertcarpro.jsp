<%@page import="java.util.Vector"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="usedcar.shopping.CarListDBBean" %>

<%
request.setCharacterEncoding("utf-8");

String	realFolder 	= "";	
Vector<String> filenames = new Vector<>();
MultipartRequest multireq = null;

String	saveFolder	= "/carimg"; 
String	encType		= "utf-8";		
int		maxSize		= 8*1024*1024;	//8 메가바이트

ServletContext	context	= getServletContext();
realFolder	= context.getRealPath(saveFolder);

System.out.println("realFolder : " + realFolder);

try {
	multireq = new MultipartRequest(
				request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	Enumeration<?>	files = multireq.getFileNames();
	while(files.hasMoreElements()) {		
		String name = (String)files.nextElement();
		System.out.println(name);
		filenames.add(multireq.getFilesystemName(name));
	}
} catch(Exception e) {
	e.printStackTrace();
}



String car_img1 = filenames.get(0);
String car_img2 = filenames.get(1);
String car_img3 = filenames.get(2);

String title = multireq.getParameter("title");	
String dealer_id = (String)session.getAttribute("user_id");	
String description = multireq.getParameter("description");	
String car_type = multireq.getParameter("car_type");	
String car_brand = multireq.getParameter("car_brand");	
String car_model = multireq.getParameter("car_model");
String car_cc = multireq.getParameter("car_cc");	
String car_oilType = multireq.getParameter("car_oilType");	
String car_birth = multireq.getParameter("car_birth");	
String car_mileage = multireq.getParameter("car_mileage");	
String car_price = multireq.getParameter("car_price");	
String car_location = multireq.getParameter("car_location");	
String car_color = multireq.getParameter("car_color");	
String car_gear = multireq.getParameter("car_gear");	
String car_option = multireq.getParameter("car_option");	
String car_regNum = multireq.getParameter("car_regNum");	

CarListDBBean dao = CarListDBBean.getInstance();

System.out.println(car_img1+" / "+car_img2+" / "+car_img3+" / "+title+" / "+dealer_id+" / "+description);
System.out.println(car_type+" / "+car_brand+" / "+car_model+" / "+car_cc+" / "+car_oilType+" / "+car_birth);
System.out.println(car_mileage+" / "+car_price+" / "+car_location+" / "+car_color+" / "+car_gear+" / "+car_regNum);
System.out.println(car_option);

dao.insertCar(car_img1, car_img2, car_img3, title, dealer_id, description, car_type, car_brand, car_model, car_cc, car_oilType, 
	car_birth, car_mileage, car_price, car_location, car_color, car_gear, car_option, car_regNum);

response.sendRedirect("http://localhost:8888/UsedCar10/shopping/logon/myCarList.jsp");
%>