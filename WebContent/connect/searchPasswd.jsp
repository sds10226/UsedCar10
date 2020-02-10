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
            $("#searchPasswd-footer").load("../module/footer.html")    
    });


    /* 입력 유효성 검사 */
    function checkSearchPasswdForm(searchPasswdForm) { 
        if(!searchPasswdForm.user_id.value) {
            alert('아이디를 입력해주세요.');
            searchIdForm.user_id.focus();
            return false;
        }
        if(!searchPasswdForm.passhint.value) {
            alert('비밀번호 찾기 질문을 선택해주세요.');
            searchPasswdForm.passhint.focus();
            return false;
        }

        if(!searchPasswdForm.passans.value) {
            alert("비밀번호 찾기 답을 입력해주세요.");
            searchPasswdForm.passans.focus();
            return false;
        }
        
        // --------- ajax 시작
       	var xhttp = new XMLHttpRequest();
       	
       	var user_id = document.getElementById('user_id').value;
        var passhint = document.getElementById('passhint').value;
        var passans = document.getElementById('passans').value;
       	
       	xhttp.onreadystatechange = function() {
       		if(this.readyState == 4 && this.status == 200) {
       			document.getElementById('searchPasswd-res').value = this.responseText;
       		}
       	};
       	xhttp.open("POST", "connect_process/searchPasswdPro.jsp?user_id="+ encodeURI(user_id) + "&passhint=" + encodeURI(passhint) + "&passans=" + encodeURI(passans), true);
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
    #searchPasswd-container {
        width: 1200px;
        height: auto;
        margin: 0 auto;
        padding: 30px;

        margin-top: 10px;
    }
    /* 컨테이너 안에 회색 툴 */
    .searchPasswd-tool {
        /* border: 1px solid rgb(180, 180, 180);
        box-shadow: inset 0px 0px 2px 2px rgb(180,180,180);
        border-radius: 10px; */
        width: 800px;
        height: 400px;
        
        margin: 0 auto;
    }

    /* 회색 툴 안에 담고있는 table setting */
    .searchPasswd-form {
        padding: 30px;
    }

    /* input setting */
    .user_id,
    .passans,
    .searchPasswd-res,
    .passhint {
        height: 40px;
        font-size: 20px;
        text-align: center;
    }
    .searchPasswd-res::placeholder {
        color: lightgray;
    }

    /* table setting */
    #searchPasswd-table {
        border-top: 2px solid gray;
        border-collapse: collapse;
        width: 640px;
        margin: 0 auto;
        margin-top: 20px;
    }

    /* table th setting */
    #searchPasswd-table tr th {
        border-bottom: 1px solid lightgray;
        text-align: left;
        height: 70px;
        width: 180px;
        padding-left: 10px;
        background-color: rgb(250, 250, 250);

        font-weight: 600;
        
    }
    /* table td setting */
    #searchPasswd-table tr td {
        border-bottom: 1px solid lightgray;
        padding-left: 10px;
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
    
    .searchPasswd-res {
    	width: 400px;
    }

    .searchPasswd_tool {
        width: 400px;
        text-align: center;
    }

    /* 상단 메뉴 바 */
	.searchPasswd-top {
	    height: 70px;
	    background: #EE5A24;
	    padding: 0 20px;
	    color: #fff;
	}
	
	.searchPasswd-left-menu {
	    position: relative;
	    height: 70px;
	    /* 왼쪽에 부유하는 블록 박스를 생성 */
	    float: left;
	    
	}
	
	.searchPasswd-left-menu > span {
	    font-weight: bold;
	    font-size: 230%;
	    border-bottom: 2px solid #fff;
	    color: white;
	    line-height: 70px;
	}
	
	.searchPasswd-left-menu > a {
	    color: #fff;
	    text-decoration: none;
	    padding: 0 15px;
	    transition: .4s;
	}
	
	.searchPasswd-right-menu {
	    /* 오른쪽에 부유하는 블록 박스를 생성 */
	    float: right;
	}
	
	.searchPasswd-right-menu > a {
	    color: #fff;
	    text-decoration: none;
	    padding: 0 5px;
	    transition: .4s;
	    font-size: 80%;
	    vertical-align: bottom;
	}
	
	/* 이렇게 두 개의 클래스를 한 번에 모아서 처리 가능 */
	.searchPasswd-left-menu > a:hover, 
	.searchPasswd-right-menu > a:hover {
	    color: rgb(236, 180, 159);
	    text-decoration: none;
	}
	
	.searchPasswd-menu {
	    border: 0px solid #EE5A24;
	    width: 1000px;
	    margin: 0 auto;
	}


    
