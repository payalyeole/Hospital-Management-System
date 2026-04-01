package com.hms.HospitalManagementSystem.service;

import com.hms.HospitalManagementSystem.models.LabReport;
import com.hms.HospitalManagementSystem.repository.LabReportRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class LabReportService {

    @Autowired
    private LabReportRepository labReportRepository;

    // ── Get all reports (paginated) ───────────────────────────────────────────
    public Page<LabReport> getAllReports(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return labReportRepository.findAll(pageable);
    }

    // ── Get single report ─────────────────────────────────────────────────────
    public LabReport getReportById(Long id) {
        return labReportRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Lab report not found with id: " + id));
    }

    // ── Create new report ─────────────────────────────────────────────────────
    public LabReport createReport(LabReport report) {
        // Default status to Pending if not provided
        if (report.getStatus() == null || report.getStatus().isEmpty()) {
            report.setStatus("Pending");
        }
        return labReportRepository.save(report);
    }

    // ── Update full report ────────────────────────────────────────────────────
    public LabReport updateReport(Long id, LabReport updated) {
        LabReport existing = getReportById(id);
        existing.setTestName(updated.getTestName());
        existing.setStatus(updated.getStatus());
        existing.setReportDate(updated.getReportDate());
        existing.setResult(updated.getResult());
        existing.setRemarks(updated.getRemarks());
        if (updated.getPatient() != null) {
            existing.setPatient(updated.getPatient());
        }
        return labReportRepository.save(existing);
    }

    // ── Update status only ────────────────────────────────────────────────────
    public LabReport updateStatus(Long id, String status, String result, String remarks) {
        LabReport existing = getReportById(id);
        existing.setStatus(status);
        if (result  != null) existing.setResult(result);
        if (remarks != null) existing.setRemarks(remarks);
        return labReportRepository.save(existing);
    }

    // ── Delete report ─────────────────────────────────────────────────────────
    public void deleteReport(Long id) {
        labReportRepository.deleteById(id);
    }
}