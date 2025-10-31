package com.hms.HospitalManagementSystem.repository;

import com.hms.HospitalManagementSystem.models.Bill;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BillRepository extends JpaRepository<Bill, Long> {

}
