<%@page import="usedcar.shopping.CarListDBBean"%>
<%@page import="usedcar.shopping.CarListDataBean"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	request.setCharacterEncoding("utf-8");

	CarListDBBean carProcess = CarListDBBean.getInstance();
	CarListDataBean carDB = new CarListDataBean();
	
	List<String> car_brandList = carProcess.getCarBrandList();
	
%>

	
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet">

<%
//bootstrap 사용할 때 
//<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
%>


<!-- stylesheet link  -->
<link rel="stylesheet" href="stylesheet/ShopMain.css">
<link rel="stylesheet" href="stylesheet/footer.css">
<link rel="stylesheet" href="stylesheet/top.css">



<title>K O O K S A N</title>

    <style>
        /* css 초기화  */
		* {
	        margin: 0;
	        padding: 0;
	        box-sizing: border-box;
	        font-family: 'Montserrat', sans-serif;
        }
 	</style>

    <script>
        /* 처음 셋팅 : Company를 선택하기 전에는 model과 fuel을 선택할 수 없도록 함 */
        function init() {
            var mainModel = document.getElementById("main-model");
            var oilType =  document.getElementById("main-oil_type");

            mainModel.disabled = 'disabled';
            oilType.disabled = 'disabled';

            mainModel.style.color = "lightgray";
            oilType.style.color = "lightgray";
        }

        function clicked() {
            var name = "";
        }
        
        /* 첫 번째 selectbox onchange 이벤트 : company가 선택되었을 때 model을 선택할 수 있도록 함  */
        function selectCompany() {
        	// --------- ajax 시작 : car_brand를 선택하면 선택한 car_brand값으로 이 값에 맞는 model만 추출하기 위한 작업
    	   	var xhttp = new XMLHttpRequest();
    	   	var car_brand = document.getElementById('main-company_name').value;
    	   	/* $('#main-model option').remove();도 가능하다. */
    	   	$('#main-model').empty();
    	
    	   	xhttp.onreadystatechange = function() {
    	   		if(this.readyState == 4 && this.status == 200) {
    	   			$('#main-model').append(this.responseText);
    	   		}
    	   	};
    	   	xhttp.open("GET", "ShopMainPro.jsp?car_brand="+ encodeURI(car_brand), true);
    	   	xhttp.send();
    	   	// --------- ajax 끝
        	
            var mainModel = document.getElementById("main-model");
            var oilType =  document.getElementById("main-oil_type");

            mainModel.disabled = 'disabled';
            oilType.disabled = 'disabled';

            mainModel.style.color = "lightgray";
            oilType.style.color = "lightgray";

            var select_company = document.getElementById('main-company_name');
            /* select element에서 선택 된 option의 value를 저장 */
            var selectedCompany = select_company.options[select_company.selectedIndex].value;
            
            if(selectedCompany != null || selectedCompany != "") {
                mainModel.removeAttribute("disabled");
                mainModel.style.color ="";
            }
        }

        /* model이 선택되었을 때 fuel을 선택할 수 있도록 함 */
        function selectModel() {
            var oilType = document.getElementById("main-oil_type");

            var select_model = document.getElementById("main-model");
            var selectModel = select_model.options[select_model.selectedIndex].value;

            if(selectModel != null || selectModel != "") {
                oilType.removeAttribute("disabled");
                oilType.style.color ="";
            }
        }
        
    	 
    </script>

</head>




<body onload="init()">

    <!-- 상단 메뉴바 들어올 곳 -->
    <header id="main-header">
        <jsp:include page="module/top.jsp" flush="false" />
    </header>

    <div id="main-container">
        <div class="main-searchTool">
            <h3 class="main-insideTitle">중고차 매물 검색</h3>
            <br />
            
            <section class="main-search_section">
                <div class="main-container">
                    <!-- 검색하면 parameter값을 넘길 곳을 action에 설정 -->
                    <form action="list/searchmenu.jsp" method="GET">
                        <div id="main-search_control" class="main-search_control">
                            <div class="main-selectors" id="main-selectors">
                               
                                <!-- 회사 select box 시작 -->
                                <div class="main-select_company">
                                    <select name="car_brand" id="main-company_name" class="main-company_name" onchange="selectCompany()" >
                                        <option value="" hidden>Company</option>
                                        <% for(int i = 0; i < car_brandList.size(); i++) { %>
                                        <option value="<%=car_brandList.get(i) %>"><%=car_brandList.get(i) %></option>
                                        <% } %>
                                    </select>
                                </div>
                                <!-- 회사 select box 끝 -->
                                
                                <!-- 모델 select box 시작 -->
                                <div class="main-select_model">
                                 <select name="car_model" id="main-model" class="main-model" onchange="selectModel()">
                                 	<option value="" hidden>Model</option>
                                     <!-- ### ajax 들어오는 곳 ### -->
                                 </select>
                                </div>
                                <!-- 모델 select box 끝 -->
                                
                                <!-- Feul select box 시작 -->
                                <div class="main-select_model_detail">
                                    <select name="car_oilType" id="main-oil_type" class="main-oil_type">
                                        <option value="" hidden>Fuel</option>
                                        <option value="가솔린">가솔린</option>
                                        <option value="디젤">디젤</option>
                                        <option value="LPG">LPG(일반인구입)</option>
                                        <option value="가솔린+전기">가솔린+전기</option>
                                        <option value="LPG+전기">LPG+전기</option>
                                        <option value="가솔린+LPG">가솔린+LPG</option>
                                        <option value="가솔린+CNG">가솔린+CNG</option>
                                        <option value="전기">전기</option>
                                        <option value="수소">수소</option>
                                    </select>
                                </div> 
                                <!-- Feul select box 끝 -->
                                 
                            </div>
                            <button type="submit" class="main-submit_btn" onclick="clicked()">Search</button>
                        </div>
                    </form>
                </div>
            </section>
            
        </div>
    </div>

    <br><br><br>
    <hr>

    <!-- footer공간 -->
    <div id="main-footer">
        <jsp:include page="module/footer.html" flush="false" />
    </div>
	
</body>

</html>