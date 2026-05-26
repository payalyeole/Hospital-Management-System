<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MediCore | Doctor Management</title>

<link href="https://fonts.googleapis.com/css2?family=Instrument+Serif:ital@0;1&family=Sora:wght@300;400;500;600&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<!-- Shared HMS Stylesheet -->
<link rel="stylesheet" href="/css/medicore.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
<!-- NAVBAR -->
    <nav class="top-nav navbar py-2 px-3 px-lg-4">
        <a href="#" class="brand">
            <span class="brand-icon"><i class="bi bi-heart-pulse-fill"></i></span>
            MediCore <sup style="font-size:.55rem;color:var(--muted);margin-left:4px;">HMS</sup>
        </a>

        <div class="d-flex align-items-center gap-3">
            <button
                  class="theme-toggle"
                  id="themeToggle"
                  aria-label="Toggle light / dark theme"
                  title="Toggle theme">
                  <i class="bi bi-moon-stars-fill icon-moon" aria-hidden="true"></i>
                  <i class="bi bi-sun-fill icon-sun" aria-hidden="true"></i>
            </button>
            <div class="topbar-right">
                <div class="breadcrumb-trail">
                    <a href="/dashboard.jsp"><i class="bi bi-house"></i></a>
                    <i class="bi bi-chevron-right" style="font-size:.6rem;"></i>
                    <span>Doctors</span>
                </div>
            </div>
        </div>
    </nav>



<!-- ═══ PAGE ═══ -->
<div class="page-wrap">

    <!-- Header -->
    <div class="page-header">
        <div class="page-header-left">
            <h1>Manage <em>Doctors</em></h1>
            <p>Add, view, and remove physician records across all departments.</p>
        </div>
        <div class="count-badge" id="totalBadge">
            <i class="bi bi-person-badge-fill"></i>
            <span id="totalCount">—</span> doctors
        </div>
    </div>

    <!-- Stats -->
<div class="row g-3 mb-4">

    <!-- Total Registered -->
    <div class="col-md-3">
        <div class="card bg-dark text-white shadow-sm border-0 h-100">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <small class="text-secondary">Total Registered</small>
                    <i class="bi bi-people text-primary"></i>
                </div>
                <h4 class="fw-bold mt-2" id="statTotal">—</h4>
                <small class="text-secondary">all specialities</small>
            </div>
        </div>
    </div>

    <!-- On Duty -->
    <div class="col-md-3">
        <div class="card bg-dark text-white shadow-sm border-0 h-100">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <small class="text-secondary">On Duty Today</small>
                    <i class="bi bi-person-check text-success"></i>
                </div>
                <h4 class="fw-bold mt-2">28</h4>
                <small class="text-secondary">actively available</small>
            </div>
        </div>
    </div>

    <!-- Departments -->
    <div class="col-md-3">
        <div class="card bg-dark text-white shadow-sm border-0 h-100">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <small class="text-secondary">Departments</small>
                    <i class="bi bi-building text-warning"></i>
                </div>
                <h4 class="fw-bold mt-2" id="statDepts">—</h4>
                <small class="text-secondary">unique specialities</small>
            </div>
        </div>
    </div>

    <!-- On Leave -->
    <div class="col-md-3">
        <div class="card bg-dark text-white shadow-sm border-0 h-100">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <small class="text-secondary">On Leave</small>
                    <i class="bi bi-person-x text-danger"></i>
                </div>
                <h4 class="fw-bold mt-2">3</h4>
                <small class="text-secondary">return this week</small>
            </div>
        </div>
    </div>
