package com.hms.HospitalManagementSystem.service;

import com.hms.HospitalManagementSystem.models.Appointment;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AppointmentService {

    public List<Appointment> getAllAppointments(){
        try{
            System.out.println("into service layer");
            return null;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            return null;
        }
    }

    public Appointment getAppointmentById(Long id){
        try{
            return null;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            return null;
        }
    }

    public Appointment createAppointment(Appointment appointment){
        try{
            return null;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            return null;
        }
    }

    public void deleteAppointment(Long id){
        try{

        }catch (Exception e){
            System.out.println("Error message: "+e.getMessage());
        }
    }

    public void updateAppointment(Long id){
        try{

        }catch (Exception e){
            System.out.println("Error message: "+e.getMessage());
        }
    }
}
