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
    <link href="../css/medicore.css" rel="stylesheet">
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
            <button
                  class="theme-toggle"
                  id="themeToggle"
                  aria-label="Toggle light / dark theme"
                  title="Toggle theme">
                  <i class="bi bi-moon-stars-fill icon-moon" aria-hidden="true"></i>
                  <i class="bi bi-sun-fill icon-sun" aria-hidden="true"></i>
            </button>
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
                <a href="/billing.jsp" class="mod-card">
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