<%@include file="adminheader.jsp" %>
<%!
    PreparedStatement ps1 = null;
    ResultSet rs1 = null;
    String gname,sname;
    %>
<%
    ps1 = conn.prepareStatement("select subject from subjects");
    rs1 = ps1.executeQuery();
%>    
<form name="f" action="groupprocess.jsp" method="post">
    <table class="form_tab">
        <thead>
            <tr>
                <th colspan="2">
                    GROUPS
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <th>Select Subject</th>
                <td>
                    <select name="sname">
                        <%
                            while(rs1.next()) {
                                sname = rs1.getString(1);
                                out.print("<option value='"+sname+"'>"+sname+"</option>");
                            }
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <th>Group Name</th>
                <td><input type="text" name="gname" required></td>
            </tr>           
        </tbody>
        <tfoot>
            <tr>
                <td colspan="2" class="center">
                    <input type="submit" name="submit" value="Create Group">
                </td>
            </tr>
        </tfoot>
    </table>
</form>
<%
    ps1 = conn.prepareStatement("select * from groups order by sname");
    rs1 = ps1.executeQuery();
    out.print("<table class='report_tab'><thead>");
    out.print("<tr><th>Subject<th>Group Name<th>Task");    
    out.print("</thead><tbody>");
    while(rs1.next()) {
        out.print("<tr>");
        out.print("<td>"+rs1.getString(1));
        gname = rs1.getString(2);
        out.print("<td>"+gname);        
        out.print("<td><a href='groups.jsp?gname="+gname+"' onclick=\"javascript:return confirm('Are You Sure to Delete ?')\">Delete</a>");
    }    
    out.print("</tbody></table>");
    ps1.close();
    
    if(request.getParameter("gname")!=null) {
        gname = request.getParameter("gname");
        ps1 = conn.prepareStatement("delete from groups where gname=?");
        ps1.setString(1, gname);
        ps1.executeUpdate();
        ps1.close();        
        response.sendRedirect("groups.jsp");
    }
%>
<%@include file="footer.jsp" %>