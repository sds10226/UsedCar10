<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="usedcar.shopping.DealerDBBean"%>
<%@page import="usedcar.shopping.DealerDataBean"%>
<%@ page import="usedcar.shopping.CustomerDBBean"%>
<%@ page import="usedcar.shopping.CustomerDataBean"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">

<link rel="stylesheet" type="text/css" href="../../stylesheet/footer.css">
<link rel="stylesheet" type="text/css" href="../../stylesheet/top.css">
<link rel="stylesheet" type="text/css" href="../../css/left.css">

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="../../js/function.js"></script>

<%	

		DealerDBBean dealerProcess = DealerDBBean.getInstance();
		CustomerDBBean customerProcess = CustomerDBBean.getInstance();
		
		
		String membertype = (String)session.getAttribute("membertype");
		
		String customer_passwd = "";
		String dealer_passwd = "";
		String passwd = "";
		
		
	if (session.getAttribute("user_id") == null) {
		response.sendRedirect("../../ShopMain.jsp");
	} else {
		String user = (String) session.getAttribute("user_id");
		
		if(membertype.equals("일반회원")) {
			customer_passwd = customerProcess.customerCheckPassword(user);
			passwd = customer_passwd;
		} else{
			dealer_passwd = dealerProcess.dealerCheckPassword(user);
			passwd = dealer_passwd;
		}
		
%>

<style type="text/css">
.container {
	padding-top: 100px;
	text-align: center;
}

table {
	border-collapse: collapse;
	width: 800px;
	height: 300px;
	text-align: center;
}

table, td {
	border: 1px solid #ddd;
}

.footer-btn {
    border: 1px solid rgb(80, 80, 80);
    border-radius: 5px;
    background-color: white;
    width: 110px;
    height: 40px;
    font-size: 15px;
    font-weight: 100;

    transition: .2s linear;
}
.footer-btn:hover {
    color: white;
    border: 1px solid #EE5A24;
    background-color: #EE5A24;
}
</style>

</head>
<title>회원 비밀번호 변경</title>
<body>
	<header id="header"> 
	<jsp:include page="../../module/top.jsp" flush="false" /> </header>

	<div id="nav-sidebar">
		<jsp:include page="../../module/left.jsp" flush="false" />
	</div>
	
	<center>
	<div class="container">
		<h1>비밀번호를 변경해주세요.</h1>
		<br> <br> <br>
		<form id="passwdChg" name="passwdChg" method="POST" action="passwdChgPro.jsp">
			<table class="table" border="1" cellspacing="2" cellpadding="2"
				style="margin-left: auto; margin-right: auto; resize: none;" >

				<tr style="border-right-color: white;">
					<td colspan="2"><br>
						<p>
							비밀번호는 문자, 숫자, 특수문자를 조합하여 <br>최소 8자 이상 12자 이내로 입력하십시요.
						</p> <br></td>
				</tr>
				
				<tr>
					<td class="cpw"><em>*</em>현재 비밀번호
					</td>
					<td><input id="ownpasswd" name="ownpasswd" class="ownpasswd" type="password" style="width: 300px;"
						 value="" maxlength="12">
						<input id="chkpasswd" class="chkpasswd" type="hidden" style="width: 300px;"
						name="chkpasswd" value="<%=passwd %>"></td>
				</tr>

				<tr>
					<td class="rpw1"><em>*</em>새 비밀번호
					</td>
					<td><input id="newpasswd" name="newpasswd" class="newpasswd" type="password" style="width: 300px;"
						name="repassword1" value="" maxlength="12"></td>
				</tr>
				
				<tr>
					<td class="rpw2"><em>*</em>비밀번호 확인
					</td>
					<td><input id="renewpasswd" name="renewpasswd" class="renewpasswd" type="password" style="width: 300px;"
						name="repassword2" value="" maxlength="12"></td>
				</tr>

			</table>

		</form>
		
		<p style="height: 15px;">
		<div class="part pwupdate" style="text-align: center;">
			<button class="footer-btn" type="button" title="저장" value=""
				onclick="changepasswdCheckForm(document.passwdChg)" style="cursor: pointer;">비밀번호 변경</button>
		</div>
	<script type="text/javascript">
		console.dir(document.passwdChg);
	</script>		

	</div>
	</center>
	<br />
	<br />
	<hr />
	<div id="footer">
		<jsp:include page="../../module/footer.html" flush="false" />
	</div>

</body>
</html>
<%
	}
%>
