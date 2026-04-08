<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MediCore | Billing</title>

<link href="https://fonts.googleapis.com/css2?family=Instrument+Serif:ital@0;1&family=Sora:wght@300;400;500;600&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="/css/medicore.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
/* ── BILLING PAGE STYLES (dark theme) ── */

.invoice-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
    gap: 1rem;
    padding: 1.2rem;
}

.invoice-card {
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

.invoice-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0; height: 2px;
    border-radius: 2px 2px 0 0;
}

.invoice-card.status-paid::before    { background: #10b981; }
.invoice-card.status-unpaid::before  { background: #ef4444; }
.invoice-card.status-pending::before { background: #f59e0b; }

.invoice-card:hover {
    transform: translateY(-3px);
    border-color: rgba(0,212,255,.3);
    box-shadow: 0 8px 30px rgba(0,0,0,.4);
}

.inv-icon {
    width: 38px; height: 38px;
    border-radius: 9px;
    display: flex; align-items: center; justify-content: center;
    font-size: 1rem; flex-shrink: 0;
}

.icon-paid    { background: rgba(16,185,129,.15); color: #6ee7b7; }
.icon-unpaid  { background: rgba(239,68,68,.15);  color: #fca5a5; }
.icon-pending { background: rgba(245,158,11,.15); color: #fcd34d; }

.inv-amount {
    font-family: 'Instrument Serif', serif;
    font-size: 1.5rem;
    color: var(--text);
    line-height: 1;
}

.inv-desc {
    font-size: .82rem; font-weight: 600; color: var(--text);
    white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}

.inv-patient {
    font-size: .72rem; color: var(--muted);
    display: flex; align-items: center; gap: .3rem;
}

.inv-meta {
    font-size: .68rem; color: var(--muted);
    display: flex; align-items: center; gap: .5rem; flex-wrap: wrap;
}

.status-badge-inv {
    display: inline-flex; align-items: center; gap: .25rem;
    font-size: .68rem; font-weight: 600;
    padding: .18rem .55rem; border-radius: 20px;
}

.badge-paid    { background: rgba(16,185,129,.15); color: #6ee7b7; border: 1px solid rgba(16,185,129,.3); }
.badge-unpaid  { background: rgba(239,68,68,.15);  color: #fca5a5; border: 1px solid rgba(239,68,68,.3); }
.badge-pending { background: rgba(245,158,11,.15); color: #fcd34d; border: 1px solid rgba(245,158,11,.3); }

.mode-badge {
    display: inline-flex; align-items: center; gap: .2rem;
    font-size: .65rem; padding: .12rem .45rem; border-radius: 20px;
    background: rgba(0,212,255,.08); color: var(--accent);
    border: 1px solid rgba(0,212,255,.2);
}

.inv-actions { display: flex; gap: .45rem; justify-content: flex-end; }

.btn-mark-paid {
    padding: .32rem .7rem;
    background: rgba(16,185,129,.12);
    color: #6ee7b7;
    border: 1px solid rgba(16,185,129,.3);
    border-radius: 7px;
    font-size: .7rem; font-weight: 600;
    font-family: 'Sora', sans-serif;
    cursor: pointer;
    display: inline-flex; align-items: center; gap: .3rem;
    transition: background .2s;
}

.btn-mark-paid:hover { background: rgba(16,185,129,.25); }

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

/* field overrides */
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

/* Mark paid modal */
.modal-box.wide { width: 380px; text-align: left; }
.modal-box.wide .modal-icon { background: rgba(16,185,129,.15); color: #6ee7b7; margin-bottom: .8rem; }

.pay-form-input {
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
    margin-bottom: 1rem;
    appearance: none;
}

.pay-form-input:focus { border-color: var(--accent); }
select.pay-form-input option { background: #151d2e; color: var(--text); }

.btn-confirm-pay {
    width: 100%;
    padding: .7rem;
    background: #10b981;
    color: #fff;
    border: none;
    border-radius: 8px;
    font-family: 'Sora', sans-serif;
    font-size: .85rem; font-weight: 700;
    cursor: pointer;
    margin-bottom: .5rem;
    transition: opacity .2s;
}

.btn-confirm-pay:hover { opacity: .85; }
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
            <span>Billing</span>
        </div>
    </div>
</nav>

<div class="page-wrap">

    <!-- Header -->
    <div class="page-header">
        <div class="page-header-left">
            <h1>Manage <em>Billing</em></h1>
            <p style="font-size:.82rem;color:var(--muted);">Generate invoices, track payments, and manage patient billing records.</p>
        </div>
        <div id="totalBadge"
            style="background:rgba(0,212,255,.1);color:var(--accent);border:1px solid rgba(0,212,255,.2);display:flex;align-items:center;gap:.5rem;padding:.5rem 1rem;border-radius:30px;font-size:.78rem;font-weight:600;">
            <i class="bi bi-receipt-cutoff"></i>
            <span id="totalCount">-</span> invoices
        </div>
    </div>

    <!-- Stats -->
    <div class="row g-3 mb-4">
        <div class="col-md">
            <div class="card bg-dark text-white shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <small class="text-secondary">Total Invoices</small>
                        <i class="bi bi-receipt text-info"></i>
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
                        <small class="text-secondary">Total Revenue</small>
                        <i class="bi bi-currency-rupee text-success"></i>
                    </div>
                    <h4 class="fw-bold mt-2" id="statRevenue">-</h4>
                    <small class="text-secondary">paid invoices</small>
                </div>
            </div>
        </div>
        <div class="col-md">
            <div class="card bg-dark text-white shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <small class="text-secondary">Unpaid</small>
                        <i class="bi bi-x-circle text-danger"></i>
                    </div>
                    <h4 class="fw-bold mt-2" id="statUnpaid">-</h4>
                    <small class="text-secondary">pending payment</small>
                </div>
            </div>
        </div>
        <div class="col-md">
            <div class="card bg-dark text-white shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <small class="text-secondary">Paid</small>
                        <i class="bi bi-check-circle text-success"></i>
                    </div>
                    <h4 class="fw-bold mt-2" id="statPaid">-</h4>
                    <small class="text-secondary">cleared</small>
                </div>
            </div>
        </div>
        <div class="col-md">
            <div class="card bg-dark text-white shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <small class="text-secondary">Outstanding</small>
                        <i class="bi bi-exclamation-triangle text-warning"></i>
                    </div>
                    <h4 class="fw-bold mt-2" id="statOutstanding">-</h4>
                    <small class="text-secondary">unpaid amount</small>
                </div>
            </div>
        </div>
    </div>

    <div class="two-col">

        <!-- GENERATE INVOICE FORM -->
        <div class="panel">
            <div class="panel-head" style="display:flex;align-items:center;justify-content:space-between;padding:.9rem 1.1rem;">
                <span class="panel-title">Generate Invoice</span>
                <i class="bi bi-receipt-cutoff" style="color:var(--accent);"></i>
            </div>
            <div class="panel-body" style="padding:1.1rem;">
                <form id="invoiceForm" autocomplete="off">

                    <div class="field-group">
                        <label class="field-label">Patient</label>
                        <div class="field-wrap">
                            <i class="bi bi-person field-icon"></i>
                            <select id="patientId" class="field-input" required>
                                <option value="">Loading patients...</option>
                            </select>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Description</label>
                        <div class="field-wrap">
                            <i class="bi bi-card-text field-icon"></i>
                            <input type="text" id="invDesc" class="field-input"
                                placeholder="e.g. Consultation + Lab Tests"
                                list="descSuggestions" required>
                            <datalist id="descSuggestions">
                                <option value="Doctor Consultation">
                                <option value="Lab Tests">
                                <option value="Medicine Charges">
                                <option value="Consultation + Lab Tests">
                                <option value="Consultation + Medicine">
                                <option value="Surgery Charges">
                                <option value="Room Charges">
                                <option value="Emergency Services">
                                <option value="Physiotherapy">
                                <option value="Full Package">
                            </datalist>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Amount (Rs.)</label>
                        <div class="field-wrap">
                            <i class="bi bi-currency-rupee field-icon"></i>
                            <input type="number" id="invAmount" class="field-input"
                                placeholder="e.g. 1500" min="0" step="0.01" required>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Invoice Date</label>
                        <div class="field-wrap">
                            <i class="bi bi-calendar3 field-icon"></i>
                            <input type="date" id="invDate" class="field-input" required>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Status</label>
                        <div class="field-wrap">
                            <i class="bi bi-activity field-icon"></i>
                            <select id="invStatus" class="field-input" required>
                                <option value="Unpaid">Unpaid</option>
                                <option value="Paid">Paid</option>
                                <option value="Pending">Pending</option>
                            </select>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Payment Mode</label>
                        <div class="field-wrap">
                            <i class="bi bi-credit-card field-icon"></i>
                            <select id="invPayMode" class="field-input">
                                <option value="">Select Mode</option>
                                <option value="Cash">Cash</option>
                                <option value="Card">Card</option>
                                <option value="UPI">UPI</option>
                                <option value="Insurance">Insurance</option>
                            </select>
                        </div>
                    </div>

                    <button type="submit" class="btn-add" id="addBtn"
                        style="background:var(--accent);color:#000;font-weight:700;">
                        <i class="bi bi-receipt-cutoff"></i>
                        Generate Invoice
                    </button>
                </form>
            </div>
        </div>

        <!-- INVOICE LIST -->
        <div class="table-panel">
            <div class="table-head-bar" style="display:flex;align-items:center;justify-content:space-between;padding:1rem 1.2rem;flex-wrap:wrap;gap:.7rem;">
                <span class="panel-title">Invoice Directory</span>
                <div style="display:flex;align-items:center;gap:.7rem;flex-wrap:wrap;">
                    <div class="search-wrap">
                        <i class="bi bi-search search-icon"></i>
                        <input type="text" id="searchInput" class="search-input" placeholder="Search patient or description...">
                    </div>
                    <div class="view-toggle">
                        <button class="view-btn active" id="gridViewBtn" title="Card view"><i class="bi bi-grid-3x3-gap-fill"></i></button>
                        <button class="view-btn" id="listViewBtn" title="List view"><i class="bi bi-list-ul"></i></button>
                    </div>
                </div>
            </div>

            <!-- Filter chips -->
            <div style="padding:.7rem 1.2rem .2rem;border-bottom:1px solid var(--border);">
                <div class="filter-chips">
                    <button class="chip active" data-filter="all">All</button>
                    <button class="chip" data-filter="Unpaid"><i class="bi bi-x-circle"></i> Unpaid</button>
                    <button class="chip" data-filter="Paid"><i class="bi bi-check-circle"></i> Paid</button>
                    <button class="chip" data-filter="Pending"><i class="bi bi-hourglass-split"></i> Pending</button>
                </div>
            </div>

            <!-- CARD VIEW -->
            <div id="gridView">
                <div class="invoice-grid" id="invoiceGrid">
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
                            <th>Description</th>
                            <th>Amount</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th style="text-align:right;">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="invoiceTableBody"></tbody>
                </table>
            </div>

            <!-- EMPTY STATE -->
            <div class="empty-state" id="emptyState" style="display:none;">
                <i class="bi bi-receipt"></i>
                <p>No invoices found. Generate one using the form.</p>
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

<!-- DELETE MODAL -->
<div class="modal-overlay" id="deleteModal">
    <div class="modal-box">
        <div class="modal-icon"><i class="bi bi-trash3-fill"></i></div>
        <p class="modal-title">Delete Invoice?</p>
        <p class="modal-sub">This will permanently remove the invoice record.</p>
        <div class="modal-actions">
            <button class="btn-cancel" id="deleteCancelBtn">Cancel</button>
            <button class="btn-confirm-del" id="deleteConfirmBtn">Yes, Delete</button>
        </div>
    </div>
</div>

<!-- MARK PAID MODAL -->
<div class="modal-overlay" id="payModal">
    <div class="modal-box wide">
        <div class="modal-icon"><i class="bi bi-check-circle-fill"></i></div>
        <p class="modal-title">Mark as Paid</p>
        <p class="modal-sub" id="payModalSub">Select payment mode to confirm.</p>
        <label style="font-size:.7rem;font-weight:600;text-transform:uppercase;letter-spacing:.08em;color:var(--muted);display:block;margin-bottom:.4rem;">Payment Mode</label>
        <select id="payModeSelect" class="pay-form-input">
            <option value="Cash">Cash</option>
            <option value="Card">Card</option>
            <option value="UPI">UPI</option>
            <option value="Insurance">Insurance</option>
        </select>
        <button class="btn-confirm-pay" id="confirmPayBtn">Confirm Payment</button>
        <button class="btn-cancel" id="payCancelBtn" style="width:100%;">Cancel</button>
    </div>
</div>

<div class="toast-wrap" id="toastWrap"></div>

<script>
/*
 * JSP RULE: No template literals, no arrow functions, no const/let.
 * Invoice fields: id, description, amount, invoiceDate, status, paymentMode
 * Nested: patient { id, name }
 */

var API_INVOICES = "/api/v1/invoices";
var API_PATIENTS = "/api/v1/patients";

var currentPage  = 0;
var pageSize     = 6;
var totalPages   = 0;
var allInvoices  = [];
var deleteTarget = null;
var payTarget    = null;
var isGridView   = true;
var activeFilter = "all";

/* ─── SET TODAY DATE ─── */
(function() {
    var now = new Date();
    var y = now.getFullYear();
    var m = String(now.getMonth() + 1).padStart(2, '0');
    var d = String(now.getDate()).padStart(2, '0');
    document.getElementById('invDate').value = y + '-' + m + '-' + d;
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

function getPatientName(inv) {
    if (inv.patient && inv.patient.name) return inv.patient.name;
    if (inv.patientName)                 return inv.patientName;
    return 'Unknown Patient';
}

function statusKey(s) {
    var sl = (s || '').toLowerCase();
    if (sl === 'paid')    return 'paid';
    if (sl === 'pending') return 'pending';
    return 'unpaid';
}

function showEmpty(show) {
    document.getElementById('emptyState').style.display = show ? 'block' : 'none';
}

function fmtAmount(amt) {
    return 'Rs.' + parseFloat(amt).toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
}

/* ─── LOAD PATIENTS ─── */
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
        }
    });
}

/* ─── RENDER GRID ─── */
function renderGrid(invoices) {
    var grid = document.getElementById('invoiceGrid');
    if (!invoices.length) { showEmpty(true); grid.innerHTML = ''; return; }
    showEmpty(false);

    var html = '';
    for (var i = 0; i < invoices.length; i++) {
        var inv  = invoices[i];
        var sk   = statusKey(inv.status);
        var pat  = getPatientName(inv);
        var isPaid = sk === 'paid';

        html +=
            '<div class="invoice-card status-' + sk + '" style="animation-delay:' + (i * 0.05) + 's">' +
                '<div style="display:flex;align-items:center;gap:.7rem;">' +
                    '<div class="inv-icon icon-' + sk + '"><i class="bi bi-receipt-cutoff"></i></div>' +
                    '<div style="flex:1;min-width:0;">' +
                        '<div class="inv-desc">' + inv.description + '</div>' +
                        '<div class="inv-patient"><i class="bi bi-person"></i>' + pat + '</div>' +
                    '</div>' +
                    '<span class="status-badge-inv badge-' + sk + '">' + inv.status + '</span>' +
                '</div>' +
                '<div class="inv-amount">' + fmtAmount(inv.amount) + '</div>' +
                '<div class="inv-meta">' +
                    '<span><i class="bi bi-calendar3"></i> ' + formatDate(inv.invoiceDate) + '</span>' +
                    (inv.paymentMode ? '<span class="mode-badge"><i class="bi bi-credit-card"></i> ' + inv.paymentMode + '</span>' : '') +
                '</div>' +
                '<div class="inv-actions">' +
                    (!isPaid ?
                        '<button class="btn-mark-paid pay-btn" data-id="' + inv.id + '" data-pat="' + pat + '">' +
                            '<i class="bi bi-check-circle"></i> Mark Paid' +
                        '</button>' : '') +
                    '<button class="btn-del delete-btn" data-id="' + inv.id + '">' +
                        '<i class="bi bi-trash3"></i>' +
                    '</button>' +
                '</div>' +
                '<div style="font-size:.65rem;color:var(--muted);margin-top:.1rem;"># ' + padId(inv.id) + '</div>' +
            '</div>';
    }
    grid.innerHTML = html;
    attachEvents(grid);
}

/* ─── RENDER TABLE ─── */
function renderTable(invoices) {
    var tbody = document.getElementById('invoiceTableBody');
    if (!invoices.length) { showEmpty(true); tbody.innerHTML = ''; return; }
    showEmpty(false);

    var html = '';
    for (var i = 0; i < invoices.length; i++) {
        var inv = invoices[i];
        var sk  = statusKey(inv.status);
        var pat = getPatientName(inv);
        var isPaid = sk === 'paid';

        html +=
            '<tr>' +
                '<td style="color:var(--muted);font-size:.72rem;">#' + padId(inv.id) + '</td>' +
                '<td><i class="bi bi-person" style="color:var(--accent);margin-right:.3rem;"></i>' + pat + '</td>' +
                '<td>' + inv.description + '</td>' +
                '<td style="font-weight:600;color:#6ee7b7;">' + fmtAmount(inv.amount) + '</td>' +
                '<td style="font-size:.78rem;color:var(--muted);">' + formatDate(inv.invoiceDate) + '</td>' +
                '<td><span class="status-badge-inv badge-' + sk + '">' + inv.status + '</span></td>' +
                '<td style="text-align:right;">' +
                    (!isPaid ?
                        '<button class="btn-mark-paid pay-btn" data-id="' + inv.id + '" data-pat="' + pat + '" style="margin-right:.3rem;">' +
                            '<i class="bi bi-check-circle"></i>' +
                        '</button>' : '') +
                    '<button class="btn-del delete-btn" data-id="' + inv.id + '">' +
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

    container.querySelectorAll('.pay-btn').forEach(function(btn) {
        btn.addEventListener('click', function() {
            payTarget = this.getAttribute('data-id');
            document.getElementById('payModalSub').textContent = 'Patient: ' + this.getAttribute('data-pat');
            document.getElementById('payModal').classList.add('open');
        });
    });
}

/* ─── LOAD INVOICES ─── */
function loadInvoices(searchTerm) {
    searchTerm = searchTerm || '';
    $.ajax({
        url: API_INVOICES + '?page=' + currentPage + '&size=' + pageSize,
        type: 'GET',
        success: function(response) {
            allInvoices = response.content || [];
            totalPages  = response.totalPages || 1;

            var filtered = allInvoices;

            if (activeFilter !== 'all') {
                filtered = filtered.filter(function(inv) {
                    return (inv.status || '').toLowerCase() === activeFilter.toLowerCase();
                });
            }

            if (searchTerm) {
                filtered = filtered.filter(function(inv) {
                    var q = searchTerm.toLowerCase();
                    return (inv.description || '').toLowerCase().indexOf(q)  !== -1 ||
                           getPatientName(inv).toLowerCase().indexOf(q) !== -1;
                });
            }

            if (isGridView) renderGrid(filtered);
            else            renderTable(filtered);

            /* Stats */
            var total       = response.totalElements || allInvoices.length;
            var paid        = 0; var unpaid = 0; var revenue = 0; var outstanding = 0;
            for (var i = 0; i < allInvoices.length; i++) {
                var inv = allInvoices[i];
                var sl  = (inv.status || '').toLowerCase();
                if (sl === 'paid')   { paid++;    revenue     += parseFloat(inv.amount) || 0; }
                if (sl !== 'paid')   { unpaid++;  outstanding += parseFloat(inv.amount) || 0; }
            }

            document.getElementById('statTotal').textContent       = total;
            document.getElementById('totalCount').textContent      = total;
            document.getElementById('statRevenue').textContent     = fmtAmount(revenue);
            document.getElementById('statPaid').textContent        = paid;
            document.getElementById('statUnpaid').textContent      = unpaid;
            document.getElementById('statOutstanding').textContent = fmtAmount(outstanding);

            document.getElementById('pageInfo').textContent =
                'Page ' + (currentPage + 1) + ' of ' + totalPages + '  \u00b7  ' + total + ' total';
            document.getElementById('prevBtn').disabled = currentPage === 0;
            document.getElementById('nextBtn').disabled = currentPage >= totalPages - 1;
        },
        error: function() { toast('Failed to load invoices.', 'error'); }
    });
}

/* ─── GENERATE INVOICE ─── */
$('#invoiceForm').submit(function(e) {
    e.preventDefault();

    var patientIdVal = document.getElementById('patientId').value;
    if (!patientIdVal) { toast('Please select a patient.', 'error'); return; }

    var btn = document.getElementById('addBtn');
    btn.disabled = true;
    btn.innerHTML = '<i class="bi bi-hourglass-split"></i> Generating...';

    var data = {
        description: document.getElementById('invDesc').value.trim(),
        amount:      parseFloat(document.getElementById('invAmount').value),
        invoiceDate: document.getElementById('invDate').value,
        status:      document.getElementById('invStatus').value,
        paymentMode: document.getElementById('invPayMode').value,
        patient:     { id: parseInt(patientIdVal, 10) }
    };

    $.ajax({
        url: API_INVOICES,
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function() {
            document.getElementById('invoiceForm').reset();
            var now = new Date();
            document.getElementById('invDate').value =
                now.getFullYear() + '-' +
                String(now.getMonth()+1).padStart(2,'0') + '-' +
                String(now.getDate()).padStart(2,'0');
            currentPage = 0;
            loadInvoices();
            toast('Invoice generated!');
        },
        error: function() { toast('Failed to generate invoice.', 'error'); },
        complete: function() {
            btn.disabled = false;
            btn.innerHTML = '<i class="bi bi-receipt-cutoff"></i> Generate Invoice';
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
        url: API_INVOICES + '/' + id,
        type: 'DELETE',
        success: function() {
            toast('Invoice deleted.');
            if (allInvoices.length === 1 && currentPage > 0) currentPage--;
            loadInvoices();
        },
        error: function() { toast('Delete failed.', 'error'); }
    });
    deleteTarget = null;
};

/* ─── MARK PAID ─── */
document.getElementById('payCancelBtn').onclick = function() {
    document.getElementById('payModal').classList.remove('open');
    payTarget = null;
};

document.getElementById('confirmPayBtn').onclick = function() {
    if (!payTarget) return;
    var id   = payTarget;
    var mode = document.getElementById('payModeSelect').value;
    document.getElementById('payModal').classList.remove('open');

    /* First mark status Paid, then update paymentMode via PUT */
    $.ajax({
        url: API_INVOICES + '/' + id + '/status?status=Paid',
        type: 'PATCH',
        success: function() {
            toast('Payment confirmed!');
            loadInvoices(document.getElementById('searchInput').value);
        },
        error: function() { toast('Update failed.', 'error'); }
    });
    payTarget = null;
};

/* close on overlay click */
document.getElementById('deleteModal').onclick = function(e) {
    if (e.target === this) { this.classList.remove('open'); deleteTarget = null; }
};
document.getElementById('payModal').onclick = function(e) {
    if (e.target === this) { this.classList.remove('open'); payTarget = null; }
};

/* ─── VIEW TOGGLE ─── */
document.getElementById('gridViewBtn').onclick = function() {
    isGridView = true;
    this.classList.add('active');
    document.getElementById('listViewBtn').classList.remove('active');
    document.getElementById('gridView').style.display = 'block';
    document.getElementById('listView').style.display = 'none';
    loadInvoices(document.getElementById('searchInput').value);
};

document.getElementById('listViewBtn').onclick = function() {
    isGridView = false;
    this.classList.add('active');
    document.getElementById('gridViewBtn').classList.remove('active');
    document.getElementById('gridView').style.display = 'none';
    document.getElementById('listView').style.display = 'block';
    loadInvoices(document.getElementById('searchInput').value);
};

/* ─── FILTER CHIPS ─── */
document.querySelectorAll('.chip').forEach(function(chip) {
    chip.addEventListener('click', function() {
        document.querySelectorAll('.chip').forEach(function(c) { c.classList.remove('active'); });
        this.classList.add('active');
        activeFilter = this.getAttribute('data-filter');
        currentPage  = 0;
        loadInvoices(document.getElementById('searchInput').value);
    });
});

/* ─── SEARCH ─── */
var searchTimer;
document.getElementById('searchInput').addEventListener('input', function() {
    clearTimeout(searchTimer);
    var val = this.value.trim();
    searchTimer = setTimeout(function() { loadInvoices(val); }, 280);
});

/* ─── PAGINATION ─── */
document.getElementById('prevBtn').onclick = function() {
    if (currentPage > 0) { currentPage--; loadInvoices(); }
};
document.getElementById('nextBtn').onclick = function() {
    if (currentPage < totalPages - 1) { currentPage++; loadInvoices(); }
};

/* ─── INIT ─── */
$(document).ready(function() {
    loadPatients();
    loadInvoices();
});
</script>
</body>
</html>
