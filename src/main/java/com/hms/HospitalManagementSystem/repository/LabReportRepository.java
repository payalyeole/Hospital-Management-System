package com.hms.HospitalManagementSystem.repository;

import com.hms.HospitalManagementSystem.models.LabReport;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LabReportRepository extends JpaRepository<LabReport, Long> {
    // JpaRepository provides: save(), findById(), findAll(Pageable), deleteById(), count()
}