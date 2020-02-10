<%@page import="usedcar.shopping.DealerDBBean"%>
<%@page import="usedcar.shopping.DealerDataBean"%>
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
	
	DealerDataBean dealerDto = new DealerDataBean();
	DealerDBBean dealerProcess = DealerDBBean.getInstance();
	
	
	// 이제 리퀘스트로 받아오자
	String user_id = multiRequest.getParameter("user_id");
	String passwd = multiRequest.getParameter("passwd"); 
	String name = multiRequest.getParameter("name"); 
	
	String bYear = multiRequest.getParameter("bYear");
	String bMonth = multiRequest.getParameter("bMonth");
	String bDay = multiRequest.getParameter("bDay");
	String birth = bYear + bMonth + bDay;
	
	String gender = multiRequest.getParameter("gender"); 
	String q_passwd = multiRequest.getParameter("passhint");
	String ans_passwd = multiRequest.getParameter("passans");
	
	String address = multiRequest.getParameter("dealer_postcode"); 
	String address1 = multiRequest.getParameter("dealer_address"); 
	String address2 = multiRequest.getParameter("dealer_detailAddress"); 
	String address3 = multiRequest.getParameter("dealer_extraAddress").trim(); 
	
	String phone1 = multiRequest.getParameter("phone1");
	String phone2 = multiRequest.getParameter("phone2");
	String phone3 = multiRequest.getParameter("phone3");
	String phone = phone1 + "-" +  phone2 + "-" +  phone3; 
	
	String tel1 = multiRequest.getParameter("tel1");
	String tel2 = multiRequest.getParameter("tel2");
	String tel3 = multiRequest.getParameter("tel3");
	String tel = tel1 + "-" + tel2 + "-" + tel3;
	
	String email1 = multiRequest.getParameter("email1");
	String email2 = multiRequest.getParameter("email2"); 
	String email = email1 + "@" + email2; 
	
	Timestamp reg_date = new Timestamp(System.currentTimeMillis());
	
	String union = multiRequest.getParameter("union"); 
	String company_name = multiRequest.getParameter("company_name"); 
	
	String bussiness_num1 = multiRequest.getParameter("bussiness_num1");
	String bussiness_num2 = multiRequest.getParameter("bussiness_num2");
	String bussiness_num3 = multiRequest.getParameter("bussiness_num3");
	String bussiness_num = bussiness_num1 + "-" + bussiness_num2 + "-" + bussiness_num3; 
	
	String company_addr = multiRequest.getParameter("company_postcode"); 
	String company_addr1 = multiRequest.getParameter("company_address"); 
	String company_addr2 = multiRequest.getParameter("company_detailAddress");
	String company_addr3 = multiRequest.getParameter("company_extraAddress").trim();
	
	String company_tel1 = multiRequest.getParameter("company_tel1");
	String company_tel2 = multiRequest.getParameter("company_tel2");
	String company_tel3 = multiRequest.getParameter("company_tel3");
	String company_tel = tel1 + "-" + tel2 + "-" + tel3;
	
	String company_fax1 = multiRequest.getParameter("company_fax1");
	String company_fax2 = multiRequest.getParameter("company_fax2");
	String company_fax3	= multiRequest.getParameter("company_fax3");
	String company_fax = company_fax1 + "-" + company_fax2 + "-" + company_fax3;
	
	String emp_id1 = multiRequest.getParameter("emp_id1");
	String emp_id2 = multiRequest.getParameter("emp_id2");
	String emp_id3 = multiRequest.getParameter("emp_id3");
	String emp_id = emp_id1 + "-" + emp_id2 + "-" + emp_id3;
	
	String introduction	= multiRequest.getParameter("introduction");
	String membertype = multiRequest.getParameter("membertype");
	

	// dto에 입력
	// 기본사항
	dealerDto.setUser_id(user_id);
	dealerDto.setPasswd(passwd);
	
	dealerDto.setName(name);
	dealerDto.setBirth(birth);
	dealerDto.setGender(gender);
	
	dealerDto.setQ_passwd(q_passwd);
	dealerDto.setAns_passwd(ans_passwd);
	
	dealerDto.setAddress(address);
	dealerDto.setAddress1(address1);
	dealerDto.setAddress2(address2);
	dealerDto.setAddress3(address3);
	
	dealerDto.setPhone(phone);
	dealerDto.setTel(tel);
	dealerDto.setEmail(email);
	
	dealerDto.setReg_date(reg_date);
	
	// 사업장 기본 사항
	dealerDto.setUnion(union);
	dealerDto.setCompany_name(company_name);
	dealerDto.setBussiness_num(bussiness_num);
	
	dealerDto.setCompany_addr(company_addr);
	dealerDto.setCompany_addr1(company_addr1);
	dealerDto.setCompany_addr2(company_addr2);
	dealerDto.setCompany_addr3(company_addr3);
	
	dealerDto.setCompany_tel(company_tel);
	dealerDto.setCompany_fax(company_fax);
	
	// 사원 정보
	dealerDto.setEmp_id(emp_id);
	dealerDto.setImg(filename);
	dealerDto.setIntroduction(introduction);
	dealerDto.setAuth(0); // auth는 기본값으로 0을 무조건 주고, 나중에 관리자가 권한을 줄 때 1로 바꾸는 걸로...
	
	dealerDto.setMembertype(membertype);
	
	// 입력 잘 되는지 toString 뽑아보기
	dealerDto.toString();
	
	// dto에 입력한거 insert method로 보내기
	dealerProcess.insertMember(dealerDto);
	
	%>
	<script>
		alert('<%=name %>님, 회원가입이 정상적으로 완료되었습니다.');
		location.href = "../../ShopMain.jsp";
	</script>

