package com.example.chatroom;

import java.util.ArrayList;
import java.util.List;

public class ChatRoom {
    private List<User> onlineUsers = new ArrayList<>();
    private List<ChatMessage> messages = new ArrayList<>();

    public synchronized void addUser(User user) {
        onlineUsers.add(user);
    }

    public synchronized void removeUser(User user) {
        onlineUsers.remove(user);
    }

    public synchronized void addMessage(ChatMessage message) {
        messages.add(message);
    }

    public synchronized List<ChatMessage> getMessages(User user) {
        List<ChatMessage> result = new ArrayList<>();
        for (ChatMessage message : messages) {
            if (!message.isPrivate() || message.getToUser().equals(user) || message.getFromUser().equals(user)) {
                result.add(message);
            }
        }
        return result;
    }

    public synchronized List<User> getOnlineUsers() {
        return new ArrayList<>(onlineUsers);
    }

    public boolean isUsernameTaken(String username) {
        for (User user : onlineUsers) {
            if (user.getUsername().equals(username)) {
                return true;
            }
        }
        return false;
    }
}

