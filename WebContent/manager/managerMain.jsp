<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
	String managerId = "";
	try {
		managerId = (String) session.getAttribute("managerid");

		//세션값이 없으면 로그인화면으로 이동시킨다.
		if (managerId == null || managerId.equals("")) {
			response.sendRedirect("manager.logon/managerLoginForm.jsp?useSSL=false");
		} else {
%>
<html>
<head>
<meta charset="UTF-8">
<link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="../js/jquery-3.4.1.js"></script>
<script src="../bootstrap/js/bootstrap.min.js"></script>
<title>KOOKSAN자동차 매매 관리자 페이지</title>
<style>
body {
	position: relative;
}

.affix {
	top: 0;
	width: 100%;
	z-index: 9999 important;
}

.navbar {
	margin-bottom: 0px;
}

.affix ~ .container-fluid {
	position: relative;
	top: 50px;
}
</style>

<script>

function printClock() {
    
    var clock = document.getElementById("clock");            // 출력할 장소 선택
    var currentDate = new Date();                                     // 현재시간
    var calendar = currentDate.getFullYear() + "-" + (currentDate.getMonth()+1) + "-" + currentDate.getDate() // 현재 날짜
    var amPm = 'AM'; // 초기값 AM
    var currentHours = addZeros(currentDate.getHours(),2); 
    var currentMinute = addZeros(currentDate.getMinutes() ,2);
    var currentSeconds =  addZeros(currentDate.getSeconds(),2);
    
    if(currentHours >= 12){ // 시간이 12보다 클 때 PM으로 세팅, 12를 빼줌
    	amPm = 'PM';
    	currentHours = addZeros(currentHours - 12,2);
    }

    if(currentSeconds >= 50){// 50초 이상일 때 색을 변환해 준다.
       currentSeconds = '<span style="color:black;">'+currentSeconds+'</span>'
    }
    clock.innerHTML = currentHours+":"+currentMinute+":"+currentSeconds +" <span style='font-size:25px;'>"+ amPm+"</span>"; //날짜를 출력해 줌
    
    setTimeout("printClock()",1000);         // 1초마다 printClock() 함수 호출
}

function addZeros(num, digit) { // 자릿수 맞춰주기
	  var zero = '';
	  num = num.toString();
	  if (num.length < digit) {
	    for (i = 0; i < digit - num.length; i++) {
	      zero += '0';
	    }
	  }
	  return zero + num;
}
//페이지 설정 AJAX--------------------------------------------------------------------------------

function loadDoc() {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      document.getElementById("customerList").innerHTML =
      this.responseText;
    }
  };
  xhttp.open("GET", "customerList.jsp", true);
  xhttp.send();
}


</script>
</head>
<body data-spy="scroll" data-target=".navbar" data-offset="50" onload="printClock()">

	<div class="container-fluid"
		style="color: #FFF; height: 200px; background-image: url(../img/topimg.jpg)">
		<br>
		<br>
		<h1 style="text-align: center;">KOOKSAN 관리자 페이지</h1>
		<div style=" width:200px; height:50px; line-height:50px; color:white-space; font-size:25px; float: right;" id="clock"></div>
		
	</div>
	

	<nav class="navbar navbar-inverse" data-spy="affix"
		data-offset-top="197">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">KOOKSAN</a>
			</div>
			<div>
				<div class="collapse navbar-collapse" id="myNavbar">
					<ul class="nav navbar-nav">
						<li class="dropdown"><a class="dropdown-toggle"
							data-toggle="dropdown" href=#> 차량등록관리 <span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="total.usedcarList/allCarList.jsp">등록 차량 관리(검색/수정/삭제)</a></li>
							</ul></li>
						<li class="dropdown"><a class="dropdown-toggle"
							data-toggle="dropdown" href="#"> 회원관리 <span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="member.management/customerList.jsp">일반 회원 관리(검색/삭제)</a></li>
								<li><a href="member.management/dealerList.jsp">딜러 회원 관리(검색/수정/삭제)</a></li>
							</ul></li>
						<li class="dropdown"><a class="dropdown-toggle"
							data-toggle="dropdown" href="#"> 판매분석리스트 <span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="#">딜러별 차량판매 지표</a></li>
							</ul></li>
						<li class="dropdown"><a class="dropdown-toggle"
							data-toggle="dropdown" href="#"> 딜러권한 문의내역<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="#">받은 문의사항</a></li>
								<li><a href="#">보낸 문의사항</a></li>
							</ul></li>
							
						<li><a href="manager.logon/managerLogout.jsp">로그아웃</a></li>

					</ul>

				</div>
			</div>


		</div>


	</nav>
	<div>
		<form>
			<table style="border:1px solid black;">
				<tr>
					<td></td>
				</tr>
			</table>
		
		</form>
	
	</div>
			<div>
				<jsp:include page="member.management/introList.jsp" flush="false"/>
			</div>
			<div id="customerList" onload="loadDoc()">
			</div>



</body>
</html>
<%
	} // End - else
	} catch (Exception e) {
		e.printStackTrace();
	}
%>

