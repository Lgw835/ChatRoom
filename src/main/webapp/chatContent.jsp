<%--
  Created by IntelliJ IDEA.
  User: Maxwell
  Date: 2024/11/1
  Time: 13:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.chatroom.User"%>
<%@ page import="com.example.chatroom.ChatRoom"%>
<%@ page import="com.example.chatroom.ChatMessage"%>
<html>
<%
    User user = (User) session.getAttribute("user");
    ChatRoom chatRoom = (ChatRoom) session.getAttribute("chatRoom");
    for (ChatMessage message : chatRoom.getMessages(user)) {
%>
<p><%= message %></p>
<% } %>
<script>
    setTimeout(() => {
        window.location.reload();
    }, 5000);
</script>
</html>
