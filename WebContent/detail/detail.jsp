<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "usedcar.shopping.CarListDataBean" %>
<%@ page import = "usedcar.shopping.CarListDBBean" %>
<%@ page import = "usedcar.shopping.DealerDataBean" %>
<%@ page import = "usedcar.shopping.DealerDBBean" %>
<%@ page import = "usedcar.shopping.JjimListDataBean" %>
<%@ page import = "usedcar.shopping.JjimListDBBean" %>
<%@ page import = "java.util.List" %>  
<%@ page import = "java.text.NumberFormat" %>
<%

if(request.getParameter("car_idx") == null) {
	response.sendRedirect("../list/searchmenu.jsp");
	return;
}

int car_idx = Integer.parseInt(request.getParameter("car_idx"));

String carImageFolder = "http://localhost:8888/UsedCar10/carimg";
String profileImageFolder = "http://localhost:8888/UsedCar10/images";

CarListDBBean carProcess = CarListDBBean.getInstance();
CarListDataBean car = carProcess.getCar(car_idx);

if(car == null) {
	return;
}

String id = (String)session.getAttribute("user_id");

DealerDBBean dealerProcess = DealerDBBean.getInstance();
DealerDataBean dealer = dealerProcess.getMember(car.getDealer_id());

int onSale = carProcess.getOnSale(dealer.getUser_id());
int completedSale = carProcess.getCompletedSale(dealer.getUser_id());

