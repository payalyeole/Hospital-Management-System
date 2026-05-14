package com.hms.HospitalManagementSystem.dto;

public class AppointmentDTO {

    private Long id;
    private String date;
    private String doctorName;
    private String patientName;
    private Long doctorId;
    private Long patientId;

    public AppointmentDTO() {
    }

    public AppointmentDTO(Long id, String date, String doctorName, String patientName, Long doctorId, Long patientId) {
        this.id = id;
        this.date = date;
        this.doctorName = doctorName;
        this.patientName = patientName;
        this.doctorId = doctorId;
        this.patientId = patientId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public Long getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(Long doctorId) {
        this.doctorId = doctorId;
    }

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }
}
