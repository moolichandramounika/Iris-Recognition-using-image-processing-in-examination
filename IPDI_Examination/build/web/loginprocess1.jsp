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
<%@include file="header.jsp" %>
<%!
    PreparedStatement ps1=null;
    ResultSet rs1=null;
    //int size = 125;
    int size = 1000;
    String fileType = "png", str1;
    boolean createQRImage(File qrFile, String qrCodeText, int size,
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
        return true;
    }
    %>
<%
    MultipartParser parser = new MultipartParser(request, 50*1024*1024);
        com.oreilly.servlet.multipart.Part part;        
        HashMap<String,String> fmap = new HashMap<String, String>();
        try {
        while((part=parser.readNextPart()) != null) {
            if(part.isFile()) {
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
        File qrFile = new File(getServletContext().getRealPath("tempup")+"/"+tfname);
        if(createQRImage(qrFile, str1, size, fileType)) {
            session.setAttribute("newqrfile", tfname);
            out.print("<div><table style='margin:auto'><tr><th>Your Generated QRImage");
            out.print("<th><img src='tempup/"+tfname+"' width='150px'><tr><th colspan='2'>");
            out.print("<a href='loginprocess2.jsp'>Compare this with QR Code</a></table></div>");
        }
        } catch(Exception ex) {
            System.out.println(ex.toString());
            out.print(ex.toString());
        } 
%>
<%@include file="footer.jsp" %>