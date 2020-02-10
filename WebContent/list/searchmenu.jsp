<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="usedcar.shopping.CarListDBBean"%>
<%@page import="usedcar.shopping.CarListDataBean"%>

<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	final String[] carType = {"경차", "소형차", "준중형차", "중형차", "대형차", "스포츠카", "SUV", "RV", "경승합차", "승합차", "화물차",
			"기타"};
	final String[] carBrand = {"현대", "기아", "제네시스", "쉐보레", "삼성", "쌍용"};
	final String[] carModel_hyundai = {"i30", "i40", "갤로퍼", "그라나다", "그랜저", "그레이스", "넥쏘", "다이너스티", "라비타", "마르샤",
			"맥스크루즈", "베뉴", "베라크루즈", "베르나", "벨로스터", "블루온", "산타모", "스쿠프", "스타렉스", "스텔라", "산타페", "쏘나타", "쏠라티",
			"아반떼", "아슬란", "아이오닉", "아토스", "에쿠스", "엑센트", "엑셀", "엘란트라", "제네시스", "코나", "코티나", "클릭", "테라칸", "투스카니",
			"투싼", "트라제XG", "티뷰론", "펠리세이드", "포니", "프레스토"};
	final String[] carModel_kia = {"K3", "K5", "K7", "K9", "X-TREK", "니로", "델타", "레이", "레토나", "로체", "록스타", "리갈",
			"리오", "모닝", "모하비", "베스타", "봉고III 미니버스", "브리샤", "비스토", "세피아", "셀토스", "슈마", "스토닉", "스팅어", "스펙트라",
			"스포티지", "쎄라토", "쏘렌토", "쏘울", "아벨라", "엔터프라이즈", "엘란", "오피러스", "옵티마", "카니발", "카렌스", "카스타", "캐피탈", "콩코드",
			"크레도스", "타우너", "토픽", "파크타운", "포르테", "포텐샤", "프라이드", "프레지오", "피아트132"};
	final String[] carModel_genesis = {"G70", "G80", "G90", "EQ900"};
	final String[] carModel_chevrolet = {"G2X", "넥시아", "누비라", "다마스", "라노스", "라보", "라세티", "레간자", "레조", "로얄살롱",
			"르망", "마티즈", "말리부", "매그너스", "맵시", "베리타스", "볼트EV", "볼트(volt)", "브로엄", "슈퍼살롱", "스테이츠맨", "스파크", "씨에로",
			"아베오", "아카디아", "알페온", "에스페로", "올란도", "윈스톰", "이쿼녹스", "임팔라", "임페리얼", "젠트라", "카마로", "칼로스", "캡티바",
			"콜로라도", "콜벳", "크루즈", "토스카", "트래버스", "트랙스", "티코", "프린스"};
	final String[] carModel_samsung = {"SM3", "SM5", "SM6", "SM7", "QM3", "QM5", "QM6", "마스터", "클리오", "트위지"};
	final String[] carModel_ssangyong = {"뉴훼미리", "렉스턴", "로디우스", "무쏘", "액티언", "이스타나", "체어맨", "칼리스타", "카이런",
			"코란도", "티볼리"};
	final String[] carMileage = {"lt20000", "gt20000lt40000", "gt40000lt60000", "gt60000lt80000",
			"gt80000lt100000", "gt100000"};
	final String[] carPrice = {"lt500", "gt500lt1000", "gt1000lt1500", "gt1500lt2000", "gt2000lt2500",
			"gt2500lt3000", "gt3000lt3500", "gt3500lt4000", "gt4000lt4500", "gt4500lt5000", "gt5000"};
	final String[] carLocation = {"서울", "경기", "인천", "대전", "세종", "충남", "충북", "강원", "부산", "대구", "울산", "경남", "경북",
			"광주", "전남", "전북", "제주"};
	final String[] carColor = {"검정색", "흰색", "갈대색", "청색", "빨간색", "검정투톤", "진주색", "연금색", "하늘색", "주황색", "쥐색",
			"흰색투톤", "갈색", "담녹색", "자주색", "은색", "진주투톤", "갈색투톤", "녹색", "보라색", "은회색", "은하색", "금색", "연두색", "분홍색",
			"은색투톤", "명은색", "금색투톤", "청옥색", "노란색"};
	final String[] carOilType = {"가솔린", "디젤", "LPG", "가솔린+전기", "LPG+전기", "가솔린+LPG", "가솔린+CNG", "전기", "수소"};
	final String[] carGear = {"오토", "수동", "세미오토", "CVT", "기타"};
	final String[] carOption = {"sunroof", "navigation", "smartkey", "HID", "camera_behind", "leatherseat",
			"airbag_assistantseat", "airbag_side"};
	int[] carType_cnt = new int[carType.length];
	int[] carBrand_cnt = new int[carBrand.length];
	int[] carModel_cnt_hyundai = new int[carModel_hyundai.length];
	int[] carModel_cnt_kia = new int[carModel_kia.length];
	int[] carModel_cnt_genesis = new int[carModel_genesis.length];
	int[] carModel_cnt_chevrolet = new int[carModel_chevrolet.length];
	int[] carModel_cnt_samsung = new int[carModel_samsung.length];
	int[] carModel_cnt_ssangyong = new int[carModel_ssangyong.length];
	int[] carMileage_cnt = new int[carMileage.length];
	int[] carPrice_cnt = new int[carPrice.length];
	int[] carLocation_cnt = new int[carLocation.length];
	int[] carColor_cnt = new int[carColor.length];
	int[] carOilType_cnt = new int[carOilType.length];
	int[] carGear_cnt = new int[carGear.length];
	int[] carOption_cnt = new int[carOption.length];

	CarListDataBean car = null;
	CarListDBBean carlist = CarListDBBean.getInstance();

	int selectAllCar = carlist.getcarListCount();
	for (int i = 0; i < carType.length; i++) {
		carType_cnt[i] = carlist.getcarListCount("car_type", carType[i]);
	}
	for (int i = 0; i < carBrand.length; i++) {
		carBrand_cnt[i] = carlist.getcarListCount("car_brand", carBrand[i]);
	}
	for (int i = 0; i < carModel_hyundai.length; i++) {
		carModel_cnt_hyundai[i] = carlist.getcarListCount("car_model", carModel_hyundai[i]);
	}
	for (int i = 0; i < carModel_kia.length; i++) {
		carModel_cnt_kia[i] = carlist.getcarListCount("car_model", carModel_kia[i]);
	}
	for (int i = 0; i < carModel_genesis.length; i++) {
		carModel_cnt_genesis[i] = carlist.getcarListCount("car_model", carModel_genesis[i]);
	}
	for (int i = 0; i < carModel_chevrolet.length; i++) {
		carModel_cnt_chevrolet[i] = carlist.getcarListCount("car_model", carModel_chevrolet[i]);
	}
	for (int i = 0; i < carModel_samsung.length; i++) {
		carModel_cnt_samsung[i] = carlist.getcarListCount("car_model", carModel_samsung[i]);
	}
	for (int i = 0; i < carModel_ssangyong.length; i++) {
		carModel_cnt_ssangyong[i] = carlist.getcarListCount("car_model", carModel_ssangyong[i]);
	}
	for (int i = 0; i < carMileage.length; i++) {
		if (carMileage[i].contains("lt") && carMileage[i].contains("gt")) {
			int minValue = Integer.parseInt(
					carMileage[i].substring(carMileage[i].indexOf("g") + 2, carMileage[i].indexOf("l")));
			int maxValue = Integer
					.parseInt(carMileage[i].substring(carMileage[i].indexOf("l") + 2, carMileage[i].length()));
			carMileage_cnt[i] = carlist.getcarListCount("car_mileage", minValue, maxValue);
		} else if (carMileage[i].contains("lt")) {
			int maxValue = Integer
					.parseInt(carMileage[i].substring(carMileage[i].indexOf("l") + 2, carMileage[i].length()));
			carMileage_cnt[i] = carlist.getcarListCount("car_mileage", 0, maxValue);
		} else if (carMileage[i].contains("gt")) {
			int minValue = Integer
					.parseInt(carMileage[i].substring(carMileage[i].indexOf("g") + 2, carMileage[i].length()));
			carMileage_cnt[i] = carlist.getcarListCount("car_mileage", minValue, 0);
		}

	}
	for (int i = 0; i < carPrice.length; i++) {
		if (carPrice[i].contains("lt") && carPrice[i].contains("gt")) {
			int minValue = Integer
					.parseInt(carPrice[i].substring(carPrice[i].indexOf("g") + 2, carPrice[i].indexOf("l")));
			int maxValue = Integer
					.parseInt(carPrice[i].substring(carPrice[i].indexOf("l") + 2, carPrice[i].length()));
			carPrice_cnt[i] = carlist.getcarListCount("car_price", minValue, maxValue);
		} else if (carPrice[i].contains("lt")) {
			int maxValue = Integer
					.parseInt(carPrice[i].substring(carPrice[i].indexOf("l") + 2, carPrice[i].length()));
			carPrice_cnt[i] = carlist.getcarListCount("car_price", 0, maxValue);
		} else if (carPrice[i].contains("gt")) {
			int minValue = Integer
					.parseInt(carPrice[i].substring(carPrice[i].indexOf("g") + 2, carPrice[i].length()));
			carPrice_cnt[i] = carlist.getcarListCount("car_price", minValue, 0);
		}
	}
	for (int i = 0; i < carLocation.length; i++) {
		carLocation_cnt[i] = carlist.getcarListCount("car_location", carLocation[i]);
	}
	for (int i = 0; i < carColor.length; i++) {
		carColor_cnt[i] = carlist.getcarListCount("car_color", carColor[i]);
	}
	for (int i = 0; i < carOilType.length; i++) {
		carOilType_cnt[i] = carlist.getcarListCount("car_oilType", carOilType[i]);
	}
	for (int i = 0; i < carGear.length; i++) {
		carGear_cnt[i] = carlist.getcarListCount("car_gear", carGear[i]);
	}
	for (int i = 0; i < carOption.length; i++) {
		carOption_cnt[i] = carlist.getcarListCount("car_option", carOption[i]);
	}
%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="Content-Language" content="ko">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="../stylesheet/top.css">
	<link rel="stylesheet" href="../stylesheet/footer.css">
	<link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	<script src='https://kit.fontawesome.com/a076d05399.js'></script>
	<style>
		* {
			font-family: 'montserrat', sans-serif;
		}

		.manufacture:hover {
			color: red;
		}

		.manufacture {
			color: black;
		}

		.hidden {
			display: none;
		}

		.popover {
			max-width: 700px;
			margin-left: 150px;
			box-shadow: 5px 5px 5px gray;
		}

		.bxColor {
			border: 1px solid gray;
			font-size: large;
		}

		.bxSelect {
			border: 2px solid red !important;
		}

		.count {
			float: right;
		}

		.table td,
		.table th {
			padding: 0.25rem;
		}

		th {
			background-color: gainsboro;
			border: 1px solid gray;
		}

		td {
			border: 1px solid gray;
			vertical-align: top;
		}

		.table-borderless {
			max-width: 1000px;
			width: 100%;
		}

		.optList {
			font-size: 12px;
		}
		.namepart,
		.bxColor,
		.fas {cursor: pointer;}
	</style>
</head>

