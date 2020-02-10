//----------------------------------------------------------------
// 아이디 중복 확인
//----------------------------------------------------------------
function confirmId()
{
	if(document.memInsForm.id.value == "") {
		alert("아이디를 입력하십시오.");
		return;
	}
	
	url = "confirmId.jsp?id=" + document.memInsForm.id.value;
	
	window.open(url, "confirm", "toolbar=no, location=no, \
			status=no, menubar=no, scrollbars=no, \
			resizable=no, width=500, height=200");
} // End - function confirmId()

//----------------------------------------------------------------
// 숫자 검사
//----------------------------------------------------------------
function isNumberCheck(inputVal)
{
	var var_normalize = /[^0-9]/gi;	//정규식
	if(var_normalize.test(inputVal) == true) return false;
	else return true;
}

//----------------------------------------------------------------
//최상위 체크 로직(chars로 넘긴 값이 있다면 false)
//----------------------------------------------------------------
function containsChars(input, chars)
{
	for(var inx = 0; inx < input.length; inx++) {
		if(chars.indexOf(input.charAt(inx)) != -1)
			return true;
	}
	return false;
}
//----------------------------------------------------------------
//최상위 체크 로직(chars로 넘긴 값이 있다면 false)
//----------------------------------------------------------------
function containsCharsOnly(input, chars)
{
	for(var inx = 0; inx < input.length; inx++) {
		if(chars.indexOf(input.charAt(inx)) == -1) 
			return false;
	}
	return true;
}
//----------------------------------------------------------------
// 숫자 체크
//----------------------------------------------------------------
function isNum(input) {
	var chars = "0123456789";
	return containsCharsOnly(input, chars);
}
//----------------------------------------------------------------
// 영숫자 체크
//----------------------------------------------------------------
function isAlphaNumCheck(input) {
	var chars = "abcdefghijklmnopqrstuvwxyzABCEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	return containsCharsOnly(input, chars);
}
//----------------------------------------------------------------
// 이름 체크
//----------------------------------------------------------------
function isNameCheck(input) {
	var chars = "0123456789~!@#$%^&*()_-+=|{}[],./?";
	return containsCharsOnly(input, chars);
}
//----------------------------------------------------------------
//사원번호 체크
//----------------------------------------------------------------
function isEmpCheck(input) {
	var chars = "0123456789-";
	return containsCharsOnly(input, chars);
}
//----------------------------------------------------------------
//비밀번호 영어/특수문자 체크
//----------------------------------------------------------------
function passCheck(input) {
	var chars = "abcdefghijklmnopqrstuvwxyzABCEFGHIJKLMNOPQRSTUVWXYZ0123456789~!@#$%^&*()_-+=";
	return containsCharsOnly(input, chars);
}
//---------------------------  회원 등록검사
function signupCheckForm(signupForm) {
	/* 이름 검사 */
	if (!signupForm.name.value) {
		alert('이름을 입력하세요.');
		signupForm.name.focus();
		return false;
	}
	if (isNameCheck(updateForm.name.value) == true) {
		alert('이름에는 숫자나 특수문자를 입력할 수 없습니다.');
		signupForm.name.focus();
		return false;
	}

	/* 생년월일 검사 */
	if (signupForm.bYear.value == "" || signupForm.bMonth.value == ""
			|| signupForm.bDay.value == "") {
		alert('생년월일을 정확하게 선택해주세요.');
		return false;
	}

	/* 아이디 검사 */
	if (!signupForm.user_id.value) {
		alert('아이디를 입력하세요.');
		signupForm.user_id.focus();
		return false;
	}
	if (isAlphaNumCheck(signupForm.user_id.value) == false) {
		alert('ID에는 숫자와 영문자 혹은 특수문자(-, _)만 사용 가능합니다.');
		signupForm.user_id.focus();
		return false;
	}
	if (signupForm.user_id.value.length < 4
			|| signupForm.user_id.value.length > 12) {
		alert('ID는 4자리에서 12자리 사이를 입력해야 합니다.');
		signupForm.user_id.focus();
		return false;
	}

	/* 비밀번호 검사 */
	if (signupForm.passwd.value.length == 0) {
		alert('비밀번호를 입력하세요.');
		signupForm.passwd.focus();
		return false;
	}
	if (passCheck(signupForm.passwd.value) == false) {
		alert('비밀번호에는 영문 대/소문자, 숫자, 특수문자[~!@#$%^&*()_+|]만 사용 가능합니다.');
		signupForm.passwd.focus();
		return false;
	}
	if (signupForm.passwd.value.length < 8
			|| signupForm.passwd.value.length > 16) {
		alert('비밀번호는 8자리에서 12자리 사이를 입력해야 합니다.');
		signupForm.passwd.focus();
		return false;
	}

	/* 비밀번호와 비밀번화 확인 일치 검사 */
	if (signupForm.passwd.value != signupForm.chkpasswd.value) {
		alert('[비밀번호]와 [비밀번호 확인]이 서로 일치하지 않습니다.');
		signupForm.chkpasswd.focus();
		return false;
	}

	/* 기타 빈 값 확인 */
	if (signupForm.passhint.value == "") {
		alert('비밀번호 찾기 질문을 선택해주세요.');
		signupForm.passhint.focus();
		return false;
	}
	if (!signupForm.passans.value) {
		alert('비밀번호 찾기 답을 입력해주세요.');
		signupForm.passans.focus();
		return false;
	}

	/* 핸드폰 검사 */
	if (!signupForm.tel1.value) {
		alert("휴대전화번호를 입력하십시오.");
		signupForm.tel1.focus();
		return false;
	}
	if (!signupForm.tel2.value) {
		alert("휴대전화번호 2번째 자리를 입력해주세요.");
		signupForm.tel2.focus();
		return false;
	}
	if (signupForm.tel2.value.length < 3) {
		alert("휴대전화번호 2번째 자리는 3자 이상 입력해야 합니다.");
		signupForm.tel2.focus();
		return false;
	}
	if (!isNumberCheck(signupForm.tel2.value)) {
		alert("휴대전화번호 2번째 자리는 숫자만 입력이 가능합니다.");
		signupForm.tel2.focus();
		return false;
	}
	if (!signupForm.tel3.value) {
		alert("휴대전화번호 3번째 자리를 입력해주세요.");
		signupForm.tel3.focus();
		return false;
	}
	if (signupForm.tel3.value.length < 4) {
		alert("휴대전화번호 3번째 자리는 4자를 입력해야 합니다.");
		signupForm.tel3.focus();
		return false;
	}
	if (!isNumberCheck(signupForm.tel3.value)) {
		alert("휴대전화번호 3번째 자리는 숫자만 입력이 가능합니다.");
		signupForm.tel3.focus();
		return false;
	}

	/* 이메일 주소 검사 */
	if (!signupForm.email1.value) {
		alert('이메일 주소 앞자리를 입력해주세요.');
		signupForm.email1.focus();
		return false;
	}
	if (!signupForm.email2.value) {
		alert('이메일 주소 뒷자리를 입력해주세요.');
		signupForm.email2.focus();
		return false;
	}

	/* 주소+상사 주소 입력 검사 */
	if (!signupForm.dealer_address.value) {
		alert('주소를 입력해주세요.');
		return false;
	}
	if (!signupForm.company_address.value) {
		alert('상사 주소를 입력해주세요.');
		return false;
	}

	/* 조합명 입력 검사 */
	if (!signupForm.union.value) {
		alert('조합명을 선택해주세요.');
		signupForm.union.focus();
		return false;
	}

	/* 상호명 입력 검사 */
	if (!signupForm.company_name.value) {
		alert('상사 상호명을 입력해주세요.');
		signupForm.company_name.focus();
		return false;
	}

	/* 사업자 등록번호 입력 검사 */
	// 앞 자리
	if (!signupForm.bussiness_num1.value) {
		alert('사업자 등록번호를 입력해주세요.')
		signupForm.bussiness_num1.focus();
		return false;
	}
	if (signupForm.bussiness_num1.length < 3) {
		alert('사업자 등록 번호 앞자리는 3자리로 입력해야 합니다.')
		signupForm.bussiness_num1.focus();
		return false;
	}
	if (!isNumberCheck(signupForm.bussiness_num1.value)) {
		alert('사업자 등록 번호는 숫자만 입력이 가능합니다.')
		signupForm.bussiness_num1.focus();
		return false;
	}
	// 중간 자리
	if (!signupForm.bussiness_num2.value) {
		alert('사업자 등록번호를 입력해주세요.')
		signupForm.bussiness_num2.focus();
		return false;
	}
	if (signupForm.bussiness_num2.length < 2) {
		alert('사업자 등록 번호 중간 자리는 2자리로 입력해야 합니다.')
		signupForm.bussiness_num2.focus();
		return false;
	}
	if (!isNumberCheck(signupForm.bussiness_num2.value)) {
		alert('사업자 등록 번호는 숫자만 입력이 가능합니다.')
		signupForm.bussiness_num2.focus();
		return false;
	}
	// 끝 자리
	if (!signupForm.bussiness_num3.value) {
		alert('사업자 등록번호를 입력해주세요.')
		signupForm.bussiness_num3.focus();
		return false;
	}
	if (signupForm.bussiness_num3.length < 5) {
		alert('사업자 등록 번호 마지막 자리는 5자리로 입력해야 합니다.')
		signupForm.bussiness_num3.focus();
		return false;
	}
	if (!isNumberCheck(signupForm.bussiness_num3.value)) {
		alert('사업자 등록 번호는 숫자만 입력이 가능합니다.')
		signupForm.bussiness_num3.focus();
		return false;
	}

	/* 상사 전화번호 검사 */
	// 앞 자리
	if (signupForm.company_phone1.value) {
		alert('상사 전화번호 앞자리를 선택해주세요.')
		signupForm.company_phone1.focus();
		return false;
	}
	// 2번째 자리
	if (signupForm.company_phone2.value) {
		alert('상사 전화번호 2번째 자리를 입력해주세요.')
		signupForm.company_phone2.focus();
		return false;
	}
	if (signupForm.company_phone2.length < 3) {
		alert('상사 전화번호 2번째 자리는 3자 이상 입력해야 합니다.')
		signupForm.company_phone2.focus();
		return false;
	}
	if (!isNumberCheck(signupForm.company_phone2.value)) {
		alert('상사 전화번호 2번째 자리는 숫자만 입력이 가능합니다.')
		signupForm.company_phone2.focus();
		return false;
	}
	// 3번째 자리
	if (signupForm.company_phone3.value) {
		alert('상사 전화번호 3번째 자리를 입력해주세요.')
		signupForm.company_phone3.focus();
		return false;
	}
	if (signupForm.company_phone3.length < 4) {
		alert('상사 전화번호 3번째 자리는 4자를 입력해야 합니다.')
		signupForm.company_phone3.focus();
		return false;
	}
	if (!isNumberCheck(signupForm.company_phone3.value)) {
		alert('상사 전화번호 3번째 자리는 숫자만 입력이 가능합니다.')
		signupForm.company_phone3.focus();
		return false;
	}

	/* 상사 팩스번호 검사 */
	// 2번째 자리
	if (signupForm.company_fax2.length < 3) {
		alert('상사 팩스번호 2번째 자리는 3자 이상 입력해야 합니다.')
		signupForm.company_fax2.focus();
		return false;
	}
	if (!isNumberCheck(signupForm.company_fax2.value)) {
		alert('상사 팩스번호 2번째 자리는 숫자만 입력이 가능합니다.')
		signupForm.company_fax2.focus();
		return false;
	}
	// 3번째 자리
	if (signupForm.company_fax3.length < 4) {
		alert('상사 팩스번호 3번째 자리는 4자를 입력해야 합니다.')
		signupForm.company_fax3.focus();
		return false;
	}
	if (!isNumberCheck(signupForm.company_fax3.value)) {
		alert('상사 팩스번호 3번째 자리는 숫자만 입력이 가능합니다.')
		signupForm.company_fax3.focus();
		return false;
	}

	/* 매매사원증 번호 검사 */
	if (!signupForm.emp_num.value) {
		alert('매매사원증 번호를 입력해주세요.');
		signupForm.emp_num.focus();
		return false;
	}

	if (!isEmpCheck(signupForm.emp_num.value)) {
		alert('매매사원증 번호에는 숫자와 특수문자[-]만 입력이 가능합니다.')
		signupForm.emp_num.focus();
		return false;
	}

	signupForm.action="singup-dealer.jsp";
	signupForm.submit();
	/* 데이터 넘김 */
	// signupForm.action = 'sign_up_process/signup-dealer-pro.jsp';
	// signupForm.submit();
} // end method
/* --------------------------- 회원가입 유효성 검사 끝 --------------------------- */

