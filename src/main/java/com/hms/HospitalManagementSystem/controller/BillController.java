package com.hms.HospitalManagementSystem.controller;

import com.hms.HospitalManagementSystem.models.Bill;
import com.hms.HospitalManagementSystem.service.BillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/bills")
public class BillController {

    @Autowired
    private BillService billService;

    @GetMapping
    public List<Bill> getAllBills(){
        System.out.println("Fetching ");
        return billService.getAllBills();
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
    public void updateBill(@PathVariable Long id) {
        billService.updateBill(id);
    }

}
