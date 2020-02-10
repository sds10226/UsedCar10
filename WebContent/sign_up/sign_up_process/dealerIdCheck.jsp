<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="usedcar.shopping.CustomerDBBean"%>
<%@page import="usedcar.shopping.DealerDBBean"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	request.setCharacterEncoding("utf-8");

	String user_id = request.getParameter("id");
	
	int customer_rtnVal = 0;
	int dealer_rtnVal = 0;
	
	CustomerDBBean customerProcess = CustomerDBBean.getInstance();
	DealerDBBean dealerProcess = DealerDBBean.getInstance();
	
	customer_rtnVal = customerProcess.confirmCustomerId(user_id);
	dealer_rtnVal = dealerProcess.confirmDealerId(user_id);
	
	if(customer_rtnVal == -1 && dealer_rtnVal == -1) {
		out.println("<center><h2>사용할 수 있는 아이디입니다.</h2></center>");
		%>
		<script>
		opener.document.dealerInsForm.checkedOrNot.value = "1";
		</script>
		<%
	} else {
		out.println("<center><h2>이미 사용중인 아이디입니다.</h2></center>");
		%>
		<script>
		opener.document.dealerInsForm.user_id.value = "";
		opener.document.dealerInsForm.checkedOrNot.value = "0";
		</script>
		<%
	}
%>

<link href="https://fonts.googleapis.com/css?family=Single+Day&display=swap" rel="stylesheet">

<style>
	* {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
		font-family: 'Single Day', cursive;
	}
	.checkIdForm {
		border: 4px solid #EE5A24;
		width: 400px;
		height: 150px;
		
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
	}
	.checkIdBtn {
		margin-top: 85px;
		cursor: pointer;
		border: 1px solid black;
		border-radius: 5px;
		background-color: white;
		width: 90px;
		height: 40px;
		font-size: 105%;
		color: rgb(116, 116, 116);
		
		transition: 0.2s linear;
	}
	.checkIdBtn:hover {
		background-color: #EE5A24;
		border: 1px solid #EE5A24;
		color: white;
	}
	h2 {
		margin-top: 45px;
		color: rgb(116, 116, 116);
	}
</style>

<center class="checkIdForm">
	<input class="checkIdBtn" type="button" value="확 인" onclick="javascript:self.close()"/>
</center>