// --------------------------- 딜러 회원 수정검사
function updateCheckForm(updateForm) {

	/* 기타 빈 값 확인 */
	if (updateForm.passhint.value == "") {
		alert('비밀번호 찾기 질문을 선택해주세요.');
		updateForm.passhint.focus();
		return false;
	}
	if (!updateForm.passans.value) {
		alert('비밀번호 찾기 답을 입력해주세요.');
		updateForm.passans.focus();
		return false;
	}

	/* 핸드폰 검사 */
	if (!updateForm.tel1.value) {
		alert("휴대전화번호를 입력하십시오.");
		updateForm.tel1.focus();
		return false;
	}
	if (!updateForm.tel2.value) {
		alert("휴대전화번호 2번째 자리를 입력해주세요.");
		updateForm.tel2.focus();
		return false;
	}
	if (updateForm.tel2.value.length < 3) {
		alert("휴대전화번호 2번째 자리는 3자 이상 입력해야 합니다.");
		updateForm.tel2.focus();
		return false;
	}
	if (!isNumberCheck(updateForm.tel2.value)) {
		alert("휴대전화번호 2번째 자리는 숫자만 입력이 가능합니다.");
		updateForm.tel2.focus();
		return false;
	}
	if (!updateForm.tel3.value) {
		alert("휴대전화번호 3번째 자리를 입력해주세요.");
		updateForm.tel3.focus();
		return false;
	}
	if (updateForm.tel3.value.length < 4) {
		alert("휴대전화번호 3번째 자리는 4자를 입력해야 합니다.");
		updateForm.tel3.focus();
		return false;
	}
	if (!isNumberCheck(updateForm.tel3.value)) {
		alert("휴대전화번호 3번째 자리는 숫자만 입력이 가능합니다.");
		updateForm.tel3.focus();
		return false;
	}

	/* 이메일 주소 검사 */
	if (!updateForm.email1.value) {
		alert('이메일 주소 앞자리를 입력해주세요.');
		updateForm.email1.focus();
		return false;
	}
	if (!updateForm.email2.value) {
		alert('이메일 주소 뒷자리를 입력해주세요.');
		updateForm.email2.focus();
		return false;
	}

	/* 주소+상사 주소 입력 검사 */
	if (!updateForm.del_postcode.value) {
		alert('우편번호를 입력해주세요.');
		return false;
	}
	if (!updateForm.del_address.value) {
		alert('주소를 입력해주세요.');
		return false;
	}
	if (!updateForm.del_detailAddress.value) {
		alert('상세주소를 입력해주세요.');
		return false;
	}
	if (!updateForm.del_extraAddress.value) {
		alert('참고항목을 입력해주세요.');
		return false;
	}
	if (!updateForm.com_postcode.value) {
		alert('상사 우편번호를 입력해주세요.');
		return false;
	}
	if (!updateForm.com_address.value) {
		alert('상사 주소를 입력해주세요.');
		return false;
	}
	if (!updateForm.com_detailAddress.value) {
		alert('상사 상세주소를 입력해주세요.');
		return false;
	}
	if (!updateForm.com_extraAddress.value) {
		alert('상사 참고항목을 입력해주세요.');
		return false;
	}
	

	/* 조합명 입력 검사 */
	if (!updateForm.union.value) {
		alert('조합명을 선택해주세요.');
		updateForm.union.focus();
		return false;
	}

	/* 상호명 입력 검사 */
	if (!updateForm.company_name.value) {
		alert('상사 상호명을 입력해주세요.');
		updateForm.company_name.focus();
		return false;
	}

	/* 사업자 등록번호 입력 검사 */
	// 앞 자리
	if (!updateForm.bussiness_num1.value) {
		alert('사업자 등록번호를 입력해주세요.')
		updateForm.bussiness_num1.focus();
		return false;
	}
	if (updateForm.bussiness_num1.length < 3) {
		alert('사업자 등록 번호 앞자리는 3자리로 입력해야 합니다.')
		updateForm.bussiness_num1.focus();
		return false;
	}
	if (!isNumberCheck(updateForm.bussiness_num1.value)) {
		alert('사업자 등록 번호는 숫자만 입력이 가능합니다.')
		updateForm.bussiness_num1.focus();
		return false;
	}
	// 중간 자리
	if (!updateForm.bussiness_num2.value) {
		alert('사업자 등록번호를 입력해주세요.')
		updateForm.bussiness_num2.focus();
		return false;
	}
	if (updateForm.bussiness_num2.length < 2) {
		alert('사업자 등록 번호 중간 자리는 2자리로 입력해야 합니다.')
		updateForm.bussiness_num2.focus();
		return false;
	}
	if (!isNumberCheck(updateForm.bussiness_num2.value)) {
		alert('사업자 등록 번호는 숫자만 입력이 가능합니다.')
		updateForm.bussiness_num2.focus();
		return false;
	}
	// 끝 자리
	if (!updateForm.bussiness_num3.value) {
		alert('사업자 등록번호를 입력해주세요.')
		updateForm.bussiness_num3.focus();
		return false;
	}
	if (updateForm.bussiness_num3.length < 5) {
		alert('사업자 등록 번호 마지막 자리는 5자리로 입력해야 합니다.')
		updateForm.bussiness_num3.focus();
		return false;
	}
	if (!isNumberCheck(updateForm.bussiness_num3.value)) {
		alert('사업자 등록 번호는 숫자만 입력이 가능합니다.')
		updateForm.bussiness_num3.focus();
		return false;
	}

	/* 상사 전화번호 검사 */
	
	// 2번째 자리
	if (!updateForm.company_tel2.value) {
		alert('상사 전화번호 2번째 자리를 입력해주세요.')
		updateForm.company_tel2.focus();
		return false;
	}
	if (updateForm.company_tel2.length < 3) {
		alert('상사 전화번호 2번째 자리는 3자 이상 입력해야 합니다.')
		updateForm.company_tel2.focus();
		return false;
	}
	if (!isNumberCheck(updateForm.company_tel2.value)) {
		alert('상사 전화번호 2번째 자리는 숫자만 입력이 가능합니다.')
		updateForm.company_tele2.focus();
		return false;
	}
	// 3번째 자리
	if (!updateForm.company_tel3.value) {
		alert('상사 전화번호 3번째 자리를 입력해주세요.')
		updateForm.company_tel3.focus();
		return false;
	}
	if (updateForm.company_tel3.length < 4) {
		alert('상사 전화번호 3번째 자리는 4자를 입력해야 합니다.')
		updateForm.company_tele3.focus();
		return false;
	}
	if (!isNumberCheck(updateForm.company_tel3.value)) {
		alert('상사 전화번호 3번째 자리는 숫자만 입력이 가능합니다.')
		updateForm.company_tel3.focus();
		return false;
	}

	/* 상사 팩스번호 검사 */
	// 1번째 자리
	if (updateForm.company_fax1.length < 3) {
		alert('상사 팩스번호 1번째 자리는 3자 이상 입력해야 합니다.')
		updateForm.company_fax1.focus();
		return false;
	}
	if (!isNumberCheck(updateForm.company_fax1.value)) {
		alert('상사 팩스번호 1번째 자리는 숫자만 입력이 가능합니다.')
		updateForm.company_fax1.focus();
		return false;
	}
	// 2번째 자리
	if (updateForm.company_fax2.length < 3) {
		alert('상사 팩스번호 2번째 자리는 3자 이상 입력해야 합니다.')
		updateForm.company_fax2.focus();
		return false;
	}
	if (!isNumberCheck(updateForm.company_fax2.value)) {
		alert('상사 팩스번호 2번째 자리는 숫자만 입력이 가능합니다.')
		updateForm.company_fax2.focus();
		return false;
	}
	// 3번째 자리
	if (updateForm.company_fax3.length < 4) {
		alert('상사 팩스번호 3번째 자리는 4자를 입력해야 합니다.')
		updateForm.company_fax3.focus();
		return false;
	}
	if (!isNumberCheck(updateForm.company_fax3.value)) {
		alert('상사 팩스번호 3번째 자리는 숫자만 입력이 가능합니다.')
		updateForm.company_fax3.focus();
		return false;
	}

	/* 매매사원증 번호 검사 */
	if (!updateForm.emp_id.value) {
		alert('매매사원증 번호를 입력해주세요.');
		updateForm.emp_id.focus();
		return false;
	}

	if (!isEmpCheck(updateForm.emp_id.value)) {
		alert('매매사원증 번호에는 숫자와 특수문자[-]만 입력이 가능합니다.')
		updateForm.emp_id.focus();
		return false;
	}
	updateForm.action = "dealerUpdatePro.jsp";
	updateForm.submit();
	/* 데이터 넘김 */
	// signupForm.action = 'sign_up_process/signup-dealer-pro.jsp';
	// signupForm.submit();
} // end method
/* --------------------------- 딜러 정보 수정 유효성 검사 끝 --------------------------- */

