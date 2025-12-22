package com.hms.HospitalManagementSystem.service;

import com.hms.HospitalManagementSystem.models.Appointment;

import com.hms.HospitalManagementSystem.repository.AppointmentRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AppointmentService {

    private static final Logger logger = LoggerFactory.getLogger(AppointmentService.class);

    private AppointmentRepository appointmentRepository;

    public Page<Appointment> getAllAppointments(int page, int size){
        try{
            System.out.println("into service layer");
            Pageable pageable = PageRequest.of(page, size);
            return appointmentRepository.findAll(pageable);
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            logger.error("An error occurred while fetching all appointment {}", e.getMessage());
            return null;
        }
    }

    public Appointment getAppointmentById(Long id){
        try{
            return null;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            logger.error("An error occurred while fetching appointment by id {} : {}", id, e.getMessage());
            return null;
        }
    }

    public Appointment createAppointment(Appointment appointment){
        try{
            return null;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            logger.error("An error occurred while creating appointment {}", e.getMessage());
            return null;
        }
    }

    public void deleteAppointment(Long id){
        try{

        }catch (Exception e){
            System.out.println("Error message: "+e.getMessage());
            logger.error("An error occurred while deleting appointment {}", e.getMessage());
        }
    }

    public Appointment updateAppointment(Long id , Appointment appointment){
        try{
            return null;
        }catch (Exception e){
            System.out.println("Error message: "+e.getMessage());
            logger.error("An error occurred while updating appointment{}", e.getMessage());
            return null;
        }
    }
}
