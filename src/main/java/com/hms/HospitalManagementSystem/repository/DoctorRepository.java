package com.hms.HospitalManagementSystem.repository;

import org.springframework.data.jpa.repository.JpaRepository;

public interface DoctorRepository <Doctor> extends JpaRepository<Doctor, Long> {
}