//--------------------------- 회원 수정검사
function customerupdateCheckForm(customerupdateForm) {

	/* 기타 빈 값 확인 */
	if (customerupdateForm.passhint.value == "") {
		alert('비밀번호 찾기 질문을 선택해주세요.');
		customerupdateForm.passhint.focus();
		return false;
	}
	if (!customerupdateForm.passans.value) {
		alert('비밀번호 찾기 답을 입력해주세요.');
		customerupdateForm.passans.focus();
		return false;
	}

	/* 핸드폰 검사 */
	if (!customerupdateForm.tel1.value) {
		alert("휴대전화번호를 입력하십시오.");
		customerupdateForm.tel1.focus();
		return false;
	}
	if (!customerupdateForm.tel2.value) {
		alert("휴대전화번호 2번째 자리를 입력해주세요.");
		customerupdateForm.tel2.focus();
		return false;
	}
	if (customerupdateForm.tel2.value.length < 3) {
		alert("휴대전화번호 2번째 자리는 3자 이상 입력해야 합니다.");
		customerupdateForm.tel2.focus();
		return false;
	}
	if (!isNumberCheck(customerupdateForm.tel2.value)) {
		alert("휴대전화번호 2번째 자리는 숫자만 입력이 가능합니다.");
		customerupdateForm.tel2.focus();
		return false;
	}
	if (!customerupdateForm.tel3.value) {
		alert("휴대전화번호 3번째 자리를 입력해주세요.");
		customerupdateForm.tel3.focus();
		return false;
	}
	if (customerupdateForm.tel3.value.length < 4) {
		alert("휴대전화번호 3번째 자리는 4자를 입력해야 합니다.");
		customerupdateForm.tel3.focus();
		return false;
	}
	if (!isNumberCheck(customerupdateForm.tel3.value)) {
		alert("휴대전화번호 3번째 자리는 숫자만 입력이 가능합니다.");
		customerupdateForm.tel3.focus();
		return false;
	}

	/* 이메일 주소 검사 */
	if (!customerupdateForm.email1.value) {
		alert('이메일 주소 앞자리를 입력해주세요.');
		customerupdateForm.email1.focus();
		return false;
	}
	if (!customerupdateForm.email2.value) {
		alert('이메일 주소 뒷자리를 입력해주세요.');
		customerupdateForm.email2.focus();
		return false;
	}

	/* 주소 입력 검사 */
	if (!customerupdateForm.com_postcode.value) {
		alert('우편번호를 입력해주세요.');
		return false;
	}
	if (!customerupdateForm.com_address.value) {
		alert('주소를 입력해주세요.');
		return false;
	}
	if (!customerupdateForm.com_detailAddress.value) {
		alert('상세주소를 입력해주세요.');
		return false;
	}
	if (!customerupdateForm.com_extraAddress.value) {
		alert('참고항목을 입력해주세요.');
		return false;
	}
	
	

	customerupdateForm.action = "customerUpdatePro.jsp";
	customerupdateForm.submit();

} // end method
/* --------------------------- 회원 정보 수정 유효성 검사 끝 --------------------------- */


