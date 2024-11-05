package com.example.chatroom;

public class ChatMessage {
    private User fromUser;
    private User toUser;
    private String content;
    private boolean isPrivate;

    public ChatMessage(User fromUser, User toUser, String content, boolean isPrivate) {
        this.fromUser = fromUser;
        this.toUser = toUser;
        this.content = content;
        this.isPrivate = isPrivate;
    }

    public User getFromUser() {
        return fromUser;
    }

    public User getToUser() {
        return toUser;
    }

    public String getContent() {
        return content;
    }

    public boolean isPrivate() {
        return isPrivate;
    }

    @Override
    public String toString() {
        if (isPrivate) {
            return fromUser.getUsername() + "对" + toUser.getUsername() + "说：" + content;
        } else {
            return fromUser.getUsername() + "对所有人说：" + content;
        }
    }
}

