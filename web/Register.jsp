<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    if(request.getMethod().equalsIgnoreCase("post")) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("full_name");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hoteldb", "root", "root75");

            CallableStatement cs = conn.prepareCall("{CALL registerUser(?, ?, ?, ?, ?, ?)}");
            cs.setString(1, username);
            cs.setString(2, password);
            cs.setString(3, fullName);
            cs.setInt(4, age);
            cs.setString(5, gender);
            cs.setString(6, phone);
            
            cs.executeUpdate();
            out.println("<script>alert('Registration successful!'); window.location='Login.jsp';</script>");
        } catch(Exception e) {
            out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
        } finally {
            if(stmt != null) stmt.close();
            if(conn != null) conn.close();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; text-align: center; }
        form { background: white; padding: 20px; margin: auto; width: 300px; border-radius: 10px; }
        input, select { width: 100%; padding: 8px; margin: 5px 0; }
        button { background: blue; color: white; padding: 10px; border: none; cursor: pointer; }
    </style>
</head>
<body>
    <h2>Register</h2>
    <form method="post">
        <input type="text" name="username" placeholder="Username" required />
        <input type="password" name="password" placeholder="Password" required />
        <input type="text" name="full_name" placeholder="Full Name" required />
        <input type="number" name="age" placeholder="Age" required />
        <select name="gender" required>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
            <option value="Other">Other</option>
        </select>
        <input type="text" name="phone" placeholder="Phone" required />
        <button type="submit">Register</button>
    </form>
</body>
</html>
