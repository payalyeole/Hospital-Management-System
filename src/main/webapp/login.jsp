<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Hospital Management System</title>
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

    <div class="login-container">

        <div class="auth-header">
            <h2>Welcome Back</h2>
            <p>Login to Hospital Management System</p>
        </div>

        <c:if test="${param.error != null}">
            <div class="alert alert-error">
                <i class="bi bi-exclamation-circle-fill"></i> Invalid username or password!
            </div>
        </c:if>

        <c:if test="${param.registered != null}">
            <div class="alert alert-success">
                <i class="bi bi-check-circle-fill"></i> Registration successful! Please login.
            </div>
        </c:if>

        <form method="post" action="/login">

            <div class="form-group">
                <input type="text" name="username" class="form-control"
                       placeholder="Username" required>
                <i class="bi bi-person"></i>
            </div>

            <div class="form-group">
                <input type="password" name="password" class="form-control"
                       placeholder="Password" required>
                <i class="bi bi-lock"></i>
            </div>

            <button type="submit" class="btn-login">Login Securely</button>

        </form>

        <div class="auth-footer">
            Don't have an account? <a href="/register">Create one</a>
        </div>

    </div>

</body>
</html>