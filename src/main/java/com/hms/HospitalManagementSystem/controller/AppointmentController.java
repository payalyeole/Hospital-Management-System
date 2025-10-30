package com.hms.HospitalManagementSystem.controller;

import com.hms.HospitalManagementSystem.models.Appointment;
import com.hms.HospitalManagementSystem.service.AppointmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/appointments")
public class AppointmentController {

    @Autowired
    private AppointmentService appointmentService;

    @GetMapping
    public List<Appointment> getAllAppointment(){
        System.out.println("Fetching from Appointment");
        return appointmentService.getAllAppointments();
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
    public Appointment updateAppointment(@PathVariable Long id, Appointment appointment){
        return appointmentService.updateAppointment(id, appointment);
    }
}
