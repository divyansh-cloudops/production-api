package com.divyansh.productionapi.dto;

public class ProductResponse {

    private Long id;
    private String name;
    private Double price;
    private Integer quantity;

    public ProductResponse() {
    }

    public ProductResponse(Long id, String name, Double price, Integer quantity) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public Double getPrice() {
        return price;
    }

    public Integer getQuantity() {
        return quantity;
    }
}