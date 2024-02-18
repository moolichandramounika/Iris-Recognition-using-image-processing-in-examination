<%@page import="java.util.*"%>
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

  document.getElementById("timerdiv").innerHTML="Time Remaining - "+cookieValue1+":"+cookieValue2+":"+cookieValue3
  cookieValue1=parseInt(cookieValue1);
  cookieValue2=parseInt(cookieValue2);
  cookieValue3=parseInt(cookieValue3)-1;

  if(cookieValue3==0) {
  cookieValue2--;
  cookieValue3=59;
  }
  if(cookieValue2==0) {
  location.href = "signout.jsp"
  }

if(hours != null)

  {

    expire = new Date((new Date()).getTime() + hours * 3600000);

    expire = "; expires=" + expire.toGMTString();

  }

  document.cookie = name1 + "=" + escape(cookieValue1) + expire;
  document.cookie = name2 + "=" + escape(cookieValue2) + expire;
  document.cookie = name3 + "=" + escape(cookieValue3) + expire;  
  
  window.setTimeout("readCookie()","1000");
}
</script>
<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<link rel="stylesheet" media="screen" href="css/ie.css">
<![endif]-->
</head>
<body onload="readCookie()">
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
<div id="timerdiv"></div>
<%!
    String subject, id, data, odata[], checked="";
    PreparedStatement ps=null;
    ResultSet rs=null;
    ArrayList<String> al1=null, al2=null;
    ListIterator<String> itr1=null, itr2;
    HashMap<String, String> hm;    
    %>
<%
try {
    if(request.getParameter("submitr")!=null) {
        subject = request.getParameter("subject");
        session.setAttribute("subject", subject);        
        al1 = new ArrayList<String>();
        al2 = new ArrayList<String>();
        hm =  new HashMap<String, String>();
        ps = conn.prepareStatement("select id,ques,ans1,ans2,ans3,ans4,ans5 from questions where subject=? order by id");
        ps.setString(1,subject);
        rs = ps.executeQuery();
        while(rs.next()) {
            al1.add(rs.getString(1));
            al2.add(rs.getString(2)+"$"+rs.getString(3)+"$"+rs.getString(4)+"$"+rs.getString(5)+"$"+rs.getString(6)+"$"+rs.getString(7));            
        }
        
        itr1 = al1.listIterator();
        itr2 = al2.listIterator();
        id = itr1.next();
        data = itr2.next();
        
        ps.close();        
    } 
    if(request.getParameter("next")!=null) {
        if(session.getAttribute("laction")!=null) {
            if(session.getAttribute("laction").toString().equals("previous") && itr1.hasNext()) {
                itr1.next();
                itr2.next();
            }
        }        
        if(itr1.hasNext()) {
            id = itr1.next();
            data = itr2.next();
                if(id!=null) {
                    if(hm.get(id)!=null) {
                        checked = hm.get(id);
                   }
                }
        }
        
        session.setAttribute("laction", "next");
        hm.put(request.getParameter("hid"), request.getParameter("ans"));
    }
    if(request.getParameter("previous")!=null) {
        if(session.getAttribute("laction")!=null) {
            if(session.getAttribute("laction").toString().equals("next") && itr1.hasPrevious()) {
                itr1.previous();
                itr2.previous();
            }
        }
        if(itr1.hasPrevious()) {
            id = itr1.previous();
            data = itr2.previous();
                if(id!=null) {
                    if(hm.get(id)!=null) {
                        checked = hm.get(id);
                    }
                }
        }
        
        session.setAttribute("laction", "previous");
        hm.put(request.getParameter("hid"), request.getParameter("ans"));
    }
    if(request.getParameter("end")!=null) {
        hm.put(request.getParameter("hid"), request.getParameter("ans"));
        session.setAttribute("answers", hm);
        response.sendRedirect("signout.jsp");
    }
    
    odata = data.split("\\$");
    session.setAttribute("answers", hm);
%>
<form name="f" action="exam.jsp" method="post" onsubmit="return check()">
    <table class="exam_tab">
    <tbody>
        <tr>
            <th rowspan="6" class="border fixed_width"><input type="hidden" name="hid" value="<%=id%>"><%=id%></th>
            <td class="border left"><%=odata[0]%></td>
        </tr>
        <tr>
            <td>
                <%
                    if(checked.equalsIgnoreCase(odata[1])) {
                %>
                    <input type="radio" name="ans" value="<%=odata[1]%>" checked><%=odata[1]%>
                <%
                    } else {
                %>
                    <input type="radio" name="ans" value="<%=odata[1]%>"><%=odata[1]%>
                <%
                    }
                %>                
            </td>
        </tr>
        <tr>
            <td>
                <%
                    if(checked.equalsIgnoreCase(odata[2])) {
                %>
                    <input type="radio" name="ans" value="<%=odata[2]%>" checked><%=odata[2]%>
                <%
                    } else {
                %>
                    <input type="radio" name="ans" value="<%=odata[2]%>"><%=odata[2]%>
                <%
                    }
                %>                
            </td>
        </tr>
        <tr>
            <td>
                <%
                    if(checked.equalsIgnoreCase(odata[3])) {
                %>
                    <input type="radio" name="ans" value="<%=odata[3]%>" checked><%=odata[3]%>
                <%
                    } else {
                %>
                    <input type="radio" name="ans" value="<%=odata[3]%>"><%=odata[3]%>
                <%
                    }
                %>                
            </td>
        </tr>
        <tr>
            <td>
                <%
                    if(checked.equalsIgnoreCase(odata[4])) {
                %>
                    <input type="radio" name="ans" value="<%=odata[4]%>" checked><%=odata[4]%>
                <%
                    } else {
                %>
                    <input type="radio" name="ans" value="<%=odata[4]%>"><%=odata[4]%>
                <%
                    }
                %>                
            </td>
        </tr>
        <tr>
            <td>
                <%
                    if(checked.equalsIgnoreCase(odata[5])) {
                %>
                    <input type="radio" name="ans" value="<%=odata[5]%>" checked><%=odata[5]%>
                <%
                    } else {
                %>
                    <input type="radio" name="ans" value="<%=odata[5]%>"><%=odata[5]%>
                <%
                    }
                %>                
            </td>
        </tr>
    </tbody>
    <tfoot>
        <tr>
            <td colspan="2" class="right">
            <%
            if(request.getParameter("submitr")==null && itr1.hasPrevious()) {
                out.print("<input type='submit' name='previous' value='Previous'>&nbsp;");
            }
            if(itr1.hasNext()) {
                out.print("<input type='submit' name='next' value='Next'>&nbsp;");
            } else {
                out.print("<input type='submit' name='end' value='Finish'>");
            }
            %>    
            </td>
        </tr>
    </tfoot>
    </table> 
</form>
<%
} catch(Exception e) {
    if(e.getMessage()==null) {
    out.print("<div class='center'>No Questions Available...!<br><a href='userhome.jsp'>Back</a></div>");
    } else {
    out.print("<div class='center'>"+e.getMessage()+"<br><a href='userhome.jsp'>Back</a></div>");
    }
}
%>
<script>
    function check() {
        var r = document.querySelectorAll("input[name='ans']")
        var b=false
        for(i in r) {
            if(r[i].checked) {
                b=true
            }
        }        
        return b
    }
</script>
<%@include file="footer.jsp" %>