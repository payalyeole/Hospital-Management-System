package com.hms.HospitalManagementSystem.service;

import com.hms.HospitalManagementSystem.models.Bill;
import com.hms.HospitalManagementSystem.repository.BillRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BillService {

    private static final Logger logger = LoggerFactory.getLogger(BillService.class);

    @Autowired
    private BillRepository billRepository;

    public Page<Bill> getAllBills(int page, int size){
        try{
            System.out.println("into service layer");
            Pageable pageable = PageRequest.of(page, size);
            return billRepository.findAll(pageable);
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            logger.error("An error occurred while fetching all bill {}", e.getMessage());
            return null;
        }
    }

    public Bill getBillById(Long id){
        try{
            return null;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            logger.error("An error occurred while fetching bill by id {} : {}", id, e.getMessage());
            return null;
        }
    }

    public Bill createBill(Bill bill){
        try{
            return null;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            logger.error("An error occurred while creating creating {}", e.getMessage());
            return null;
        }
    }

    public void deleteBill(Long id){
        try{

        }catch (Exception e){
            System.out.println("Error message: "+e.getMessage());
            logger.error("An error occurred while deleting bill {}", e.getMessage());
        }
    }

    public Bill updateBill(Long id, Bill bill){
        try{
            return null;
        }catch (Exception e){
            System.out.println("Error message: "+e.getMessage());
            logger.error("An error occurred while updating bill {}", e.getMessage());
            return null;
        }
    }
}
