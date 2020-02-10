<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "usedcar.shopping.JjimCarDataBean" %>
<%@ page import = "usedcar.shopping.JjimListDataBean" %>
<%@ page import = "usedcar.shopping.JjimListDBBean" %>
<%@ page import = "java.util.List" %>  
<%@ page import = "java.text.NumberFormat" %>
<%
String sort = request.getParameter("sort");
if(sort == null){
	sort = "reg_date DESC";
}
else if(sort.equals("1")){
	sort = "car_price";
}
else if(sort.equals("2")){
	sort = "car_price DESC";
}
else if(sort.equals("3")){
	sort = "car_mileage";
}
else if(sort.equals("4")){
	sort = "car_birth DESC";
}
else{
	sort = "reg_date DESC";
}

String id = (String) session.getAttribute("user_id");
if(id == null) {
	response.sendRedirect("../shopMain.jsp");
	return;
}

String carImageFolder = "http://localhost:8888/UsedCar10/carimg";

JjimListDBBean jjimProcess = JjimListDBBean.getInstance();
int jjimListCnt = jjimProcess.getJjimCountByUserId(id);

//페이지네이션 방법

//전체 페이지 개수 구하기

int totalCount = jjimListCnt; // 데이터 개수, 물론 실제론 여긴 DBMS 에서 조회한 값이어야 한다. 25라고 가정하면

int countList = 10;// 한 페이지에서 보여줄 리스트의 개수

int totalPage = totalCount / countList; //25/10 = 2

//전체 페이지 보정
if (totalCount % countList > 0) {//25%10 = 5

totalPage++; //3

}

int curPage;//현재 페이지

if(request.getParameter("page") == null){
	curPage = 1;
}
else{
	curPage = Integer.parseInt(request.getParameter("page"));
}

if (totalPage < curPage) { //잘못된 현재 페이지(전체 페이지 보다 큰 경우)가 들어왔을 경우

	curPage = totalPage;//마지막 페이지로 보냄

}
if (curPage < 1) { //잘못된 현재 페이지(1보다 작은 경우)가 들어왔을 경우

	curPage = 1;//처음 페이지로 보냄

}


int countPage = 10; //페이지네이션의 개수

//현재 페이지가 20인 경우 스타트페이지를 유지하기 위해 (page - 1)을 하는 것

int startPage = ((curPage - 1) / countPage) * countPage + 1;

int endPage = startPage + countPage - 1;

//마지막 페이지 보정
if (endPage > totalPage) {

endPage = totalPage;

}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="../stylesheet/top.css">
	<link rel="stylesheet" type="text/css" href="../css/left.css">
	
    <script src="https://code.jquery.com/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    
    <title>찜 목록</title>
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
        
		function paging(num) {
			
			var url = new URL(location.href);
			if(url.toString().includes("page")){
				url.searchParams.set('page', num);
			}
			else{
				url.searchParams.append('page', num);
			}
    		location.href = url.toString();
		}
		
    </script>
    
    <style> 
		* {
			font-family: 'Montserrat', sans-serif;
		}
		    
        .pagination {
          display: inline-block;
        }
        
        .pagination span {
          color: black;
          float: left;
          padding: 8px 16px;
          text-decoration: none;
        }
        
        .pagination span.active {
          background-color:  #EE5A24;
          color: white;
          border-radius: 5px;
        }
        
        .pagination span:hover:not(.active) {
          background-color: #ddd;
          border-radius: 5px;
        }
        
		.sort{
		  display: inline-block;
		  padding-right: 10px;
		  cursor: pointer;
		}
		
		/* top 제어 */
		#header-container {
			width: 1200px;
			margin: 0 auto;
			font-size: 115%;
		}

    </style>
