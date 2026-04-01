package com.hms.HospitalManagementSystem.controller;

import com.hms.HospitalManagementSystem.models.Medicine;
import com.hms.HospitalManagementSystem.service.MedicineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/medicines")
public class MedicineController {

    @Autowired
    private MedicineService medicineService;

    // GET  /api/v1/medicines?page=0&size=6
    @GetMapping
    public Page<Medicine> getAllMedicines(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "6") int size) {
        System.out.println("Fetching medicines - page: " + page);
        return medicineService.getAllMedicines(page, size);
    }

    // GET  /api/v1/medicines/{id}
    @GetMapping("/{id}")
    public Medicine getMedicineById(@PathVariable Long id) {
        return medicineService.getMedicineById(id);
    }

    // POST /api/v1/medicines
    @PostMapping
    public Medicine createMedicine(@RequestBody Medicine medicine) {
        System.out.println("Creating medicine: " + medicine.getName());
        return medicineService.createMedicine(medicine);
    }

    // PUT  /api/v1/medicines/{id}
    @PutMapping("/{id}")
    public Medicine updateMedicine(@PathVariable Long id,
                                   @RequestBody Medicine medicine) {
        System.out.println("Updating medicine ID: " + id);
        return medicineService.updateMedicine(id, medicine);
    }

    // DELETE /api/v1/medicines/{id}
    @DeleteMapping("/{id}")
    public void deleteMedicine(@PathVariable Long id) {
        System.out.println("Deleting medicine ID: " + id);
        medicineService.deleteMedicine(id);
    }

    // PATCH /api/v1/medicines/{id}/stock?quantity=50
    @PatchMapping("/{id}/stock")
    public Medicine updateStock(@PathVariable Long id,
                                @RequestParam int quantity) {
        System.out.println("Updating stock for medicine ID: " + id + " → " + quantity);
        return medicineService.updateStock(id, quantity);
    }
}