</div>
    <!-- Two-col -->
    <div class="two-col">

        <!-- ADD FORM -->
        <div class="panel">
            <div class="panel-head">
                <span class="panel-title">Add New Doctor</span>
                <i class="bi bi-person-plus" style="color:var(--accent);"></i>
            </div>
            <div class="panel-body">
                <form id="doctorForm" autocomplete="off">

                    <div class="field-group">
                        <label class="field-label">Full Name</label>
                        <div class="field-wrap">
                            <i class="bi bi-person field-icon"></i>
                            <input type="text" id="name" class="field-input" placeholder="Dr. Firstname Lastname" required>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Speciality</label>
                        <div class="field-wrap">
                            <i class="bi bi-heart-pulse field-icon"></i>
                            <input type="text" id="speciality" class="field-input" placeholder="e.g. Cardiology" list="specSuggestions" required>
                            <datalist id="specSuggestions">
                                <option value="Cardiology">
                                <option value="Neurology">
                                <option value="Orthopedics">
                                <option value="Pediatrics">
                                <option value="Dermatology">
                                <option value="General Medicine">
                                <option value="Oncology">
                                <option value="Gynecology">
                                <option value="Ophthalmology">
                                <option value="Psychiatry">
                            </datalist>
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
                        Add Doctor
                    </button>
                </form>
            </div>
        </div>

        <!-- DOCTOR LIST -->
        <div class="table-panel">
            <div class="table-head-bar">
                <span class="panel-title">Doctor Directory</span>

                <div style="display:flex;align-items:center;gap:.7rem;flex-wrap:wrap;">
                    <!-- Search -->
                    <div class="search-wrap">
                        <i class="bi bi-search search-icon"></i>
                        <input type="text" id="searchInput" class="search-input" placeholder="Search doctors…">
                    </div>

                    <!-- View toggle -->
                    <div class="view-toggle">
                        <button class="view-btn active" id="gridViewBtn" title="Card view"><i class="bi bi-grid-3x3-gap-fill"></i></button>
                        <button class="view-btn" id="listViewBtn" title="List view"><i class="bi bi-list-ul"></i></button>
                    </div>
                </div>
            </div>

            <!-- CARD VIEW -->
            <div id="gridView">
                <div class="doctor-grid" id="doctorGrid">
                    <!-- skeleton placeholders -->
                    <div class="skel-card"><div class="skeleton" style="height:100%;border-radius:10px;"></div></div>
                    <div class="skel-card"><div class="skeleton" style="height:100%;border-radius:10px;"></div></div>
                    <div class="skel-card"><div class="skeleton" style="height:100%;border-radius:10px;"></div></div>
                </div>
            </div>

            <!-- LIST VIEW (hidden by default) -->
            <div id="listView" style="display:none; overflow-x:auto;">
                <table class="doc-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Doctor</th>
                            <th>Speciality</th>
                            <th style="text-align:right;">Action</th>
                        </tr>
                    </thead>
                    <tbody id="doctorTableBody"></tbody>
                </table>
            </div>

            <!-- EMPTY STATE -->
            <div class="empty-state" id="emptyState" style="display:none;">
                <i class="bi bi-person-x"></i>
                <p>No doctors found. Add one using the form.</p>
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
        <p class="modal-title">Remove Doctor?</p>
        <p class="modal-sub">This action cannot be undone. The doctor's record will be permanently deleted.</p>
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
 * NOTE FOR JSP DEVELOPERS:
 * All JavaScript template literals have been replaced with string
 * concatenation to avoid conflicts with JSP Expression Language (EL).
 * JSP compiler intercepts every dollar+brace pattern in the file,
 * even inside script tags and comments.
 * Solution: use '' + variable + '' style concatenation throughout.
 */

const API_URL    = "/api/v1/doctors";
let currentPage  = 0;
const pageSize   = 6;
let totalPages   = 0;
let allDoctors   = [];
let deleteTarget = null;
let isGridView   = true;

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

/* ─── SPEC TAG ─── */
function specClass(spec) {
    var s = (spec || '').toLowerCase();
    if (s.indexOf('cardio')  !== -1) return 'spec-cardiology';
    if (s.indexOf('neuro')   !== -1) return 'spec-neurology';
    if (s.indexOf('ortho')   !== -1) return 'spec-orthopedic';
    if (s.indexOf('pedia')   !== -1) return 'spec-pediatrics';
    if (s.indexOf('derma')   !== -1) return 'spec-dermatology';
    if (s.indexOf('general') !== -1) return 'spec-general';
    return 'spec-default';
}

