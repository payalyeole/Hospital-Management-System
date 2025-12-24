<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctor Management</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body class="container mt-4">

<h2 class="text-center mb-4">Hospital Management - Doctors</h2>

<!-- Add Doctor Form -->
<div class="card mb-4">
    <div class="card-header">Add Doctors</div>
    <div class="card-body">
        <form id="doctorForm">
            <div class="row g-2">
                <div class="col-md-6">
                    <input type="text" id="name" class="form-control" placeholder="Name" required>
                </div>
                <div class="col-md-6">
                    <input type="text" id="speciality" class="form-control" placeholder="Speciality" required>
                </div>
            </div>
            <button type="submit" class="btn btn-primary mt-3">Add Doctor</button>
        </form>
    </div>
</div>

<!-- Doctor Table -->
<div class="card">
    <div class="card-header">Doctor List</div>
    <div class="card-body">
        <table class="table table-bordered text-center">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Speciality</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody id="doctorTable"></tbody>
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
const API_URL = "/api/v1/doctors";

let currentPage = 0;
let pageSize = 2;
let totalPages = 0;

function loadDoctors() {
    $.ajax({
        url: API_URL + "?page=" + currentPage+ "&size=" + pageSize,
        type: "GET",
        success: function(response) {

            console.log("API RESPONSE => ", response);

            let rows = "";

            response.content.forEach(function(d) {
                rows +=
                    "<tr>" +
                    "<td>" + d.id + "</td>" +
                    "<td>" + d.name + "</td>" +
                    "<td>" + d.speciality + "</td>" +
                    "<td>" +
                        "<button class='btn btn-danger btn-sm' onclick='deleteDoctor(" + d.id + ")'>Delete</button>" +
                    "</td>" +
                    "</tr>";
            });

            $("#doctorTable").html(rows);

            totalPages = response.totalPages;
            $("#pageInfo").text(`Page ${currentPage + 1} of ${totalPages}`);
            $("#prevBtn").prop("disabled", currentPage === 0);
            $("#nextBtn").prop("disabled", currentPage === totalPages - 1);
        },
        error: function(err) {
            console.error("Error loading doctors", err);
        }
    });
}

/* ================= ADD DOCTOR ================= */
$("#doctorForm").submit(function(e) {
    e.preventDefault();

    const doctorData = {
        name: $("#name").val(),
        speciality: $("#speciality").val(),
    };

    $.ajax({
        url: API_URL,
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(doctorData),
        success: function() {
            $("#doctorForm")[0].reset();
            currentPage = 0; // new data → first page
            loadDoctors();
        },
        error: function(err) {
            console.error("Error saving doctor", err);
        }
    });
});

// DELETE
function deleteDoctor(id) {
    if(confirm("Are you sure?")) {
        $.ajax({
            url: API_URL + "/" + id,
            type: "DELETE",
            success: function() {
                loadDoctors();
            }
        });
    }
}

// INITIAL LOAD
$(document).ready(function() {
    loadDoctors();
});

/* ================= PAGINATION ================= */
$("#nextBtn").click(() => {
    if(currentPage < totalPages - 1) {
        currentPage++;
        loadDoctors();
    }
});

$("#prevBtn").click(() => {
    if(currentPage > 0) {
        currentPage--;
        loadDoctors();
    }
});
</script>

</body>
</html>
