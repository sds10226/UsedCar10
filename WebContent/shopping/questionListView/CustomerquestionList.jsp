
<%@page import="com.mysql.fabric.xmlrpc.base.Value"%>
<%@page import="usedcar.shopping.CarListDataBean"%>
<%@page import="usedcar.question.MemberQuestionDataBean"%>
<%@page import="usedcar.shopping.CarListDBBean"%>
<%@page import="usedcar.question.CustomerQuestionDBBean"%>
<%@page import="usedcar.shopping.CustomerDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="usedcar.shopping.CustomerDBBean"%>
<%@page import="usedcar.shopping.CustomerDataBean"%>
<%@page import="java.text.SimpleDateFormat"%>    
<%@ page import = "java.util.List" %>

<%
String Id = (String)session.getAttribute("user_id");
%>

<% 
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>   
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">

<link rel="stylesheet" type="text/css" href="../../stylesheet/top.css">
<link rel="stylesheet" type="text/css" href="../../css/left.css">

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery.min.js"></script>
<title>보낸 문의 사항</title>
<style type="text/css">
		
		#container {width: 1200px; height:auto;}
        #user-table {margin: 0 auto; text-align: center; width: 100%;}
        #user-table {border-collapse: collapse;}
        #user-table > thead > tr { background-color: #ffdd59; color:#fff; }
        #user-table > thead > tr > th { padding: 0px; text-align: center; }
        #user-table > tbody > tr > td { border-bottom: 1px solid gray; padding:8px; }
        
	
		 /* 왼쪽 질문 답변 setting */
  		  .qna-title {
        	background-color: white;

        	border: none;
        	border-bottom: 1px solid lightgray;
	        color: black;
     	   cursor: pointer;
        	padding: 18px;
        	width: 1500px;;
        	text-align: left;
        	outline: none;
        	font-size: 15px;
   		 }
    	.firstinfo {
        	border-top: 2px solid #7e7e7e;
    	}
	  	.qna-title:hover {
        background-color: #eee;
  	  	}

  	  	.qna-content {
        padding: 0 18px;
        
        border-bottom: 1px solid #d3d3d3;
        max-height: 0;
        overflow: hidden;
        width: 1500px;
        transition: max-height 0.2s ease-out;
        background-color: #f1f1f1;
        font-size: 80%;
        margin: 0 auto;
   	 	}
   	 	#qna-infoContentTool {
        width: 1500px;
        float: left;
  	  }

  	
	span{
	display: inline-block;
	}
	.number{
	width: 60px;
	}
	.car_title{
	width: 720px;
	text-align: center;
	}
	.customer_User_id{
	width: 70px;
	text-align: center;
	}
	.tel{
	width: 200px;
	text-align: center;
	}
	.car_own{
	width: 100px;
	}
	.dealer_id{
	width: 100px;
	}
	.qReg_date{
	width: 150px;
	}
	
	</style>
</head>
<script type="text/javascript">
function scrollMove() {
	document.body.scrollTop = 0;
	document.documentElement.scrollTop = 0;
}/* top으로 위로 올리게 한다.*/


</script> 
<%
CustomerDBBean customerProcess = CustomerDBBean.getInstance();//phone정보 추출하기
CustomerQuestionDBBean customerQ_Process = CustomerQuestionDBBean.getInstance();
CarListDBBean customerC_Process = CarListDBBean.getInstance();//car정보들 추출하기
//------------------------------------------------------------------------------


//회원의 모든 정보를 가져온다.
//customer.getxxx

List<MemberQuestionDataBean> customerQuestion = null;
List<CarListDataBean> customerCar_List  = null;
//세션에 해당하는 아이디를 가진 딜러에게 문의온 내역을 모두 출력한다.
//customerQuestion.getxxx



int getCarIdx = 0;
int number = 0; //게시물 숫자표시 순번
int memberCount = 0;
memberCount = customerQ_Process.getQusetionCount(Id);
%>    
    

