<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCore | Hospital Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --bg: #0a0f1e;
            --surface: #111827;
            --card: #151d2e;
            --border: rgba(255, 255, 255, .07);
            --accent: #00d4ff;
            --accent2: #7c3aed;
            --accent3: #10b981;
            --accent4: #f59e0b;
            --accent5: #ef4444;
            --text: #f1f5f9;
            --muted: #64748b;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: var(--bg);
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            min-height: 100vh;
            overflow-x: hidden;
        }

        body::before {
            content: '';
            position: fixed;
            inset: 0;
            pointer-events: none;
            z-index: 0;
            background-image:
                radial-gradient(ellipse 80% 50% at 50% -20%, rgba(0, 212, 255, 0.08), transparent),
                linear-gradient(rgba(0, 212, 255, .03) 1px, transparent 1px),
                linear-gradient(90deg, rgba(0, 212, 255, .03) 1px, transparent 1px);
            background-size: 100% 100%, 60px 60px, 60px 60px;
        }

        /* Floating Orbs Animation */
        .orb {
            position: fixed;
            border-radius: 50%;
            filter: blur(80px);
            pointer-events: none;
            z-index: 0;
            animation: float 20s ease-in-out infinite;
        }

        .orb-1 {
            width: 400px;
            height: 400px;
            background: rgba(0, 212, 255, 0.15);
            top: -100px;
            right: -100px;
            animation-delay: 0s;
        }

        .orb-2 {
            width: 300px;
            height: 300px;
            background: rgba(124, 58, 237, 0.12);
            bottom: 20%;
            left: -50px;
            animation-delay: -7s;
        }

        .orb-3 {
            width: 250px;
            height: 250px;
            background: rgba(16, 185, 129, 0.1);
            bottom: -50px;
            right: 30%;
            animation-delay: -14s;
        }

        @keyframes float {
            0%, 100% { transform: translate(0, 0) scale(1); }
            25% { transform: translate(30px, -30px) scale(1.05); }
            50% { transform: translate(-20px, 20px) scale(0.95); }
            75% { transform: translate(40px, 10px) scale(1.02); }
        }

        /* Navbar */
        .top-nav {
            background: rgba(10, 15, 30, .75);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .brand {
            font-family: 'DM Serif Display', serif;
            font-size: 1.5rem;
            color: var(--text);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .brand-icon {
            width: 36px;
            height: 36px;
            background: linear-gradient(135deg, var(--accent), var(--accent2));
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            color: white;
            box-shadow: 0 4px 15px rgba(0, 212, 255, 0.3);
        }

        .badge-online {
            font-size: .72rem;
            padding: .35rem .8rem;
            border-radius: 20px;
            background: rgba(16, 185, 129, .12);
            border: 1px solid rgba(16, 185, 129, .3);
            color: var(--accent3);
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .pulse-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: var(--accent3);
            animation: pulse 2s ease-in-out infinite;
        }

        .btn-nav {
            border: 1px solid var(--border);
            color: var(--muted);
            background: rgba(255, 255, 255, 0.03);
            border-radius: 10px;
            font-size: .82rem;
            padding: 0.5rem 1rem;
            transition: all .25s cubic-bezier(0.4, 0, 0.2, 1);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-nav:hover {
            border-color: var(--accent);
            color: var(--accent);
            background: rgba(0, 212, 255, .08);
            transform: translateY(-2px);
        }

        /* Hero Section */
        .hero {
            padding: 4rem 0 3rem;
            position: relative;
            z-index: 1;
        }

        .hero-eyebrow {
            font-size: .75rem;
            letter-spacing: .2em;
            text-transform: uppercase;
            color: var(--accent);
            font-weight: 600;
            margin-bottom: 1rem;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .hero-eyebrow::before {
            content: '';
            width: 30px;
            height: 2px;
            background: linear-gradient(90deg, var(--accent), transparent);
        }

        .hero h1 {
            font-family: 'DM Serif Display', serif;
            font-size: clamp(2.2rem, 5vw, 3.5rem);
            color: var(--text);
            line-height: 1.15;
            margin-bottom: 1.5rem;
        }

        .hero h1 em {
            font-style: italic;
            background: linear-gradient(135deg, var(--accent), #7c3aed);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero-desc {
            color: var(--muted);
            font-size: 1.05rem;
            line-height: 1.7;
            max-width: 500px;
        }

        .hero-img-wrapper {
            position: relative;
        }

        .hero-img {
            width: 100%;
            max-width: 520px;
            border-radius: 20px;
            box-shadow:
                0 25px 60px rgba(0, 0, 0, .5),
                0 0 0 1px rgba(255, 255, 255, 0.05);
            transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .hero-img:hover {
            transform: scale(1.02) rotate(1deg);
        }

        .hero-img-glow {
            position: absolute;
            inset: -20px;
            background: radial-gradient(ellipse at center, rgba(0, 212, 255, 0.2), transparent 70%);
            z-index: -1;
            filter: blur(40px);
        }

        /* KPI Cards */
        .kpi-section {
            margin-bottom: 2rem;
        }

        .kpi-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 1.4rem 1.5rem;
            position: relative;
            overflow: hidden;
            transition: all .3s cubic-bezier(0.4, 0, 0.2, 1);
            animation: fadeUp .5s both;
        }

        .kpi-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            border-radius: 3px 3px 0 0;
        }

        .kpi-card::after {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 100px;
            height: 100px;
            border-radius: 50%;
            filter: blur(50px);
            opacity: 0.15;
            transition: opacity 0.3s;
        }

        .kpi-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, .4);
            border-color: rgba(255, 255, 255, 0.1);
        }

        .kpi-card:hover::after {
            opacity: 0.25;
        }

        .kpi-card.cyan::before { background: linear-gradient(90deg, var(--accent), transparent); }
        .kpi-card.cyan::after { background: var(--accent); }
        .kpi-card.purple::before { background: linear-gradient(90deg, var(--accent2), transparent); }
        .kpi-card.purple::after { background: var(--accent2); }
        .kpi-card.green::before { background: linear-gradient(90deg, var(--accent3), transparent); }
        .kpi-card.green::after { background: var(--accent3); }
        .kpi-card.amber::before { background: linear-gradient(90deg, var(--accent4), transparent); }
        .kpi-card.amber::after { background: var(--accent4); }
        .kpi-card.red::before { background: linear-gradient(90deg, var(--accent5), transparent); }
        .kpi-card.red::after { background: var(--accent5); }

        .kpi-icon {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            margin-bottom: 1rem;
        }

        .kpi-icon.cyan { background: rgba(0, 212, 255, .12); color: var(--accent); }
        .kpi-icon.purple { background: rgba(124, 58, 237, .12); color: var(--accent2); }
        .kpi-icon.green { background: rgba(16, 185, 129, .12); color: var(--accent3); }
        .kpi-icon.amber { background: rgba(245, 158, 11, .12); color: var(--accent4); }
        .kpi-icon.red { background: rgba(239, 68, 68, .12); color: var(--accent5); }

        .kpi-label {
            font-size: .72rem;
            text-transform: uppercase;
            letter-spacing: .1em;
            color: var(--muted);
            margin-bottom: .4rem;
        }

        .kpi-value {
            font-family: 'DM Serif Display', serif;
            font-size: 2.2rem;
            color: var(--text);
            line-height: 1;
            margin-bottom: 0.5rem;
        }

        .kpi-delta {
            font-size: .75rem;
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }

        .kpi-delta.up { color: var(--accent3); }
        .kpi-delta.down { color: var(--accent5); }

        /* Module Cards */
        .mod-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 20px;
            text-decoration: none;
            display: block;
            overflow: hidden;
            transition: all .35s cubic-bezier(0.4, 0, 0.2, 1);
            animation: fadeUp .5s both;
            position: relative;
        }

        .mod-card::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(180deg, transparent 60%, rgba(0, 0, 0, 0.8));
            z-index: 1;
            pointer-events: none;
            opacity: 0;
            transition: opacity 0.3s;
        }

        .mod-card:hover {
            transform: translateY(-8px) scale(1.01);
            box-shadow: 0 30px 60px rgba(0, 0, 0, .5);
            border-color: rgba(255, 255, 255, .15);
        }

        .mod-card:hover .mod-img {
            transform: scale(1.08);
        }

        .mod-card:hover .mod-arrow {
            transform: translate(4px, -4px);
            border-color: var(--accent);
            color: var(--accent);
        }

        .mod-img-wrapper {
            height: 180px;
            overflow: hidden;
            position: relative;
        }

        .mod-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .mod-img-overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(180deg, transparent 40%, var(--card) 100%);
            pointer-events: none;
        }

        .mod-content {
            padding: 1.25rem 1.5rem 1.5rem;
        }

        .mod-tag {
            display: inline-block;
            font-size: .65rem;
            letter-spacing: .12em;
            text-transform: uppercase;
            font-weight: 600;
            padding: .25rem .7rem;
            border-radius: 20px;
            margin-bottom: .75rem;
        }

        .tag-cyan { background: rgba(0, 212, 255, .1); color: var(--accent); border: 1px solid rgba(0, 212, 255, .2); }
        .tag-purple { background: rgba(124, 58, 237, .12); color: #a78bfa; border: 1px solid rgba(124, 58, 237, .25); }
        .tag-green { background: rgba(16, 185, 129, .1); color: var(--accent3); border: 1px solid rgba(16, 185, 129, .2); }
        .tag-amber { background: rgba(245, 158, 11, .1); color: var(--accent4); border: 1px solid rgba(245, 158, 11, .2); }
        .tag-red { background: rgba(239, 68, 68, .1); color: var(--accent5); border: 1px solid rgba(239, 68, 68, .2); }
        .tag-indigo { background: rgba(99, 102, 241, .1); color: #818cf8; border: 1px solid rgba(99, 102, 241, .2); }

        .mod-title {
            font-family: 'DM Serif Display', serif;
            font-size: 1.3rem;
            color: var(--text);
            margin-bottom: 0.5rem;
        }

        .mod-desc {
            font-size: .85rem;
            color: var(--muted);
            line-height: 1.6;
            margin-bottom: 1rem;
        }

        .mod-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .mod-count {
            font-size: .8rem;
            color: var(--muted);
        }

        .mod-count span {
            color: var(--text);
            font-weight: 600;
        }

        .mod-arrow {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            border: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: .85rem;
            color: var(--muted);
            transition: all .3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        /* Activity & Quick Actions */
        .side-panel {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 1.5rem;
        }

        .panel-title {
            font-family: 'DM Serif Display', serif;
            font-size: 1.15rem;
            color: var(--text);
            margin-bottom: 1.25rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .activity-item {
            display: flex;
            align-items: flex-start;
            gap: 1rem;
            padding: 1rem 0;
            border-bottom: 1px solid var(--border);
            transition: background 0.2s;
        }

        .activity-item:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .activity-item:hover {
            background: rgba(255, 255, 255, 0.02);
            margin: 0 -1rem;
            padding-left: 1rem;
            padding-right: 1rem;
            border-radius: 10px;
        }

        .act-icon {
            width: 40px;
            height: 40px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
            flex-shrink: 0;
        }

        .act-icon.cyan { background: rgba(0, 212, 255, .1); color: var(--accent); }
        .act-icon.green { background: rgba(16, 185, 129, .1); color: var(--accent3); }
        .act-icon.amber { background: rgba(245, 158, 11, .1); color: var(--accent4); }
        .act-icon.red { background: rgba(239, 68, 68, .1); color: var(--accent5); }
        .act-icon.purple { background: rgba(124, 58, 237, .12); color: #a78bfa; }

        .act-content {
            flex-grow: 1;
            min-width: 0;
        }

        .act-title {
            font-size: .88rem;
            color: var(--text);
            font-weight: 500;
            margin-bottom: .2rem;
        }

        .act-sub {
            font-size: .78rem;
            color: var(--muted);
        }

        .act-time {
            font-size: .72rem;
            color: var(--muted);
            flex-shrink: 0;
            background: rgba(255, 255, 255, 0.03);
            padding: 0.25rem 0.6rem;
            border-radius: 6px;
        }

        /* Quick Actions */
        .quick-btn {
            display: flex;
            align-items: center;
            gap: .9rem;
            width: 100%;
            padding: 1rem 1.1rem;
            background: rgba(255, 255, 255, .02);
            border: 1px solid var(--border);
            border-radius: 12px;
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            font-size: .88rem;
            margin-bottom: .7rem;
            transition: all .25s cubic-bezier(0.4, 0, 0.2, 1);
            text-decoration: none;
        }

        .quick-btn:last-child {
            margin-bottom: 0;
        }

        .quick-btn:hover {
            border-color: rgba(255, 255, 255, .15);
            background: rgba(255, 255, 255, .06);
            color: var(--text);
            transform: translateX(5px);
        }

        .quick-btn i {
            font-size: 1.1rem;
        }

        /* Tech Strip */
        .tech-strip {
            display: flex;
            flex-wrap: wrap;
            gap: 0.6rem;
            align-items: center;
            padding: 1.5rem 0;
        }

        .tech-label {
            font-size: .72rem;
            color: var(--muted);
            text-transform: uppercase;
            letter-spacing: .08em;
        }

        .tech-badge {
            font-size: .72rem;
            padding: .3rem .75rem;
            border-radius: 8px;
            border: 1px solid var(--border);
            color: var(--muted);
            background: var(--card);
            font-weight: 500;
            transition: all .2s;
        }

        .tech-badge:hover {
            color: var(--accent);
            border-color: rgba(0, 212, 255, .3);
            background: rgba(0, 212, 255, .05);
        }

        /* Footer */
        footer {
            border-top: 1px solid var(--border);
            padding: 2rem 0;
            text-align: center;
            font-size: .82rem;
            color: var(--muted);
            position: relative;
            z-index: 1;
        }

        footer strong {
            color: var(--accent);
        }

        /* Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: var(--bg);
        }

        ::-webkit-scrollbar-thumb {
            background: #1e293b;
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: #334155;
        }

        /* Animations */
        @keyframes pulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: .5; transform: scale(1.5); }
        }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(25px); }
            to { opacity: 1; transform: translateY(0); }
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

        /* Responsive */
        @media (max-width: 991px) {
            .hero { padding: 3rem 0 2rem; }
            .hero h1 { font-size: 2rem; }
            .kpi-card { padding: 1.1rem 1.2rem; }
            .kpi-value { font-size: 1.8rem; }
        }

        @media (max-width: 767px) {
            .top-nav .d-flex { gap: 0.5rem !important; }
            .badge-online { display: none; }
            .hero-img { max-width: 100%; margin-top: 2rem; }
        }
    </style>
</head>

<body>
    <!-- Floating Orbs -->
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>
    <div class="orb orb-3"></div>

    <!-- NAVBAR -->
    <nav class="top-nav navbar py-2 px-3 px-lg-4">
        <a href="#" class="brand">
            <span class="brand-icon"><i class="bi bi-heart-pulse-fill"></i></span>
            MediCore <sup style="font-size:.55rem;color:var(--muted);margin-left:4px;">HMS</sup>
        </a>
        <div class="d-flex align-items-center gap-3">
            <span class="badge-online">
                <span class="pulse-dot"></span>
                All Systems Normal
            </span>
            <span id="liveClock" style="font-size:.85rem;color:var(--muted);font-variant-numeric:tabular-nums;">--:--:--</span>
            <c:choose>
                <c:when test="${sessionScope.USER != null}">
                    <a href="/logout" class="btn-nav"><i class="bi bi-box-arrow-right"></i> Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="/login" class="btn-nav"><i class="bi bi-box-arrow-in-right"></i> Login</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

    <!-- HERO -->
    <section class="hero position-relative z-1 px-3 px-lg-4">
        <div class="container-xl">
            <div class="row align-items-center gy-4">
                <div class="col-lg-6">
                    <p class="hero-eyebrow">Hospital Management System</p>
                    <h1>Dashboard Overview<br><em>Smart Healthcare Control</em></h1>
                    <p class="hero-desc">Real-time insights across all departments. Manage patients, staff, appointments, and operations from one powerful, intelligent dashboard.</p>
                </div>
                <div class="col-lg-6 text-center">
                    <div class="hero-img-wrapper">
                        <div class="hero-img-glow"></div>

                        <video class="hero-img" autoplay muted loop playsinline>
                            <source src="img/hms.mp4" type="video/mp4">
                            Your browser does not support the video tag.
                        </video>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- KPI ROW -->
    <section class="kpi-section container-xl px-3 px-lg-4 position-relative z-1">
        <div class="row g-3">
            <div class="col-6 col-lg">
                <div class="kpi-card cyan">
                    <div class="kpi-icon cyan"><i class="bi bi-people-fill"></i></div>
                    <p class="kpi-label">Total Patients</p>
                    <div class="kpi-value">1,248</div>
                    <div class="kpi-delta up"><i class="bi bi-arrow-up-short"></i> 12% this week</div>
                </div>
            </div>
            <div class="col-6 col-lg">
                <div class="kpi-card purple">
                    <div class="kpi-icon purple"><i class="bi bi-person-badge-fill"></i></div>
                    <p class="kpi-label">Doctors on Duty</p>
                    <div class="kpi-value">34</div>
                    <div class="kpi-delta up"><i class="bi bi-circle-fill" style="font-size:.35rem;"></i> 28 active now</div>
                </div>
            </div>
            <div class="col-6 col-lg">
                <div class="kpi-card green">
                    <div class="kpi-icon green"><i class="bi bi-calendar-check-fill"></i></div>
                    <p class="kpi-label">Today's Appointments</p>
                    <div class="kpi-value">87</div>
                    <div class="kpi-delta up"><i class="bi bi-arrow-up-short"></i> 5 new today</div>
                </div>
            </div>
            <div class="col-6 col-lg">
                <div class="kpi-card amber">
                    <div class="kpi-icon amber"><i class="bi bi-hospital-fill"></i></div>
                    <p class="kpi-label">Beds Available</p>
                    <div class="kpi-value">63</div>
                    <div class="kpi-delta down"><i class="bi bi-arrow-down-short"></i> 8 occupied today</div>
                </div>
            </div>
            <div class="col-6 col-lg">
                <div class="kpi-card red">
                    <div class="kpi-icon red"><i class="bi bi-exclamation-triangle-fill"></i></div>
                    <p class="kpi-label">Emergency Alerts</p>
                    <div class="kpi-value">3</div>
                    <div class="kpi-delta down"><i class="bi bi-exclamation-circle-fill"></i> Needs attention</div>
                </div>
            </div>
        </div>
    </section>

    <!-- MODULE CARDS -->
    <section class="container-xl px-3 px-lg-4 mb-4 mt-4 position-relative z-1">
        <div class="row g-3 g-lg-4">
            <div class="col-lg-4 col-md-6">
                <a href="/doctor.jsp" class="mod-card">
                    <div class="mod-img-wrapper">
                        <img src="img/doctor.png" alt="Doctors Module" class="mod-img">
                        <div class="mod-img-overlay"></div>
                    </div>
                    <div class="mod-content">
                        <span class="mod-tag tag-cyan">Staff</span>
                        <h2 class="mod-title">Doctors</h2>
                        <p class="mod-desc">Manage physician profiles, specializations, schedules, and availability across departments.</p>
                        <div class="mod-footer">
                            <span class="mod-count"><span>34</span> registered</span>
                            <span class="mod-arrow"><i class="bi bi-arrow-up-right"></i></span>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-4 col-md-6">
                <a href="/patient.jsp" class="mod-card">
                    <div class="mod-img-wrapper">
                        <img src="img/patient(1).png" alt="Patients Module" class="mod-img">
                        <div class="mod-img-overlay"></div>
                    </div>
                    <div class="mod-content">
                        <span class="mod-tag tag-green">Records</span>
                        <h2 class="mod-title">Patients</h2>
                        <p class="mod-desc">Access and update patient records, medical history, diagnoses, and treatment plans.</p>
                        <div class="mod-footer">
                            <span class="mod-count"><span>1,248</span> total</span>
                            <span class="mod-arrow"><i class="bi bi-arrow-up-right"></i></span>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-4 col-md-6">
                <a href="/appointments.jsp" class="mod-card">
                    <div class="mod-img-wrapper">
                        <img src="img/appointment.png" alt="Appointments Module" class="mod-img">
                        <div class="mod-img-overlay"></div>
                    </div>
                    <div class="mod-content">
                        <span class="mod-tag tag-amber">Scheduling</span>
                        <h2 class="mod-title">Appointments</h2>
                        <p class="mod-desc">Schedule, reschedule, and track appointments between doctors and patients.</p>
                        <div class="mod-footer">
                            <span class="mod-count"><span>87</span> today</span>
                            <span class="mod-arrow"><i class="bi bi-arrow-up-right"></i></span>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-4 col-md-6">
                <a href="/pharmacy.jsp" class="mod-card">
                    <div class="mod-img-wrapper">
                        <img src="img/pharmacy.png" alt="Pharmacy Module" class="mod-img">
                        <div class="mod-img-overlay"></div>
                    </div>
                    <div class="mod-content">
                        <span class="mod-tag tag-purple">Inventory</span>
                        <h2 class="mod-title">Pharmacy</h2>
                        <p class="mod-desc">Track medicine stock, prescriptions, dispensing history, and supplier orders.</p>
                        <div class="mod-footer">
                            <span class="mod-count"><span>412</span> items</span>
                            <span class="mod-arrow"><i class="bi bi-arrow-up-right"></i></span>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-4 col-md-6">
                <a href="/lab.jsp" class="mod-card">
                    <div class="mod-img-wrapper">
                        <img src="img/labTest.png" alt="Lab Module" class="mod-img">
                        <div class="mod-img-overlay"></div>
                    </div>
                    <div class="mod-content">
                        <span class="mod-tag tag-red">Diagnostics</span>
                        <h2 class="mod-title">Lab &amp; Reports</h2>
                        <p class="mod-desc">Manage lab tests, diagnostic reports, and pathology results for all patients.</p>
                        <div class="mod-footer">
                            <span class="mod-count"><span>156</span> pending</span>
                            <span class="mod-arrow"><i class="bi bi-arrow-up-right"></i></span>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-4 col-md-6">
                <a href="/bill.jsp" class="mod-card">
                    <div class="mod-img-wrapper">
                        <img src="img/report.png" alt="Billing Module" class="mod-img">
                        <div class="mod-img-overlay"></div>
                    </div>
                    <div class="mod-content">
                        <span class="mod-tag tag-indigo">Finance</span>
                        <h2 class="mod-title">Billing</h2>
                        <p class="mod-desc">Generate invoices, process insurance claims, and manage payment history.</p>
                        <div class="mod-footer">
                            <span class="mod-count"><span>$24.5K</span> today</span>
                            <span class="mod-arrow"><i class="bi bi-arrow-up-right"></i></span>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </section>

    <!-- ACTIVITY + QUICK ACTIONS -->
    <section class="container-xl px-3 px-lg-4 mb-4 position-relative z-1">
        <div class="row g-3 g-lg-4">
            <div class="col-lg-8">
                <div class="side-panel">
                    <p class="panel-title"><i class="bi bi-activity" style="color:var(--accent);"></i> Recent Activity</p>
                    <div class="activity-item">
                        <div class="act-icon cyan"><i class="bi bi-person-plus"></i></div>
                        <div class="act-content">
                            <p class="act-title">New patient registered</p>
                            <p class="act-sub">Priya Sharma - OPD Ward B</p>
                        </div>
                        <span class="act-time">2 min ago</span>
                    </div>
                    <div class="activity-item">
                        <div class="act-icon green"><i class="bi bi-calendar-check"></i></div>
                        <div class="act-content">
                            <p class="act-title">Appointment confirmed</p>
                            <p class="act-sub">Dr. Mehta - Cardiology - 11:30 AM</p>
                        </div>
                        <span class="act-time">8 min ago</span>
                    </div>
                    <div class="activity-item">
                        <div class="act-icon amber"><i class="bi bi-capsule"></i></div>
                        <div class="act-content">
                            <p class="act-title">Prescription issued</p>
                            <p class="act-sub">Patient #1042 - Amoxicillin 500mg</p>
                        </div>
                        <span class="act-time">15 min ago</span>
                    </div>
                    <div class="activity-item">
                        <div class="act-icon red"><i class="bi bi-exclamation-triangle"></i></div>
                        <div class="act-content">
                            <p class="act-title">Emergency admission</p>
                            <p class="act-sub">ICU Bed 4 assigned - Critical</p>
                        </div>
                        <span class="act-time">22 min ago</span>
                    </div>
                    <div class="activity-item">
                        <div class="act-icon purple"><i class="bi bi-file-earmark-medical"></i></div>
                        <div class="act-content">
                            <p class="act-title">Lab report uploaded</p>
                            <p class="act-sub">Patient #0987 - Blood CBC panel</p>
                        </div>
                        <span class="act-time">41 min ago</span>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="side-panel">
                    <p class="panel-title"><i class="bi bi-lightning-charge-fill" style="color:var(--accent4);"></i> Quick Actions</p>
                    <a href="/patient.jsp" class="quick-btn"><i class="bi bi-person-plus-fill" style="color:var(--accent);"></i> Register New Patient</a>
                    <a href="/appointments.jsp" class="quick-btn"><i class="bi bi-calendar-plus-fill" style="color:var(--accent4);"></i> Book Appointment</a>
                    <a href="/lab.jsp" class="quick-btn"><i class="bi bi-clipboard2-plus-fill" style="color:var(--accent5);"></i> Request Lab Test</a>
                    <a href="/pharmacy.jsp" class="quick-btn"><i class="bi bi-capsule-pill" style="color:#a78bfa;"></i> Issue Medicine</a>
                    <a href="/billing.jsp" class="quick-btn"><i class="bi bi-receipt" style="color:var(--accent3);"></i> Generate Invoice</a>
                    <a href="/reports.jsp" class="quick-btn"><i class="bi bi-download" style="color:var(--muted);"></i> Export Reports</a>
                </div>
            </div>
        </div>
    </section>

    <!-- TECH STRIP -->
    <section class="container-xl px-3 px-lg-4 position-relative z-1">
        <div class="tech-strip">
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
    </section>

    <!-- FOOTER -->
    <footer class="position-relative z-1">
        <strong>MediCore HMS</strong> &nbsp;-&nbsp; Built with Java EE - JSP - Servlets &nbsp;-&nbsp; 2025
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Live Clock
        function tick() {
            document.getElementById('liveClock').textContent =
                new Date().toLocaleTimeString('en-IN', { hour12: false });
        }
        tick();
        setInterval(tick, 1000);

        // Smooth scroll for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });
    </script>
</body>

</html>
