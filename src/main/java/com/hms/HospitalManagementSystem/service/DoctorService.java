package com.hms.HospitalManagementSystem.service;

import com.hms.HospitalManagementSystem.models.Doctor;
import com.hms.HospitalManagementSystem.repository.PatientRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.hms.HospitalManagementSystem.repository.DoctorRepository;

import java.util.List;

@Service
public class DoctorService {

    private static final Logger logger = LoggerFactory.getLogger(DoctorService.class);

    @Autowired
    private DoctorRepository doctorRepository;

    public Page<Doctor> getAllDoctors(int page, int size){
        try{
            System.out.println("into service layer");
            Pageable pageable = PageRequest.of(page, size);
            return doctorRepository.findAll(pageable);
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