JjimListDBBean jjimProcess = JjimListDBBean.getInstance();
int jjim = jjimProcess.getJjimCountByCarIdx(car_idx);

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet">

    <link href="../css/navbar.css" rel="stylesheet" type="text/css">
	<script src="../js/navbar.js"></script>
    <title>차량보기</title>
    <style>
	* {
		font-family: 'Montserrat', sans-serif;
	}
    
    .content > div {
        padding-bottom: 150px;
    }

    .mySlides img {
        width: 100%; 
        height: 720px; 
        object-fit: cover;
    }

    .slideshow-container {
    position: relative;
    }

    .prev, .next {
    cursor: pointer;
    position: absolute;
    top: 50%;
    padding: 20px;
    margin-top: -25px;
    color: white;
    font-weight: bold;
    font-size: 30px;
    }

    .next {
    right: 0;
    }

    .info {
        position: absolute; 
        top: 10px; 
        padding: 20px; 
        color: white; 
        font-size: 22px;
        font-weight: bold;
    }
    
    .detailInfo {
        position: absolute; 
        top: 50px; 
        padding: 20px; 

        color: rgb(224, 224, 224); 
        font-size: 15px;
        font-weight: bold;
        
    }

    .option div {
        width: 295px; 
        line-height: 50px; 
        font-size: 20px;
        color: lightgray; /* dimgray */
        display: inline-block;
    }

    .tab-buyguide li{
        display: inline-block;
        width: 220px;
        line-height: 30px;
        text-align: center;
        cursor: pointer;
        font-weight: bold;
    }

    .list-buyguide {
        display: none;
        list-style-type: circle;
    }

    .list-buyguide li{
        line-height: 30px;
    }

    .price{
        font-size: 20px;
        font-weight: bold;
        color: #EA2027;
        padding: 15px;
    }

    .inquiry {
        width: 200px;
        border-radius: 50px;
        padding: 15px;
        background-color: #EE5A24;
        font-size: 20px;
        font-weight: bold;
        text-align: center;
        color: white;
        cursor: pointer;
    }

    /* The Modal (background) */
    .modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    }

    /* Modal Content */
    .modal-content {
    border-radius: 10px;
    background-color: #fefefe;
    margin: auto;
    padding: 50px;
    border: 1px solid #888;
    width: 600px;
    -webkit-animation-name: animatetop;
    -webkit-animation-duration: 0.4s;
    animation-name: animatetop;
    animation-duration: 0.4s
    }

    /* Add Animation */
    @-webkit-keyframes animatetop {
    from {top:-300px; opacity:0} 
    to {top:0; opacity:1}
    }

    @keyframes animatetop {
    from {top:-300px; opacity:0}
    to {top:0; opacity:1}
    }

    /* The Close Button */
    .close {
    color: #aaaaaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
    }

    .close:hover,
    .close:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
    }

    #map {
        display: none;
    }

    .inquiryBtn {
        width: 100px;
        border-radius: 50px;
        padding: 10px;
        background-color: #EE5A24;
        font-size: 15px;
        font-weight: bold;
        text-align: center;
        color: white;
        cursor: pointer;
        border: none;
    }
    
    .inquiryInput {
        height: 50px;
        border: 1px solid lightgray;
        border-radius: 5px;
        font-size: 15px;
        padding: 10px;
    }
    
    /* top 제어 */
	#header-container {
		width: 1200px;
		margin: 0 auto;
		font-size: 115%;
	}

    </style>
    
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3ebaf554d3a4c9a845c6f8abc0e29679&libraries=services"></script>
    <script>
    	//1.슬라이드
        var slideIndex = 1;
        var modal;
        window.onload = function(){
            showSlides(slideIndex);//최초 보여짐
            tabBuyguide(1);
            modal = document.getElementById("myModal");
            checkOption("<%= car.getCar_option() %>");
        }
        
        function plusSlides(n) {
          showSlides(slideIndex += n);
        }
        
        function showSlides(n) {
          var i;
          var slides = document.getElementsByClassName("mySlides");
          
          if (n > slides.length) {slideIndex = 1} //최대장수보다 크면 처음으로 가고
          if (n < 1) {slideIndex = slides.length} //최소장수보다 작으면 끝으로 간다
          
          for (i = 0; i < slides.length; i++) {
             slides[i].style.display = "none";
          }
          slides[slideIndex-1].style.display = "block";
        }

        //2.구매가이드
        function tabBuyguide(n) {
            var tabs = document.getElementsByClassName("tab-buyguide")[0].children;
            var lists = document.getElementsByClassName("list-buyguide");
            
            for (i = 0; i < lists.length; i++) {
                lists[i].style.display = "none";
                tabs[i].style.color = "dimgray";
            }
            
            lists[n-1].style.display = "block";
            tabs[n-1].style.color = "#EA2027";

        }

        //3.모달
        function showModal() {
            modal.style.display = "block";
        }

        function closeModal() {
            modal.style.display = "none";
        }

        window.onclick = function(event) {
            if (event.target == modal) {
                closeModal();
            }
        }

        //4.지도
        function createMap(loc){
            var mapContainer = document.getElementById('map') // 지도를 표시할 div 
            var mapOption = {
                    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                    level: 3 // 지도의 확대 레벨
                };  

                // 지도를 생성합니다    
                var map = new kakao.maps.Map(mapContainer, mapOption); 

                // 주소-좌표 변환 객체를 생성합니다
                var geocoder = new kakao.maps.services.Geocoder();

                // 주소로 좌표를 검색합니다
                geocoder.addressSearch(loc, function(result, status) {

                    // 정상적으로 검색이 완료됐으면 
                    if (status === kakao.maps.services.Status.OK) {

                        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                        // 결과값으로 받은 위치를 마커로 표시합니다
                        var marker = new kakao.maps.Marker({
                            map: map,
                            position: coords
                        });
                        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                        map.setCenter(coords);
                    } 
                });
        }

        function showMap(obj){
            var mapContainer = document.getElementById('map');
            if(mapContainer.style.display == 'none' || mapContainer.style.display == ''){
                mapContainer.style.display = 'block';
                createMap(obj.innerText);
            } else {
                mapContainer.style.display = 'none';
            }
            
        }

        //5.인풋제한
        function limitText(obj){
            var text = obj.value;
            var textByte = document.getElementsByClassName('textByte')[0];

            if (getTextLength(text) > 800){
                obj.value = text.substring(0, text.length-1);
            }

            textByte.innerHTML = getTextLength(text);
        }

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
        
        //로그인 체크
        function checkLogin(){
        	var id = "<%=id %>";
        	if(id == "null"){
        		alert("로그인이 필요합니다.");
        		return;
        	}
        	if(id == "<%=dealer.getUser_id() %>"){
        		alert("내가 등록한 차량에 구매문의를 할 수 없습니다.");
        		return;
        	}
        	showModal();
        }
        
        //옵션 체크
        function checkOption(car_option){
        	var options = document.getElementsByClassName('option');
        	
        	for(var i = 0; i < options.length; i++){
        		var option = options[i];
        		var elements = option.getElementsByTagName("span");
        		for(var j = 0; j < elements.length; j++){
        			var element = elements[j];
        			if(car_option.includes(element.getAttribute("id"))){
        				element.style.color = "dimgray";
        			}
        		}
        	}
        }
    </script>
