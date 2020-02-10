<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="usedcar.shopping.CustomerDataBean"%>
<%@ page import="usedcar.shopping.CustomerDBBean"%>
<%@ page import="usedcar.shopping.DealerDBBean"%>
<%@ page import="usedcar.shopping.DealerDataBean"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.text.SimpleDateFormat"%>
<script src="../../js/function.js"></script>
<script>
	function chkModifyAuth(modifyAuthForm) {
         if(confirm("멤버타입을 수정하시겠습니까?")) {
            modifyAuthForm.action = "member.management/dealerAuthUpdatePro.jsp";
            modifyAuthForm.submit();
         } else {
            history.go(0);
         }
         
   }

</script>
<br>
<br>
<br>
<h2 align=center>회원 분류</h2>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	CustomerDataBean customerLists[] = null;
	DealerDataBean dealerLists[] = null;
	customerLists = new CustomerDataBean[3];
	dealerLists = new DealerDataBean[3];

	int number = 0;
	int dealernumber = 0;
	String membertypeName = "";

	CustomerDBBean customerProcess = CustomerDBBean.getInstance();
	DealerDBBean dealerProcess = DealerDBBean.getInstance();
	//회원분류 (membertype)는 일반회원,딜러회원으로 만든다.

	customerLists = customerProcess.getCustomerMemberdata("일반회원", 3);

	//책종류의 값을 문자로 변환한다.
	if (customerLists[0].getMembertype().equals("일반회원")) membertypeName = "일반회원";
	
%>
<br>
<table class="table table-bordered table-striped nanum table-hover">
	<tr class="info" height="30">
		<td width="550"><font size="+1"><b><%=membertypeName%>
					분류: <a
					href="member.management/customerList.jsp?membertype=<%=customerLists[0].getMembertype()%>">더보기</a>
			</b></font></td>
	</tr>
</table>

<%
	int memberCount = customerProcess.getCustomerMemberCount(customerLists[0].getMembertype());
	if (memberCount >= 3)
		memberCount = 3;

	//내부for문 : 책의 종류에 따라 최대 3건의 도서자료를 보여준다.
	for (int i = 0; i < memberCount; i++) {
%>
<table class="table table-bordered table-striped nanum table-hover">
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
	<tr height="50">
		<td width="20" align="center"><%=++number%></td>
		<td width="100" align="center"><%=customerLists[i].getUser_id()%></td>
		<td width="50" align="center" style="color: #EE5A24;"><font size="+1"><b> <%=customerLists[i].getName()%></b></font></td>
		<td width="80" align="center"><%=customerLists[i].getBirth()%></td>
		<td width="30" align="center"><%=customerLists[i].getGender()%></td>
		<td width="250" align="center"><%=customerLists[i].getAddress()%>
			<%=customerLists[i].getAddress1()%><%=customerLists[i].getAddress2()%><%=customerLists[i].getAddress3()%></td>
		<td width="60" align="center"><%=customerLists[i].getPhone()%></td>
		<td width="60" align="center"><%=customerLists[i].getTel()%></td>
		<td width="70" align="center"><%=customerLists[i].getEmail()%></td>
		<td width="50" align="center"><%=sdf.format(customerLists[i].getReg_date())%></td>
		<td width="50" align="center"><%=customerLists[i].getMembertype()%></td>
		
		<td width="30" align="center"><a
			href="member.management/deleteMemberPro.jsp?user_id=<%=customerLists[i].getUser_id()%>&membertype=<%=customerLists[i].getMembertype()%>">삭제</a></td>
	</tr>
</table>


<% 
	}
%>
<%
	dealerLists = dealerProcess.getDealerMemberdata("딜러회원", 3);
	if (dealerLists[0].getMembertype().equals("딜러회원")) membertypeName = "딜러회원";
%>
<br>
<table class="table table-bordered table-striped nanum table-hover">
	<tr class="info" height="30">
		<td width="550"><font size="+1"><b><%=membertypeName%>
					분류: <a
					href="member.management/dealerList.jsp?membertype=<%=dealerLists[0].getMembertype()%>">더보기</a>
			</b></font></td>
	</tr>
</table>
<%

	String Auth = "";
	int dealerCount = dealerProcess.getDealerMemberCount(dealerLists[0].getMembertype());
	if (dealerCount >= 3)
	dealerCount = 3;

	//내부for문 : 회원의 종류에 따라 최대 3건의 회원자료를 보여준다.
	for (int j = 0; j < dealerCount; j++) {
		if(dealerLists[j].getAuth()==1){
			Auth = "有";
		}else{
			Auth = "無";
		}
%>
<form action="" method="GET">	
<table class="table table-bordered table-striped nanum table-hover">
	<tr height="20" class="info">
		<th style="width:25px; text-align:center; height: 30px;">번 호</th>
		<th style="width:90px; text-align:center;">아이디</th>
		<th style="width:70px; text-align:center;">이 름</th>
		<th style="width:80px; text-align:center;">생년월일</th>
		<th style="width:50px; text-align:center;">성 별</th>
		<th style="width:200px; text-align:center;">주 소</th>
		<th style="width:80px; text-align:center;">집 전화번호</th>
		<th style="width:80px; text-align:center;">휴대전화번호</th>
		<th style="width:150px; text-align:center;">이메일</th>
		<th style="width:60px; text-align:center;">회원가입일</th>
		<th style="width:50px; text-align:center;">회원 구분</th>
		<th style="width:50px; text-align:center;">권한 여부</th>
		<th style="width:60px; text-align:center;">차량등록권한</th>
		<th style="width:50px; text-align:center;">수정</th>
		<th style="width:50px; text-align:center;">삭제</th>
	</tr>
	<tr height="50">
		<td width="20" align="center"><%=++dealernumber%></td>
		<td width="90" align="center"><%=dealerLists[j].getUser_id()%></td>
		<td width="50" align="center" style="color: #EE5A24;"><font size="+1"><b> <%=dealerLists[j].getName()%></b></font></td>
		<td width="80" align="center"><%=dealerLists[j].getBirth()%></td>
		<td width="30" align="center"><%=dealerLists[j].getGender()%></td>
		<td width="200" align="center"><%=dealerLists[j].getAddress()%>
			<%=dealerLists[j].getAddress1()%><%=dealerLists[j].getAddress2()%><%=dealerLists[j].getAddress3()%></td>
		<td width="60" align="center"><%=dealerLists[j].getPhone()%></td>
		<td width="60" align="center"><%=dealerLists[j].getTel()%></td>
		<td width="70" align="center"><%=dealerLists[j].getEmail()%></td>
		<td width="50" align="center"><%=sdf.format(dealerLists[j].getReg_date())%></td>
		<td style="width:50px; text-align:center;"><%=dealerLists[j].getMembertype()%>
			<input type="text" name="membertype" value="<%=dealerLists[j].getMembertype()%>" hidden></td>
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
			href="member.management/deleteMemberPro.jsp?user_id=<%=dealerLists[j].getUser_id()%>&membertype=<%=dealerLists[j].getMembertype()%>">삭제</a></td>		
	</tr>
</table>
</form>

<%
	}
%>

