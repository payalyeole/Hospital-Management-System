package com.hms.HospitalManagementSystem.controller;
import com.hms.HospitalManagementSystem.models.Doctor;
import com.hms.HospitalManagementSystem.service.DoctorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/doctors")
public class DoctorController {
    @Autowired
    private DoctorService doctorService;

    @GetMapping
    public List<Doctor> getAllDoctors(){
        System.out.println("Fetching from Doctor");
        return doctorService.getAllDoctors();
    }
    @PostMapping
    public Doctor createDoctor(@RequestBody Doctor doctor){
        System.out.println("Creating doctor");
        return  doctorService.createDoctor(doctor);
    }

    @GetMapping("/{id}")
    public Doctor getDoctorById(@PathVariable Long id){
        System.out.println("Fetching id by ID");
        return doctorService.getDoctorById(id);
    }

    @DeleteMapping("/{id}")
    public void deleteDoctor(@PathVariable Long id){
        doctorService.deleteDoctor(id);
    }

    @PutMapping("/{id}")
    public Doctor updateDoctor(@PathVariable Long id, @RequestBody Doctor doctor){
        System.out.println("Update Doctor with ID: "+id);
        return doctorService.updateDoctor(id, doctor);
    }
}
