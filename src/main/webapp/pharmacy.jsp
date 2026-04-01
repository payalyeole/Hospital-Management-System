<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MediCore | Pharmacy</title>

<link href="https://fonts.googleapis.com/css2?family=Instrument+Serif:ital@0;1&family=Sora:wght@300;400;500;600&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="/css/medicore.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
/* ── PHARMACY PAGE STYLES (dark theme) ── */

/* Medicine cards grid */
.medicine-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(230px, 1fr));
    gap: 1rem;
    padding: 1.2rem;
}

.medicine-card {
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

.medicine-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 2px;
    border-radius: 2px 2px 0 0;
}

.medicine-card.stock-ok::before       { background: #10b981; }
.medicine-card.stock-low::before      { background: #f59e0b; }
.medicine-card.stock-critical::before { background: #ef4444; }

.medicine-card:hover {
    transform: translateY(-3px);
    border-color: rgba(0,212,255,.3);
    box-shadow: 0 8px 30px rgba(0,0,0,.4);
}

.med-icon {
    width: 38px; height: 38px;
    border-radius: 9px;
    display: flex; align-items: center; justify-content: center;
    font-size: 1rem;
    flex-shrink: 0;
}

.med-name {
    font-size: .9rem;
    font-weight: 600;
    color: var(--text);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.med-manufacturer {
    font-size: .7rem;
    color: var(--muted);
}

.med-price {
    font-family: 'Instrument Serif', serif;
    font-size: 1.1rem;
    color: var(--text);
}

.med-price span {
    font-size: .68rem;
    color: var(--muted);
    font-family: 'Sora', sans-serif;
}

/* Stock bar */
.stock-bar-wrap {
    height: 3px;
    background: rgba(255,255,255,.08);
    border-radius: 3px;
    overflow: hidden;
}

.stock-bar {
    height: 100%;
    border-radius: 3px;
    transition: width .4s;
}

.stock-bar.ok       { background: #10b981; }
.stock-bar.low      { background: #f59e0b; }
.stock-bar.critical { background: #ef4444; }

.stock-label { font-size: .7rem; font-weight: 600; }
.stock-label.ok       { color: #10b981; }
.stock-label.low      { color: #f59e0b; }
.stock-label.critical { color: #ef4444; }

.med-expiry {
    font-size: .68rem;
    color: var(--muted);
    display: flex; align-items: center; gap: .3rem;
}

.med-expiry.expired { color: #ef4444; font-weight: 600; }

.med-actions {
    display: flex; gap: .45rem; justify-content: flex-end;
}

/* Category tag */
.cat-tag {
    display: inline-flex; align-items: center;
    font-size: .68rem; font-weight: 600;
    padding: .15rem .5rem; border-radius: 20px;
    letter-spacing: .03em;
}

.cat-antibiotic  { background: rgba(239,68,68,.15);   color: #fca5a5; }
.cat-painkiller  { background: rgba(245,158,11,.15);  color: #fcd34d; }
.cat-vitamin     { background: rgba(16,185,129,.15);  color: #6ee7b7; }
.cat-antiviral   { background: rgba(124,58,237,.15);  color: #c4b5fd; }
.cat-antifungal  { background: rgba(236,72,153,.15);  color: #f9a8d4; }
.cat-antacid     { background: rgba(0,212,255,.12);   color: #67e8f9; }
.cat-default     { background: rgba(0,212,255,.1);    color: var(--accent); }

/* med icon bg */
.icon-antibiotic  { background: rgba(239,68,68,.15);  color: #fca5a5; }
.icon-painkiller  { background: rgba(245,158,11,.15); color: #fcd34d; }
.icon-vitamin     { background: rgba(16,185,129,.15); color: #6ee7b7; }
.icon-antiviral   { background: rgba(124,58,237,.15); color: #c4b5fd; }
.icon-antifungal  { background: rgba(236,72,153,.15); color: #f9a8d4; }
.icon-antacid     { background: rgba(0,212,255,.12);  color: #67e8f9; }
.icon-default     { background: rgba(0,212,255,.1);   color: var(--accent); }

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

/* Action buttons on cards */
.btn-stock {
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

.btn-stock:hover { background: rgba(16,185,129,.25); }

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

/* Stock edit modal */
.modal-box.wide { width: 400px; text-align: left; }
.modal-box.wide .modal-icon { background: rgba(0,212,255,.12); color: var(--accent); margin-bottom: .8rem; }

.stock-edit-wrap { display: flex; gap: .5rem; align-items: center; margin-bottom: 1rem; }

.stock-edit-input {
    flex: 1;
    padding: .6rem .9rem;
    border: 1px solid var(--border);
    border-radius: 8px;
    font-family: 'Sora', sans-serif;
    font-size: .85rem;
    color: var(--text);
    background: rgba(255,255,255,.04);
    outline: none;
    transition: border-color .2s;
}

.stock-edit-input:focus { border-color: var(--accent); }

.btn-save-stock {
    padding: .6rem 1rem;
    background: var(--accent);
    color: #000;
    border: none;
    border-radius: 8px;
    font-family: 'Sora', sans-serif;
    font-size: .82rem; font-weight: 700;
    cursor: pointer;
    transition: opacity .2s;
}

.btn-save-stock:hover { opacity: .85; }

/* Panel override for dark theme compatibility */
.panel-head { border-bottom: 1px solid var(--border); }
.table-head-bar { border-bottom: 1px solid var(--border); }

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
            <span>Pharmacy</span>
        </div>
    </div>
</nav>

<!-- ═══ PAGE ═══ -->
<div class="page-wrap">

    <!-- Header -->
    <div class="page-header">
        <div class="page-header-left">
            <h1>Manage <em>Pharmacy</em></h1>
            <p style="font-size:.82rem;color:var(--muted);">Track medicine inventory, stock levels, pricing and expiry dates.</p>
        </div>
        <div class="count-badge" id="totalBadge"
            style="background:rgba(0,212,255,.1);color:var(--accent);border:1px solid rgba(0,212,255,.2);display:flex;align-items:center;gap:.5rem;padding:.5rem 1rem;border-radius:30px;font-size:.78rem;font-weight:600;">
            <i class="bi bi-capsule-pill"></i>
            <span id="totalCount">-</span> medicines
        </div>
    </div>

    <!-- Stats — Bootstrap dark cards (same style as patient.jsp) -->
    <div class="row g-3 mb-4">
        <div class="col-md">
            <div class="card bg-dark text-white shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <small class="text-secondary">Total Items</small>
                        <i class="bi bi-capsule-pill text-info"></i>
                    </div>
                    <h4 class="fw-bold mt-2" id="statTotal">-</h4>
                    <small class="text-secondary">in inventory</small>
                </div>
            </div>
        </div>
        <div class="col-md">
            <div class="card bg-dark text-white shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <small class="text-secondary">In Stock</small>
                        <i class="bi bi-check-circle text-success"></i>
                    </div>
                    <h4 class="fw-bold mt-2" id="statInStock">-</h4>
                    <small class="text-secondary">qty above 20</small>
                </div>
            </div>
        </div>
        <div class="col-md">
            <div class="card bg-dark text-white shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <small class="text-secondary">Low Stock</small>
                        <i class="bi bi-exclamation-triangle text-warning"></i>
                    </div>
                    <h4 class="fw-bold mt-2" id="statLow">-</h4>
                    <small class="text-secondary">qty 1 to 20</small>
                </div>
            </div>
        </div>
        <div class="col-md">
            <div class="card bg-dark text-white shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <small class="text-secondary">Out of Stock</small>
                        <i class="bi bi-x-circle text-danger"></i>
                    </div>
                    <h4 class="fw-bold mt-2" id="statOut">-</h4>
                    <small class="text-secondary">qty = 0</small>
                </div>
            </div>
        </div>
        <div class="col-md">
            <div class="card bg-dark text-white shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <small class="text-secondary">Expired</small>
                        <i class="bi bi-calendar-x text-danger"></i>
                    </div>
                    <h4 class="fw-bold mt-2" id="statExpired">-</h4>
                    <small class="text-secondary">past expiry</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Two-col -->
    <div class="two-col">

        <!-- ADD FORM -->
        <div class="panel">
            <div class="panel-head" style="display:flex;align-items:center;justify-content:space-between;padding:.9rem 1.1rem;">
                <span class="panel-title">Add Medicine</span>
                <i class="bi bi-plus-circle" style="color:var(--accent);"></i>
            </div>
            <div class="panel-body" style="padding:1.1rem;">
                <form id="medicineForm" autocomplete="off">

                    <div class="field-group">
                        <label class="field-label">Medicine Name</label>
                        <div class="field-wrap">
                            <i class="bi bi-capsule field-icon"></i>
                            <input type="text" id="medName" class="field-input" placeholder="e.g. Amoxicillin 500mg" required>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Category</label>
                        <div class="field-wrap">
                            <i class="bi bi-tag field-icon"></i>
                            <input type="text" id="medCategory" class="field-input"
                                placeholder="e.g. Antibiotic" list="catSuggestions" required>
                            <datalist id="catSuggestions">
                                <option value="Antibiotic">
                                <option value="Painkiller">
                                <option value="Vitamin">
                                <option value="Antiviral">
                                <option value="Antifungal">
                                <option value="Antacid">
                                <option value="Antihistamine">
                                <option value="Steroid">
                                <option value="Vaccine">
                            </datalist>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Manufacturer</label>
                        <div class="field-wrap">
                            <i class="bi bi-building field-icon"></i>
                            <input type="text" id="medManufacturer" class="field-input" placeholder="e.g. Sun Pharma" required>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Quantity (units)</label>
                        <div class="field-wrap">
                            <i class="bi bi-boxes field-icon"></i>
                            <input type="number" id="medQuantity" class="field-input" placeholder="e.g. 100" min="0" required>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Price per unit (Rs.)</label>
                        <div class="field-wrap">
                            <i class="bi bi-currency-rupee field-icon"></i>
                            <input type="number" id="medPrice" class="field-input" placeholder="e.g. 12.50" min="0" step="0.01" required>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label">Expiry Date</label>
                        <div class="field-wrap">
                            <i class="bi bi-calendar-x field-icon"></i>
                            <input type="date" id="medExpiry" class="field-input" required>
                        </div>
                    </div>

                    <button type="submit" class="btn-add" id="addBtn"
                        style="background:var(--accent);color:#000;font-weight:700;">
                        <i class="bi bi-plus-circle-fill"></i>
                        Add Medicine
                    </button>
                </form>
            </div>
        </div>

        <!-- MEDICINE LIST -->
        <div class="table-panel">
            <div class="table-head-bar" style="display:flex;align-items:center;justify-content:space-between;padding:1rem 1.2rem;flex-wrap:wrap;gap:.7rem;">
                <span class="panel-title">Medicine Inventory</span>
                <div style="display:flex;align-items:center;gap:.7rem;flex-wrap:wrap;">
                    <div class="search-wrap">
                        <i class="bi bi-search search-icon"></i>
                        <input type="text" id="searchInput" class="search-input" placeholder="Search medicines...">
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
                    <button class="chip" data-filter="Antibiotic">Antibiotic</button>
                    <button class="chip" data-filter="Painkiller">Painkiller</button>
                    <button class="chip" data-filter="Vitamin">Vitamin</button>
                    <button class="chip" data-filter="Antiviral">Antiviral</button>
                    <button class="chip" data-filter="low-stock"><i class="bi bi-exclamation-triangle"></i> Low Stock</button>
                </div>
            </div>

            <!-- CARD VIEW -->
            <div id="gridView">
                <div class="medicine-grid" id="medicineGrid">
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
                            <th>Name</th>
                            <th>Category</th>
                            <th>Qty</th>
                            <th>Price</th>
                            <th>Expiry</th>
                            <th style="text-align:right;">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="medicineTableBody"></tbody>
                </table>
            </div>

            <!-- EMPTY STATE -->
            <div class="empty-state" id="emptyState" style="display:none;">
                <i class="bi bi-capsule"></i>
                <p>No medicines found. Add one using the form.</p>
            </div>

            <!-- PAGINATION -->
            <div class="pagination-bar" style="display:flex;align-items:center;justify-content:space-between;padding:1rem 1.2rem;border-top:1px solid var(--border);">
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
        <p class="modal-title">Remove Medicine?</p>
        <p class="modal-sub">This will permanently delete the medicine from inventory.</p>
        <div class="modal-actions">
            <button class="btn-cancel" id="deleteCancelBtn">Cancel</button>
            <button class="btn-confirm-del" id="deleteConfirmBtn">Yes, Delete</button>
        </div>
    </div>
</div>

<!-- ═══ STOCK MODAL ═══ -->
<div class="modal-overlay" id="stockModal">
    <div class="modal-box wide">
        <div class="modal-icon"><i class="bi bi-boxes"></i></div>
        <p class="modal-title">Update Stock</p>
        <p class="modal-sub" id="stockModalSub">Set new quantity for this medicine.</p>
        <div class="stock-edit-wrap">
            <input type="number" id="stockQtyInput" class="stock-edit-input" min="0" placeholder="New quantity">
            <button class="btn-save-stock" id="saveStockBtn">Update</button>
        </div>
        <button class="btn-cancel" id="stockCancelBtn" style="width:100%;margin-top:.2rem;">Cancel</button>
    </div>
</div>

<!-- ═══ TOAST ═══ -->
<div class="toast-wrap" id="toastWrap"></div>

<script>
/*
 * JSP RULE: No template literals, no arrow functions, no const/let.
 * Fields: id, name, category, manufacturer, quantity, price, expiryDate
 */

var API_URL      = "/api/v1/medicines";
var currentPage  = 0;
var pageSize     = 6;
var totalPages   = 0;
var allMedicines = [];
var deleteTarget = null;
var stockTarget  = null;
var isGridView   = true;
var activeFilter = "all";

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

function stockStatus(qty) {
    if (qty === 0) return 'critical';
    if (qty <= 20) return 'low';
    return 'ok';
}

function stockBarWidth(qty) {
    return Math.min(Math.round((qty / 200) * 100), 100);
}

function catKey(cat) {
    var c = (cat || '').toLowerCase();
    if (c === 'antibiotic')  return 'antibiotic';
    if (c === 'painkiller')  return 'painkiller';
    if (c === 'vitamin')     return 'vitamin';
    if (c === 'antiviral')   return 'antiviral';
    if (c === 'antifungal')  return 'antifungal';
    if (c === 'antacid')     return 'antacid';
    return 'default';
}

function isExpired(dateStr) {
    if (!dateStr) return false;
    return new Date(dateStr) < new Date();
}

function formatExpiry(dateStr) {
    if (!dateStr) return '-';
    var parts = dateStr.split('-');
    if (parts.length < 3) return dateStr;
    var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return parts[2] + ' ' + (months[parseInt(parts[1],10)-1] || parts[1]) + ' ' + parts[0];
}

function showEmpty(show) {
    document.getElementById('emptyState').style.display = show ? 'block' : 'none';
}

/* ─── RENDER GRID ─── */
function renderGrid(medicines) {
    var grid = document.getElementById('medicineGrid');
    if (!medicines.length) { showEmpty(true); grid.innerHTML = ''; return; }
    showEmpty(false);

    var html = '';
    for (var i = 0; i < medicines.length; i++) {
        var m       = medicines[i];
        var status  = stockStatus(m.quantity);
        var ck      = catKey(m.category);
        var barW    = stockBarWidth(m.quantity);
        var expired = isExpired(m.expiryDate);

        html +=
            '<div class="medicine-card stock-' + status + '" style="animation-delay:' + (i * 0.05) + 's">' +
                '<div style="display:flex;align-items:center;gap:.7rem;">' +
                    '<div class="med-icon icon-' + ck + '"><i class="bi bi-capsule-pill"></i></div>' +
                    '<div style="flex:1;min-width:0;">' +
                        '<div class="med-name">' + m.name + '</div>' +
                        '<div class="med-manufacturer">' + m.manufacturer + '</div>' +
                    '</div>' +
                    '<span class="cat-tag cat-' + ck + '">' + m.category + '</span>' +
                '</div>' +
                '<div class="stock-bar-wrap"><div class="stock-bar ' + status + '" style="width:' + barW + '%"></div></div>' +
                '<div style="display:flex;align-items:center;justify-content:space-between;">' +
                    '<span class="stock-label ' + status + '"><i class="bi bi-box-seam"></i> ' + m.quantity + ' units</span>' +
                    '<div class="med-price">Rs.' + m.price.toFixed(2) + ' <span>/unit</span></div>' +
                '</div>' +
                '<div class="med-expiry' + (expired ? ' expired' : '') + '">' +
                    '<i class="bi bi-calendar' + (expired ? '-x' : '-check') + '"></i>' +
                    (expired ? 'Expired: ' : 'Expires: ') + formatExpiry(m.expiryDate) +
                '</div>' +
                '<div class="med-actions">' +
                    '<button class="btn-stock stock-btn" data-id="' + m.id + '" data-name="' + m.name + '" data-qty="' + m.quantity + '">' +
                        '<i class="bi bi-pencil-square"></i> Stock' +
                    '</button>' +
                    '<button class="btn-del delete-btn" data-id="' + m.id + '">' +
                        '<i class="bi bi-trash3"></i>' +
                    '</button>' +
                '</div>' +
                '<div style="font-size:.65rem;color:var(--muted);margin-top:.1rem;"># ' + padId(m.id) + '</div>' +
            '</div>';
    }
    grid.innerHTML = html;
    attachEvents(grid);
}

/* ─── RENDER TABLE ─── */
function renderTable(medicines) {
    var tbody = document.getElementById('medicineTableBody');
    if (!medicines.length) { showEmpty(true); tbody.innerHTML = ''; return; }
    showEmpty(false);

    var html = '';
    for (var i = 0; i < medicines.length; i++) {
        var m       = medicines[i];
        var status  = stockStatus(m.quantity);
        var ck      = catKey(m.category);
        var expired = isExpired(m.expiryDate);

        html +=
            '<tr>' +
                '<td style="color:var(--muted);font-size:.72rem;">#' + padId(m.id) + '</td>' +
                '<td><strong>' + m.name + '</strong><br><span style="font-size:.7rem;color:var(--muted);">' + m.manufacturer + '</span></td>' +
                '<td><span class="cat-tag cat-' + ck + '">' + m.category + '</span></td>' +
                '<td><span class="stock-label ' + status + '">' + m.quantity + '</span></td>' +
                '<td>Rs.' + m.price.toFixed(2) + '</td>' +
                '<td style="' + (expired ? 'color:#ef4444;font-weight:600;' : 'color:var(--muted);') + 'font-size:.78rem;">' + formatExpiry(m.expiryDate) + '</td>' +
                '<td style="text-align:right;">' +
                    '<button class="btn-stock stock-btn" data-id="' + m.id + '" data-name="' + m.name + '" data-qty="' + m.quantity + '" style="margin-right:.3rem;">' +
                        '<i class="bi bi-pencil-square"></i>' +
                    '</button>' +
                    '<button class="btn-del delete-btn" data-id="' + m.id + '">' +
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

    container.querySelectorAll('.stock-btn').forEach(function(btn) {
        btn.addEventListener('click', function() {
            stockTarget = this.getAttribute('data-id');
            document.getElementById('stockModalSub').textContent = 'Update stock for: ' + this.getAttribute('data-name');
            document.getElementById('stockQtyInput').value = this.getAttribute('data-qty');
            document.getElementById('stockModal').classList.add('open');
        });
    });
}

/* ─── LOAD MEDICINES ─── */
function loadMedicines(searchTerm) {
    searchTerm = searchTerm || '';
    $.ajax({
        url: API_URL + '?page=' + currentPage + '&size=' + pageSize,
        type: 'GET',
        success: function(response) {
            allMedicines = response.content || [];
            totalPages   = response.totalPages || 1;

            var filtered = allMedicines;

            if (activeFilter === 'low-stock') {
                filtered = filtered.filter(function(m) { return m.quantity <= 20; });
            } else if (activeFilter !== 'all') {
                filtered = filtered.filter(function(m) {
                    return (m.category || '').toLowerCase() === activeFilter.toLowerCase();
                });
            }

            if (searchTerm) {
                filtered = filtered.filter(function(m) {
                    var q = searchTerm.toLowerCase();
                    return (m.name         || '').toLowerCase().indexOf(q) !== -1 ||
                           (m.category     || '').toLowerCase().indexOf(q) !== -1 ||
                           (m.manufacturer || '').toLowerCase().indexOf(q) !== -1;
                });
            }

            if (isGridView) renderGrid(filtered);
            else            renderTable(filtered);

            /* Stats */
            var total    = response.totalElements || allMedicines.length;
            var inStock  = 0; var lowStock = 0; var outStock = 0; var expiredCnt = 0;
            for (var i = 0; i < allMedicines.length; i++) {
                var m = allMedicines[i];
                if (m.quantity > 20)                           inStock++;
                else if (m.quantity > 0 && m.quantity <= 20)  lowStock++;
                else if (m.quantity === 0)                     outStock++;
                if (isExpired(m.expiryDate))                   expiredCnt++;
            }

            document.getElementById('statTotal').textContent   = total;
            document.getElementById('totalCount').textContent  = total;
            document.getElementById('statInStock').textContent = inStock;
            document.getElementById('statLow').textContent     = lowStock;
            document.getElementById('statOut').textContent     = outStock;
            document.getElementById('statExpired').textContent = expiredCnt;

            document.getElementById('pageInfo').textContent =
                'Page ' + (currentPage + 1) + ' of ' + totalPages + '  \u00b7  ' + total + ' total';
            document.getElementById('prevBtn').disabled = currentPage === 0;
            document.getElementById('nextBtn').disabled = currentPage >= totalPages - 1;
        },
        error: function() { toast('Failed to load medicines.', 'error'); }
    });
}

/* ─── ADD MEDICINE ─── */
$('#medicineForm').submit(function(e) {
    e.preventDefault();
    var btn = document.getElementById('addBtn');
    btn.disabled = true;
    btn.innerHTML = '<i class="bi bi-hourglass-split"></i> Saving...';

    var data = {
        name:         document.getElementById('medName').value.trim(),
        category:     document.getElementById('medCategory').value.trim(),
        manufacturer: document.getElementById('medManufacturer').value.trim(),
        quantity:     parseInt(document.getElementById('medQuantity').value, 10),
        price:        parseFloat(document.getElementById('medPrice').value),
        expiryDate:   document.getElementById('medExpiry').value
    };

    $.ajax({
        url: API_URL,
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function() {
            document.getElementById('medicineForm').reset();
            currentPage = 0;
            loadMedicines();
            toast('Medicine added to inventory!');
        },
        error: function() { toast('Failed to add medicine.', 'error'); },
        complete: function() {
            btn.disabled = false;
            btn.innerHTML = '<i class="bi bi-plus-circle-fill"></i> Add Medicine';
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
        url: API_URL + '/' + id,
        type: 'DELETE',
        success: function() {
            toast('Medicine removed.');
            if (allMedicines.length === 1 && currentPage > 0) currentPage--;
            loadMedicines();
        },
        error: function() { toast('Delete failed.', 'error'); }
    });
    deleteTarget = null;
};

/* ─── UPDATE STOCK ─── */
document.getElementById('stockCancelBtn').onclick = function() {
    document.getElementById('stockModal').classList.remove('open');
    stockTarget = null;
};

document.getElementById('saveStockBtn').onclick = function() {
    if (!stockTarget) return;
    var newQty = parseInt(document.getElementById('stockQtyInput').value, 10);
    if (isNaN(newQty) || newQty < 0) { toast('Enter a valid quantity.', 'error'); return; }
    var id = stockTarget;
    document.getElementById('stockModal').classList.remove('open');
    $.ajax({
        url: API_URL + '/' + id + '/stock?quantity=' + newQty,
        type: 'PATCH',
        success: function() { toast('Stock updated!'); loadMedicines(document.getElementById('searchInput').value); },
        error: function()   { toast('Stock update failed.', 'error'); }
    });
    stockTarget = null;
};

/* close modals on overlay click */
document.getElementById('deleteModal').onclick = function(e) {
    if (e.target === this) { this.classList.remove('open'); deleteTarget = null; }
};
document.getElementById('stockModal').onclick = function(e) {
    if (e.target === this) { this.classList.remove('open'); stockTarget = null; }
};

/* ─── VIEW TOGGLE ─── */
document.getElementById('gridViewBtn').onclick = function() {
    isGridView = true;
    this.classList.add('active');
    document.getElementById('listViewBtn').classList.remove('active');
    document.getElementById('gridView').style.display = 'block';
    document.getElementById('listView').style.display = 'none';
    loadMedicines(document.getElementById('searchInput').value);
};

document.getElementById('listViewBtn').onclick = function() {
    isGridView = false;
    this.classList.add('active');
    document.getElementById('gridViewBtn').classList.remove('active');
    document.getElementById('gridView').style.display = 'none';
    document.getElementById('listView').style.display = 'block';
    loadMedicines(document.getElementById('searchInput').value);
};

/* ─── FILTER CHIPS ─── */
document.querySelectorAll('.chip').forEach(function(chip) {
    chip.addEventListener('click', function() {
        document.querySelectorAll('.chip').forEach(function(c) { c.classList.remove('active'); });
        this.classList.add('active');
        activeFilter = this.getAttribute('data-filter');
        currentPage  = 0;
        loadMedicines(document.getElementById('searchInput').value);
    });
});

/* ─── SEARCH ─── */
var searchTimer;
document.getElementById('searchInput').addEventListener('input', function() {
    clearTimeout(searchTimer);
    var val = this.value.trim();
    searchTimer = setTimeout(function() { loadMedicines(val); }, 280);
});

/* ─── PAGINATION ─── */
document.getElementById('prevBtn').onclick = function() {
    if (currentPage > 0) { currentPage--; loadMedicines(); }
};
document.getElementById('nextBtn').onclick = function() {
    if (currentPage < totalPages - 1) { currentPage++; loadMedicines(); }
};

/* ─── INIT ─── */
$(document).ready(function() { loadMedicines(); });
</script>

</body>
</html>
