package com.hms.HospitalManagementSystem.service;

import com.hms.HospitalManagementSystem.models.Patient;
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PatientService {

    private static final Logger logger = LoggerFactory.getLogger(PatientService.class);

    public List<Patient> getAllPatients(){
        try{
            System.out.println("into service layer");
            return null;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            logger.error("An error occurred while fetching all patient: {}", e.getMessage());
            return null;
        }
    }

    public Patient getPatientById(Long id){
        try{
            return null;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            logger.error("An error occurred while fetching patient with Id {} : {}", id, e.getMessage());
            return null;
        }
    }

    public Patient createPatient(Patient patient){
        try{
            return null;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            logger.error("An error occurred while creating patient {} ", e.getMessage());
            return null;
        }
    }

    public void deletePatient(Long id){
        try{

        }catch (Exception e){
            System.out.println("Error message: "+e.getMessage());
            logger.error("An error occurred while deleting patient {} ", e.getMessage());
        }
    }

    public void updatePatient(Long id){
        try{

        }catch (Exception e){
            System.out.println("Error message: "+e.getMessage());
            logger.error("An error occurred while updating patient {} ", e.getMessage());
        }
    }
}
