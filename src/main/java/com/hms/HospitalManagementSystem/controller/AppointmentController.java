package com.hms.HospitalManagementSystem.controller;

import com.hms.HospitalManagementSystem.models.Appointment;
import com.hms.HospitalManagementSystem.service.AppointmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

import java.util.List;

// BUG FIX: Removed the erroneous generic type parameter <appointment>.
// @RestController classes must never have generic type parameters.
// Having AppointmentController<appointment> causes a compilation error
// because 'appointment' is not a defined type, and controllers are
// instantiated by Spring as concrete classes, not generic templates.
@RestController
@RequestMapping("/api/v1/appointments")
public class AppointmentController {

    @Autowired
    private AppointmentService appointmentService;

    @GetMapping
    public Page<Appointment> getAllAppointment(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "5") int size) {

        System.out.println("Fetching from Appointment");
        return appointmentService.getAllAppointments(page, size);
    }

    @PostMapping
    public Appointment createAppointment(@RequestBody Appointment appointment) {
        System.out.println("Creating appointment");
        return appointmentService.createAppointment(appointment);
    }

    @GetMapping("/{id}")
    public Appointment getAppointmentById(@PathVariable Long id) {
        System.out.println("Fetching appointment by ID: " + id);
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

        System.out.println("Updating appointment with ID: " + id);
        return appointmentService.updateAppointment(id, appointment);
    }
}