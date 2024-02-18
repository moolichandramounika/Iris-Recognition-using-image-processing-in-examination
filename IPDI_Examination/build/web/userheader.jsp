<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>IPDI Exam</title>
<meta charset="utf-8">
<link rel="icon" href="images/favicon.ico">
<link rel="shortcut icon" href="images/favicon.ico">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/slider.css">
<script src="js/jquery.js"></script>
<script src="js/jquery.easing.1.3.js"></script>
<script src="js/jquery-migrate-1.1.1.js"></script>
<script src="js/superfish.js"></script>
<script src="js/jquery.equalheights.js"></script>
<script src="js/tms-0.4.1.js"></script>
<script src="js/jquery.carouFredSel-6.1.0-packed.js"></script>
<script src="js/jquery.ui.totop.js"></script>
<script>
$(window).load(function () {
    $('.slider')._TMS({
        show: 0,
        pauseOnHover: false,
        prevBu: '.prev',
        nextBu: '.next',
        playBu: false,
        duration: 800,
        preset: 'fade',
        easing: 'easeOutQuad',
        pagination: true, //'.pagination',true,'<ul></ul>'
        pagNums: false,
        slideshow: 8000,
        numStatus: false,
        banners: 'fade',
        waitBannerAnimation: false,
        progressBar: false
    })
});
$(window).load(
    function () {
        $('.carousel1').carouFredSel({
            auto: false,
            prev: '.prev1',
            next: '.next1',
            width: 960,
            items: {
                visible: {
                    min: 4,
                    max: 4
                },
            },
            responsive: false,
            scroll: 1,
            mousewheel: false,
            swipe: {
                onMouse: false,
                onTouch: false
            }
        });
    });

</script>
<script type="text/javascript">
function writeCookie() 
{

  var expire = "";
  var name1="hh";
  var name2="mm";
  var name3="ss";
  var hours="1";
  var value1="0";
  var value2="30";
  var value3="59";

  if(hours != null)

  {

    expire = new Date((new Date()).getTime() + hours * 3600000);

    expire = "; expires=" + expire.toGMTString();

  }

  document.cookie = name1 + "=" + escape(value1) + expire;
  document.cookie = name2 + "=" + escape(value2) + expire;
  document.cookie = name3 + "=" + escape(value3) + expire;  
}

function readCookie()
{

  var cookieValue1 = "";
  var cookieValue2 = "";
  var cookieValue3 = "";
  var name1="hh";
  var name2="mm";
  var name3="ss";
  var hours="1";

  var search1 = name1 + "=";
  var search2 = name2 + "=";
  var search3 = name3 + "=";

  if(document.cookie.length > 0)  
  { 

    offset1 = document.cookie.indexOf(search1);
    offset2 = document.cookie.indexOf(search2);
    offset3 = document.cookie.indexOf(search3);

    if (offset1 != -1)   { 
      offset1 += search1.length;

      end1 = document.cookie.indexOf(";", offset1);

      if (end1 == -1) end1 = document.cookie.length;

      cookieValue1 = unescape(document.cookie.substring(offset1, end1))
    }
    if (offset2 != -1)   { 
      offset2 += search2.length;

      end2 = document.cookie.indexOf(";", offset2);

      if (end2 == -1) end2 = document.cookie.length;

      cookieValue2 = unescape(document.cookie.substring(offset2, end2))
    }
    if (offset3 != -1)   { 
      offset3 += search1.length;

      end3 = document.cookie.indexOf(";", offset3);

      if (end3 == -1) end3 = document.cookie.length;

      cookieValue3 = unescape(document.cookie.substring(offset3, end3))
    }

  }

  document.getElementById("timerdiv").innerHTML=cookieValue1+":"+cookieValue2+":"+cookieValue3
  cookieValue1=parseInt(cookieValue1);
  cookieValue2=parseInt(cookieValue2);
  cookieValue3=parseInt(cookieValue3)-1;

  if(cookieValue3==0) {
  cookieValue2--;
  cookieValue3=59;
  }
  if(cookieValue2==0) {
  window.navigate("signout.jsp");
  }

if(hours != null)

  {

    expire = new Date((new Date()).getTime() + hours * 3600000);

    expire = "; expires=" + expire.toGMTString();

  }

  document.cookie = name1 + "=" + escape(cookieValue1) + expire;
  document.cookie = name2 + "=" + escape(cookieValue2) + expire;
  document.cookie = name3 + "=" + escape(cookieValue3) + expire;
  alert("Read")
  window.setTimeout("readCookie()","1000");
}
</script>
<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<link rel="stylesheet" media="screen" href="css/ie.css">
<![endif]-->
</head>
<body>
<header>
  <div class="container_12">
    <div class="grid_12">
      <h1>
          <!--a href="index.jsp"><img src="images/logo.png" alt=""></a-->
          IPDI          
      </h1>
        <div class="center sub_head">Identifying Personality Development for Intelligent Examination</div>
    </div>
  </div>
  <nav>
    <div class="container_12">
      <div class="grid_12">
          <%--@include file="menu2.jsp" --%>
        <div class="clear"></div>
      </div>
    </div>
  </nav>
</header>
<div id="content">
    <%@include file="db.jsp" %>
    <%
        if(session.getAttribute("userid")==null) {
            response.sendRedirect("login.jsp");
        }
        %>