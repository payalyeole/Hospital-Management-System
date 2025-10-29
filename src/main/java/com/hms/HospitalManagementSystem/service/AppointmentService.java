package com.hms.HospitalManagementSystem.service;

import com.hms.HospitalManagementSystem.models.Appointment;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AppointmentService {

    private static final Logger logger = LoggerFactory.getLogger(AppointmentService.class);

    public List<Appointment> getAllAppointments(){
        try{
            System.out.println("into service layer");
            return null;
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

    public void updateAppointment(Long id){
        try{

        }catch (Exception e){
            System.out.println("Error message: "+e.getMessage());
            logger.error("An error occurred while updating appointment{}", e.getMessage());
        }
    }
}
