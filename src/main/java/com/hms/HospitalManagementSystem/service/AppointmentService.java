package com.hms.HospitalManagementSystem.service;

import com.hms.HospitalManagementSystem.dto.AppointmentDTO;
import com.hms.HospitalManagementSystem.models.Appointment;
import com.hms.HospitalManagementSystem.models.Doctor;
import com.hms.HospitalManagementSystem.models.Patient;
import com.hms.HospitalManagementSystem.repository.AppointmentRepository;
import com.hms.HospitalManagementSystem.repository.DoctorRepository;
import com.hms.HospitalManagementSystem.repository.PatientRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class AppointmentService {

    private static final Logger logger = LoggerFactory.getLogger(AppointmentService.class);

    @Autowired
    private AppointmentRepository appointmentRepository;

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private PatientRepository patientRepository;

    /** Convert Appointment entity → DTO with resolved names */
    private AppointmentDTO toDTO(Appointment a) {
        String doctorName  = "Unknown Doctor";
        String patientName = "Unknown Patient";

        try {
            Optional<Doctor> doc = doctorRepository.findById(a.getDoctorId());
            if (doc.isPresent()) doctorName = doc.get().getName();
        } catch (Exception ignored) {}

        try {
            Optional<Patient> pat = patientRepository.findById(a.getPatientId());
            if (pat.isPresent()) patientName = pat.get().getName();
        } catch (Exception ignored) {}

        return new AppointmentDTO(a.getId(), a.getDate(), doctorName, patientName,
                a.getDoctorId(), a.getPatientId());
    }

    /** GET all appointments – returns DTO page with resolved names */
    public Page<AppointmentDTO> getAllAppointments(int page, int size) {
        try {
            Pageable pageable = PageRequest.of(page, size);
            Page<Appointment> apptPage = appointmentRepository.findAll(pageable);
            List<AppointmentDTO> dtos = apptPage.getContent()
                    .stream()
                    .map(this::toDTO)
                    .collect(Collectors.toList());
            return new PageImpl<>(dtos, pageable, apptPage.getTotalElements());
        } catch (Exception e) {
            logger.error("Error fetching appointments: {}", e.getMessage());
            return Page.empty();
        }
    }

    public Appointment getAppointmentById(Long id) {
        try {
            return appointmentRepository.findById(id).orElse(null);
        } catch (Exception e) {
            logger.error("Error fetching appointment by id {}: {}", id, e.getMessage());
            return null;
        }
    }

    /**
     * Create appointment from DTO-style request.
     * The JSP sends {doctorName, patientName, date}.
     * We look up the IDs from name.
     */
    public AppointmentDTO createAppointmentByNames(String doctorName, String patientName, String date) {
        try {
            // Find doctor by name
            List<Doctor> doctors = doctorRepository.findAll();
            Doctor matchedDoctor = null;
            for (Doctor d : doctors) {
                if (d.getName() != null && d.getName().equalsIgnoreCase(doctorName)) {
                    matchedDoctor = d;
                    break;
                }
            }

            // Find patient by name
            List<Patient> patients = patientRepository.findAll();
            Patient matchedPatient = null;
            for (Patient p : patients) {
                if (p.getName() != null && p.getName().equalsIgnoreCase(patientName)) {
                    matchedPatient = p;
                    break;
                }
            }

            if (matchedDoctor == null || matchedPatient == null) {
                logger.error("Doctor or Patient not found: doctor='{}', patient='{}'", doctorName, patientName);
                return null;
            }

            Appointment appt = new Appointment();
            appt.setDoctorId(matchedDoctor.getId());
            appt.setPatientId(matchedPatient.getId());
            appt.setDate(date);
            appointmentRepository.save(appt);
            return toDTO(appt);
        } catch (Exception e) {
            logger.error("Error creating appointment: {}", e.getMessage());
            return null;
        }
    }

    public Appointment createAppointment(Appointment appointment) {
        try {
            return appointmentRepository.save(appointment);
        } catch (Exception e) {
            logger.error("Error creating appointment: {}", e.getMessage());
            return null;
        }
    }

    public void deleteAppointment(Long id) {
        try {
            appointmentRepository.deleteById(id);
        } catch (Exception e) {
            logger.error("Error deleting appointment {}: {}", id, e.getMessage());
        }
    }

    public Appointment updateAppointment(Long id, Appointment updateAppointment) {
        try {
            Optional<Appointment> existing = appointmentRepository.findById(id);
            if (existing.isPresent()) {
                Appointment a = existing.get();
                a.setDate(updateAppointment.getDate());
                a.setDoctorId(updateAppointment.getDoctorId());
                a.setPatientId(updateAppointment.getPatientId());
                return appointmentRepository.save(a);
            }
            logger.error("Appointment with Id {} not found", id);
            return null;
        } catch (Exception e) {
            logger.error("Error updating appointment {}: {}", id, e.getMessage());
            return null;
        }
    }
}
