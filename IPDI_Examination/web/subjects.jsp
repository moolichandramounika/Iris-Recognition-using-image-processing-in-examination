<%@include file="adminheader.jsp" %>
<form name="f" action="subjprocess.jsp" method="post" onsubmit="return check()">
    <table class="form_tab">
        <thead>
            <tr>
                <th colspan="2">
                    SUBJECTS
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <th>Subject Name</th>
                <td><input type="text" name="subject" required></td>
            </tr>           
        </tbody>
        <tfoot>
            <tr>
                <td colspan="2" class="center">
                    <input type="submit" name="submit" value="Create Subject">
                </td>
            </tr>
        </tfoot>
    </table>
</form>
<%!
    PreparedStatement ps1 = null;
    ResultSet rs1 = null;
    String subject;
    %>
<%
    ps1 = conn.prepareStatement("select * from subjects");
    rs1 = ps1.executeQuery();
    out.print("<table class='report_tab'><thead>");
    out.print("<tr><th>Subject Name<th>Task");    
    out.print("</thead><tbody>");
    while(rs1.next()) {
        out.print("<tr>");
        subject = rs1.getString(1);
        out.print("<td>"+subject);        
        out.print("<td><a href='subjects.jsp?subject="+subject+"' onclick=\"javascript:return confirm('Are You Sure to Delete ?')\">Delete</a>");
    }    
    out.print("</tbody></table>");
    ps1.close();
    
    if(request.getParameter("subject")!=null) {
        subject = request.getParameter("subject");
        ps1 = conn.prepareStatement("delete from subjects where subject=?");
        ps1.setString(1, subject);
        ps1.executeUpdate();
        ps1.close();
        response.sendRedirect("subjects.jsp");
    }
%>
<%@include file="footer.jsp" %>