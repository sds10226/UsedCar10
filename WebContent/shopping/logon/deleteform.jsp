<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="usedcar.shopping.CustomerDBBean"%>
<%@page import="usedcar.shopping.DealerDBBean"%>
<%@page import="usedcar.shopping.DealerDataBean"%>


<script src="../../js/function.js"></script>
<link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="../../stylesheet/top.css">
<link rel="stylesheet" type="text/css" href="../../css/left.css">


<style>
	* {
		font-family: 'Montserrat', sans-serif;
	}
	
	.deleteform{
		height: auto;
		margin-left: 0 auto;
		margin-right: 0 auto;
	}
	
	#repasswd{
		width: 300px;
		height: 40px;
		font-size: 16px;
		padding-left: 10px;
		
		border: 1px solid lightgray;
		box-shadow: inset 0px 0px 1px 1px lightgray;
	}
	
	#repasswd::placeholder{
		color: lightgray;
	}
   /* 검색 버튼 */
    .submit_btn {
        background-color: white;
        border: 1px solid black;
        border-radius: 5px;
        width: 100px;
        height: 40px;
        font-size: 105%;
        cursor: pointer;

        transition: .2s linear;
    }
    .submit_btn:hover {
        border: 1px solid black;
        background-color: black;
        color: white;
    }

</style>
<%	

		DealerDBBean dealerProcess = DealerDBBean.getInstance();
		CustomerDBBean customerProcess = CustomerDBBean.getInstance();

	/*
		session.setAttribute("user_id", "KimTest");
		session.setAttribute("membertype", "딜러회원");
		*/
		
		String membertype = (String)session.getAttribute("membertype");
		
		String passwd = "";
		
		
	if (session.getAttribute("user_id") == null) {
		response.sendRedirect("../../ShopMain.jsp");
	} else {
		String user = (String) session.getAttribute("user_id");
		
		if(membertype.equals("일반회원")) {
			passwd = customerProcess.customerCheckPassword(user);
		} else{
			passwd = dealerProcess.dealerCheckPassword(user);
		}
		
%>

	<body>
	<header id="header"> 
	<jsp:include page="../../module/top.jsp" flush="false" /> </header>

	<div id="nav-sidebar">
		<jsp:include page="../../module/left.jsp" flush="false" />
	</div>
	<div style="margin-left: auto; margin-right: auto; text-align:center; width: 500px;">
		<br />
		<br />
		<!-- focus()는 커서로써, 처음 시작할 때 password이름을 가진 text에 커서가 위치해있다. -->
		<b><font size="6" color="gray">회원 탈퇴 화면입니다</font></b>
		<br />
		<br />
		<br />
		<br />
	
		<form name="deleteform" action="" method="post" id="deleteform">

			<table style="border-top: 2px solid gray; border-bottom: 3px double gray; padding: 20px;">
				<tr>
					<td><input type="hidden" name="user_id" value="<%=user%>">
					</td>

					<td style=" width: 8em; text-align: center;"><font size="4" color="#EE5A24"><b>현재 비밀번호</b></font></td>
					
					<td>
						&nbsp;&nbsp;<input type="password" id="repasswd" class="repasswd" name="repasswd" maxlength="12" value="" placeholder="비밀번호를 입력해주세요.">
						<input type="hidden" id="passwd" name="passwd" maxlength="12" value="<%=passwd %>">
						</td>
				</tr>
			</table>
			<br />

			<button type="button" class="submit_btn" value="회원탈퇴" onclick=updelCheckForm(this.form)>회원탈퇴</button>
			<script>
			</script>
		</form>
		
		
		<div style="height: 500px;"></div>
		</div>
	<footer>
	<div style="background-color: #f1f1f1; padding: 40px;">
		<p style="text-align: center; color: rgb(116, 116, 116); font-family: 'Montserrat', sans-serif;">© Copyright 2019 KooKSan - All rights reserved.</p>
	</div>
	</footer>
	</body>
	

<%
	}
%>
