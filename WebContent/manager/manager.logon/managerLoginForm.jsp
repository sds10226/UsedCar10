<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <script src="https://code.jquery.com/jquery.min.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../../stylesheet/managerLogin.css" type="text/css" />
    <title>로그인</title>
    <script>
    	function init() {
			var id_box = document.getElementById('id');
			var pw_box = document.getElementById('passwd');
			
			id_box.value = '';
			pw_box.value = '';
		}
    </script>
</head>
<style>
#body_Img {
  
    background-image: url("../../img/Lamborghini1.jpg");
    background-repeat: no-repeat;
    background-size: 1980px,1020px;
}
</style>
<body onload="init()" id="body_Img">

    <form action="managerLoginPro.jsp" class="login-form" name="loginForm" method="POST">
        <h1>KOOKSAN 관리자 <span><br>Login</span></h1>

		<!-- ID 입력 -->
        <div class="txtb">
            <input type="text" name="id" class="id" id="id" value="">
            <span data-placeholder="Username"></span>
        </div>

		<!-- PW 입력 -->
        <div class="txtb">
            <input type="password" name="passwd" class="passwd" id="passwd" value="">
            <span data-placeholder="Password"></span>
        </div>
	
		<!-- Login 버튼 -->	
        <input type="submit" class="logbtn" value="Login">
        
        
    </form>

    <script>
        $(".txtb input").on('focus', function() {
            $(this).addClass('focus');
        });

        $(".txtb input").on('blur', function() {
            if($(this).val() == "")
            $(this).removeClass('focus');
        });
        
    </script>
</body>

</html>











