
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

List<DealerDataBean> D_Lists = null;
DealerDataBean dealerList =null;
int number = 0;//회원의 분류에 따른 등록된 회원의 수
int member =0;


DealerDBBean dealerProcess = DealerDBBean.getInstance();
number = dealerProcess.getListCount();

%>	
	<title>딜러 회원 목록</title>
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
	<script>
		function scrollMove() {
		document.body.scrollTop = 0;
		document.documentElement.scrollTop = 0;
		}/* top으로 위로 올리게 한다.*/
		
		function chkModifyAuth(modifyAuthForm) {
	         if(confirm("차량등록 권한을 수정하시겠습니까?")) {
	            modifyAuthForm.action = "dealerAuthUpdatePro.jsp";
	            modifyAuthForm.submit();
	         } else {
	            history.go(0);
	         }
	         
	   }
		//검색 기능
		
		$(document).ready(function(){
 		 $("#myInput").on("keyup", function() {
  		  var value = $(this).val().toLowerCase();
  		  $("#dealerListTbody tr").filter(function() {
  		    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
   		 });
  		});
		});
	</script>

</head>
<body>


<div style="color: #FFF; height: 200px; background-image: url(../../img/topimg.jpg)">
<br>
<br>
<h2 style="text-align: center;">딜러 회원 관리</h2>
<br>
<br>
<a href="../managerMain.jsp" >&nbsp;&nbsp;&nbsp;&nbsp;관리자 메인으로</a>
<p>&nbsp;&nbsp;&nbsp;&nbsp;딜러 회원 목록 :<%=number %>명

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
	D_Lists = dealerProcess.getDealerMemberList();
%>
<div id="container" style="margin: 0 auto;">

<table id="user-table">
	<thead>
	<tr height="20" class="info">
		<th style="width:25px; text-align:center; height: 30px;">번 호</th>
		<th style="width:100px; text-align:center;">아이디</th>
		<th style="width:90px; text-align:center;">이 름</th>
		<th style="width:80px; text-align:center;">생년월일</th>
		<th style="width:50px; text-align:center;">성 별</th>
		<th style="width:190px; text-align:center;">주 소</th>
		<th style="width:80px; text-align:center;">집 전화번호</th>
		<th style="width:80px; text-align:center;">휴대전화번호</th>
		<th style="width:160px; text-align:center;">이메일</th>
		<th style="width:50px; text-align:center;">회원가입일</th>
		<th style="width:50px; text-align:center;">회원 구분</th>
		<th style="width:70px; text-align:center;">권한 여부</th>
		<th style="width:80px; text-align:center;">차량등록권한부여</th>
		<th style="width:50px; text-align:center;">수정</th>
		<th style="width:50px; text-align:center;">삭제</th>
	</tr>
	</thead>
</table>
	<%
		String Auth = "";
	for(int i = 0; i < D_Lists.size(); i++) {
		dealerList = (DealerDataBean)D_Lists.get(i);
		if(dealerList.getAuth()==1){
			Auth = "有";
		}else{
			Auth = "無";
		}
	%>
	
<!-- ## test -->
<form action="" method="GET">	
	
	
	<table id="data-table">
	<tbody id="dealerListTbody">
	<tr height="50" id="dealer_List">
		<td style="width:25px; text-align:center;"><%=++member %></td>
		
		<td style="width:100px; text-align:center;"><%=dealerList.getUser_id()%>
			<input type="text" name="user_id" value="<%=dealerList.getUser_id()%>" hidden></td>
			
		<td  style="width:100px; text-align:center; color: #EE5A24;"><font size="+1"><b><%=dealerList.getName()%></b></font></td>
		<td style="width:80px; text-align:center;"><%=dealerList.getBirth()%></td>
		<td  style="width:50px; text-align:center;"><%=dealerList.getGender()%></td>
		<td  style="width:200px; text-align:center;"><%=dealerList.getAddress()%>
			<%=dealerList.getAddress1()%><%=dealerList.getAddress2()%><%=dealerList.getAddress3()%></td>
		<td style="width:80px; text-align:center;"><%=dealerList.getPhone()%></td>
		<td style="width:80px; text-align:center;"><%=dealerList.getTel()%></td>
		<td  style="width:150px; text-align:center;"><%=dealerList.getEmail().trim()%></td>
		<td  style="width:60px; text-align:center;"><%=sdf.format(dealerList.getReg_date())%></td>
		<td style="width:50px; text-align:center;"><%=dealerList.getMembertype()%>
			<input type="text" name="membertype" value="<%=dealerList.getMembertype()%>" hidden></td>
		<td style="width: 60px; text-align: center;"><%=Auth %></td>
		<td  style="width:60px; text-align:center;">
			<select name="modify_auth" id="modify_auth">
                <option value="" hidden>딜러권한</option>
                <option value="0">권한 없음</option>
                <option value="1">권한 있음</option>    
            </select>
		</td>
		<td  style="width:50px; text-align:center;">
			<button type="button" onclick="javascript:chkModifyAuth(this.form)">수정</button>
		</td>
		<td  style="width:50px; text-align:center;"><a
			href="deleteMemberPro.jsp?user_id=<%=dealerList.getUser_id()%>&membertype=<%=dealerList.getMembertype()%>">삭제</a></td>		
	</tr>

	</tbody>
</table>


<!-- ## test ## -->
</form>


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
