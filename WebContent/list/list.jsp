<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "usedcar.shopping.CarListDataBean" %>
<%@ page import = "usedcar.shopping.CarListDBBean" %>
<%@ page import = "usedcar.shopping.JjimListDataBean" %>
<%@ page import = "usedcar.shopping.JjimListDBBean" %>
<%@ page import = "java.util.List" %>  
<%@ page import = "java.text.NumberFormat" %>
<%
/* int car_idx;
if(request.getParameter("car_idx") != null){
	car_idx = Integer.parseInt(request.getParameter("car_idx"));
}
String car_img1 = request.getParameter("car_img1");
String car_img2 = request.getParameter("car_img2");
String car_img3 = request.getParameter("car_img3");
String title = request.getParameter("title");
String dealer_id = request.getParameter("dealer_id");
String description = request.getParameter("description");
String reg_date = request.getParameter("reg_date");
int sel_status;
if(request.getParameter("sel_status") != null){
	sel_status = Integer.parseInt(request.getParameter("sel_status"));
} */
String car_type = request.getParameter("car_type");
String car_brand = request.getParameter("car_brand");
String car_model = request.getParameter("car_model");
String car_cc = request.getParameter("car_cc");
String car_oilType = request.getParameter("car_oilType");
String car_birth = request.getParameter("car_birth");
String car_mileage = request.getParameter("car_mileage");
String car_price = request.getParameter("car_price");
String car_location = request.getParameter("car_location");
String car_color = request.getParameter("car_color");
String car_gear = request.getParameter("car_gear");
String car_option = request.getParameter("car_option");
String car_regNum = request.getParameter("car_regNum");

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

String carImageFolder = "http://localhost:8888/UsedCar10/carimg";

CarListDBBean carProcess = CarListDBBean.getInstance();
JjimListDBBean jjimProcess = JjimListDBBean.getInstance();

int carListCnt = carProcess.getcarListCount(
		car_type, car_brand, car_model, car_cc, car_oilType, 
		car_birth, car_mileage, car_price, car_location, car_color, 
		car_gear, car_option, car_regNum);

String id = (String)session.getAttribute("user_id");

//페이지네이션 방법

//전체 페이지 개수 구하기

