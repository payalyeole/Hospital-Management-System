<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Appointment Management</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body class="container mt-4">

<h2 class="text-center mb-4">Hospital Management - Appointments</h2>

<!-- ================= ADD APPOINTMENT FORM ================= -->
<div class="card mb-4">
    <div class="card-header">Book Appointment</div>
    <div class="card-body">
        <form id="appointmentForm">
            <div class="row g-2">

                <div class="col-md-4">
                    <input type="date" id="date" class="form-control" required>
                </div>

                <div class="col-md-4">
                    <select id="doctorName" class="form-control" required>
                        <option value="">Select Doctor</option>
                    </select>
                </div>

                <div class="col-md-4">
                    <select id="patientName" class="form-control" required>
                        <option value="">Select Patient</option>
                    </select>
                </div>
            </div>
            <button type="submit" class="btn btn-primary mt-3">Book Appointment</button>
        </form>
    </div>
</div>

<!-- ================= APPOINTMENT TABLE ================= -->
<div class="card">
    <div class="card-header">Appointment List</div>
    <div class="card-body">

        <table class="table table-bordered text-center">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Date</th>
                    <th>Doctor Name</th>
                    <th>Patient Name</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody id="appointmentTable"></tbody>
        </table>

        <!-- PAGINATION -->
        <div class="d-flex justify-content-between align-items-center">
            <button id="prevBtn" class="btn btn-secondary">Previous</button>
            <span id="pageInfo" class="fw-bold"></span>
            <button id="nextBtn" class="btn btn-secondary">Next</button>
        </div>

    </div>
</div>

<script>
function loadDoctors() {
    $.ajax({
        url: "/api/v1/doctors/names",
        type: "GET",
        success: function(data) {
            let options = `<option value="">Select Doctor</option>`;
            data.forEach(name => {
                options += `<option value="${name}">${name}</option>`;
            });
            $("#doctorName").html(options);
        },
        error: function() {
            console.error("Error loading doctors");
        }
    });
}

function loadPatients() {
    $.ajax({
        url: "/api/v1/patients/names",
        type: "GET",
        success: function(data) {
            let options = `<option value="">Select Patient</option>`;
            data.forEach(name => {
                options += `<option value="${name}">${name}</option>`;
            });
            $("#patientName").html(options);
        },
        error: function() {
            console.error("Error loading patients");
        }
    });
}
</script>

<script>
const API_URL = "/api/v1/appointments";

let currentPage = 0;
let pageSize = 2;
let totalPages = 0;

/* ================= LOAD APPOINTMENTS ================= */
function loadAppointments() {
    $.ajax({
        url: API_URL,
        type: "GET",
        data: {
            page: currentPage,
            size: pageSize
        },
        success: function(response) {

            let rows = "";

            if (response.content.length === 0) {
                rows = `<tr><td colspan="5">No appointments found</td></tr>`;
            } else {
                response.content.forEach(a => {
                    rows += `
                        <tr>
                            <td>${a.id}</td>
                            <td>${a.date}</td>
                            <td>${a.doctorName}</td>
                            <td>${a.patientName}</td>
                            <td>
                                <button class="btn btn-danger btn-sm"
                                    onclick="deleteAppointment(${a.id})">
                                    Delete
                                </button>
                            </td>
                        </tr>
                    `;
                });
            }

            $("#appointmentTable").html(rows);

            totalPages = response.totalPages || 1;
            $("#pageInfo").text(`Page ${currentPage + 1} of ${totalPages}`);

            $("#prevBtn").prop("disabled", currentPage === 0);
            $("#nextBtn").prop("disabled", currentPage >= totalPages - 1);
        },
        error: function(err) {
            console.error("Error loading appointments", err);
        }
    });
}

/* ================= ADD APPOINTMENT ================= */
$("#appointmentForm").submit(function(e) {
    e.preventDefault();

    const appointmentData = {
        date: $("#date").val(),
        doctorName: $("#doctorName").val(),
        patientName: $("#patientName").val()
    };

    $.ajax({
        url: API_URL,
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(appointmentData),
        success: function() {
            $("#appointmentForm")[0].reset();
            currentPage = 0;
            loadAppointments();
        },
        error: function(err) {
            console.error("Error saving appointment", err);
        }
    });
});

/* ================= DELETE ================= */
function deleteAppointment(id) {
    if (confirm("Are you sure?")) {
        $.ajax({
            url: API_URL + "/" + id,
            type: "DELETE",
            success: function() {
                if (currentPage > 0) currentPage--;
                loadAppointments();
            }
        });
    }
}

/* ================= PAGINATION ================= */
$("#nextBtn").click(function() {
    if (currentPage < totalPages - 1) {
        currentPage++;
        loadAppointments();
    }
});

$("#prevBtn").click(function() {
    if (currentPage > 0) {
        currentPage--;
        loadAppointments();
    }
});

/* ================= INITIAL LOAD ================= */
$(document).ready(function() {
    loadDoctors();
    loadPatients();
    loadAppointments();
});

</script>

</body>
</html>
