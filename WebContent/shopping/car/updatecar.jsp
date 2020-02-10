<%@page import="usedcar.shopping.CarListDataBean"%>
<%@page import="usedcar.shopping.CarListDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int car_idx = Integer.parseInt(request.getParameter("car_idx"));
	
	CarListDBBean dao = CarListDBBean.getInstance();
	CarListDataBean dto = dao.getCarInfo(car_idx);
	
	String id = (String)session.getAttribute("user_id");

	try {
		if(id == null) {
			response.sendRedirect("http://localhost:8888/UsedCar10/ShopMain.jsp");
		} else {

%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품 정보 입력</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../../stylesheet/footer.css">
<link rel="stylesheet" type="text/css" href="../../stylesheet/top.css">
<link rel="stylesheet" type="text/css" href="../../css/left.css">
<link rel="stylesheet" type="text/css" href="../../css/customerupdate.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<style>
* {
	font-family: 'Montserrat', sans-serif;
}

.popover {
    max-width: 700px;
    margin-left: 150px;
    box-shadow: 5px 5px 5px gray;
}
.title{
    color: coral;
    font-size: 20px;
    font-weight: bold;
    text-align: center;
    margin: 30px;
}
.colorBx{
    text-align: center;
    border: 2px solid black;
    cursor: pointer;
}
.row{
    width: 100%;
    margin-bottom: 10px;
}
.item_title{
    width: 100px;
    margin-left: 15px;
    margin-right: 30px;
    font-size: 16px;
    font-weight: bold;
}
select{
    width: 150px;
}
table{
    width: 100%;
}
td.optList{
    width: 150px;
}
td.input[type="radio"]{
    width:100px;
}

/* top 제어 */
#header-container {
	width: 1200px;
	margin: 0 auto;
	font-size: 100%;
}
.fas {
	cursor: pointer;
}
</style>
</head>
<body>
	<!-- 상단 메뉴바 들어올 곳 -->
    <header id="main-header">
        <jsp:include page="../../module/top.jsp" flush="false" />
    </header>
    <div id="nav-sidebar">
		<jsp:include page="../../module/left.jsp" flush="false" />
	</div>
	
    <div class="container" style="width: 100%;">
        <div class="title">중고 자동차 수정</div>
        <div class="row"><span class="item_title">제목</span><input type="text" name="select_title" style="width:900px"></div>
        <div class="row"><span class="item_title">상세설명</span><p><textarea name="select_description" cols="98" rows="10"></textarea></p></div>
        <script>
        </script>
        <div class="row"><span class="item_title">차종</span>
            <table style="width: 80%;">
                <tr>
                    <td><input type="radio" name="select_type" value="경차">경차</input></td>
                    <td><input type="radio" name="select_type" value="소형차">소형차</input></td>
                    <td><input type="radio" name="select_type" value="준중형차">준중형차</input></td>
                    <td><input type="radio" name="select_type" value="중형차">중형차</input></td>
                    <td><input type="radio" name="select_type" value="대형차">대형차</input></td>
                    <td><input type="radio" name="select_type" value="스포츠카">스포츠카</input></td>
                    <td><input type="radio" name="select_type" value="SUV">SUV</input></td>
                    <td><input type="radio" name="select_type" value="RV">RV</input></td>
                    <td><input type="radio" name="select_type" value="경승합차">경승합차</input></td>
                    <td><input type="radio" name="select_type" value="승합차">승합차</input></td>
                    <td><input type="radio" name="select_type" value="화물차">화물차</input></td>
                    <td><input type="radio" name="select_type" value="기타">기타</input></td>
                </tr>
            </table>
        </div>
        <div class="row">
            <span class="item_title">제조사</span>
            <select name="select_brand" onchange=selectModel()>
                <option value="none">선택</option>
                <option value="현대">현대</option>
                <option value="기아">기아</option>
                <option value="제네시스">제네시스</option>
                <option value="쉐보레">쉐보레</option>
                <option value="르노삼성">르노삼성</option>
                <option value="쌍용">쌍용</option>
            </select>
            &emsp;&emsp;
            <span class="item_title">모델</span>
            <select name="select_model">
                <option value="none">선택</option>
            </select>
            <span class="item_title">배기량</span><input type="text" name="select_cc" style="width: 150px; margin-left: -50px; margin-right: 4px;">cc&ensp;&nbsp;
        </div>
        <div class="row">
            <span class="item_title">가격</span><input type="text" name="select_price" style="width: 150px; margin-right: 4px;">만원
            <span class="item_title" style="margin-left: 10px;">지역</span>
            <select name="select_location1" id="city" onchange=selectArea()>
                <option value="none">선택</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="인천">인천</option>
                <option value="대전">대전</option>
                <option value="세종">세종</option>
                <option value="충남">충남</option>
                <option value="충북">충북</option>
                <option value="강원">강원</option>
                <option value="충남">충남</option>
                <option value="부산">부산</option>
                <option value="대구">대구</option>
                <option value="울산">울산</option>
                <option value="경남">경남</option>
                <option value="경북">경북</option>
                <option value="광주">광주</option>
                <option value="전북">전북</option>
                <option value="제주">제주</option>
            </select>&ensp;
            <select name="select_location2" id="area">
                <option value="none">선택</option>
            </select>
        </div>
        <div class="row">
            <span class="item_title">연료</span>
            <select name="select_oilType" id="oilType">
                <option value="none">선택</option>
                <option value="가솔린">가솔린</option>
                <option value="디젤">디젤</option>
                <option value="LPG">LPG</option>
                <option value="가솔린+전기">가솔린+전기</option>
                <option value="LPG+전기">LPG+전기</option>
                <option value="가솔린+LPG">가솔린+LPG</option>
                <option value="가솔린+CNG">가솔린+CNG</option>
                <option value="전기">전기</option>
                <option value="수소">수소</option>
            </select>&emsp;&emsp;
            <span class="item_title">주행거리</span><input type="text" name="select_mileage" style="width: 150px; margin-right: 4px;">Km&ensp;&nbsp;
            <span class="item_title">연식</span><input type="text" name="select_birth" style="width: 150px; margin-left: -39px; margin-right: 4px;">년식&ensp;&nbsp;
        </div>
        <div class="row">
            <span class="item_title">색  상</span><span id="colorWindow" style="width: 88px; text-align: center; margin-top: 2px;">color</span><button class="collapsed card-link" data-toggle="collapse" onclick=colorShow() style="margin-right: 14px;">색상선택</button>
            <div class="popover fade bs-popover-right" role="tooltip" id="colorExtendWindow" style="position: absolute; transform: translate3d(560px, 532px, 0px); top: 0px; left: 0px; z-index: -1;" x-placement="right">
                <div class="arrow" style="top: 33px;"></div>
                <div class="popover-body" style="width: 700px;">
                    <div>
                        <span style="float:left; font-weight: bold;">색상선택</span><i class="fas fa-times"
                            style="float:right; margin-left: 0px;" onclick=colorShow()></i><br>
                    </div>
                    <hr style="margin-top:5px; margin-bottom:5px;">
                    <table class="table table-bordered">
                        <tr>
                            <td class="colorBx" style="background-color: black; color: white;" onclick=selectColor()>검정색</td class="colorBx">
                            <td class="colorBx" style="background-color: white; color: black;" onclick=selectColor()>흰색</td>
                            <td class="colorBx" style="background-color: #606060; color: white;" onclick=selectColor()>갈대색</td>
                            <td class="colorBx" style="background-color: blue; color: white;" onclick=selectColor()>청색</td>
                            <td class="colorBx" style="background-color: red; color: white;" onclick=selectColor()>적색</td>
                        </tr>
                        <tr>
                            <td class="colorBx" style="background: linear-gradient(to right, #606060 50%, #000000 50%); color: white;" onclick=selectColor()>검정투톤</td>
                            <td class="colorBx" style="background-color:beige; color: black;" onclick=selectColor()>진주색</td>
                            <td class="colorBx" style="background-color:#d7be69; color: white;" onclick=selectColor()>연금색</td>
                            <td class="colorBx" style="background-color:skyblue; color: white;" onclick=selectColor()>하늘색</td>
                            <td class="colorBx" style="background-color:orange; color: white;" onclick=selectColor()>주황색</td>
                        </tr>
                        <tr>
                            <td class="colorBx" style="background-color: #727875; color: white;" onclick=selectColor()>쥐색</td>
                            <td class="colorBx" style="background: linear-gradient(to right, #727875 50%, #ffffff 50%); color: black;" onclick=selectColor()>흰색투톤</td>
                            <td class="colorBx" style="background-color:brown; color: white;" onclick=selectColor()>갈색</td>
                            <td class="colorBx" style="background-color:#59b300; color: white;" onclick=selectColor()>담녹색</td>
                            <td class="colorBx" style="background-color:rgb(234, 2, 255); color: white;" onclick=selectColor()>자주색</td>
                        </tr>
                        <tr>
                            <td class="colorBx" style="background-color: silver; color: black;" onclick=selectColor()>은색</td >
                            <td class="colorBx" style="background: linear-gradient(to right, gray 50%, beige 50%); color: black;" onclick=selectColor()>진주투톤</td>
                            <td class="colorBx" style="background: linear-gradient(to right, gray 50%, brown 50%); color: white;" onclick=selectColor()>갈색투톤</td>
                            <td class="colorBx" style="background-color: green; color: white;" onclick=selectColor()>녹색</td>
                            <td class="colorBx" style="background-color:rgb(70, 0, 128); color: white;" onclick=selectColor()>보라색</td>
                        </tr>
                        <tr>
                            <td class="colorBx" style="background-color: #c5d0d3; color: black;" onclick=selectColor()>은회색</td>
                            <td class="colorBx" style="background-color: gainsboro; color: black;" onclick=selectColor()>은하색</td>
                            <td class="colorBx" style="background-color: rgb(209, 196, 120); color: white;" onclick=selectColor()>금색</td>
                            <td class="colorBx" style="background-color: lightgreen; color: black;" onclick=selectColor()>연두색</td>
                            <td class="colorBx" style="background-color: pink; color: black;" onclick=selectColor()>분홍색</td>
                        </tr>
                        <tr>
                            <td class="colorBx" style="background: linear-gradient(to right, #606060 50%, silver 50%); color: white;" onclick=selectColor()>은색투톤</td>
                            <td class="colorBx" style="background-color: rgba(192, 192, 192, 0.836); color: black;" onclick=selectColor()>명은색</td>
                            <td class="colorBx" style="background: linear-gradient(to right, #606060 50%, gold 50%); color: white;" onclick=selectColor()>금색투톤</td>
                            <td class="colorBx" style="background-color: #009999; color: white;" onclick=selectColor()>청옥색</td>
                            <td class="colorBx" style="background-color: yellow; color: black;" onclick=selectColor()>노란색</td>
                        </tr>
                    </table>
                </div>
            </div>
            <span class="item_title">변속기</span>
            <select name="select_gear">
                <option value="none">선택</option>
                <option value="오토">오토</option>
                <option value="수동">수동</option>
                <option value="세미오토">세미오토</option>
                <option value="CVT">CVT</option>
                <option value="기타">기타</option>
            </select>
            <span class="item_title">등록번호</span><input type="text" name="select_regNum">
        </div>
        <hr>
        <div class="row" style="width: 1300px;">
            <span class="item_title">옵션선택</span><br>
            <div>
                <div style="font-weight: bold;">외관내장</div>
                <table class="table-borderless">
                    <tr>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="sunroof" name="select_option" /><span>선루프</span></span>
                        </td>
                        <td><span style="float: left;" class="optList"><input type="checkbox" class="headlamp" name="headlamp" /><span>헤드램프(<input type="radio" class="headlamp" value="HID" name="select_option" />HID
                                    <input type="radio" class="headlamp" value="LED" name="select_option" />LED)</span></span>
                        </td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="PET" name="select_option" /><span>파워 전동 트렁크</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="GDC" name="select_option" /><span>고스트 도어 클로징</span></span></td>
                    </tr>
                    <tr>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="EFSM" name="select_option" /><span>전동접이 사이드 미러</span></span>
                        </td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="AW" name="select_option" /><span>알루미늄 휠</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="roofrack" name="select_option" /><span>루프랙</span></span>
                        </td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="HSW" name="select_option" /><span>열선 스티어링 휠</span></span></td>
                    </tr>
                    <tr>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="ECSW" name="select_option" /><span>전동 조절 스티어링 휠</span></span>
                        </td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="paddleshift" name="select_option" /><span>패들
                                    시프트</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="SWR" name="select_option" /><span>스티어링 휠 리모컨</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="ECMroommirror" name="select_option" /><span>ECM
                                    룸미러</span></span></td>
                    </tr>
                    <tr>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="hipass" name="select_option" /><span>하이패스</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="powerdoorlock" name="select_option" /><span>파워
                                    도어록</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="PSW" name="select_option" /><span>파워 스티어링 휠</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="powerwindow" name="select_option" /><span>파워
                                    윈도우</span></span></td>
                    </tr>
                </table>
                <hr style="margin-top:5px; margin-bottom:5px;">
                <div style="font-weight: bold;">안전</div>
                <table class="table-borderless">
                    <tr>
                        <td><span style="float: left;" class="optList"><input type="checkbox" class="airbag" name="airbag" /><span>에어백(
                            <input type="checkbox" class="airbag" value="airbag_drivingseat" name="select_option" />운전석
                            <input type="checkbox" class="airbag" value="airbag_assistantseat" name="select_option" />동승자)</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="airbag_side"
                                    name="select_option" /><span>에어백(사이드)</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="airbag_curtain"
                                    name="select_option" /><span>에어백(커튼)</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="ABS" name="select_option" /><span>브레이크 잠김 방지(ABS)</span></span>
                        </td>
                    </tr>
                    <tr>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="TCS" name="select_option" /><span>미끄럼방지(TCS)</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="ESC" name="select_option" /><span>차체 자세 제어장치(ESC)</span></span>
                        </td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="TPMS" name="select_option" /><span></span>타이어
                                공기압센서(TPMS)</span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="LDWS" name="select_option" /><span>차선이탈 경보
                                    시스템(LDWS)</span></span></td>
                    </tr>
                    <tr>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="ECS" name="select_option" /><span>전자제어 서스펜션(ECS)</span></span>
                        </td>
                        <td><span style="float: left;" class="optList"><input type="checkbox" class="PDC" name="option" /><span>주차감지센서(
                            <input type="checkbox" class="PDC" value="PDC_front" name="select_option" />전방
                            <input type="checkbox" class="PDC" value="PDC_behind" name="select_option" />후방)</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="BSAS" name="select_option" /><span>후측방 경보시스템</span></span>
                        </td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="camera_behind"
                                    name="select_option" /><span>후방카메라</span></span></td>
                    </tr>
                    <tr>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="aroundview" name="select_option" /><span>360도 어라운드
                                    뷰</span></span></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
                <hr style="margin-top:5px; margin-bottom:5px;">
                <div style="font-weight: bold;">편의/멀티미디어</div>
                <table class="table-borderless">
                    <tr>
                        <td><span style="float: left;" class="optList"><input type="checkbox" class="cruisecontrol" name="cruisecontrol" /><span>크루즈 컨트롤(
                            <input type="checkbox" class="cruisecontrol" value="cruisecontrol_normal" name="select_option" />일반
                            <input type="checkbox" class="cruisecontrol" value="cruisecontrol_adaptive" name="select_option" />어댑티브)</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="HUD" name="select_option" /><span>헤드업 디스플레이(HUD)</span></span>
                        </td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="EPB" name="select_option" /><span>전자식 주차브레이크(EPB)</span></span>
                        </td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="autoaircon" name="select_option" /><span>자동
                                    에어컨</span></span></td>
                    </tr>
                    <tr>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="smartkey" name="select_option" /><span>스마트키</span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="wirelessdoorlock" name="select_option" /><span>무선
                                    도어 잠금장치</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="rainsensor"
                                    name="select_option" /><span></span>레인센서</span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="autolight" name="select_option" /><span>오토
                                    라이트</span></span></td>
                    </tr>
                    <tr>
                        <td><span style="float: left;" class="optList"><input type="checkbox" class="curtain_blind" name="curtain_blind" /><span>커튼/블라인드(
                            <input type="checkbox" class="curtain_blind" value="curtain_blind_behindseat" name="select_option" />뒷좌석
                            <input type="checkbox" class="curtain_blind" value="curtain_blind_behind" name="select_option" />후방)</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="navigation"
                                    name="select_option" /><span>내비게이션</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="AV_monitor_front" name="select_option" /><span>앞좌석
                                    AV 모니터</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="AV_monitor_behind"
                                    name="select_option" /><span>뒷좌석 AV 모니터</span></span>
                        </td>
                    </tr>
                    <tr>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="bluetooth"
                                    name="select_option" /><span>블루투스</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="CDplayer"
                                    name="select_option" /><span>CD플레이어</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="USB" name="select_option" /><span>USB단자</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="AUX" name="select_option" /><span>AUX단자</span></span></td>
                    </tr>
                </table>
                <hr style="margin-top:5px; margin-bottom:5px;">
                <div style="font-weight: bold;">시트</div>
                <table class="table-borderless">
                    <tr>
                        <td><span style="float: left;" class="optList"><input type="checkbox" value="leaderseat"
                                    name="select_option" /><span>가죽시트</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox" class="electricseat" name="electricseat" /><span>전동시트(
                            <input type="checkbox" class="electricseat" value="electricseat_drivingseat" name="select_option" />운전석
                            <input type="checkbox" class="electricseat" value="electricseat_assistantseat" name="select_option" />동승석)</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="electricseat_behind"
                                    name="select_option" /><span>전동시트(뒷좌석)</span></span>
                        </td>
                        <td><span style="float: left;" class="optList"><input type="checkbox" class="heatseat" name="heatseat" /><span>열선시트(
                            <input type="checkbox" class="heatseat" value="heatseat_front" name="select_option" />앞좌석
                            <input type="checkbox" class="heatseat" value="heatseat_behind" name="select_option" />뒷좌석)</span></span></td>
                    </tr>
                    <tr>
                        <td><span style="float: left;" class="optList"><input type="checkbox" class="memoryseat" name="memoryseat" /><span>메모리시트(
                            <input type="checkbox" class="memoryseat" value="memoryseat_drivingseat" name="select_option" />운전석
                            <input type="checkbox" class="memoryseat" value="memoryseat_assistantseat" name="select_option" />동승석)</span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox" class="airseat" name="airseat" /><span>통풍시트(
                            <input type="checkbox" class="airseat" value="airseat_drivingseat" name="select_option" />운전석
                            <input type="checkbox" class="airseat" value="airseat_assistantseat" name="select_option" />동승석)</span></span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="airseat_behind"
                                    name="select_option" /><span></span>통풍시트(뒷좌석)</span></td>
                        <td><span style="float: left;" class="optList"><input type="checkbox"
                                    value="massageseat" name="select_option" /><span>마사지
                                    시트</span></span></td>
                    </tr>
                </table>
            </div>
        </div> 
        <form action="" method="post" enctype="multipart/form-data">
            <input type="hidden" name="car_idx">
            <input type="hidden" name="title">
            <input type="hidden" name="description">
            <input type="hidden" name="car_type">
            <input type="hidden" name="car_brand">
            <input type="hidden" name="car_model">
            <input type="hidden" name="car_cc">
            <input type="hidden" name="car_oilType">
            <input type="hidden" name="car_mileage">
            <input type="hidden" name="car_birth">
            <input type="hidden" name="car_price">
            <input type="hidden" name="car_location">
            <input type="hidden" name="car_color">
            <input type="hidden" name="car_gear">
            <input type="hidden" name="car_regNum">
            <div class="row">
                <span class="item_title">사진첨부</span>
                <input type="file" name="car_img1" style="width: 250px;"></input>
                <input type="file" name="car_img2" style="width: 250px;"></input>
                <input type="file" name="car_img3" style="width: 250px;"></input>
            </div>
            <input type="hidden" name="car_option">
            <input type="button" class="btn btn-success" style="margin-left: 450px; margin-top: 50px;" value="입력완료" onclick="dataCollect(this.form)">
        </form>
    </div>
    <script>
    //=====================================================차량 list resource========================================================================
    var hyundaicarlist = ["i30", "i40", "갤로퍼", "그라나다", "그랜저", "그레이스", "넥쏘", "다이너스티", "라비타", "마르샤",
					"맥스크루즈", "베뉴", "베라크루즈", "베르나", "벨로스터", "블루온", "산타모", "스쿠프", "스타렉스", "스텔라", "산타페", "쏘나타",
					"쏠라티", "아반떼", "아슬란", "아이오닉", "아토스", "에쿠스", "엑센트", "엑셀", "엘란트라", "제네시스", "코나", "코티나", "클릭", "테라칸",
					"투스카니", "투싼", "트라제XG", "티뷰론", "펠리세이드", "포니", "프레스토"];
    var kiacarlist = ["K3", "K5", "K7", "K9", "X-TREK", "니로", "델타", "레이", "레토나", "로체", "록스타", "리갈", "리오", "모닝", "모하비", "베스타",
        "봉고III 미니버스", "브리샤", "비스토", "세피아", "셀토스", "슈마", "스토닉", "스팅어", "스펙트라", "스포티지", "쎄라토", "쏘렌토", "쏘울",
        "아벨라", "엔터프라이즈", "엘란", "오피러스", "옵티마", "카니발", "카렌스", "카스타", "캐피탈", "콩코드", "크레도스", "타우너", "토픽", "파크타운",
        "포르테", "포텐샤", "프라이드", "프레지오", "피아트132"];			
    var genesiscarlist = ["G70", "G80", "G90", "EQ900"];
    var chevroletcarlist = ["G2X", "넥시아", "누비라", "다마스", "라노스", "라보", "라세티", "레간자", "레조", "로얄살롱", "르망", "마티즈", "말리부", "매그너스",
        "맵시", "베리타스", "볼트EV", "볼트(volt)", "브로엄", "슈퍼살롱", "스테이츠맨", "스파크", "씨에로", "아베오", "아카디아", "알페온", "에스페로",
        "올란도", "윈스톰", "이쿼녹스", "임팔라", "임페리얼", "젠트라", "카마로", "칼로스", "캡티바", "콜로라도", "콜벳", "크루즈", "토스카", "트래버스", "트랙스",
        "티코", "프린스"];
    var samsungcarlist = ["SM3", "SM5", "SM6", "SM7", "QM3", "QM5", "QM6", "마스터", "클리오", "트위지"];
    var ssangyongcarlist = ["뉴훼미리", "렉스턴", "로디우스", "무쏘", "액티언", "이스타나", "체어맨", "칼리스타", "카이런", "코란도", "티볼리"];
	//===============================================================================================================================================
    //===============================================location city resource==============================================================================
    var seoul = ["강남구", "강동구", "강서구", "강북구", "관악구", "광진구", "구로구", "금천구",
        "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성북구", "송파구", "양천구",
        "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"];
    var kyunggi = ["고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시",
        "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시", "안양시", "양주시", "양평군", "여주시",
        "연천군", "오산시", "용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시", "화성시"];
    var incheon = ["계양구", "남구", "남동구", "동구", "미추홀구", "부평구", "서구", "연수구", "중구"];
    var daejeon = ["광역시", "대덕구", "동구", "서구", "유성구", "중구"];
    var choongnam = ["계룡시", "공주시", "금산군", "논산시", "당진시", "보령시", "부여군", "서산시", "서천군",
        "아산시", "예산군", "천안시", "청양군", "태안군", "홍성군"];
    var choongbook = ["괴산군", "영동군", "음성군", "제천시", "진천군", "청주시", "충주시"];
    var kangwon = ["강릉시", "동해시", "삼척시", "속초시", "원주시", "인제군", "철원군", "춘천시", "홍천군"];
    var busan = ["강서구", "금정구", "기장군", "남구", "동구", "동래구", "부산진구", "북구", "사상구",
        "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구"];
    var daegu = ["남구", "달서구", "달성군", "동구", "북구", "서구", "수성구", "중구"];
    var ulsan = ["남구", "동구", "북구", "울주군", "중구"];
    var kyungnam = ["거제시", "거창군", "김해시", "남해군", "마산시", "밀양시", "사천시", "산청군", "양산시",
        "의령군", "진주시", "진해시", "창원시", "통영시", "함안군", "합천군"];
    var kyungbook = ["경산시", "경주시", "고령군", "구미시", "군위군", "김천시", "문경시", "상주시", "성주군",
        "안동시", "영덕군", "영주시", "영천시", "예천군", "의성군", "청도군", "칠곡군", "포항시"];
    var kwangju = ["광산구", "남구", "동구", "북구", "서구"];
    var jeonnam = ["고흥군", "광양시", "나주시", "목포시", "무안군", "보성군", "순천시", "여수시", "영광군",
        "영암군", "완도군", "장성군"];
    var jeonbook = ["고창군", "군산시", "김제시", "남원시", "부안군", "완주군", "익산시", "전주시", "정읍시"];
    var jeju = ["서귀포시", "제주시"];
    //===============================================================================================================================================

    // head lamp defaultcheck
    var headlamp = document.getElementsByClassName('headlamp');
    headlamp[0].onclick = function () {
        if (this.checked == true) {
            headlamp[1].checked = true;
        } else if (this.checked == false) {
            headlamp[1].checked = false;
            headlamp[2].checked = false;
        }
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

    //=============car Model list 생성====================
    function selectModel(){
        $('select[name=select_model]').empty();
        var modelObj = document.getElementsByName('select_model');
        var brandObj = document.getElementsByName('select_brand');
        var brandList = null;
        if(brandObj[0].value=="현대"){
            brandList = hyundaicarlist;
        } else if(brandObj[0].value=="기아"){
            brandList = kiacarlist;
        } else if(brandObj[0].value=="제네시스"){
            brandList = genesiscarlist;
        } else if(brandObj[0].value=="쉐보레"){
            brandList = chevroletcarlist;
        } else if(brandObj[0].value=="르노삼성"){
            brandList = samsungcarlist;
        } else if(brandObj[0].value=="쌍용"){
            brandList = ssangyongcarlist;
        } else{
            brandList = ["선택"];
        }
        for (var model of brandList) {
            var opt = document.createElement('option');
            opt.value = model;
            opt.innerHTML = model;
            modelObj[0].appendChild(opt);
		};
    }
    //=======================================================

    //=============location area list 생성====================
    function selectArea(){
        $('#area').empty();
        var areaObj = document.getElementsByName('select_location2');
        var cityObj = document.getElementsByName('select_location1');
        var cityList = null;
        if(cityObj[0].value=="서울"){
            cityList = seoul;
        } else if(cityObj[0].value=="경기"){
            cityList = kyunggi;
        } else if(cityObj[0].value=="인천"){
            cityList = incheon;
        } else if(cityObj[0].value=="대전"){
            cityList = daejeon;
        }  else if(cityObj[0].value=="충남"){
            cityList = choongnam;
        } else if(cityObj[0].value=="충북"){
            cityList = choongbook;
        } else if(cityObj[0].value=="강원"){
            cityList = kangwon;
        } else if(cityObj[0].value=="부산"){
            cityList = busan;
        } else if(cityObj[0].value=="대구"){
            cityList = daegu;
        } else if(cityObj[0].value=="울산"){
            cityList = ulsan;
        } else if(cityObj[0].value=="경남"){
            cityList = kyungnam;
        } else if(cityObj[0].value=="경북"){
            cityList = kyungbook;
        } else if(cityObj[0].value=="광주"){
            cityList = kwangju;
        } else if(cityObj[0].value=="전남"){
            cityList = jeonnam;
        } else if(cityObj[0].value=="전북"){
            cityList = jeonbook;
        } else if(cityObj[0].value=="제주"){
            cityList = jeju;
        } else {
            cityList=["선택"];
        }
        for (var city of cityList) {
            var opt = document.createElement('option');
            opt.value = city;
            opt.innerHTML = city;
            areaObj[0].appendChild(opt);
		};
    }
    //=======================================================

    //=====================color 창 보이기/숨기기==================  
    function colorShow() {
        var colorExtendWindow = document.getElementById('colorExtendWindow');
        if (colorExtendWindow.className == 'popover fade bs-popover-right show') {
            colorExtendWindow.className = 'popover fade bs-popover-right';
            colorExtendWindow.style.zIndex = -1;
        } else if (colorExtendWindow.className == 'popover fade bs-popover-right') {
            colorExtendWindow.className = 'popover fade bs-popover-right show'
            colorExtendWindow.style.zIndex = 1;
        }
    };
    //============================================================

    //=======================color클릭=========================
    function selectColor(){
        var colorObj = event.srcElement;
        var colorWindow = document.getElementById('colorWindow');
        var inputcolor = document.getElementsByName('car_color');
        inputcolor[0].value = colorObj.innerHTML;
        colorWindow.innerHTML = colorObj.innerHTML;
        colorShow()
    }
    //=========================================================

    //=====================data collect========================
    function dataCollect(form){
        form.car_idx.value = <%=car_idx %>;
        form.title.value = document.getElementsByName('select_title')[0].value;
        form.description.value = document.getElementsByName('select_description')[0].value.replace(/(?:\r\n|\r|\n)/g, '<br>');
        var car_typelist = document.getElementsByName('select_type');
        for(var type of car_typelist){
            if(type.checked==true){
                form.car_type.value = type.value;
            }
        }
        form.car_brand.value = document.getElementsByName('select_brand')[0].value;
        form.car_model.value = document.getElementsByName('select_model')[0].value;
        form.car_cc.value = document.getElementsByName('select_cc')[0].value;
        form.car_price.value = document.getElementsByName('select_price')[0].value;
        form.car_oilType.value = document.getElementsByName('select_oilType')[0].value;
        form.car_mileage.value = document.getElementsByName('select_mileage')[0].value;
        form.car_birth.value = document.getElementsByName('select_birth')[0].value;
        form.car_location.value = document.getElementsByName('select_location1')[0].value+" "+document.getElementsByName('select_location2')[0].value;
        form.car_color.value = document.getElementById('colorWindow').innerHTML;
        form.car_gear.value = document.getElementsByName('select_gear')[0].value;
        form.car_regNum.value = document.getElementsByName('select_regNum')[0].value;
        var car_optionlist = document.getElementsByName('select_option');
        for(var option of car_optionlist){
            if((option.selecetd==true||option.checked==true)&&option.value!=null){
                form.car_option.value += option.value+"/";
            }
        }
        form.car_option.value = form.car_option.value.substr(0, form.car_option.value.length-1);
        checkForm(form);
    }
    //=========================================================
    
    //=======================data 유효성 check====================
    function checkForm(carform) {
        if(!carform.title.value) {
            alert("제목을 입력해주세요");
            carform.title.focus();
            return false;
        }
        if(!carform.description.value) {
            alert("상세설명을 입력하십시오.");
            carform.description.focus();
            return false;
        }
        if(!carform.car_type.value) {
            alert("차종을 입력하십시오.");
            carform.car_type.focus();
            return false;
        }
        if(carform.car_brand.value=="none") {
            alert("제조사를 입력하십시오.");
            carform.car_brand.focus();
            return false;
        }
        if(carform.car_model.value=="none") {
            alert("모델을 입력하십시오.");
            carform.car_model.focus();
            return false;
        }
        if(!carform.car_cc.value) {
            alert("배기량를 입력하십시오.");
            carform.car_cc.focus();
            return false;
        }
        if(!carform.car_price.value) {
            alert("가격을 입력하십시오.");
            carform.car_price.focus();
            return false;
        }
        if(carform.car_location.value.match("none")) {
            alert("지역을 입력하십시오.");
            carform.car_location.focus();
            return false;
        }
        if(carform.car_oilType.value=="none") {
            alert("연료타입을 입력하십시오.");
            carform.car_oilType.focus();
            return false;
        }
        if(!carform.car_mileage.value) {
            alert("주행거리를 입력하십시오.");
            carform.car_mileage.focus();
            return false;
        }
        if(!carform.car_birth.value) {
            alert("연식을 입력하십시오.");
            carform.car_birth.focus();
            return false;
        }
        if(carform.car_color.value=="color") {
            alert("색상을 입력하십시오.");
            carform.car_color.focus();
            return false;
        }
        if(carform.car_gear.value=="none") {
            alert("변속기를 입력하십시오.");
            carform.car_gear.focus();
            return false;
        }
        if(!carform.car_regNum.value) {
            alert("등록번호를 입력하십시오.");
            carform.car_regNum.focus();
            return false;
        }
        if(!carform.car_img1.value) {
            alert("사진1를 입력하십시오.");
            carform.car_img1.focus();
            return false;
        }
        if(!carform.car_img2.value) {
            alert("사진2를 입력하십시오.");
            carform.car_img2.focus();
            return false;
        }
        if(!carform.car_img3.value) {
            alert("사진3를 입력하십시오.");
            carform.car_img3.focus();
            return false;
        }
        carform.action = "updatecarpro.jsp"
        carform.method = "POST"
        carform.submit();
    }
    //===========================================================
    //==== 시작시 DB데이터 자동 입력=====
    window.onload = function(){
        document.getElementsByName('select_title')[0].value = "<%=dto.getTitle() %>";
        document.getElementsByName('select_description')[0].value="<%=dto.getDescription() %>";
        document.getElementsByName('select_description')[0].value = document.getElementsByName('select_description')[0].value.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');
        console.dir(document.getElementsByName('select_description')[0].value);
        var car_typelist = document.getElementsByName('select_type');
        for(var type of car_typelist){
            if(type.value=="<%=dto.getCar_type() %>"){
                type.checked=true;
            }
        }
        document.getElementsByName('select_brand')[0].value = "<%=dto.getCar_brand() %>";
        selectModel();
        document.getElementsByName('select_model')[0].value = "<%=dto.getCar_model() %>";
        document.getElementsByName('select_cc')[0].value = "<%=dto.getCar_cc() %>";
        document.getElementsByName('select_price')[0].value = "<%=dto.getCar_price() %>";
        document.getElementsByName('select_oilType')[0].value = "<%=dto.getCar_oilType() %>";
        document.getElementsByName('select_mileage')[0].value = "<%=dto.getCar_mileage() %>";
        document.getElementsByName('select_birth')[0].value = "<%=dto.getCar_birth() %>";
        var locationValue = "<%=dto.getCar_location() %>";
        var locationValueArr = locationValue.split(" ");
        document.getElementsByName('select_location1')[0].value = locationValueArr[0];
        selectArea();
        document.getElementsByName('select_location2')[0].value = locationValueArr[1];
        document.getElementById('colorWindow').innerHTML = "<%=dto.getCar_color() %>";
        document.getElementsByName('select_gear')[0].value = "<%=dto.getCar_gear() %>";
        document.getElementsByName('select_regNum')[0].value = "<%=dto.getCar_regNum() %>";
        var optionDBValue = "<%=dto.getCar_option() %>";
        var optionDBValueArr = optionDBValue.split("/");
        var optionObj = document.getElementsByName('select_option');
        for(var i=0; i<optionDBValueArr.length; i++){
            for(var j=0; j<optionObj.length; j++){
                if(optionObj[j].value == optionDBValueArr[i]){
                    optionObj[j].checked = true;
                }
            }
        }
    }
    </script>
    
	<div style="background-color: #f1f1f1; padding: 40px;">
		<p style="text-align: center; color: rgb(116, 116, 116); font-family: 'Montserrat', sans-serif;">© Copyright 2019 KooKSan - All rights reserved.</p>
	</div>
</body>
</html>

<%  	
	}
} catch(NullPointerException e) {
	e.printStackTrace();
} catch(Exception e) {
	e.printStackTrace();
}
%>
