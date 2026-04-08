<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MediCore | Export Reports</title>

<link href="https://fonts.googleapis.com/css2?family=Instrument+Serif:ital@0;1&family=Sora:wght@300;400;500;600&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="/css/medicore.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
/* ── REPORTS PAGE STYLES (dark theme) ── */

.report-section {
    background: rgba(255,255,255,.03);
    border: 1px solid var(--border);
    border-radius: 12px;
    margin-bottom: 1.5rem;
    overflow: hidden;
    animation: fadeUp .4s both;
}

.report-section-head {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: .9rem 1.2rem;
    border-bottom: 1px solid var(--border);
    cursor: pointer;
    user-select: none;
}

.report-section-head:hover { background: rgba(255,255,255,.02); }

.report-section-title {
    display: flex; align-items: center; gap: .6rem;
    font-family: 'Instrument Serif', serif;
    font-size: 1rem; color: var(--text);
}

.section-icon {
    width: 32px; height: 32px;
    border-radius: 8px;
    display: flex; align-items: center; justify-content: center;
    font-size: .85rem;
}

.section-count {
    font-size: .72rem; font-weight: 600;
    padding: .15rem .55rem; border-radius: 20px;
    background: rgba(0,212,255,.1); color: var(--accent);
    border: 1px solid rgba(0,212,255,.2);
}

.report-body { padding: 1rem 1.2rem; }

.report-table {
    width: 100%; border-collapse: collapse;
    font-size: .8rem;
}

.report-table th {
    font-size: .65rem; text-transform: uppercase; letter-spacing: .1em;
    color: var(--muted); font-weight: 600;
    padding: .5rem .7rem;
    border-bottom: 1px solid var(--border);
    text-align: left;
}

.report-table td {
    padding: .6rem .7rem;
    border-bottom: 1px solid rgba(255,255,255,.04);
    color: var(--text);
    vertical-align: middle;
}

.report-table tr:last-child td { border-bottom: none; }
.report-table tr:hover td { background: rgba(255,255,255,.02); }

/* Summary cards */
.summary-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
    gap: 1rem;
    margin-bottom: 2rem;
}

.summary-card {
    background: rgba(255,255,255,.03);
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 1rem 1.1rem;
    animation: fadeUp .4s both;
}

.summary-card-icon {
    font-size: 1.4rem;
    margin-bottom: .4rem;
}

.summary-card-val {
    font-family: 'Instrument Serif', serif;
    font-size: 1.8rem; color: var(--text); line-height: 1;
    margin-bottom: .2rem;
}

.summary-card-label {
    font-size: .7rem; color: var(--muted);
    text-transform: uppercase; letter-spacing: .08em;
}

/* Export buttons */
.export-bar {
    display: flex; align-items: center; justify-content: space-between;
    flex-wrap: wrap; gap: .7rem;
    margin-bottom: 1.5rem;
    animation: fadeUp .35s both;
}

.export-bar-title {
    font-family: 'Instrument Serif', serif;
    font-size: 1.05rem; color: var(--text);
}

.export-btns { display: flex; gap: .5rem; flex-wrap: wrap; }

.btn-export {
    display: inline-flex; align-items: center; gap: .4rem;
    padding: .5rem 1rem;
    border-radius: 8px;
    border: 1px solid var(--border);
    background: rgba(255,255,255,.04);
    color: var(--text);
    font-family: 'Sora', sans-serif;
    font-size: .78rem; font-weight: 500;
    cursor: pointer;
    transition: all .2s;
}

.btn-export:hover { border-color: var(--accent); color: var(--accent); background: rgba(0,212,255,.06); }

.btn-export.primary {
    background: var(--accent); color: #000;
    border-color: var(--accent); font-weight: 700;
}

.btn-export.primary:hover { opacity: .85; }

/* Collapse arrow */
.collapse-arrow { transition: transform .25s; }
.collapsed .collapse-arrow { transform: rotate(-90deg); }

/* Loading spinner */
.loading-row td { text-align: center; padding: 1.5rem; color: var(--muted); font-size: .82rem; }

