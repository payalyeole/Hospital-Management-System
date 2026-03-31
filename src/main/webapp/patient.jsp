<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MediCore | Patient Management</title>

<!-- Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Instrument+Serif:ital@0;1&family=Sora:wght@300;400;500;600&display=swap" rel="stylesheet">
<!-- Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
<!-- Shared HMS Stylesheet -->
<link rel="stylesheet" href="/css/medicore.css">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
/* ── PATIENT-SPECIFIC STYLES ── */

/* Patient cards grid */
.patient-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(230px, 1fr));
    gap: 1rem;
    padding: 1.2rem;
}

.patient-card {
    background: var(--bg);
    border: 1px solid var(--border);
    border-radius: var(--radius);
    padding: 1.15rem;
    display: flex;
    flex-direction: column;
    gap: .65rem;
    transition: transform .2s, box-shadow .2s, border-color .2s;
    animation: fadeUp .35s both;
}

.patient-card:hover {
    transform: translateY(-3px);
    box-shadow: var(--shadow-lg);
    border-color: #c7d7f5;
}

.patient-card-top {
    display: flex;
    align-items: center;
    gap: .75rem;
}

.patient-name {
    font-size: .9rem;
    font-weight: 600;
    color: var(--text);
    margin-bottom: .2rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.patient-meta {
    display: flex;
    align-items: center;
    gap: .4rem;
    flex-wrap: wrap;
}

.age-badge {
    font-size: .7rem;
    font-weight: 600;
    padding: .15rem .5rem;
    border-radius: 20px;
    background: var(--success-l);
    color: var(--success);
}

.patient-id {
    font-size: .68rem;
    color: var(--muted);
}

.patient-card-actions {
    display: flex;
    gap: .5rem;
    justify-content: flex-end;
    margin-top: .15rem;
}

/* Age range indicator bar */
.age-bar-wrap {
    height: 3px;
    background: var(--border);
    border-radius: 3px;
    overflow: hidden;
}

.age-bar {
    height: 100%;
    border-radius: 3px;
    background: linear-gradient(90deg, var(--accent), var(--success));
}

/* Filter chips */
.filter-chips {
    display: flex;
    gap: .4rem;
    flex-wrap: wrap;
}

.chip {
    padding: .3rem .75rem;
    border-radius: 20px;
    border: 1px solid var(--border);
    background: var(--bg);
    font-size: .72rem;
    font-weight: 500;
    color: var(--muted);
    cursor: pointer;
    font-family: 'Sora', sans-serif;
    transition: all .2s;
}

.chip.active {
    background: var(--accent);
    color: #fff;
    border-color: var(--accent);
}

.chip:hover:not(.active) {
    border-color: var(--accent);
    color: var(--accent);
}
</style>
</head>

<body>

<!-- ═══ TOPBAR ═══ -->
<nav class="topbar">
    <a href="/dashboard.jsp" class="topbar-brand">
        <span class="brand-pill">HMS</span>
        MediCore
    </a>
    <div class="topbar-right">
        <div class="breadcrumb-trail">
            <a href="/dashboard.jsp"><i class="bi bi-house"></i></a>
            <i class="bi bi-chevron-right" style="font-size:.6rem;"></i>
            <span>Patients</span>
        </div>
    </div>
</nav>

<!-- ═══ PAGE ═══ -->
<div class="page-wrap">

    <!-- Header -->
    <div class="page-header">
        <div class="page-header-left">
            <h1>Manage <em>Patients</em></h1>
            <p>Register, view, and manage all patient records across wards.</p>
        </div>
        <div class="count-badge" id="totalBadge">
            <i class="bi bi-people-fill"></i>
            <span id="totalCount">—</span> patients
        </div>
    </div>

    <!-- Stats -->
    <div class="stat-row">
        <div class="stat-card blue">
            <p class="stat-label">Total Patients</p>
            <div class="stat-val" id="statTotal">—</div>
            <p class="stat-sub">all records</p>
        </div>
        <div class="stat-card green">
            <p class="stat-label">Admitted</p>
            <div class="stat-val" id="statMale">—</div>
            <p class="stat-sub">currently in ward</p>
        </div>
        <div class="stat-card purple">
            <p class="stat-label">Female</p>
            <div class="stat-val" id="statFemale">—</div>
            <p class="stat-sub">registered</p>
        </div>
        <div class="stat-card warn">
            <p class="stat-label">Avg. Age</p>
            <div class="stat-val" id="statAvgAge">—</div>
            <p class="stat-sub">years</p>
        </div>
        <div class="stat-card red">
            <p class="stat-label">New Today</p>
            <div class="stat-val">4</div>
            <p class="stat-sub">registered today</p>
        </div>
    </div>

    <!-- Two-col -->
    <div class="two-col">

        <!-- ADD FORM -->
        <div class="panel">
            <div class="panel-head">
                <span class="panel-title">Register Patient</span>
                <i class="bi bi-person-plus" style="color:var(--success);"></i>
            </div>
            <div class="panel-body">
                <form id="patientForm" autocomplete="off">

                    <div class="field-group">
                        <label class="field-label">Full Name</label>
                        <div class="field-wrap">
                            <i class="bi bi-person field-icon"></i>
                            <input type="text" id="name" class="field-input" placeholder="Patient full name" required>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Gender</label>
                        <div class="field-wrap">
                            <i class="bi bi-gender-ambiguous field-icon"></i>
                            <select id="gender" class="field-input" required>
                                <option value="">Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Age</label>
                        <div class="field-wrap">
                            <i class="bi bi-calendar2 field-icon"></i>
                            <input type="number" id="age" class="field-input" placeholder="Age in years" min="0" max="120" required>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Phone (optional)</label>
                        <div class="field-wrap">
                            <i class="bi bi-telephone field-icon"></i>
                            <input type="tel" id="phone" class="field-input" placeholder="+91 98765 43210">
                        </div>
                    </div>

                    <button type="submit" class="btn-add" id="addBtn">
                        <i class="bi bi-plus-circle-fill"></i>
                        Register Patient
                    </button>
                </form>
            </div>
        </div>

        <!-- PATIENT LIST -->
        <div class="table-panel">
            <div class="table-head-bar">
                <span class="panel-title">Patient Directory</span>

                <div style="display:flex;align-items:center;gap:.7rem;flex-wrap:wrap;">
                    <!-- Search -->
                    <div class="search-wrap">
                        <i class="bi bi-search search-icon"></i>
                        <input type="text" id="searchInput" class="search-input" placeholder="Search patients…">
                    </div>
                    <!-- View toggle -->
                    <div class="view-toggle">
                        <button class="view-btn active" id="gridViewBtn" title="Card view"><i class="bi bi-grid-3x3-gap-fill"></i></button>
                        <button class="view-btn" id="listViewBtn" title="List view"><i class="bi bi-list-ul"></i></button>
                    </div>
                </div>
            </div>

            <!-- Gender filter chips -->
            <div style="padding:.75rem 1.4rem .1rem; border-bottom:1px solid var(--border);">
                <div class="filter-chips">
                    <button class="chip active" data-filter="all">All</button>
                    <button class="chip" data-filter="Male"><i class="bi bi-gender-male"></i> Male</button>
                    <button class="chip" data-filter="Female"><i class="bi bi-gender-female"></i> Female</button>
                    <button class="chip" data-filter="Other">Other</button>
                </div>
            </div>

            <!-- CARD VIEW -->
            <div id="gridView">
                <div class="patient-grid" id="patientGrid">
                    <div class="skel-card"><div class="skeleton" style="height:100%;border-radius:10px;"></div></div>
                    <div class="skel-card"><div class="skeleton" style="height:100%;border-radius:10px;"></div></div>
                    <div class="skel-card"><div class="skeleton" style="height:100%;border-radius:10px;"></div></div>
                </div>
            </div>

            <!-- LIST VIEW -->
            <div id="listView" style="display:none;overflow-x:auto;">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Patient</th>
                            <th>Gender</th>
                            <th>Age</th>
                            <th style="text-align:right;">Action</th>
                        </tr>
                    </thead>
                    <tbody id="patientTableBody"></tbody>
                </table>
            </div>

            <!-- EMPTY STATE -->
            <div class="empty-state" id="emptyState" style="display:none;">
                <i class="bi bi-person-x"></i>
                <p>No patients found. Register one using the form.</p>
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
        <div class="modal-icon"><i class="bi bi-trash3-fill"></i></div>
        <p class="modal-title">Remove Patient?</p>
        <p class="modal-sub">This action cannot be undone. The patient record will be permanently deleted.</p>
        <div class="modal-actions">
            <button class="btn-cancel" id="modalCancel">Cancel</button>
            <button class="btn-confirm-del" id="modalConfirm">Yes, Delete</button>
        </div>
    </div>
</div>

<!-- ═══ TOAST ═══ -->
<div class="toast-wrap" id="toastWrap"></div>


<script>
/*
 * NOTE: All JS uses string concatenation (no template literals / backticks)
 * to avoid conflicts with JSP Expression Language parser.
 */

var API_URL      = "/api/v1/patients";
var currentPage  = 0;
var pageSize     = 6;
var totalPages   = 0;
var allPatients  = [];
var deleteTarget = null;
var isGridView   = true;
var activeFilter = "all";

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
function initials(name) {
    return (name || '?').split(' ').map(function(w) { return w[0]; }).join('').substring(0, 2).toUpperCase();
}

function padId(id) {
    var s = '' + id;
    while (s.length < 4) s = '0' + s;
    return s;
}

function genderClass(g) {
    var gl = (g || '').toLowerCase();
    if (gl === 'male')   return 'tag-male';
    if (gl === 'female') return 'tag-female';
    return 'tag-other';
}

function avatarClass(g) {
    var gl = (g || '').toLowerCase();
    if (gl === 'male')   return 'avatar male';
    if (gl === 'female') return 'avatar female';
    return 'avatar';
}

function ageBarWidth(age) {
    var pct = Math.min(Math.round((age / 100) * 100), 100);
    return pct;
}

function showEmpty(show) {
    document.getElementById('emptyState').style.display = show ? 'block' : 'none';
}

/* ─── RENDER GRID ─── */
function renderGrid(patients) {
    var grid = document.getElementById('patientGrid');
    if (!patients.length) { showEmpty(true); grid.innerHTML = ''; return; }
    showEmpty(false);

    var html = '';
    for (var i = 0; i < patients.length; i++) {
        var p = patients[i];
        var barW = ageBarWidth(p.age);
        html +=
            '<div class="patient-card" style="animation-delay:' + (i * 0.05) + 's">' +
                '<div class="patient-card-top">' +
                    '<div class="' + avatarClass(p.gender) + '">' + initials(p.name) + '</div>' +
                    '<div style="flex:1;min-width:0;">' +
                        '<div class="patient-name">' + p.name + '</div>' +
                        '<div class="patient-meta">' +
                            '<span class="spec-tag ' + genderClass(p.gender) + '">' + p.gender + '</span>' +
                            '<span class="age-badge">' + p.age + ' yrs</span>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
                '<div class="age-bar-wrap"><div class="age-bar" style="width:' + barW + '%"></div></div>' +
                '<div class="patient-id"># ' + padId(p.id) + '</div>' +
                '<div class="patient-card-actions">' +
                    '<button class="btn-del" data-id="' + p.id + '">' +
                        '<i class="bi bi-trash3"></i> Remove' +
                    '</button>' +
                '</div>' +
            '</div>';
    }
    grid.innerHTML = html;

    grid.querySelectorAll('.btn-del').forEach(function(btn) {
        btn.addEventListener('click', function() {
            confirmDelete(this.getAttribute('data-id'));
        });
    });
}

/* ─── RENDER TABLE ─── */
function renderTable(patients) {
    var tbody = document.getElementById('patientTableBody');
    if (!patients.length) { showEmpty(true); tbody.innerHTML = ''; return; }
    showEmpty(false);

    var html = '';
    for (var i = 0; i < patients.length; i++) {
        var p = patients[i];
        html +=
            '<tr>' +
                '<td style="color:var(--muted);font-size:.75rem;">#' + padId(p.id) + '</td>' +
                '<td>' +
                    '<div style="display:flex;align-items:center;gap:.7rem;">' +
                        '<div class="' + avatarClass(p.gender) + ' sm">' + initials(p.name) + '</div>' +
                        '<span style="font-weight:500;">' + p.name + '</span>' +
                    '</div>' +
                '</td>' +
                '<td><span class="spec-tag ' + genderClass(p.gender) + '">' + p.gender + '</span></td>' +
                '<td>' + p.age + ' yrs</td>' +
                '<td style="text-align:right;">' +
                    '<button class="btn-del" data-id="' + p.id + '">' +
                        '<i class="bi bi-trash3"></i> Remove' +
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

/* ─── LOAD PATIENTS ─── */
function loadPatients(searchTerm) {
    searchTerm = searchTerm || '';
    $.ajax({
        url: API_URL + '?page=' + currentPage + '&size=' + pageSize,
        type: 'GET',
        success: function(response) {
            allPatients = response.content || [];
            totalPages  = response.totalPages || 1;

            var filtered = allPatients;

            if (activeFilter !== 'all') {
                filtered = filtered.filter(function(p) {
                    return (p.gender || '').toLowerCase() === activeFilter.toLowerCase();
                });
            }

            if (searchTerm) {
                filtered = filtered.filter(function(p) {
                    return p.name.toLowerCase().indexOf(searchTerm.toLowerCase()) !== -1;
                });
            }

            if (isGridView) renderGrid(filtered);
            else            renderTable(filtered);

            /* ── Stats ── */
            var total = response.totalElements || allPatients.length;
            document.getElementById('statTotal').textContent  = total;
            document.getElementById('totalCount').textContent = total;

            var males   = allPatients.filter(function(p) { return (p.gender||'').toLowerCase() === 'male'; }).length;
            var females = allPatients.filter(function(p) { return (p.gender||'').toLowerCase() === 'female'; }).length;
            var totalAge = 0;
            allPatients.forEach(function(p) { totalAge += parseInt(p.age) || 0; });
            var avgAge = allPatients.length ? Math.round(totalAge / allPatients.length) : 0;

            document.getElementById('statMale').textContent   = males;
            document.getElementById('statFemale').textContent = females;
            document.getElementById('statAvgAge').textContent = avgAge;

            /* ── Pagination ── */
            document.getElementById('pageInfo').textContent =
                'Page ' + (currentPage + 1) + ' of ' + totalPages + '  \u00b7  ' + total + ' total';
            document.getElementById('prevBtn').disabled = currentPage === 0;
            document.getElementById('nextBtn').disabled = currentPage >= totalPages - 1;
        },
        error: function() { toast('Failed to load patients.', 'error'); }
    });
}

/* ─── ADD PATIENT ─── */
$('#patientForm').submit(function(e) {
    e.preventDefault();
    var btn = document.getElementById('addBtn');
    btn.disabled = true;
    btn.innerHTML = '<i class="bi bi-hourglass-split"></i> Saving...';

    var patientData = {
        name:   $('#name').val().trim(),
        gender: $('#gender').val(),
        age:    $('#age').val()
    };

    $.ajax({
        url: API_URL,
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(patientData),
        success: function() {
            $('#patientForm')[0].reset();
            currentPage = 0;
            loadPatients();
            toast('Patient registered successfully!');
        },
        error: function() { toast('Failed to register patient.', 'error'); },
        complete: function() {
            btn.disabled = false;
            btn.innerHTML = '<i class="bi bi-plus-circle-fill"></i> Register Patient';
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
        url: API_URL + '/' + id,
        type: 'DELETE',
        success: function() { toast('Patient removed.'); loadPatients(); },
        error:   function() { toast('Delete failed.', 'error'); }
    });
    deleteTarget = null;
};

/* ─── VIEW TOGGLE ─── */
document.getElementById('gridViewBtn').onclick = function() {
    isGridView = true;
    this.classList.add('active');
    document.getElementById('listViewBtn').classList.remove('active');
    document.getElementById('gridView').style.display = 'block';
    document.getElementById('listView').style.display = 'none';
    loadPatients($('#searchInput').val());
};

document.getElementById('listViewBtn').onclick = function() {
    isGridView = false;
    this.classList.add('active');
    document.getElementById('gridViewBtn').classList.remove('active');
    document.getElementById('gridView').style.display = 'none';
    document.getElementById('listView').style.display = 'block';
    loadPatients($('#searchInput').val());
};

/* ─── GENDER FILTER CHIPS ─── */
document.querySelectorAll('.chip').forEach(function(chip) {
    chip.addEventListener('click', function() {
        document.querySelectorAll('.chip').forEach(function(c) { c.classList.remove('active'); });
        this.classList.add('active');
        activeFilter = this.getAttribute('data-filter');
        currentPage  = 0;
        loadPatients($('#searchInput').val());
    });
});

/* ─── SEARCH ─── */
var searchTimer;
document.getElementById('searchInput').addEventListener('input', function() {
    clearTimeout(searchTimer);
    var val = this.value.trim();
    searchTimer = setTimeout(function() { loadPatients(val); }, 280);
});

/* ─── PAGINATION ─── */
document.getElementById('prevBtn').onclick = function() {
    if (currentPage > 0) { currentPage--; loadPatients(); }
};
document.getElementById('nextBtn').onclick = function() {
    if (currentPage < totalPages - 1) { currentPage++; loadPatients(); }
};

/* ─── CLOSE MODAL ON OVERLAY CLICK ─── */
document.getElementById('confirmModal').onclick = function(e) {
    if (e.target === this) { this.classList.remove('open'); deleteTarget = null; }
};

/* ─── INIT ─── */
$(document).ready(function() { loadPatients(); });
</script>

</body>
</html>
