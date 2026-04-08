package com.hms.HospitalManagementSystem.service;

import com.hms.HospitalManagementSystem.models.Invoice;
import com.hms.HospitalManagementSystem.repository.InvoiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class InvoiceService {

    @Autowired
    private InvoiceRepository invoiceRepository;

    public Page<Invoice> getAllInvoices(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return invoiceRepository.findAll(pageable);
    }

    public Invoice getInvoiceById(Long id) {
        return invoiceRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Invoice not found with id: " + id));
    }

    public Invoice createInvoice(Invoice invoice) {
        if (invoice.getStatus() == null || invoice.getStatus().isEmpty()) {
            invoice.setStatus("Unpaid");
        }
        return invoiceRepository.save(invoice);
    }

    public Invoice updateStatus(Long id, String status) {
        Invoice existing = getInvoiceById(id);
        existing.setStatus(status);
        return invoiceRepository.save(existing);
    }

    public Invoice updateInvoice(Long id, Invoice updated) {
        Invoice existing = getInvoiceById(id);
        existing.setDescription(updated.getDescription());
        existing.setAmount(updated.getAmount());
        existing.setStatus(updated.getStatus());
        existing.setPaymentMode(updated.getPaymentMode());
        existing.setInvoiceDate(updated.getInvoiceDate());
        return invoiceRepository.save(existing);
    }

    public void deleteInvoice(Long id) {
        invoiceRepository.deleteById(id);
    }
}