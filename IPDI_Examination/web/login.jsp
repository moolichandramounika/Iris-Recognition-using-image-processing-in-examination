<%@include file="header.jsp" %>
<form name="f" action="loginprocess.jsp" method="post">
    <table class="login">
        <thead>
            <tr>
                <th colspan="2">LOGIN</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <th>UserId</th>
                <td><input type="text" name="userid" required autofocus></td>
            </tr>
            <tr>
                <th>Password</th>
                <td><input type="password" name="pwd" required></td>
            </tr>
            <tr>
                <th>User Type</th>
                <td>
                    <select name="utype">
                        <option value="user">User</option>
                        <option value="admin">Admin</option>
                    </select>
                </td>
            </tr>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="2">
                    <input type="submit" name="submit" value="Login">
                </td>
            </tr>
        </tfoot>
    </table>
</form>
<%@include file="footer.jsp" %>