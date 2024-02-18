<%@page import="java.sql.*"%>
<%!
    Connection conn=null;
    %>
<%
    if(conn==null) {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/jsp_ipdiexam","root","");
    }
%>    