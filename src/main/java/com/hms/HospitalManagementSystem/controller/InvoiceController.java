package com.hms.HospitalManagementSystem.controller;

import com.hms.HospitalManagementSystem.models.Invoice;
import com.hms.HospitalManagementSystem.service.InvoiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/invoices")
public class InvoiceController {

    @Autowired
    private InvoiceService invoiceService;

    // GET  /api/v1/invoices?page=0&size=6
    @GetMapping
    public Page<Invoice> getAllInvoices(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "6") int size) {
        return invoiceService.getAllInvoices(page, size);
    }

    // GET  /api/v1/invoices/{id}
    @GetMapping("/{id}")
    public Invoice getInvoiceById(@PathVariable Long id) {
        return invoiceService.getInvoiceById(id);
    }

    // POST /api/v1/invoices
    // Body: { description, amount, invoiceDate, status, paymentMode, patient:{id} }
    @PostMapping
    public Invoice createInvoice(@RequestBody Invoice invoice) {
        System.out.println("Creating invoice for patient ID: " + invoice.getPatient().getId());
        return invoiceService.createInvoice(invoice);
    }

    // PATCH /api/v1/invoices/{id}/status?status=Paid
    @PatchMapping("/{id}/status")
    public Invoice updateStatus(@PathVariable Long id,
                                @RequestParam String status) {
        return invoiceService.updateStatus(id, status);
    }

    // PUT  /api/v1/invoices/{id}
    @PutMapping("/{id}")
    public Invoice updateInvoice(@PathVariable Long id,
                                 @RequestBody Invoice invoice) {
        return invoiceService.updateInvoice(id, invoice);
    }

    // DELETE /api/v1/invoices/{id}
    @DeleteMapping("/{id}")
    public void deleteInvoice(@PathVariable Long id) {
        invoiceService.deleteInvoice(id);
    }
}