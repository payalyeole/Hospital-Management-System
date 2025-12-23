package com.hms.HospitalManagementSystem.service;

import com.hms.HospitalManagementSystem.models.Appointment;

import com.hms.HospitalManagementSystem.repository.AppointmentRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AppointmentService {

    private static final Logger logger = LoggerFactory.getLogger(AppointmentService.class);

    @Autowired
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
            Optional <Appointment> appointment = appointmentRepository.findById(id);
            return appointment.orElse(null);
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            logger.error("An error occurred while fetching appointment by id {} : {}", id, e.getMessage());
            return null;
        }
    }

    public Appointment createAppointment(Appointment appointment){
        try{
            appointmentRepository.save(appointment);
            return appointment;
        }catch (Exception e){
            System.out.println("Error message: " +e.getMessage());
            logger.error("An error occurred while creating appointment {}", e.getMessage());
            return null;
        }
    }

    public void deleteAppointment(Long id){
        try{
            logger.info("Deleting appointment by ID: {}", id);
            appointmentRepository.deleteById(id);
        }catch (Exception e){
            System.out.println("Error message: "+e.getMessage());
            logger.error("An error occurred while deleting appointment {}", e.getMessage());
        }
    }

    public Appointment updateAppointment(Long id , Appointment updateAppointment){
        try{
            Optional <Appointment> existingAppointment = appointmentRepository.findById(id);
            if(existingAppointment.isPresent()){
                Appointment a = existingAppointment.get();
                a.setDate(updateAppointment.getDate());
                a.setDoctorId(updateAppointment.getDoctorId());
                a.setPatientId(updateAppointment.getPatientId());
                appointmentRepository.save(a);
                return updateAppointment;
            }else {
                logger.error("Appointment with Id {} not found", id);
                return null;
            }

        }catch (Exception e){
            System.out.println("Error message: "+e.getMessage());
            logger.error("An error occurred while updating appointment{}", e.getMessage());
            return null;
        }
    }
}
