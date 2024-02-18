<%@page import="java.io.*"%>
<%@include file="header.jsp" %>
<%!
    PreparedStatement ps1=null;
    ResultSet rs1=null;
    %><%
        File qrFile = new File(getServletContext().getRealPath("tempup")+"/"+session.getAttribute("newqrfile").toString());
        ps1 = conn.prepareStatement("select qrpath from qrtab where email=?");
        ps1.setString(1, session.getAttribute("userid").toString());
        rs1 = ps1.executeQuery();
            if(rs1.next()) {
                String path = getServletContext().getRealPath("qr")+"/"+rs1.getString(1);
                File qrFile1 = new File(path);
                FileInputStream fin1 = new FileInputStream(qrFile);
                FileInputStream fin2 = new FileInputStream(qrFile1);
                int d;
                boolean flag=false;
                while((d=fin1.read())!=-1) {
                    flag=true;
                    if(d!=fin2.read()) {
                        flag=false;
                        break;
                    }
                }
                fin1.close();
                fin2.close();
                if(flag) {
                    response.sendRedirect("userhome.jsp");
                } else {
                    out.print("<div class='center'>Invalid Iris Image!<br><a href='login.jsp'>Back</a></div>");
                }
            }
        ps1.close();                
        %>
<%@include file="footer.jsp" %>