package com.hms.HospitalManagementSystem.controller;

import com.hms.HospitalManagementSystem.models.Bill;
import com.hms.HospitalManagementSystem.service.BillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/bills")
public class BillController {

    @Autowired
    private BillService billService;

    @GetMapping
    public Page<Bill> getAllBills(@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "2") int size){
        System.out.println("Fetching from Bill");
        return billService.getAllBills(page, size);
    }

    @GetMapping("/{id}")
    public Bill getBillById(@PathVariable Long id){
        System.out.println("Fetching id by ID");
        return billService.getBillById(id);
    }

    @PostMapping
    public Bill createBill(@RequestBody Bill bill){
        System.out.println("Creating bill");
        return  billService.createBill(bill);
    }

    @DeleteMapping("/{id}")
    public void deleteBill(@PathVariable Long id){
        billService.deleteBill(id);
    }

    @PutMapping("/{id}")
    public Bill updateBill(@PathVariable Long id, @RequestBody Bill bill) {
        System.out.println("Update Bill with ID: "+id);
        return billService.updateBill(id, bill);
    }

}
