<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../css/topWhite.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" type="text/css" href="../css/introduction.css">
<title>회사 임직원 소개</title>
</head>

<body>

	<header id="header">
		<jsp:include page="../module/top.jsp" flush="false" />
	</header>

	<div class="slideshow-container">

<div class="mySlides fade">
  <img class="img_1" src="../img/1.jpg" >
</div>

<div class="mySlides fade">
  <img class="img_1" src="../img/2.jpg">
</div>

<div class="mySlides fade">
  <img class="img_1" src="../img/3.jpg">
</div>

<div class="mySlides fade">
  <img class="img_1" src="../img/4.jpg">
</div>

<div class="mySlides fade">
  <img class="img_1" src="../img/5.jpg">
</div>
<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
<a class="next" onclick="plusSlides(1)">&#10095;</a>

</div>
<br>

<div style="text-align:center">
  <span class="dot" onclick="currentSlide(1)"></span> 
  <span class="dot" onclick="currentSlide(2)"></span> 
  <span class="dot" onclick="currentSlide(3)"></span>  
  <span class="dot" onclick="currentSlide(4)"></span> 
  <span class="dot" onclick="currentSlide(5)"></span> 
</div>
	
	<h1> KOOKSAN 사업 소개 및 임직원 소개</h1>
		<div id="infoContainer">
		<h3>1.KOOKSAN 자동차 사업의 소개</h3>
		<br>
			<div class="txt_info">
				<a>
				(주)KOOKSAN자동차는 소비자에게 합리적인 가격과 정직한 마음으로 자동차 공급을 하기 위하여 노력합니다.
				</a>
			</div>
				<br>
				<br>
		<h3>2.KOOKSAN 자동차 프로젝트 진행</h3>
		<br>
			<div class="txt_info">
				<a >저희 KOOKSAN 자동차 프로젝트는 <span style="color:red;">MVC-1</span>을 기반으로 하여 
					 <span style="color:red;">HTML</span>, <span style="color:blue;">CSS</span>, <span style="color:green;">JAVA-SCRIPT</span>, <span style="color:purple;">JSP</span>를 사용하였으며, 
					<br>사용된 기술로서는  <span style="color:red;">AJAX</span>, <span style="color:skyblue;">bootstrap</span>, <span style="color:navy;">jQuery</span>을 사용하였으며,<br>
					데이터베이스는 <span style="color:puple;">MySQL</span>을 사용하였습니다.
				</a>
			</div>
		<br>
		<h3>3.KOOKSAN 자동차 프로젝트 역할 분배</h3>
		<br><br>
		
			<div class="txt_info2">
				<table class="table_info1">
					
					<tr class="info_tr1">
				
						<td class="info_td1">김	 상	헌</td>
					
						<td class="info_td2">
							<ul>
								<li>관리자 페이지 전체 설계 및 생성</li>
								<li>딜러/일반회원정보 수정</li>
								<li>비밀번호 변경</li>
								<li>회원탈퇴</li>
								<li>차량문의사항</li>
								<li>등록권한에 따른 차량등록 가능여부 설계</li>
								<li>전체 DB구성 및 회원관련 DB설계</li>
							</ul>
						</td>
						<td class="info_td1">이	 영	기</td>
						<td class="info_td2">
							<ul>
								<li>등록 차량 페이지네이션 및 항목별 정렬 기능 구현</li>
								<li>찜 기능 구현</li>
								<li>쿠키를 이용한 스크롤값 유지 기능 구현</li>
								<li>URL parameter 값 유지 및 수정 기능 구현</li>
								<li>차량 상세보기 페이지 구현</li>
								<li>구매문의 기능 구현</li>
								<li>SQL에서 join, and, or, like 모두 적용해 봄</li>
							</ul>
						</td>
					</tr>
					<tr class="info_tr1">
						<td class="info_td1">신	동	수</td>
						<td class="info_td2">
							<ul>
								<li>SearchMenu(검색조건선택메뉴)</li>
								<li>사용자의 검색 조건 선택에 따른 쿼리 전달</li>
								<li>중복선택하여 해당 상품 모두 볼수 있게함</li>
								<li>각 조건에 해당하는 현재 등록된 차량 상품의 숫자 표시</li>
								<li>차량 배기량 조건 부분 Ajax사용하여 숫자 받음</li>
								<li>선택 초기화 기능</li>
								<li>차량 등록 리스트 생성</li>
							</ul>
						</td>
						
						<td class="info_td1">강	한	결</td>
						<td class="info_td2">
							<ul>
								<li>메인페이지(ShopMain) 제작</li>
								<li>상단 메뉴바와 하단 툴 제작</li>
								<li>로그인과 로그아웃 기능 구현</li>
								<li>아이디 찾기와 비밀번호 찾기 구현(ajax 사용)</li>
								<li>회원가입 기능 구현</li>
								<li>QnA 페이지 제작</li>
								<li>차량 등록 리스트 제작</li>
							</ul>
						</td>
					</tr>
				</table>
	
		</div>
	</div>

	
	<div class="container_first"><img alt="" src="../img/car.jpg" width="1980px;" height="auto;" style="position:relative; z-index: -1;"></div>
	<div class="container_seconed">
	
		<div class="column1">
			<div class="gap1"><div class="infotextgap1">김	상	헌</div></div>
			<div class="cell1"><img class="profile" src="../profileImg/deadpool.jpg"></div>
			<div class="gap1" ><div class="infotextgap1">이	영	기</div></div>
			<div class="cell1"><img class="profile" src="../profileImg/homer.jpg"></div>
			<div class="gap1" ><div class="infotextgap1">신	동	수</div></div>
			<div class="cell1"><img class="profile" src="../profileImg/darknight.jpg"></div>
			<div class="gap1" ><div class="infotextgap1">강	한	결</div></div>
			<div class="cell1"><img class="profile" src="../profileImg/bob.jpg"></div>
			<div class="gap1"><div class="infotextgap1"></div></div>
		</div>
		
		<div class="column2">
			<div class="gap2"><div class="infotextgap2">직	함: 조	장	개	발	자</div></div>
			<div class="cell2"><div class="infotext">
			<a>모든 일에는 때가 있고 그 때는 바로 지금입니다.</a><br><br>
			<a>이번에 새롭게 프로젝트를 진행함에 있어서 많은 어려움이 있었지만 한단계 더 성장하는 모습을 보며 
			배움에는 끝이 없고 해야 할 일은 많다고 느꼈습니다.</a><br><br>
			<a>프로젝트를 통해서 공동으로 작업하는 부분에 있어서 사람간에 관계가 굉장히 중요하다고 느꼈으며,</a><br>
			<a>한달이라는 짧은 기간동안 서로 부족한 부분을 채워주며 프로젝트를 진행하였습니다.</a><br><br>
			<a>기초가 튼튼한 건물은 쉽게 무너지지 않듯이 기초가 튼튼한 개발자가 되기 위해서 오늘도 더 배우려</a><br><a>노력하겠습니다.</a>
			</div></div>
			<div class="gap2" ><div class="infotextgap2">직	함: 개	발	자</div></div>
			<div class="cell2"><div class="infotext"><br>
			<a>호머 심슨과 같은(?) 열정을 가지고 열심히 코딩하는 병아리 프로그래머 이영기 입니다.</a><br><br>
			<a>처음 시작은 호기심이었는데, 적성에 꽤 잘맞아 재미있게 하고 있습니다.</a><br><br>
			<a>이 프로젝트를 무사히 완수할 수 있게 되어 굉장히 기쁨니다.</a><br><br>
			<a>지금은 병아리지만 매같은 프로그래머로 성장하기 위해 넓은 지식을 깊게 탐구하겠습니다.</a>
			</div></div>
			<div class="gap2" ><div class="infotextgap2">직	함:	개	발	자</div></div>
			<div class="cell2"><div class="infotext"><br>
				<a>늦은나이지만 적성을 찾아 웹 프로그래머 문에 들어섰습니다.</a><br><br>
				<a>일할때 2~3시간씩 시간가는줄 모르게 몰입해서 하는것을 좋아합니다.</a><br><br>
				<a>이러한 몰입으로 클라이언트가 원하는 결과물을 만들어내는 프로그래머가 되겠습니다.</a></div></div>
			<div class="gap2" ><div class="infotextgap2">직	함:	개	발	자</div></div>
			<div class="cell2"><div class="infotext"><br>
				<a>['역지사지(易地思之)'를 이정표 삼아 항상 주위 사람들의 형편을 살펴 깊이 이해할 수 있는 관계지향적인</a><br><a>사람이 되자!]</a><br><br>
				<a>스펀지밥과 같은 유머는 비록 (많이) 부족하지만, 어디에서든 스펀지밥과 같이 화기애애한 분위기를 만들고자 노력하는 소통의 아이콘이 되고 싶은 늅늅 개발자(지망생)입니다.</a><br><br>
				<a>학원 내 최고의 팀과 함께할 수 있어서 정말 감사하고 행복했습니다. 국산 팀 파이팅 부트스트랩처럼 취업도 뿌수자!</a></div></div>
			<div class="gap2" ><div class="infotextgap2"></div></div>
		</div>
	
	</div>
	<footer>
	<div style="background-color: #f1f1f1; padding: 40px;">
		<p style="text-align: center; color: rgb(116, 116, 116); font-family: 'Montserrat', sans-serif;">© Copyright 2019 KooKSan - All rights reserved.</p>
	</div>
	</footer>
</body>
<script>
var slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("dot");
  if (n > slides.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";  
  }
  for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " active";
}
</script>
</html>