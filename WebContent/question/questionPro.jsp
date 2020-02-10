<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import = "usedcar.question.CustomerQuestionDBBean" %>

<jsp:useBean id="question" scope="page" class="usedcar.question.MemberQuestionDataBean"></jsp:useBean>
<!-- 강한결 -->
<%
request.setCharacterEncoding("utf-8");

int car_idx = Integer.parseInt(request.getParameter("car_idx"));
String user_id = (String)session.getAttribute("user_id");
int car_own = Integer.parseInt(request.getParameter("car_own"));
String inquiry = request.getParameter("inquiry");
String dealer_id = request.getParameter("dealer_id");

question.setCar_idx(car_idx);
question.setUser_id(user_id);
question.setCar_own(car_own);
question.setInquiry(inquiry);
question.setDealer_id(dealer_id);
question.setReg_date(new Timestamp(System.currentTimeMillis()));


CustomerQuestionDBBean questionProcess = CustomerQuestionDBBean.getInstance();
questionProcess.insertQuestion(question);
%>

<script>
	alert("문의완료! 마이페이지를 확인하세요.");
	location.href = document.referrer;
</script>