</head>
<body>
	<header id="header">
		<jsp:include page="../module/top.jsp" flush="false" />
	</header>

	<div id="nav-sidebar">
		<jsp:include page="../module/left.jsp" flush="false" />
	</div>
	<div style="padding-top: 40px;"></div>
    <div class="container">
	    <%	    
    	List<JjimCarDataBean> jjimList = jjimProcess.getJjimListByUserId(id, sort);
	    
	    if(jjimList == null) {
			%>
			<h4>찜한 목록이 존재하지 않습니다.</h4>
			<%
			return;
		} 
	    %>
	  
        <div style="font-size: 15px; display:inline-block;">
        	<font color="#EE5A24"><b>찜한 차량 </b></font>
        </div>
        <div align="right" style="display: inline-block; width:calc(100% - 100px);">
        	<div class="sort" onclick="sorting(0)" <%if(sort.equals("reg_date DESC")) {%> style="color:red" <%} %>>최근 등록순</div>
        	<div class="sort" onclick="sorting(1)" <%if(sort.equals("car_price")) {%> style="color:red" <%} %>>낮은 가격순</div>
        	<div class="sort" onclick="sorting(2)" <%if(sort.equals("car_price DESC")) {%> style="color:red" <%} %>>높은 가격순</div>
        	<div class="sort" onclick="sorting(3)" <%if(sort.equals("car_mileage")) {%> style="color:red" <%} %>>낮은 주행거리순</div>
        	<div class="sort" onclick="sorting(4)" <%if(sort.equals("car_birth DESC")) {%> style="color:red" <%} %>>최근 연식순</div>
        </div>
        <br><br>
        <table class="table table-hover">
            <thead style="border-top: 2px solid gainsboro;">
              <tr>
                <th width="500">차량정보</th>
                <th width="200">가격</th>
                <th width="50"></th>
              </tr>
            </thead>
            <tbody style="border-bottom: 2px solid gainsboro;">
            <%
    	    for(int i = 0; i < jjimList.size(); i++){ 
    	    	JjimCarDataBean car = (JjimCarDataBean)jjimList.get(i);
            %>
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td>
	                                <span style="cursor:pointer" onclick="window.open('../detail/detail.jsp?car_idx=<%=car.getCar_idx() %>')">
	                                   <img src="<%=carImageFolder%>/<%=car.getCar_img1()%>" alt="예제" width="120" height="80" style="object-fit: cover;">
		                           	</span>
                                </td>
                                <td style="padding-left: 20px;">
                                	<span style="cursor:pointer" onclick="window.open('../detail/detail.jsp?car_idx=<%=car.getCar_idx() %>')">
	                                    [ <%=car.getCar_brand() %>- <b><%=car.getCar_model() %></b> ] <%=car.getTitle() %><br>
	                                    <%=car.getCar_birth() %>년식 | <%=car.getCar_mileage() %>km | <%=car.getCar_oilType() %> | <%=car.getCar_location() %>
	                                </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="padding-top: 35px;">
                        <b><%=NumberFormat.getInstance().format(Integer.parseInt(car.getCar_price())) %></b> 만원
                    </td>
                    <td style="padding-top: 35px;">
                    	<a href="jjimPro.jsp?mode=delete&car_idx=<%=car.getCar_idx() %>" style="color:red;" onclick="return confirm('찜한 차량을 삭제하시겠습니까?');"><b>삭제</b></a>
                    </td>
                </tr>
                <%} %>
            </tbody>
        </table>
        <div align="right">
        	<a class="btn btn-danger" href="jjimPro.jsp?mode=deleteAll" onclick="return confirm('전체 삭제하시겠습니까?');">전체 삭제</a>
        </div>
        
        <div style="margin: auto; width: fit-content;">
            <div class="pagination">
	        <%
	        if (startPage > 1) {//맨앞으로
        	%>
        	<span onclick="paging(1)">&laquo;</span>
        	<%
	        }
	
	        if (curPage > 1) {
        	%>
        	<span onclick="paging(<%=curPage - 1 %>)">이전</span>
        	<%
	
	        }
	
	        for (int iCount = startPage; iCount <= endPage; iCount++) {
	         
	            if (iCount == curPage) {//현재 페이지는 특별하게
	            %>
        		<span onclick="paging(<%=iCount %>)" class="active"><%=iCount %></span>
            	<%
	
	            } else {
            	%>
        		<span onclick="paging(<%=iCount %>)"><%=iCount %></span>
            	<%
	            }
	
	        }
	        
	        if (curPage < totalPage) {
        	%>
        	<span onclick="paging(<%=curPage + 1 %>)">다음</span>
        	<%
	        }
	
	        if (endPage < totalPage) {//맨끝으로
        	%>
        	<span onclick="paging(<%=totalPage %>)">&raquo;</span>
        	<%
	        }
	        %>
            </div>
        </div>
    </div>
    <footer style="position: absolute; bottom: 0; left: 0; right: 0;">
	<div style="background-color: #f1f1f1; padding: 40px;">
		<p style="text-align: center; color: rgb(116, 116, 116); font-family: 'Montserrat', sans-serif;">© Copyright 2019 KooKSan - All rights reserved.</p>
	</div>
	</footer>
</body>
</html>