/*----------------------------- 회원 탈퇴  -----------------------------*/
/* 회원탈퇴 비밀번호 검사 */
function updelCheckForm(updelForm) {
		console.dir(updelForm);
		if (!updelForm.repasswd.value) {
			alert('비밀번호를 입력하세요.');
			updelForm.repasswd.focus();
			return false;
		}
		if (passCheck(updelForm.repasswd.value) == false) {
			alert('비밀번호에는 영문 대/소문자, 숫자, 특수문자[~!@#$%^&*()_+|]만 사용 가능합니다.');
			updelForm.repasswd.focus();
			return false;
		}
		if (updelForm.repasswd.value.length < 8
				|| updelForm.repasswd.value.length > 16) {
			alert('비밀번호는 8자리에서 12자리 사이를 입력해야 합니다.');
			updelForm.repasswd.focus();
			return false;
		}
	
		/* 비밀번호와 비밀번호 확인 일치 검사 */
		if (updelForm.passwd.value != updelForm.repasswd.value) {
			alert('[비밀번호]와 [비밀번호 확인]이 서로 일치하지 않습니다.');
			updelForm.repasswd.focus();
			return false;
		}
		
		if(confirm('회원탈퇴를 하시겠습니까?')) {
			updelForm.action = "deletePro.jsp";
			updelForm.submit();
		} else {
			location.href = "http://localhost:8888/UsedCar/shopping/logon/deleteform.jsp";
		}
	
	}/* 회원 비밀번호 변경시 검사 */
