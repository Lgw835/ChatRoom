package com.example.chatroom;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/ChatServlet")
public class ChatServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ChatRoom chatRoom = (ChatRoom) request.getSession().getAttribute("chatRoom");
        User user = (User) request.getSession().getAttribute("user");
        String message = request.getParameter("message");
        String toUsername = request.getParameter("toUser");
        boolean isPrivate = !"all".equals(toUsername);

        User toUser = null;
        for (User u : chatRoom.getOnlineUsers()) {
            if (u.getUsername().equals(toUsername)) {
                toUser = u;
                break;
            }
        }

        ChatMessage chatMessage = new ChatMessage(user, toUser, message, isPrivate);
        chatRoom.addMessage(chatMessage);

        response.sendRedirect("chat.jsp");
    }
}

