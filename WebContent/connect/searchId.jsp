<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="../stylesheet/footer.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
		type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">

<script src="https://code.jquery.com/jquery.min.js"></script>
<script>
    $(document).ready(function(){
            $("#searchId-footer").load("../module/footer.html")    
    });

    /* 숫자 검사 */
    function isNumberCheck(inputVal) {
        var var_normalize = /[^0-9]/gi;	//정규식
        if(var_normalize.test(inputVal) == true) {
            return false;
        } else {
            return true;
        } 
    }

    /* 입력 유효성 검사 */
    function checkSearchIdForm(searchIdForm) { 
        /* 이메일 주소 검사 */
        if(!searchIdForm.email1.value) {
            alert('이메일 주소 앞자리를 입력해주세요.');
            searchIdForm.email1.focus();
            return false;
        }
        if(!searchIdForm.email2.value) {
            alert('이메일 주소 뒷자리를 입력해주세요.');
            searchIdForm.email2.focus();
            return false;
        }

         /* 핸드폰 검사 */
         if(!searchIdForm.tel1.value) {
            alert("휴대전화번호를 입력하십시오.");
            searchIdForm.tel1.focus();
            return false;
        }
        if(!searchIdForm.tel2.value) {
            alert("휴대전화번호 2번째 자리를 입력하십시오.");
            searchIdForm.tel2.focus();
            return false;
        }
        if(searchIdForm.tel2.value.length < 3) {
            alert("휴대전화번호 2번째 자리는 3자 이상 입력해야 합니다.");
            searchIdForm.tel2.focus();
            return false;
        }
        if(!isNumberCheck(searchIdForm.tel2.value)) {
            alert("휴대전화번호 2번째 자리는 숫자만 입력이 가능합니다.");
            searchIdForm.tel2.focus();
            return false;
        }
        if(!searchIdForm.tel3.value) {
            alert("휴대전화번호 3번째 자리를 입력하십시오.");
            searchIdForm.tel3.focus();
            return false;
        }
        if(searchIdForm.tel3.value.length < 4) {
            alert("휴대전화번호 3번째 자리는 4자를 입력해야 합니다.");
            searchIdForm.tel3.focus();
            return false;
        }
        if(!isNumberCheck(searchIdForm.tel3.value)) {
            alert("휴대전화번호 3번째 자리는 숫자만 입력이 가능합니다.");
            searchIdForm.tel3.focus();
            return false;
        }
        
        // --------- ajax 시작
       	var xhttp = new XMLHttpRequest();
       	
       	var email1 = document.getElementById('email1').value;
       	var email2 = document.getElementById('email2').value;
       	var email = email1 + "@" + email2;
        	
       	var tel1 = document.getElementById('tel1').value;
       	var tel2 = document.getElementById('tel2').value;
       	var tel3 = document.getElementById('tel3').value;
       	var tel = tel1 + "-" + tel2 + "-" + tel3;
       	
       	xhttp.onreadystatechange = function() {
       		if(this.readyState == 4 && this.status == 200) {
       			document.getElementById('searchId-res').value = this.responseText;
       		}
       	};
       	xhttp.open("POST", "connect_process/searchIdPro.jsp?email="+ encodeURI(email) + "&tel=" + encodeURI(tel), true);
       	xhttp.send();
       	// --------- ajax 끝
        	
    } // end - 유효성 검사
    
