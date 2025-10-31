package com.hms.HospitalManagementSystem.repository;

import com.hms.HospitalManagementSystem.models.Doctor;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DoctorRepository  extends JpaRepository<Doctor, Long> {
}
