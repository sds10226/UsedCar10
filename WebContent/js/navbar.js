
		//6.네비게이션 스크롤 반영
        window.onscroll = function() {scrollFunction()};

        function scrollFunction() {
          var navbar = document.getElementsByClassName("navbar")[0];
          if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
        	  
        	  navbar.style.boxShadow = '0px 2px 5px #888888';
        	  navbar.style.backgroundColor = '#fff';
        	  navbar.style.color = 'dimgray';
        	  navbar.getElementsByClassName("navbar-title")[0].style.color = '#EE5A24';
              var a = navbar.getElementsByTagName("a");
              for (var i = 0; i < a.length; i++) {
				a[i].style.display = 'none';
              }
              var nav = navbar.getElementsByClassName("navbar-nav");
              for (var i = 0; i < nav.length; i++) {
  				nav[i].style.display = 'none';
              }
              var nav2 = navbar.getElementsByClassName("navbar-nav2");
              for (var i = 0; i < nav2.length; i++) {
  				nav2[i].style.display = 'inline';
              }
            
          } else {
        	  navbar.style.boxShadow = 'none';
        	  navbar.style.backgroundColor = '#EE5A24';
        	  navbar.style.color = '#fff';
        	  navbar.getElementsByClassName("navbar-title")[0].style.color = '#fff';
              var a = navbar.getElementsByTagName("a");
              for (var i = 0; i < a.length; i++) {
				a[i].style.display = 'inline';
              }
              var nav = navbar.getElementsByClassName("navbar-nav");
              for (var i = 0; i < nav.length; i++) {
  				nav[i].style.display = 'inline';
              }
              var nav2 = navbar.getElementsByClassName("navbar-nav2");
              for (var i = 0; i < nav2.length; i++) {
  				nav2[i].style.display = 'none';
              }
          }
        }
        function scrollDownTo(id) {
        	var top = document.getElementById(id).offsetTop-100;
        	window.scrollTo(0, top);
        }