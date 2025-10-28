package com.hms.HospitalManagementSystem.controller;

import com.hms.HospitalManagementSystem.models.Appointment;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/appointments")
public class AppointmentController {

    @GetMapping
    public List<Appointment> getAllAppointment(){
        System.out.println("Fetching ");
        return null;
    }
    @PostMapping
    public Appointment createAppointment(@RequestBody Appointment appointment){
        System.out.println("Creating appointment");
        return appointment;
    }

    @GetMapping("/{id}")
    public Appointment getAppointmentById(@PathVariable Long id){
        System.out.println("Fetching id by ID");
        return null;
    }

    @DeleteMapping("/{id}")
    public void deleteAppointment(@PathVariable Long id){
    }

    @PutMapping("/{id}")
    public void updateAppointment(@PathVariable Long id){
    }
}
