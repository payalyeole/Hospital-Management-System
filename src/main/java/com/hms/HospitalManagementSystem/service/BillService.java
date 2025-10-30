package com.hms.HospitalManagementSystem.service;

import com.hms.HospitalManagementSystem.models.Bill;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BillService {

    private static final Logger logger = LoggerFactory.getLogger(BillService.class);

    public List<Bill> getAllBills(){
        try{
            System.out.println("into service layer");
            return null;
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
