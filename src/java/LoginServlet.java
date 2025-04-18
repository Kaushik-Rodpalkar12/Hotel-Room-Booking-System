import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hoteldb", "root", "root75");

            // Get form parameters
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // Debugging logs
            System.out.println("Login Attempt: Username = " + username);

            if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
                throw new Exception("⚠️ Username or Password cannot be empty!");
            }

            // Check user in database
            String sql = "SELECT id, full_name FROM users WHERE username=? AND password=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            rs = stmt.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("id");
                String fullName = rs.getString("full_name");

                // Debugging log
                System.out.println("Login Success! User ID: " + userId);

                // Set session attributes
                HttpSession session = request.getSession();
                session.setAttribute("user_id", String.valueOf(userId));
                session.setAttribute("username", username);
                session.setAttribute("full_name", fullName);

                // Redirect to user dashboard
                response.sendRedirect("dash.jsp");
            } else {
                System.out.println("❌ Login Failed! Invalid credentials.");
                response.sendRedirect("login.jsp?error=Invalid username or password!");
            }

        } catch (Exception e) {
            e.printStackTrace(); // Print error in logs
            response.sendRedirect("error.jsp?message=Login Failed! Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
