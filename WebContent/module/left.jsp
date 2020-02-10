<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="usedcar.shopping.CustomerDataBean"%>
<%@page import="usedcar.shopping.CustomerDBBean"%>
<%@page import="usedcar.shopping.DealerDataBean"%>
<%@page import="usedcar.shopping.DealerDBBean"%>
<%
/* 김상헌  */
	request.setCharacterEncoding("utf-8");

	String id = (String) session.getAttribute("user_id");
	String membertype = (String)session.getAttribute("membertype");

%>
	<!-- 딜러 권한이 없을 시 차량 등록을 눌렀을 때 처리 -->
	<script>
		function haveNotAuth(){
			alert("권한이 필요합니다. (고객센터 문의)");
		}
		
		  // html dom 이 다 로딩된 후 실행된다.
	    $(document).ready(function(){
	        // menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
	        $(".car_QList>a").click(function(){
	            var submenu = $(this).next("ul");
	 
	            // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
	            if( submenu.is(":visible") ){
	                submenu.slideUp();
	            }else{
	                submenu.slideDown();
	            }
	        });
	    });
		
	</script>
	
<div id="leftSidenav" class="sidenav">
<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
<ul>
	<%
		if (membertype.equals("딜러회원")) {
	%>
	<li class="meminfo"><a
		href="http://localhost:8888/UsedCar10/shopping/logon/dealerUpdateForm.jsp">회원정보관리</a></li>
	<%
		} else {
	%>
	<li class="meminfo"><a href="http://localhost:8888/UsedCar10/shopping/logon/customerUpdateForm.jsp">회원정보관리</a></li>
	<%
		}
	%>
	
	<li><a href="http://localhost:8888/UsedCar10/jjim/jjimList.jsp">찜 목록보기</a></li>

	<%
		if (membertype.equals("딜러회원")) {
			int auth = (int)session.getAttribute("auth");
			if(auth == 1) {
	%>		
			<li><a href="http://localhost:8888/UsedCar10/shopping/car/insertcar.jsp">챠량 등록하기</a></li>
			<li><a href="http://localhost:8888/UsedCar10/shopping/logon/myCarList.jsp">등록한 차량 보기</a></li>
	<%
			} else {
	%>
			<li><a href="#"  onclick="haveNotAuth()">챠량 등록하기</a></li>
	<%
			} // end - if2
		} // end - if1
	%>
	
	
	
	<%
		if (membertype.equals("딜러회원")) {
	%>
	
	<li class="car_QList"><a>차량문의내역</a>
		<ul class="hide">
			<li><a href="http://localhost:8888/UsedCar10/shopping/questionListView/DealerquestionList.jsp">받은 문의 사항</a></li>
			<li><a href="#">보낸 답변</a></li>
		</ul>
	</li>
	<%
		} else {
	%>
	<li class="car_QList"><a>차량문의내역</a>
		<ul class="hide">
			<li><a href="http://localhost:8888/UsedCar10/shopping/questionListView/CustomerquestionList.jsp">보낸 문의 사항</a></li>
			<li><a href="#">받은 답변</a></li>
		</ul>
	</li>
	<%
		}
	%>

	<li><a href="http://localhost:8888/UsedCar10/shopping/logon/passwdChgform.jsp">비밀번호 변경</a></li>
	<li><a href="http://localhost:8888/UsedCar10/shopping/logon/deleteform.jsp">회원탈퇴</a></li>
</ul>
</div>
<span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776; open</span>
<script>
//사이드 메뉴바 넓이 설정
function openNav() {
	
	  document.getElementById("leftSidenav").style.width = "300px";
	}

	function closeNav() {
	  document.getElementById("leftSidenav").style.width = "0";
	}
</script>