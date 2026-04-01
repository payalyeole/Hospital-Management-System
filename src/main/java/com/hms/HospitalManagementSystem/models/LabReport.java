package com.hms.HospitalManagementSystem.models;

import jakarta.persistence.*;

@Entity
@Table(name = "lab_report")
public class LabReport {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;

    @Column(nullable = false)
    private String testName;       // e.g. Blood CBC, Urine Test

    @Column(nullable = false)
    private String status;         // Pending, Completed, Cancelled

    @Column(nullable = false)
    private String reportDate;     // YYYY-MM-DD

    @Column
    private String result;         // Normal, Abnormal, Critical (filled when Completed)

    @Column
    private String remarks;        // optional notes by lab technician

    // ── Constructors ──────────────────────────────────────────────────────────
    public LabReport() {}

    // ── Getters & Setters ─────────────────────────────────────────────────────
    public Long getId()                        { return id; }
    public void setId(Long id)                 { this.id = id; }

    public Patient getPatient()                { return patient; }
    public void setPatient(Patient patient)    { this.patient = patient; }

    public String getTestName()                { return testName; }
    public void setTestName(String testName)   { this.testName = testName; }

    public String getStatus()                  { return status; }
    public void setStatus(String status)       { this.status = status; }

    public String getReportDate()              { return reportDate; }
    public void setReportDate(String d)        { this.reportDate = d; }

    public String getResult()                  { return result; }
    public void setResult(String result)       { this.result = result; }

    public String getRemarks()                 { return remarks; }
    public void setRemarks(String remarks)     { this.remarks = remarks; }
}