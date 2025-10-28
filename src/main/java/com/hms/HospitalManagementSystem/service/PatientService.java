package com.hms.HospitalManagementSystem.service;

import com.hms.HospitalManagementSystem.models.Patient;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PatientService {
    public List<Patient> getAllPatients(){
        try{
            System.out.println("into service layer");
            return null;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            return null;
        }
    }

    public Patient getPatientById(Long id){
        try{
            return null;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            return null;
        }
    }

    public Patient createPatient(Patient patient){
        try{
            return null;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            return null;
        }
    }

    public void deletePatient(Long id){
        try{

        }catch (Exception e){
            System.out.println("Error message: "+e.getMessage());
        }
    }

    public void updatePatient(Long id){
        try{

        }catch (Exception e){
            System.out.println("Error message: "+e.getMessage());
        }
    }
}
