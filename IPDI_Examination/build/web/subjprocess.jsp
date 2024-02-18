<%@include file="adminheader.jsp" %>
<%!
    PreparedStatement ps1=null;
    String subject;
    %>
<%
    subject = request.getParameter("subject");
    
    ps1 = conn.prepareStatement("insert into subjects (subject) values (?)");
    ps1.setString(1, subject);
    ps1.executeUpdate();
    ps1.close();
    out.print("<div class='center'>Subject Generated...!<br><a href='subjects.jsp'>Back</a></div>");
%>    
<%@include file="footer.jsp" %>