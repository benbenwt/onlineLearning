package com.weitao.domain;

public class Comments extends CommentsKey {
    private Integer star;

    private String text;

    private String nickname;

    @Override
    public String toString() {
        return "Comments{" +
                "star=" + star +
                ", text='" + text + '\'' +
                ", nickname='" + nickname + '\'' +
                '}';
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public Integer getStar() {
        return star;
    }

    public void setStar(Integer star) {
        this.star = star;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text == null ? null : text.trim();
    }


}