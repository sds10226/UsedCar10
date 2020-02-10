<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	

<style>
	.homebtn {
		text-decoration: none;	
		color: white;
		transition: .2s;
	}
	.homebtn:LINK {
		text-decoration: none;
		color: white;
	}
	.homebtn:VISITED {
		text-decoration: none;
		color: white;
	}
	.homebtn:hover {
		color: rgb(236, 180, 159);
	}
</style>	
	
	
<div class="navbar">
	<div class="navbar-container">
		<div class="navbar-left-menu">
			<span class="navbar-title"><a href="http://localhost:8888/UsedCar10/ShopMain.jsp" class="homebtn">KOOK SAN</a></span> 			
			<span class="navbar-nav" onclick="scrollDownTo('basic-info')">기본정보</span>
			<span class="navbar-nav" onclick="scrollDownTo('option-info')">옵션</span>
			<span class="navbar-nav" onclick="scrollDownTo('desc-info')">판매자 설명</span>
         	<span class="navbar-nav" onclick="scrollDownTo('buy-info')">구매 가이드</span>
         	
			<span class="navbar-nav2" onclick="scrollDownTo('basic-info')">기본정보</span>
			<span class="navbar-nav2" onclick="scrollDownTo('option-info')">옵션</span>
			<span class="navbar-nav2" onclick="scrollDownTo('desc-info')">판매자 설명</span>
         	<span class="navbar-nav2" onclick="scrollDownTo('buy-info')">구매 가이드</span>
		</div>
		<div class="navbar-right-menu">	
<%
try {
	if(session.getAttribute("user_id") == null) {
%>
			<a href="#" onclick="window.open('../connect/Login.html', '로그인','width=600, height=800'); return false">로그인</a>
			<a href="../sign_up/signup-select.html">회원가입</a>

<% } else { 
		/* 마이페이지 클릭시 :: 딜러회원일때는 본인이 등록한 차량 리스트로 넘어가고, 일반회원일때는 기존 마이페이지로 넘어가도록 처리 */
		if(session.getAttribute("membertype").equals("딜러회원")) {
%>
			<a href="http://localhost:8888/UsedCar10/shopping/logon/myCarList.jsp">마이페이지</a>
			<a href="../connect/connect_process/LogoutPro.jsp">로그아웃</a>
<% 
		} else {
%>
			<a href="http://localhost:8888/UsedCar10/shopping/logon/customerUpdateForm.jsp">마이페이지</a>
			<a href="../connect/connect_process/LogoutPro.jsp">로그아웃</a>
<%
		}
	}
} catch(NullPointerException e) {
	e.printStackTrace();
} catch(Exception e) {
	e.printStackTrace();
}
%>
		</div>
    </div>
</div>

