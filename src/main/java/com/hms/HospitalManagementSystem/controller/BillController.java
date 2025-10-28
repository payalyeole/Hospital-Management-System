package com.hms.HospitalManagementSystem.controller;

import com.hms.HospitalManagementSystem.models.Bill;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/bills")
public class BillController {

    @GetMapping
    public List<Bill> getAllBills(){
        System.out.println("Fetching ");
        return null;
    }
    @PostMapping
    public Bill createBill(@RequestBody Bill bill){
        System.out.println("Creating bill");

        return  bill;
    }

    @GetMapping("/{id}")
    public Bill getBillById(@PathVariable Long id){
        System.out.println("Fetching id by ID");
        return null;
    }

    @GetMapping("/{id}")
    public void deleteBill(@PathVariable Long id){
    }

    @GetMapping("/{id}")
    public void updateBill(@PathVariable Long id) {
    }

}
