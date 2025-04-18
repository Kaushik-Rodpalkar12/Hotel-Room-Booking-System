import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AddRoomServlet extends HttpServlet {

    private static final String SAVE_DIR = "images";  // Folder to store images

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

     
        String dbURL = "jdbc:mysql://localhost:3306/hoteldb";
        String dbUser = "root";
        String dbPass = "root75"; 

        
        int hotelId = 1;
        String roomType = request.getParameter("room_type");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");

     
        Part filePart = request.getPart("image");
        String fileName = extractFileName(filePart);
        String savePath = getServletContext().getRealPath("") + File.separator + SAVE_DIR;
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir(); 
        }
        String imagePath = SAVE_DIR + File.separator + fileName;
        filePart.write(savePath + File.separator + fileName);

        try {
         
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

          
            CallableStatement stmt = conn.prepareCall("{CALL sp_add_room(?, ?, ?, ?, ?, ?)}");
            stmt.setInt(1, hotelId);
            stmt.setString(2, roomType);
            stmt.setDouble(3, price);
            stmt.setString(4, description);
            stmt.setString(5, imagePath);
            stmt.registerOutParameter(6, java.sql.Types.VARCHAR);

           
            stmt.execute();
            String message = stmt.getString(6);

          
            response.sendRedirect("admin_dashboard.jsp?message=" + message);

            conn.close();
        } catch (SQLException | ClassNotFoundException e) {
            response.sendRedirect("admin_dashboard.jsp?message=Error: " + e.getMessage());
        }
    }

    // Extracts file name from HTTP header content-disposition
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String content : contentDisp.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return "default.jpg";
    }
}
