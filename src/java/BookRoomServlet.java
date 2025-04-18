import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.CallableStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/BookRoomServlet")
public class BookRoomServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
    String checkIn = request.getParameter("check_in");


        String checkOut = request.getParameter("check_out");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Connection conn = null;
        CallableStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hoteldb", "root", "root75");

          
            stmt = conn.prepareCall("{CALL BookRoom(?, ?, ?)}");
            stmt.setString(1, username);
            stmt.setString(2, checkIn);
            stmt.setString(3, checkOut);
            stmt.execute();

            response.sendRedirect("user_dashboard.jsp?message=Booking Successful!");
        } catch (Exception e) {
            response.sendRedirect("user_dashboard.jsp?message=Booking Failed! Error: " + e.getMessage());
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