/*---------------------- 비밀번호 변경 유효성 검사---------------------------------*/
function changepasswdCheckForm(changepasswdForm) {
	if (changepasswdForm.ownpasswd.value.length == 0) {
		alert('현재 비밀번호를 입력하세요.');
		changepasswdForm.ownpasswd.focus();
		return false;
	}
	if (passCheck(changepasswdForm.ownpasswd.value) == false) {
		alert('비밀번호에는 영문 대/소문자, 숫자, 특수문자[~!@#$%^&*()_+|]만 사용 가능합니다.');
		changepasswdForm.ownpasswd.focus();
		return false;
	}
	if (changepasswdForm.ownpasswd.value.length < 8 || changepasswdForm.ownpasswd.value.length > 12) {
		alert('비밀번호는 8자리에서 12자리 사이를 입력해야 합니다.');
		changepasswdForm.ownpasswd.focus();
		return false;
	}
	
	//--------------------------------------------------------
	if (changepasswdForm.newpasswd.value.length == 0) {
		alert('새 비밀번호를 입력하세요.');
		changepasswdForm.newpasswd.focus();
		return false;
	}
	if (passCheck(changepasswdForm.newpasswd.value) == false) {
		alert('비밀번호에는 영문 대/소문자, 숫자, 특수문자[~!@#$%^&*()_+|]만 사용 가능합니다.');
		changepasswdForm.newpasswd.focus();
		return false;
	}
	if (changepasswdForm.newpasswd.value.length < 8 || changepasswdForm.newpasswd.value.length > 16) {
		alert('비밀번호는 8자리에서 12자리 사이를 입력해야 합니다.');
		changepasswdForm.newpasswd.focus();
		return false;
	}
	
	//-----------------------------------------------------------
	if (changepasswdForm.renewpasswd.value.length == 0) {
		alert('새 비밀번호 확인을 입력하세요.');
		changepasswdForm.renewpasswd.focus();
		return false;
	}
	if (passCheck(changepasswdForm.renewpasswd.value) == false) {
		alert('비밀번호에는 영문 대/소문자, 숫자, 특수문자[~!@#$%^&*()_+|]만 사용 가능합니다.');
		changepasswdForm.renewpasswd.focus();
		return false;
	}
	if (changepasswdForm.renewpasswd.value.length < 8 || changepasswdForm.renewpasswd.value.length > 16) {
		alert('비밀번호는 8자리에서 12자리 사이를 입력해야 합니다.');
		changepasswdForm.renewpasswd.focus();
		return false;
	}

	/* DB에 저장된 비밀번호와 입력된 현재 비밀번호 확인 일치 검사 */
	if (changepasswdForm.chkpasswd.value != changepasswdForm.ownpasswd.value) {
		alert('현재 비밀번호를 잘못 입력하였습니다.');
		changepasswdForm.ownpasswd.focus();
		return false;
	}
	if (changepasswdForm.newpasswd.value != changepasswdForm.renewpasswd.value) {
		alert('[새 비밀번호]와 [확인 비밀번호]가 서로 일치하지 않습니다.');
		changepasswdForm.renewpasswd.focus();
		return false;
	}
	changepasswdForm.action = "passwdChgPro.jsp";
	changepasswdForm.submit();
}