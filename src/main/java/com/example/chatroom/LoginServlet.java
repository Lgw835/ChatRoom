package com.example.chatroom;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashSet;
import java.util.Random;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final int CAPTCHA_WIDTH = 100;
    private static final int CAPTCHA_HEIGHT = 40;
    private static final HashSet<String> registeredUsers = new HashSet<>(); // 用于模拟已注册用户的集合

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("captcha".equals(action)) {
            generateCaptchaImage(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String userInputCaptcha = request.getParameter("captcha");

        HttpSession session = request.getSession();
        String generatedCaptcha = (String) session.getAttribute("captcha");

        if (username != null && !username.isEmpty() && generatedCaptcha != null && generatedCaptcha.equalsIgnoreCase(userInputCaptcha)) {
            // 检查用户名是否已存在
            if (registeredUsers.contains(username)) {
                response.sendRedirect("login.jsp?error=2"); // 错误码2：用户名已存在
            } else {
                registeredUsers.add(username); // 将新用户名添加到已注册用户集合
                session.setAttribute("username", username);
                response.sendRedirect("chatroom.jsp");
            }
        } else {
            response.sendRedirect("login.jsp?error=1"); // 错误码1：验证码错误
        }
    }

    private void generateCaptchaImage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String captcha = generateCaptcha(6);

        HttpSession session = request.getSession();
        session.setAttribute("captcha", captcha);

        response.setContentType("image/png");
        OutputStream os = response.getOutputStream();

        BufferedImage image = new BufferedImage(CAPTCHA_WIDTH, CAPTCHA_HEIGHT, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = image.createGraphics();
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, CAPTCHA_WIDTH, CAPTCHA_HEIGHT);
        g.setColor(Color.BLACK);
        g.drawString(captcha, 15, 25);
        g.dispose();

        javax.imageio.ImageIO.write(image, "png", os);
        os.close();
    }

    private String generateCaptcha(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random random = new Random();
        StringBuilder captcha = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            captcha.append(chars.charAt(random.nextInt(chars.length())));
        }
        return captcha.toString();
    }
}
