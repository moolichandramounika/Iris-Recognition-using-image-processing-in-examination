<%@include file="adminheader.jsp" %>
<style>
    table thead tr th {
        border-bottom: solid thin gray;
        padding:3px 5px;
    }
    table tr td, table tr th {
        border-right: solid thin gray;
    }
    table tr td {
        padding-left: 3px;
    }
</style>
<%!
    PreparedStatement ps1 = null;
    ResultSet rs1 = null;
    String subject, id;
    %>
<%
    ps1 = conn.prepareStatement("select cname,city,degree,subject,dt,markpercent from candidates c,examresult e where c.email=e.userid");
    rs1 = ps1.executeQuery();
    out.print("<table class='exam_tab'><thead><tr><th colspan='6'>EXAM RESULT");
    out.print("<tr><th>Name<th>City<th>Degree<th>Subject<th>Date<th>Percentage");    
    out.print("</thead><tbody>");
    while(rs1.next()) {
        out.print("<tr>");        
        out.print("<td>"+rs1.getString(1));
        out.print("<td>"+rs1.getString(2));
        out.print("<td>"+rs1.getString(3));
        out.print("<td>"+rs1.getString(4));
        out.print("<td>"+rs1.getString(5));
        out.print("<td>"+rs1.getString(6));
    }    
    out.print("</tbody></table>");
    ps1.close();
%>                    
<%@include file="footer.jsp" %>