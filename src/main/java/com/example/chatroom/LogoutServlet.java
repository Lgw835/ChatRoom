package com.example.chatroom;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ChatRoom chatRoom = (ChatRoom) request.getSession().getAttribute("chatRoom");
        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {
            chatRoom.removeUser(user);
            request.getSession().invalidate();
        }

        response.sendRedirect("index.jsp");
    }
}

