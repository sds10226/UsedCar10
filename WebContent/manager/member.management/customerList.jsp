
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "usedcar.master.ManagerDBBean" %>
<%@ page import = "usedcar.shopping.CustomerDataBean" %>
<%@ page import = "usedcar.shopping.CustomerDBBean"%>
<%@ page import = "usedcar.shopping.DealerDataBean" %>
<%@ page import = "usedcar.shopping.DealerDBBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>


<%
String managerId = (String)session.getAttribute("managerid");

%>

<% 
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>



<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<script src="../../js/jquery-3.4.1.js"></script>
	<script src="../../bootstrap/js/bootstrap.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	
<%




List<CustomerDataBean> C_Lists = null;
CustomerDataBean customerList =null;
int number = 0;			//회원의 분류에 따른 등록된 회원의 수
int member =0;	//회원의 분류

CustomerDBBean customerProcess = CustomerDBBean.getInstance();
number = customerProcess.getListCount();

%>
	
	<title>일반 회원 목록</title>
	<style type="text/css">
		
		#container {width: 1880px; height:auto;}
        #container #input-form {text-align: center;}
        #user-table {margin: 0 auto; text-align: center; width: 100%;}
        #input-form {margin-top: 10px; margin-bottom: 10px;}

        #user-table {border-collapse: collapse;}
        #user-table > thead > tr { background-color: #333; color:#fff; }
        #user-table > thead > tr > th { padding: 0px; text-align: center; }
        #user-table > tbody > tr > td { border-bottom: 1px solid gray; padding:8px; }
        
        
        #data-table {margin: 0 auto; text-align: center; width: 1880px;}
        #data-table {border-collapse: collapse;}
        #data-table > thead > tr { background-color: #333; color:#fff;}
        #data-table > thead > tr > th { padding: 0px; width: 150px; text-align: center; }
        #data-table > tbody > tr > td { border-bottom: 1px solid gray; padding:8px;  }
	
	</style>
</head>
<script>
function scrollMove() {
	document.body.scrollTop = 0;
	document.documentElement.scrollTop = 0;
}/* top으로 위로 올리게 한다.*/

//검색 기능을 위한 Jquery활용
//검색 기능
		
		$(document).ready(function(){
 		 $("#myInput").on("keyup", function() {
  		  var value = $(this).val().toLowerCase();
  		  $("#customerlistTbody tr").filter(function() {
  		    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
   		 });
  		});
		});
</script>
<body>
<div style="color: #FFF; height: 200px; background-image: url(../../img/topimg.jpg)">
<br>
<br>
<h2 style="text-align: center;">일반 회원 관리</h2>
<br>
<br>
<a href="../managerMain.jsp" >&nbsp;&nbsp;&nbsp;&nbsp;관리자 메인으로</a>
<p>&nbsp;&nbsp;&nbsp;&nbsp;일반 회원 목록 : <%=number %>명

</p>
</div>

<table class="table">
	<tr>
		<td>
			<!-- 회원종류를 선택하는 메뉴 -->
			<div class="btn-group">
				<button type="button" class="btn btn-default dropdown-toggle" 
					data-toggle="dropdown" aria-expanded="false">회원 종류<span class="caret"></span></button>
					<ul class="dropdown-menu" role="menu">
						<li><a href="customerList.jsp?membertype=일반회원">일반 회원</a></li>
						<li><a href="dealerList.jsp?membertype=딜러회원">딜러 회원</a></li>
					</ul> 
					</div>
			<div style="text-align: center; color:#EE5A24; font-size: 20px;"><b>검색 : </b><input id="myInput" type="text" placeholder="Search.."></div>
		
		</td>
	</tr>
</table>

<% //데이터가 한명도 없으면
if(number <= 0) {
%>
<table class="table table-bordered table-striped nanum table-hover">
	<tr>
		<td align="center">등록된 회원이 없습니다.</td>
	</tr>
</table>

<%} else{
	C_Lists = customerProcess.getCustomerMemberList();
%>
<div id="container" style="margin: 0 auto;">
<table id="user-table">
	<thead>
	<tr height="20" class="info">
		<th  style="width:25px; text-align:center; height: 30px;">번 호</th>
		<th style="width:100px; text-align:center;">아이디</th>
		<th style="width:50px; text-align:center;">이 름</th>
		<th style="width:80px; text-align:center;">생년월일</th>
		<th style="width:50px; text-align:center;">성 별</th>
		<th style="width:200px; text-align:center;">주 소</th>
		<th style="width:80px; text-align:center;">집 전화번호</th>
		<th style="width:80px; text-align:center;">휴대전화번호</th>
		<th style="width:150px; text-align:center;">이메일</th>
		<th style="width:60px; text-align:center;">회원가입일</th>
		<th style="width:50px; text-align:center;">회원 구분</th>
		<th style="width:50px; text-align:center;">삭제</th>
	</tr>
	</thead>
</table>
	
	<%
	for(int i = 0; i < C_Lists.size(); i++) {
		customerList =(CustomerDataBean)C_Lists.get(i);
	%>
	<table id="data-table">
	<tbody id="customerlistTbody">
	<tr height="50">
		<td style="width:25px; text-align:center;"><%=++member%></td>
		<td style="width:100px; text-align:center;"><%=customerList.getUser_id()%>
		<input type="text" name="user_id" value="<%=customerList.getUser_id()%>" hidden></td>
		<td  style="width:50px; text-align:center; color: #EE5A24;"><font size="+1"><b><%=customerList.getName()%></b></font></td>
		<td style="width:80px; text-align:center;"><%=customerList.getBirth()%></td>
		<td  style="width:50px; text-align:center;"><%=customerList.getGender()%></td>
		<td  style="width:200px; text-align:center;"><%=customerList.getAddress()%>
			<%=customerList.getAddress1()%><%=customerList.getAddress2()%><%=customerList.getAddress3()%></td>
		<td style="width:80px; text-align:center;"><%=customerList.getPhone()%></td>
		<td style="width:80px; text-align:center;"><%=customerList.getTel()%></td>
		<td  style="width:150px; text-align:center;"><%=customerList.getEmail().trim()%></td>
		<td  style="width:60px; text-align:center;"><%=sdf.format(customerList.getReg_date())%></td>
		<td style="width:50px; text-align:center;"><%=customerList.getMembertype()%></td>
		<td  style="width:50px; text-align:center;"><a
			href="deleteMemberPro.jsp?user_id=<%=customerList.getUser_id()%>&membertype=<%=customerList.getMembertype()%>">삭제</a></td>
	</tr>
	</tbody>
</table>
</div>
	
<%}%>
<%}%>
<br>
<a href="../managerMain.jsp">&nbsp;&nbsp;&nbsp;&nbsp;관리자 메인으로</a>
</body>
<div id="top" onclick="scrollMove()"
				style="cursor: pointer; width: fit-content; margin: auto; text-align: right;">
				<b>top</b>
	</div>
</html>