/* print styles */
@media print {
    .topbar, .export-bar, .btn-export, .report-section-head { display: none !important; }
    body { background: #fff !important; color: #000 !important; }
    .report-section { border: 1px solid #ddd !important; background: #fff !important; }
    .report-table th, .report-table td { color: #000 !important; border-color: #ddd !important; }
    .summary-card { background: #f9f9f9 !important; border-color: #ddd !important; }
    .summary-card-val, .summary-card-label { color: #000 !important; }
    .page-wrap { padding: 0 !important; }
}
</style>
</head>
<body>

<!-- ═══ TOPBAR ═══ -->
<nav class="topbar">
    <a href="/dashboard.jsp" class="navbar-brand">
        <span class="brand-dot"></span>
        MediCore <sup style="font-size:.55rem;letter-spacing:.12em;color:var(--muted);font-family:'Sora',sans-serif;">HMS</sup>
    </a>
    <div class="topbar-right">
        <div class="breadcrumb-trail">
            <a href="/dashboard.jsp"><i class="bi bi-house"></i></a>
            <i class="bi bi-chevron-right" style="font-size:.6rem;"></i>
            <span>Export Reports</span>
        </div>
    </div>
</nav>

<div class="page-wrap">

    <!-- Header -->
    <div class="page-header">
        <div class="page-header-left">
            <h1>Export <em>Reports</em></h1>
            <p style="font-size:.82rem;color:var(--muted);">Full system summary — doctors, patients, appointments, lab reports, medicines and billing.</p>
        </div>
        <div style="font-size:.72rem;color:var(--muted);text-align:right;">
            <i class="bi bi-clock"></i> Generated: <span id="genTime">-</span>
        </div>
    </div>

    <!-- Summary Overview -->
    <div class="summary-grid" id="summaryGrid">
        <div class="summary-card">
            <div class="summary-card-icon" style="color:#00d4ff;">&#x1F9D1;&#x200D;&#x2695;&#xFE0F;</div>
            <div class="summary-card-val" id="sumDoctors">-</div>
            <div class="summary-card-label">Doctors</div>
        </div>
        <div class="summary-card">
            <div class="summary-card-icon" style="color:#10b981;">&#x1F9D1;</div>
            <div class="summary-card-val" id="sumPatients">-</div>
            <div class="summary-card-label">Patients</div>
        </div>
        <div class="summary-card">
            <div class="summary-card-icon" style="color:#f59e0b;">&#x1F4C5;</div>
            <div class="summary-card-val" id="sumAppointments">-</div>
            <div class="summary-card-label">Appointments</div>
        </div>
        <div class="summary-card">
            <div class="summary-card-icon" style="color:#7c3aed;">&#x1F9EA;</div>
            <div class="summary-card-val" id="sumLab">-</div>
            <div class="summary-card-label">Lab Reports</div>
        </div>
        <div class="summary-card">
            <div class="summary-card-icon" style="color:#ec4899;">&#x1F48A;</div>
            <div class="summary-card-val" id="sumMedicines">-</div>
            <div class="summary-card-label">Medicines</div>
        </div>
        <div class="summary-card">
            <div class="summary-card-icon" style="color:#10b981;">&#x1F4B0;</div>
            <div class="summary-card-val" id="sumRevenue">-</div>
            <div class="summary-card-label">Revenue (Paid)</div>
        </div>
    </div>

    <!-- Export/Print Bar -->
    <div class="export-bar">
        <span class="export-bar-title">Detailed Report</span>
        <div class="export-btns">
            <button class="btn-export" id="csvBtn"><i class="bi bi-filetype-csv"></i> Export CSV</button>
            <button class="btn-export primary" id="printBtn"><i class="bi bi-printer-fill"></i> Print Report</button>
        </div>
    </div>

    <!-- ── DOCTORS ── -->
    <div class="report-section" id="secDoctors">
        <div class="report-section-head" onclick="toggleSection('doctorBody', this)">
            <div class="report-section-title">
                <div class="section-icon" style="background:rgba(0,212,255,.1);color:var(--accent);"><i class="bi bi-person-badge"></i></div>
                Doctors
                <span class="section-count" id="cntDoctors">-</span>
            </div>
            <i class="bi bi-chevron-down collapse-arrow"></i>
        </div>
        <div class="report-body" id="doctorBody">
            <table class="report-table">
                <thead><tr><th>ID</th><th>Name</th><th>Speciality</th></tr></thead>
                <tbody id="doctorRows"><tr class="loading-row"><td colspan="3"><i class="bi bi-hourglass-split"></i> Loading...</td></tr></tbody>
            </table>
        </div>
    </div>

    <!-- ── PATIENTS ── -->
    <div class="report-section" id="secPatients">
        <div class="report-section-head" onclick="toggleSection('patientBody', this)">
            <div class="report-section-title">
                <div class="section-icon" style="background:rgba(16,185,129,.1);color:#6ee7b7;"><i class="bi bi-people"></i></div>
                Patients
                <span class="section-count" id="cntPatients">-</span>
            </div>
            <i class="bi bi-chevron-down collapse-arrow"></i>
        </div>
        <div class="report-body" id="patientBody">
            <table class="report-table">
                <thead><tr><th>ID</th><th>Name</th><th>Gender</th><th>Age</th></tr></thead>
                <tbody id="patientRows"><tr class="loading-row"><td colspan="4"><i class="bi bi-hourglass-split"></i> Loading...</td></tr></tbody>
            </table>
        </div>
    </div>

    <!-- ── APPOINTMENTS ── -->
    <div class="report-section" id="secAppointments">
        <div class="report-section-head" onclick="toggleSection('apptBody', this)">
            <div class="report-section-title">
                <div class="section-icon" style="background:rgba(245,158,11,.1);color:#fcd34d;"><i class="bi bi-calendar-check"></i></div>
                Appointments
                <span class="section-count" id="cntAppointments">-</span>
            </div>
            <i class="bi bi-chevron-down collapse-arrow"></i>
        </div>
        <div class="report-body" id="apptBody">
            <table class="report-table">
                <thead><tr><th>ID</th><th>Date</th><th>Doctor</th><th>Patient</th></tr></thead>
                <tbody id="apptRows"><tr class="loading-row"><td colspan="4"><i class="bi bi-hourglass-split"></i> Loading...</td></tr></tbody>
            </table>
        </div>
    </div>

    <!-- ── LAB REPORTS ── -->
    <div class="report-section" id="secLab">
        <div class="report-section-head" onclick="toggleSection('labBody', this)">
            <div class="report-section-title">
                <div class="section-icon" style="background:rgba(124,58,237,.1);color:#c4b5fd;"><i class="bi bi-clipboard2-pulse"></i></div>
                Lab Reports
                <span class="section-count" id="cntLab">-</span>
            </div>
            <i class="bi bi-chevron-down collapse-arrow"></i>
        </div>
        <div class="report-body" id="labBody">
            <table class="report-table">
                <thead><tr><th>ID</th><th>Patient</th><th>Test</th><th>Date</th><th>Status</th><th>Result</th></tr></thead>
                <tbody id="labRows"><tr class="loading-row"><td colspan="6"><i class="bi bi-hourglass-split"></i> Loading...</td></tr></tbody>
            </table>
        </div>
    </div>

    <!-- ── MEDICINES ── -->
    <div class="report-section" id="secMedicines">
        <div class="report-section-head" onclick="toggleSection('medBody', this)">
            <div class="report-section-title">
                <div class="section-icon" style="background:rgba(236,72,153,.1);color:#f9a8d4;"><i class="bi bi-capsule-pill"></i></div>
                Medicine Inventory
                <span class="section-count" id="cntMedicines">-</span>
            </div>
            <i class="bi bi-chevron-down collapse-arrow"></i>
        </div>
        <div class="report-body" id="medBody">
            <table class="report-table">
                <thead><tr><th>ID</th><th>Name</th><th>Category</th><th>Qty</th><th>Price</th><th>Expiry</th></tr></thead>
                <tbody id="medRows"><tr class="loading-row"><td colspan="6"><i class="bi bi-hourglass-split"></i> Loading...</td></tr></tbody>
            </table>
        </div>
    </div>

    <!-- ── INVOICES ── -->
    <div class="report-section" id="secInvoices">
        <div class="report-section-head" onclick="toggleSection('invBody', this)">
            <div class="report-section-title">
                <div class="section-icon" style="background:rgba(16,185,129,.1);color:#6ee7b7;"><i class="bi bi-receipt-cutoff"></i></div>
                Billing / Invoices
                <span class="section-count" id="cntInvoices">-</span>
            </div>
            <i class="bi bi-chevron-down collapse-arrow"></i>
        </div>
        <div class="report-body" id="invBody">
            <table class="report-table">
                <thead><tr><th>ID</th><th>Patient</th><th>Description</th><th>Amount</th><th>Date</th><th>Status</th></tr></thead>
                <tbody id="invRows"><tr class="loading-row"><td colspan="6"><i class="bi bi-hourglass-split"></i> Loading...</td></tr></tbody>
            </table>
        </div>
    </div>

</div>

<div class="toast-wrap" id="toastWrap"></div>

<script>
/*
 * JSP RULE: No template literals, no arrow functions, no const/let.
 * This page calls all existing APIs with size=500 to get full data for export.
 */

var BIG = 500; /* fetch all records for report */

/* ─── TOAST ─── */
function toast(msg, type) {
    type = type || 'success';
    var t = document.createElement('div');
    t.className = 'toast-msg ' + type;
    t.innerHTML = '<i class="bi bi-' + (type === 'success' ? 'check-circle-fill' : 'x-circle-fill') + '"></i>' + msg;
    document.getElementById('toastWrap').appendChild(t);
    setTimeout(function() { t.remove(); }, 3000);
}

/* ─── HELPERS ─── */
function padId(id) {
    var s = '' + id;
    while (s.length < 4) s = '0' + s;
    return s;
}

function fmtDate(dateStr) {
    if (!dateStr) return '-';
    var parts = dateStr.split('-');
    if (parts.length < 3) return dateStr;
    var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return parts[2] + ' ' + (months[parseInt(parts[1],10)-1] || parts[1]) + ' ' + parts[0];
}

function getName(obj) {
    if (obj && obj.name) return obj.name;
    return '-';
}

function getDoctorName(a) {
    if (a.doctor  && a.doctor.name)  return a.doctor.name;
    if (a.doctorName)                return a.doctorName;
    return '-';
}

function getPatientName(a) {
    if (a.patient  && a.patient.name) return a.patient.name;
    if (a.patientName)                return a.patientName;
    return '-';
}

/* ─── COLLAPSE TOGGLE ─── */
function toggleSection(bodyId, headEl) {
    var body = document.getElementById(bodyId);
    if (body.style.display === 'none') {
        body.style.display = 'block';
        headEl.classList.remove('collapsed');
    } else {
        body.style.display = 'none';
        headEl.classList.add('collapsed');
    }
}

/* ─── SET GENERATION TIME ─── */
(function() {
    var now = new Date();
    document.getElementById('genTime').textContent = now.toLocaleString('en-IN');
})();

/* ─── STORED DATA FOR CSV ─── */
var csvData = {
    doctors: [], patients: [], appointments: [], lab: [], medicines: [], invoices: []
};

/* ─── LOAD DOCTORS ─── */
function loadDoctors() {
    $.ajax({
        url: '/api/v1/doctors?page=0&size=' + BIG,
        type: 'GET',
        success: function(response) {
            var data = response.content || [];
            csvData.doctors = data;
            document.getElementById('cntDoctors').textContent = data.length;
            document.getElementById('sumDoctors').textContent = data.length;

            var html = '';
            for (var i = 0; i < data.length; i++) {
                var d = data[i];
                html += '<tr><td style="color:var(--muted);">#' + padId(d.id) + '</td><td>' + d.name + '</td><td>' + (d.speciality||'-') + '</td></tr>';
            }
            document.getElementById('doctorRows').innerHTML = html || '<tr><td colspan="3" style="color:var(--muted);text-align:center;">No data</td></tr>';
        }
    });
}

/* ─── LOAD PATIENTS ─── */
function loadPatients() {
    $.ajax({
        url: '/api/v1/patients?page=0&size=' + BIG,
        type: 'GET',
        success: function(response) {
            var data = response.content || [];
            csvData.patients = data;
            document.getElementById('cntPatients').textContent = data.length;
            document.getElementById('sumPatients').textContent = data.length;

            var html = '';
            for (var i = 0; i < data.length; i++) {
                var p = data[i];
                html += '<tr><td style="color:var(--muted);">#' + padId(p.id) + '</td><td>' + p.name + '</td><td>' + (p.gender||'-') + '</td><td>' + (p.age||'-') + '</td></tr>';
            }
            document.getElementById('patientRows').innerHTML = html || '<tr><td colspan="4" style="color:var(--muted);text-align:center;">No data</td></tr>';
        }
    });
}

/* ─── LOAD APPOINTMENTS ─── */
function loadAppointments() {
    $.ajax({
        url: '/api/v1/appointments?page=0&size=' + BIG,
        type: 'GET',
        success: function(response) {
            var data = response.content || [];
            csvData.appointments = data;
            document.getElementById('cntAppointments').textContent = data.length;
            document.getElementById('sumAppointments').textContent = data.length;

            var html = '';
            for (var i = 0; i < data.length; i++) {
                var a = data[i];
                html += '<tr><td style="color:var(--muted);">#' + padId(a.id) + '</td><td>' + fmtDate(a.date) + '</td><td>' + getDoctorName(a) + '</td><td>' + getPatientName(a) + '</td></tr>';
            }
            document.getElementById('apptRows').innerHTML = html || '<tr><td colspan="4" style="color:var(--muted);text-align:center;">No data</td></tr>';
        }
    });
}

/* ─── LOAD LAB REPORTS ─── */
function loadLabReports() {
    $.ajax({
        url: '/api/v1/lab-reports?page=0&size=' + BIG,
        type: 'GET',
        success: function(response) {
            var data = response.content || [];
            csvData.lab = data;
            document.getElementById('cntLab').textContent = data.length;
            document.getElementById('sumLab').textContent = data.length;

            var html = '';
            for (var i = 0; i < data.length; i++) {
                var r = data[i];
                html += '<tr><td style="color:var(--muted);">#' + padId(r.id) + '</td><td>' + getPatientName(r) + '</td><td>' + r.testName + '</td><td>' + fmtDate(r.reportDate) + '</td><td>' + (r.status||'-') + '</td><td>' + (r.result||'-') + '</td></tr>';
            }
            document.getElementById('labRows').innerHTML = html || '<tr><td colspan="6" style="color:var(--muted);text-align:center;">No data</td></tr>';
        }
    });
}

/* ─── LOAD MEDICINES ─── */
function loadMedicines() {
    $.ajax({
        url: '/api/v1/medicines?page=0&size=' + BIG,
        type: 'GET',
        success: function(response) {
            var data = response.content || [];
            csvData.medicines = data;
            document.getElementById('cntMedicines').textContent = data.length;
            document.getElementById('sumMedicines').textContent = data.length;

            var html = '';
            for (var i = 0; i < data.length; i++) {
                var m = data[i];
                html += '<tr><td style="color:var(--muted);">#' + padId(m.id) + '</td><td>' + m.name + '</td><td>' + (m.category||'-') + '</td><td>' + m.quantity + '</td><td>Rs.' + parseFloat(m.price).toFixed(2) + '</td><td>' + fmtDate(m.expiryDate) + '</td></tr>';
            }
            document.getElementById('medRows').innerHTML = html || '<tr><td colspan="6" style="color:var(--muted);text-align:center;">No data</td></tr>';
        }
    });
}

/* ─── LOAD INVOICES ─── */
function loadInvoices() {
    $.ajax({
        url: '/api/v1/invoices?page=0&size=' + BIG,
        type: 'GET',
        success: function(response) {
            var data = response.content || [];
            csvData.invoices = data;
            document.getElementById('cntInvoices').textContent = data.length;

            var revenue = 0;
            for (var i = 0; i < data.length; i++) {
                if ((data[i].status || '').toLowerCase() === 'paid') {
                    revenue += parseFloat(data[i].amount) || 0;
                }
            }
            document.getElementById('sumRevenue').textContent =
                'Rs.' + revenue.toLocaleString('en-IN', { maximumFractionDigits: 0 });

            var html = '';
            for (var i = 0; i < data.length; i++) {
                var inv = data[i];
                html += '<tr><td style="color:var(--muted);">#' + padId(inv.id) + '</td><td>' + getPatientName(inv) + '</td><td>' + inv.description + '</td><td>Rs.' + parseFloat(inv.amount).toFixed(2) + '</td><td>' + fmtDate(inv.invoiceDate) + '</td><td>' + (inv.status||'-') + '</td></tr>';
            }
            document.getElementById('invRows').innerHTML = html || '<tr><td colspan="6" style="color:var(--muted);text-align:center;">No data</td></tr>';
        }
    });
}

/* ─── PRINT ─── */
document.getElementById('printBtn').onclick = function() {
    window.print();
};

/* ─── EXPORT CSV ─── */
document.getElementById('csvBtn').onclick = function() {
    var lines = [];

    lines.push('MEDICORE HMS - FULL REPORT');
    lines.push('Generated: ' + new Date().toLocaleString('en-IN'));
    lines.push('');

    /* Doctors */
    lines.push('--- DOCTORS ---');
    lines.push('ID,Name,Speciality');
    for (var i = 0; i < csvData.doctors.length; i++) {
        var d = csvData.doctors[i];
        lines.push(d.id + ',"' + d.name + '","' + (d.speciality||'') + '"');
    }
    lines.push('');

    /* Patients */
    lines.push('--- PATIENTS ---');
    lines.push('ID,Name,Gender,Age');
    for (var i = 0; i < csvData.patients.length; i++) {
        var p = csvData.patients[i];
        lines.push(p.id + ',"' + p.name + '","' + (p.gender||'') + '",' + (p.age||''));
    }
    lines.push('');

    /* Appointments */
    lines.push('--- APPOINTMENTS ---');
    lines.push('ID,Date,Doctor,Patient');
    for (var i = 0; i < csvData.appointments.length; i++) {
        var a = csvData.appointments[i];
        lines.push(a.id + ',' + (a.date||'') + ',"' + getDoctorName(a) + '","' + getPatientName(a) + '"');
    }
    lines.push('');

    /* Lab Reports */
    lines.push('--- LAB REPORTS ---');
    lines.push('ID,Patient,Test,Date,Status,Result');
    for (var i = 0; i < csvData.lab.length; i++) {
        var r = csvData.lab[i];
        lines.push(r.id + ',"' + getPatientName(r) + '","' + r.testName + '",' + (r.reportDate||'') + ',"' + (r.status||'') + '","' + (r.result||'') + '"');
    }
    lines.push('');

    /* Medicines */
    lines.push('--- MEDICINES ---');
    lines.push('ID,Name,Category,Quantity,Price,ExpiryDate');
    for (var i = 0; i < csvData.medicines.length; i++) {
        var m = csvData.medicines[i];
        lines.push(m.id + ',"' + m.name + '","' + (m.category||'') + '",' + m.quantity + ',' + m.price + ',' + (m.expiryDate||''));
    }
    lines.push('');

    /* Invoices */
    lines.push('--- INVOICES ---');
    lines.push('ID,Patient,Description,Amount,Date,Status,PaymentMode');
    for (var i = 0; i < csvData.invoices.length; i++) {
        var inv = csvData.invoices[i];
        lines.push(inv.id + ',"' + getPatientName(inv) + '","' + inv.description + '",' + inv.amount + ',' + (inv.invoiceDate||'') + ',"' + (inv.status||'') + '","' + (inv.paymentMode||'') + '"');
    }

    var csv     = lines.join('\n');
    var blob    = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
    var url     = URL.createObjectURL(blob);
    var link    = document.createElement('a');
    var now     = new Date();
    var fname   = 'medicore_report_' + now.getFullYear() + String(now.getMonth()+1).padStart(2,'0') + String(now.getDate()).padStart(2,'0') + '.csv';
    link.href   = url;
    link.setAttribute('download', fname);
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    toast('CSV exported successfully!');
};

/* ─── INIT ─── */
$(document).ready(function() {
    loadDoctors();
    loadPatients();
    loadAppointments();
    loadLabReports();
    loadMedicines();
    loadInvoices();
});
</script>
</body>
</html>
