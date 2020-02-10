<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   

<%@page import="usedcar.shopping.CustomerDBBean"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="usedcar.shopping.CustomerDataBean"%> 
<%@page import="java.sql.Timestamp"%>

<%
	request.setCharacterEncoding("utf-8");
	// 이미지 파일 경로 설정
	String realFolder = ""; // 웹 어플리케이션상의 절대경로
	String filename = "";
	MultipartRequest multiRequest = null;
	
	
	String saveFolder = "/images"; //파일이 업로드되는 폴더를 지정
	String encType = "utf-8"; //인코딩 타입
	int maxSize = (2 * 1024 * 1024) * 2; //최대 업로될 파일의 크기 4MB

	// 현재 jsp 페이지의 웹 어플리케이션상의 절대 경로 구하기
	ServletContext context = getServletContext();
	realFolder = context.getRealPath(saveFolder);


	try {
		//전송을 담당할 컴포넌트 생성 + 파일 전송.
		//전송할 파일명을 가지고 있는 객체, 서버상의 절대경로, 최대 업로드될 파일크기, 문자코드, 기본 보안 적용
		multiRequest = new MultipartRequest(
					request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		
		//전송한 파일 정보를 가져와 출력
		Enumeration<?>	files = multiRequest.getFileNames();
		
		//파일 정보가 있다면
		while(files.hasMoreElements()) {
			//input 태그의 속성이 file인 태그의 name속성값: 파라미터 이름
			String name = (String)files.nextElement();
		
			//서버에 저장된 파일 이름
			filename = multiRequest.getFilesystemName(name);
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
	
	/* DTO, DAO 객체 생성 */
	CustomerDataBean customerDto = new CustomerDataBean();
	CustomerDBBean customerProcess = CustomerDBBean.getInstance();

	/* 회원가입 입력폼 값 가져오기 */
	String user_id = multiRequest.getParameter("customer_user_id");
	String passwd = multiRequest.getParameter("customer_passwd");
	String name = multiRequest.getParameter("customer_name");

	String bYear = multiRequest.getParameter("customer_bYear");
	String bMonth = multiRequest.getParameter("customer_bMonth");
	String bDay = multiRequest.getParameter("customer_bDay");
	String birth = bYear + bMonth + bDay;

	String q_passwd = multiRequest.getParameter("customer_passhint");
	String ans_passwd = multiRequest.getParameter("customer_passans");
	String gender = multiRequest.getParameter("customer_gender");
	String address = multiRequest.getParameter("customer_postcode");
	String address1 = multiRequest.getParameter("customer_address");
	String address2 = multiRequest.getParameter("customer_detailAddress");
	String address3 = multiRequest.getParameter("customer_extraAddress");

	String phone1 = multiRequest.getParameter("customer_phone1");
	String phone2 = multiRequest.getParameter("customer_phone2");
	String phone3 = multiRequest.getParameter("customer_phone3");
	String phone = phone1 + "-" + phone2 + "-" + phone3;

	String tel1 = multiRequest.getParameter("customer_tel1");
	String tel2 = multiRequest.getParameter("customer_tel2");
	String tel3 = multiRequest.getParameter("customer_tel3");
	String tel = tel1 + "-" + tel2 + "-" + tel3;

	String email1 = multiRequest.getParameter("customer_email1");
	String email2 = multiRequest.getParameter("customer_email2");
	String email = email1 + "@" + email2;

	Timestamp reg_date = new Timestamp(System.currentTimeMillis());
	
	String membertype = multiRequest.getParameter("membertype");
	
	/* dto에 입력 */
	customerDto.setUser_id(user_id);
	customerDto.setPasswd(passwd);
	customerDto.setName(name);
	customerDto.setBirth(birth);
	customerDto.setQ_passwd(q_passwd);
	customerDto.setAns_passwd(ans_passwd);
	customerDto.setGender(gender);
	customerDto.setAddress(address);
	customerDto.setAddress1(address1);
	customerDto.setAddress2(address2);
	customerDto.setAddress3(address3);
	customerDto.setPhone(phone);
	customerDto.setTel(tel);
	customerDto.setEmail(email);
	customerDto.setImg(filename);
	customerDto.setReg_date(reg_date);
	customerDto.setMembertype(membertype);
	
	System.out.println("customerDto.toString() : " + customerDto.toString());
	
	/* 입력 메소드로 dto 보내기 */
	customerProcess.insertMember(customerDto);
%>

	<script>
		alert('<%=name %>님, 회원가입이 정상적으로 완료되었습니다.');
		location.href = "../../ShopMain.jsp";
	</script>















