<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Hospital Dashboard</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background-color: #f5f7fa;
        }
        .dashboard-card {
            transition: 0.3s;
            cursor: pointer;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
    </style>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-dark bg-primary mb-4">
    <div class="container-fluid">
        <span class="navbar-brand mb-0 h1">
            <i class="bi bi-hospital"></i> Hospital Management System
        </span>
    </div>
</nav>

<!-- CONTENT -->
<div class="container">

    <h3 class="mb-4 text-center">Dashboard</h3>

    <div class="row g-4">

        <!-- DOCTORS -->
        <div class="col-md-4">
            <div class="card dashboard-card text-center">
                <div class="card-body">
                    <i class="bi bi-person-badge fs-1 text-primary"></i>
                    <h5 class="card-title mt-3">Doctors</h5>
                    <p class="card-text">Manage doctor details</p>
                    <a href="/doctor.jsp" class="btn btn-primary">View Doctors</a>
                </div>
            </div>
        </div>

        <!-- PATIENTS -->
        <div class="col-md-4">
            <div class="card dashboard-card text-center">
                <div class="card-body">
                    <i class="bi bi-people fs-1 text-success"></i>
                    <h5 class="card-title mt-3">Patients</h5>
                    <p class="card-text">Manage patient records</p>
                    <a href="/patient.jsp" class="btn btn-success">View Patients</a>
                </div>
            </div>
        </div>

        <!-- APPOINTMENTS -->
        <div class="col-md-4">
            <div class="card dashboard-card text-center">
                <div class="card-body">
                    <i class="bi bi-calendar-check fs-1 text-warning"></i>
                    <h5 class="card-title mt-3">Appointments</h5>
                    <p class="card-text">Schedule appointments</p>
                    <a href="/appointments.jsp" class="btn btn-warning">View Appointments</a>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- FOOTER -->
<footer class="text-center mt-5 text-muted">
    <p>© 2025 Hospital Management System</p>
</footer>

</body>
</html>
