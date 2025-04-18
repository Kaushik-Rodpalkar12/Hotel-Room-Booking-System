<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("Login.jsp");
    }
%>
<html>
<head>
    <title>User Dashboard</title>
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
        }
        form {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            display: inline-block;
            text-align: left;
        }
        label, input, button {
            display: block;
            margin: 10px 0;
            font-size: 16px;
        }
        input {
            padding: 8px;
            width: 100%;
            max-width: 300px;
        }
        button {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h2>Book a Room</h2>
    <form action="BookRoomServlet" method="post">
        <label for="room_id">Select Room:</label>
        <input type="number" name="room_id" required>

        <label for="check_in">Check-in Date:</label>
        <input type="date" name="check_in" required>

        <label for="check_out">Check-out Date:</label>
        <input type="date" name="check_out" required>

        <button type="submit">Book Now</button>
    </form>
</body>
</html>
