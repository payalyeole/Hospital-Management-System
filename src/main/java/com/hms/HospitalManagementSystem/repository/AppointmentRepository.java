package com.hms.HospitalManagementSystem.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AppointmentRepository<Appointment> extends JpaRepository<Appointment, Long> {
}
