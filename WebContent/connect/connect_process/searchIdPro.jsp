<%@page import="usedcar.shopping.DealerDBBean"%>
<%@page import="usedcar.shopping.CustomerDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	/* searchId.jsp에서 받은 값 정리 */
	String email = request.getParameter("email").trim();
	String tel = request.getParameter("tel").trim();
	
	/* dto 인스턴스 생성 */
	CustomerDBBean customerProcess = CustomerDBBean.getInstance();
	DealerDBBean dealerProcess = DealerDBBean.getInstance();
	
	/* dao에 있는 method를 거쳐서 id값 받아오기 */	
	String customerId = customerProcess.searchCustomerId(tel, email);
	String dealerId = dealerProcess.seachDealerId(tel, email);
	
	String resId = "";
	/* request.setAttribute("customerId", customerId);
	request.setAttribute("dealerId", dealerId); */

	if(customerId.equals("해당 조건에 맞는 ID가 없습니다.") || customerId == "해당 조건에 맞는 ID가 없습니다.") {
		resId = dealerId;
	} else {
		resId = customerId;
	}
%>

<% if(resId == "해당 조건에 맞는 ID가 없습니다." || resId.equals("해당 조건에 맞는 ID가 없습니다.") ) { %>
<%=resId %>
<% } else { %>
<%=resId %>
<% } %>
