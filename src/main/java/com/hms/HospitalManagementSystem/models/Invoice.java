package com.hms.HospitalManagementSystem.models;

import jakarta.persistence.*;

@Entity
@Table(name = "invoice")
public class Invoice {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;

    @Column(nullable = false)
    private String invoiceDate;   // YYYY-MM-DD

    @Column(nullable = false)
    private String description;   // e.g. Consultation, Lab Tests, Medicine

    @Column(nullable = false)
    private double amount;        // total amount in INR

    @Column(nullable = false)
    private String status;        // Paid, Unpaid, Pending

    @Column
    private String paymentMode;   // Cash, Card, UPI, Insurance

    // ── Constructors ──────────────────────────────────────────────────────────
    public Invoice() {}

    // ── Getters & Setters ─────────────────────────────────────────────────────
    public Long getId()                          { return id; }
    public void setId(Long id)                   { this.id = id; }

    public Patient getPatient()                  { return patient; }
    public void setPatient(Patient patient)      { this.patient = patient; }

    public String getInvoiceDate()               { return invoiceDate; }
    public void setInvoiceDate(String d)         { this.invoiceDate = d; }

    public String getDescription()               { return description; }
    public void setDescription(String desc)      { this.description = desc; }

    public double getAmount()                    { return amount; }
    public void setAmount(double amount)         { this.amount = amount; }

    public String getStatus()                    { return status; }
    public void setStatus(String status)         { this.status = status; }

    public String getPaymentMode()               { return paymentMode; }
    public void setPaymentMode(String mode)      { this.paymentMode = mode; }
}