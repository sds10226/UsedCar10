<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="usedcar.shopping.CustomerDBBean"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import="java.sql.Timestamp"%>
<%
	request.setCharacterEncoding("utf-8");


String	realFolder 	= "";	//웹 어플리케이션 상의 절대 경로
String	filename	= "";
MultipartRequest multirequest = null;

String	saveFolder	= "/images"; //파일이 업로드되는 폴더를 지정한다.
String	encType		= "utf-8";		//인코딩 타입
int		maxSize		= 8*1024*1024;	//최대 업로될 파일의 크기 8MB

//현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구한다.
ServletContext	context	= getServletContext();
realFolder	= context.getRealPath(saveFolder);

System.out.println("realFolder : " + realFolder);

try {
	//전송을 담당할 컴포넌트를 생성하고 파일을 전송한다.
	//전송할 파일명을 가지고 있는 객체, 서버상의 절대경로, 최대 업로드될 파일크기,
	//문자코드, 기본 보안 적용
	multirequest = new MultipartRequest(
				request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	//전송한 파일 정보를 가져와 출력한다.
	Enumeration<?>	files = multirequest.getFileNames();
	
	//파일 정보가 있다면
	while(files.hasMoreElements()) {
		//input 태그의 속성이 file인 태그의 name속성값: 파라미터 이름
		String imgName = (String)files.nextElement();
	
		//서버에 저장된 파일 이름
		filename = multirequest.getFilesystemName(imgName);
	}
} catch(Exception e) {
	e.printStackTrace();
}
	


	String user = (String) session.getAttribute("user_id");


	String name = multirequest.getParameter("customer_name");
	String birth = multirequest.getParameter("customer_bYear")+multirequest.getParameter("customer_bMonth")+multirequest.getParameter("customer_bDay");
	String gender = multirequest.getParameter("gender");
	String q_passwd = multirequest.getParameter("customer_passhint");
	String ans_passwd =multirequest.getParameter("customer_passanswer");
	String address = multirequest.getParameter("com_postcode");
	String address1 = multirequest.getParameter("com_address");
	String address2 = multirequest.getParameter("com_detailAddress");
	String address3 = multirequest.getParameter("com_extraAddress");
	String phone = multirequest.getParameter("phone1") + "-" + multirequest.getParameter("phone2") + "-" + multirequest.getParameter("phone3");
	String tel = multirequest.getParameter("tel1")+"-"+multirequest.getParameter("tel2")+"-"+multirequest.getParameter("tel3");
	String email = multirequest.getParameter("customer_email1") + "@" + multirequest.getParameter("customer_email2");


	
%>
<jsp:useBean id="customer" scope="page"
	class="usedcar.shopping.CustomerDataBean">
</jsp:useBean>
<%
	customer.setUser_id(user);
	customer.setName(name);
	customer.setBirth(birth);
	customer.setGender(gender);
	customer.setQ_passwd(q_passwd);
	customer.setAns_passwd(ans_passwd);
	customer.setAddress(address);
	customer.setAddress1(address1);
	customer.setAddress2(address2);
	customer.setAddress3(address3);
	customer.setPhone(phone);
	customer.setTel(tel);
	customer.setEmail(email);
	customer.setImg(filename);
	
	CustomerDBBean customerProcess = CustomerDBBean.getInstance();

	customerProcess.updateMember(customer);
	
	response.sendRedirect("http://localhost:8888/UsedCar10/ShopMain.jsp");
	
		
	
%>
<script>
   alert('수정이 완료되었습니다.');
   location.href = "../../ShopMain.jsp";
</script>