</script>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        text-decoration: none;
        font-family: 'Montserrat', sans-serif;
    }

    /* 컨테이너 */
    #searchId-container {
        width: 1200px;
        height: auto;
        margin: 0 auto;
        padding: 30px;

        margin-top: 30px;
    }
    /* 컨테이너 안에 회색 툴 */
    .searchId-tool {
        /* border: 1px solid rgb(180, 180, 180);
        box-shadow: inset 0px 0px 2px 2px rgb(180,180,180);
        border-radius: 10px; */
        width: 800px;
        height: 400px;
        
        margin: 0 auto;
    }

    /* 회색 툴 안에 담고있는 table setting */
    .searchId-form {
        padding: 30px;
    }

    /* input setting */
    .email1,
    .email2,
    .tel1,
    .tel2,
    .tel3,
    .searchId-res {
        height: 40px;
        font-size: 20px;
        text-align: center;
    }
    .email2::placeholder,
    .searchId-res::placeholder {
        color: lightgray;
    }

    /* table setting */
    #searchId-table {
        border-top: 2px solid gray;
        border-collapse: collapse;
        width: 640px;
        margin: 0 auto;
        margin-top: 20px;
    }

    /* table th setting */
    #searchId-table tr th {
        border-bottom: 1px solid lightgray;
        text-align: left;
        height: 70px;
        width: 150px;
        padding-left: 10px;
        background-color: rgb(250, 250, 250);

        font-weight: 600;
        
    }
    /* table td setting */
    #searchId-table tr td {
        border-bottom: 1px solid lightgray;
        padding-left: 10px;
    }

    .tel1,
    .tel2,
    .tel3 {
        width: 4em;
    }

    /* 검색 버튼 */
    .submit_btn {
        background-color: white;
        border: 1px solid black;
        border-radius: 5px;
        width: 100px;
        height: 40px;
        font-size: 105%;
        cursor: pointer;

        transition: .2s linear;
    }
    .submit_btn:hover {
        border: 1px solid #EE5A24;
        background-color: #EE5A24;
        color: white;
    }
    
    .searchId-res {
    	width: 400px;
    }
    
    
    /* 상단 메뉴 바 */
	.searchId-top {
	    height: 70px;
	    background: #EE5A24;
	    padding: 0 20px;
	    color: #fff;
	}
	
	.searchId-left-menu {
	    position: relative;
	    height: 70px;
	    /* 왼쪽에 부유하는 블록 박스를 생성 */
	    float: left;
	    
	}
	
	.searchId-left-menu > span {
	    font-weight: bold;
	    font-size: 230%;
	    border-bottom: 2px solid #fff;
	    color: white;
	    line-height: 70px;
	}
	
	.searchId-left-menu > a {
	    color: #fff;
	    text-decoration: none;
	    padding: 0 15px;
	    transition: .4s;
	}
	
	.searchId-right-menu {
	    /* 오른쪽에 부유하는 블록 박스를 생성 */
	    float: right;
	}
	
	.searchId-right-menu > a {
	    color: #fff;
	    text-decoration: none;
	    padding: 0 5px;
	    transition: .4s;
	    font-size: 80%;
	    vertical-align: bottom;
	}
	
	/* 이렇게 두 개의 클래스를 한 번에 모아서 처리 가능 */
	.searchId-left-menu > a:hover, 
	.searchId-right-menu > a:hover {
	    color: rgb(236, 180, 159);
	    text-decoration: none;
	}
	
	.searchId-menu {
	    border: 0px solid #EE5A24;
	    width: 1000px;
	    margin: 0 auto;
	}

    
</style>

<title>아이디 찾기</title>
</head>
<body>
    <!-- 머리 -->
    <div class="searchId-top">
        <div class="searchId-menu">
	        <!-- float: left; -->
	        <div class="searchId-left-menu">
	            <span>KOOK SAN</span>
	            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	            <a href="searchPasswd.jsp">비밀번호 찾기</a>
	        </div>

	        <div class="searchId-right-menu">
	            <!-- float: right; -->
	            <br>
	            <a href="../ShopMain.jsp"><i class="fas fa-home" style="color: white;"></i> HOME</a>
	        </div>
        </div>
    </div>
    
    <!-- 몸 -->
    <div id="searchId-container">
        <div class="searchId-tool">
            
            <form action="" method="get" id="searchId-form" class="searchId-form" name="searchId-form">
                <h2 style="text-align: center; color: #EE5A24;">고객 아이디 검색</h2>
                <table id="searchId-table" class="searchId-table">
                    <!-- email -->
                    <tr>
                        <th>E-mail 주소</th>
                        <td>
                            <input type="text" class="email1" id="email1" name="email1" value="" maxlength="14"> @
                            <input type="text" class="email2" id="email2" name="email2" list="emailList" placeholder="직접 입력" value="">
                            <datalist id="emailList">
                                <option value="gmail.com">gmail.com</option>
                                <option value="hanmail.net">hanmail.net</option>
                                <option value="outlook.kr">outlook.kr</option>
                                <option value="nate.com">nate.com</option>
                                <option value="naver.com">naver.com</option>
                                <option value="yahoo.com">yahoo.com</option>
                            </datalist>
                        </td>
                    </tr>

                    <!-- 전화번호 -->
                    <tr>
                        <th>휴대전화 번호</th>
                        <td>
                            <select class="tel1" id="tel1" name="tel1">
                                <option value="" hidden>선택</option>
                                <option value="010">010</option>
                                <option value="011">011</option>
                                <option value="016">016</option>
                                <option value="017">017</option>
                            </select> -
                            <input type="text" class="tel2" id="tel2" name="tel2" value="" maxlength="4"> -
                            <input type="text" class="tel3" id="tel3" name="tel3" value="" maxlength="4">
                        </td>
                    </tr>

                    <!-- 검색한 아이디 노출 -->
                    
                    <tr>
                        <th style="height: 100px;">회원 아이디</th>
                        <td>
                            <input type="text" placeholder="검색 버튼을 눌러주세요." class="searchId-res" id="searchId-res" name="searchId-res" value="" readonly>
                            <br><small style="color: #EE5A24;">* 검색한 회원 ID의 앞 5자리를 제외한 나머지는 *로 표시됩니다.</small>
                        </td>
                    </tr> 
                    
                </table>
                
                <br>

                <div class="searchId-sub-btn" style="text-align: center;">
                    <button type="button" class="submit_ajax_btn submit_btn" id="submit_ajx_btn submit_btn" onclick="checkSearchIdForm(this.form)">검 색</button>
                </div>
   
            </form>
        </div>

    </div>

    <br>
    <br>
    <hr>

    <!-- 발 -->
    <div id="searchId-footer">
    </div>
</body>
</html>