package com.hms.HospitalManagementSystem.models;

import jakarta.persistence.*;

@Entity
@Table(name = "medicine")
public class Medicine {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String category;   // e.g. Antibiotic, Painkiller, Vitamin

    @Column(nullable = false)
    private String manufacturer;

    @Column(nullable = false)
    private int quantity;      // stock count

    @Column(nullable = false)
    private double price;      // price per unit (INR)

    @Column(name = "expiry_date", nullable = false)
    private String expiryDate; // stored as "YYYY-MM-DD" string for simplicity

    // ── Constructors ──────────────────────────────────────────────────────────
    public Medicine() {}

    public Medicine(String name, String category, String manufacturer,
                    int quantity, double price, String expiryDate) {
        this.name         = name;
        this.category     = category;
        this.manufacturer = manufacturer;
        this.quantity     = quantity;
        this.price        = price;
        this.expiryDate   = expiryDate;
    }

    // ── Getters & Setters ─────────────────────────────────────────────────────
    public Long getId()                     { return id; }
    public void setId(Long id)              { this.id = id; }

    public String getName()                 { return name; }
    public void setName(String name)        { this.name = name; }

    public String getCategory()             { return category; }
    public void setCategory(String cat)     { this.category = cat; }

    public String getManufacturer()         { return manufacturer; }
    public void setManufacturer(String m)   { this.manufacturer = m; }

    public int getQuantity()                { return quantity; }
    public void setQuantity(int quantity)   { this.quantity = quantity; }

    public double getPrice()                { return price; }
    public void setPrice(double price)      { this.price = price; }

    public String getExpiryDate()           { return expiryDate; }
    public void setExpiryDate(String date)  { this.expiryDate = date; }
}