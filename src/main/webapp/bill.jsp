<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>MediCore | Billing</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="/css/medicore.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</head>

<body>

<!-- TOPBAR -->
<nav class="topbar">
    <a href="#" class="navbar-brand">
        <span class="brand-dot"></span>
        MediCore <sup style="font-size:.55rem;letter-spacing:.12em;color:var(--muted);font-family:'DM Sans',sans-serif;">HMS</sup>
    </a>
    <div class="topbar-right">
        <div class="breadcrumb-trail">
            <a href="/dashboard.jsp"><i class="bi bi-house"></i></a>
            <i class="bi bi-chevron-right" style="font-size:.6rem;"></i>
            <span>Billing</span>
        </div>
    </div>
</nav>

<div class="page-wrap">

    <!-- HEADER -->
    <div class="page-header">
        <h1>Billing Management</h1>
        <span class="count-badge">
            <span id="total">0</span> Bills
        </span>
    </div>

    <div class="two-col">

        <!-- FORM -->
        <div class="panel">
            <div class="panel-title">Create Bill</div>

            <form id="billForm">
                <select id="patientId" class="field-input" required>
                    <option value="" disabled selected>Select patient</option>
                </select>
                <input type="number" id="amount" class="field-input" placeholder="Amount" required>
                <input type="text" id="status" class="field-input" placeholder="Status (PAID / PENDING)" required>

                <button class="btn-add">Add Bill</button>
            </form>
        </div>

        <!-- TABLE -->
        <div class="table-panel">

            <!-- SEARCH -->
            <input type="text" id="search" class="search-input" placeholder="Search...">

            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Patient</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="data"></tbody>
            </table>

            <!-- PAGINATION -->
            <div class="pagination-bar">
                <button class="page-btn" id="prev">Prev</button>
                <span id="pageInfo"></span>
                <button class="page-btn" id="next">Next</button>
            </div>

        </div>
    </div>
</div>

<script>

var API = "/api/v1/bills";
var PATIENT_API = "/api/v1/patients";

var page = 0;
var totalPages = 1;
var cache = [];
var patientMap = {};

function escapeHtml(value) {
    return String(value == null ? "" : value)
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}

function formatAmount(amount) {
    var value = parseFloat(amount);
    if (isNaN(value)) value = 0;
    return "Rs. " + value.toLocaleString("en-IN", {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    });
}

/* LOAD PATIENTS */
function loadPatients() {
    return $.ajax({
        url: PATIENT_API + "?page=0&size=100",
        type: "GET",
        success: function(res) {
            var patients = (res && res.content) ? res.content : [];
            patientMap = {};
            var options = '<option value="" disabled selected>Select patient</option>';

            for (var i = 0; i < patients.length; i++) {
                var p = patients[i];
                patientMap[p.id] = p.name;
                options += '<option value="' + escapeHtml(p.id) + '">' + escapeHtml(p.name) + '</option>';
            }

            $("#patientId").html(options);
            render($("#search").val().toLowerCase());
        },
        error: function() {
            $("#patientId").html('<option value="" disabled selected>Failed to load patients</option>');
        }
    });
}

/* LOAD DATA */
function load(q) {
    q = q || "";
    $.ajax({
        url: API + "?page=" + page + "&size=5",
        type: "GET",
        success: function(res) {
            cache = (res && res.content) ? res.content : [];
            totalPages = (res && res.totalPages) ? res.totalPages : 1;

            $("#total").text((res && res.totalElements != null) ? res.totalElements : cache.length);
            $("#pageInfo").text("Page " + (page + 1) + " / " + totalPages);

            render(q);
        },
        error: function() {
            $("#data").html('<tr><td colspan="5">Failed to load bills</td></tr>');
        }
    });
}

/* RENDER */
function render(q) {
    q = q || "";
    var html = "";

    for (var i = 0; i < cache.length; i++) {
        var b = cache[i];
        var patientName = patientMap[b.patientId] || ("Patient #" + (b.patientId || "-"));
        var searchable = (patientName + " " + (b.status || "") + " " + b.id).toLowerCase();
        if (q && searchable.indexOf(q) === -1) continue;

        html +=
            '<tr>' +
                '<td>' + escapeHtml(b.id) + '</td>' +
                '<td>' + escapeHtml(patientName) + '</td>' +
                '<td>' + formatAmount(b.amount) + '</td>' +
                '<td>' + escapeHtml(b.status) + '</td>' +
                '<td>' +
                    '<button type="button" class="btn-del" data-id="' + escapeHtml(b.id) + '">X</button>' +
                '</td>' +
            '</tr>';
    }

    if (!html) {
        html = '<tr><td colspan="5">No bills found</td></tr>';
    }

    $("#data").html(html);
}

/* ADD */
$("#billForm").submit(function(e) {
    e.preventDefault();

    var selectedPatientId = Number($("#patientId").val());
    if (!selectedPatientId) {
        alert("Please select a patient.");
        return;
    }

    var obj = {
        patientId: selectedPatientId,
        amount: Number($("#amount").val()),
        status: $("#status").val().trim()
    };

    $.ajax({
        url: API,
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(obj),
        success: function() {
            $("#billForm")[0].reset();
            page = 0;
            loadPatients().always(function() {
                load();
            });
        },
        error: function() {
            alert("Unable to save the bill. Please check the server logs.");
        }
    });
});

/* DELETE */
function del(id) {
    if (confirm("Delete bill?")) {
        $.ajax({
            url: API + "/" + id,
            type: "DELETE",
            success: function() {
                load($("#search").val().toLowerCase());
            },
            error: function() {
                alert("Unable to delete the bill. Please check the server logs.");
            }
        });
    }
}

/* SEARCH */
$("#search").on("input", function() {
    render(this.value.toLowerCase());
});

/* DELETE BUTTONS */
$("#data").on("click", ".btn-del", function() {
    del($(this).data("id"));
});

/* PAGINATION */
$("#prev").click(function() {
    if (page > 0) {
        page--;
        load($("#search").val().toLowerCase());
    }
});

$("#next").click(function() {
    if (page < totalPages - 1) {
        page++;
        load($("#search").val().toLowerCase());
    }
});

/* INIT */
$(function() {
    loadPatients().always(function() {
        load();
    });
});
</script>
</body>
</html>
