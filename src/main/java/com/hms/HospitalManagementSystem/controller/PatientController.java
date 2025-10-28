package com.hms.HospitalManagementSystem.controller;

import com.hms.HospitalManagementSystem.models.Patient;
import org.springframework.web.bind.annotation.*;


import java.util.List;

@RestController
@RequestMapping("api/v1/patients")
public class PatientController {

    @GetMapping
    public List<Patient> getAllPatients(){
        System.out.println("Fetching ");
        return null;
    }
    @PostMapping
    public Patient createPatient(@RequestBody Patient patient){
        System.out.println("Creating patient");

        return  patient;
    }

    @GetMapping("/{id}")
    public Patient getPatientById(@PathVariable Long id){
        System.out.println("Fetching id by ID");
        return null;
    }

    @GetMapping("/{id}")
    public void deletePatient(@PathVariable Long id){
    }

    @GetMapping("/{id}")
    public void updatePatient(@PathVariable Long id){
    }
}
