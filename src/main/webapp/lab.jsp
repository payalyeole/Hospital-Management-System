<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MediCore | Lab & Reports</title>

<link href="https://fonts.googleapis.com/css2?family=Instrument+Serif:ital@0;1&family=Sora:wght@300;400;500;600&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="/css/medicore.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
/* ── LAB PAGE STYLES (dark theme) ── */

/* Report cards grid */
.lab-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
    gap: 1rem;
    padding: 1.2rem;
}

.lab-card {
    background: rgba(255,255,255,.03);
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 1.15rem;
    display: flex;
    flex-direction: column;
    gap: .65rem;
    transition: transform .2s, box-shadow .2s, border-color .2s;
    animation: fadeUp .35s both;
    position: relative;
    overflow: hidden;
}

.lab-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 2px;
    border-radius: 2px 2px 0 0;
}

.lab-card.status-pending::before   { background: #f59e0b; }
.lab-card.status-completed::before { background: #10b981; }
.lab-card.status-cancelled::before { background: #ef4444; }

.lab-card:hover {
    transform: translateY(-3px);
    border-color: rgba(0,212,255,.3);
    box-shadow: 0 8px 30px rgba(0,0,0,.4);
}

/* Test icon */
.test-icon {
    width: 38px; height: 38px;
    border-radius: 9px;
    display: flex; align-items: center; justify-content: center;
    font-size: 1rem;
    flex-shrink: 0;
}

.icon-pending   { background: rgba(245,158,11,.15); color: #fcd34d; }
.icon-completed { background: rgba(16,185,129,.15); color: #6ee7b7; }
.icon-cancelled { background: rgba(239,68,68,.15);  color: #fca5a5; }
.icon-default   { background: rgba(0,212,255,.1);   color: var(--accent); }

/* Status badge */
.status-badge-lab {
    display: inline-flex; align-items: center; gap: .25rem;
    font-size: .68rem; font-weight: 600;
    padding: .18rem .55rem; border-radius: 20px;
    letter-spacing: .03em;
}

.badge-pending   { background: rgba(245,158,11,.15); color: #fcd34d; border: 1px solid rgba(245,158,11,.3); }
.badge-completed { background: rgba(16,185,129,.15); color: #6ee7b7; border: 1px solid rgba(16,185,129,.3); }
.badge-cancelled { background: rgba(239,68,68,.15);  color: #fca5a5; border: 1px solid rgba(239,68,68,.3); }

/* Result badge */
.result-badge {
    display: inline-flex; align-items: center; gap: .25rem;
    font-size: .65rem; font-weight: 600;
    padding: .15rem .5rem; border-radius: 20px;
}

.result-normal   { background: rgba(16,185,129,.12); color: #6ee7b7; }
.result-abnormal { background: rgba(245,158,11,.12); color: #fcd34d; }
.result-critical { background: rgba(239,68,68,.12);  color: #fca5a5; }
.result-pending  { background: rgba(148,163,184,.1); color: var(--muted); }

.lab-test-name {
    font-size: .9rem; font-weight: 600;
    color: var(--text);
    white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}

.lab-patient {
    font-size: .75rem; color: var(--muted);
    display: flex; align-items: center; gap: .3rem;
}

.lab-date {
    font-size: .68rem; color: var(--muted);
    display: flex; align-items: center; gap: .3rem;
}

.lab-remarks {
    font-size: .7rem; color: var(--muted);
    font-style: italic;
    white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}

.lab-actions {
    display: flex; gap: .45rem; justify-content: flex-end;
}

/* Action buttons */
.btn-update-status {
    padding: .32rem .7rem;
    background: rgba(0,212,255,.1);
    color: var(--accent);
    border: 1px solid rgba(0,212,255,.25);
    border-radius: 7px;
    font-size: .7rem; font-weight: 600;
    font-family: 'Sora', sans-serif;
    cursor: pointer;
    display: inline-flex; align-items: center; gap: .3rem;
    transition: background .2s;
}

.btn-update-status:hover { background: rgba(0,212,255,.2); }

.btn-del {
    padding: .32rem .7rem;
    background: rgba(239,68,68,.12);
    color: #fca5a5;
    border: 1px solid rgba(239,68,68,.3);
    border-radius: 7px;
    font-size: .7rem; font-weight: 600;
    font-family: 'Sora', sans-serif;
    cursor: pointer;
    display: inline-flex; align-items: center; gap: .3rem;
    transition: background .2s;
}

.btn-del:hover { background: rgba(239,68,68,.25); color: #fff; }

/* Filter chips */
.filter-chips { display: flex; gap: .4rem; flex-wrap: wrap; }

.chip {
    padding: .28rem .72rem;
    border-radius: 20px;
    border: 1px solid var(--border);
    background: transparent;
    font-size: .7rem; font-weight: 500;
    color: var(--muted);
    cursor: pointer;
    font-family: 'Sora', sans-serif;
    transition: all .2s;
}

.chip.active { background: var(--accent); color: #000; border-color: var(--accent); }
.chip:hover:not(.active) { border-color: var(--accent); color: var(--accent); }

/* Update status modal */
.modal-box.wide { width: 420px; text-align: left; }
.modal-box.wide .modal-icon { background: rgba(0,212,255,.12); color: var(--accent); margin-bottom: .8rem; }

.status-form-group { margin-bottom: .9rem; }

.status-form-label {
    display: block;
    font-size: .7rem; font-weight: 600;
    text-transform: uppercase; letter-spacing: .08em;
    color: var(--muted); margin-bottom: .35rem;
}

.status-form-input {
    width: 100%;
    padding: .6rem .9rem;
    border: 1px solid var(--border);
    border-radius: 8px;
    font-family: 'Sora', sans-serif;
    font-size: .83rem;
    color: var(--text);
    background: rgba(255,255,255,.04);
    outline: none;
    transition: border-color .2s;
    appearance: none;
}

.status-form-input:focus { border-color: var(--accent); }

select.status-form-input option { background: #151d2e; color: var(--text); }

.btn-save-status {
    width: 100%;
    padding: .7rem;
    background: var(--accent);
    color: #000;
    border: none;
    border-radius: 8px;
    font-family: 'Sora', sans-serif;
    font-size: .85rem; font-weight: 700;
    cursor: pointer;
    margin-bottom: .5rem;
    transition: opacity .2s;
}

.btn-save-status:hover { opacity: .85; }

/* field overrides for dark */
.field-input {
    background: rgba(255,255,255,.04);
    border: 1px solid var(--border);
    color: var(--text);
}

.field-input:focus {
    border-color: var(--accent);
    box-shadow: 0 0 0 3px rgba(0,212,255,.1);
    background: rgba(255,255,255,.06);
}

.field-input::placeholder { color: var(--muted); }
select.field-input option { background: #151d2e; color: var(--text); }
.panel-head { border-bottom: 1px solid var(--border); }
.table-head-bar { border-bottom: 1px solid var(--border); }
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
            <span>Lab & Reports</span>
        </div>
    </div>
</nav>

<!-- ═══ PAGE ═══ -->
<div class="page-wrap">

    <!-- Header -->
    <div class="page-header">
        <div class="page-header-left">
            <h1>Lab <em>&amp; Reports</em></h1>
            <p style="font-size:.82rem;color:var(--muted);">Request lab tests, track status, and manage diagnostic reports.</p>
        </div>
        <div id="totalBadge"
            style="background:rgba(0,212,255,.1);color:var(--accent);border:1px solid rgba(0,212,255,.2);display:flex;align-items:center;gap:.5rem;padding:.5rem 1rem;border-radius:30px;font-size:.78rem;font-weight:600;">
            <i class="bi bi-clipboard2-pulse-fill"></i>
            <span id="totalCount">-</span> reports
        </div>
    </div>

    <!-- Stats — Bootstrap dark cards -->
    <div class="row g-3 mb-4">
        <div class="col-md">
            <div class="card bg-dark text-white shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <small class="text-secondary">Total Reports</small>
                        <i class="bi bi-clipboard2-pulse text-info"></i>
                    </div>
                    <h4 class="fw-bold mt-2" id="statTotal">-</h4>
                    <small class="text-secondary">all records</small>
                </div>
            </div>
        </div>
        <div class="col-md">
            <div class="card bg-dark text-white shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <small class="text-secondary">Pending</small>
                        <i class="bi bi-hourglass-split text-warning"></i>
                    </div>
                    <h4 class="fw-bold mt-2" id="statPending">-</h4>
                    <small class="text-secondary">awaiting results</small>
                </div>
            </div>
        </div>
        <div class="col-md">
            <div class="card bg-dark text-white shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <small class="text-secondary">Completed</small>
                        <i class="bi bi-check-circle text-success"></i>
                    </div>
                    <h4 class="fw-bold mt-2" id="statCompleted">-</h4>
                    <small class="text-secondary">results ready</small>
                </div>
            </div>
        </div>
        <div class="col-md">
            <div class="card bg-dark text-white shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <small class="text-secondary">Critical Results</small>
                        <i class="bi bi-exclamation-triangle text-danger"></i>
                    </div>
                    <h4 class="fw-bold mt-2" id="statCritical">-</h4>
                    <small class="text-secondary">needs attention</small>
                </div>
            </div>
        </div>
        <div class="col-md">
            <div class="card bg-dark text-white shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <small class="text-secondary">Cancelled</small>
                        <i class="bi bi-x-circle text-secondary"></i>
                    </div>
                    <h4 class="fw-bold mt-2" id="statCancelled">-</h4>
                    <small class="text-secondary">not processed</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Two-col -->
    <div class="two-col">

        <!-- REQUEST FORM -->
        <div class="panel">
            <div class="panel-head" style="display:flex;align-items:center;justify-content:space-between;padding:.9rem 1.1rem;">
                <span class="panel-title">Request Lab Test</span>
                <i class="bi bi-plus-circle" style="color:var(--accent);"></i>
            </div>
            <div class="panel-body" style="padding:1.1rem;">
                <form id="labForm" autocomplete="off">

                    <div class="field-group">
                        <label class="field-label">Patient</label>
                        <div class="field-wrap">
                            <i class="bi bi-person field-icon"></i>
                            <%-- value = patient.id so Spring maps to patient_id FK --%>
                            <select id="patientId" class="field-input" required>
                                <option value="">Loading patients...</option>
                            </select>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Test Name</label>
                        <div class="field-wrap">
                            <i class="bi bi-clipboard2-pulse field-icon"></i>
                            <input type="text" id="testName" class="field-input"
                                placeholder="e.g. Blood CBC" list="testSuggestions" required>
                            <datalist id="testSuggestions">
                                <option value="Blood CBC">
                                <option value="Blood Sugar (Fasting)">
                                <option value="Blood Sugar (PP)">
                                <option value="Urine Routine">
                                <option value="Liver Function Test">
                                <option value="Kidney Function Test">
                                <option value="Thyroid Profile">
                                <option value="Lipid Profile">
                                <option value="X-Ray Chest">
                                <option value="ECG">
                                <option value="MRI Brain">
                                <option value="CT Scan Abdomen">
                                <option value="COVID-19 PCR">
                                <option value="Dengue NS1 Antigen">
                            </datalist>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Report Date</label>
                        <div class="field-wrap">
                            <i class="bi bi-calendar3 field-icon"></i>
                            <input type="date" id="reportDate" class="field-input" required>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Status</label>
                        <div class="field-wrap">
                            <i class="bi bi-activity field-icon"></i>
                            <select id="labStatus" class="field-input" required>
                                <option value="Pending">Pending</option>
                                <option value="Completed">Completed</option>
                                <option value="Cancelled">Cancelled</option>
                            </select>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Result (optional)</label>
                        <div class="field-wrap">
                            <i class="bi bi-journal-medical field-icon"></i>
                            <select id="labResult" class="field-input">
                                <option value="">Select Result</option>
                                <option value="Normal">Normal</option>
                                <option value="Abnormal">Abnormal</option>
                                <option value="Critical">Critical</option>
                            </select>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Remarks (optional)</label>
                        <div class="field-wrap">
                            <i class="bi bi-chat-text field-icon"></i>
                            <input type="text" id="labRemarks" class="field-input" placeholder="e.g. Fasting required">
                        </div>
                    </div>

                    <button type="submit" class="btn-add" id="addBtn"
                        style="background:var(--accent);color:#000;font-weight:700;">
                        <i class="bi bi-clipboard2-plus-fill"></i>
                        Request Test
                    </button>
                </form>
            </div>
        </div>

        <!-- REPORTS LIST -->
        <div class="table-panel">
            <div class="table-head-bar" style="display:flex;align-items:center;justify-content:space-between;padding:1rem 1.2rem;flex-wrap:wrap;gap:.7rem;">
                <span class="panel-title">Report Directory</span>
                <div style="display:flex;align-items:center;gap:.7rem;flex-wrap:wrap;">
                    <div class="search-wrap">
                        <i class="bi bi-search search-icon"></i>
                        <input type="text" id="searchInput" class="search-input" placeholder="Search test or patient...">
                    </div>
                    <div class="view-toggle">
                        <button class="view-btn active" id="gridViewBtn" title="Card view"><i class="bi bi-grid-3x3-gap-fill"></i></button>
                        <button class="view-btn" id="listViewBtn" title="List view"><i class="bi bi-list-ul"></i></button>
                    </div>
                </div>
            </div>

            <!-- Status filter chips -->
            <div style="padding:.7rem 1.2rem .2rem;border-bottom:1px solid var(--border);">
                <div class="filter-chips">
                    <button class="chip active" data-filter="all">All</button>
                    <button class="chip" data-filter="Pending"><i class="bi bi-hourglass-split"></i> Pending</button>
                    <button class="chip" data-filter="Completed"><i class="bi bi-check-circle"></i> Completed</button>
                    <button class="chip" data-filter="Cancelled"><i class="bi bi-x-circle"></i> Cancelled</button>
                    <button class="chip" data-filter="Critical"><i class="bi bi-exclamation-triangle"></i> Critical</button>
                </div>
            </div>

            <!-- CARD VIEW -->
            <div id="gridView">
                <div class="lab-grid" id="labGrid">
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
                            <th>Test</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Result</th>
                            <th style="text-align:right;">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="labTableBody"></tbody>
                </table>
            </div>

            <!-- EMPTY STATE -->
            <div class="empty-state" id="emptyState" style="display:none;">
                <i class="bi bi-clipboard2-x"></i>
                <p>No reports found. Request a test using the form.</p>
            </div>

            <!-- PAGINATION -->
            <div style="display:flex;align-items:center;justify-content:space-between;padding:1rem 1.2rem;border-top:1px solid var(--border);">
                <span class="page-info" id="pageInfo" style="font-size:.78rem;color:var(--muted);">-</span>
                <div style="display:flex;gap:.4rem;">
                    <button class="page-btn" id="prevBtn" disabled><i class="bi bi-chevron-left"></i> Previous</button>
                    <button class="page-btn" id="nextBtn" disabled>Next <i class="bi bi-chevron-right"></i></button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ═══ DELETE MODAL ═══ -->
<div class="modal-overlay" id="deleteModal">
    <div class="modal-box">
        <div class="modal-icon"><i class="bi bi-trash3-fill"></i></div>
        <p class="modal-title">Delete Report?</p>
        <p class="modal-sub">This will permanently remove the lab report record.</p>
        <div class="modal-actions">
            <button class="btn-cancel" id="deleteCancelBtn">Cancel</button>
            <button class="btn-confirm-del" id="deleteConfirmBtn">Yes, Delete</button>
        </div>
    </div>
</div>

<!-- ═══ UPDATE STATUS MODAL ═══ -->
<div class="modal-overlay" id="statusModal">
    <div class="modal-box wide">
        <div class="modal-icon"><i class="bi bi-clipboard2-check"></i></div>
        <p class="modal-title">Update Report</p>
        <p class="modal-sub" id="statusModalSub">Update status and result for this test.</p>

        <div class="status-form-group">
            <label class="status-form-label">Status</label>
            <select id="updateStatus" class="status-form-input">
                <option value="Pending">Pending</option>
                <option value="Completed">Completed</option>
                <option value="Cancelled">Cancelled</option>
            </select>
        </div>

        <div class="status-form-group">
            <label class="status-form-label">Result</label>
            <select id="updateResult" class="status-form-input">
                <option value="">Select Result</option>
                <option value="Normal">Normal</option>
                <option value="Abnormal">Abnormal</option>
                <option value="Critical">Critical</option>
            </select>
        </div>

        <div class="status-form-group">
            <label class="status-form-label">Remarks</label>
            <input type="text" id="updateRemarks" class="status-form-input" placeholder="Optional notes...">
        </div>

        <button class="btn-save-status" id="saveStatusBtn">Save Changes</button>
        <button class="btn-cancel" id="statusCancelBtn" style="width:100%;">Cancel</button>
    </div>
</div>

<!-- ═══ TOAST ═══ -->
<div class="toast-wrap" id="toastWrap"></div>

<script>
/*
 * JSP RULE: No template literals, no arrow functions, no const/let.
 *
 * LabReport fields: id, testName, status, reportDate, result, remarks
 * Nested: patient { id, name, gender, age }
 *
 * POST body: { testName, status, reportDate, result, remarks, patient:{id} }
 */

var API_REPORTS  = "/api/v1/lab-reports";
var API_PATIENTS = "/api/v1/patients";

var currentPage  = 0;
var pageSize     = 6;
var totalPages   = 0;
var allReports   = [];
var deleteTarget = null;
var statusTarget = null;
var isGridView   = true;
var activeFilter = "all";

/* ─── SET TODAY AS DEFAULT DATE ─── */
(function() {
    var now = new Date();
    var y = now.getFullYear();
    var m = String(now.getMonth() + 1).padStart(2, '0');
    var d = String(now.getDate()).padStart(2, '0');
    document.getElementById('reportDate').value = y + '-' + m + '-' + d;
})();

/* ─── TOAST ─── */
function toast(msg, type) {
    type = type || 'success';
    var t = document.createElement('div');
    t.className = 'toast-msg ' + type;
    t.innerHTML = '<i class="bi bi-' + (type === 'success' ? 'check-circle-fill' : 'x-circle-fill') + '"></i>' + msg;
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
    if (!dateStr) return '-';
    var parts = dateStr.split('-');
    if (parts.length < 3) return dateStr;
    var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return parts[2] + ' ' + (months[parseInt(parts[1],10)-1] || parts[1]) + ' ' + parts[0];
}

function getPatientName(r) {
    if (r.patient && r.patient.name) return r.patient.name;
    if (r.patientName)               return r.patientName;
    return 'Unknown Patient';
}

function statusKey(s) {
    var sl = (s || '').toLowerCase();
    if (sl === 'completed') return 'completed';
    if (sl === 'cancelled') return 'cancelled';
    return 'pending';
}

function resultBadgeClass(res) {
    var rl = (res || '').toLowerCase();
    if (rl === 'normal')   return 'result-normal';
    if (rl === 'abnormal') return 'result-abnormal';
    if (rl === 'critical') return 'result-critical';
    return 'result-pending';
}

function showEmpty(show) {
    document.getElementById('emptyState').style.display = show ? 'block' : 'none';
}

/* ─── LOAD PATIENTS INTO SELECT ─── */
function loadPatients() {
    $.ajax({
        url: API_PATIENTS + '?page=0&size=100',
        type: 'GET',
        success: function(response) {
            var patients = response.content || [];
            var html = '<option value="">Select Patient</option>';
            for (var i = 0; i < patients.length; i++) {
                var p = patients[i];
                html += '<option value="' + p.id + '">' + p.name + ' (' + (p.gender || '') + ', ' + (p.age || '') + ' yrs)</option>';
            }
            document.getElementById('patientId').innerHTML = html;
        },
        error: function() {
            document.getElementById('patientId').innerHTML = '<option value="">Failed to load</option>';
            toast('Could not load patients.', 'error');
        }
    });
}

/* ─── RENDER GRID ─── */
function renderGrid(reports) {
    var grid = document.getElementById('labGrid');
    if (!reports.length) { showEmpty(true); grid.innerHTML = ''; return; }
    showEmpty(false);

    var html = '';
    for (var i = 0; i < reports.length; i++) {
        var r       = reports[i];
        var sk      = statusKey(r.status);
        var patName = getPatientName(r);
        var res     = r.result || '';

        html +=
            '<div class="lab-card status-' + sk + '" style="animation-delay:' + (i * 0.05) + 's">' +
                '<div style="display:flex;align-items:center;gap:.7rem;">' +
                    '<div class="test-icon icon-' + sk + '"><i class="bi bi-clipboard2-pulse"></i></div>' +
                    '<div style="flex:1;min-width:0;">' +
                        '<div class="lab-test-name">' + r.testName + '</div>' +
                        '<div class="lab-patient"><i class="bi bi-person"></i>' + patName + '</div>' +
                    '</div>' +
                    '<span class="status-badge-lab badge-' + sk + '">' + r.status + '</span>' +
                '</div>' +
                '<div style="display:flex;align-items:center;justify-content:space-between;gap:.4rem;">' +
                    '<div class="lab-date"><i class="bi bi-calendar3"></i>' + formatDate(r.reportDate) + '</div>' +
                    (res ? '<span class="result-badge ' + resultBadgeClass(res) + '">' + res + '</span>' : '<span class="result-badge result-pending">Awaiting</span>') +
                '</div>' +
                (r.remarks ? '<div class="lab-remarks"><i class="bi bi-chat-text"></i> ' + r.remarks + '</div>' : '') +
                '<div class="lab-actions">' +
                    '<button class="btn-update-status update-btn" data-id="' + r.id + '" data-status="' + (r.status||'') + '" data-result="' + (r.result||'') + '" data-remarks="' + (r.remarks||'') + '" data-test="' + r.testName + '">' +
                        '<i class="bi bi-pencil-square"></i> Update' +
                    '</button>' +
                    '<button class="btn-del delete-btn" data-id="' + r.id + '">' +
                        '<i class="bi bi-trash3"></i>' +
                    '</button>' +
                '</div>' +
                '<div style="font-size:.65rem;color:var(--muted);margin-top:.1rem;"># ' + padId(r.id) + '</div>' +
            '</div>';
    }
    grid.innerHTML = html;
    attachEvents(grid);
}

/* ─── RENDER TABLE ─── */
function renderTable(reports) {
    var tbody = document.getElementById('labTableBody');
    if (!reports.length) { showEmpty(true); tbody.innerHTML = ''; return; }
    showEmpty(false);

    var html = '';
    for (var i = 0; i < reports.length; i++) {
        var r       = reports[i];
        var sk      = statusKey(r.status);
        var patName = getPatientName(r);
        var res     = r.result || '';

        html +=
            '<tr>' +
                '<td style="color:var(--muted);font-size:.72rem;">#' + padId(r.id) + '</td>' +
                '<td><i class="bi bi-person" style="color:var(--accent);margin-right:.3rem;"></i>' + patName + '</td>' +
                '<td><strong>' + r.testName + '</strong></td>' +
                '<td style="font-size:.78rem;color:var(--muted);">' + formatDate(r.reportDate) + '</td>' +
                '<td><span class="status-badge-lab badge-' + sk + '">' + r.status + '</span></td>' +
                '<td>' + (res ? '<span class="result-badge ' + resultBadgeClass(res) + '">' + res + '</span>' : '<span class="result-badge result-pending">-</span>') + '</td>' +
                '<td style="text-align:right;">' +
                    '<button class="btn-update-status update-btn" data-id="' + r.id + '" data-status="' + (r.status||'') + '" data-result="' + (r.result||'') + '" data-remarks="' + (r.remarks||'') + '" data-test="' + r.testName + '" style="margin-right:.3rem;">' +
                        '<i class="bi bi-pencil-square"></i>' +
                    '</button>' +
                    '<button class="btn-del delete-btn" data-id="' + r.id + '">' +
                        '<i class="bi bi-trash3"></i>' +
                    '</button>' +
                '</td>' +
            '</tr>';
    }
    tbody.innerHTML = html;
    attachEvents(tbody);
}

/* ─── ATTACH EVENTS ─── */
function attachEvents(container) {
    container.querySelectorAll('.delete-btn').forEach(function(btn) {
        btn.addEventListener('click', function() {
            deleteTarget = this.getAttribute('data-id');
            document.getElementById('deleteModal').classList.add('open');
        });
    });

    container.querySelectorAll('.update-btn').forEach(function(btn) {
        btn.addEventListener('click', function() {
            statusTarget = this.getAttribute('data-id');
            document.getElementById('statusModalSub').textContent = 'Test: ' + this.getAttribute('data-test');
            document.getElementById('updateStatus').value  = this.getAttribute('data-status')  || 'Pending';
            document.getElementById('updateResult').value  = this.getAttribute('data-result')  || '';
            document.getElementById('updateRemarks').value = this.getAttribute('data-remarks') || '';
            document.getElementById('statusModal').classList.add('open');
        });
    });
}

/* ─── LOAD REPORTS ─── */
function loadReports(searchTerm) {
    searchTerm = searchTerm || '';
    $.ajax({
        url: API_REPORTS + '?page=' + currentPage + '&size=' + pageSize,
        type: 'GET',
        success: function(response) {
            allReports = response.content || [];
            totalPages = response.totalPages || 1;

            var filtered = allReports;

            /* Filter by status chip or Critical result */
            if (activeFilter === 'Critical') {
                filtered = filtered.filter(function(r) {
                    return (r.result || '').toLowerCase() === 'critical';
                });
            } else if (activeFilter !== 'all') {
                filtered = filtered.filter(function(r) {
                    return (r.status || '').toLowerCase() === activeFilter.toLowerCase();
                });
            }

            /* Search by test name or patient name */
            if (searchTerm) {
                filtered = filtered.filter(function(r) {
                    var q = searchTerm.toLowerCase();
                    return (r.testName || '').toLowerCase().indexOf(q) !== -1 ||
                           getPatientName(r).toLowerCase().indexOf(q) !== -1;
                });
            }

            if (isGridView) renderGrid(filtered);
            else            renderTable(filtered);

            /* Stats */
            var total     = response.totalElements || allReports.length;
            var pending   = 0; var completed = 0; var cancelled = 0; var critical = 0;
            for (var i = 0; i < allReports.length; i++) {
                var r = allReports[i];
                var sl = (r.status || '').toLowerCase();
                if (sl === 'pending')   pending++;
                if (sl === 'completed') completed++;
                if (sl === 'cancelled') cancelled++;
                if ((r.result || '').toLowerCase() === 'critical') critical++;
            }

            document.getElementById('statTotal').textContent     = total;
            document.getElementById('totalCount').textContent    = total;
            document.getElementById('statPending').textContent   = pending;
            document.getElementById('statCompleted').textContent = completed;
            document.getElementById('statCritical').textContent  = critical;
            document.getElementById('statCancelled').textContent = cancelled;

            document.getElementById('pageInfo').textContent =
                'Page ' + (currentPage + 1) + ' of ' + totalPages + '  \u00b7  ' + total + ' total';
            document.getElementById('prevBtn').disabled = currentPage === 0;
            document.getElementById('nextBtn').disabled = currentPage >= totalPages - 1;
        },
        error: function() { toast('Failed to load reports.', 'error'); }
    });
}

/* ─── REQUEST LAB TEST ─── */
$('#labForm').submit(function(e) {
    e.preventDefault();

    var patientIdVal = document.getElementById('patientId').value;
    if (!patientIdVal) { toast('Please select a patient.', 'error'); return; }

    var btn = document.getElementById('addBtn');
    btn.disabled = true;
    btn.innerHTML = '<i class="bi bi-hourglass-split"></i> Saving...';

    var data = {
        testName:   document.getElementById('testName').value.trim(),
        reportDate: document.getElementById('reportDate').value,
        status:     document.getElementById('labStatus').value,
        result:     document.getElementById('labResult').value,
        remarks:    document.getElementById('labRemarks').value.trim(),
        patient:    { id: parseInt(patientIdVal, 10) }
    };

    $.ajax({
        url: API_REPORTS,
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function() {
            document.getElementById('labForm').reset();
            /* reset date to today */
            var now = new Date();
            var y = now.getFullYear();
            var m = String(now.getMonth() + 1).padStart(2, '0');
            var d = String(now.getDate()).padStart(2, '0');
            document.getElementById('reportDate').value = y + '-' + m + '-' + d;
            currentPage = 0;
            loadReports();
            toast('Lab test requested!');
        },
        error: function() { toast('Failed to create report.', 'error'); },
        complete: function() {
            btn.disabled = false;
            btn.innerHTML = '<i class="bi bi-clipboard2-plus-fill"></i> Request Test';
        }
    });
});

/* ─── DELETE ─── */
document.getElementById('deleteCancelBtn').onclick = function() {
    document.getElementById('deleteModal').classList.remove('open');
    deleteTarget = null;
};

document.getElementById('deleteConfirmBtn').onclick = function() {
    if (!deleteTarget) return;
    var id = deleteTarget;
    document.getElementById('deleteModal').classList.remove('open');
    $.ajax({
        url: API_REPORTS + '/' + id,
        type: 'DELETE',
        success: function() {
            toast('Report deleted.');
            if (allReports.length === 1 && currentPage > 0) currentPage--;
            loadReports();
        },
        error: function() { toast('Delete failed.', 'error'); }
    });
    deleteTarget = null;
};

/* ─── UPDATE STATUS ─── */
document.getElementById('statusCancelBtn').onclick = function() {
    document.getElementById('statusModal').classList.remove('open');
    statusTarget = null;
};

document.getElementById('saveStatusBtn').onclick = function() {
    if (!statusTarget) return;
    var id      = statusTarget;
    var status  = document.getElementById('updateStatus').value;
    var result  = document.getElementById('updateResult').value;
    var remarks = document.getElementById('updateRemarks').value.trim();

    document.getElementById('statusModal').classList.remove('open');

    var url = API_REPORTS + '/' + id + '/status?status=' + encodeURIComponent(status);
    if (result)  url += '&result='  + encodeURIComponent(result);
    if (remarks) url += '&remarks=' + encodeURIComponent(remarks);

    $.ajax({
        url: url,
        type: 'PATCH',
        success: function() {
            toast('Report updated!');
            loadReports(document.getElementById('searchInput').value);
        },
        error: function() { toast('Update failed.', 'error'); }
    });
    statusTarget = null;
};

/* close modals on overlay click */
document.getElementById('deleteModal').onclick = function(e) {
    if (e.target === this) { this.classList.remove('open'); deleteTarget = null; }
};
document.getElementById('statusModal').onclick = function(e) {
    if (e.target === this) { this.classList.remove('open'); statusTarget = null; }
};

/* ─── VIEW TOGGLE ─── */
document.getElementById('gridViewBtn').onclick = function() {
    isGridView = true;
    this.classList.add('active');
    document.getElementById('listViewBtn').classList.remove('active');
    document.getElementById('gridView').style.display = 'block';
    document.getElementById('listView').style.display = 'none';
    loadReports(document.getElementById('searchInput').value);
};

document.getElementById('listViewBtn').onclick = function() {
    isGridView = false;
    this.classList.add('active');
    document.getElementById('gridViewBtn').classList.remove('active');
    document.getElementById('gridView').style.display = 'none';
    document.getElementById('listView').style.display = 'block';
    loadReports(document.getElementById('searchInput').value);
};

/* ─── FILTER CHIPS ─── */
document.querySelectorAll('.chip').forEach(function(chip) {
    chip.addEventListener('click', function() {
        document.querySelectorAll('.chip').forEach(function(c) { c.classList.remove('active'); });
        this.classList.add('active');
        activeFilter = this.getAttribute('data-filter');
        currentPage  = 0;
        loadReports(document.getElementById('searchInput').value);
    });
});

/* ─── SEARCH ─── */
var searchTimer;
document.getElementById('searchInput').addEventListener('input', function() {
    clearTimeout(searchTimer);
    var val = this.value.trim();
    searchTimer = setTimeout(function() { loadReports(val); }, 280);
});

/* ─── PAGINATION ─── */
document.getElementById('prevBtn').onclick = function() {
    if (currentPage > 0) { currentPage--; loadReports(); }
};
document.getElementById('nextBtn').onclick = function() {
    if (currentPage < totalPages - 1) { currentPage++; loadReports(); }
};

/* ─── INIT ─── */
$(document).ready(function() {
    loadPatients();
    loadReports();
});
</script>

</body>
</html>
