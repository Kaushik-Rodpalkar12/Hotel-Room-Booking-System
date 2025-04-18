<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Add Room</title>
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
        form {
            background: white;
            width: 50%;
            margin: auto;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        label {
            display: block;
            margin: 10px 0 5px;
            font-weight: bold;
        }
        input, textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        button {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
        }
        button:hover {
            background-color: #0056b3;
        }
        p {
            color: green;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h2>Add a New Room</h2>
  <form action="AddRoomServlet" method="post" enctype="multipart/form-data">
    <label for="room_type">Room Type:</label>
    <input type="text" name="room_type" required>

    <label for="price">Price:</label>
    <input type="number" name="price" required>

    <label for="description">Description:</label>
    <textarea name="description" required></textarea>

    <label for="image">Upload Room Image:</label>
    <input type="file" name="image" accept="image/*" required>

    <button type="submit">Add Room</button>
</form>

    <% if (request.getParameter("message") != null) { %>
        <p><%= request.getParameter("message") %></p>
    <% } %>
</body>
</html>
