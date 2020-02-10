<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="usedcar.shopping.DealerDBBean"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import="java.sql.Timestamp"%>
<%
   request.setCharacterEncoding("utf-8");

String   realFolder    = "";   //웹 어플리케이션 상의 절대 경로
String   filename   = "";
MultipartRequest multirequest = null;

String   saveFolder   = "/images"; //파일이 업로드되는 폴더를 지정한다.
String   encType      = "utf-8";      //인코딩 타입
int      maxSize      = 8*1024*1024;   //최대 업로될 파일의 크기 2MB

//현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구한다.
ServletContext   context   = getServletContext();
realFolder   = context.getRealPath(saveFolder);

System.out.println("### dealerUpdatePro realFolder : " + realFolder);

try {
   //전송을 담당할 컴포넌트를 생성하고 파일을 전송한다.
   //전송할 파일명을 가지고 있는 객체, 서버상의 절대경로, 최대 업로드될 파일크기,
   //문자코드, 기본 보안 적용
   multirequest = new MultipartRequest(
            request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
   
   //전송한 파일 정보를 가져와 출력한다.
   Enumeration<?>   files = multirequest.getFileNames();
   
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
   String name = multirequest.getParameter("dealer_name");
   String birth = multirequest.getParameter("dealer_bYear")+multirequest.getParameter("dealer_bMonth")+multirequest.getParameter("dealer_bDay");
   String gender = multirequest.getParameter("gender");
   String q_passwd = multirequest.getParameter("dealer_passhint");
   String ans_passwd =multirequest.getParameter("dealer_passanswer");
   String address = multirequest.getParameter("del_postcode");
   String address1 = multirequest.getParameter("del_address");
   String address2 = multirequest.getParameter("del_detailAddress");
   String address3 = multirequest.getParameter("del_extraAddress");
   String phone = multirequest.getParameter("phone1")+"-"+multirequest.getParameter("phone2")+"-"+multirequest.getParameter("phone3");
   String tel = multirequest.getParameter("tel1")+"-"+multirequest.getParameter("tel2")+"-"+multirequest.getParameter("tel3");
   String email = multirequest.getParameter("dealer_email1")+"@"+multirequest.getParameter("dealer_email2");
   String union = multirequest.getParameter("union");
   String company_name = multirequest.getParameter("company_name");
   String bussiness_num = multirequest.getParameter("bussiness_num1")+"-"+multirequest.getParameter("bussiness_num2")+"-"+multirequest.getParameter("bussiness_num3");
   String company_addr = multirequest.getParameter("com_postcode");
   String company_addr1 = multirequest.getParameter("com_address");
   String company_addr2 = multirequest.getParameter("com_detailAddress");
   String company_addr3 = multirequest.getParameter("com_extraAddress");
   String company_tel = multirequest.getParameter("company_tel1")+"-"+multirequest.getParameter("company_tel2")+"-"+multirequest.getParameter("company_tel3");
   String company_fax = multirequest.getParameter("company_fax1")+"-"+multirequest.getParameter("company_fax2")+"-"+multirequest.getParameter("company_fax3");
   String emp_id = multirequest.getParameter("emp_id");
   String introduction = multirequest.getParameter("intro");


%>
<jsp:useBean id="dealer" scope="page"
   class="usedcar.shopping.DealerDataBean">
</jsp:useBean>
<%

dealer.setUser_id(user);
dealer.setName(name);
dealer.setBirth(birth);
dealer.setGender(gender);
dealer.setQ_passwd(q_passwd);
dealer.setAns_passwd(ans_passwd);
dealer.setAddress(address);
dealer.setAddress1(address1);
dealer.setAddress2(address2);
dealer.setAddress3(address3);
dealer.setPhone(phone);
dealer.setTel(tel);
dealer.setEmail(email);
dealer.setUnion(union);
dealer.setCompany_name(company_name);
dealer.setBussiness_num(bussiness_num);
dealer.setCompany_addr(company_addr);
dealer.setCompany_addr1(company_addr1);
dealer.setCompany_addr2(company_addr2);
dealer.setCompany_addr3(company_addr3);
dealer.setCompany_tel(company_tel);
dealer.setCompany_fax(company_fax);
dealer.setEmp_id(emp_id);
dealer.setImg(filename);
dealer.setIntroduction(introduction);


DealerDBBean dealerProcess = DealerDBBean.getInstance();

dealerProcess.updateMember(dealer);

%>

<script>
   alert('수정이 완료되었습니다.');
   location.href = "../../ShopMain.jsp";
</script>