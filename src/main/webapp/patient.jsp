<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Management</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body class="container mt-4">

<h2 class="text-center mb-4">Hospital Management - Patients</h2>

<!-- Add Patient Form -->
<div class="card mb-4">
    <div class="card-header">Add Patient</div>
    <div class="card-body">
        <form id="patientForm">
            <div class="row g-2">
                <div class="col-md-4">
                    <input type="text" id="name" class="form-control" placeholder="Name" required>
                </div>
                <div class="col-md-4">
                    <input type="text" id="gender" class="form-control" placeholder="Gender" required>
                </div>
                <div class="col-md-4">
                    <input type="number" id="age" class="form-control" placeholder="Age" required>
                </div>
            </div>
            <button class="btn btn-primary mt-3">Add Patient</button>
        </form>
    </div>
</div>

<!-- Patient Table -->
<div class="card">
    <div class="card-header">Patient List</div>
    <div class="card-body">
        <table class="table table-bordered text-center">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Gender</th>
                    <th>Age</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody id="patientTable"></tbody>
        </table>
        <!-- PAGINATION -->
        <div class="d-flex justify-content-between">
            <button id="prevBtn" class="btn btn-secondary">Previous</button>
            <span id="pageInfo"></span>
            <button id="nextBtn" class="btn btn-secondary">Next</button>
        </div>

    </div>
</div>


<script>
const API_URL = "/api/v1/patients";

let currentPage = 0;
let pageSize = 2;
let totalPages = 0;

function loadPatients() {
    $.ajax({
        url: API_URL + "?page=" + currentPage+ "&size=" + pageSize,
        type: "GET",
        success: function(response) {

            console.log("API RESPONSE => ", response);

            let rows = "";

            response.content.forEach(function(p) {
                rows +=
                    "<tr>" +
                    "<td>" + p.id + "</td>" +
                    "<td>" + p.name + "</td>" +
                    "<td>" + p.gender + "</td>" +
                    "<td>" + p.age + "</td>" +
                    "<td>" +
                        "<button class='btn btn-danger btn-sm' onclick='deletePatient(" + p.id + ")'>Delete</button>" +
                    "</td>" +
                    "</tr>";
            });

            $("#patientTable").html(rows);

            totalPages = response.totalPages;
            $("#pageInfo").text(`Page ${currentPage + 1} of ${totalPages}`);
            $("#prevBtn").prop("disabled", currentPage === 0);
            $("#nextBtn").prop("disabled", currentPage === totalPages - 1);
        },
        error: function(err) {
            console.error("Error loading patients", err);
        }
    });
}

// DELETE
function deletePatient(id) {
    if(confirm("Are you sure?")) {
        $.ajax({
            url: API_URL + "/" + id,
            type: "DELETE",
            success: function() {
                loadPatients();
            }
        });
    }
}

// INITIAL LOAD
$(document).ready(function() {
    loadPatients();
});


/* ================= PAGINATION ================= */
$("#nextBtn").click(() => {
    if(currentPage < totalPages - 1) {
        currentPage++;
        loadPatients();
    }
});

$("#prevBtn").click(() => {
    if(currentPage > 0) {
        currentPage--;
        loadPatients();
    }
});
</script>

</body>
</html>
