<%--
  Created by IntelliJ IDEA.
  User: Maxwell
  Date: 2024/11/1
  Time: 13:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.chatroom.User" %>
<%@ page import="com.example.chatroom.ChatRoom" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>聊天室</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE8 HTML5 shim and Respond.js support -->
    <!--[if lt IE 9]>
    <script src="https://cdn.jsdelivr.net/npm/html5shiv@3.7.3/dist/html5shiv.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/respond.js@1.4.2/dest/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="container" style="margin-top: 20px">
    <div class="jumbotron">
        <% User user = (User) session.getAttribute("user"); %>
        <h1 style="text-align: center">欢迎, <%= user.getUsername() %>！进入聊天室</h1>
        <br><br>
        <div class="well" style="border:1px solid #000; width:80%; height:300px; overflow:auto; margin: 0 auto;">
            <iframe src="chatContent.jsp" style="width:100%; height:100%; border:none;"></iframe>
        </div>
        <br>
        <div>
            <form action="ChatServlet" method="post">
                <select name="toUser">
                    <option value="all">所有人</option>
                    <%
                        ChatRoom chatRoom = (ChatRoom) session.getAttribute("chatRoom");
                        for (User u : chatRoom.getOnlineUsers()) {
                            if (!u.getUsername().equals(user.getUsername())) {
                    %>
                    <option value="<%= u.getUsername() %>"><%= u.getUsername() %></option>
                    <% } } %>
                </select><br><br>

                <div class="input-group">
                    <input type="text" class="form-control" name="message" placeholder="输入您的消息" required>
                    <span class="input-group-btn">
                    <button class="btn btn-default" type="submit" onclick="sendMessage()">Send!</button>
                </span>
                </div>
            </form>

            <h3>在线用户：</h3>
            <iframe class="well" src="currentUsers.jsp" width="20%" height="200px"></iframe>

            <br><br>
            <button type="button" class="btn btn-danger" onclick="window.location.href='LogoutServlet'" style="display: block; margin: 0 auto;">Logout</button>

        <%--            <a href="LogoutServlet">Logout</a>--%>

        </div>
    </div>
</div>

<!-- jQuery 和 Bootstrap 插件 -->
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
</body>
</body>
</html>