<body style="width: 1550;" onload=initConditionSearch() >
	<!-- 상단 메뉴바 들어올 곳 -->
	<header id="main-header" style="min-width: 1200px; max-width: 100%;">
		<jsp:include page="../module/top.jsp" flush="false" />
	</header>
	<br>
	<div class="main_container" style="width: 1550px; float: left;">
		<div class="container" style="width: 300px; display: inline-block; vertical-align: top; float: left;">
			<!-- 제목(선택초기화/최근검색조건) -->
			<div class="accordion">
				<div class="card" style="overflow: visible;">
					<div style="margin: 10px;">
						<span style="color: tomato; font-weight: bold; float: left;">국산차</span>
						<span
							style="font-weight: bold; font-size: 14px; float: right;"><span><%=selectAllCar%></span>대</span>
					</div>
					<div style="font-size: 13px; margin-bottom: 10px;">
						<a id="initialchoice" style="margin-left: 10px; display: inline-block; cursor: pointer;"
							onclick=initchoice()><span><i class="fas fa-undo-alt"></i>선택초기화</span></span></a>&emsp;	
						<a id="recentSearch" style="display: inline-block; cursor: pointer;" onclick=recentWindowShow()><span><i
								class="fas fa-search"></i>최근 검색 조건</span></span></a>
					<div class="popover fade bs-popover-right" role="tooltip" id="recentSearchWindow"
						style="position: absolute; transform: translate3d(140px, 0px, 0px); top: 23px; left: 0px; will-change: transform;"
						x-placement="right">
						<div class="arrow" style="top: 20px;"></div>
						<div class="popover-body" style="width: 500px;">
							<div>
								<span style="float:left; font-weight: bold; font-size: 16px;">최근 검색 조건</span><i
									class="fas fa-times" style="float:right; margin-left: 0px;"
									onclick=recentWindowShow()></i><br>
							</div>
							<hr style="margin-top:5px; margin-bottom:5px;">
							<div id="searchContents"></div>
							<hr style="margin-top:5px; margin-bottom:5px;">
							<div style="color: red; font-size: 12px;">검색 내용은 최대 5개까지 저장됩니다.</div>
						</div>
					</div>
					</div>
				</div>
			</div>
			<!--선택 초기화 및 최근 검색 조건 함수-->
			<script>
				//+최근 검색기록 보기시 확장 윈도우 표시/숨김
				var recentSearchWindow = document.getElementById('recentSearchWindow');
				function recentWindowShow() {
					if (recentSearchWindow.className == 'popover fade bs-popover-right show') {
						recentSearchWindow.className = 'popover fade bs-popover-right';
					} else if (recentSearchWindow.className == 'popover fade bs-popover-right') {
						recentSearchWindow.className = 'popover fade bs-popover-right show'
					}
				};
				//선택 초기화 
				function initchoice() {
					var checkBox = document.getElementsByTagName('input');
					for (var i = 0; i < checkBox.length; i++) {
						checkBox[i].checked = false;
					}
					//브랜드 모델 CC 초기화
					var car = document.getElementsByClassName('fa-times-circle');
					backstep(car[0]);
					var selectOpt = document.getElementsByTagName('option');
					for (var i = 0; i < selectOpt.length; i++) {
						if (selectOpt[i].innerHTML == "년" || selectOpt[i].innerHTML == "월" || selectOpt[i].innerHTML == "Km" ||
							selectOpt[i].innerHTML == "선택" || selectOpt[i].innerHTML == "시/도" || selectOpt[i].innerHTML == "구/군") {
							selectOpt[i].selected = true;
						} else {
							selectOpt[i].selected = false;
						}
					}
					//칼라 초기화
					var selectColor = document.getElementsByClassName('bxColor');
					for (var i = 0; i < selectColor.length; i++) {
						selectColor[i].className = "bxColor";
					}
					selectCondition();
				}
				//최근 검색조건 추가 함수
				function addRecentSearch(listQuery){
					var brand = "";
					var model = "";
					var condition = listQuery.substr(9, listQuery.length);
					condition = condition.split('&');
					for(var i=0; i<condition.length; i++){
						condition[i] = condition[i].split('=');
						if(condition[i][0]=='car_brand'){
							brand = condition[i][1];
						}else if(condition[i][0]=='car_model'){
							model = condition[i][1];
						}
					}
					//쿼리에서 브랜드와 모델명 뽑아내기 끝
					//box에 추가할 node 생성 
					var row = document.createElement('div');
					row.className = "recentSearchElem";
					row.listQuery = listQuery;
					var element = document.getElementsByClassName('recentSearchElem');
					if(element.length>=5){
						row.id = 5;
					}else{
						row.id = element.length;
					}
					var namepart = document.createElement('div');
					namepart.style = "font-weight:bold; width:150px; display:inline-block;"
					namepart.className = "namepart";
					namepart.innerHTML = brand+" | "+model;
					namepart.onclick = function(){
						var iframe = document.getElementsByTagName('iframe');
						iframe[0].src = event.srcElement.parentElement.listQuery;
						
					};
					var deleteIcon = document.createElement('i');
					deleteIcon.className = "fas fa-times";
					deleteIcon.style = "color:red;margin-left:315px";
					var searchContent = document.getElementById('searchContents');
					deleteIcon.onclick = function(){
						searchContent.removeChild(event.srcElement.parentElement);
					};
					row.appendChild(namepart);
					row.appendChild(deleteIcon);
					if(element.length<5){
						searchContent.appendChild(row);
					}else{
						searchContent.removeChild(element[0]);
						searchContent.appendChild(row);
					}
				}
			</script>

			<div id="accordion">
				<!-- 차종 -->
				<div class="card">
					<div class="card-header" style="border: 0px; border-radius: 0px; background-color: white;">
						<a id="anchor1" class="collapsed card-link" data-toggle="collapse" href='#collapseOne'
							style="display: block; color: black;"> <span
								style="font-weight: bold; float: left;">차종</span> <i id="angle1"
								class="fas fa-angle-down" style="color: gray; float: right; margin-top: 5px;"></i>
						</a>
					</div>
					<div id="collapseOne" class="collapse" data-parent="" style="border: 0px;">
						<div class="card-body" style="font-size: 14px;">
							<span style="float: left;"><input type="checkbox" value="경차" name="car_type"
									onchange=selectCondition() /><span>경차</span></span>
							<span style="float: right;"><span><%=carType_cnt[0]%></span></span><br>
							<span style="float: left;"><input type="checkbox" value="소형차" name="car_type"
									onchange=selectCondition() /><span>소형차</span></span>
							<span style="float: right;"><span><%=carType_cnt[1]%></span></span><br>
							<span style="float: left;"><input type="checkbox" value="준중형차" name="car_type"
									onchange=selectCondition() /><span>준중형차</span></span>
							<span style="float: right;"><span><%=carType_cnt[2]%></span></span><br>
							<span style="float: left;"><input type="checkbox" value="중형차" name="car_type"
									onchange=selectCondition() /><span>중형차</span></span>
							<span style="float: right;"><span><%=carType_cnt[3]%></span></span><br>
							<span style="float: left;"><input type="checkbox" value="대형차" name="car_type"
									onchange=selectCondition() /><span>대형차</span></span>
							<span style="float: right;"><span><%=carType_cnt[4]%></span></span><br>
							<span style="float: left;"><input type="checkbox" value="스포츠카" name="car_type"
									onchange=selectCondition() /><span>스포츠카</span></span>
							<span style="float: right;"><span><%=carType_cnt[5]%></span></span><br>
							<hr style="width: 225px; margin: 10px; margin-left: 0px; border: 1px dashed gray">
							<span style="float: left;"><input type="checkbox" value="SUV" name="car_type"
									onchange=selectCondition() /><span style="margin-left: 2px;">SUV</span></span> <span
								style="float: right;"><span><%=carType_cnt[6]%></span></span><br>
							<span style="float: left;"><input type="checkbox" value="RV" name="car_type"
									onchange=selectCondition() /><span>RV</span></span>
							<span style="float: right;"><span><%=carType_cnt[7]%></span></span><br>
							<hr style="width: 225px; margin: 10px; margin-left: 0px; border: 1px dashed gray">
							<span style="float: left;"><input type="checkbox" value="경승합차" name="car_type"
									onchange=selectCondition() /><span>경승합차</span></span>
							<span style="float: right;"><span><%=carType_cnt[8]%></span></span><br>
							<span style="float: left;"><input type="checkbox" value="승합차" name="car_type"
									onchange=selectCondition() /><span>승합차</span></span>
							<span style="float: right;"><span><%=carType_cnt[9]%></span></span><br>
							<span style="float: left;"><input type="checkbox" value="화물차" name="car_type"
									onchange=selectCondition() /><span>화물차</span></span>
							<span style="float: right;"><span><%=carType_cnt[10]%></span></span><br>
							<span style="float: left;"><input type="checkbox" value="기타" name="car_type"
									onchange=selectCondition() /><span>기타</span></span>
							<span style="float: right;"><span><%=carType_cnt[11]%></span></span><br>
						</div>
					</div>
				</div>
				<!--차종 스크립트-->
				<script>
					// 클릭시 메뉴화살표 방향 변경
					var anchor1 = document.getElementById('anchor1');
					var angle1 = document.getElementById('angle1');
					anchor1.onclick = function () {
						if (angle1.className == 'fas fa-angle-down') {
							angle1.className = 'fas fa-angle-up';
						} else if (angle1.className == 'fas fa-angle-up') {
							angle1.className = 'fas fa-angle-down';
						}
					};
				</script>

				<!-- 제조사/모델/등급 -->
				<div class="card">
					<div class="card-header" style="border: 0px; border-radius: 0px; background-color: white;">
						<a id="anchor2" class="collapsed" style="display: block; color: black; width: 230px"> <span
								style="font-weight: bold;">제조사/모델/배기량</span> <i id="angle2" class="fas fa-angle-down"
								style="color: gray; visibility: hidden; margin-top: 5px;"></i>
						</a>
					</div>
					<div id="collapseTwo" class="" style="border: 0px; background-color: #ffe6cc;">
						<div class="card-body" style="font-size: 14px;">
							<div id="manufacturerList">
								<a style="float: left;" href="#manufacturerList" class="manufacture" title="현대"
									name="car_brand" onclick='firstlist(this);'>현대</a><span
									style="float: right;"><span><%=carBrand_cnt[0]%></span></span><br>
								<a style="float: left;" href="#manufacturerList" class="manufacture" title="기아"
									name="car_brand" onclick=firstlist(this)>기아</a> <span
									style="float: right;"><span><%=carBrand_cnt[1]%></span></span><br>
								<a style="float: left;" href="#manufacturerList" class="manufacture" title="제네시스"
									name="car_brand" onclick=firstlist(this)>제네시스</a> <span
									style="float: right;"><span><%=carBrand_cnt[2]%></span></span><br>
								<a style="float: left;" href="#manufacturerList" class="manufacture" title="쉐보레"
									name="car_brand" onclick=firstlist(this)>쉐보레</a> <span
									style="float: right;"><span><%=carBrand_cnt[3]%></span></span><br>
								<a style="float: left;" href="#manufacturerList" class="manufacture" title="르노삼성"
									name="car_brand" onclick=firstlist(this)>르노삼성</a> <span
									style="float: right;"><span><%=carBrand_cnt[4]%></span></span><br>
								<a style="float: left;" href="#manufacturerList" class="manufacture" title="쌍용"
									name="car_brand" onclick=firstlist(this)>쌍용</a> <span
									style="float: right;"><span><%=carBrand_cnt[5]%></span></span><br>
							</div>
							<div id="firstStep" class="hidden">
								<span class="fas fa-minus" style="float: left; color: orange; margin-top: 3px;"></span>
								<span id="firstTitle" style="float: left; margin-left: 5px;"></span>
								<span class="fas fa-times-circle" id="firstX" style="float: right; color: orange"
									onclick=backstep(this)></span><br>
							</div>
							<div id="secondStep" class="hidden">
								<span class="fas fa-minus"
									style="float: left; color: orange; margin-left: 15px; margin-top: 3px;"></span>
								<span id="secondTitle" style="float: left; margin-left: 5px;"></span>
								<span class="fas fa-times-circle" id="secondX" style="float: right; color: orange"
									onclick=backstep(this)></span><br>
							</div>
							<div id="firstList" class="hidden" style="margin-left: 20px;">
							</div>
							<div id="secondList" class="hidden" style="margin-left: 25px;">
							</div>
							<input type="hidden" id="car_cc" value="">
						</div>
					</div>
				</div>
				<!--제조사/모델/등급 스크립트-->
				<script>
					//제조사별 carlist 선언
					var hyundaicarlist = ["i30", "i40", "갤로퍼", "그라나다", "그랜저", "그레이스", "넥쏘", "다이너스티", "라비타", "마르샤",
						"맥스크루즈", "베뉴", "베라크루즈", "베르나", "벨로스터", "블루온", "산타모", "스쿠프", "스타렉스", "스텔라", "산타페", "쏘나타",
						"쏠라티", "아반떼", "아슬란", "아이오닉", "아토스", "에쿠스", "엑센트", "엑셀", "엘란트라", "제네시스", "코나", "코티나", "클릭", "테라칸",
						"투스카니", "투싼", "트라제XG", "티뷰론", "펠리세이드", "포니", "프레스토"];
					var hyundaicarcnt = [<%=carModel_cnt_hyundai[0] %><%for (int i = 1; i < carModel_cnt_hyundai.length; i++) {%>,<%=carModel_cnt_hyundai[i] %><%}%>];
					var kiacarlist = ["K3", "K5", "K7", "K9", "X-TREK", "니로", "델타", "레이", "레토나", "로체", "록스타", "리갈", "리오", "모닝", "모하비", "베스타",
						"봉고III 미니버스", "브리샤", "비스토", "세피아", "셀토스", "슈마", "스토닉", "스팅어", "스펙트라", "스포티지", "쎄라토", "쏘렌토", "쏘울",
						"아벨라", "엔터프라이즈", "엘란", "오피러스", "옵티마", "카니발", "카렌스", "카스타", "캐피탈", "콩코드", "크레도스", "타우너", "토픽", "파크타운",
						"포르테", "포텐샤", "프라이드", "프레지오", "피아트132"];
					var kiacarcnt = [<%=carModel_cnt_kia[0] %><%for (int i = 1; i < carModel_cnt_kia.length; i++) {%>,<%=carModel_cnt_kia[i] %><%}%>];
					var genesiscarlist = ["G70", "G80", "G90", "EQ900"];
					var genesiscarcnt = [<%=carModel_cnt_genesis[0] %><%for (int i = 1; i < carModel_cnt_genesis.length; i++) {%>,<%=carModel_cnt_genesis[i] %><%}%>];
					var chevroletcarlist = ["G2X", "넥시아", "누비라", "다마스", "라노스", "라보", "라세티", "레간자", "레조", "로얄살롱", "르망", "마티즈", "말리부", "매그너스",
						"맵시", "베리타스", "볼트EV", "볼트(volt)", "브로엄", "슈퍼살롱", "스테이츠맨", "스파크", "씨에로", "아베오", "아카디아", "알페온", "에스페로",
						"올란도", "윈스톰", "이쿼녹스", "임팔라", "임페리얼", "젠트라", "카마로", "칼로스", "캡티바", "콜로라도", "콜벳", "크루즈", "토스카", "트래버스", "트랙스",
						"티코", "프린스"];
					var chevroletcarcnt = [<%=carModel_cnt_chevrolet[0] %><%for (int i = 1; i < carModel_cnt_chevrolet.length; i++) {%>,<%=carModel_cnt_chevrolet[i] %><%}%>];
					var samsungcarlist = ["SM3", "SM5", "SM6", "SM7", "QM3", "QM5", "QM6", "마스터", "클리오", "트위지"];
					var samsungcarcnt = [<%=carModel_cnt_samsung[0] %><%for (int i = 1; i < carModel_cnt_samsung.length; i++) {%>,<%=carModel_cnt_samsung[i] %><%}%>];
					var ssangyongcarlist = ["뉴훼미리", "렉스턴", "로디우스", "무쏘", "액티언", "이스타나", "체어맨", "칼리스타", "카이런", "코란도", "티볼리"];
					var ssangyongcarcnt = [<%=carModel_cnt_ssangyong[0] %><%for (int i = 1; i < carModel_cnt_ssangyong.length; i++) {%>,<%=carModel_cnt_ssangyong[i] %><%}%>];

					// first 및 second 리스트 생성
					function createfirstlist(obj) {
						selectCondition();
						if (obj.title == '현대') {
							var cnt = 0;
							for (var car of hyundaicarlist) {
								var anchor = document.createElement('a');
								anchor.className = "manufacture";
								anchor.name = "car_model";
								anchor.style = "float:left;";
								anchor.href = "#manufacturerList";
								anchor.innerHTML = car;
								anchor.title = car;
								//두번째 계층 click 함수
								anchor.onclick = function () {
									var secondTitle = document.getElementById('secondTitle');
									secondTitle.innerHTML = this.innerHTML;
									var firstList = document.getElementById('firstList');
									firstList.className = "hidden";
									var secondStep = document.getElementById('secondStep');
									secondStep.className = "";
									var secondList = document.getElementById('secondList');
									secondList.className = "";
									//secondlist 배기량 목록 생성함수
									//ajax로 모델과 배기량 조건을 만족하는 상품 수 확인
									for (var i = 1000; i <= 13000; i = i + 2000) {
										var xhttp = new XMLHttpRequest();
										xhttp.onreadystatechange = function () {
											if (this.readyState == 4 && this.status == 200) {
												var anchor = document.createElement('a');
												anchor.className = "manufacture";
												anchor.style = "float:left;";
												anchor.title = i + "," + (i + 2000);
												anchor.href = "#";
												anchor.name = "car_cc";
												anchor.onclick = selectCondition;
												var span1 = document.createElement('span');
												span1.style = "float:right;";
												var span2 = document.createElement('span');
												var text = this.responseText.trim();
												var textSplit = text.split("|");
												for (var j = 0; j < textSplit.length; j++) {
													var valueSplit = textSplit[j].split(":");
													if (j == 0) {
														anchor.innerHTML += valueSplit[1] + "~";
													} else if (j == 1) {
														anchor.innerHTML += valueSplit[1] + "cc";
													} else if (j == 2) {
														span2.innerHTML = valueSplit[1];
													}
												}
												span1.appendChild(span2);
												var secondList = document.getElementById('secondList');
												secondList.appendChild(anchor);
												secondList.appendChild(span1);
												var br = document.createElement('br');
												secondList.appendChild(br);
											}
										};
										xhttp.open("POST", "cc_cntSearch.jsp?model=" + this.title + "&cc=gt" + i + "lt" + (i + 2000), false);
										xhttp.send();
										//=============================================
									}
									selectCondition();
								}
								var span1 = document.createElement('span');
								span1.style = "float:right;";
								var span2 = document.createElement('span');
								span2.innerHTML = hyundaicarcnt[cnt];
								span1.appendChild(span2);
								var firstList = document.getElementById('firstList');
								firstList.appendChild(anchor);
								firstList.appendChild(span1);
								var br = document.createElement('br');
								firstList.appendChild(br);
								cnt++;
							}
						} else if (obj.title == '기아') {
							var cnt = 0;
							for (var car of kiacarlist) {
								var anchor = document.createElement('a');
								anchor.className = "manufacture";
								anchor.name = "car_model";
								anchor.style = "float:left;";
								anchor.href = "#manufacturerList";
								anchor.innerHTML = car;
								anchor.title = car;
								//두번째 계층 click 함수
								anchor.onclick = function () {
									var secondTitle = document.getElementById('secondTitle');
									secondTitle.innerHTML = this.innerHTML;
									var firstList = document.getElementById('firstList');
									firstList.className = "hidden";
									var secondStep = document.getElementById('secondStep');
									secondStep.className = "";
									var secondList = document.getElementById('secondList');
									secondList.className = "";
									//secondlist 배기량 목록 생성함수
									//ajax로 모델과 배기량 조건을 만족하는 상품 수 확인
									for (var i = 1000; i <= 13000; i = i + 2000) {
										var xhttp = new XMLHttpRequest();
										xhttp.onreadystatechange = function () {
											if (this.readyState == 4 && this.status == 200) {
												var anchor = document.createElement('a');
												anchor.className = "manufacture";
												anchor.style = "float:left;";
												anchor.name = "car_cc";
												anchor.title = i + "," + (i + 2000);
												anchor.href = "#";
												anchor.onclick = selectCondition;
												var span1 = document.createElement('span');
												span1.style = "float:right;";
												var span2 = document.createElement('span');
												var text = this.responseText.trim();
												var textSplit = text.split("|");
												for (var j = 0; j < textSplit.length; j++) {
													var valueSplit = textSplit[j].split(":");
													if (j == 0) {
														anchor.innerHTML += valueSplit[1] + "~";
													} else if (j == 1) {
														anchor.innerHTML += valueSplit[1] + "cc";
													} else if (j == 2) {
														span2.innerHTML = valueSplit[1];
													}
												}
												span1.appendChild(span2);
												var secondList = document.getElementById('secondList');
												secondList.appendChild(anchor);
												secondList.appendChild(span1);
												var br = document.createElement('br');
												secondList.appendChild(br);
											}
										};
										xhttp.open("POST", "cc_cntSearch.jsp?model=" + this.title + "&cc=gt" + i + "lt" + (i + 2000), false);
										xhttp.send();
										//=============================================
									}
									selectCondition();
								}
								var span1 = document.createElement('span');
								span1.style = "float:right;";
								var span2 = document.createElement('span');
								span2.innerHTML = kiacarcnt[cnt];
								span1.appendChild(span2);
								var firstList = document.getElementById('firstList');
								firstList.appendChild(anchor);
								firstList.appendChild(span1);
								var br = document.createElement('br');
								firstList.appendChild(br);
								cnt++;
							}
						} else if (obj.title == '제네시스') {
							var cnt = 0;
							for (var car of genesiscarlist) {
								var anchor = document.createElement('a');
								anchor.className = "manufacture";
								anchor.name = "car_model";
								anchor.style = "float:left;";
								anchor.href = "#manufacturerList";
								anchor.innerHTML = car;
								anchor.title = car;
								//두번째 계층 click 함수
								anchor.onclick = function () {
									var secondTitle = document.getElementById('secondTitle');
									secondTitle.innerHTML = this.innerHTML;
									var firstList = document.getElementById('firstList');
									firstList.className = "hidden";
									var secondStep = document.getElementById('secondStep');
									secondStep.className = "";
									var secondList = document.getElementById('secondList');
									secondList.className = "";
									//secondlist 배기량 목록 생성함수
									//ajax로 모델과 배기량 조건을 만족하는 상품 수 확인
									for (var i = 1000; i <= 13000; i = i + 2000) {
										var xhttp = new XMLHttpRequest();
										xhttp.onreadystatechange = function () {
											if (this.readyState == 4 && this.status == 200) {
												var anchor = document.createElement('a');
												anchor.className = "manufacture";
												anchor.style = "float:left;";
												anchor.title = i + "," + (i + 2000);
												anchor.href = "#";
												anchor.name = "car_cc";
												anchor.onclick = selectCondition;
												var span1 = document.createElement('span');
												span1.style = "float:right;";
												var span2 = document.createElement('span');
												var text = this.responseText.trim();
												var textSplit = text.split("|");
												for (var j = 0; j < textSplit.length; j++) {
													var valueSplit = textSplit[j].split(":");
													if (j == 0) {
														anchor.innerHTML += valueSplit[1] + "~";
													} else if (j == 1) {
														anchor.innerHTML += valueSplit[1] + "cc";
													} else if (j == 2) {
														span2.innerHTML = valueSplit[1];
													}
												}
												span1.appendChild(span2);
												var secondList = document.getElementById('secondList');
												secondList.appendChild(anchor);
												secondList.appendChild(span1);
												var br = document.createElement('br');
												secondList.appendChild(br);
											}
										};
										xhttp.open("POST", "cc_cntSearch.jsp?model=" + this.title + "&cc=gt" + i + "lt" + (i + 2000), false);
										xhttp.send();
										//=============================================
									}
									selectCondition();
								}
								var span1 = document.createElement('span');
								span1.style = "float:right;";
								var span2 = document.createElement('span');
								span2.innerHTML = genesiscarcnt[cnt];
								span1.appendChild(span2);
								var firstList = document.getElementById('firstList');
								firstList.appendChild(anchor);
								firstList.appendChild(span1);
								var br = document.createElement('br');
								firstList.appendChild(br);
								cnt++;
							}
						} else if (obj.title == '쉐보레') {
							var cnt = 0;
							for (var car of chevroletcarlist) {
								var anchor = document.createElement('a');
								anchor.className = "manufacture";
								anchor.name = "car_model";
								anchor.style = "float:left;";
								anchor.href = "#manufacturerList";
								anchor.innerHTML = car;
								anchor.title = car;
								//두번째 계층 click 함수
								anchor.onclick = function () {
									var secondTitle = document.getElementById('secondTitle');
									secondTitle.innerHTML = this.innerHTML;
									var firstList = document.getElementById('firstList');
									firstList.className = "hidden";
									var secondStep = document.getElementById('secondStep');
									secondStep.className = "";
									var secondList = document.getElementById('secondList');
									secondList.className = "";
									//secondlist 배기량 목록 생성함수
									//ajax로 모델과 배기량 조건을 만족하는 상품 수 확인
									for (var i = 1000; i <= 13000; i = i + 2000) {
										var xhttp = new XMLHttpRequest();
										xhttp.onreadystatechange = function () {
											if (this.readyState == 4 && this.status == 200) {
												var anchor = document.createElement('a');
												anchor.className = "manufacture";
												anchor.style = "float:left;";
												anchor.title = i + "," + (i + 2000);
												anchor.href = "#";
												anchor.name = "car_cc";
												anchor.onclick = selectCondition(anchor);
												var span1 = document.createElement('span');
												span1.style = "float:right;";
												var span2 = document.createElement('span');
												var text = this.responseText.trim();
												var textSplit = text.split("|");
												for (var j = 0; j < textSplit.length; j++) {
													var valueSplit = textSplit[j].split(":");
													if (j == 0) {
														anchor.innerHTML += valueSplit[1] + "~";
													} else if (j == 1) {
														anchor.innerHTML += valueSplit[1] + "cc";
													} else if (j == 2) {
														span2.innerHTML = valueSplit[1];
													}
												}
												span1.appendChild(span2);
												var secondList = document.getElementById('secondList');
												secondList.appendChild(anchor);
												secondList.appendChild(span1);
												var br = document.createElement('br');
												secondList.appendChild(br);
											}
										};
										xhttp.open("POST", "cc_cntSearch.jsp?model=" + this.title + "&cc=gt" + i + "lt" + (i + 2000), false);
										xhttp.send();
										//=============================================
									}
									selectCondition();
								}
								var span1 = document.createElement('span');
								span1.style = "float:right;";
								var span2 = document.createElement('span');
								span2.innerHTML = chevroletcarcnt[cnt];
								span1.appendChild(span2);
								var firstList = document.getElementById('firstList');
								firstList.appendChild(anchor);
								firstList.appendChild(span1);
								var br = document.createElement('br');
								firstList.appendChild(br);
								cnt++
							}
						} else if (obj.title == '르노삼성') {
							var cnt = 0;
							for (var car of samsungcarlist) {
								var anchor = document.createElement('a');
								anchor.className = "manufacture";
								anchor.name = "car_model";
								anchor.style = "float:left;";
								anchor.href = "#manufacturerList";
								anchor.innerHTML = car;
								anchor.title = car;
								//두번째 계층 click 함수
								anchor.onclick = function () {
									var secondTitle = document.getElementById('secondTitle');
									secondTitle.innerHTML = this.innerHTML;
									var firstList = document.getElementById('firstList');
									firstList.className = "hidden";
									var secondStep = document.getElementById('secondStep');
									secondStep.className = "";
									var secondList = document.getElementById('secondList');
									secondList.className = "";
									//secondlist 배기량 목록 생성함수
									//ajax로 모델과 배기량 조건을 만족하는 상품 수 확인
									for (var i = 1000; i <= 13000; i = i + 2000) {
										var xhttp = new XMLHttpRequest();
										xhttp.onreadystatechange = function () {
											if (this.readyState == 4 && this.status == 200) {
												var anchor = document.createElement('a');
												anchor.className = "manufacture";
												anchor.style = "float:left;";
												anchor.title = i + "," + (i + 2000);
												anchor.href = "#";
												anchor.name = "car_cc";
												anchor.onclick = selectCondition(anchor);
												var span1 = document.createElement('span');
												span1.style = "float:right;";
												var span2 = document.createElement('span');
												var text = this.responseText.trim();
												var textSplit = text.split("|");
												for (var j = 0; j < textSplit.length; j++) {
													var valueSplit = textSplit[j].split(":");
													if (j == 0) {
														anchor.innerHTML += valueSplit[1] + "~";
													} else if (j == 1) {
														anchor.innerHTML += valueSplit[1] + "cc";
													} else if (j == 2) {
														span2.innerHTML = valueSplit[1];
													}
												}
												span1.appendChild(span2);
												var secondList = document.getElementById('secondList');
												secondList.appendChild(anchor);
												secondList.appendChild(span1);
												var br = document.createElement('br');
												secondList.appendChild(br);
											}
										};
										xhttp.open("POST", "cc_cntSearch.jsp?model=" + this.title + "&cc=gt" + i + "lt" + (i + 2000), false);
										xhttp.send();
										//=============================================
									}
									selectCondition();
								}
								var span1 = document.createElement('span');
								span1.style = "float:right;";
								var span2 = document.createElement('span');
								span2.innerHTML = samsungcarcnt[cnt];
								span1.appendChild(span2);
								var firstList = document.getElementById('firstList');
								firstList.appendChild(anchor);
								firstList.appendChild(span1);
								var br = document.createElement('br');
								firstList.appendChild(br);
								cnt++
							}
						} else if (obj.title == '쌍용') {
							var cnt = 0;
							for (var car of ssangyongcarlist) {
								var anchor = document.createElement('a');
								anchor.className = "manufacture";
								anchor.name = "car_model";
								anchor.style = "float:left;";
								anchor.href = "#manufacturerList";
								anchor.innerHTML = car;
								anchor.title = car;
								//두번째 계층 click 함수
								anchor.onclick = function () {
									var secondTitle = document.getElementById('secondTitle');
									secondTitle.innerHTML = this.innerHTML;
									var firstList = document.getElementById('firstList');
									firstList.className = "hidden";
									var secondStep = document.getElementById('secondStep');
									secondStep.className = "";
									var secondList = document.getElementById('secondList');
									secondList.className = "";
									//secondlist 배기량 목록 생성함수
									//ajax로 모델과 배기량 조건을 만족하는 상품 수 확인
									for (var i = 1000; i <= 13000; i = i + 2000) {
										var xhttp = new XMLHttpRequest();
										xhttp.onreadystatechange = function () {
											if (this.readyState == 4 && this.status == 200) {
												var anchor = document.createElement('a');
												anchor.className = "manufacture";
												anchor.style = "float:left;";
												anchor.title = i + "," + (i + 2000);
												anchor.href = "#";
												anchor.name = "car_cc";
												anchor.onclick = selectCondition(anchor);
												var span1 = document.createElement('span');
												span1.style = "float:right;";
												var span2 = document.createElement('span');
												var text = this.responseText.trim();
												var textSplit = text.split("|");
												for (var j = 0; j < textSplit.length; j++) {
													var valueSplit = textSplit[j].split(":");
													if (j == 0) {
														anchor.innerHTML += valueSplit[1] + "~";
													} else if (j == 1) {
														anchor.innerHTML += valueSplit[1] + "cc";
													} else if (j == 2) {
														span2.innerHTML = valueSplit[1];
													}
												}
												span1.appendChild(span2);
												var secondList = document.getElementById('secondList');
												secondList.appendChild(anchor);
												secondList.appendChild(span1);
												var br = document.createElement('br');
												secondList.appendChild(br);
											}
										};
										xhttp.open("POST", "cc_cntSearch.jsp?model=" + this.title + "&cc=gt" + i + "lt" + (i + 2000), false);
										xhttp.send();
										//=============================================
									}
									selectCondition();
								}
								var span1 = document.createElement('span');
								span1.style = "float:right;";
								var span2 = document.createElement('span');
								span2.innerHTML = ssangyongcarcnt[cnt];
								span1.appendChild(span2);
								var firstList = document.getElementById('firstList');
								firstList.appendChild(anchor);
								firstList.appendChild(span1);
								var br = document.createElement('br');
								firstList.appendChild(br);
								cnt++;
							}
						}
					};

					//첫번째 계층 click 함수
					function firstlist(object) {
						var firstTitle = document.getElementById('firstTitle');
						firstTitle.innerHTML = object.innerHTML;
						var manuList = document.getElementById('manufacturerList');
						manuList.className = "hidden";
						var firstStep = document.getElementById('firstStep');
						firstStep.className = "";
						var firstList = document.getElementById('firstList');
						firstList.className = "";
						var secondStep = document.getElementById('secondStep');
						secondStep.className = "hidden";
						var secondList = document.getElementById('secondList');
						secondList.className = "hidden";
						createfirstlist(object);
					}

					//백스텝 function
					function backstep(object) {
						var parent = object.parentNode;
						if (parent.id == 'firstStep') {
							object.name = "car_brand_close"
							var manuList = document.getElementById('manufacturerList');
							manuList.className = "";
							var firstStep = document.getElementById('firstStep');
							firstStep.className = "hidden";
							var secondStep = document.getElementById('secondStep');
							secondStep.className = "hidden";
							var firstList = document.getElementById('firstList');
							firstList.className = "hidden";
							var secondList = document.getElementById('secondList');
							secondList.className = "hidden";
							$('#firstList').empty();
							$('#secondList').empty();
							var car_brandVal = document.getElementById('firstTitle');
							car_brandVal.innerHTML = "";

						}
						else if (parent.id == 'secondStep') {
							object.name = "car_model_close"
							var firstStep = document.getElementById('firstStep');
							firstStep.className = "";
							var secondStep = document.getElementById('secondStep');
							secondStep.className = "hidden";
							var firstList = document.getElementById('firstList');
							firstList.className = "";
							var secondList = document.getElementById('secondList');
							secondList.className = "hidden";
							$('#secondList').empty();
						}
						var car_modelVal = document.getElementById('secondTitle');
						car_modelVal.innerHTML = "";
						var car_ccVal = document.getElementById('car_cc');
						car_ccVal.value = "";
						selectCondition();
					}
				</script>

				<!-- 연식 -->
				<div class="card">
					<div class="card-header" style="border: 0px; border-radius: 0px; background-color: white;">
						<a id="anchor3" class="collapsed card-link" data-toggle="collapse" href='#collapseThree'
							style="display: block; color: black;">
							<span style="font-weight: bold; float: left;">연식</span> <i id="angle3"
								class="fas fa-angle-down" style="color: gray; float: right; margin-top: 5px;"></i>
						</a>
					</div>
					<div id="collapseThree" class="collapse" data-parent="" style="border: 0px;">
						<div class="card-body" style="font-size: 14px;">
							<select name="car_birth_f" class="custom-select-sm" onchange=selectCondition()>
								<option selected value="0">년</option>
							</select> 
							부터 
							<select name="car_birth_l" class="custom-select-sm" onchange=selectCondition()>
								<option selected value="0">년</option>
							</select> 까지 <br>
						</div>
					</div>
				</div>
				<!--연식 스크립트-->
				<script>
					// 클릭시 메뉴화살표 방향 변경
					var anchor3 = document.getElementById('anchor3');
					var angle3 = document.getElementById('angle3');
					anchor3.onclick = function () {
						if (angle3.className == 'fas fa-angle-down') {
							angle3.className = 'fas fa-angle-up';
						} else if (angle3.className == 'fas fa-angle-up') {
							angle3.className = 'fas fa-angle-down';
						}
					};
					//년 항목 넣기
					for (var i = 0; i < 30; i++) {
						var now_year = new Date().getFullYear();
						var opt1 = document.createElement('option');
						var opt2 = document.createElement('option');
						opt1.value = now_year - i;
						opt1.innerHTML = now_year - i;
						opt2.value = now_year - i;
						opt2.innerHTML = now_year - i;
						var pyear = document.getElementsByName('car_birth_f');
						var lyear = document.getElementsByName('car_birth_l');
						pyear[0].appendChild(opt1);
						lyear[0].appendChild(opt2);
					};
				</script>

				<!-- 주행거리 -->
				<div class="card">
					<div class="card-header" style="border: 0px; border-radius: 0px; background-color: white;">
						<a id="anchor4" class="collapsed card-link" data-toggle="collapse" href='#collapseFour'
							style="display: block; color: black;"> <span
								style="font-weight: bold; float: left;">주행거리</span> <i id="angle4"
								class="fas fa-angle-down" style="color: gray; float: right; margin-top: 5px;"></i>
						</a>
					</div>
					<div id="collapseFour" class="collapse" data-parent="" style="border: 0px;">
						<div class="card-body" style="font-size: 14px;">
							<select name="car_mileage_f" class="custom-select-sm" onchange=selectCondition()>
								<option value="0" selected>Km</option>
							</select> 부터 <br> <select name="car_mileage_l" class="custom-select-sm"
								onchange=selectCondition()>
								<option value="0" selected>Km</option>
							</select> 까지
						</div>
					</div>
				</div>
				<!--주행거리 스크립트-->
				<script>
					// 클릭시 메뉴화살표 방향 변경
					var anchor4 = document.getElementById('anchor4');
					var angle4 = document.getElementById('angle4');
					anchor4.onclick = function () {
						if (angle4.className == 'fas fa-angle-down') {
							angle4.className = 'fas fa-angle-up';
						} else if (angle4.className == 'fas fa-angle-up') {
							angle4.className = 'fas fa-angle-down';
						}
					};
					//주행거리 선택 항목 생성부분
					for (var i = 10000; i <= 200000; i = i + 10000) {
						var opt1 = document.createElement('option');
						opt1.value = i;
						opt1.innerHTML = i + 'km';
						var opt2 = document.createElement('option');
						opt2.value = i;
						opt2.innerHTML = i + 'km';
						var pkm = document.getElementsByName('car_mileage_f');
						var lkm = document.getElementsByName('car_mileage_l');
						pkm[0].appendChild(opt1);
						lkm[0].appendChild(opt2);
					};
				</script>

				<!-- 가격 -->
				<div class="card">
					<div class="card-header" style="border: 0px; border-radius: 0px; background-color: white;">
						<a id="anchor5" class="collapsed card-link" data-toggle="collapse" href='#collapseFive'
							style="display: block; color: black;"> <span
								style="font-weight: bold; float: left;">가격</span> <i id="angle5"
								class="fas fa-angle-down" style="color: gray; float: right; margin-top: 5px;"></i>
						</a>
					</div>
					<div id="collapseFive" class="collapse" data-parent="" style="border: 0px;">
						<div class="card-body" style="font-size: 14px;">
							<select name="p_won" class="custom-select-sm" onchange=selectCondition()>
								<option value="0" selected>선택</option>
							</select> 부터 <br> <select name="l_won" class="custom-select-sm" onchange=selectCondition()>
								<option value="0" selected>선택</option>
							</select> 까지
						</div>
					</div>
				</div>
				<!--가격 스크립트-->
				<script>
					// 클릭시 메뉴화살표 방향 변경
					var anchor5 = document.getElementById('anchor5');
					var angle5 = document.getElementById('angle5');
					anchor5.onclick = function () {
						if (angle5.className == 'fas fa-angle-down') {
							angle5.className = 'fas fa-angle-up';
						} else if (angle5.className == 'fas fa-angle-up') {
							angle5.className = 'fas fa-angle-down';
						}
					};
					//가격 선택 항목 생성부분
					for (var i = 500; i <= 10000; i = i + 500) {
						var opt1 = document.createElement('option');
						opt1.value = i;
						opt1.innerHTML = i + '만원';
						var opt2 = document.createElement('option');
						opt2.value = i;
						opt2.innerHTML = i + '만원';
						var pwon = document.getElementsByName('p_won');
						var lwon = document.getElementsByName('l_won');
						pwon[0].appendChild(opt1);
						lwon[0].appendChild(opt2);
					};
				</script>

				<!-- 지역 -->
				<div class="card">
					<div class="card-header" style="border: 0px; border-radius: 0px; background-color: white;">
						<a id="anchor6" class="collapsed card-link" data-toggle="collapse" href='#collapseSix'
							style="display: block; color: black;"> <span
								style="font-weight: bold; float: left;">지역</span> <i id="angle6"
								class="fas fa-angle-down" style="color: gray; float: right; margin-top: 5px;"></i>
						</a>
					</div>
					<div id="collapseSix" class="collapse" data-parent="" style="border: 0px;">
						<div class="card-body" style="font-size: 14px;">
							<span style="float: left;"> <input type="checkbox" value="경기" name="car_locationMenu"
									onchange=syncLocationCondition() /><span>경기</span></span> <span
								style="float: right;"><span><%=carLocation_cnt[1]%></span></span><br>
							<span style="float: left;"> <input type="checkbox" value="대구" name="car_locationMenu"
									onchange=syncLocationCondition() /><span>대구</span></span> <span
								style="float: right;"><span><%=carLocation_cnt[9]%></span></span><br>
							<span style="float: left;"> <input type="checkbox" value="부산" name="car_locationMenu"
									onchange=syncLocationCondition() /><span>부산</span></span> <span
								style="float: right;"><span><%=carLocation_cnt[8]%></span></span><br>
							<span style="float: left;"> <input type="checkbox" value="서울" name="car_locationMenu"
									onchange=syncLocationCondition() /><span>서울</span></span> <span
								style="float: right;"><span><%=carLocation_cnt[0]%></span></span><br>
							<span style="float: left;"> <input type="checkbox" value="대전" name="car_locationMenu"
									onchange=syncLocationCondition() /><span>대전</span></span> <span
								style="float: right;"><span><%=carLocation_cnt[3]%></span></span><br>
							<div>
								<a id="localExtend" href="#localExtendWindow" style="display: inline-block;"><span
										id="local" onclick=localShow()>+다른지역 더보기</span></a>
								<div class="popover fade bs-popover-right" role="tooltip" id="localExtendWindow"
									style="position: absolute; transform: translate3d(140px, 135px, 0px); top: -50px; left: 0px; will-change: transform;"
									x-placement="right">
									<div class="arrow" style="top: 83px;"></div>
									<div class="popover-body" style="width: 500px;">
										<div>
											<span style="float: left; font-weight: bold;">지역선택</span><i
												class="fas fa-times" style="float: right; margin-left: 0px;"
												onclick=localShow()></i><br>
										</div>
										<hr style="margin-top: 5px; margin-bottom: 5px;">
										<div>
											<input type="radio" name="localSearchOption" id='checkCity' checked
												onchange=disable(this)>시/도 검색<br>
											<table class="table-bordered" style="width: 100%;">
												<thead>
													<th>수도권</th>
													<th>충청/강원</th>
													<th>영남</th>
													<th>호남/제주</th>
												</thead>
												<tbody>
													<td><span style="float: left;"> <input type="checkbox"
																class='cbCity' value="서울" name="car_location"
																onchange=syncLocationCondition() /><span>서울</span></span>
														<span
															style="float: right;"><span><%=carLocation_cnt[0]%></span></span><br>
														<span style="float: left;"> <input type="checkbox"
																class='cbCity' value="경기" name="car_location"
																onchange=syncLocationCondition() /><span>경기</span></span>
														<span
															style="float: right;"><span><%=carLocation_cnt[1]%></span></span><br>
														<span style="float: left;"> <input type="checkbox"
																class='cbCity' value="인천" name="car_location"
																onchange=selectCondition() /><span>인천</span></span>
														<span
															style="float: right;"><span><%=carLocation_cnt[2]%></span></span>
													</td>
													<td><span style="float: left;"> <input type="checkbox"
																class='cbCity' value="대전" name="car_location"
																onchange=syncLocationCondition() /><span>대전</span></span>
														<span
															style="float: right;"><span><%=carLocation_cnt[3]%></span></span><br>
														<span style="float: left;"> <input type="checkbox"
																class='cbCity' value="세종" name="car_location"
																onchange=selectCondition() /><span>세종</span></span>
														<span
															style="float: right;"><span><%=carLocation_cnt[4]%></span></span><br>
														<span style="float: left;"> <input type="checkbox"
																class='cbCity' value="충남" name="car_location"
																onchange=selectCondition() /><span>충남</span></span>
														<span
															style="float: right;"><span><%=carLocation_cnt[5]%></span></span><br>
														<span style="float: left;"> <input type="checkbox"
																class='cbCity' value="충북" name="car_location"
																onchange=selectCondition() /><span>충북</span></span>
														<span
															style="float: right;"><span><%=carLocation_cnt[6]%></span></span><br>
														<span style="float: left;"> <input type="checkbox"
																class='cbCity' value="강원" name="car_location"
																onchange=selectCondition() /><span>강원</span></span>
														<span
															style="float: right;"><span><%=carLocation_cnt[7]%></span></span>
													</td>
													<td><span style="float: left;"> <input type="checkbox"
																class='cbCity' value="부산" name="car_location"
																onchange=syncLocationCondition() /><span>부산</span></span>
														<span
															style="float: right;"><span><%=carLocation_cnt[8]%></span></span><br>
														<span style="float: left;"> <input type="checkbox"
																class='cbCity' value="대구" name="car_location"
																onchange=syncLocationCondition() /><span>대구</span></span>
														<span
															style="float: right;"><span><%=carLocation_cnt[9]%></span></span><br>
														<span style="float: left;"> <input type="checkbox"
																class='cbCity' value="울산" name="car_location"
																onchange=selectCondition() /><span>울산</span></span>
														<span
															style="float: right;"><span><%=carLocation_cnt[10]%></span></span><br>
														<span style="float: left;"> <input type="checkbox"
																class='cbCity' value="경남" name="car_location"
																onchange=selectCondition() /><span>경남</span></span>
														<span
															style="float: right;"><span><%=carLocation_cnt[11]%></span></span><br>
														<span style="float: left;"> <input type="checkbox"
																class='cbCity' value="경북" name="car_location"
																onchange=selectCondition() /><span>경북</span></span>
														<span
															style="float: right;"><span><%=carLocation_cnt[12]%></span></span>
													</td>
													<td><span style="float: left;"> <input type="checkbox"
																class='cbCity' value="광주" name="car_location"
																onchange=selectCondition() /><span>광주</span></span>
														<span
															style="float: right;"><span><%=carLocation_cnt[13]%></span></span><br>
														<span style="float: left;"> <input type="checkbox"
																class='cbCity' value="전남" name="car_location"
																onchange=selectCondition() /><span>전남</span></span>
														<span
															style="float: right;"><span><%=carLocation_cnt[14]%></span></span><br>
														<span style="float: left;"> <input type="checkbox"
																class='cbCity' value="전북" name="car_location"
																onchange=selectCondition() /><span>전북</span></span>
														<span
															style="float: right;"><span><%=carLocation_cnt[15]%></span></span><br>
														<span style="float: left;"> <input type="checkbox"
																class='cbCity' value="제주" name="car_location"
																onchange=selectCondition() /><span>제주</span></span>
														<span
															style="float: right;"><span><%=carLocation_cnt[16]%></span></span>
													</td>
												</tbody>
											</table>
										</div>
										<div style="margin-top: 5px;">
											<input type="radio" name="localSearchOption" id='selectCity'
												onchange=disable(this)>구/군까지 검색<span
												style="color: gray; font-size: 10px;">(1개선택가능)</span><br>
											<select name="city" class="custom-select-sm" disabled
												onchange=citySelect(this.value)>
												<option value="none" selected>시/도</option>
											</select> <select name="area" id='area' class="custom-select-sm" disabled
												onchange=selectCondition()>
												<option value="none" selected>구/군</option>
											</select>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--지역 스크립트-->
				<script>
					//menu와 box간 sync 연결함수
					function syncLocationCondition() {
						if (event.srcElement.name == "car_locationMenu") {
							var car_locationArr = document.getElementsByName('car_location');
							for (var car_locationObj of car_locationArr) {
								if (car_locationObj.value == event.srcElement.value && event.srcElement.checked == true) {
									car_locationObj.checked = true;
								} else if (car_locationObj.value == event.srcElement.value && event.srcElement.checked == false) {
									car_locationObj.checked = false;
								}
							}
						} else if (event.srcElement.name == "car_location") {
							var car_locationMenuArr = document.getElementsByName('car_locationMenu');
							for (var car_locationMenuObj of car_locationMenuArr) {
								if (car_locationMenuObj.value == event.srcElement.value && event.srcElement.checked == true) {
									car_locationMenuObj.checked = true;
								} else if (car_locationMenuObj.value == event.srcElement.value && event.srcElement.checked == false) {
									car_locationMenuObj.checked = false;
								}
							}
						}
						selectCondition();
					}

					// 클릭시 메뉴화살표 방향 변경
					var anchor6 = document.getElementById('anchor6');
					var angle6 = document.getElementById('angle6');
					anchor6.onclick = function () {
						if (angle6.className == 'fas fa-angle-down') {
							angle6.className = 'fas fa-angle-up';
						} else if (angle6.className == 'fas fa-angle-up') {
							angle6.className = 'fas fa-angle-down';
						}
					};
					//+다른지역 더보기시 확장 윈도우 표시/숨김
					var localExtendWindow = document.getElementById('localExtendWindow');
					function localShow() {
						if (localExtendWindow.className == 'popover fade bs-popover-right show') {
							localExtendWindow.className = 'popover fade bs-popover-right';
						} else if (localExtendWindow.className == 'popover fade bs-popover-right') {
							localExtendWindow.className = 'popover fade bs-popover-right show'
						}
					};
					// 검색 옵션에 따른 활성 비활성화 함수
					function disable(obj) {
						if (obj.id == 'checkCity') {
							if (obj.checked == true) {
								var cbCity = document.getElementsByClassName('cbCity');
								for (var cb of cbCity) {
									cb.disabled = false;
								}
								var city = document.getElementsByName('city');
								var area = document.getElementsByName('area');
								city[0].disabled = true;
								city[0].childNodes[0].selected = true;
								for (var i = 1; i < city[0].childNodes.length - 1; i++) {
									city[0].childNodes[i].selected = false;
								}
								area[0].disabled = true;
								area[0].childNodes[0].selected = true;
								var locationMenuObj = document.getElementsByName('car_locationMenu');
								for (var locationMenu of locationMenuObj) {
									locationMenu.disabled = false;
								}

							}
						} else if (obj.id == 'selectCity') {
							if (obj.checked == true) {
								var cbCity = document.getElementsByClassName('cbCity');
								for (var cb of cbCity) {
									cb.disabled = true;
								}
								var city = document.getElementsByName('city');
								var area = document.getElementsByName('area');
								city[0].disabled = false;
								area[0].disabled = false;
								var locationMenuObj = document.getElementsByName('car_locationMenu');
								for (var locationMenu of locationMenuObj) {
									locationMenu.disabled = true;
								}
							}
						}
					};

					//지역 시/도 선택 생성
					var citys = ["서울", "경기", "인천", "대전", "세종", "충남", "충북", "강원", "부산",
						"대구", "울산", "경남", "경북", "광주", "전남", "전북", "제주"];
					for (var ct of citys) {
						var opt1 = document.createElement('option');
						opt1.value = ct;
						opt1.innerHTML = ct;
						var city = document.getElementsByName('city');
						city[0].appendChild(opt1);
					};

					//지역 구/군 선택 생성 함수
					function citySelect(city) {
						if (city == "서울") {
							var seoul = ["강남구", "강동구", "강서구", "강북구", "관악구", "광진구", "구로구", "금천구",
								"노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성북구", "송파구", "양천구",
								"영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"];
							areaOption(seoul);
						}
						else if (city == "경기") {
							var kyunggi = ["고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시",
								"부천시", "성남시", "수원시", "시흥시", "안산시", "안성시", "안양시", "양주시", "양평군", "여주시",
								"연천군", "오산시", "용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시", "화성시"];
							areaOption(kyunggi);
						}
						else if (city == "인천") {
							var incheon = ["계양구", "남구", "남동구", "동구", "미추홀구", "부평구", "서구", "연수구", "중구"];
							areaOption(incheon);
						}
						else if (city == "대전") {
							var daejeon = ["광역시", "대덕구", "동구", "서구", "유성구", "중구"];
							areaOption(daejeon);
						}
						else if (city == "충남") {
							var choongnam = ["계룡시", "공주시", "금산군", "논산시", "당진시", "보령시", "부여군", "서산시", "서천군",
								"아산시", "예산군", "천안시", "청양군", "태안군", "홍성군"];
							areaOption(choongnam);
						}
						else if (city == "충북") {
							var choongbook = ["괴산군", "영동군", "음성군", "제천시", "진천군", "청주시", "충주시"];
							areaOption(choongbook);
						}
						else if (city == "강원") {
							var kangwon = ["강릉시", "동해시", "삼척시", "속초시", "원주시", "인제군", "철원군", "춘천시", "홍천군"];
							areaOption(kangwon);
						}
						else if (city == "부산") {
							var busan = ["강서구", "금정구", "기장군", "남구", "동구", "동래구", "부산진구", "북구", "사상구",
								"사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구"];
							areaOption(busan);
						}
						else if (city == "대구") {
							var daegu = ["남구", "달서구", "달성군", "동구", "북구", "서구", "수성구", "중구"];
							areaOption(daegu);
						}
						else if (city == "울산") {
							var ulsan = ["남구", "동구", "북구", "울주군", "중구"];
							areaOption(ulsan);
						}
						else if (city == "경남") {
							var kyungnam = ["거제시", "거창군", "김해시", "남해군", "마산시", "밀양시", "사천시", "산청군", "양산시",
								"의령군", "진주시", "진해시", "창원시", "통영시", "함안군", "합천군"];
							areaOption(kyungnam);
						}
						else if (city == "경북") {
							var kyungbook = ["경산시", "경주시", "고령군", "구미시", "군위군", "김천시", "문경시", "상주시", "성주군",
								"안동시", "영덕군", "영주시", "영천시", "예천군", "의성군", "청도군", "칠곡군", "포항시"];
							areaOption(kyungbook);
						}
						else if (city == "광주") {
							var kwangju = ["광산구", "남구", "동구", "북구", "서구"];
							areaOption(kwangju);
						}
						else if (city == "전남") {
							var jeonnam = ["고흥군", "광양시", "나주시", "목포시", "무안군", "보성군", "순천시", "여수시", "영광군",
								"영암군", "완도군", "장성군"];
							areaOption(jeonnam);
						}
						else if (city == "전북") {
							var jeonbook = ["고창군", "군산시", "김제시", "남원시", "부안군", "완주군", "익산시", "전주시", "정읍시"];
							areaOption(jeonbook);
						}
						else if (city == "제주") {
							var jeju = ["서귀포시", "제주시"];
							areaOption(jeju);
						}
						else {
							areaOption('');
						}
						selectCondition();
					};
					function areaOption(areas) {
						$('#area').empty();
						var optionSelected = document.createElement('option');
						optionSelected.innerHTML = '구/군';
						optionSelected.value = 'none';
						optionSelected.selected = true;
						var area = document.getElementsByName('area');
						area[0].appendChild(optionSelected);
						if (areas != '') {
							for (var ar of areas) {
								var opt2 = document.createElement('option');
								opt2.value = ar;
								opt2.innerHTML = ar;
								area[0].appendChild(opt2);
							};
						};
					};
				</script>

				<!-- 색상 -->
				<div class="card">
					<div class="card-header" style="border: 0px; border-radius: 0px; background-color: white;">
						<a id="anchor7" class="collapsed card-link" data-toggle="collapse" href='#collapseSeven'
							style="display: block; color: black;">
							<span style="font-weight: bold; float: left;">색상</span> <i id="angle7"
								class="fas fa-angle-down" style="color: gray; float: right; margin-top: 5px;"></i>
						</a>
					</div>
					<div id="collapseSeven" class="collapse" data-parent="" style="border: 0px;">
						<div class="card-body" style="font-size: 14px;">
							<span style="float: left;"> <input type="checkbox" value="흰색" name="checkColor"
									onclick=selectColor() /><span>흰색</span></span>
							<span style="float: right;"><span><%=carColor_cnt[1]%></span></span><br>
							<span style="float: left;"> <input type="checkbox" value="검정색" name="checkColor"
									onclick=selectColor() /><span>검정색</span></span>
							<span style="float: right;"><span><%=carColor_cnt[0]%></span></span><br>
							<span style="float: left;"> <input type="checkbox" value="은색" name="checkColor"
									onclick=selectColor() /><span>은색</span></span>
							<span style="float: right;"><span><%=carColor_cnt[15]%></span></span><br>
							<span style="float: left;"> <input type="checkbox" value="쥐색" name="checkColor"
									onclick=selectColor() /><span>쥐색</span></span>
							<span style="float: right;"><span><%=carColor_cnt[10]%></span></span><br>
							<span style="float: left;"> <input type="checkbox" value="청색" name="checkColor"
									onclick=selectColor() /><span>청색</span></span>
							<span style="float: right;"><span><%=carColor_cnt[3]%></span></span><br>
							<div>
								<a id="colorExtend" href="#colorExtendWindow" style="display: inline-block;"><span
										id="color" onclick=colorShow()>+다른색상 더보기</span></a>
								<div class="popover fade bs-popover-right" role="tooltip" id="colorExtendWindow"
									style="position: absolute; transform: translate3d(140px, 135px, 0px); top: 0px; left: 0px; will-change: transform;"
									x-placement="right">
									<div class="arrow" style="top: 33px;"></div>
									<div class="popover-body" style="width: 700px;">
										<div>
											<span style="float: left; font-weight: bold;">색상선택</span><i
												class="fas fa-times" style="float: right; margin-left: 0px;"
												onclick=colorShow()></i><br>
										</div>
										<hr style="margin-top: 5px; margin-bottom: 5px;">
										<table class="table table-borderless">
											<tr>
												<td><span class="bxColor" style="background-color: black; color: white;"
														onclick=selectColor()>검정색</span> <span
														class="count"><%=carColor_cnt[0]%></span>
												</td>
												<td><span class="bxColor" style="background-color: white; color: black;"
														onclick=selectColor()>흰색</span> <span
														class="count"><%=carColor_cnt[1]%></span>
												</td>
												<td><span class="bxColor"
														style="background-color: #606060; color: white;"
														onclick=selectColor()>갈대색</span> <span
														class="count"><%=carColor_cnt[2]%></span>
												</td>
												<td><span class="bxColor" style="background-color: blue; color: white;"
														onclick=selectColor()>청색</span> <span
														class="count"><%=carColor_cnt[3]%></span>
												</td>
												<td><span class="bxColor" style="background-color: red; color: white;"
														onclick=selectColor()>빨간색</span> <span
														class="count"><%=carColor_cnt[4]%></span>
												</td>
											</tr>
											<tr>
												<td><span class="bxColor"
														style="background: linear-gradient(to right, #606060 50%, #000000 50%); color: white;"
														onclick=selectColor()>검정투톤</span> <span
														class="count"><%=carColor_cnt[5]%></span>
												</td>
												<td><span class="bxColor" style="background-color: beige; color: black;"
														onclick=selectColor()>진주색</span> <span
														class="count"><%=carColor_cnt[6]%></span>
												</td>
												<td><span class="bxColor"
														style="background-color: #d7be69; color: white;"
														onclick=selectColor()>연금색</span> <span
														class="count"><%=carColor_cnt[7]%></span>
												</td>
												<td><span class="bxColor"
														style="background-color: skyblue; color: white;"
														onclick=selectColor()>하늘색</span></span> <span
														class="count"><%=carColor_cnt[8]%></span>
												</td>
												<td><span class="bxColor"
														style="background-color: orange; color: white;"
														onclick=selectColor()>주황색</span> <span
														class="count"><%=carColor_cnt[9]%></span>
												</td>
											</tr>
											<tr>
												<td><span class="bxColor"
														style="background-color: #727875; color: white;"
														onclick=selectColor()>쥐색</span> <span
														class="count"><%=carColor_cnt[10]%></span>
												</td>
												<td><span class="bxColor"
														style="background: linear-gradient(to right, #727875 50%, #ffffff 50%); color: black;"
														onclick=selectColor()>흰색투톤</span> <span
														class="count"><%=carColor_cnt[11]%></span>
												</td>
												<td><span class="bxColor" style="background-color: brown; color: white;"
														onclick=selectColor()>갈색</span> <span
														class="count"><%=carColor_cnt[12]%></span>
												</td>
												<td><span class="bxColor"
														style="background-color: #59b300; color: white;"
														onclick=selectColor()>담녹색</span> <span
														class="count"><%=carColor_cnt[13]%></span>
												</td>
												<td><span class="bxColor"
														style="background-color: rgb(234, 2, 255); color: white;"
														onclick=selectColor()>자주색</span> <span
														class="count"><%=carColor_cnt[14]%></span>
												</td>
											</tr>
											<tr>
												<td><span class="bxColor"
														style="background-color: silver; color: black;"
														onclick=selectColor()>은색</span> <span
														class="count"><%=carColor_cnt[15]%></span>
												</td>
												<td><span class="bxColor"
														style="background: linear-gradient(to right, gray 50%, beige 50%); color: black;"
														onclick=selectColor()>진주투톤</span> <span
														class="count"><%=carColor_cnt[16]%></span>
												</td>
												<td><span class="bxColor"
														style="background: linear-gradient(to right, gray 50%, brown 50%); color: white;"
														onclick=selectColor()>갈색투톤</span> <span
														class="count"><%=carColor_cnt[17]%></span>
												</td>
												<td><span class="bxColor" style="background-color: green; color: white;"
														onclick=selectColor()>녹색</span> <span
														class="count"><%=carColor_cnt[18]%></span>
												</td>
												<td><span class="bxColor"
														style="background-color: rgb(70, 0, 128); color: white;"
														onclick=selectColor()>보라색</span> <span
														class="count"><%=carColor_cnt[19]%></span>
												</td>
											</tr>
											<tr>
												<td><span class="bxColor"
														style="background-color: #c5d0d3; color: black;"
														onclick=selectColor()>은회색</span> <span
														class="count"><%=carColor_cnt[20]%></span>
												</td>
												<td><span class="bxColor"
														style="background-color: gainsboro; color: black;"
														onclick=selectColor()>은하색</span> <span
														class="count"><%=carColor_cnt[21]%></span>
												</td>
												<td><span class="bxColor"
														style="background-color: rgb(209, 196, 120); color: white;"
														onclick=selectColor()>금색</span> <span
														class="count"><%=carColor_cnt[22]%></span>
												</td>
												<td><span class="bxColor"
														style="background-color: lightgreen; color: black;"
														onclick=selectColor()>연두색</span> <span
														class="count"><%=carColor_cnt[23]%></span>
												</td>
												<td><span class="bxColor" style="background-color: pink; color: black;"
														onclick=selectColor()>분홍색</span> <span
														class="count"><%=carColor_cnt[24]%></span>
												</td>
											</tr>
											<tr>
												<td><span class="bxColor"
														style="background: linear-gradient(to right, #606060 50%, silver 50%); color: white;"
														onclick=selectColor()>은색투톤</span> <span
														class="count"><%=carColor_cnt[25]%></span>
												</td>
												<td><span class="bxColor"
														style="background-color: rgba(192, 192, 192, 0.836); color: black;"
														onclick=selectColor()>명은색</span> <span
														class="count"><%=carColor_cnt[26]%></span>
												</td>
												<td><span class="bxColor"
														style="background: linear-gradient(to right, #606060 50%, gold 50%); color: white;"
														onclick=selectColor()>금색투톤</span> <span
														class="count"><%=carColor_cnt[27]%></span>
												</td>
												<td><span class="bxColor"
														style="background-color: #009999; color: white;"
														onclick=selectColor()>청옥색</span> <span
														class="count"><%=carColor_cnt[28]%></span>
												</td>
												<td><span class="bxColor"
														style="background-color: yellow; color: black;"
														onclick=selectColor()>노란색</span> <span
														class="count"><%=carColor_cnt[29]%></span>
												</td>
											</tr>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<!--색상 스크립트-->
				<script>
					// 클릭시 메뉴화살표 방향 변경
					var anchor7 = document.getElementById('anchor7');
					var angle7 = document.getElementById('angle7');
					anchor7.onclick = function () {
						if (angle7.className == 'fas fa-angle-down') {
							angle7.className = 'fas fa-angle-up';
						} else if (angle7.className == 'fas fa-angle-up') {
							angle7.className = 'fas fa-angle-down';
						}
					};
					//+다른색상 더보기시 확장 윈도우 표시/숨김
					var colorExtendWindow = document.getElementById('colorExtendWindow');
					function colorShow() {
						if (colorExtendWindow.className == 'popover fade bs-popover-right show') {
							colorExtendWindow.className = 'popover fade bs-popover-right';
						} else if (colorExtendWindow.className == 'popover fade bs-popover-right') {
							colorExtendWindow.className = 'popover fade bs-popover-right show'
						}
					};
					//colorbox 선택시 테두리 red
					function selectColor() {
						if (event.srcElement.className == "bxColor") {
							event.srcElement.className = "bxColor bxSelect";
							if (event.srcElement.innerHTML == "흰색" || event.srcElement.innerHTML == "검정색" || event.srcElement.innerHTML == "은색" || event.srcElement.innerHTML == "쥐색" || event.srcElement.innerHTML == "청색") {
								var checkColor = document.getElementsByName('checkColor');
								for (var i = 0; i < checkColor.length; i++) {
									if (checkColor[i].value == event.srcElement.innerHTML) {
										checkColor[i].checked = true;
									}
								}
							}
						} else if (event.srcElement.className == "bxColor bxSelect") {
							event.srcElement.className = "bxColor";
							if (event.srcElement.innerHTML == "흰색" || event.srcElement.innerHTML == "검정색" || event.srcElement.innerHTML == "은색" || event.srcElement.innerHTML == "쥐색" || event.srcElement.innerHTML == "청색") {
								var checkColor = document.getElementsByName('checkColor');
								for (var i = 0; i < checkColor.length; i++) {
									if (checkColor[i].value == event.srcElement.innerHTML) {
										checkColor[i].checked = false;
									}
								}
							}
						} else if (event.srcElement.name == "checkColor" && event.srcElement.checked == true) {
							var bxColor = document.getElementsByClassName('bxColor');
							for (var i = 0; i < bxColor.length; i++) {
								if (bxColor[i].innerHTML == event.srcElement.value) {
									bxColor[i].className = "bxColor bxSelect";
								}
							}
						} else if (event.srcElement.name == "checkColor" && event.srcElement.checked == false) {
							var bxColor = document.getElementsByClassName('bxColor');
							for (var i = 0; i < bxColor.length; i++) {
								if (bxColor[i].innerHTML == event.srcElement.value) {
									bxColor[i].className = "bxColor";
								}
							}
						}
						selectCondition();
					}
				</script>
				

				<!-- 연료 -->
				<div class="card">
					<div class="card-header" style="border: 0px; border-radius: 0px; background-color: white;">
						<a id="anchor8" class="collapsed card-link" data-toggle="collapse" href='#collapseEight'
							style="display: block; color: black;">
							<span style="font-weight: bold; float: left;">연료</span> <i id="angle8"
								class="fas fa-angle-down" style="color: gray; float: right; margin-top: 5px;"></i>
						</a>
					</div>
					<div id="collapseEight" class="collapse" data-parent="" style="border: 0px;">
						<div class="card-body" style="font-size: 14px;">
							<span style="float: left;"> 
								<input type="checkbox" value="가솔린" name="car_oilType" onchange=selectCondition() /><span>가솔린</span>
							</span> 
							<span style="float: right;">
								<span><%=carOilType_cnt[0]%></span>
							</span><br>
							<span style="float: left;">
								<input type="checkbox" value="디젤" name="car_oilType" onchange=selectCondition() /><span>디젤</span>
							</span>
							<span style="float: right;">
								<span><%=carOilType_cnt[1]%></span>
							</span><br>
							<span style="float: left;">
								<input type="checkbox" value="LPG" name="car_oilType" onchange=selectCondition() /><span>LPG(일반인구입)</span>
							</span>
							<span style="float: right;">
								<span><%=carOilType_cnt[2]%></span>
							</span><br>
							<span style="float: left;">
								<input type="checkbox" value="가솔린+전기" name="car_oilType" onchange=selectCondition() /><span>가솔린+전기</span>
							</span>
							<span style="float: right;">
								<span><%=carOilType_cnt[3]%></span>
							</span><br>
							<span style="float: left;">
								<input type="checkbox" value="LPG+전기" name="car_oilType" onchange=selectCondition() /><span>LPG+전기</span>
							</span>
							<span style="float: right;">
								<span><%=carOilType_cnt[4]%></span>
							</span><br>
							<span style="float: left;">
								<input type="checkbox" value="가솔린+LPG" name="car_oilType" onchange=selectCondition() /><span>가솔린+LPG</span>
							</span>
							<span style="float: right;">
								<span><%=carOilType_cnt[5]%></span>
							</span><br>
							<span style="float: left;">
								<input type="checkbox" value="가솔린+CNG" name="car_oilType" onchange=selectCondition() /><span>가솔린+CNG</span>
							</span>
							<span style="float: right;">
								<span><%=carOilType_cnt[6]%></span>
							</span><br>
							<span style="float: left;">
								<input type="checkbox" value="전기" name="car_oilType" onchange=selectCondition() /><span>전기</span>
							</span>
							<span style="float: right;">
								<span><%=carOilType_cnt[7]%></span>
							</span><br>
							<span style="float: left;">
								<input type="checkbox" value="수소" name="car_oilType" onchange=selectCondition() /><span>수소</span>
							</span>
							<span style="float: right;">
								<span><%=carOilType_cnt[8]%></span>
							</span><br>
						</div>
					</div>
				</div>
				
				
				<!--연료 스크립트-->
				<script>
					// 클릭시 메뉴화살표 방향 변경
					var anchor8 = document.getElementById('anchor8');
					var angle8 = document.getElementById('angle8');
					anchor8.onclick = function () {
						if (angle8.className == 'fas fa-angle-down') {
							angle8.className = 'fas fa-angle-up';
						} else if (angle8.className == 'fas fa-angle-up') {
							angle8.className = 'fas fa-angle-down';
						}
					};
				</script>

				<!-- 변속기 -->
				<div class="card">
					<div class="card-header" style="border: 0px; border-radius: 0px; background-color: white;">
						<a id="anchor9" class="collapsed card-link" data-toggle="collapse" href='#collapseNine'
							style="display: block; color: black;"> <span
								style="font-weight: bold; float: left;">변속기</span> <i id="angle9"
								class="fas fa-angle-down" style="color: gray; float: right; margin-top: 5px;"></i>
						</a>
					</div>
					<div id="collapseNine" class="collapse" data-parent="" style="border: 0px;">
						<div class="card-body" style="font-size: 14px;">
							<span style="float: left;"><input type="checkbox" value="오토" name="car_gear"
									onchange=selectCondition() /><span>오토</span></span>
							<span style="float: right;"><span><%=carGear_cnt[0]%></span></span><br>
							<span style="float: left;"><input type="checkbox" value="수동" name="car_gear"
									onchange=selectCondition() /><span>수동</span></span>
							<span style="float: right;"><span><%=carGear_cnt[1]%></span></span><br>
							<span style="float: left;"><input type="checkbox" value="세미오토" name="car_gear"
									onchange=selectCondition() /><span>세미오토</span></span>
							<span style="float: right;"><span><%=carGear_cnt[2]%></span></span><br>
							<span style="float: left;"><input type="checkbox" value="CVT" name="car_gear"
									onchange=selectCondition() /><span>CVT</span></span>
							<span style="float: right;"><span><%=carGear_cnt[3]%></span></span><br>
							<span style="float: left;"><input type="checkbox" value="기타" name="car_gear"
									onchange=selectCondition() /><span></span>기타</span></span>
							<span style="float: right;"><span><%=carGear_cnt[4]%></span></span><br>
						</div>
					</div>
				</div>
				<!--변속기 스크립트-->
				<script>
					// 클릭시 메뉴화살표 방향 변경
					var anchor9 = document.getElementById('anchor9');
					var angle9 = document.getElementById('angle9');
					anchor9.onclick = function () {
						if (angle9.className == 'fas fa-angle-down') {
							angle9.className = 'fas fa-angle-up';
						} else if (angle9.className == 'fas fa-angle-up') {
							angle9.className = 'fas fa-angle-down';
						}
					};
				</script>

				<!-- 옵션 -->
				<div class="card">
					<div class="card-header" style="border: 0px; border-radius: 0px; background-color: white;">
						<a id="anchor10" class="collapsed card-link" data-toggle="collapse" href='#collapseTen'
							style="display: block; color: black;"> <span
								style="font-weight: bold; float: left;">옵션</span> <i id="angle10"
								class="fas fa-angle-down" style="color: gray; float: right; margin-top: 5px;"></i>
						</a>
					</div>
					<div id="collapseTen" class="collapse" data-parent="" style="border: 0px;">
						<div class="card-body" style="font-size: 14px;">
							<span style="float: left;"> <input type="checkbox" value="sunroof" name="car_optionMenu"
									onchange=syncOptionCondition() /><span>선루프</span></span> <span
								style="float: right;"><span><%=carOption_cnt[0]%></span></span><br>
							<span style="float: left;"> <input type="checkbox" value="navigation" name="car_optionMenu"
									onchange=syncOptionCondition() /><span>네비게이션</span></span> <span
								style="float: right;"><span><%=carOption_cnt[1]%></span></span><br>
							<span style="float: left;"> <input type="checkbox" value="smartkey" name="car_optionMenu"
									onchange=syncOptionCondition() /><span>스마트키</span></span> <span
								style="float: right;"><span><%=carOption_cnt[2]%></span></span><br>
							<span style="float: left;"> <input type="checkbox" value="HID" name="car_optionMenu"
									onchange=syncOptionCondition() /><span>헤드램프(HID)</span></span>
							<span style="float: right;"><span><%=carOption_cnt[3]%></span></span><br>
							<span style="float: left;"> <input type="checkbox" value="camera_behind"
									name="car_optionMenu" onchange=syncOptionCondition() /><span>후방카메라</span></span>
							<span style="float: right;"><span><%=carOption_cnt[4]%></span></span><br>
							<span style="float: left;"> <input type="checkbox" value="leaderseat" name="car_optionMenu"
									onchange=syncOptionCondition() /><span>가죽시트</span></span> <span
								style="float: right;"><span><%=carOption_cnt[5]%></span></span><br>
							<span style="float: left;"> <input type="checkbox" value="airbag_assistantseat"
									name="car_optionMenu" onchange=syncOptionCondition() /><span>에어백(동승자)</span></span>
							<span style="float: right;"><span><%=carOption_cnt[6]%></span></span><br>
							<span style="float: left;"> <input type="checkbox" value="airbag_side" name="car_optionMenu"
									onchange=syncOptionCondition() /><span>에어백(사이드)</span></span> <span
								style="float: right;"><span><%=carOption_cnt[7]%></span></span><br>
							<div>
								<a id="optionExtend" href="#optionExtendWindow" style="display: inline-block;"><span
										id="color" onclick=optionShow()>+다른옵션 더보기</span></a>
								<div class="popover fade bs-popover-right" role="tooltip" id="optionExtendWindow"
									style="position: absolute; transform: translate3d(140px, 135px, 0px); top: 65px; left: 0px; will-change: transform;"
									x-placement="right">
									<div class="arrow" style="top: 33px;"></div>
									<div class="popover-body" style="width: 700px;">
										<div>
											<span style="float: left; font-weight: bold;">옵션선택</span><i
												class="fas fa-times" style="float: right; margin-left: 0px;"
												onclick=optionShow()></i><br>
										</div>
										<hr style="margin-top: 5px; margin-bottom: 5px;">
										<div>
											<div style="font-weight: bold;">외관내장</div>
											<table class="table-borderless">
												<tr>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="sunroof" name="car_option"
																onchange=syncOptionCondition() /><span>선루프</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" class="headlamp" /><span>헤드램프(
																<input type="radio" class="headlamp" value="HID"
																	name="car_option"
																	onchange=syncOptionCondition() />HID
																<input type="radio" class="headlamp" value="LED"
																	name="car_option" onchange=selectCondition() />LED)
															</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="PET" name="car_option"
																onchange=selectCondition() /><span>파워 전동 트렁크</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="GDC" name="car_option"
																onchange=selectCondition() /><span>고스트 도어 클로징</span>
														</span></td>
												</tr>
												<tr>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="EFSM" name="car_option"
																onchange=selectCondition() /><span>전동접이 사이드 미러</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="AW" name="car_option"
																onchange=selectCondition() /><span>알루미늄 휠</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="roofrack" name="car_option"
																onchange=selectCondition() /><span>루프랙</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="HSW" name="car_option"
																onchange=selectCondition() /><span>열선 스티어링 휠</span>
														</span></td>
												</tr>
												<tr>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="ECSW" name="car_option"
																onchange=selectCondition() /><span>전동 조절 스티어링 휠</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="paddleshift" name="car_option"
																onchange=selectCondition() /><span>패들시프트</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="SWR" name="car_option"
																onchange=selectCondition() /><span>스티어링 휠 리모컨</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="ECMroommirror"
																name="car_option"
																onchange=selectCondition() /><span>ECM룸미러</span>
														</span></td>
												</tr>
												<tr>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="hipass" name="car_option"
																onchange=selectCondition() /><span>하이패스</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="powerdoorlock"
																name="car_option"
																onchange=selectCondition() /><span>파워도어록</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="PSW" name="car_option"
																onchange=selectCondition() /><span>파워 스티어링 휠</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="powerwindow" name="car_option"
																onchange=selectCondition() /><span>파워윈도우</span>
														</span></td>
												</tr>
											</table>
											<hr style="margin-top: 5px; margin-bottom: 5px;">
											<div style="font-weight: bold;">안전</div>
											<table class="table-borderless">
												<tr>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" class="airbag" /><span>에어백(
																<input type="checkbox" class="airbag"
																	value="airbag_drivingseat" name="car_option"
																	onchange=selectCondition() />운전석 <input
																	type="checkbox" class="airbag"
																	value="airbag_assistantseat" name="car_option"
																	onchange=syncOptionCondition() />동승자)
															</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="airbag_side" name="car_option"
																onchange=syncOptionCondition() /><span>에어백(사이드)</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="airbag_curtain"
																name="car_option"
																onchange=selectCondition() /><span>에어백(커튼)</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="ABS" name="car_option"
																onchange=selectCondition() /><span>브레이크 잠김
																방지(ABS)</span>
														</span></td>
												</tr>
												<tr>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="TCS" name="car_option"
																onchange=selectCondition() /><span>미끄럼방지(TCS)</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="ESC" name="car_option"
																onchange=selectCondition() /><span>차체 자세
																제어장치(ESC)</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="TPMS" name="car_option"
																onchange=selectCondition() /><span></span>타이어공기압센서(TPMS)
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="LDWS" name="car_option"
																onchange=selectCondition() /><span>차선이탈
																경보시스템(LDWS)</span>
														</span></td>
												</tr>
												<tr>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="ECS" name="car_option"
																onchange=selectCondition() /><span>전자제어 서스펜션(ECS)</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" class="PDC" /><span>주차감지센서(
																<input type="checkbox" class="PDC" value="PDC_front"
																	name="car_option" onchange=selectCondition() />전방
																<input type="checkbox" class="PDC" value="PDC_behind"
																	name="car_option" onchange=selectCondition() />후방)
															</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="BSAS" name="car_option"
																onchange=selectCondition() /><span>후측방 경보시스템</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="camera_behind"
																name="car_option"
																onchange=syncOptionCondition() /><span>후방카메라</span>
														</span></td>
												</tr>
												<tr>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="aroundview" name="car_option"
																onchange=selectCondition() /><span>360도
																어라운드뷰</span>
														</span></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
											</table>
											<hr style="margin-top: 5px; margin-bottom: 5px;">
											<div style="font-weight: bold;">편의/멀티미디어</div>
											<table class="table-borderless">
												<tr>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" class="cruisecontrol" /><span>크루즈
																컨트롤( <input type="checkbox" class="cruisecontrol"
																	value="cruisecontrol_normal" name="car_option"
																	onchange=selectCondition() />일반 <input
																	type="checkbox" class="cruisecontrol"
																	value="cruisecontrol_adaptive" name="car_option"
																	onchange=selectCondition() />어댑티브)
															</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="HUD" name="car_option"
																onchange=selectCondition() /><span>헤드업 디스플레이(HUD)</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="EPB" name="car_option"
																onchange=selectCondition() /><span>전자식
																주차브레이크(EPB)</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="autoaircon" name="car_option"
																onchange=selectCondition() /><span>자동에어컨</span>
														</span></td>
												</tr>
												<tr>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="smartkey" name="car_option"
																onchange=syncOptionCondition() /><span>스마트키</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="wirelessdoorlock"
																name="car_option"
																onchange=selectCondition() /><span>무선도어
																잠금장치</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="rainsensor" name="car_option"
																onchange=selectCondition() /><span></span>레인센서
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="autolight" name="car_option"
																onchange=selectCondition() /><span>오토라이트</span>
														</span></td>
												</tr>
												<tr>
													<td><span style="float: left;" class="optList">
															<input type="checkbox"
																class="curtain_blind" /><span>커튼/블라인드(
																<input type="checkbox" class="curtain_blind"
																	value="curtain_blind_behindseat" name="car_option"
																	onchange=selectCondition() />뒷좌석 <input
																	type="checkbox" class="curtain_blind"
																	value="curtain_blind_behind" name="car_option"
																	onchange=selectCondition() />후방)
															</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="navigation" name="car_option"
																onchange=syncOptionCondition() /><span>내비게이션</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="AV_monitor_front"
																name="car_option"
																onchange=selectCondition() /><span>앞좌석AV
																모니터</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="AV_monitor_behind"
																name="car_option" onchange=selectCondition() /><span>뒷좌석
																AV 모니터</span>
														</span></td>
												</tr>
												<tr>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="bluetooth" name="car_option"
																onchange=selectCondition() /><span>블루투스</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="CDplayer" name="car_option"
																onchange=selectCondition() /><span>CD플레이어</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="USB" name="car_option"
																onchange=selectCondition() /><span>USB단자</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="AUX" name="car_option"
																onchange=selectCondition() /><span>AUX단자</span>
														</span></td>
												</tr>
											</table>
											<hr style="margin-top: 5px; margin-bottom: 5px;">
											<div style="font-weight: bold;">시트</div>
											<table class="table-borderless">
												<tr>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="leaderseat" name="car_option"
																onchange=syncOptionCondition() /><span>가죽시트</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" class="electricseat" /><span>전동시트(
																<input type="checkbox" class="electricseat"
																	value="electricseat_drivingseat" name="car_option"
																	onchange=selectCondition() />운전석 <input
																	type="checkbox" class="electricseat"
																	value="electricseat_assistantseat" name="car_option"
																	onchange=selectCondition() />동승석)
															</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="electricseat_behind"
																name="car_option"
																onchange=selectCondition() /><span>전동시트(뒷좌석)</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" class="heatseat" /><span>열선시트(
																<input type="checkbox" class="heatseat"
																	value="heatseat_front" name="car_option"
																	onchange=selectCondition() />앞좌석 <input
																	type="checkbox" class="heatseat"
																	value="heatseat_behind" name="car_option"
																	onchange=selectCondition() />뒷좌석)
															</span>
														</span></td>
												</tr>
												<tr>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" class="memoryseat" /><span>메모리시트(
																<input type="checkbox" class="memoryseat"
																	value="memoryseat_drivingseat" name="car_option"
																	onchange=selectCondition() />운전석 <input
																	type="checkbox" class="memoryseat"
																	value="memoryseat_assistantseat" name="car_option"
																	onchange=selectCondition() />동승석)
															</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" class="airseat" /><span>통풍시트(
																<input type="checkbox" class="airseat"
																	value="airseat_drivingseat" name="car_option"
																	onchange=selectCondition() />운전석 <input
																	type="checkbox" class="airseat"
																	value="airseat_assistantseat" name="car_option"
																	onchange=selectCondition() />동승석)
															</span>
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="airseat_behind"
																name="car_option"
																onchange=selectCondition() /><span></span>통풍시트(뒷좌석)
														</span></td>
													<td><span style="float: left;" class="optList">
															<input type="checkbox" value="massageseat" name="car_option"
																onchange=selectCondition() /><span>마사지시트</span>
														</span></td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<!--옵션 스크립트-->
				<script>
					//옵션 선택 동기화
					function syncOptionCondition() {
						if (event.srcElement.name == "car_optionMenu") {
							var car_optionArr = document.getElementsByName('car_option');
							for (var car_optionObj of car_optionArr) {
								if (car_optionObj.value == event.srcElement.value && event.srcElement.checked == true) {
									console.dir(car_optionArr);
									console.dir(event.srcElement);
									if(car_optionObj.parentElement.previousElementSibling!=undefined){
										car_optionObj.parentElement.previousElementSibling.checked = true;	
									}
									car_optionObj.checked = true;
								} else if (car_optionObj.value == event.srcElement.value && event.srcElement.checked == false) {
									if(car_optionObj.parentElement.previousElementSibling!=undefined){
										car_optionObj.parentElement.previousElementSibling.checked = false;	
									}
									car_optionObj.checked = false;
								}
							}
						} else if (event.srcElement.name == "car_option") {
							var car_optionMenuArr = document.getElementsByName('car_optionMenu');
							for (var car_optionMenuObj of car_optionMenuArr) {
								if (car_optionMenuObj.value == event.srcElement.value && event.srcElement.checked == true) {
									car_optionMenuObj.checked = true;
								} else if (car_optionMenuObj.value == event.srcElement.value && event.srcElement.checked == false) {
									car_optionMenuObj.checked = false;
								}
							}
						}
						selectCondition();
					}

					//헤드램프 선택시 Default값 지정
					var headlamp = document.getElementsByClassName('headlamp');
					headlamp[0].onclick = function () {
						if (this.checked == true) {
							var car_optionMenuArr = document.getElementsByName('car_optionMenu');
							car_optionMenuArr[3].checked = true;
							headlamp[1].checked = true;
						} else if (this.checked == false) {
							var car_optionMenuArr = document.getElementsByName('car_optionMenu');
							car_optionMenuArr[3].checked = false;
							headlamp[1].checked = false;
							headlamp[2].checked = false;
						}
						selectCondition();
					};
					headlamp[1].onclick = function () {
						if (this.checked == true) {
							headlamp[0].checked = true;
						}
					};
					headlamp[2].onclick = function () {
						if (this.checked == true) {
							headlamp[0].checked = true;
						}
					};
					
					//에어백 선택시 Default값 지정
					var airbag = document.getElementsByClassName('airbag');
					airbag[0].onclick = function () {
						if (this.checked == true) {
							airbag[1].checked = true;
						} else if (this.checked == false) {
							airbag[1].checked = false;
							airbag[2].checked = false;
						}
						selectCondition();
					};
					airbag[1].onclick = function () {
						if (this.checked == true) {
							airbag[0].checked = true;
						} else if (this.checked == false && airbag[2].checked == false) {
							airbag[0].checked = false;
						}
					};
					airbag[2].onclick = function () {
						if (this.checked == true) {
							airbag[0].checked = true;
						} else if (this.checked == false && airbag[1].checked == false) {
							airbag[0].checked = false;
						}
					};

					//주차감지센서 선택시 Default값 지정
					var PDC = document.getElementsByClassName('PDC');
					PDC[0].onclick = function () {
						if (this.checked == true) {
							PDC[1].checked = true;
						} else if (this.checked == false) {
							PDC[1].checked = false;
							PDC[2].checked = false;
						}
						selectCondition();
					};
					PDC[1].onclick = function () {
						if (this.checked == true) {
							PDC[0].checked = true;
						} else if (this.checked == false && PDC[2].checked == false) {
							PDC[0].checked = false;
						}
					};
					PDC[2].onclick = function () {
						if (this.checked == true) {
							PDC[0].checked = true;
						} else if (this.checked == false && PDC[1].checked == false) {
							PDC[0].checked = false;
						}
					};

					//크루즈컨트롤 선택시 Default값 지정
					var cruisecontrol = document.getElementsByClassName('cruisecontrol');
					cruisecontrol[0].onclick = function () {
						if (this.checked == true) {
							cruisecontrol[1].checked = true;
						} else if (this.checked == false) {
							cruisecontrol[1].checked = false;
							cruisecontrol[2].checked = false;
						}
						selectCondition();
					};
					cruisecontrol[1].onclick = function () {
						if (this.checked == true) {
							cruisecontrol[0].checked = true;
						} else if (this.checked == false && cruisecontrol[2].checked == false) {
							cruisecontrol[0].checked = false;
						}
					};
					cruisecontrol[2].onclick = function () {
						if (this.checked == true) {
							cruisecontrol[0].checked = true;
						} else if (this.checked == false && cruisecontrol[1].checked == false) {
							cruisecontrol[0].checked = false;
						}
					};

					//커튼/블라인드 선택시 Default값 지정
					var curtain_blind = document.getElementsByClassName('curtain_blind');
					curtain_blind[0].onclick = function () {
						if (this.checked == true) {
							curtain_blind[1].checked = true;
						} else if (this.checked == false) {
							curtain_blind[1].checked = false;
							curtain_blind[2].checked = false;
						}
						selectCondition();
					};
					curtain_blind[1].onclick = function () {
						if (this.checked == true) {
							curtain_blind[0].checked = true;
						} else if (this.checked == false && curtain_blind[2].checked == false) {
							curtain_blind[0].checked = false;
						}
					};
					curtain_blind[2].onclick = function () {
						if (this.checked == true) {
							curtain_blind[0].checked = true;
						} else if (this.checked == false && curtain_blind[1].checked == false) {
							curtain_blind[0].checked = false;
						}
					};

					//전동시트 선택시 Default값 지정
					var electricseat = document.getElementsByClassName('electricseat');
					electricseat[0].onclick = function () {
						if (this.checked == true) {
							electricseat[1].checked = true;
						} else if (this.checked == false) {
							electricseat[1].checked = false;
							electricseat[2].checked = false;
						}
						selectCondition();
					};
					electricseat[1].onclick = function () {
						if (this.checked == true) {
							electricseat[0].checked = true;
						} else if (this.checked == false && electricseat[2].checked == false) {
							electricseat[0].checked = false;
						}
					};
					electricseat[2].onclick = function () {
						if (this.checked == true) {
							electricseat[0].checked = true;
						} else if (this.checked == false && electricseat[1].checked == false) {
							electricseat[0].checked = false;
						}
					};

					//열선시트 선택시 Default값 지정
					var heatseat = document.getElementsByClassName('heatseat');
					heatseat[0].onclick = function () {
						if (this.checked == true) {
							heatseat[1].checked = true;
						} else if (this.checked == false) {
							heatseat[1].checked = false;
							heatseat[2].checked = false;
						}
						selectCondition();
					};
					heatseat[1].onclick = function () {
						if (this.checked == true) {
							heatseat[0].checked = true;
						} else if (this.checked == false && heatseat[2].checked == false) {
							heatseat[0].checked = false;
						}
					};
					heatseat[2].onclick = function () {
						if (this.checked == true) {
							heatseat[0].checked = true;
						} else if (this.checked == false && heatseat[1].checked == false) {
							heatseat[0].checked = false;
						}
					};

					//메모리시트 선택시 Default값 지정
					var memoryseat = document.getElementsByClassName('memoryseat');
					memoryseat[0].onclick = function () {
						if (this.checked == true) {
							memoryseat[1].checked = true;
						} else if (this.checked == false) {
							memoryseat[1].checked = false;
							memoryseat[2].checked = false;
						}
						selectCondition();
					};
					memoryseat[1].onclick = function () {
						if (this.checked == true) {
							memoryseat[0].checked = true;
						} else if (this.checked == false && memoryseat[2].checked == false) {
							memoryseat[0].checked = false;
						}
					};
					memoryseat[2].onclick = function () {
						if (this.checked == true) {
							memoryseat[0].checked = true;
						} else if (this.checked == false && memoryseat[1].checked == false) {
							memoryseat[0].checked = false;
						}
					};

					//통풍시트 선택시 Default값 지정
					var airseat = document.getElementsByClassName('airseat');
					airseat[0].onclick = function () {
						if (this.checked == true) {
							airseat[1].checked = true;
						} else if (this.checked == false) {
							airseat[1].checked = false;
							airseat[2].checked = false;
						}
						selectCondition();
					};
					airseat[1].onclick = function () {
						if (this.checked == true) {
							airseat[0].checked = true;
						} else if (this.checked == false && airseat[2].checked == false) {
							airseat[0].checked = false;
						}
					};
					airseat[2].onclick = function () {
						if (this.checked == true) {
							airseat[0].checked = true;
						} else if (this.checked == false && airseat[1].checked == false) {
							airseat[0].checked = false;
						}
					};

					// 클릭시 메뉴화살표 방향 변경
					var anchor10 = document.getElementById('anchor10');
					var angle10 = document.getElementById('angle10');
					anchor10.onclick = function () {
						if (angle10.className == 'fas fa-angle-down') {
							angle10.className = 'fas fa-angle-up';
						} else if (angle10.className == 'fas fa-angle-up') {
							angle10.className = 'fas fa-angle-down';
						};
					};

					//+다른옵션 더보기시 확장 윈도우 표시/숨김
					var optionExtendWindow = document.getElementById('optionExtendWindow');
					function optionShow() {
						if (optionExtendWindow.className == 'popover fade bs-popover-right show') {
							optionExtendWindow.className = 'popover fade bs-popover-right';
						} else if (optionExtendWindow.className == 'popover fade bs-popover-right') {
							optionExtendWindow.className = 'popover fade bs-popover-right show'
						}
					};
				</script>
			</div>
		</div>
		<script>
		<!--Main페이지에서 넘어온 조건 실행 함수-->
			function initConditionSearch() {
				//brand 검색조건 적용
				var car_brandArr = document.getElementsByName('car_brand');
				for (var carbrand of car_brandArr) {
					if (carbrand.title == "<%=request.getParameter("car_brand")%>") {
						firstlist(carbrand);
					}
				}

				//model조건 jquery로 onclick 이벤트 강제실행
				$('a.manufacture[title="<%=request.getParameter("car_model")%>"]').trigger("onclick");

				//oilType 검색조건 적용
				var car_oilTypeArr = document.getElementsByName('car_oilType');
				for (var caroilType of car_oilTypeArr) {
					if (caroilType.value == "<%=request.getParameter("car_oilType")%>") {
						caroilType.checked = true;
					}
				}

				selectCondition();
			}

			<!--검색 조건 선택시 함수-->
				function selectCondition() {
					var listQuery = "list.jsp?";
					// car_type query생성
					var car_typeValArr = document.getElementsByName('car_type');
					var car_typeQuery = "car_type=";
					var car_typeCnt = 0;
					for (var car_typeVal of car_typeValArr) {
						if (car_typeVal.checked == true) {
							car_typeQuery += car_typeVal.value + ",";
							car_typeCnt++;
						}
					}
					if (car_typeCnt != 0) {
						car_typeQuery = car_typeQuery.substr(0, car_typeQuery.length - 1);
						listQuery += car_typeQuery;
					}

					// car_brand query생성
					var car_brandVal = document.getElementById('firstTitle');
					var car_brandQuery = "car_brand=";
					if (car_brandVal.innerHTML != "" && event.srcElement.id != "firstX") {
						car_brandQuery += car_brandVal.innerHTML;
						listQuery += "&" + car_brandQuery;
					}

					// car_model query생성
					var car_modelVal = document.getElementById('secondTitle');
					var car_modelQuery = "car_model=";
					if (car_modelVal.innerHTML != "" && (event.srcElement.id != "firstX" || event.srcElement.id != "secondX")) {
						car_modelQuery += car_modelVal.innerHTML;
						listQuery += "&" + car_modelQuery;
					}

					// car_cc query생성
					var car_ccVal = document.getElementById('car_cc');
					var car_ccQuery = "car_cc=";
					if (event.srcElement.name == "car_cc") {
						car_ccVal.value = event.srcElement.title;
						car_ccQuery += car_ccVal.value;
						listQuery += "&" + car_ccQuery;
					}

					// car_birth query생성
					var car_birthQuery = "car_birth=";
					var car_birth_fVal = document.getElementsByName('car_birth_f');
					var car_birth_lVal = document.getElementsByName('car_birth_l');
					if (car_birth_fVal[0].value > car_birth_lVal[0].value && (car_birth_fVal[0].value != 0 && car_birth_lVal[0].value != 0)) {
						alert('연식의 시작년도가 끝년도보다 클수 없습니다. 다시 선택해주세요.');
						car_birth_fVal[0].firstElementChild.selected = true;
						car_birth_lVal[0].firstElementChild.selected = true;
						return;
					}
					if (car_birth_fVal[0].value != 0 || car_birth_lVal[0].value != 0) {
						car_birthQuery += car_birth_fVal[0].value + "," + car_birth_lVal[0].value;
						listQuery += "&" + car_birthQuery;
					}

					// car_mileage query생성
					var car_mileageQuery = "car_mileage=";
					var car_mileage_fVal = document.getElementsByName('car_mileage_f');
					var car_mileage_lVal = document.getElementsByName('car_mileage_l');
					if (car_mileage_fVal[0].value > car_mileage_lVal[0].value && (car_mileage_fVal[0].value != 0 && car_mileage_lVal[0].value != 0)) {
						alert('주행거리의 시작이 끝보다 클수 없습니다. 다시 선택해주세요.');
						car_mileage_fVal[0].firstElementChild.selected = true;
						car_mileage_lVal[0].firstElementChild.selected = true;
						return;
					}
					if (car_mileage_fVal[0].value != 0 || car_mileage_lVal[0].value != 0) {
						car_mileageQuery += car_mileage_fVal[0].value + "," + car_mileage_lVal[0].value;
						listQuery += "&" + car_mileageQuery;
					}

					// car_price query생성
					var car_priceQuery = "car_price=";
					var car_price_fVal = document.getElementsByName('p_won');
					var car_price_lVal = document.getElementsByName('l_won');
					if (car_price_fVal[0].value > car_price_lVal[0].value && (car_price_fVal[0].value != 0 && car_price_lVal[0].value != 0)) {
						alert('주행거리의 시작이 끝보다 클수 없습니다. 다시 선택해주세요.');
						car_price_fVal[0].firstElementChild.selected = true;
						car_price_lVal[0].firstElementChild.selected = true;
						return;
					}
					if (car_price_fVal[0].value != 0 || car_price_lVal[0].value != 0) {
						car_priceQuery += car_price_fVal[0].value + "," + car_price_lVal[0].value;
						listQuery += "&" + car_priceQuery;
					}

					//car_location query 생성
					var checkcity = document.getElementById('checkCity');
					var selectCity = document.getElementById('selectCity');
					if (checkcity.checked == true) { // location checkbox 경우
						var car_locationValArr = document.getElementsByName('car_location');
						var car_locationQuery = "car_location=";
						var car_locationCnt = 0;
						for (var car_locationVal of car_locationValArr) {
							if (car_locationVal.checked == true) {
								car_locationQuery += car_locationVal.value + ",";
								car_locationCnt++;
							}
						}
						if (car_locationCnt != 0) {
							car_locationQuery = car_locationQuery.substr(0, car_locationQuery.length - 1);
							listQuery += "&" + car_locationQuery;
						}
					} else if (selectCity.checked == true) { // location select 경우
						var car_locationQuery = "car_location=";
						var cityVal = document.getElementsByName('city');
						var areaVal = document.getElementsByName('area');
						if (cityVal[0].value == "none" && areaVal[0].value == "none") {
							return;
						} else if (cityVal[0].value == "none" || areaVal[0].value == "none") {
							car_locationQuery += cityVal[0].value;
							listQuery += "&" + car_locationQuery;
						} else {
							car_locationQuery += cityVal[0].value + " " + areaVal[0].value;
							listQuery += "&" + car_locationQuery;
						}
					}

					// car_color query생성
					var car_colorValArr = document.getElementsByClassName('bxSelect');
					var car_colorQuery = "car_color=";
					if (car_colorValArr.length != 0) {
						for (var car_colorVal of car_colorValArr) {
							car_colorQuery += car_colorVal.innerHTML + ",";
						}
						car_colorQuery = car_colorQuery.substr(0, car_colorQuery.length - 1);
						listQuery += "&" + car_colorQuery;
					}

					// car_oilType query생성
					var car_oilTypeValArr = document.getElementsByName('car_oilType');
					var car_oilTypeQuery = "car_oilType=";
					var car_oilTypeCnt = 0;
					for (var car_oilTypeVal of car_oilTypeValArr) {
						if (car_oilTypeVal.checked == true) {
							car_oilTypeQuery += car_oilTypeVal.value + ",";
							car_oilTypeCnt++;
						}
					}
					if (car_oilTypeCnt != 0) {
						car_oilTypeQuery = car_oilTypeQuery.substr(0, car_oilTypeQuery.length - 1);
						listQuery += "&" + car_oilTypeQuery;
					}

					// car_gear query생성
					var car_gearValArr = document.getElementsByName('car_gear');
					var car_gearQuery = "car_gear=";
					var car_gearCnt = 0;
					for (var car_gearVal of car_gearValArr) {
						if (car_gearVal.checked == true) {
							car_gearQuery += car_gearVal.value + ",";
							car_gearCnt++;
						}
					}
					if (car_gearCnt != 0) {
						car_gearQuery = car_gearQuery.substr(0, car_gearQuery.length - 1);
						listQuery += "&" + car_gearQuery;
					}

					// car_option query생성
					var car_optionValArr = document.getElementsByName('car_option');
					var car_optionQuery = "car_option=";
					var car_optionCnt = 0;
					for (var car_optionVal of car_optionValArr) {
						if (car_optionVal.checked == true) {
							car_optionQuery += car_optionVal.value + ",";
							car_optionCnt++;
						}
					}
					if (car_optionCnt != 0) {
						car_optionQuery = car_optionQuery.substr(0, car_optionQuery.length - 1);
						listQuery += "&" + car_optionQuery;
					}

					// ?& 변경
					listQuery = listQuery.replace("?&", "?");
					console.dir(listQuery);
					if(event.srcElement.name=='car_model'){
						addRecentSearch(listQuery);	
					}
					var iframe = document.getElementsByTagName('iframe');
					iframe[0].src = listQuery;
				}
		</script>

		<iframe src="list.jsp" name="listFrame" frameborder="0" scrolling="no"
			style="width: 1200px; height: 2000px; overflow: visible; float: left;"></iframe>

	</div>

</body>

</html>