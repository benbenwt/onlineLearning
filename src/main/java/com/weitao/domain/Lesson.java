package com.weitao.domain;

public class Lesson {
    private Integer id;

    private String name;

    private String vedio;

    private Integer cid;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getVedio() {
        return vedio;
    }

    public void setVedio(String vedio) {
        this.vedio = vedio == null ? null : vedio.trim();
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public Lesson(Integer id, String name, String vedio, Integer cid) {
        this.id = id;
        this.name = name;
        this.vedio = vedio;
        this.cid = cid;
    }

    public Lesson() {
    }

    @Override
    public String toString() {
        return "Lesson{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", vedio='" + vedio + '\'' +
                ", cid=" + cid +
                '}';
    }
}