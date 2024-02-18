<%@include file="adminheader.jsp" %>
<%!
    PreparedStatement ps1 = null;
    ResultSet rs1 = null;
    String subject, id;
    %>
<%
    ps1 = conn.prepareStatement("select * from subjects");
    rs1 = ps1.executeQuery();
%>    
<form name="f" action="qprocess1.jsp" method="post" onsubmit="return check()">
    <table class="form_tab">
        <thead>
            <tr>
                <th colspan="2">
                    QUESTIONS
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <th>Question</th>
                <td><textarea name="ques" cols="30" rows="5" required autofocus></textarea></td>
            </tr>
            <tr>
                <th>Answer1</th>
                <td><input type="text" name="ans1" class="ans" required></td>
            </tr>            
            <tr>
                <th>Answer2</th>
                <td><input type="text" name="ans2" class="ans" required></td>
            </tr>
            <tr>
                <th>Answer3</th>
                <td><input type="text" name="ans3" class="ans" required></td>
            </tr>
            <tr>
                <th>Answer4</th>
                <td><input type="text" name="ans4" class="ans" required></td>
            </tr>
            <tr>
                <th>Answer5</th>
                <td><input type="text" name="ans5" class="ans" required></td>
            </tr>
            <tr>
                <th>Correct Answer</th>
                <td><input type="text" name="cans" class="ans" required></td>
            </tr>
            <tr>
                <th>Subject</th>
                <td>
                    <select name="subject">
                        <%
                            while(rs1.next()) {
                                subject = rs1.getString(1);
                                out.print("<option value='"+subject+"'>"+subject+"</option>");
                            }
                            ps1.close();
                        %>
                    </select>
                </td>
            </tr>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="2" class="center">
                    <input type="submit" name="submit" value="Continue">
                </td>
            </tr>
        </tfoot>
    </table>
</form>
<%
    ps1 = conn.prepareStatement("select id,ques,cans,subject,gname  from questions order by subject,gname");
    rs1 = ps1.executeQuery();
    out.print("<table class='report_tab'><thead>");
    out.print("<tr><th>Question<th>Correct Ans<th>Subject<th>Group<th>Task");    
    out.print("</thead><tbody>");
    while(rs1.next()) {
        out.print("<tr>");
        id = rs1.getString(1);
        out.print("<td>"+rs1.getString(2));
        out.print("<td>"+rs1.getString(3));
        out.print("<td>"+rs1.getString(4));
        out.print("<td>"+rs1.getString(5));
        
        out.print("<td><a href='questions.jsp?dqid="+id+"' onclick=\"javascript:return confirm('Are You Sure to Delete ?')\">Delete</a>");
    }    
    out.print("</tbody></table>");
    ps1.close();
    if(request.getParameter("dqid")!=null) {
        String id = request.getParameter("dqid");
        ps1 = conn.prepareStatement("delete from questions where id=?");
        ps1.setString(1, id);
        ps1.executeUpdate();
        ps1.close();
        response.sendRedirect("questions.jsp");
    }
%>                    
<script>
function check() {
    var ans1 = f.ans1.value
    var ans2 = f.ans2.value
    var ans3 = f.ans3.value
    var ans4 = f.ans4.value
    var ans5 = f.ans5.value
    var cans = f.cans.value
    
    if(ans1!=cans && ans2!=cans && ans3!=cans && ans4!=cans && ans5!=cans) {
        alert("Correct Answer not matches any Answers")
        f.cans.focus()
        return false
    }
    return true
}                            
</script>
<%@include file="footer.jsp" %>