<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>View Rooms</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
            background: white;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #007BFF;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        img {
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <h2>Available Rooms</h2>
    <table>
        <tr>
            <th>Room ID</th>
            <th>Hotel ID</th>
            <th>Room Type</th>
            <th>Price</th>
            <th>Status</th>
            <th>Description</th>
            <th>Image</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hoteldb", "root", "root75");
                Statement stmt = conn.createStatement();
                String sql = "SELECT id, hotel_id, room_type, price, status, description, image_url FROM rooms";
                ResultSet rs = stmt.executeQuery(sql);

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getInt("hotel_id") %></td>
            <td><%= rs.getString("room_type") %></td>
            <td><%= rs.getDouble("price") %></td>
            <td><%= rs.getString("status") %></td>
            <td><%= rs.getString("description") %></td>
            <td><img src="<%= rs.getString("image_url") %>" width="100"></td>
        </tr>
        <%
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>
</body>
</html>
