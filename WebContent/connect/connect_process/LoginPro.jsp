<%@page import="usedcar.shopping.DealerDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="usedcar.shopping.CustomerDBBean"%>


<%
   	request.setCharacterEncoding("utf-8");
   	
   	// 로그인 검사를 하는데 필요한 자료를 가져온다.
   	String id = request.getParameter("id");
   	String passwd = request.getParameter("passwd");

   	// 사용할 dao 객체 생성
   	CustomerDBBean customerProcess = CustomerDBBean.getInstance();
   	DealerDBBean dealerProcess = DealerDBBean.getInstance();
   	
   	int checkCustomer = customerProcess.userCheck(id, passwd);
   	int checkDealer = dealerProcess.userCheck(id, passwd);
   	
   	// 멤버타입에 사용할 변수
   	String membertype = "";
   	
   	// 인증된 결과에 대해서 처리를 한다.
   	if (checkCustomer == 1 || checkDealer == 1) {
   		// 회원아이디가 존재하고 비밀번호가 맞으면 세션을 발급한다.
   		session.setAttribute("user_id", id);
   		
   		// 로그인 한 id의 membertype 가져오기
   	   	String cMembertype = customerProcess.checkMembertype(id).trim();
   	   	String dMembertype = dealerProcess.checkMembertype(id).trim();
   	 	
   	   	// membertype 분기시키기
   	   	if(cMembertype == null || cMembertype == "") {
   	   		membertype = dMembertype;
   	   		int auth = dealerProcess.getAuth(id);
   	   		// 딜러로 로그인 했으면 auth값을 받아와서 세션을 발급한다.
   	   		session.setAttribute("auth", auth);
   	   	} else {
   	   		membertype = cMembertype;
   	   	}
   	   	
   	   	// 분기된 membertype에 세션 발급
   	   	session.setAttribute("membertype", membertype);
   	   	
%>
	<script>
		alert("로그인 되었습니다.");
		// 로그인 팝업창 닫고 부모창 새로고침
		window.opener.location.reload();
		// 로그인 팝업창 닫기
	    window.close();
    </script>
<%
	} else if(checkCustomer == 0 || checkDealer == 0) {
		// 회원아이디는 존재하나 비밀번호가 틀린 경우
%>
	<script>
		alert("비밀번호가 맞지 않습니다.\n비밀번호를 확인하신 후 다시 시도하십시오.");
		location.href="../Login.html";
	</script>
<%
	} else {
		// 회원아이디 자체가 존재하지 않는 경우
%>
	<script>
		alert("아이디가 맞지 않습니다.\n아이디를 확인하신 후 다시 시도하십시오.");
		location.href="../Login.html";
	</script>
<%
	}
%>