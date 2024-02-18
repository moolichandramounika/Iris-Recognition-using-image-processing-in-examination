<%@page import="java.util.*"%>
<%@include file="header.jsp" %>
<%!
    PreparedStatement ps=null;
    ResultSet rs=null;
    String cans,gname,ques,descr;
%>    
<%
    if(session.getAttribute("adminuserid")!=null) {
        session.removeAttribute("adminuserid");
        response.sendRedirect("index.jsp");
    } else if(session.getAttribute("userid")!=null) {
        if(session.getAttribute("answers")!=null) {
            HashMap<String,String> hm = (HashMap<String, String>)session.getAttribute("answers");
            Set<String> set = hm.keySet();
            Iterator iterator = set.iterator();
            TreeSet<String> gnames = new TreeSet<String>();
            String key,ans;
            int totalq;
            ps = conn.prepareStatement("select count(*) from questions where subject=?");
            ps.setString(1,session.getAttribute("subject").toString());
            rs = ps.executeQuery();
            rs.next();
            totalq = rs.getInt(1);
            ps.close();
            ps = conn.prepareStatement("select cans,gname,ques,descr from questions where id=?");
            out.print("<table class='result_tab'><thead>");
            out.print("<tr><th>Question<th>Correct Answer<th>Your Answer<th>Description");
            while(iterator.hasNext()) {                
                key = (String)iterator.next();
                ans = hm.get(key).toString();
                ps.setString(1, key);
                rs = ps.executeQuery();
                rs.next();
                cans = rs.getString(1);
                gname = rs.getString(2);
                ques = rs.getString(3);
                descr = rs.getString(4);
                if(!cans.equalsIgnoreCase(ans))
                    gnames.add(gname);
                rs.close();
                out.print("<tr>");
                out.print("<td>"+ques);
                out.print("<td>"+cans);
                if(cans.equalsIgnoreCase(ans))
                out.print("<td>"+ans);
                else
                out.print("<td style='color:red;'>"+ans);
                //out.print("<td>"+gname);
                out.print("<td>"+descr);
            }
            out.print("</table>");
            ps.close();
            ps = conn.prepareStatement("select count(*) from questions where gname=?");
            int lessmark=0,netmark;
            double markpercent;
            
            out.print("<table class='result_tab'><thead><tr><th>Improvement Needed in the following Area...!");
            out.print("<tr><th>Name<tbody>");
            Iterator<String> iterator1 = gnames.iterator();
            while(iterator1.hasNext()) {
                String ls = iterator1.next();
                ps.setString(1, ls);
                rs = ps.executeQuery();
                rs.next();
                lessmark += rs.getInt(1);
                rs.close();
                //out.print("<br>"+iterator1.next());
                out.print("<tr><td>"+ls);
            }
            ps.close();
            out.print("</tbody></html>");
            //out.print("<br>"+totalq+" - "+lessmark);
            netmark = totalq-lessmark;
            markpercent = Math.round(((double)netmark/totalq)*100);
            //out.print("<br>Percent Obtained : "+markpercent+"%");
            if(session.getAttribute("laction")!=null) {
                session.removeAttribute("laction");
            }
          String dt = new java.text.SimpleDateFormat("yyyy-MM-dd h:m:s a").format(new java.util.Date());
          ps = conn.prepareStatement("insert into examresult (userid,dt,subject,markpercent) values (?,?,?,?)");
          ps.setString(1, session.getAttribute("userid").toString());
          ps.setString(2, dt);
          ps.setString(3, session.getAttribute("subject").toString());
          ps.setString(4, ""+markpercent);
          ps.executeUpdate();
          ps.close();
          out.print("<div class='center top_margin' style='clear:both'>");
          out.print("Mr/Ms.<i>"+session.getAttribute("cname")+"</i>, You have Obtained "+markpercent+" %");
          out.print("</div>");
          out.print("<div class='center' style='clear:both'><a href='login.jsp'>Back to Login</a></div>");
        session.removeAttribute("userid");
        session.removeAttribute("cname");
        session.removeAttribute("answers");
        session.removeAttribute("subject");
        if(session.getAttribute("newqrfile")!=null)
            session.removeAttribute("newqrfile");
        } else {
            response.sendRedirect("index.jsp");
        }
    }
    %>
    <%@include file="footer.jsp" %>    