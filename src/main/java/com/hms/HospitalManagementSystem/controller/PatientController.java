package com.hms.HospitalManagementSystem.controller;

import com.hms.HospitalManagementSystem.models.Patient;
import com.hms.HospitalManagementSystem.service.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


import java.util.List;

@RestController
@RequestMapping("api/v1/patients")
public class PatientController<patient> {

    @Autowired
    private PatientService patientService;

    @GetMapping
    public List<Patient> getAllPatients(){
        System.out.println("Fetching from Patient");
        return patientService.getAllPatients();
    }
    @PostMapping
    public Patient createPatient(@RequestBody Patient patient){
        System.out.println("Creating patient");

        return patientService.createPatient(patient);
    }

    @GetMapping("/{id}")
    public Patient getPatientById(@PathVariable Long id){
        System.out.println("Fetching id by ID");
        return patientService.getPatientById(id);
    }

    @DeleteMapping("/{id}")
    public void deletePatient(@PathVariable Long id){
        patientService.deletePatient(id);
    }

    @PutMapping("/{id}")
    public Patient updatePatient(@PathVariable Long id, @RequestBody Patient patient){
        System.out.println("Update patient wit ID: "+id);
        return patientService.updatePatient(id, patient);
    }
}
