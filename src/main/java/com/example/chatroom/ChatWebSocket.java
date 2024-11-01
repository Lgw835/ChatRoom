package com.example.chatroom;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;

@ServerEndpoint("/chat")
public class ChatWebSocket {
    private static Set<Session> clients = new CopyOnWriteArraySet<>();
    private static Map<Session, String> usernames = new ConcurrentHashMap<>();

    @OnOpen
    public void onOpen(Session session) {
        clients.add(session);
    }

    @OnClose
    public void onClose(Session session) {
        clients.remove(session);
        usernames.remove(session);
        broadcastUserList();
    }

    @OnMessage
    public void onMessage(String message, Session senderSession) {
        if (message.startsWith("USERNAME:")) {
            String username = message.replace("USERNAME:", "").trim();
            usernames.put(senderSession, username);
            broadcastUserList();
        } else {
            for (Session client : clients) {
                try {
                    if (client.isOpen()) {
                        client.getBasicRemote().sendText(message);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private void broadcastUserList() {
        // 生成在线用户名列表并发送给所有客户端
        String userList = usernames.values().stream()
                .reduce((a, b) -> a + "," + b)
                .orElse("");
        for (Session session : clients) {
            session.getAsyncRemote().sendText("USER_LIST:" + userList);
        }
    }
}
