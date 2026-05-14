package com.hms.HospitalManagementSystem.controller;

import com.hms.HospitalManagementSystem.dto.AppointmentDTO;
import com.hms.HospitalManagementSystem.models.Appointment;
import com.hms.HospitalManagementSystem.service.AppointmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/appointments")
public class AppointmentController {

    @Autowired
    private AppointmentService appointmentService;

    /** Returns Page<AppointmentDTO> so doctorName/patientName are always populated */
    @GetMapping
    public Page<AppointmentDTO> getAllAppointment(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "5") int size) {
        return appointmentService.getAllAppointments(page, size);
    }

    /**
     * Accepts JSON: { "doctorName": "...", "patientName": "...", "date": "..." }
     * Resolves names → IDs in the service layer.
     */
    @PostMapping
    public ResponseEntity<?> createAppointment(@RequestBody Map<String, String> body) {
        String doctorName  = body.get("doctorName");
        String patientName = body.get("patientName");
        String date        = body.get("date");

        if (doctorName == null || patientName == null || date == null) {
            return ResponseEntity.badRequest().body("doctorName, patientName and date are required.");
        }

        AppointmentDTO result = appointmentService.createAppointmentByNames(doctorName, patientName, date);
        if (result == null) {
            return ResponseEntity.badRequest().body("Doctor or Patient not found with the given names.");
        }
        return ResponseEntity.ok(result);
    }

    @GetMapping("/{id}")
    public Appointment getAppointmentById(@PathVariable Long id) {
        return appointmentService.getAppointmentById(id);
    }

    @DeleteMapping("/{id}")
    public void deleteAppointment(@PathVariable Long id) {
        appointmentService.deleteAppointment(id);
    }

    @PutMapping("/{id}")
    public Appointment updateAppointment(
            @PathVariable Long id,
            @RequestBody Appointment appointment) {
        return appointmentService.updateAppointment(id, appointment);
    }
}