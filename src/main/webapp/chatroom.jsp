<%-- Created by IntelliJ IDEA. User: Maxwell Date: 2024/11/1 Time: 14:01 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession userSession = request.getSession();
    String username = (String) userSession.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
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

    <script>
        var ws;
        function connect() {
            ws = new WebSocket("ws://" + window.location.host + "/chat");

            ws.onopen = function() {
                // 向服务器发送用户名
                ws.send("USERNAME:" + "<%= username %>");
            };

            ws.onmessage = function(event) {
                var message = event.data;

                // 检查是否为用户列表更新消息
                if (message.startsWith("USER_LIST:")) {
                    updateRecipientOptions(message.replace("USER_LIST:", "").split(","));
                } else {
                    // 普通聊天消息
                    var chatBox = document.getElementById("chat-box");
                    chatBox.innerHTML += message + "<br>";
                    chatBox.scrollTop = chatBox.scrollHeight;
                }
            };
        }

        function updateRecipientOptions(users) {
            var recipientSelect = document.getElementById("recipient");
            recipientSelect.innerHTML = '<option value="all">所有人</option>';
            users.forEach(function(user) {
                if (user !== "<%= username %>") { // 排除自己
                    var option = document.createElement("option");
                    option.value = user;
                    option.text = "用户 " + user;
                    recipientSelect.appendChild(option);
                }
            });
        }

        // 发送消息并支持选择特定接收者
        function sendMessage() {
            var message = document.getElementById("message").value;
            var recipient = document.getElementById("recipient").value;

            if (message.trim() === "") {
                alert("消息不能为空");
                return;
            }

            var formattedMessage;
            if (recipient === "all") {
                formattedMessage = "<strong>" + "<%= username %>" + "</strong>: " + message;
                ws.send(message);
            } else {
                formattedMessage = "<strong>" + "<%= username %> (对 " + recipient + "):</strong> " + message;
                ws.send("TO:" + recipient + " " + message);
            }

            // 将用户输入的消息添加到聊天框
            var chatBox = document.getElementById("chat-box");
            chatBox.innerHTML += formattedMessage + "<br>";
            chatBox.scrollTop = chatBox.scrollHeight;

            document.getElementById("message").value = "";
        }

        window.onload = connect;
    </script>
</head>
<body>
<div class="container" style="margin-top: 20px">
    <div class="jumbotron">
        <h1 style="text-align: center">欢迎, <%= username %>！进入聊天室</h1><br><br>
        <div class="well" id="chat-box" style="border:1px solid #000; width:80%; height:300px; overflow:auto; margin: 0 auto">
            <!-- 聊天消息显示区域 -->
        </div>
        <br>
        <div>
            发送给:
            <select id="recipient">
                <option value="all">所有人</option>
                <!-- 在线用户选项 -->
            </select><br><br><br>
            <div class="input-group">
                <input type="text" class="form-control" id="message" placeholder="输入您的消息">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button" onclick="sendMessage()">Send!</button>
                </span>
            </div>
        </div>
    </div>
</div>

<!-- jQuery 和 Bootstrap 插件 -->
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
</body>
</html>
