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
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<html>
<%
    ChatRoom chatRoom = (ChatRoom) session.getAttribute("chatRoom");
    List<User> users = chatRoom.getOnlineUsers();
    for (User user : users) {
%>
<p><%= user.getUsername() %></p>
<% } %>
<script>
    setTimeout(() => {
        window.location.reload();
    }, 5000);
</script>
</html>
