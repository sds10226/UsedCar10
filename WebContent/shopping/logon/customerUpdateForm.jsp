<%@ page import="usedcar.shopping.CustomerDBBean"%>
<%@ page import="usedcar.shopping.CustomerDataBean"%>
<%@ page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">

<link rel="stylesheet" type="text/css" href="../../stylesheet/footer.css">
<link rel="stylesheet" type="text/css" href="../../stylesheet/top.css">
<link rel="stylesheet" type="text/css" href="../../css/left.css">
<link rel="stylesheet" type="text/css" href="../../css/customerupdate.css">

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery.min.js"></script>

<style type="text/css">
	/* css 속성 겹침 제거 : footer에 email subscribe쪽 관련 */
	.footer-form-group {
		line-height: 0px !important;
	}
	.footer-form-subscribe {
		line-height: 20px !important;
	}
</style>

<script src="../../js/function.js"></script>
<%
	CustomerDataBean customerList = null;

	if (session.getAttribute("user_id") == null) {
		response.sendRedirect("../../ShopMain.jsp");
	} else if (session.getAttribute("membertype").equals("딜러회원")) {
		response.sendRedirect("../../ShopMain.jsp");
	} else {
		String customer = (String)session.getAttribute("user_id");

		//세션id에 해당하는 정보를 DB에서 가져온다.
		CustomerDBBean customerProcess = CustomerDBBean.getInstance();
		customerList = customerProcess.getMember(customer);

		//생년 월일을 화면에 맞게 나눈다.
		String customer_bYear = "";
		String customer_bMonth = "";
		String customer_bDay = "";

		customer_bYear = customerList.getBirth().substring(0, 4);
		customer_bMonth = customerList.getBirth().substring(4, 6); 
		customer_bDay = customerList.getBirth().substring(6, 8);

		//전화 번호를 화면에 맞게 나눈다.
		String phone1 = "";
		String phone2 = "";
		String phone3 = "";
		
		String phone = customerList.getPhone();
		StringTokenizer phoneStr = new StringTokenizer(phone,"-");
		
		phone1 = phoneStr.nextToken();
		phone2 = phoneStr.nextToken();
		phone3 = phoneStr.nextToken();
			
		//핸드폰 번호를 화면에 맞게 나눈다.
		String tel1 = "";
		String tel2 = "";
		String tel3 = "";
		
		String tel = customerList.getTel();
		StringTokenizer telStr = new StringTokenizer(tel, "-");
		
		tel1 = telStr.nextToken();
		tel2 = telStr.nextToken();
		tel3 = telStr.nextToken();

		//이메일을 화면에 맞게 나눈다.
		String customer_email1 = "";
		String customer_email2 = "";
		String email = customerList.getEmail();
		StringTokenizer str = new StringTokenizer(email, "@");
		customer_email1 = str.nextToken();
		customer_email2 = str.nextToken();
%>
<script type="text/javascript">
	function scrollMove() {
		document.body.scrollTop = 0;
		document.documentElement.scrollTop = 0;
	}/* top으로 위로 올리게 한다.*/
	
	 /* 자기소개 byte 제한 */
    $(document).ready(function () {
            $('.intro').keyup(function(){
                cut_80(this);
            }); 
        });
    
        /* 문자열 길이 구하기(한글 포함) */
        function getTextLength(str) {
            var len = 0;
            for (var i = 0; i < str.length; i++) {
                if (escape(str.charAt(i)).length == 6) {
                    len++;
                }
                len++;
            }
            return len;
        }
        
        /* span에 현재 입력한 byte수를 보여주고, 800byte를 초과하지 못하게 제한을 건다. */
        function cut_80(obj){
            var text = $(obj).val();
            var leng = text.length;
            while(getTextLength(text) > 800){
                leng--;
                text = text.substring(0, leng);
            }
            $(obj).val(text);
            $('.textByte').text(getTextLength(text));
        }
	
	/* 생년월일 설정 */
	function birthdaySetSelectBox() {
		var today = new Date();
		var year = today.getFullYear();

		/* 연도 처리 */
		for (var i = year; i >= 1900; i--) {
			$('#bYear').append('<option value="' + i + '">' + i + '</option>');
		}

		/* 월 처리 */
		for (var i = 12; i >= 1; i--) {
			if (i < 10) {
				i = '0' + i;
				$('#bMonth').append(
						'<option value="' + i + '">' + i + '</option>');
			} else {
				$('#bMonth').append(
						'<option value="' + i + '">' + i + '</option>');
			}
		}

		/* 일 처리 */
		for (var i = 31; i >= 1; i--) {
			if (i < 10) {
				i = '0' + i;
				$('#bDay').append(
						'<option value="' + i + '">' + i + '</option>');
			} else {
				$('#bDay').append(
						'<option value="' + i + '">' + i + '</option>');
			}
		}
	}
</script>
<!-- 카카오 도로명 주소 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
					function customer_execDaumPostcode() {
						new daum.Postcode(
								{
									oncomplete : function(data) {
										// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

										// 각 주소의 노출 규칙에 따라 주소를 조합한다.
										// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
										var addr = ''; // 주소 변수
										var extraAddr = ''; // 참고항목 변수

										//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
										if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
											addr = data.roadAddress;
										} else { // 사용자가 지번 주소를 선택했을 경우(J)
											addr = data.jibunAddress;
										}

										// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
										if (data.userSelectedType === 'R') {
											// 법정동명이 있을 경우 추가한다. (법정리는 제외)
											// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
											if (data.bname !== ''
													&& /[동|로|가]$/g
															.test(data.bname)) {
												extraAddr += data.bname;
											}
											// 건물명이 있고, 공동주택일 경우 추가한다.
											if (data.buildingName !== ''
													&& data.apartment === 'Y') {
												extraAddr += (extraAddr !== '' ? ', '
														+ data.buildingName
														: data.buildingName);
											}
											// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
											if (extraAddr !== '') {
												extraAddr = ' (' + extraAddr
														+ ')';
											}
											// 조합된 참고항목을 해당 필드에 넣는다.
											document.getElementById("com_extraAddress").value = extraAddr;

										} else {
											document.getElementById("com_extraAddress").value = '';
										}

										// 우편번호와 주소 정보를 해당 필드에 넣는다.
										document.getElementById('com_postcode').value = data.zonecode;
										document.getElementById("com_address").value = addr;
										// 커서를 상세주소 필드로 이동한다.
										document.getElementById("com_detailAddress").focus();
									}
								}).open();
					}
				</script>
				<!--input도로명 주소API-->
