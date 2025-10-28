package com.hms.HospitalManagementSystem.service;

import com.hms.HospitalManagementSystem.models.Doctor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DoctorService {

    public List<Doctor> getAllDoctors(){
        try{
            System.out.println("into service layer");
            return null;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            return null;
        }
    }

    public Doctor getDoctorById(Long id){
        try{
            return null;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            return null;
        }
    }

    public Doctor createDoctor(Doctor doctor){
        try{
            return null;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            return null;
        }
    }

    public void deleteDoctor(Long id){
        try{

        }catch (Exception e){
            System.out.println("Error message: "+e.getMessage());
        }
    }

    public void updateDoctor(Long id){
        try{

        }catch (Exception e){
            System.out.println("Error message: "+e.getMessage());
        }
    }
}
