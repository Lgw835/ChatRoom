<%--
  Created by IntelliJ IDEA.
  User: Maxwell
  Date: 2024/11/1
  Time: 13:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>聊天室登录</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%
    String captcha = (String) session.getAttribute("captcha");
%>
<script>
    console.log("验证码：" + "<%= captcha %>");
</script>

<div class="container" style="margin-top: 20px">
    <div class="jumbotron">
        <h1 style="text-align: center">登录聊天室</h1><br>
        <p style="text-align: center">欢迎加入聊天室！畅所欲言，分享精彩瞬间；互相尊重，共建和谐空间！</p><br>

        <form class="form-horizontal" action="LoginServlet" method="post">
            <div class="form-group">
                <label for="userName" class="col-sm-2 control-label">用户名:</label>
                <div class="col-sm-10">
                    <input id="userName" type="text" name="username" class="form-control" required placeholder="请输入用户名">
                </div>
            </div>
            <div class="form-group">
                <label for="captcha" class="col-sm-2 control-label">验证码:</label>
                <div class="col-sm-10">
                    <input type="text" name="captcha" id="captcha" class="form-control" required placeholder="请输入验证码">
                    <img src="LoginServlet?action=captcha" alt="验证码" title="点击刷新验证码" style="cursor:pointer; margin-top: 10px;"
                         onclick="this.src='LoginServlet?action=captcha&'+Math.random()">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-primary">登录</button>
                </div>
            </div>
        </form>

        <% String error = request.getParameter("error"); %>
        <% if ("1".equals(error)) { %>
        <div class="alert alert-danger" role="alert" style="margin-top: 20px;">
            登录失败：验证码错误，请重试。
        </div>
        <% } else if ("2".equals(error)) { %>
        <div class="alert alert-danger" role="alert" style="margin-top: 20px;">
            登录失败：用户名已存在，请选择其他用户名。
        </div>
        <% } %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
</body>
</html>
