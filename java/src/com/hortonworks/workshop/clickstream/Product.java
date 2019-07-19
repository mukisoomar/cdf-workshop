package com.hortonworks.workshop.clickstream;

public class Product {
    private String id;
    private String url;
    private String category;

    public Product(String id, String url, String category) {
        this.id = id;
        this.url = url;
        this.category = category;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String toString() {
        String value = getId() + ", " + getUrl() + ", " + getCategory();
        return value;
    }
}