<body>
<header id="header">
		<jsp:include page="../../module/top.jsp" flush="false" />
	</header>

	<div id="nav-sidebar">
		<jsp:include page="../../module/left.jsp" flush="false" />
	</div>
	
<% //데이터가 한명도 없으면
if(memberCount <= 0){ 
%>
 <table class="table table-bordered table-striped nanum table-hover">
	<tr>
		<td align="center">등록된 고객문의가 없습니다.</td>
	</tr>
</table>

<%}else{
	customerQuestion = customerQ_Process.getQuestionId(Id);
%>
<div style="padding-top: 50px;"></div>
<div id="container" style="margin: 0 auto;">

<div id = "qna-infoContentTool">
	 <p style="height: 30px;"><i class="fas fa-check-square" style="color: #EE5A24;"></i> <b>내가 물어본 문의 사항</b></p>

 <table id="user-table">
	<thead>
	<tr height="20" >
		<th style="width:25px; text-align:center; height: 30px;">번	호</th>
		<th style="width:400px; text-align:center;">제	목</th>
		<th style="width:70px; text-align:center;">작성자</th>
		<th style="width:70px; text-align:center;">핸드폰 번호</th>
		<th style="width:70px; text-align:center;">차량소유 여부</th>
		<th style="width:70px; text-align:center;">딜러 id</th>
		<th style="width:70px; text-align:center;">작성날짜</th>
		<th style="width:50px; text-align:center;">삭	제</th>	
	</tr>
	</thead>
</table>
</div>
	
	<%
	CustomerDataBean customer = customerProcess.getMember(Id);
	String car_own = "";
for(int i = 0; i < customerQuestion.size(); i++) {//문의목록에 있는 문의 하나를 꺼내서
		getCarIdx = customerQuestion.get(i).getCar_idx();//문의한 차량의
		CarListDataBean car = customerC_Process.getCar(getCarIdx);//정보들을 가져와서
		
		int Car_own = (int)customerQuestion.get(i).getCar_own();
		if(Car_own == 1) {
			car_own = "有";
		}else{
			car_own = "無";
		}
	
		//폰정보도 가져와서
		//여기서부터  html 태그로 찜하나를 출력해줌
	%>
<div id="select-container">
	
		<button class="qna-title">
		<span class="number"><%=++number%>.</span>
		<span class="car_title"><%=car.getTitle() %></span>
		<span class="customer_User_id"><%=customer.getUser_id() %></span>
		<span class="tel"><%=customer.getTel() %></span>		
		<span class="car_own"><%=car_own %></span>
		<span class="dealer_id"><%=car.getDealer_id() %></span>
		<span class="qReg_date"><%=sdf.format(customerQuestion.get(i).getReg_date()) %></span>
		</button>
		
		<div class="qna-content">
			<p><%=customerQuestion.get(i).getInquiry() %></p>
		</div>
		
</div>		

<%
}
}
%>

<br>
<div id="top" onclick="scrollMove()"
				style="cursor: pointer; width: fit-content; margin-left: auto; text-align: center;">
				<b>top</b>
	</div>
</div>	
<br>
<script type="text/javascript">
<!-- 문의사항 내용 script setting -->
var coll = document.getElementsByClassName("qna-title");
var i;

for (i = 0; i < coll.length; i++) {
  coll[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var content = this.nextElementSibling;
    if (content.style.maxHeight){
      content.style.maxHeight = null;
    } else {
      content.style.maxHeight = content.scrollHeight + "px";
    } 
  });
}
</script>
<div></div>
<footer style="position: absolute; bottom: 0; left: 0; right: 0;">
	<div style="background-color: #f1f1f1; padding: 40px;">
		<p style="text-align: center; color: rgb(116, 116, 116); font-family: 'Montserrat', sans-serif;">© Copyright 2019 KooKSan - All rights reserved.</p>
	</div>
	</footer>
</body>
</html>