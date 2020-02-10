<%@page import="usedcar.shopping.DealerDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

--------------------------------------------------------------
[메인화면 검색 form 테스트입니다.]

<p>선택한 회사 : <%=request.getParameter("car_brand") %></p>
<p>모델 : <%=request.getParameter("car_model") %></p>
<p>세부모델 : <%=request.getParameter("car_oilType") %></p>

--------------------------------------------------------------
[로그인 입력 form 테스트입니다.]

<p>ID : <%=request.getParameter("id") %></p>
<p>PW : <%=request.getParameter("passwd") %></p>

--------------------------------------------------------------
<br>
[딜러 회원가입 입력 form 테스트입니다.]

이름 : <%=request.getParameter("name") %> <br>
<br>
생년 : <%=request.getParameter("bYear") %><br>
월 : <%=request.getParameter("bMonth") %><br>
일 : <%=request.getParameter("bDay") %><br>
<br>
성별 : <%=request.getParameter("gender") %><br>
<br>
아이디 : <%=request.getParameter("user_id") %><br>
비밀번호 : <%=request.getParameter("passwd") %><br>
비밀번호확인 : <%=request.getParameter("chkpasswd") %><br>
비밀번호찾기 힌트 : <%=request.getParameter("passhint") %><br>
비밀번호찾기 힌트 : <%=request.getParameter("passans") %><br>
<br>
우편번호 : <%=request.getParameter("dealer_postcode") %><br>
주소 : <%=request.getParameter("dealer_address") %><br>
상세주소 : <%=request.getParameter("dealer_detailAddress") %><br>
추가주소 : <%=request.getParameter("dealer_extraAddress") %><br>
<br>
회사 우편번호 : <%=request.getParameter("company_postcode") %><br>
회사 주소 : <%=request.getParameter("company_address") %><br>
회사 상세주소 : <%=request.getParameter("company_detailAddress") %><br>
회사 추가주소 : <%=request.getParameter("company_extraAddress") %><br>
<br>
전화번호1 : <%=request.getParameter("phone1") %><br>
전화번호2 : <%=request.getParameter("phone2") %><br>
전화번호3 : <%=request.getParameter("phone3") %><br>

핸드폰번호1 : <%=request.getParameter("tel1") %><br>
핸드폰번호2 : <%=request.getParameter("tel2") %><br>
핸드폰번호3 : <%=request.getParameter("tel3") %><br>
<br>
이메일1 : <%=request.getParameter("email1") %><br>
이메일2 : <%=request.getParameter("email2") %><br>
<br>
--------------------------------------------------------------
<br />
[고객 회원가입 입력 form 테스트입니다.]

이름 : <%=request.getParameter("customer_name") %> <br>
<br>
생년 : <%=request.getParameter("customer_bYear") %><br>
월 : <%=request.getParameter("customer_bMonth") %><br>
일 : <%=request.getParameter("customer_bDay") %><br>
<br>
성별 : <%=request.getParameter("customer_gender") %><br>
<br>
아이디 : <%=request.getParameter("customer_user_id") %><br>
비밀번호 : <%=request.getParameter("customer_passwd") %><br>
비밀번호확인 : <%=request.getParameter("customer_chkpasswd") %><br>
비밀번호찾기 힌트 : <%=request.getParameter("customer_passhint") %><br>
비밀번호찾기 힌트 답 : <%=request.getParameter("customer_passans") %><br>
<br>
우편번호 : <%=request.getParameter("customer_postcode") %><br>
주소 : <%=request.getParameter("customer_address") %><br>
상세주소 : <%=request.getParameter("customer_detailAddress") %><br>
추가주소 : <%=request.getParameter("customer_extraAddress") %><br>
<br>
전화번호1 : <%=request.getParameter("customer_phone1") %><br>
전화번호2 : <%=request.getParameter("customer_phone2") %><br>
전화번호3 : <%=request.getParameter("customer_phone3") %><br>
<br>
핸드폰번호1 : <%=request.getParameter("customer_tel1") %><br>
핸드폰번호2 : <%=request.getParameter("customer_tel2") %><br>
핸드폰번호3 : <%=request.getParameter("customer_tel3") %><br>
<br>
이메일1 : <%=request.getParameter("customer_email1") %><br>
이메일2 : <%=request.getParameter("customer_email2") %><br>
<br>
--------------------------------------------------------------
<br />
<a href="ShopMain.jsp">홈으로</a>
<br />
<br />

</body>
</html>