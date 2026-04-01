package com.hms.HospitalManagementSystem.controller;

import com.hms.HospitalManagementSystem.models.LabReport;
import com.hms.HospitalManagementSystem.service.LabReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/lab-reports")
public class LabReportController {

    @Autowired
    private LabReportService labReportService;

    // GET  /api/v1/lab-reports?page=0&size=6
    @GetMapping
    public Page<LabReport> getAllReports(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "6") int size) {
        System.out.println("Fetching lab reports - page: " + page);
        return labReportService.getAllReports(page, size);
    }

    // GET  /api/v1/lab-reports/{id}
    @GetMapping("/{id}")
    public LabReport getReportById(@PathVariable Long id) {
        return labReportService.getReportById(id);
    }

    // POST /api/v1/lab-reports
    // Body: { testName, reportDate, status, result, remarks, patient: {id} }
    @PostMapping
    public LabReport createReport(@RequestBody LabReport report) {
        System.out.println("Creating lab report: " + report.getTestName());
        return labReportService.createReport(report);
    }

    // PUT  /api/v1/lab-reports/{id}
    @PutMapping("/{id}")
    public LabReport updateReport(@PathVariable Long id,
                                  @RequestBody LabReport report) {
        System.out.println("Updating lab report ID: " + id);
        return labReportService.updateReport(id, report);
    }

    // PATCH /api/v1/lab-reports/{id}/status?status=Completed&result=Normal&remarks=All+fine
    @PatchMapping("/{id}/status")
    public LabReport updateStatus(@PathVariable Long id,
                                  @RequestParam String status,
                                  @RequestParam(required = false) String result,
                                  @RequestParam(required = false) String remarks) {
        System.out.println("Updating status for lab report ID: " + id + " → " + status);
        return labReportService.updateStatus(id, status, result, remarks);
    }

    // DELETE /api/v1/lab-reports/{id}
    @DeleteMapping("/{id}")
    public void deleteReport(@PathVariable Long id) {
        System.out.println("Deleting lab report ID: " + id);
        labReportService.deleteReport(id);
    }
}