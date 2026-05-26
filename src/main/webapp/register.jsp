<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Hospital Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600&family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="../css/medicore.css" rel="stylesheet">
    <script>
        (function () {
            var t = localStorage.getItem("medicore-theme");
            if (!t) t = window.matchMedia("(prefers-color-scheme: light)").matches ? "light" : "dark";
            document.documentElement.setAttribute("data-theme", t);
        })();
    </script>
</head>
<body class="auth-body">

    <div class="register-container">

        <div class="auth-header">
            <i class="bi bi-person-plus-fill hospital-icon" style="color:var(--accent2);"></i>
            <h2>Join Us</h2>
            <p>Create a new account</p>
        </div>

        <c:if test="${param.error != null}">
            <div class="alert alert-error">
                <i class="bi bi-exclamation-circle-fill"></i> Username is already taken!
            </div>
        </c:if>

        <form method="post" action="/register">

            <div class="form-group">
                <input type="text" name="username" class="form-control"
                       placeholder="Choose a Username" required>
                <i class="bi bi-person"></i>
            </div>

            <div class="form-group">
                <input type="password" name="password" class="form-control"
                       placeholder="Create a Password" required>
                <i class="bi bi-lock"></i>
            </div>

            <button type="submit" class="btn-register">Register Now</button>

        </form>

        <div class="auth-footer">
            Already have an account? <a href="/login">Login here</a>
        </div>

    </div>

</body>
</html>