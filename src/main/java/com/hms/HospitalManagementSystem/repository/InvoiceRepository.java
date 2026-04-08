package com.hms.HospitalManagementSystem.repository;

import com.hms.HospitalManagementSystem.models.Invoice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface InvoiceRepository extends JpaRepository<Invoice, Long> {
}