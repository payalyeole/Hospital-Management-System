package com.hms.HospitalManagementSystem.repository;

import com.hms.HospitalManagementSystem.models.Medicine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MedicineRepository extends JpaRepository<Medicine, Long> {
    // JpaRepository gives us:
    // save(), findById(), findAll(), deleteById(), count(), etc.
    // Spring Data pagination is available via findAll(Pageable)
}