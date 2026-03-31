<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCore | Hospital Management System</title>

    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        :root {
            --bg:        #0a0f1e;
            --surface:   #111827;
            --card:      #151d2e;
            --border:    rgba(255,255,255,0.07);
            --accent:    #00d4ff;
            --accent2:   #7c3aed;
            --accent3:   #10b981;
            --accent4:   #f59e0b;
            --accent5:   #ef4444;
            --text:      #f1f5f9;
            --muted:     #64748b;
            --glow:      rgba(0,212,255,0.18);
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        html { scroll-behavior: smooth; }

        body {
            background: var(--bg);
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* ── ANIMATED GRID BACKGROUND ── */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background-image:
                linear-gradient(rgba(0,212,255,0.04) 1px, transparent 1px),
                linear-gradient(90deg, rgba(0,212,255,0.04) 1px, transparent 1px);
            background-size: 60px 60px;
            pointer-events: none;
            z-index: 0;
        }

        body::after {
            content: '';
            position: fixed;
            top: -40%;
            left: -20%;
            width: 70%;
            height: 70%;
            background: radial-gradient(ellipse, rgba(0,212,255,0.06) 0%, transparent 70%);
            pointer-events: none;
            z-index: 0;
            animation: driftBlob 18s ease-in-out infinite alternate;
        }

        @keyframes driftBlob {
            0%   { transform: translate(0,0) scale(1); }
            100% { transform: translate(15%,10%) scale(1.2); }
        }

        /* ── NAVBAR ── */
        .navbar {
            position: sticky;
            top: 0;
            z-index: 100;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 2rem;
            height: 66px;
            background: rgba(10,15,30,0.82);
            backdrop-filter: blur(18px);
            border-bottom: 1px solid var(--border);
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            gap: .55rem;
            font-family: 'DM Serif Display', serif;
            font-size: 1.4rem;
            color: var(--text);
            text-decoration: none;
            letter-spacing: -.01em;
        }

        .brand-dot {
            display: inline-block;
            width: 8px; height: 8px;
            border-radius: 50%;
            background: var(--accent);
            box-shadow: 0 0 10px var(--accent);
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%,100% { opacity:1; transform:scale(1); }
            50%      { opacity:.5; transform:scale(1.4); }
        }

        .navbar-right { display: flex; align-items: center; gap: 1rem; }

        .badge-status {
            font-size: .72rem;
            padding: .28rem .7rem;
            border-radius: 20px;
            background: rgba(16,185,129,.12);
            border: 1px solid rgba(16,185,129,.3);
            color: var(--accent3);
            letter-spacing: .04em;
            font-weight: 600;
        }

        .nav-time {
            font-size: .82rem;
            color: var(--muted);
            font-feature-settings: "tnum";
        }

        .btn-logout {
            display: flex;
            align-items: center;
            gap: .4rem;
            padding: .42rem 1rem;
            border-radius: 8px;
            border: 1px solid var(--border);
            background: transparent;
            color: var(--muted);
            font-size: .82rem;
            font-family: 'DM Sans', sans-serif;
            cursor: pointer;
            transition: all .2s;
            text-decoration: none;
        }

        .btn-logout:hover {
            border-color: var(--accent);
            color: var(--accent);
            background: rgba(0,212,255,.06);
        }

        /* ── HERO ── */
        .hero {
            position: relative;
            z-index: 1;
            padding: 3.5rem 2rem 2rem;
            max-width: 1280px;
            margin: 0 auto;
        }

        .hero-eyebrow {
            font-size: .75rem;
            letter-spacing: .18em;
            text-transform: uppercase;
            color: var(--accent);
            font-weight: 600;
            margin-bottom: .6rem;
        }

        .hero h1 {
            font-family: 'DM Serif Display', serif;
            font-size: clamp(2rem, 4vw, 3rem);
            line-height: 1.15;
            color: var(--text);
            margin-bottom: .5rem;
        }

        .hero h1 em {
            font-style: italic;
            color: var(--accent);
        }

        .hero p {
            color: var(--muted);
            font-size: .95rem;
            max-width: 480px;
        }

        /* ── KPI ROW ── */
        .kpi-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
            gap: 1rem;
            max-width: 1280px;
            margin: 2rem auto 0;
            padding: 0 2rem;
            position: relative;
            z-index: 1;
        }

        .kpi-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 14px;
            padding: 1.2rem 1.4rem;
            position: relative;
            overflow: hidden;
            transition: transform .25s, box-shadow .25s;
            animation: fadeUp .5s both;
        }

        .kpi-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(0,0,0,.35);
        }

        .kpi-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 2px;
            border-radius: 2px 2px 0 0;
        }

        .kpi-card.cyan::before   { background: linear-gradient(90deg,var(--accent),transparent); }
        .kpi-card.purple::before { background: linear-gradient(90deg,var(--accent2),transparent); }
        .kpi-card.green::before  { background: linear-gradient(90deg,var(--accent3),transparent); }
        .kpi-card.amber::before  { background: linear-gradient(90deg,var(--accent4),transparent); }
        .kpi-card.red::before    { background: linear-gradient(90deg,var(--accent5),transparent); }

        .kpi-label {
            font-size: .72rem;
            text-transform: uppercase;
            letter-spacing: .1em;
            color: var(--muted);
            margin-bottom: .55rem;
        }

        .kpi-value {
            font-family: 'DM Serif Display', serif;
            font-size: 1.9rem;
            color: var(--text);
            line-height: 1;
        }

        .kpi-delta {
            font-size: .72rem;
            margin-top: .4rem;
        }

        .kpi-delta.up   { color: var(--accent3); }
        .kpi-delta.down { color: var(--accent5); }

        /* ── MAIN GRID ── */
        .main-grid {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 1.2rem;
            max-width: 1280px;
            margin: 2rem auto 0;
            padding: 0 2rem;
            position: relative;
            z-index: 1;
        }

        @media (max-width: 900px) {
            .main-grid { grid-template-columns: 1fr 1fr; }
        }
        @media (max-width: 600px) {
            .main-grid { grid-template-columns: 1fr; }
        }

        /* ── MODULE CARDS ── */
        .mod-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 18px;
            overflow: hidden;
            transition: transform .3s, box-shadow .3s;
            animation: fadeUp .5s both;
            text-decoration: none;
            display: block;
            position: relative;
        }

        .mod-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 20px 50px rgba(0,0,0,.4);
            border-color: rgba(255,255,255,.14);
            text-decoration: none;
        }

        .mod-card:hover .mod-arrow { transform: translate(3px,-3px); }

        .mod-img {
            width: 100%;
            height: 160px;
            object-fit: cover;
            display: block;
            filter: brightness(.7) saturate(.9);
            transition: filter .3s;
        }

        .mod-card:hover .mod-img { filter: brightness(.85) saturate(1.05); }

        .mod-img-placeholder {
            height: 160px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3.5rem;
        }

        /* Color fills for placeholders */
        .fill-cyan   { background: linear-gradient(135deg, #0a1628 0%, #0c2a3a 100%); color: var(--accent); }
        .fill-purple { background: linear-gradient(135deg, #160a28 0%, #2a1050 100%); color: var(--accent2); }
        .fill-green  { background: linear-gradient(135deg, #0a1e18 0%, #0c3028 100%); color: var(--accent3); }
        .fill-amber  { background: linear-gradient(135deg, #1e1408 0%, #2e1e0a 100%); color: var(--accent4); }
        .fill-red    { background: linear-gradient(135deg, #1e0a0a 0%, #2e0c10 100%); color: var(--accent5); }
        .fill-indigo { background: linear-gradient(135deg, #0a0e28 0%, #121840 100%); color: #818cf8; }

        .mod-body {
            padding: 1.3rem 1.4rem 1.4rem;
        }

        .mod-tag {
            display: inline-block;
            font-size: .65rem;
            letter-spacing: .14em;
            text-transform: uppercase;
            font-weight: 600;
            padding: .2rem .6rem;
            border-radius: 20px;
            margin-bottom: .65rem;
        }

        .tag-cyan   { background: rgba(0,212,255,.1);   color: var(--accent);  border: 1px solid rgba(0,212,255,.2); }
        .tag-purple { background: rgba(124,58,237,.12); color: #a78bfa;        border: 1px solid rgba(124,58,237,.25); }
        .tag-green  { background: rgba(16,185,129,.1);  color: var(--accent3); border: 1px solid rgba(16,185,129,.2); }
        .tag-amber  { background: rgba(245,158,11,.1);  color: var(--accent4); border: 1px solid rgba(245,158,11,.2); }
        .tag-red    { background: rgba(239,68,68,.1);   color: var(--accent5); border: 1px solid rgba(239,68,68,.2); }
        .tag-indigo { background: rgba(99,102,241,.1);  color: #818cf8;        border: 1px solid rgba(99,102,241,.2); }

        .mod-title {
            font-family: 'DM Serif Display', serif;
            font-size: 1.2rem;
            color: var(--text);
            margin-bottom: .3rem;
        }

        .mod-desc {
            font-size: .82rem;
            color: var(--muted);
            line-height: 1.55;
            margin-bottom: 1rem;
        }

        .mod-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .mod-count {
            font-size: .75rem;
            color: var(--muted);
        }

        .mod-count span {
            color: var(--text);
            font-weight: 600;
        }

        .mod-arrow {
            width: 30px; height: 30px;
            border-radius: 50%;
            border: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: .8rem;
            color: var(--muted);
            transition: transform .25s, border-color .25s, color .25s;
        }

        /* ── ACTIVITY SECTION ── */
        .activity-section {
            max-width: 1280px;
            margin: 2rem auto;
            padding: 0 2rem 3rem;
            position: relative;
            z-index: 1;
            display: grid;
            grid-template-columns: 1fr 340px;
            gap: 1.2rem;
        }

        @media (max-width: 820px) {
            .activity-section { grid-template-columns: 1fr; }
        }

        .section-title {
            font-family: 'DM Serif Display', serif;
            font-size: 1.1rem;
            color: var(--text);
            margin-bottom: 1rem;
        }

        .activity-list {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 18px;
            padding: 1.4rem;
        }

        .activity-item {
            display: flex;
            align-items: flex-start;
            gap: 1rem;
            padding: .85rem 0;
            border-bottom: 1px solid var(--border);
            animation: fadeUp .4s both;
        }

        .activity-item:last-child { border-bottom: none; padding-bottom: 0; }

        .act-icon {
            width: 36px; height: 36px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: .95rem;
            flex-shrink: 0;
        }

        .act-icon.cyan   { background: rgba(0,212,255,.1);   color: var(--accent); }
        .act-icon.green  { background: rgba(16,185,129,.1);  color: var(--accent3); }
        .act-icon.amber  { background: rgba(245,158,11,.1);  color: var(--accent4); }
        .act-icon.red    { background: rgba(239,68,68,.1);   color: var(--accent5); }
        .act-icon.purple { background: rgba(124,58,237,.12); color: #a78bfa; }

        .act-text { flex: 1; }

        .act-title { font-size: .85rem; color: var(--text); font-weight: 500; margin-bottom: .15rem; }

        .act-sub   { font-size: .75rem; color: var(--muted); }

        .act-time  { font-size: .72rem; color: var(--muted); flex-shrink: 0; }

        /* ── QUICK ACTIONS ── */
        .quick-panel {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 18px;
            padding: 1.4rem;
        }

        .quick-btn {
            display: flex;
            align-items: center;
            gap: .8rem;
            width: 100%;
            padding: .85rem 1rem;
            background: rgba(255,255,255,.03);
            border: 1px solid var(--border);
            border-radius: 10px;
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            font-size: .85rem;
            cursor: pointer;
            margin-bottom: .6rem;
            transition: all .2s;
            text-decoration: none;
        }

        .quick-btn:last-child { margin-bottom: 0; }

        .quick-btn:hover {
            border-color: rgba(255,255,255,.18);
            background: rgba(255,255,255,.07);
            color: var(--text);
            text-decoration: none;
        }

        .quick-btn i { font-size: 1rem; }

        /* ── JAVA TECH STRIP ── */
        .tech-strip {
            max-width: 1280px;
            margin: 0 auto;
            padding: 0 2rem 1rem;
            position: relative;
            z-index: 1;
        }

        .tech-badges {
            display: flex;
            flex-wrap: wrap;
            gap: .5rem;
            align-items: center;
        }

        .tech-label {
            font-size: .72rem;
            color: var(--muted);
            letter-spacing: .06em;
            text-transform: uppercase;
            margin-right: .3rem;
        }

        .tech-badge {
            font-size: .7rem;
            padding: .24rem .65rem;
            border-radius: 6px;
            border: 1px solid var(--border);
            color: var(--muted);
            background: var(--card);
            letter-spacing: .03em;
            font-weight: 500;
            transition: color .2s, border-color .2s;
        }

        .tech-badge:hover {
            color: var(--accent);
            border-color: rgba(0,212,255,.3);
        }

        /* ── ANIMATION ── */
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .kpi-card:nth-child(1) { animation-delay: .05s; }
        .kpi-card:nth-child(2) { animation-delay: .10s; }
        .kpi-card:nth-child(3) { animation-delay: .15s; }
        .kpi-card:nth-child(4) { animation-delay: .20s; }
        .kpi-card:nth-child(5) { animation-delay: .25s; }

        .mod-card:nth-child(1) { animation-delay: .10s; }
        .mod-card:nth-child(2) { animation-delay: .18s; }
        .mod-card:nth-child(3) { animation-delay: .26s; }
        .mod-card:nth-child(4) { animation-delay: .34s; }
        .mod-card:nth-child(5) { animation-delay: .42s; }
        .mod-card:nth-child(6) { animation-delay: .50s; }

        /* ── FOOTER ── */
        footer {
            position: relative;
            z-index: 1;
            text-align: center;
            padding: 1.5rem;
            border-top: 1px solid var(--border);
            font-size: .78rem;
            color: var(--muted);
        }

        footer strong { color: var(--accent); }

        /* Scrollbar */
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: var(--bg); }
        ::-webkit-scrollbar-thumb { background: #1e293b; border-radius: 3px; }
    </style>
</head>
<body>

<!-- ═══ NAVBAR ═══ -->
<nav class="navbar">
    <a href="#" class="navbar-brand">
        <span class="brand-dot"></span>
        MediCore <sup style="font-size:.55rem;letter-spacing:.12em;color:var(--muted);font-family:'DM Sans',sans-serif;">HMS</sup>
    </a>

    <div class="navbar-right">
        <span class="badge-status"><i class="bi bi-circle-fill" style="font-size:.45rem;"></i> All Systems Normal</span>
        <span class="nav-time" id="liveClock">--:--:--</span>

        <c:choose>
            <c:when test="${sessionScope.USER != null}">
                <a href="/logout" class="btn-logout">
                    <i class="bi bi-box-arrow-right"></i> Logout
                </a>
            </c:when>
            <c:otherwise>
                <a href="/login" class="btn-logout">
                    <i class="bi bi-box-arrow-in-right"></i> Login
                </a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>


<!-- ═══ HERO ═══ -->
<section class="hero">
    <p class="hero-eyebrow">Hospital Management System</p>
    <h1>Dashboard Overview<br><em>Hospital Management System</em></h1>
    <p>Real-time insights across all departments. Manage patients, staff, and operations from one place.</p>
</section>


<!-- ═══ KPI STRIP ═══ -->
<div class="kpi-row">
    <div class="kpi-card cyan">
        <p class="kpi-label">Total Patients</p>
        <div class="kpi-value">1,248</div>
        <div class="kpi-delta up"><i class="bi bi-arrow-up-short"></i>12% this week</div>
    </div>
    <div class="kpi-card purple">
        <p class="kpi-label">Doctors on Duty</p>
        <div class="kpi-value">34</div>
        <div class="kpi-delta up"><i class="bi bi-circle-fill" style="font-size:.4rem;"></i> 28 active now</div>
    </div>
    <div class="kpi-card green">
        <p class="kpi-label">Today's Appointments</p>
        <div class="kpi-value">87</div>
        <div class="kpi-delta up"><i class="bi bi-arrow-up-short"></i>5 new today</div>
    </div>
    <div class="kpi-card amber">
        <p class="kpi-label">Beds Available</p>
        <div class="kpi-value">63</div>
        <div class="kpi-delta down"><i class="bi bi-arrow-down-short"></i>8 occupied today</div>
    </div>
    <div class="kpi-card red">
        <p class="kpi-label">Emergency Alerts</p>
        <div class="kpi-value">3</div>
        <div class="kpi-delta down"><i class="bi bi-exclamation-triangle-fill" style="font-size:.65rem;"></i> Needs attention</div>
    </div>
</div>


<!-- ═══ MODULE CARDS ═══ -->
<div class="main-grid">

    <!-- Doctors -->
    <a href="/doctor.jsp" class="mod-card">
        <div class="mod-img-placeholder fill-cyan">
            <i class="bi bi-person-badge-fill"></i>
        </div>
        <div class="mod-body">
            <span class="mod-tag tag-cyan">Staff</span>
            <h2 class="mod-title">Doctors</h2>
            <p class="mod-desc">Manage physician profiles, specializations, schedules, and availability across departments.</p>
            <div class="mod-footer">
                <span class="mod-count"><span>34</span> registered</span>
                <span class="mod-arrow"><i class="bi bi-arrow-up-right"></i></span>
            </div>
        </div>
    </a>

    <!-- Patients -->
    <a href="/patient.jsp" class="mod-card">
        <div class="mod-img-placeholder fill-green">
            <i class="bi bi-people-fill"></i>
        </div>
        <div class="mod-body">
            <span class="mod-tag tag-green">Records</span>
            <h2 class="mod-title">Patients</h2>
            <p class="mod-desc">Access and update patient records, medical history, diagnoses, and treatment plans.</p>
            <div class="mod-footer">
                <span class="mod-count"><span>1,248</span> total</span>
                <span class="mod-arrow"><i class="bi bi-arrow-up-right"></i></span>
            </div>
        </div>
    </a>

    <!-- Appointments -->
    <a href="/appointments.jsp" class="mod-card">
        <div class="mod-img-placeholder fill-amber">
            <i class="bi bi-calendar2-check-fill"></i>
        </div>
        <div class="mod-body">
            <span class="mod-tag tag-amber">Scheduling</span>
            <h2 class="mod-title">Appointments</h2>
            <p class="mod-desc">Schedule, reschedule, and track appointments between doctors and patients.</p>
            <div class="mod-footer">
                <span class="mod-count"><span>87</span> today</span>
                <span class="mod-arrow"><i class="bi bi-arrow-up-right"></i></span>
            </div>
        </div>
    </a>

    <!-- Pharmacy -->
    <a href="/pharmacy.jsp" class="mod-card">
        <div class="mod-img-placeholder fill-purple">
            <i class="bi bi-capsule-pill"></i>
        </div>
        <div class="mod-body">
            <span class="mod-tag tag-purple">Inventory</span>
            <h2 class="mod-title">Pharmacy</h2>
            <p class="mod-desc">Track medicine stock, prescriptions, dispensing history, and supplier orders.</p>
            <div class="mod-footer">
                <span class="mod-count"><span>412</span> items</span>
                <span class="mod-arrow"><i class="bi bi-arrow-up-right"></i></span>
            </div>
        </div>
    </a>

    <!-- Lab / Reports -->
    <a href="/lab.jsp" class="mod-card">
        <div class="mod-img-placeholder fill-red">
            <i class="bi bi-clipboard2-pulse-fill"></i>
        </div>
        <div class="mod-body">
            <span class="mod-tag tag-red">Diagnostics</span>
            <h2 class="mod-title">Lab & Reports</h2>
            <p class="mod-desc">Manage lab tests, diagnostic reports, and pathology results for all patients.</p>
            <div class="mod-footer">
                <span class="mod-count"><span>156</span> pending</span>
                <span class="mod-arrow"><i class="bi bi-arrow-up-right"></i></span>
            </div>
        </div>
    </a>

    <!-- Billing -->
    <a href="/bill.jsp" class="mod-card">
        <div class="mod-img-placeholder fill-indigo">
            <i class="bi bi-receipt-cutoff"></i>
        </div>
        <div class="mod-body">
            <span class="mod-tag tag-indigo">Finance</span>
            <h2 class="mod-title">Billing</h2>
            <p class="mod-desc">Generate invoices, process insurance claims, and manage payment history.</p>
            <div class="mod-footer">
                <span class="mod-count"><span>₹2.4L</span> today</span>
                <span class="mod-arrow"><i class="bi bi-arrow-up-right"></i></span>
            </div>
        </div>
    </a>

</div>


<!-- ═══ ACTIVITY + QUICK ACTIONS ═══ -->
<div class="activity-section">

    <!-- Recent Activity -->
    <div class="activity-list">
        <p class="section-title">Recent Activity</p>

        <div class="activity-item">
            <div class="act-icon cyan"><i class="bi bi-person-plus"></i></div>
            <div class="act-text">
                <p class="act-title">New patient registered</p>
                <p class="act-sub">Priya Sharma · OPD Ward B</p>
            </div>
            <span class="act-time">2 min ago</span>
        </div>

        <div class="activity-item">
            <div class="act-icon green"><i class="bi bi-calendar-check"></i></div>
            <div class="act-text">
                <p class="act-title">Appointment confirmed</p>
                <p class="act-sub">Dr. Mehta · Cardiology · 11:30 AM</p>
            </div>
            <span class="act-time">8 min ago</span>
        </div>

        <div class="activity-item">
            <div class="act-icon amber"><i class="bi bi-capsule"></i></div>
            <div class="act-text">
                <p class="act-title">Prescription issued</p>
                <p class="act-sub">Patient #1042 · Amoxicillin 500mg</p>
            </div>
            <span class="act-time">15 min ago</span>
        </div>

        <div class="activity-item">
            <div class="act-icon red"><i class="bi bi-exclamation-triangle"></i></div>
            <div class="act-text">
                <p class="act-title">Emergency admission</p>
                <p class="act-sub">ICU Bed 4 assigned · Critical</p>
            </div>
            <span class="act-time">22 min ago</span>
        </div>

        <div class="activity-item">
            <div class="act-icon purple"><i class="bi bi-file-earmark-medical"></i></div>
            <div class="act-text">
                <p class="act-title">Lab report uploaded</p>
                <p class="act-sub">Patient #0987 · Blood CBC panel</p>
            </div>
            <span class="act-time">41 min ago</span>
        </div>

    </div>

    <!-- Quick Actions -->
    <div class="quick-panel">
        <p class="section-title">Quick Actions</p>

        <a href="/patient.jsp" class="quick-btn">
            <i class="bi bi-person-plus-fill" style="color:var(--accent);"></i>
            Register New Patient
        </a>
        <a href="/appointments.jsp" class="quick-btn">
            <i class="bi bi-calendar-plus-fill" style="color:var(--accent4);"></i>
            Book Appointment
        </a>
        <a href="/lab/request" class="quick-btn">
            <i class="bi bi-clipboard2-plus-fill" style="color:var(--accent5);"></i>
            Request Lab Test
        </a>
        <a href="/pharmacy/issue" class="quick-btn">
            <i class="bi bi-capsule-pill" style="color:#a78bfa;"></i>
            Issue Medicine
        </a>
        <a href="/billing/new" class="quick-btn">
            <i class="bi bi-receipt" style="color:var(--accent3);"></i>
            Generate Invoice
        </a>
        <a href="/report/export" class="quick-btn">
            <i class="bi bi-download" style="color:var(--muted);"></i>
            Export Reports
        </a>
    </div>

</div>


<!-- ═══ TECH STACK STRIP ═══ -->
<div class="tech-strip">
    <div class="tech-badges">
        <span class="tech-label">Stack:</span>
        <span class="tech-badge">Java EE</span>
        <span class="tech-badge">JSP / JSTL</span>
        <span class="tech-badge">Servlets</span>
        <span class="tech-badge">JDBC</span>
        <span class="tech-badge">MySQL</span>
        <span class="tech-badge">Tomcat</span>
        <span class="tech-badge">Maven</span>
        <span class="tech-badge">MVC Pattern</span>
        <span class="tech-badge">Bootstrap 5</span>
    </div>
</div>


<!-- ═══ FOOTER ═══ -->
<footer>
    <strong>MediCore HMS</strong> &nbsp;·&nbsp; Built with Java EE · JSP · Servlets &nbsp;·&nbsp; © 2025
</footer>


<script>
    // Live clock
    function tick() {
        const now = new Date();
        document.getElementById('liveClock').textContent =
            now.toLocaleTimeString('en-IN', { hour12: false });
    }
    tick();
    setInterval(tick, 1000);
</script>

</body>
</html>
