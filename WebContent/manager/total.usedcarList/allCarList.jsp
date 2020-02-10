<%@page import="usedcar.shopping.CarListDBBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "usedcar.shopping.CarListDataBean" %>
<%@ page import = "usedcar.shopping.CarListDBBean" %>
<%@ page import = "java.util.List" %>  
<%@ page import = "java.text.NumberFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

String sort = request.getParameter("sort");
if(sort == null){
   sort = "reg_date DESC";
} else if(sort.equals("1")) {
   sort = "car_price";
} else if(sort.equals("2")) {
   sort = "car_price DESC";
} else if(sort.equals("3")) {
   sort = "car_mileage";
} else if(sort.equals("4")) {
   sort = "car_birth DESC";
} else{
   sort = "reg_date DESC";
}

String realFolder = "http://localhost:8888/UsedCar10/carimg";

CarListDBBean carProcess = CarListDBBean.getInstance();

int carListCnt = carProcess.getcarListCount();
if(carListCnt == 0) {
	 response.sendRedirect("http://localhost:8888/UsedCar10/shopping/logon/dealerUpdateForm.jsp");
   return;
}

String managerId = (String)session.getAttribute("managerid");

if(managerId == null) {
	   response.sendRedirect("http://localhost:8888/UsedCar10/manager/manager.logon/managerLoginForm.jsp?useSSL=false");
	} else {

%>

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Language" content="ko">
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <title>게시글 목록</title>
    <script>
     function sorting(num) {
         
         var url = new URL(location.href);
         if(url.toString().includes("sort")){
            url.searchParams.set('sort', num);
         }
         else{
            url.searchParams.append('sort', num);
         }
          location.href = url.toString();
      }
     
      function changeSelStatus(sel_status_form) {
         if(confirm('차량 구분을 변경합니다. (판매완료시 차량 판매 게시글이 삭제됩니다.)')) {
            sel_status_form.action = "allCarListPro.jsp";
            sel_status_form.submit();
         } else {
            location.href = "allCarList.jsp";
         }
      }
      
   
    </script>
    
    <style>   
      .sort{
        display: inline-block;
        padding-right: 10px;
        cursor: pointer;
      }
      
      .container {
      	width: 1400px;
      	margin: 0 auto;
      }
      
      #carListTable {
      	border-collapse: collapse;
      	width: 100%;
      }
      #carListTable tr th {
      	text-align: center;
      	border-bottom: 2px solid gainsboro;
      	border-top: 2px solid gainsboro;
      	height: 50px;
      	font-size: 16px;
      }

	  #carListInfo td {
	  	text-align: center;
	  	border-bottom: 1px solid #eee;
	  	height: 100px;
	  	font-size: 15px;
	  }

    </style>
</head>
<body>
	<div style="color: #FFF; height: 200px; background-image: url(../../img/topimg.jpg)">
	<br>
	<br>
	<h2 style="text-align: center;">등록된 차량 관리</h2>
	<br>
	<br>
	<br>
	<a href="../managerMain.jsp" >&nbsp;&nbsp;&nbsp;&nbsp;관리자 메인으로</a>


	<div class="container" style="margin-top: 40px;">
		 <%
	       List<CarListDataBean> carList = carProcess.getCarList(sort);
	        
	       
	       if (carList == null){
          %>
          <h4>검색조건에 맞는 차량이 존재하지 않습니다.</h4>
          <%
          return;
       }
       
      %>
    <br />
    <div style="text-align: center; color:rgb(32, 40, 43); font-size: 20px;"><b>검색 : </b><input id="myInput" type="text" style="padding-left: 10px;" placeholder="Search..."></div>
    <br />
    
        <div align="right" style="display: inline-block; width:auto; float: right; color: black;">
           <div class="sort" onclick="sorting(0)" <%if(sort.equals("reg_date DESC")) {%> style="color:red" <%} %>>최근 등록순</div>
           <div class="sort" onclick="sorting(1)" <%if(sort.equals("car_price")) {%> style="color:red" <%} %>>낮은 가격순</div>
           <div class="sort" onclick="sorting(2)" <%if(sort.equals("car_price DESC")) {%> style="color:red" <%} %>>높은 가격순</div>
           <div class="sort" onclick="sorting(3)" <%if(sort.equals("car_mileage")) {%> style="color:red" <%} %>>낮은 주행거리순</div>
           <div class="sort" onclick="sorting(4)" <%if(sort.equals("car_birth DESC")) {%> style="color:red" <%} %>>최근 연식순</div>
        </div>
        <br>
        <br>
       
	    
	   
	        <table id="carListTable" style="color: black;">
	        	<tr>
	        		<th style="width: 100px;">차량 등록번호</th>
	        		<th style="width: 150px;">판매자</th>
	        		<th style="width: 650px;">차량정보</th>
	        		<th style="width: 200px;">가격</th>
	        		<th style="width: 130px;">구분</th>
	        	</tr>
	       
	        	<%
	        	for(int i = 0; i < carList.size(); i++) {
	        		CarListDataBean car = (CarListDataBean)carList.get(i);
	        	%>
	        	<tr id="carListInfo">
	        		<td><%=car.getCar_idx() %></td>
	        		<td id="dealer_id"><%=car.getDealer_id() %></td> 
	        		<td>
		        		<div style="margin-left: 200px;">
		        			<div style="float: left;"><img src="<%=realFolder%>/<%=car.getCar_img1()%>" alt="예제" width="120" height="80" style="object-fit: cover;"></div>
		        			<div style="float: left; padding-left: 15px;">[ <%=car.getCar_brand() %>- <b><%=car.getCar_model() %></b> ] <%=car.getTitle() %> <br />
		                                    <%=car.getCar_birth() %>년식 | <%=car.getCar_mileage() %>km | <%=car.getCar_oilType() %></div>
	                    </div>
	        		</td> 
	        		<td><b><%=NumberFormat.getInstance().format(Integer.parseInt(car.getCar_price())) %></b> 만원</td>
	        		 <form action="" method="get" name="sel_status_form">
	                    <td style="text-align: center; padding: 15px;">
	                    
	                       <select id="sel_status" class="sel_status" name="sel_status" class="sel_status" style="height: 2em; width: 91.5px;">
	                            <option value="0" <%if(car.getSel_status() == 0) {%> selected <%}%>>판매중</option>
	                            <option value="1" <%if(car.getSel_status() == 1) {%> selected <%}%>>거래중</option>
	                            <option value="2" >판매완료</option>
	                        </select>
	                        <br>
	                        <div style="height: 2px;"></div>
	                        <button class="okbtn" type="button" onclick="changeSelStatus(this.form)" style="height: 2em;">확인</button>
	                        
	                    </td>
	                   <input type="hidden" value="<%=car.getCar_idx() %>" name="getCarIdx">
	                 </form>
	        	</tr>
	        	<%
	        	}
	        	%>
	        </table>
        
        
        <br />
       
        <div style="margin: auto; width: fit-content; cursor: pointer;">
            <div class="pagination"></div>
        </div>
	</div>

<script>
//검색 기능을 위한 Jquery활용
//검색 기능	
$(document).ready(function(){
	 $("#myInput").on("keyup", function() {
		  var value = $(this).val().toLowerCase();
		  $("#carListTable #carListInfo").filter(function() {
			 console.log(this);
		    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
		    $(this).eq();
		 });
		});
});
</script>
	
</body>
		
</html>


<% } %>