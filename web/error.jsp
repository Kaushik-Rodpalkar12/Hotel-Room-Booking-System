<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; background-color: #f8d7da; color: #721c24; padding: 50px; }
        .container { padding: 20px; background-color: white; border-radius: 5px; box-shadow: 0px 0px 10px gray; display: inline-block; }
        h2 { color: red; }
        a { text-decoration: none; color: #007bff; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Booking Failed!</h2>
        <p><%= request.getParameter("message") != null ? request.getParameter("message") : "Something went wrong." %></p>
        <a href="user_dashboard.jsp">Go Back</a>
    </div>
</body>
</html>
