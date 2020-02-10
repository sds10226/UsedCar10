<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- 강한결  -->
	<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'montserrat', sans-serif;
    }
	</style>
<%
	request.setCharacterEncoding("utf-8");

try {
	if(session.getAttribute("user_id") == null) {
%>

<body>
    <div id="header-top">
    	<div id="header-container">
	        <!-- float: left; -->
	        <div class="header-left-menu">
	            <span><a href="http://localhost:8888/UsedCar10/ShopMain.jsp" style="line-height: 70px;">KOOK SAN</a></span>
	            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	            <a href="http://localhost:8888/UsedCar10/list/searchmenu.jsp">국산</a>
	            <a href="#">시세</a>
	            <a href="http://localhost:8888/UsedCar10/module/QnA.html">QnA</a>
	            <a href="http://localhost:8888/UsedCar10/shopping/introduction.jsp">회사소개</a>
	        </div>
	
	        <div class="header-right-menu" style="color: white;">
	            <!-- float: right; -->
	            
	            <!-- 로그인 누르면  -->
	            <a href="#" onclick="window.open('http://localhost:8888/UsedCar10/connect/Login.html', '로그인','width=600, height=800'); return false">로그인</a>
	            <a href="sign_up/signup-select.html">회원가입</a>
	 
	        </div>
        </div>
    </div>

</body>

<% } else { 
	String mType = (String)session.getAttribute("membertype");
	String membertype = mType.substring(0, 2);

%>
<body>
	<div id="header-top">
		<div id="header-container">
			<!-- float: left; -->
			<div class="header-left-menu">
				<span><a href="http://localhost:8888/UsedCar10/ShopMain.jsp" style="line-height: 70px;">KOOK SAN</a></span> 
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				<a href="http://localhost:8888/UsedCar10/list/searchmenu.jsp">국산</a> 
				<a href="#">시세</a> 
				<a href="http://localhost:8888/UsedCar10/module/QnA.html">QnA</a>
             	<a href="http://localhost:8888/UsedCar10/shopping/introduction.jsp">회사소개</a>
			</div>

			<div class="header-right-menu" style="color: white;">
				<!-- float: right; -->

<%
	String href = "";
	if(membertype.equals("일반")) {
		href = "http://localhost:8888/UsedCar10/shopping/logon/customerUpdateForm.jsp";
	}else{
		href = "http://localhost:8888/UsedCar10/shopping/logon/dealerUpdateForm.jsp";
	}
%>


				<span class="welcome-font-set" style="color: white; line-height: 70px"> <%=session.getAttribute("user_id") %>님[<%=membertype %>], 
					환영합니다. &nbsp;&nbsp;&nbsp;<a href="<%=href%>">마이페이지</a>│ <a href="http://localhost:8888/UsedCar10/connect/connect_process/LogoutPro.jsp">로그아웃</a>
				</span>

			</div>
		</div>
	</div>

</body>




<% } // end if ~ else
} catch(NullPointerException e) {
	e.printStackTrace();
} catch(Exception e) {
	e.printStackTrace();
} // end try ~ catch
%>

