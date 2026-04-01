package com.hms.HospitalManagementSystem.service;

import com.hms.HospitalManagementSystem.models.Medicine;
import com.hms.HospitalManagementSystem.repository.MedicineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class MedicineService {

    @Autowired
    private MedicineRepository medicineRepository;

    // ── Get all medicines (paginated) ─────────────────────────────────────────
    public Page<Medicine> getAllMedicines(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return medicineRepository.findAll(pageable);
    }

    // ── Get single medicine by ID ─────────────────────────────────────────────
    public Medicine getMedicineById(Long id) {
        return medicineRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Medicine not found with id: " + id));
    }

    // ── Add new medicine ──────────────────────────────────────────────────────
    public Medicine createMedicine(Medicine medicine) {
        return medicineRepository.save(medicine);
    }

    // ── Update medicine ───────────────────────────────────────────────────────
    public Medicine updateMedicine(Long id, Medicine updated) {
        Medicine existing = getMedicineById(id);
        existing.setName(updated.getName());
        existing.setCategory(updated.getCategory());
        existing.setManufacturer(updated.getManufacturer());
        existing.setQuantity(updated.getQuantity());
        existing.setPrice(updated.getPrice());
        existing.setExpiryDate(updated.getExpiryDate());
        return medicineRepository.save(existing);
    }

    // ── Delete medicine ───────────────────────────────────────────────────────
    public void deleteMedicine(Long id) {
        medicineRepository.deleteById(id);
    }

    // ── Update stock quantity only ────────────────────────────────────────────
    public Medicine updateStock(Long id, int newQuantity) {
        Medicine existing = getMedicineById(id);
        existing.setQuantity(newQuantity);
        return medicineRepository.save(existing);
    }
}