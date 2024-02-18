<%@include file="adminheader.jsp" %>
<%!
    PreparedStatement ps1=null;
    String sname,gname;
    %>
<%
    sname = request.getParameter("sname");
    gname = request.getParameter("gname");
    
    ps1 = conn.prepareStatement("insert into groups (sname,gname) values (?,?)");
    ps1.setString(1, sname);
    ps1.setString(2, gname);
    ps1.executeUpdate();
    ps1.close();
    out.print("<div class='center'>Group Generated...!<br><a href='groups.jsp'>Back</a></div>");
%>    
<%@include file="footer.jsp" %>