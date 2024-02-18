<%@include file="adminheader.jsp" %>
<form name="f" action="cregnprocess.jsp" method="post" enctype="multipart/form-data" onsubmit="return check()">
    <table class="form_tab">
        <thead>
            <tr>
                <th colspan="2">
                    CANDIDATE REGISTRATION
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <th>Name</th>
                <td><input type="text" name="cname" required autofocus></td>
            </tr>
            <tr>
                <th>Address</th>
                <td><textarea name="addr" cols="15" required></textarea></td>
            </tr>
            <tr>
                <th>City</th>
                <td><input type="text" name="city" required></td>
            </tr>
            <tr>
                <th>Degree</th>
                <td><input type="text" name="degree" required></td>
            </tr>
            <tr>
                <th>Gender</th>
                <td>
                    <input type="radio" name="gender" value="Male" checked>Male &nbsp;
                    <input type="radio" name="gender" value="Female">Female
                </td>
            </tr>
            <tr>
                <th>Mobile</th>
                <td><input type="text" name="mobile" maxlength="10" required></td>
            </tr>
            <tr>
                <th>EMail (UserId)</th>
                <td><input type="text" name="email" required></td>
            </tr>
            <tr>
                <th>Password</th>
                <td><input type="password" name="pwd" required></td>
            </tr>
            <tr>
                <th>Confirm Pwd</th>
                <td><input type="password" name="cpwd" required></td>
            </tr>
            <tr>
                <th>Your IRIS Image</th>
                <td><input type="file" name="ff" required accept="image/*" style="width: 190px;"></td>
            </tr>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="2" class="center">
                    <input type="submit" name="submit" value="Create Id">
                </td>
            </tr>
        </tfoot>
    </table>
</form>
<%!
    PreparedStatement ps1 = null;
    ResultSet rs1 = null;
    String email;
    %>
<%
    ps1 = conn.prepareStatement("select * from candidates");
    rs1 = ps1.executeQuery();
    out.print("<table class='report_tab'><thead>");
    out.print("<tr><th>Name<th>Addr<th>City<th>Degree<th>Gender<th>Mobile<th>EMail<th>Password<th>Task");    
    out.print("</thead><tbody>");
    while(rs1.next()) {
        out.print("<tr>");
        out.print("<td>"+rs1.getString(1));
        out.print("<td>"+rs1.getString(2));
        out.print("<td>"+rs1.getString(3));
        out.print("<td>"+rs1.getString(4));
        out.print("<td>"+rs1.getString(5));
        out.print("<td>"+rs1.getString(6));
        email = rs1.getString(7);
        out.print("<td>"+email);
        out.print("<td>"+rs1.getString(8));
        out.print("<td><a href='adminhome.jsp?email="+email+"' onclick=\"javascript:return confirm('Are You Sure to Delete ?')\">Delete</a>");
    }    
    out.print("</tbody></table>");
    ps1.close();
    
    if(request.getParameter("email")!=null) {
        email = request.getParameter("email");
        ps1 = conn.prepareStatement("delete from candidates where email=?");
        ps1.setString(1, email);
        ps1.executeUpdate();
        ps1.close();
        response.sendRedirect("adminhome.jsp");
    }
%>    
<script>
    function check() {
        var mobile = f.mobile.value
        var pwd = f.pwd.value
        var cpwd = f.cpwd.value
        var mp = /^[9876]\d{9}$/
        if(!mobile.match(mp)) {
            alert("Invalid Mobile Number")
            f.mobile.focus()
            return false
        }
        if(pwd!=cpwd) {
            alert("Invalid Confirm Password")
            f.cpwd.focus()
            return false
        }
        return true
    }
</script>
<%@include file="footer.jsp" %>