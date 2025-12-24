package com.hms.HospitalManagementSystem.repository;

import com.hms.HospitalManagementSystem.models.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PatientRepository extends JpaRepository<Patient, Long> {
    @Query("SELECT p.name FROM Patient p")
    List<String> findAllPatientNames();
}
