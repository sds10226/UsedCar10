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
String id = (String)session.getAttribute("user_id");


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

String realFolder = "http://192.168.11.3:8888/UsedCar10/carimg";

CarListDBBean carProcess = CarListDBBean.getInstance();

int carListCnt = carProcess.getcarListCountByDealerId(id);
if(carListCnt == 0) {
   response.sendRedirect("http://localhost:8888/UsedCar10/shopping/logon/dealerUpdateForm.jsp");
   return;
}

if(id == null) {
      response.sendRedirect("http://localhost:8888/UsedCar10/ShopMain.jsp");
   } else {
      
      
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
if(request.getParameter("page") == null) {
   curPage = 1;
   } else {
      curPage = Integer.parseInt(request.getParameter("page"));
}

if (totalPage < curPage) { //잘못된 현재 페이지(전체 페이지 보다 큰 경우)가 들어왔을 경우
   curPage = totalPage;//마지막 페이지로 보냄
}

if (curPage < 1) { //잘못된 현재 페이지(1보다 작은 경우)가 들어왔을 경우
   curPage = 1;//처음 페이지로 보냄
}

int countPage = 10; //페이지네이션의 개수

//현재 페이지가 10인 경우 스타트페이지를 유지하기 위해 (page - 1)을 하는 것
//현재 페이지가 0부터 시작한다면 상관 없는 부분이다. 이 경우 코드 맨 끝 +1, -1 부분도 삭제해야한다.
int startPage = ((curPage - 1) / countPage) * countPage + 1;
int endPage = startPage + countPage - 1;

//마지막 페이지 보정
if (endPage > totalPage) {
   endPage = totalPage;
}

%>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Language" content="ko">
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../../stylesheet/footer.css">
   <link rel="stylesheet" type="text/css" href="../../stylesheet/top.css">
   <link rel="stylesheet" type="text/css" href="../../css/left.css">
   <link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet">
      
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    
    <title>게시글 목록</title>
    <script>
        function scrollMove() {
            document.body.scrollTop = 0;
            document.documentElement.scrollTop = 0;
        }
        
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
      
      function changeSelStatus(sel_status_form) {
         if(confirm('차량 구분을 변경합니다. (판매완료시 차량 판매 게시글이 삭제됩니다.)')) {
            sel_status_form.action = "myCarListPro.jsp";
            sel_status_form.submit();
         } else {
            location.href = "myCarList.jsp";
         }
      }
    </script>
    
    <style>
          * {
         font-family: 'montserrat', sans-serif;
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
   <jsp:include page="../../module/top.jsp" flush="false" /> </header>

   <div id="nav-sidebar">
      <jsp:include page="../../module/left.jsp" flush="false" />
   </div>
   
   <div class="container" style="margin-top: 40px;">
       <%
          List<CarListDataBean> carList = carProcess.getCarListByDealerId(sort, curPage, countList, id);
           
          
          if (carList == null){
          %>
          <h4>검색조건에 맞는 차량이 존재하지 않습니다.</h4>
          <%
          return;
       }
       
      %>
        
        <div style="font-size: 15px; display:inline-block; float: left;">
           <font color="#EE5A24" size="4"><b><%=session.getAttribute("user_id")%>님의 차량 </b></font>
        </div>
        <div align="right" style="display: inline-block; width:auto; float: right;">
           <div class="sort" onclick="sorting(0)" <%if(sort.equals("reg_date DESC")) {%> style="color:red" <%} %>>최근 등록순</div>
           <div class="sort" onclick="sorting(1)" <%if(sort.equals("car_price")) {%> style="color:red" <%} %>>낮은 가격순</div>
           <div class="sort" onclick="sorting(2)" <%if(sort.equals("car_price DESC")) {%> style="color:red" <%} %>>높은 가격순</div>
           <div class="sort" onclick="sorting(3)" <%if(sort.equals("car_mileage")) {%> style="color:red" <%} %>>낮은 주행거리순</div>
           <div class="sort" onclick="sorting(4)" <%if(sort.equals("car_birth DESC")) {%> style="color:red" <%} %>>최근 연식순</div>
        </div>
        <br>
        <br>
        <table class="table table-hover">
            <thead style="border-top: 2px solid gainsboro;">
              <tr>
                <th width="500">차량정보</th>
                <th width="200">가격</th>
                <th width="50" style="text-align: center;">구분</th>
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
                                    <img src="<%=realFolder%>/<%=car.getCar_img1()%>" alt="예제" width="120" height="80" style="object-fit: cover;">
                                </td>
                                <td style="padding-left: 20px;">
                                    [ <%=car.getCar_brand() %>- <b><%=car.getCar_model() %></b> ] <%=car.getTitle() %><br>
                                    <%=car.getCar_birth() %>년식 | <%=car.getCar_mileage() %>km | <%=car.getCar_oilType() %> | <%=car.getCar_location() %>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="padding-top: 35px;">
                        <b><%=NumberFormat.getInstance().format(Integer.parseInt(car.getCar_price())) %></b> 만원
                    </td>
                    
                    <form action="" method="get" name="sel_status_form">
                       <td style="text-align: center; padding: 15px;">
                       
                          <select id="sel_status" class="sel_status" name="sel_status" class="sel_status" style="height: 2em; width: 91.5px;">
                               <option value="0" <%if(car.getSel_status() == 0) {%> selected <%}%>>판매중</option>
                               <option value="1" <%if(car.getSel_status() == 1) {%> selected <%}%>>거래중</option>
                               <option value="2" >판매완료</option>
                           </select>
                           <br>
                           <div style="height: 2px;"></div>
                           <button type="button" onclick="changeSelStatus(this.form)" style="height: 2em; color: black;">확인</button>
                           <button style="height: 2em;"><a style="text-decoration: none; color: black;" href="http://localhost:8888/UsedCar10/shopping/car/updatecar.jsp?car_idx=<%=car.getCar_idx() %>">수정</a></button>
                           
                       </td>
                      <input type="hidden" value="<%=car.getCar_idx() %>" name="getCarIdx">    
                    </form>
                    
                </tr>
                <%} %>
            </tbody>
            
        </table>
        <button style="height: 2em;"><a style="text-decoration: none; color: black;" href="http://localhost:8888/UsedCar10/shopping/car/insertcar.jsp">상품등록</a></button>
        
        
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
   <footer>
   <div style="background-color: #f1f1f1; padding: 40px;">
      <p style="text-align: center; color: rgb(116, 116, 116); font-family: 'Montserrat', sans-serif;">© Copyright 2019 KooKSan - All rights reserved.</p>
   </div>
   </footer>
   
</body>
      
</html>


<%
	}
%>