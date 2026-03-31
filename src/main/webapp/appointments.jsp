<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MediCore | Appointment Management</title>

<!-- Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Instrument+Serif:ital@0;1&family=Sora:wght@300;400;500;600&display=swap" rel="stylesheet">
<!-- Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
<!-- Shared HMS Stylesheet -->
<link rel="stylesheet" href="/css/medicore.css">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
/* ── APPOINTMENT-SPECIFIC STYLES ── */

/* Timeline list view */
.appt-list { padding: 0 1.2rem 1rem; }

.appt-item {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding: 1rem 1.1rem;
    background: var(--bg);
    border: 1px solid var(--border);
    border-radius: var(--radius);
    margin-bottom: .7rem;
    transition: transform .2s, box-shadow .2s, border-color .2s;
    animation: fadeUp .35s both;
}

.appt-item:hover {
    transform: translateY(-2px);
    box-shadow: var(--shadow-lg);
    border-color: #c7d7f5;
}

.appt-date-block {
    text-align: center;
    background: var(--accent-l);
    border-radius: 10px;
    padding: .55rem .8rem;
    min-width: 54px;
    flex-shrink: 0;
}

.appt-day {
    font-family: 'Instrument Serif', serif;
    font-size: 1.5rem;
    line-height: 1;
    color: var(--accent);
}

.appt-month {
    font-size: .62rem;
    text-transform: uppercase;
    letter-spacing: .1em;
    color: var(--accent);
    font-weight: 600;
}

.appt-info { flex: 1; min-width: 0; }