</head>
<body>
	<jsp:include page="navbar.jsp" flush="false"/>
    <div class="content" style="width: 1200px; margin: auto; padding-top: 100px">
        <div id="basic-info">
            <div class="slideshow-container">
                <div class="mySlides">
                    <img src="<%=carImageFolder%>/<%=car.getCar_img1()%>">
                </div>
                <div class="mySlides">
                    <img src="<%=carImageFolder%>/<%=car.getCar_img2()%>">
                </div>
                <div class="mySlides">
                    <img src="<%=carImageFolder%>/<%=car.getCar_img3()%>">
                </div>
                <div style="width: 100%; height: 100%; position:absolute; box-shadow: inset 0 200px 150px -120px black; top:0%;"></div>
                <div class="info" >[ <%=car.getCar_brand() %> - <%=car.getCar_model() %> ] <%=car.getTitle() %></div>
                <div class="detailInfo" >
                	<%=car.getCar_mileage() %>km - 
                	<%=car.getCar_birth() %>년식 - 
                	<%=car.getCar_oilType() %> - 
                	<%=car.getCar_type() %> - 
                	<%=car.getCar_cc() %>cc - 
                	<%=car.getCar_type() %> - 
                	<%=car.getCar_color() %> - 
                	<%=car.getCar_regNum() %>
                </div>
                <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
                <a class="next" onclick="plusSlides(1)">&#10095;</a>
            </div>

            <table style="width: 100%; padding: 5px; border: 1px solid lightgray;">
                <tr>
                    <td width="800" style="color: dimgray;">등록번호 <%=car.getCar_idx() %> | 등록일 <%=car.getReg_date().toString().substring(0, 10) %> | 찜 <%=jjim %></td>
                    <td style="display: inline-flex;">
                    	<div class="price"><%=NumberFormat.getInstance().format(Integer.parseInt(car.getCar_price())) %>만원</div>
                    	<div class="inquiry" onclick="checkLogin()">구매문의</div>
                    </td>
                </tr>
            </table>
        </div>

        <!-- The Modal -->
        <div id="myModal" class="modal">

            <!-- Modal content -->
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <h2>구매문의</h2>
                <table>
                    <tr>
                        <td style="width: 100px;">
                            <img class="profile-img" src="<%=profileImageFolder%>/<%=dealer.getImg()%>" height="70" width="70" style="object-fit: cover; border-radius: 50%;">
                        </td>
                        <td>
                            <p><%=dealer.getCompany_name() %> <b><%=dealer.getName() %></b></p>
                            <p style="cursor: pointer;" onclick="showMap(this)"><u>
                            	<%=dealer.getAddress1() %> <%=dealer.getAddress2() %> <%=dealer.getAddress3() %>
                            </u></p>
                        </td>
                    </tr>
                </table>
                <div id='map' style='width:100%; height:340px;'></div>

                <br>
                <i class="fa fa-phone" style="font-size:24px;color:#EA2027"> <b><%=dealer.getTel() %></b></i>
                <p style="font-size: 12px; color: dimgray;">허위 매물 단속 및 매매관련 분쟁처리 등을 위해 문의하신 전화번호와 통화 및 문자 내용이 저장될 수 있습니다.</p>
                <br>
                
                <form action="../question/questionPro.jsp" method="POST">
                    <span><b>문의사항</b></span>
                    <input type="hidden" name="car_idx" value=<%=car.getCar_idx() %>>
                    <input type="hidden" name="dealer_id" value=<%=dealer.getUser_id() %>>
                    <span style="float: right; font-size: 15px; color: dimgray;">400자 이내 (<b class="textByte">0</b> / 800 byte)</span>
                    <br><br>
                    <input class="inquiryInput" name="inquiry" style="width:100%;" placeholder="이 차의 어떤 점이 궁금하신가요?" onkeyup="limitText(this)" required></input>
                    <br><br>
                    <div style="color: dimgray;">
                        <span>교환 또는 판매할 차량을 가지고 계신가요?</span>
                        <input type="radio" name="car_own" value="1"> 예
                        <input type="radio" name="car_own" value="0" checked> 아니오
                    </div>
                    <br><br><br>
                    <div align="center">
                        <input type="submit" class="inquiryBtn" value="문의하기"></input>
                    </div>
                </form>
            </div>
        </div>
  
        <div id="option-info">
            <h2>옵션</h2><br>
            <div class="option">
            	<p><b>외관/내장</b></p>
            	<div>
            		<span id="sunroof">선루프</span>
            	</div>
            	<div>
            		<span id="HID">헤드램프(HID,</span>
            		<span id="LED">LED)</span>
            	</div>
            	<div>
            		<span id="PET">파워전동트렁크</span>
            	</div>
            	<div>
            		<span id="GDC">고스트도어클로징</span>
            	</div>
            	<div>
            		<span id="EFSM">전동접이사이드미러</span>
            	</div>
            	<div>
            		<span id="AW">알루미늄휠</span>
            	</div>
            	<div>
            		<span id="roofrack">루프랙</span>
            	</div>
            	<div>
            		<span id="HSW">열선스티어링휠</span>
            	</div>
            	<div>
            		<span id="ECSW">전동조절스티어링휠</span>
            	</div>
            	<div>
            		<span id="paddleshift">패들시프트</span>
            	</div>
            	<div>
            		<span id="SWR">스티어링휠리모콘</span>
            	</div>
            	<div>
            		<span id="ECMroommirror">ECM룸미러</span>
            	</div>
            	<div>
            		<span id="hipass">하이패스</span>
            	</div>
            	<div>
            		<span id="powerdoorlock">파워도어록</span>
            	</div>
            	<div>
            		<span id="PSW">파워스티어링휠</span>
            	</div>
            	<div>
            		<span id="powerwindow">파워윈도우</span>
            	</div>
            </div>
            <br>
            <hr>
            <br>
            <div class="option">
            	<p><b>안전</b></p>
            	<div>
            		<span id="airbag_drivingseat">에어백(운전석,</span>
            		<span id="airbag_assistantseat">동승자)</span>
            	</div>
            	<div>
            		<span id="airbag_side">에어백(사이드)</span>
            	</div>
            	<div>
            		<span id="airbag_curtain">에어백(커튼)</span>
            	</div>
            	<div>
            		<span id="ABS">브레이크잠김방지(ABS)</span>
            	</div>
            	<div>
            		<span id="TCS">미끄럼방지(TCS)</span>
            	</div>
            	<div>
            		<span id="ESC">차체자세제어장치</span>
            	</div>
            	<div>
            		<span id="TPMS">타이어 공기압센서</span>
            	</div>
            	<div>
            		<span id="LDWS">차선이탈경보시스템</span>
            	</div>
            	<div>
            		<span id="ECS">전자제어서스펜션</span>
            	</div>
            	<div>
            		<span id="PDC_front">주차감지센서(전방,</span>
            		<span id="PDC_behind">후방)</span>
            	</div>
            	<div>
            		<span id="BSAS">후측방경보시스템</span>
            	</div>
            	<div>
            		<span id="camera_behind">후방카메라</span>
            	</div>
            	<div>
            		<span id="aroundview">360도 어라운드뷰</span>
            	</div>
           	</div>
            <br>
            <hr>
            <br>
            <div class="option">
            	<p><b>편의/멀티미디어</b></p>
            	<div>
            		<span id="cruisecontrol_normal">크루즈 컨트롤(일반,</span>
            		<span id="cruisecontrol_adaptive">어댑티브)</span>
            	</div>
            	<div>
            		<span id="HUD">헤드업디스플레이</span>
            	</div>
            	<div>
            		<span id="EPB">전자식주차브레이크</span>
            	</div>
            	<div>
            		<span id="autoaircon">자동에어컨</span>
            	</div>
            	<div>
            		<span id="smartkey">스마트키</span>
            	</div>
            	<div>
            		<span id="wirelessdoorlock">무선도어잠금장치</span>
            	</div>
            	<div>
            		<span id="rainsensor">레인센서</span>
            	</div>
            	<div>
            		<span id="autolight">오토라이트</span>
            	</div>
            	<div>
            		<span id="curtain_blind_behindseat">커튼/블라인드 (뒷좌석,</span>
            		<span id="curtain_blind_behind">후방)</span>
            	</div>
            	<div>
            		<span id="navigation">내비게이션</span>
            	</div>
            	<div>
            		<span id="AV_monitor_front">앞좌석 AV 모니터</span>
            	</div>
            	<div>
            		<span id="AV_monitor_behind">뒷좌석 AV 모니터</span>
            	</div>
            	<div>
            		<span id="bluetooth">블루투스</span>
            	</div>
            	<div>
            		<span id="CDplayer">CD플레이어</span>
            	</div>
            	<div>
            		<span id="USB">USB단자</span>
            	</div>
            	<div>
            		<span id="AUX">AUX단자</span>
            	</div>
            </div>
            <br>
            <hr>
            <br>
            <div class="option">
            	<p><b>시트</b></p>
            	<div>
            		<span id="leaderseat">가죽시트</span>
            	</div>
            	<div>
            		<span id="electricseat_drivingseat">전동시트(운전석,</span>
            		<span id="electricseat_assistantseat">동승석)</span>
            	</div>
            	<div>
            		<span id="electricseat_behind">전동시트(뒷좌석)</span>
            	</div>
            	<div>
            		<span id="heatseat_front">열선시트(앞좌석,</span>
            		<span id="heatseat_behind">뒷좌석)</span>
            	</div>
            	<div>
            		<span id="memoryseat_drivingseat">메모리시트(운전석,</span>
            		<span id="memoryseat_assistantseat">동승석)</span>
            	</div>
            	<div>
            		<span id="airseat_drivingseat">통풍시트(운전석,</span>
            		<span id="airseat_assistantseat">동승석)</span>
            	</div>
            	<div>
            		<span id="airseat_behind">통풍시트(뒷좌석)</span>
            	</div>
            	<div>
            		<span id="massageseat">마사지시트</span>
            	</div>
            </div>
           	
        </div>

        <div id="desc-info">
            <h2>판매자 설명</h2>
            <table>
                <tr>
                    <td style="width: 100px;">
                        <img class="profile-img" src="<%=profileImageFolder%>/<%=dealer.getImg()%>" height="70" width="70" style="object-fit: cover; border-radius: 50%;">
                    </td>
                    <td>
                        <p><%=dealer.getCompany_name() %> <b><%=dealer.getName() %></b> | <%=dealer.getAddress1() %> <%=dealer.getAddress2() %> <%=dealer.getAddress3() %></p>
                        <p>
                        	종사원증번호 <%if(dealer.getEmp_id() == null) { %>-<% } else { %><%=dealer.getEmp_id() %><%} %> | 
                        	판매중 <b><%=onSale %></b> | 
                        	판매완료 <b><%=completedSale %></b>
                        </p>
                    </td>
                </tr>
            </table>
            <hr>
            <p style="line-height: 30px;">
                <%=car.getDescription() %>
            </p>
        </div>

        <div id="buy-info">
            <h2>구매 가이드</h2>
            <ul class="tab-buyguide">
                <li onclick="tabBuyguide(1)">허위매물 대처</li>
                <li onclick="tabBuyguide(2)">성능 상태 점검기록부</li>
                <li onclick="tabBuyguide(3)">차량 금액 외 별도 수수료</li>
                <li onclick="tabBuyguide(4)">차량 이전등록</li>
                <li onclick="tabBuyguide(5)">차량체크 사항</li>
            </ul>

            <div style="height: 250px;">
                <ul class="list-buyguide">
                    <li>가격이 수시로 여러번 오르고 내리는 형태를 보이는 매물</li>
                    <li>전화상담 직원과 차량 응대 직원이 다를 경우 (자연스럽게 여러가지 핑계를 댄다.)</li>
                    <li>상담했던 차량과 다른 차량을 보여주거나 권하는 매물, 저렴하면서 좋은 중고차는 세상에 존재하지 않는다는 것을 잊지 마세요.</li>
                </ul>
                <ul class="list-buyguide">
                    <li>성능 &middot; 상태 점검기록부에 점검자와 고지자의 서명날인된 원본을 받습니다.</li>
                    <li>보증수리 주체가 누구인지 명기되지 않았다면, 계약서의 보증책임주체를 명기합니다.</li>
                </ul>
                <ul class="list-buyguide">
                    <li>차량금액 외 별도의 수수료가 발생하는지 계약 진행 전 챙기도록 합니다.</li>
                    <li>모든 수수료에 대해 영수증을 받습니다.</li>
                </ul>
                <ul class="list-buyguide">
                    <li>차량 이전등록업무를 맡길 경우 별도의 이전등록수수료가 얼마인지 사전에 묻고, 이전등록이 끝난뒤 수수료외 납부한 모든 금액에 대해 영수증을 확인합니다.</li>
                </ul>
                <ul class="list-buyguide">
                    <li>매뉴얼이 있는지 확인합니다. (수입차는 별도 매뉴얼을 구하기 어렵고, 높은 비용이 발생함.)</li>
                    <li>보조키가 있는지 확인합니다. (이모빌라이져 기능이 있는 키나, 스마트키는 추가 비용이 높음.)</li>
                    <li>겨울에는 에어컨 상태를, 여름에는 히터 상태를 확인합니다. (판매자가 점검을 잊기 쉬움.)</li>
                    <li>스페어타이어는 밖으로 빼서 확인합니다. (쓸 수 없는 타이어가 들어있는 경우가 많음.)</li>
                    <li>차량 공구 및 비상 삼각거치대 유무를 확인합니다. (출고 후 다시 찾아가 요청하기 힘든 품목.)</li>
                    <li>출고 전 차량의 하체를 확인하여 부식 상태와 충격 유무를 확인합니다.</li>
                    <li>내비게이션이 장착된 차량은 차량을 움직여 봄으로써 GPS와 기계 정상 작동을 확인합니다.</li>
                    <li>남아있는 신차 보증기간과 신차 출고 시 제공한 쿠폰이 있는지 확인합니다. (전자쿠폰은 눈으로 확인이 불가한 경우도 있음)</li>
                </ul>
            </div>
        </div>
    </div>
    
	<div style="background-color: #f1f1f1; padding: 40px;">
		<p style="text-align: center; color: rgb(116, 116, 116); font-family: 'Montserrat', sans-serif;">© Copyright 2019 KooKSan - All rights reserved.</p>
	</div>
</body>
</html>