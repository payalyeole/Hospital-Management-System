package com.hms.HospitalManagementSystem.controller;

import com.hms.HospitalManagementSystem.models.Appointment;
import com.hms.HospitalManagementSystem.service.AppointmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/appointments")
public class AppointmentController<appointment> {

    @Autowired
    private AppointmentService appointmentService;

    @GetMapping
    public Page<Appointment> getAllAppointment(@RequestParam(defaultValue = "0")int page,
                                               @RequestParam(defaultValue = "2") int size){
        System.out.println("Fetching from Appointment");
        return appointmentService.getAllAppointments(page, size);
    }

    @PostMapping
    public Appointment createAppointment(@RequestBody Appointment appointment){
        System.out.println("Creating appointment");
        return appointmentService.createAppointment(appointment);
    }

    @GetMapping("/{id}")
    public Appointment getAppointmentById(@PathVariable Long id){
        System.out.println("Fetching id by ID");
        return appointmentService.getAppointmentById(id);
    }

    @DeleteMapping("/{id}")
    public void deleteAppointment(@PathVariable Long id){
        appointmentService.deleteAppointment(id);
    }

    @PutMapping("/{id}")
    public Appointment updateAppointment(@PathVariable Long id,@RequestBody Appointment appointment){
        return appointmentService.updateAppointment(id, appointment);
    }
}