.appt-title {
    font-size: .9rem;
    font-weight: 600;
    color: var(--text);
    margin-bottom: .2rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.appt-sub {
    font-size: .75rem;
    color: var(--muted);
    display: flex;
    align-items: center;
    gap: .5rem;
    flex-wrap: wrap;
}

.appt-id {
    font-size: .68rem;
    color: var(--muted);
    flex-shrink: 0;
}

.appt-actions { flex-shrink: 0; }

/* Table view */
.appt-table-wrap { overflow-x: auto; }

/* Status badge */
.status-badge {
    display: inline-flex;
    align-items: center;
    gap: .25rem;
    font-size: .68rem;
    font-weight: 600;
    padding: .18rem .55rem;
    border-radius: 20px;
    letter-spacing: .03em;
}

.status-scheduled  { background: #dbeafe; color: #1d4ed8; }
.status-completed  { background: #d1fae5; color: #065f46; }
.status-cancelled  { background: #fee2e2; color: #b91c1c; }

/* Select dropdown enhancements */
.select-wrap { position: relative; }
.select-icon {
    position: absolute; left: .85rem; top: 50%;
    transform: translateY(-50%);
    color: var(--muted); font-size: .95rem;
    pointer-events: none; z-index: 1;
}

/* Date input */
input[type="date"].field-input {
    padding-left: 2.4rem;
    color-scheme: light;
}

/* Today button */
.btn-today {
    padding: .42rem .8rem;
    border: 1.5px solid var(--border);
    border-radius: 8px;
    background: var(--bg);
    color: var(--muted);
    font-family: 'Sora', sans-serif;
    font-size: .75rem;
    font-weight: 500;
    cursor: pointer;
    transition: all .2s;
    white-space: nowrap;
}
.btn-today:hover {
    border-color: var(--accent);
    color: var(--accent);
    background: var(--accent-l);
}
</style>
</head>

<body>

<!-- ═══ TOPBAR ═══ -->
<nav class="topbar">
    <a href="#" class="navbar-brand">
        <span class="brand-dot"></span>
        MediCore <sup style="font-size:.55rem;letter-spacing:.12em;color:var(--muted);font-family:'DM Sans',sans-serif;">HMS</sup>
    </a>
    <div class="topbar-right">
        <div class="breadcrumb-trail">
            <a href="/dashboard.jsp"><i class="bi bi-house"></i></a>
            <i class="bi bi-chevron-right" style="font-size:.6rem;"></i>
            <span>Appointments</span>
        </div>
    </div>
</nav>

<!-- ═══ PAGE ═══ -->
<div class="page-wrap">

    <!-- Header -->
    <div class="page-header">
        <div class="page-header-left">
            <h1>Manage <em>Appointments</em></h1>
            <p>Book, view, and cancel appointments between doctors and patients.</p>
        </div>
        <div class="count-badge" id="totalBadge">
            <i class="bi bi-calendar2-check-fill"></i>
            <span id="totalCount">—</span> appointments
        </div>
    </div>

    <!-- Stats -->
<div class="row g-3 mb-4">

    <!-- Total Booked -->
    <div class="col-md">
        <div class="card bg-dark text-white shadow-sm border-0 h-100">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <small class="text-secondary">Total Booked</small>
                    <i class="bi bi-calendar-check text-primary"></i>
                </div>
                <h4 class="fw-bold mt-2" id="statTotal">—</h4>
                <small class="text-secondary">all time</small>
            </div>
        </div>
    </div>

    <!-- Today -->
    <div class="col-md">
        <div class="card bg-dark text-white shadow-sm border-0 h-100">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <small class="text-secondary">Today</small>
                    <i class="bi bi-calendar-day text-success"></i>
                </div>
                <h4 class="fw-bold mt-2" id="statToday">—</h4>
                <small class="text-secondary">scheduled today</small>
            </div>
        </div>
    </div>

    <!-- This Page -->
    <div class="col-md">
        <div class="card bg-dark text-white shadow-sm border-0 h-100">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <small class="text-secondary">This Page</small>
                    <i class="bi bi-file-earmark-text text-warning"></i>
                </div>
                <h4 class="fw-bold mt-2" id="statPage">—</h4>
                <small class="text-secondary">current view</small>
            </div>
        </div>
    </div>

    <!-- Doctors Listed -->
    <div class="col-md">
        <div class="card bg-dark text-white shadow-sm border-0 h-100">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <small class="text-secondary">Doctors Listed</small>
                    <i class="bi bi-person-badge text-danger"></i>
                </div>
                <h4 class="fw-bold mt-2" id="statDoctors">—</h4>
                <small class="text-secondary">available</small>
            </div>
        </div>
    </div>

</div>
    <!-- Two-col -->
    <div class="two-col">

        <!-- BOOK FORM -->
        <div class="panel">
            <div class="panel-head">
                <span class="panel-title">Book Appointment</span>
                <i class="bi bi-calendar-plus" style="color:var(--accent);"></i>
            </div>
            <div class="panel-body">
                <form id="appointmentForm" autocomplete="off">

                    <div class="field-group">
                        <label class="field-label">Date</label>
                        <div class="field-wrap" style="display:flex;gap:.5rem;align-items:center;">
                            <div style="position:relative;flex:1;">
                                <i class="bi bi-calendar3 field-icon"></i>
                                <input type="date" id="date" class="field-input" required>
                            </div>
                            <button type="button" class="btn-today" id="todayBtn">Today</button>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Doctor</label>
                        <div class="field-wrap">
                            <i class="bi bi-person-badge field-icon"></i>
                            <select id="doctorName" class="field-input" required>
                                <option value="">Loading doctors...</option>
                            </select>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Patient</label>
                        <div class="field-wrap">
                            <i class="bi bi-person field-icon"></i>
                            <select id="patientName" class="field-input" required>
                                <option value="">Loading patients...</option>
                            </select>
                        </div>
                    </div>

                    <!-- Summary preview -->
                    <div id="bookingSummary" style="display:none; background:var(--accent-l); border-radius:10px; padding:.85rem 1rem; margin-bottom:1rem; font-size:.8rem; color:var(--accent);">
                        <i class="bi bi-info-circle"></i>
                        <span id="summaryText"></span>
                    </div>

                    <button type="submit" class="btn-add" id="addBtn">
                        <i class="bi bi-calendar-check-fill"></i>
                        Book Appointment
                    </button>
                </form>
            </div>
        </div>

        <!-- APPOINTMENTS LIST -->
        <div class="table-panel">
            <div class="table-head-bar">
                <span class="panel-title">Appointment Directory</span>

                <div style="display:flex;align-items:center;gap:.7rem;flex-wrap:wrap;">
                    <div class="search-wrap">
                        <i class="bi bi-search search-icon"></i>
                        <input type="text" id="searchInput" class="search-input" placeholder="Search doctor or patient…">
                    </div>
                    <div class="view-toggle">
                        <button class="view-btn active" id="listViewBtn" title="Timeline view"><i class="bi bi-card-list"></i></button>
                        <button class="view-btn" id="tableViewBtn" title="Table view"><i class="bi bi-table"></i></button>
                    </div>
                </div>
            </div>

            <!-- TIMELINE VIEW (default) -->
            <div id="timelineView">
                <div class="appt-list" id="apptList">
                    <!-- skeleton -->
                    <div class="skel-row"><div class="skeleton" style="width:54px;height:52px;border-radius:10px;flex-shrink:0;"></div><div style="flex:1;"><div class="skeleton" style="height:14px;width:60%;margin-bottom:6px;"></div><div class="skeleton" style="height:11px;width:40%;"></div></div></div>
                    <div class="skel-row"><div class="skeleton" style="width:54px;height:52px;border-radius:10px;flex-shrink:0;"></div><div style="flex:1;"><div class="skeleton" style="height:14px;width:55%;margin-bottom:6px;"></div><div class="skeleton" style="height:11px;width:35%;"></div></div></div>
                    <div class="skel-row"><div class="skeleton" style="width:54px;height:52px;border-radius:10px;flex-shrink:0;"></div><div style="flex:1;"><div class="skeleton" style="height:14px;width:65%;margin-bottom:6px;"></div><div class="skeleton" style="height:11px;width:45%;"></div></div></div>
                </div>
            </div>

            <!-- TABLE VIEW (hidden by default) -->
            <div id="tableView" style="display:none; overflow-x:auto;">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Date</th>
                            <th>Doctor</th>
                            <th>Patient</th>
                            <th style="text-align:right;">Action</th>
                        </tr>
                    </thead>
                    <tbody id="apptTableBody"></tbody>
                </table>
            </div>

            <!-- EMPTY STATE -->
            <div class="empty-state" id="emptyState" style="display:none;">
                <i class="bi bi-calendar-x"></i>
                <p>No appointments found. Book one using the form.</p>
            </div>

            <!-- PAGINATION -->
            <div class="pagination-bar">
                <span class="page-info" id="pageInfo">—</span>
                <div class="page-btns">
                    <button class="page-btn" id="prevBtn" disabled>
                        <i class="bi bi-chevron-left"></i> Previous
                    </button>
                    <button class="page-btn" id="nextBtn" disabled>
                        Next <i class="bi bi-chevron-right"></i>
                    </button>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- ═══ CONFIRM MODAL ═══ -->
<div class="modal-overlay" id="confirmModal">
    <div class="modal-box">
        <div class="modal-icon"><i class="bi bi-calendar-x-fill"></i></div>
        <p class="modal-title">Cancel Appointment?</p>
        <p class="modal-sub">This will permanently remove the appointment record.</p>
        <div class="modal-actions">
            <button class="btn-cancel" id="modalCancel">Keep It</button>
            <button class="btn-confirm-del" id="modalConfirm">Yes, Cancel</button>
        </div>
    </div>
</div>

<!-- ═══ TOAST ═══ -->
<div class="toast-wrap" id="toastWrap"></div>


<script>
/*
 * JSP RULE: No template literals (backtick strings), no arrow functions,
 * no const/let — all cause issues with JSP EL or older Tomcat/JVM setups.
 * Use var, function(){}, and string concatenation throughout.
 */

var API_APPOINTMENTS = "/api/v1/appointments";
var API_DOCTORS      = "/api/v1/doctors/names";
var API_PATIENTS     = "/api/v1/patients/names";

var currentPage  = 0;
var pageSize     = 5;
var totalPages   = 0;
var allAppts     = [];
var deleteTarget = null;
var isTimeline   = true;
var todayStr     = "";

/* ─── INIT TODAY DATE ─── */
(function() {
    var now = new Date();
    var y   = now.getFullYear();
    var m   = String(now.getMonth() + 1).padStart(2, '0');
    var d   = String(now.getDate()).padStart(2, '0');
    todayStr = y + '-' + m + '-' + d;
    document.getElementById('date').value = todayStr;
})();

document.getElementById('todayBtn').onclick = function() {
    document.getElementById('date').value = todayStr;
};

/* ─── TOAST ─── */
function toast(msg, type) {
    type = type || 'success';
    var t = document.createElement('div');
    t.className = 'toast-msg ' + type;
    var icon = (type === 'success') ? 'check-circle-fill' : 'x-circle-fill';
    t.innerHTML = '<i class="bi bi-' + icon + '"></i>' + msg;
    document.getElementById('toastWrap').appendChild(t);
    setTimeout(function() { t.remove(); }, 3200);
}

/* ─── HELPERS ─── */
function padId(id) {
    var s = '' + id;
    while (s.length < 4) s = '0' + s;
    return s;
}

function formatDate(dateStr) {
    /* dateStr expected as "YYYY-MM-DD" */
    if (!dateStr) return { day: '—', month: '—', full: '—' };
    var parts = dateStr.split('-');
    if (parts.length < 3) return { day: dateStr, month: '', full: dateStr };
    var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    var mIdx = parseInt(parts[1], 10) - 1;
    return {
        day:   parts[2],
        month: months[mIdx] || parts[1],
        full:  parts[2] + ' ' + (months[mIdx] || parts[1]) + ' ' + parts[0]
    };
}

function showEmpty(show) {
    document.getElementById('emptyState').style.display = show ? 'block' : 'none';
}

/* ─── BOOKING PREVIEW ─── */
function updatePreview() {
    var date    = document.getElementById('date').value;
    var doctor  = document.getElementById('doctorName').value;
    var patient = document.getElementById('patientName').value;
    var summary = document.getElementById('bookingSummary');
    var txt     = document.getElementById('summaryText');

    if (date && doctor && patient) {
        var d = formatDate(date);
        txt.textContent = patient + ' with ' + doctor + ' on ' + d.full;
        summary.style.display = 'block';
    } else {
        summary.style.display = 'none';
    }
}

document.getElementById('date').addEventListener('change', updatePreview);
document.getElementById('doctorName').addEventListener('change', updatePreview);
document.getElementById('patientName').addEventListener('change', updatePreview);

/* ─── LOAD DOCTORS INTO SELECT ─── */
/*
 * BUG FIX: The original code assumed /doctors/names returned plain strings.
 * Your DoctorController's /names endpoint returns List<String> (just names),
 * so we handle it as strings. If your backend returns objects like {id, name},
 * change item to item.name below.
 */
function loadDoctors() {
    $.ajax({
        url: API_DOCTORS,
        type: 'GET',
        success: function(data) {
            var html = '<option value="">Select Doctor</option>';
            for (var i = 0; i < data.length; i++) {
                /* data[i] is a plain String from getDoctorNames() */
                var name = data[i];
                html += '<option value="' + name + '">' + name + '</option>';
            }
            document.getElementById('doctorName').innerHTML = html;
            document.getElementById('statDoctors').textContent = data.length;
        },
        error: function() {
            document.getElementById('doctorName').innerHTML =
                '<option value="">Failed to load doctors</option>';
            toast('Could not load doctor list.', 'error');
        }
    });
}

/* ─── LOAD PATIENTS INTO SELECT ─── */
function loadPatients() {
    $.ajax({
        url: API_PATIENTS,
        type: 'GET',
        success: function(data) {
            var html = '<option value="">Select Patient</option>';
            for (var i = 0; i < data.length; i++) {
                var name = data[i];
                html += '<option value="' + name + '">' + name + '</option>';
            }
            document.getElementById('patientName').innerHTML = html;
        },
        error: function() {
            document.getElementById('patientName').innerHTML =
                '<option value="">Failed to load patients</option>';
            toast('Could not load patient list.', 'error');
        }
    });
}

/* ─── RENDER TIMELINE ─── */
function renderTimeline(appts) {
    var container = document.getElementById('apptList');
    if (!appts.length) { showEmpty(true); container.innerHTML = ''; return; }
    showEmpty(false);

    var html = '';
    for (var i = 0; i < appts.length; i++) {
        var a = appts[i];
        var d = formatDate(a.date);
        var isToday = (a.date === todayStr);
        html +=
            '<div class="appt-item" style="animation-delay:' + (i * 0.06) + 's">' +
                '<div class="appt-date-block">' +
                    '<div class="appt-day">' + d.day + '</div>' +
                    '<div class="appt-month">' + d.month + '</div>' +
                '</div>' +
                '<div class="appt-info">' +
                    '<div class="appt-title">' +
                        '<i class="bi bi-person-badge" style="color:var(--accent);font-size:.8rem;"></i> ' + a.doctorName +
                    '</div>' +
                    '<div class="appt-sub">' +
                        '<i class="bi bi-person" style="font-size:.75rem;"></i> ' + a.patientName +
                        (isToday ? ' &nbsp;<span class="status-badge status-scheduled"><i class="bi bi-dot"></i>Today</span>' : '') +
                    '</div>' +
                '</div>' +
                '<div class="appt-id">#' + padId(a.id) + '</div>' +
                '<div class="appt-actions">' +
                    '<button class="btn-del" data-id="' + a.id + '">' +
                        '<i class="bi bi-trash3"></i>' +
                    '</button>' +
                '</div>' +
            '</div>';
    }
    container.innerHTML = html;

    container.querySelectorAll('.btn-del').forEach(function(btn) {
        btn.addEventListener('click', function() {
            confirmDelete(this.getAttribute('data-id'));
        });
    });
}

/* ─── RENDER TABLE ─── */
function renderTable(appts) {
    var tbody = document.getElementById('apptTableBody');
    if (!appts.length) { showEmpty(true); tbody.innerHTML = ''; return; }
    showEmpty(false);

    var html = '';
    for (var i = 0; i < appts.length; i++) {
        var a = appts[i];
        var d = formatDate(a.date);
        html +=
            '<tr>' +
                '<td style="color:var(--muted);font-size:.75rem;">#' + padId(a.id) + '</td>' +
                '<td><strong>' + d.full + '</strong></td>' +
                '<td>' +
                    '<div style="display:flex;align-items:center;gap:.5rem;">' +
                        '<i class="bi bi-person-badge" style="color:var(--accent);"></i>' + a.doctorName +
                    '</div>' +
                '</td>' +
                '<td>' +
                    '<div style="display:flex;align-items:center;gap:.5rem;">' +
                        '<i class="bi bi-person" style="color:var(--success);"></i>' + a.patientName +
                    '</div>' +
                '</td>' +
                '<td style="text-align:right;">' +
                    '<button class="btn-del" data-id="' + a.id + '">' +
                        '<i class="bi bi-trash3"></i> Cancel' +
                    '</button>' +
                '</td>' +
            '</tr>';
    }
    tbody.innerHTML = html;

    tbody.querySelectorAll('.btn-del').forEach(function(btn) {
        btn.addEventListener('click', function() {
            confirmDelete(this.getAttribute('data-id'));
        });
    });
}

/* ─── LOAD APPOINTMENTS ─── */
function loadAppointments(searchTerm) {
    searchTerm = searchTerm || '';
    $.ajax({
        url: API_APPOINTMENTS,
        type: 'GET',
        data: { page: currentPage, size: pageSize },
        success: function(response) {
            allAppts   = response.content || [];
            totalPages = response.totalPages || 1;

            var filtered = searchTerm
                ? allAppts.filter(function(a) {
                    var q = searchTerm.toLowerCase();
                    return (a.doctorName  || '').toLowerCase().indexOf(q) !== -1 ||
                           (a.patientName || '').toLowerCase().indexOf(q) !== -1;
                  })
                : allAppts;

            if (isTimeline) renderTimeline(filtered);
            else            renderTable(filtered);

            /* Stats */
            var total = response.totalElements || allAppts.length;
            document.getElementById('statTotal').textContent = total;
            document.getElementById('totalCount').textContent = total;
            document.getElementById('statPage').textContent  = allAppts.length;

            var todayCount = allAppts.filter(function(a) { return a.date === todayStr; }).length;
            document.getElementById('statToday').textContent = todayCount;

            /* Pagination */
            document.getElementById('pageInfo').textContent =
                'Page ' + (currentPage + 1) + ' of ' + totalPages + '  \u00b7  ' + total + ' total';
            document.getElementById('prevBtn').disabled = currentPage === 0;
            document.getElementById('nextBtn').disabled = currentPage >= totalPages - 1;
        },
        error: function() { toast('Failed to load appointments.', 'error'); }
    });
}

/* ─── BOOK APPOINTMENT ─── */
$('#appointmentForm').submit(function(e) {
    e.preventDefault();

    var btn = document.getElementById('addBtn');

    /* Client-side validation */
    var doctor  = document.getElementById('doctorName').value;
    var patient = document.getElementById('patientName').value;
    var date    = document.getElementById('date').value;

    if (!doctor) { toast('Please select a doctor.', 'error'); return; }
    if (!patient) { toast('Please select a patient.', 'error'); return; }
    if (!date)    { toast('Please pick a date.', 'error'); return; }

    btn.disabled = true;
    btn.innerHTML = '<i class="bi bi-hourglass-split"></i> Booking...';

    var apptData = {
        date:        date,
        doctorName:  doctor,
        patientName: patient
    };

    $.ajax({
        url: API_APPOINTMENTS,
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(apptData),
        success: function() {
            document.getElementById('appointmentForm').reset();
            document.getElementById('date').value = todayStr;
            document.getElementById('bookingSummary').style.display = 'none';
            currentPage = 0;
            loadAppointments();
            toast('Appointment booked!');
        },
        error: function() { toast('Failed to book appointment.', 'error'); },
        complete: function() {
            btn.disabled = false;
            btn.innerHTML = '<i class="bi bi-calendar-check-fill"></i> Book Appointment';
        }
    });
});

/* ─── DELETE FLOW ─── */
function confirmDelete(id) {
    deleteTarget = id;
    document.getElementById('confirmModal').classList.add('open');
}

document.getElementById('modalCancel').onclick = function() {
    document.getElementById('confirmModal').classList.remove('open');
    deleteTarget = null;
};

document.getElementById('modalConfirm').onclick = function() {
    if (!deleteTarget) return;
    var id = deleteTarget;
    document.getElementById('confirmModal').classList.remove('open');

    $.ajax({
        url: API_APPOINTMENTS + '/' + id,
        type: 'DELETE',
        success: function() {
            toast('Appointment cancelled.');
            /* Go to previous page if current page becomes empty */
            if (allAppts.length === 1 && currentPage > 0) currentPage--;
            loadAppointments();
        },
        error: function() { toast('Delete failed.', 'error'); }
    });
    deleteTarget = null;
};

document.getElementById('confirmModal').onclick = function(e) {
    if (e.target === this) { this.classList.remove('open'); deleteTarget = null; }
};

/* ─── VIEW TOGGLE ─── */
document.getElementById('listViewBtn').onclick = function() {
    isTimeline = true;
    this.classList.add('active');
    document.getElementById('tableViewBtn').classList.remove('active');
    document.getElementById('timelineView').style.display = 'block';
    document.getElementById('tableView').style.display = 'none';
    loadAppointments($('#searchInput').val());
};

document.getElementById('tableViewBtn').onclick = function() {
    isTimeline = false;
    this.classList.add('active');
    document.getElementById('listViewBtn').classList.remove('active');
    document.getElementById('timelineView').style.display = 'none';
    document.getElementById('tableView').style.display = 'block';
    loadAppointments($('#searchInput').val());
};

/* ─── SEARCH ─── */
var searchTimer;
document.getElementById('searchInput').addEventListener('input', function() {
    clearTimeout(searchTimer);
    var val = this.value.trim();
    searchTimer = setTimeout(function() { loadAppointments(val); }, 280);
});

/* ─── PAGINATION ─── */
document.getElementById('prevBtn').onclick = function() {
    if (currentPage > 0) { currentPage--; loadAppointments(); }
};
document.getElementById('nextBtn').onclick = function() {
    if (currentPage < totalPages - 1) { currentPage++; loadAppointments(); }
};

/* ─── INIT ─── */
$(document).ready(function() {
    loadDoctors();
    loadPatients();
    loadAppointments();
});
</script>

</body>
</html>