</style>

<title>아이디 찾기</title>
</head>
<body>
    <!-- 머리 -->
    <div class="searchPasswd-top">
        <div class="searchPasswd-menu">
	        <!-- float: left; -->
	        <div class="searchPasswd-left-menu">
	            <span>KOOK SAN</span>
	            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	            <a href="searchId.jsp">아이디 찾기</a>
	        </div>

	        <div class="searchPasswd-right-menu">
	            <!-- float: right; -->
	            <br>
	            <a href="../ShopMain.jsp"><i class="fas fa-home" style="color: white;"></i> HOME</a>
	        </div>
        </div>
    </div>
    
    <!-- 몸 -->
    <div id="searchPasswd-container">
        <div class="searchPasswd-tool">
            
            <form action="" method="get" id="searchPasswd-form" class="searchPasswd-form" name="searchPasswd-form">
                <h2 style="text-align: center; color: #EE5A24;">고객 아이디 검색</h2>
                <table id="searchPasswd-table" class="searchPasswd-table">
                    <!-- id -->
                    <tr>
                        <th>회원 ID</th>
                        <td>
                            <input type="text" class="user_id searchPasswd_tool" id="user_id" name="user_id" value="" maxlength="14">
                        </td>
                    </tr>

                    <!-- 비밀번호 찾기 질문 -->
                    <tr>
                        <th>비밀번호 찾기 질문</th>
                        <td>
                            <select id="passhint" name="passhint" class="passhint searchPasswd_tool">
                                <option value="" hidden>질문 선택</option>
                                <option value="나의 첫차는?">나의 첫차는?</option>
                                <option value="아버지의 첫차는?">아버지의 첫차는?</option>
                                <option value="내가 가장 갖고 싶은 차는?">내가 가장 갖고 싶은 차는?</option>
                                <option value="내가 가장 좋아하는 운동은?">내가 가장 좋아하는 운동은?</option>
                                <option value="나의 노래방 18번은?">나의 노래방 18번은?</option>
                                <option value="가장 좋아하는 가수는?">가장 좋아하는 가수는?</option>
                                <option value="아버지 성함은?">아버지 성함은?</option>
                            </select>
                        </td>
                    </tr>

                    <!-- 비밀번호 찾기 답 -->
                    <tr>
                        <th>비밀번호 찾기 답</th>
                        <td>
                            <input type="text" class="passans searchPasswd_tool" id="passans" name="passans" value="" maxlength="14">
                        </td>
                    </tr>

                    
                    <!-- 검색한 비밀번호 노출 -->
                    <tr>
                        <th style="height: 100px;">비밀번호</th>
                        <td>
                            <input type="text" placeholder="검색 버튼을 눌러주세요." class="searchPasswd-res" id="searchPasswd-res" name="searchPasswd-res" value="" readonly>
                            <br><small style="color: #EE5A24;">* 검색한 비밀번호의 앞 4자리를 제외한 나머지는 *로 표시됩니다.</small>
                        </td>
                    </tr> 
                    
                </table>
                
                <br>

                <div class="searchPasswd-sub-btn" style="text-align: center;">
                    <button type="button" class="submit_ajax_btn submit_btn" id="submit_ajx_btn submit_btn" onclick="checkSearchPasswdForm(this.form)">검 색</button>
                </div>
   
            </form>
        </div>

    </div>

    <br>
    <br>
    <hr>

    <!-- 발 -->
    <div id="searchPasswd-footer">
    </div>
</body>
</html>