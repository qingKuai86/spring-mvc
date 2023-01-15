package com.Z09420121.domain;

public class Booking {
    private String username;
    private Integer id;

    public Booking() {
    }

    public Booking(String username, Integer id) {
        this.username = username;
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "Booking{" +
                "username='" + username + '\'' +
                ", id=" + id +
                '}';
    }
}
