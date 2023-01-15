package com.Z09420121.domain;

public class User {
    String username;
    String password;
    String isRoot="0";//1为管理员
    String img;
    public User() {
    }

    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public User(String username, String password, String isRoot) {
        this.username = username;
        this.password = password;
        this.isRoot = isRoot;
    }

    public User(String username, String password, String isRoot, String img) {
        this.username = username;
        this.password = password;
        this.isRoot = isRoot;
        this.img = img;
    }

    @Override
    public String toString() {
        return "User{" +
                "username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", isRoot='" + isRoot + '\'' +
                '}';
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public String getIsRoot() {
        return isRoot;
    }

    public void setIsRoot(String isRoot) {
        this.isRoot = isRoot;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}