function initials(name) {
    return (name || '?').split(' ').map(function(w) { return w[0]; }).join('').substring(0,2).toUpperCase();
}

function padId(id) {
    var s = '' + id;
    while (s.length < 4) s = '0' + s;
    return s;
}

/* ─── RENDER GRID ─── */
function renderGrid(doctors) {
    var grid = document.getElementById('doctorGrid');
    if (!doctors.length) { showEmpty(true); grid.innerHTML = ''; return; }
    showEmpty(false);

    var html = '';
    for (var i = 0; i < doctors.length; i++) {
        var d = doctors[i];
        html +=
            '<div class="doctor-card" style="animation-delay:' + (i * 0.05) + 's" data-id="' + d.id + '">' +
                '<div style="display:flex;align-items:center;gap:.7rem;">' +
                    '<div class="doc-avatar">' + initials(d.name) + '</div>' +
                    '<div class="doc-info">' +
                        '<div class="doc-name">' + d.name + '</div>' +
                        '<span class="spec-tag ' + specClass(d.speciality) + '">' + d.speciality + '</span>' +
                    '</div>' +
                '</div>' +
                '<div class="doc-id"># ' + padId(d.id) + '</div>' +
                '<div class="doc-actions">' +
                    '<button class="btn-del" data-id="' + d.id + '">' +
                        '<i class="bi bi-trash3"></i> Remove' +
                    '</button>' +
                '</div>' +
            '</div>';
    }
    grid.innerHTML = html;

    // Attach delete handlers via data attributes (avoids inline onclick + quote escaping)
    grid.querySelectorAll('.btn-del').forEach(function(btn) {
        btn.addEventListener('click', function() {
            confirmDelete(this.getAttribute('data-id'));
        });
    });
}

