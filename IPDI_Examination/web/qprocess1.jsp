<%@include file="adminheader.jsp" %>
<%!
    PreparedStatement ps1 = null;
    ResultSet rs1 = null;
    String gname, ques, ans1,ans2,ans3,ans4,ans5,cans,subject;
    %>
<%
    ques = request.getParameter("ques");
    ans1 = request.getParameter("ans1");
    ans2 = request.getParameter("ans2");
    ans3 = request.getParameter("ans3");
    ans4 = request.getParameter("ans4");
    ans5 = request.getParameter("ans5");
    cans = request.getParameter("cans");
    subject = request.getParameter("subject");
    ps1 = conn.prepareStatement("select gname from groups where sname=?");
    ps1.setString(1, subject);
    rs1 = ps1.executeQuery();
%>    
<form name="f" action="qprocess2.jsp" method="post" onsubmit="return check()">
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
                <td><textarea name="ques" cols="30" rows="5" required autofocus readonly><%=ques%></textarea></td>
            </tr>
            <tr>
                <th>Answer1</th>
                <td><input type="text" name="ans1" class="ans" value="<%=ans1%>" required readonly></td>
            </tr>            
            <tr>
                <th>Answer2</th>
                <td><input type="text" name="ans2" class="ans" value="<%=ans2%>" required readonly></td>
            </tr>
            <tr>
                <th>Answer3</th>
                <td><input type="text" name="ans3" class="ans" value="<%=ans3%>" required readonly></td>
            </tr>
            <tr>
                <th>Answer4</th>
                <td><input type="text" name="ans4" class="ans" value="<%=ans4%>" required readonly></td>
            </tr>
            <tr>
                <th>Answer5</th>
                <td><input type="text" name="ans5" class="ans" value="<%=ans5%>" required readonly></td>
            </tr>
            <tr>
                <th>Correct Answer</th>
                <td><input type="text" name="cans" class="ans" value="<%=cans%>" required readonly></td>
            </tr>
            <tr>
                <th>Subject</th>
                <td><input type="text" name="subject" class="ans" value="<%=subject%>" required readonly></td>
            </tr>
            <tr>
                <th>Group</th>
                <td>
                    <select name="gname">
                        <%
                            while(rs1.next()) {
                                gname = rs1.getString(1);
                                out.print("<option value='"+gname+"'>"+gname+"</option>");
                            }
                            ps1.close();
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <th>Answer Description</th>
                <td><textarea name="descr" cols="30" rows="3" required></textarea></td>
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
                    
<script>

</script>
<%@include file="footer.jsp" %>