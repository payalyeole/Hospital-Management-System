package com.hms.HospitalManagementSystem.service;

import com.hms.HospitalManagementSystem.models.Doctor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DoctorService {

    private static final Logger logger = LoggerFactory.getLogger(DoctorService.class);

    public List<Doctor> getAllDoctors(){
        try{
            System.out.println("into service layer");
            return null;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            logger.error("An error occurred while fetching all doctors: {}", e.getMessage());
            return null;
        }
    }

    public Doctor getDoctorById(Long id){
        try{
            return null;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            logger.error("An error occurred while fetching doctor by id {} : {}", id, e.getMessage());
            return null;
        }
    }

    public Doctor createDoctor(Doctor doctor){
        try{
            return null;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            logger.error("An error occurred while creating doctor {}", e.getMessage());
            return null;
        }
    }

    public void deleteDoctor(Long id){
        try{

        }catch (Exception e){
            System.out.println("Error message: "+e.getMessage());
            logger.error("An error occurred while deleting doctor by id {}", e.getMessage());
        }
    }

    public Doctor updateDoctor(Long id, Doctor doctor){
        try{
            return null;
        }catch (Exception e){
            System.out.println("Error message: "+e.getMessage());
            logger.error("An error occurred while updating doctor {}", e.getMessage());
            return null;
        }
    }
}