/* ─── RENDER TABLE ─── */
function renderTable(doctors) {
    var tbody = document.getElementById('doctorTableBody');
    if (!doctors.length) { showEmpty(true); tbody.innerHTML = ''; return; }
    showEmpty(false);

    var html = '';
    for (var i = 0; i < doctors.length; i++) {
        var d = doctors[i];
        html +=
            '<tr>' +
                '<td style="color:var(--muted);font-size:.75rem;">#' + padId(d.id) + '</td>' +
                '<td>' +
                    '<div style="display:flex;align-items:center;gap:.7rem;">' +
                        '<div class="doc-avatar" style="width:32px;height:32px;font-size:.8rem;">' + initials(d.name) + '</div>' +
                        '<span style="font-weight:500;">' + d.name + '</span>' +
                    '</div>' +
                '</td>' +
                '<td><span class="spec-tag ' + specClass(d.speciality) + '">' + d.speciality + '</span></td>' +
                '<td style="text-align:right;">' +
                    '<button class="btn-del" data-id="' + d.id + '">' +
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

function showEmpty(show) {
    document.getElementById('emptyState').style.display = show ? 'block' : 'none';
}

/* ─── LOAD DOCTORS ─── */
function loadDoctors(searchTerm) {
    searchTerm = searchTerm || '';
    $.ajax({
        url: API_URL + '?page=' + currentPage + '&size=' + pageSize,
        type: 'GET',
        success: function(response) {
            allDoctors = response.content || [];
            totalPages = response.totalPages || 1;

            var filtered = searchTerm
                ? allDoctors.filter(function(d) {
                    return d.name.toLowerCase().indexOf(searchTerm.toLowerCase()) !== -1 ||
                           d.speciality.toLowerCase().indexOf(searchTerm.toLowerCase()) !== -1;
                  })
                : allDoctors;

            if (isGridView) renderGrid(filtered);
            else            renderTable(filtered);

            // Stats
            var total = response.totalElements || allDoctors.length;
            document.getElementById('statTotal').textContent  = total;
            document.getElementById('totalCount').textContent = total;
            var specs = [];
            allDoctors.forEach(function(d) {
                if (specs.indexOf(d.speciality) === -1) specs.push(d.speciality);
            });
            document.getElementById('statDepts').textContent = specs.length;

            // Pagination
            document.getElementById('pageInfo').textContent =
                'Page ' + (currentPage + 1) + ' of ' + totalPages + '  ·  ' + total + ' total';
            document.getElementById('prevBtn').disabled = currentPage === 0;
            document.getElementById('nextBtn').disabled = currentPage >= totalPages - 1;
        },
        error: function() { toast('Failed to load doctors.', 'error'); }
    });
}

/* ─── ADD DOCTOR ─── */
$('#doctorForm').submit(function(e) {
    e.preventDefault();
    var btn = document.getElementById('addBtn');
    btn.disabled = true;
    btn.innerHTML = '<i class="bi bi-hourglass-split"></i> Saving...';

    var doctorData = {
        name:       $('#name').val().trim(),
        speciality: $('#speciality').val().trim()
    };

    $.ajax({
        url: API_URL,
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(doctorData),
        success: function() {
            $('#doctorForm')[0].reset();
            currentPage = 0;
            loadDoctors();
            toast('Doctor added successfully!');
        },
        error: function() { toast('Failed to add doctor.', 'error'); },
        complete: function() {
            btn.disabled = false;
            btn.innerHTML = '<i class="bi bi-plus-circle-fill"></i> Add Doctor';
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
        success: function() { toast('Doctor removed.'); loadDoctors(); },
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
    loadDoctors($('#searchInput').val());
};

document.getElementById('listViewBtn').onclick = function() {
    isGridView = false;
    this.classList.add('active');
    document.getElementById('gridViewBtn').classList.remove('active');
    document.getElementById('gridView').style.display = 'none';
    document.getElementById('listView').style.display = 'block';
    loadDoctors($('#searchInput').val());
};

/* ─── SEARCH ─── */
var searchTimer;
document.getElementById('searchInput').addEventListener('input', function() {
    clearTimeout(searchTimer);
    var val = this.value.trim();
    searchTimer = setTimeout(function() { loadDoctors(val); }, 280);
});

/* ─── PAGINATION ─── */
document.getElementById('prevBtn').onclick = function() {
    if (currentPage > 0) { currentPage--; loadDoctors(); }
};
document.getElementById('nextBtn').onclick = function() {
    if (currentPage < totalPages - 1) { currentPage++; loadDoctors(); }
};

/* ─── CLOSE MODAL ON OVERLAY CLICK ─── */
document.getElementById('confirmModal').onclick = function(e) {
    if (e.target === this) { this.classList.remove('open'); deleteTarget = null; }
};

/* ─── INIT ─── */
$(document).ready(function() { loadDoctors(); });
</script>

</body>
</html>
<script>
(function () {
  "use strict";

  var STORAGE_KEY = "medicore-theme";
  var html        = document.documentElement;

  function getPreferred() {
    var saved = localStorage.getItem(STORAGE_KEY);
    if (saved === "light" || saved === "dark") return saved;
    return window.matchMedia("(prefers-color-scheme: light)").matches
      ? "light"
      : "dark";
  }

  function applyTheme(theme) {
    html.setAttribute("data-theme", theme);
    localStorage.setItem(STORAGE_KEY, theme);
  }

  applyTheme(getPreferred());

  document.addEventListener("DOMContentLoaded", function () {

    function tick() {
      var el = document.getElementById("liveClock");
      if (el) {
        el.textContent = new Date().toLocaleTimeString("en-IN", { hour12: false });
      }
    }
    tick();
    setInterval(tick, 1000);

    var btn = document.getElementById("themeToggle");
    if (!btn) return;

    btn.addEventListener("click", function () {
      var current = html.getAttribute("data-theme") || "dark";
      applyTheme(current === "dark" ? "light" : "dark");
    });

    window.addEventListener("storage", function (e) {
      if (e.key === STORAGE_KEY && (e.newValue === "light" || e.newValue === "dark")) {
        applyTheme(e.newValue);
      }
    });
  });
})();
</script>