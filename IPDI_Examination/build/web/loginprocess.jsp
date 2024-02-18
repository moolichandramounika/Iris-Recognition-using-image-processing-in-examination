<%@include file="header.jsp" %>
<%!
  PreparedStatement ps=null;
  ResultSet rs=null;
  String userid,pwd,utype;
    %>
<%
    userid = request.getParameter("userid");
    pwd = request.getParameter("pwd");
    utype = request.getParameter("utype");
    
    if(utype.equalsIgnoreCase("admin")) {
        if(userid.equalsIgnoreCase("admin") && pwd.equals("admin")) {
            session.setAttribute("adminuserid", userid);
            response.sendRedirect("adminhome.jsp");
        } else {
        out.print("<div class='center'>Invalid Userid/Password...!<br><a href='login.jsp'>Back</a></div>");
        }
    } else {
        ps = conn.prepareStatement("select * from candidates where email=? and pwd=?");
        ps.setString(1, userid);
        ps.setString(2, pwd);
        rs = ps.executeQuery();
            if(rs.next()) {
                session.setAttribute("userid", userid);
                session.setAttribute("cname", rs.getString(1));
%>
<form name="f" action="loginprocess1.jsp" method="post" enctype="multipart/form-data">
    <table class="login">
        <thead>
            <tr>
                <th colspan="2">IRIS IMAGE UPLOAD</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <th>Your Iris Image</th>
                <td><input type="file" name="ff" required autofocus></td>
            </tr>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="2">
                    <input type="submit" name="submit" value="Validate">
                </td>
            </tr>
        </tfoot>
    </table>
</form>
<%
                //response.sendRedirect("userhome.jsp");
            } else {
       out.print("<div class='center'>Invalid Userid/Password...!<br><a href='login.jsp'>Back</a></div>");
            }
        ps.close();
    }
%>    
<%@include file="footer.jsp" %>