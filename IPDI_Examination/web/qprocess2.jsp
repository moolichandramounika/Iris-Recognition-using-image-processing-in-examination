<%@include file="adminheader.jsp" %>
<%!
    PreparedStatement ps1 = null;    
    String gname, ques, ans1,ans2,ans3,ans4,ans5,cans,subject,descr;
    %>
<%
    try {
    ques = request.getParameter("ques");
    ans1 = request.getParameter("ans1");
    ans2 = request.getParameter("ans2");
    ans3 = request.getParameter("ans3");
    ans4 = request.getParameter("ans4");
    ans5 = request.getParameter("ans5");
    cans = request.getParameter("cans");
    subject = request.getParameter("subject");
    gname = request.getParameter("gname");
    descr = request.getParameter("descr");
    
    ps1 = conn.prepareStatement("insert into questions (ques,ans1,ans2,ans3,ans4,ans5,cans,subject,gname,descr) values (?,?,?,?,?,?,?,?,?,?)");
    ps1.setString(1, ques);
    ps1.setString(2, ans1);
    ps1.setString(3, ans2);
    ps1.setString(4, ans3);
    ps1.setString(5, ans4);
    ps1.setString(6, ans5);
    ps1.setString(7, cans);
    ps1.setString(8, subject);
    ps1.setString(9, gname);
    ps1.setString(10, descr);
    ps1.executeUpdate();
    ps1.close();
    out.print("<div class='center'>Question Added Successfully...!</div>");
    } catch(Exception ex) {
        out.print("<div class='center'>"+ex.getLocalizedMessage()+"</div>");
    }
    out.print("<div class='center'><br><a href='questions.jsp'>Back</a></div>");
%>
<%@include file="footer.jsp" %>