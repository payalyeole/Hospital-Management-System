package com.hms.HospitalManagementSystem.controller;
import com.hms.HospitalManagementSystem.models.Doctor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/doctors")
public class DoctorController {

    @GetMapping
    public List<Doctor> getAllDoctors(){
        System.out.println("Fetching ");
        return null;
    }
    @PostMapping
    public Doctor createDoctor(@RequestBody Doctor doctor){
        System.out.println("Creating doctor");

        return  doctor;
    }

    @GetMapping("/{id}")
    public Doctor getDoctorById(@PathVariable Long id){
        System.out.println("Fetching id by ID");
        return null;
    }

    @GetMapping("/{id}")
    public void deleteDoctor(@PathVariable Long id){
    }

    @GetMapping("/{id}")
    public void updateDoctor(@PathVariable Long id){
    }
}