<!--input도로명 주소API-->


</head>


<title>고객회원정보관리</title>
</head>
<body onload="birthdaySetSelectBox()">
	<header id="header">
		<jsp:include page="../../module/top.jsp" flush="false" />
	</header>

	<div id="nav-sidebar">
		<jsp:include page="../../module/left.jsp" flush="false" />
	</div>


	<div class="container">
		<form id="updatecustomerinfo" class="updatecustomerinfo" name="updatecustomerinfo" method="POST"
			action="" enctype="multipart/form-data">

			<h3 style="text-align: center; font-size: 30px; color: #EE5A24;">회원
				정보 수정</h3>
			<br> <br>
			<div class="section summary">
				<div class="part desc">
					<p>
						<small>고객님의 비밀번호 확인 후 <em>닉네임, 주소, 연락처(전화번호,휴대폰,이메일
								등)</em> 등의 회원정보를 수정할 수 있습니다.
						</small>
					</p><br>
				</div>
			</div>

			<div class="part form userinfo">

				<b style="color: #EE5A24; font-size: 100%;"> <i
					class="fas fa-car"></i>기본 정보
				</b> 
				<small style="color: #EE5A24; float: right; line-height: 40px;">*
					표시는 필수입력 사항</small>
			</div>

			<table id="default-info-table">

				<tr class="default-id">
					<th id="deault-id_th">&nbsp;&nbsp;아이디 <em>*</em></th>
					<td><input type="text" name="customer_id" id="user_id" value="<%=customer%>"
						maxlength="12" disabled></td>
				</tr>
				<!--input id="id" type="hidden name="id" value="">-->
				<tr class="default-name">
					<th>이름 <em>*</em>
					</th>
					<td><input type="text" class="form-control" id="name"
						value="<%=customerList.getName()%>" name="customer_name" maxlength="10"
						readonly></td>
				</tr>
				<!-- 생년월일 입력-->
				<tr class="update-birth">
					<th>생년월일 <em>*</em>
					</th>
					<td>
						<p class="birth-set">
							<select name="customer_bYear" id="bYear" class="bYear">
								<option value="<%=customer_bYear%>" hidden><%=customer_bYear%></option>
							</select> 년 &nbsp; <select name="customer_bMonth" id="bMonth"
								class="bMonth">
								<option value="<%=customer_bMonth%>" hidden><%=customer_bMonth%></option>
							</select> 월&nbsp; <select name="customer_bDay" id="bDay" class="bDay">
								<option value="<%=customer_bDay%>" hidden><%=customer_bDay%></option>
							</select> 일
						</p>
					</td>
				</tr>
				<tr class="update-gender">
					<th>&nbsp;&nbsp;성 별 <em>*</em> <!--(성별:남/여)-->
					</th>
					<td>&nbsp; <span><input name="gender" type="radio" id="gender" value="남성"
							<%if (customerList.getGender().equals("남성")) {%> checked <%}%>>남성&nbsp;&nbsp;
							<input name="gender" type="radio" id="gender" value="여성"
							<%if (customerList.getGender().equals("여성")) {%> checked <%}%>>여성</span></td>
					<!--(성별:남/여)-->
				</tr>
				<!--input으로 생년월일(birth), 성별(gender)가져오기-->
				<!--input /id/type/name/value-->
				<tr class="update=q_passwd">

					<th><br>비밀번호 재발급 질문 <em>*</em>
					</th>
					<td><select id="passhint" name="customer_passhint"
						class="pass-q">
							<option value="" hidden>질문 선택</option>
							<option value="나의 첫차는?"
								<%if (customerList.getQ_passwd().equals("나의 첫차는?")) {%> selected
								<%}%>>나의 첫차는?</option>
							<option value="아버지의 첫차는?"
								<%if (customerList.getQ_passwd().equals("아버지의 첫차는?")) {%> selected
								<%}%>>아버지의 첫차는?</option>
							<option value="내가 가장 갖고 싶은 차는?"
								<%if (customerList.getQ_passwd().equals("내가 가장 갖고 싶은 차는?")) {%>
								selected <%}%>>내가 가장 갖고 싶은 차는?</option>
							<option value="내가 가장 좋아하는 운동은?"
								<%if (customerList.getQ_passwd().equals("내가 가장 좋아하는 운동은?")) {%>
								selected <%}%>>내가 가장 좋아하는 운동은?</option>
							<option value="나의 노래방 18번은?"
								<%if (customerList.getQ_passwd().equals("나의 노래방 18번은?")) {%>
								selected <%}%>>나의 노래방 18번은?</option>
							<option value="가장 좋아하는 가수는?"
								<%if (customerList.getQ_passwd().equals("가장 좋아하는 가수는?")) {%>
								selected <%}%>>가장 좋아하는 가수는?</option>
							<option value="아버지 성함은?"
								<%if (customerList.getQ_passwd().equals("아버지 성함은?")) {%> selected
								<%}%>>아버지 성함은?</option>
					</select> &nbsp;&nbsp;<small>비밀번호 찾기 시 본인확인용으로 사용</small></td>
				</tr>
				<tr class="update-ans_passwd">
					<th>비밀번호 찾기 답 <em>*</em>
					</th>
					<td><input id="passans" class="text pass" type="text"
						name="customer_passanswer" value="<%=customerList.getAns_passwd()%>" maxlength="30"></td>
				</tr>

				<tr class="update-address">
					<th style="height: 100px;">
					<label style="text-align: center;"><br>&nbsp;&nbsp;주소 <em>*</em>
					</label></th>
					
					<td>
					<input type="text" id="com_postcode" name="com_postcode" placeholder="우편번호" style="width: 130px;" value="<%=customerList.getAddress()%>">
					<input id="comaddrees" type="button" name="comaddress_btn" onclick="customer_execDaumPostcode(this)" value="우편번호 찾기"><br>
					<input type="text" id="com_address" name="com_address" placeholder="주소" style="width: 500px;" value="<%=customerList.getAddress1()%>"><br>
					
					<p style="height: 5px;"></p>
					
					<input type="text" id="com_detailAddress" name="com_detailAddress" placeholder="상세주소" style="width: 250px;" value="<%=customerList.getAddress2()%>">
					
					<input type="text" id="com_extraAddress" name="com_extraAddress" placeholder="참고항목" style="width: 150px;" value="<%=customerList.getAddress3()%>">
					
					<br>
					
					<p class="post"></p> 
					<small>&nbsp;*차량 판매 시 정확한 위치정보를 위해 도로명주소 입력을 권장합니다.</small>
					</td>
				</tr>
				
				<tr class="update-telephone">
					<th>전화 번호</th>
					<td>
						
							<select id="phone1" class="select" name="phone1"
								style="width: 80px;">
								<option value="02" <%if (phone1.equals("02")) {%> selected <%}%>>02</option>
								<option value="031" <%if (phone1.equals("031")) {%> selected
									<%}%>>031</option>
								<option value="032" <%if (phone1.equals("032")) {%> selected
									<%}%>>032</option>
								<option value="033" <%if (phone1.equals("033")) {%> selected
									<%}%>>033</option>
								<option value="041" <%if (phone1.equals("041")) {%> selected
									<%}%>>041</option>
								<option value="042" <%if (phone1.equals("042")) {%> selected
									<%}%>>042</option>
								<option value="043" <%if (phone1.equals("043")) {%> selected
									<%}%>>043</option>
								<option value="044" <%if (phone1.equals("044")) {%> selected
									<%}%>>044</option>
								<option value="051" <%if (phone1.equals("051")) {%> selected
									<%}%>>051</option>
								<option value="052" <%if (phone1.equals("052")) {%> selected
									<%}%>>052</option>
								<option value="053" <%if (phone1.equals("053")) {%> selected
									<%}%>>053</option>
								<option value="054" <%if (phone1.equals("054")) {%> selected
									<%}%>>054</option>
								<option value="055" <%if (phone1.equals("055")) {%> selected
									<%}%>>055</option>
								<option value="061" <%if (phone1.equals("061")) {%> selected
									<%}%>>061</option>
								<option value="062" <%if (phone1.equals("062")) {%> selected
									<%}%>>062</option>
								<option value="063" <%if (phone1.equals("063")) {%> selected
									<%}%>>063</option>
								<option value="064" <%if (phone1.equals("064")) {%> selected
									<%}%>>064</option>
								<option value="070" <%if (phone1.equals("070")) {%> selected
									<%}%>>070</option>
							</select> - 
							<input id="phone2" class="text phone" type="text" name="phone2" maxlength="4" style="width: 80px;"value="<%=phone2%>"> - 
							<input id="phone3" class="text phone" type="text" name="phone3" maxlength="4" style="width: 80px;" value="<%=phone3%>">
						
					</td>
				</tr>

				<tr class="update-tel">
					<th>휴대전화번호 <em>*</em>
					</th>
					<td>
						
							<select id="tel1" class="select" name="tel1"
								style="width: 80px;">
								<option value="010" <%if (tel1.equals("010")) {%> selected <%}%>>010</option>
								<option value="011" <%if (tel1.equals("011")) {%> selected <%}%>>011</option>
								<option value="016" <%if (tel1.equals("016")) {%> selected <%}%>>016</option>
								<option value="017" <%if (tel1.equals("017")) {%> selected <%}%>>017</option>
								<option value="019" <%if (tel1.equals("019")) {%> selected <%}%>>019</option>
							</select> - 
							<input id="tel2" class="text tel" type="text" name="tel2" value="<%=tel2%>" maxlength="4" style="width: 80px;"> -
							<input id="tel3" class="text tel" type="text" name="tel3" value="<%=tel3%>" maxlength="4" style="width: 80px;">
						
					</td>
				</tr>

				<!-- 이메일 입력 -->
				<tr class="update-email">
					<th>이메일 주소 <em>*</em></th>
					<td>
					<input type="text" id="email1" class="email1" name="customer_email1" value="<%=customer_email1%>" maxlength="40" />@ 
					<input type="text" id="email2" class="email2" name="customer_email2" value="<%=customer_email2%>" list="emailList" placeholder="직접 입력">
					 <!-- 수정 이후 test 해볼것 --> 
					 <datalist id="emailList">
							<option value="gmail.com"
								<%if (customer_email2.equals("gmail.com")) {%> selected <%}%>>gmail.com</option>
							<option value="hanmail.net"
								<%if (customer_email2.equals("hanmail.net")) {%> selected <%}%>>hanmail.net</option>
							<option value="outlook.kr"
								<%if (customer_email2.equals("outlook.kr")) {%> selected <%}%>>outlook.kr</option>
							<option value="nate.com"
								<%if (customer_email2.equals("nate.com")) {%> selected <%}%>>nate.com</option>
							<option value="naver.com"
								<%if (customer_email2.equals("naver.com")) {%> selected <%}%>>naver.com</option>
							<option value="yahoo.com"
								<%if (customer_email2.equals("yahoo.com")) {%> selected <%}%>>yahoo.com</option>
						</datalist>
					</td>
				</tr>
				


			
			</table>
			<p class="wait waitS wait1">
				<sup title="참고">*</sup> <em>부정확한 전화번호(예 : 02-111-1111,
					031-000-0000) 입력 시 판매차량 등록이 불가능</em>할 수 있습니다.
			</p>
			<p class="wait waitS wait2">
				<sup title="참고">*</sup> <em>평생번호(0502, 0504, 0505, 0506) 국번의
					전화번호는 050 안심번호를 통한 연결이 불가합니다.</em> 다른 번호를 입력해주세요.
			</p>
			<br><br>
				<h5 style="color: #EE5A24; font-size: 100%;">
					<i class="fas fa-car"></i>개인 이미지 정보
				</h5>
				
					<br>
					<table id="customer-info-table">
					
					<!-- 사원 증명사진 -->
					<tr class="profile">
						<th style="height: 120px;">프로필사진&nbsp;<em>*</em></th>
						<td>
							<div class="profile-img">
							<div class="img-first">
								<p class="image">
									<img src="../../images/noImage.jpg" class="profile" id="profile"  width="80" height="100" onerror="javascript:noImg_user(this);" width="80">
								</p>
							</div>
							
							<div>
								<p class="file">
									<span id="inputFile"><input type="file" id="images"
										name="images" style="display: block;" onchange="imgUpload()"></span>
									<input type="hidden" id="filetext" name="filetext"
										value="<%=customerList.getImg()%>">
								</p>
								<p style="height: 10px;"></p>
								<small>* 이미지 등록기준 : 80X100 사이즈 / JPG 파일</small> 
								<small>* 본인 프로필이 아닌 사진(예 : 연예인, 동물 등) 등록 시 삭제 처리</small>
								</div>
							</div>
						</td>
					</tr>
				</table>

		
			<br>
			<div class="contain_sub_btn" style="text-align: center;">
				
				<button type="button" class="submit_btn" onclick="customerupdateCheckForm(this.form)">확인</button> 
				
			</div>

			<br><br>
			<div class="section caution"
				style="border: dotted 1px; padding: 5px; padding-bottom: 10px; margin-bottom: 30px;">

				<dl class="caution">
					<dt>
						<i class="fas fa-star"></i>꼭 알아두세요!
					</dt>
					<dd>kooksan은 회원님의 개인정보를 안전하게 보호하며, 회원님의 동의 없이는 공개 및 제3자 제공을 하지
						않습니다.</dd>
					<dd>
						<em>타인의 주민등록번호 도용 시</em> <br> - 관련법규(주민등록법)에 따라 처벌 : 3년 이하의
						징역 또는 1천만원 이하의 벌금부과<br> - kooksan 이용이 즉시 제한되며, 결제한 금액이 있어도
						환불불가
					</dd>
				</dl>
			</div>

			<div id="top" onclick="scrollMove()"
				style="cursor: pointer; width: fit-content; margin: auto; text-align: right;">
				<b>top</b>
			</div>
		</form>

	</div>
	<div id="footer">
		<jsp:include page="../../module/footer.html" flush="false" />
	</div>


</body>

</html>
<%
	}
%>