int totalCount = carListCnt; // 데이터 개수, 물론 실제론 여긴 DBMS 에서 조회한 값이어야 한다. 25라고 가정하면

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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <title>게시글 목록</title>
    <script>
        function scrollMove() {
            document.body.scrollTop = 0;
            document.documentElement.scrollTop = 0;
        }
        
        window.onload = function(){
        	//alert();
			var imgs = document.getElementsByClassName("img");
			var divAspect = 0.7; // div의 가로세로비
			
			for(var img of imgs){
				var imgAspect = img.height / img.width;
				 
				if (imgAspect <= divAspect) {
					img.className += " landscape";//왜인지 모르겠지만 =으로 하면 홀수만 적용됨..
				} else {
					img.className += " portrait";
				}
			}
			
			//저장된 스크롤값 가져오기
            document.body.scrollTop = getCookie("scroll");
			document.documentElement.scrollTop = getCookie("scroll");
        	setCookie("scroll", 0, 1);//초기화
        }
        
        function checkLogin(obj, car_idx){
        	var id = "<%=id %>";
        	if(id == "null"){
        		alert("로그인이 필요합니다.");
        		return;
        	}
			
        	setCookie("scroll", document.documentElement.scrollTop, 1);//스크롤값 저장
        	
        	if(obj.style.color == "red"){
	    		location.href = "../jjim/jjimPro.jsp?mode=delete&car_idx=" + car_idx;
        	}
        	else{
	    		location.href = "../jjim/jjimPro.jsp?mode=insert&car_idx=" + car_idx;
        	}
        }
        
        function sorting(num) {
        	
        	setCookie("scroll", document.documentElement.scrollTop, 1);//스크롤값 저장
			
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
		
		var setCookie = function(name, value, exp) {
			var date = new Date();
			date.setTime(date.getTime() + exp*24*60*60*1000);
			document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
		}
			
		var getCookie = function(name) {
			var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
			return value? value[2] : null;
		}
		
    </script>
    
    <style>
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
        
        .thumbnail {
		  padding: 0 0 15px 0;
		  border: none;
		  border-radius: 0;
		}
				
		.thumbnail2 {
		  position: relative;
		  padding-top: 70%;
		  overflow: hidden;
		  margin-bottom: 10px;
		}
		
		.thumbnail2 .centered  {
	  	  position: absolute;
	      top: 0;
	      left: 0;
	      right: 0;
	      bottom: 0;
	  	  -webkit-transform: translate(50%,50%);
	      -ms-transform: translate(50%,50%);
	      transform: translate(50%,50%);
		}
		
		.thumbnail2 .centered img {
		  -webkit-transform: translate(-50%,-50%);
		  -ms-transform: translate(-50%,-50%);
		  transform: translate(-50%,-50%);
		}
		
		.thumbnail2 img.portrait {
		  width: 100%;
		  height: auto;
		}
		
		.thumbnail2 img.landscape {
		  width: auto;
		  height: 100%;
		}
		
		.sort{
		  display: inline-block;
		  padding-right: 10px;
		  cursor: pointer;
		}

    </style>
</head>
<body>
    <div class="container">
    
	    <div class="row">
	    <%
		List<CarListDataBean> carList = carProcess.getCarList(sort, curPage, countList, 
				car_type, car_brand, car_model, car_cc, car_oilType, 
				car_birth, car_mileage, car_price, car_location, car_color, 
				car_gear, car_option, car_regNum);
    	List<JjimListDataBean> jjimList = jjimProcess.getJjimListByUserId(id);
	    
	    if (carList == null){
	    	%>
	    	<h4>검색조건에 맞는 차량이 존재하지 않습니다.</h4>
	    	<%
	    	return;
	    }
	    
	    for(int i=0; i<8 && i<carList.size(); i++){ 
	    	CarListDataBean car = (CarListDataBean)carList.get(i);
	    %>
		    <div class="col-sm-3">
		    	<div class="thumbnail">
		    		<div class="thumbnail2">
			    		<div class="centered">
			      			<img class="img" src="<%=carImageFolder%>/<%=car.getCar_img1()%>">
			      		</div>
		      		</div>
					<div style="height: 3em;">[ <%=car.getCar_brand() %>- <b><%=car.getCar_model() %></b> ] <%=car.getTitle() %></div>
					<div style="height: 3em;"><%=car.getCar_birth() %>년식 | <%=car.getCar_mileage() %>km | <%=car.getCar_oilType() %> | <%=car.getCar_location() %></div>
					<b><span style="font-size: 20px;"><%=NumberFormat.getInstance().format(Integer.parseInt(car.getCar_price())) %></span> 만원</b>
				</div>
	    	</div>
		    <%} %>
	  	</div>
	  	
        <div style="font-size: 15px; display:inline-block;">
        	<b>등록된 차량 </b>
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
                <th width="50">찜</th>
              </tr>
            </thead>
            <tbody style="border-bottom: 2px solid gainsboro;">
            <%
            for(int i=0; i<countList && i<carList.size(); i++){ 
    	    	CarListDataBean car = (CarListDataBean)carList.get(i);
            %>
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td>
                                	<span style="cursor:pointer" onclick="window.open('../detail/detail.jsp?car_idx=<%=car.getCar_idx() %>')">
                                    	<img src="<%=carImageFolder%>/<%=car.getCar_img1()%>" alt="예제" width="120" height="80" style="object-fit: cover;">
                                    </span>
                                    <!-- 브라우저 버전 문제로 object-fit 사용하지 않을 경우 다음 적용 -->
                                    <!-- 
				      				<div style="width: 120px; height: 80px; overflow: hidden">가로가 긴 이미지
				    					<img src="media/mainImg.jpg" style="width: auto; height: 100%; margin-left: -30px;">
									</div>
				      				<div style="width: 120px; height: 80px; overflow: hidden">세로가 긴 이미지
				    					<img src="media/mainImg.jpg" style="width: 100%; height: auto;">
									</div>
									
									//자바스크립트 영역(이미지의 비율을 모르는 경우)
									var div = ... // 이미지를 감싸는 div
									var img = ... // 이미지
									var divAspect = 80 / 120; // div의 가로세로비
									var imgAspect = img.height / img.width;
									 
									if (imgAspect <= divAspect) {
									    // 이미지가 div보다 납작한 경우 세로를 div에 맞추고 가로는 잘라낸다
									    var imgWidthActual = div.offsetHeight / imgAspect;
									    var imgWidthToBe = div.offsetHeight / divAspect;
									    var marginLeft = -Math.round((imgWidthActual - imgWidthToBe) / 2);
									    
									    img.style.cssText = 'width: auto; height: 100%; margin-left: '
									                      + marginLeft + 'px;'
									} else {
									    // 이미지가 div보다 길쭉한 경우 가로를 div에 맞추고 세로를 잘라낸다
									    img.style.cssText = 'width: 100%; height: auto; margin-left: 0;';
									}
									 -->
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
                    	<%                    	
                    	int j;
                        loop:for(j=0; jjimList!=null && j<jjimList.size(); j++){ 
                        	JjimListDataBean jjim = (JjimListDataBean)jjimList.get(j);
                        	
	                    	if(jjim.getCar_idx() == car.getCar_idx()){
	                    	%>
	                    		<span class="glyphicon glyphicon-heart" style="color: red; cursor: pointer;" onclick="checkLogin(this, <%= car.getCar_idx()%>)"></span>
	                    	<%
	                    		break loop;
	                    	} 
                    	}
                    	if(jjimList == null || j == jjimList.size()){
                    		%>
	                    	<span class="glyphicon glyphicon-heart-empty" style="cursor: pointer;" onclick="checkLogin(this, <%= car.getCar_idx()%>)"></span>
	                    	<% 
                    	} 
                    	%>
                    	
                    </td>
                </tr>
                <%} %>
            </tbody>
        </table>
        <div id="top" onclick="scrollMove()" style="cursor: pointer; width: fit-content; margin: auto; ">
            <b>top</b>
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
</body>
</html>