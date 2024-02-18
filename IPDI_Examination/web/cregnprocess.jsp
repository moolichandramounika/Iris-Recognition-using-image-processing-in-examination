<%@page import="javax.imageio.*"%>
<%@page import="java.awt.*"%>
<%@page import="java.awt.image.*"%>
<%@page import="com.google.zxing.common.*"%>
<%@page import="com.google.zxing.qrcode.*"%>
<%@page import="com.google.zxing.qrcode.decoder.*"%>
<%@page import="com.google.zxing.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.oreilly.servlet.multipart.*"%>
<%@include file="adminheader.jsp" %>
<%!
    PreparedStatement ps1=null;
    //int size = 125;
    int size=1000;
    String fileType = "png", str1;
    void createQRImage(File qrFile, String qrCodeText, int size,
            String fileType) throws WriterException, IOException {
        // Create the ByteMatrix for the QR-Code that encodes the given String
        Hashtable hintMap = new Hashtable();
        hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix byteMatrix = qrCodeWriter.encode(qrCodeText,
                BarcodeFormat.QR_CODE, size, size, hintMap);
        // Make the BufferedImage that are to hold the QRCode
        int matrixWidth = byteMatrix.getWidth();
        BufferedImage image = new BufferedImage(matrixWidth, matrixWidth,
                BufferedImage.TYPE_INT_RGB);
        image.createGraphics();
 
        Graphics2D graphics = (Graphics2D) image.getGraphics();
        graphics.setColor(Color.WHITE);
        graphics.fillRect(0, 0, matrixWidth, matrixWidth);
        // Paint and save the image using the ByteMatrix
        graphics.setColor(Color.BLACK);
 
        for (int i = 0; i < matrixWidth; i++) {
            for (int j = 0; j < matrixWidth; j++) {
                if (byteMatrix.get(i, j)) {
                    graphics.fillRect(i, j, 1, 1);
                }
            }
        }
        ImageIO.write(image, fileType, qrFile);
    }
    %>
<%
    MultipartParser parser = new MultipartParser(request, 50*1024*1024);
        com.oreilly.servlet.multipart.Part part;
        HashMap<String,String> pmap = new HashMap<String, String>();
        HashMap<String,String> fmap = new HashMap<String, String>();        
        try {
        while((part=parser.readNextPart()) != null) {
            if(part.isParam()) {
                    ParamPart pp = (ParamPart)part;
                    pmap.put(pp.getName(), pp.getStringValue());
            } else if(part.isFile()) {
                try {
                    FilePart fp = (FilePart)part;
                    fp.setRenamePolicy(new DefaultFileRenamePolicy());
                    File f1 = new File(getServletContext().getRealPath("tempup")+"/"+fp.getFileName());
                    fp.writeTo(f1);
                    byte []b = new byte[size];
                    FileInputStream fin = new FileInputStream(f1);
                    fin.read(b, 0, size);
                    fin.close();
                    str1 = new String(b);
                    //fmap.put(fp.getName(), "qr/"+fp.getFileName());
                } catch(Exception e) {
                    out.println(e.toString());
                }
            }
        }
        String tfname = new java.util.Date().getTime()+"file."+fileType;
        File qrFile = new File(getServletContext().getRealPath("qr")+"/"+tfname);
        createQRImage(qrFile, str1, size, fileType);
        
        ps1 = conn.prepareStatement("insert into candidates (cname,addr,city,degree,gender,mobile,email,pwd) values (?,?,?,?,?,?,?,?)");
    ps1.setString(1, pmap.get("cname"));
    ps1.setString(2, pmap.get("addr"));
    ps1.setString(3, pmap.get("city"));
    ps1.setString(4, pmap.get("degree"));
    ps1.setString(5, pmap.get("gender"));
    ps1.setString(6, pmap.get("mobile"));
    ps1.setString(7, pmap.get("email"));
    ps1.setString(8, pmap.get("pwd"));
    ps1.executeUpdate();
    ps1.close(); 
    ps1 = conn.prepareStatement("insert into qrtab(email,qrpath) values (?,?)");    
    ps1.setString(1, pmap.get("email"));
    ps1.setString(2, tfname);
    ps1.executeUpdate();
        ps1.close();
    out.print("<div><table style='margin:auto'><tr><th>Your Generated QRImage");
    out.print("<th><img src='qr/"+tfname+"' width='150px'></table></div>");
    
    out.print("<div class='center'>Candidate Id Generated...!<br><a href='adminhome.jsp'>Back</a></div>");
        } catch(Exception ex) {
            System.out.println(ex.toString());
            out.print(ex.toString());
        }    
%>    
<%@include file="footer.jsp" %>