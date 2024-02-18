<%@include file="userheader.jsp" %>
<%!
    PreparedStatement ps=null;
    ResultSet rs=null;
    String subject;
%>
<%
    ps = conn.prepareStatement("select subject from subjects order by subject");
    rs = ps.executeQuery();
%>
<div>
    <div class="leftdiv">
        <i>Welcome, </i><%=session.getAttribute("cname")%>
    </div>
    <div class="rightdiv">
        <a href="signout.jsp">Signout</a>
    </div>
</div>
    <form name="f" action="exam.jsp" method="post" onsubmit="check()">
    <table class="login">
        <thead>
            <tr>
                <th colspan="2">
                    SUBJECT
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <th>Select Subject</th>
                <td>
                    <select name="subject">
                        <%
                            while(rs.next()) {
                                subject = rs.getString(1);
                                out.print("<option value='"+subject+"'>"+subject+"</option>");
                            }
                        %>
                    </select>
                </td>
            </tr>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="2" class="center">
                    <input type="submit" name="submitr" value="Proceed">
                </td>
            </tr>
        </tfoot>
    </table>
</form>
<script>
    function check() {
        writeCookie()
    }
</script>
<%@include file="footer.jsp" %>