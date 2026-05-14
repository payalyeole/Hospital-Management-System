<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Hospital Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }
        body {
            background: linear-gradient(135deg, #e0c3fc 0%, #8ec5fc 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .register-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transform: translateY(0);
            transition: all 0.3s ease;
        }
        .register-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        .header h2 {
            color: #2c3e50;
            font-weight: 700;
            font-size: 28px;
            margin-bottom: 10px;
        }
        .header p {
            color: #7f8c8d;
            font-size: 14px;
        }
        .form-group {
            margin-bottom: 20px;
            position: relative;
        }
        .form-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #95a5a6;
            transition: color 0.3s ease;
        }
        .form-control {
            width: 100%;
            padding: 15px 15px 15px 45px;
            border: 2px solid #e0e6ed;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s ease;
            outline: none;
            background: #f8fafc;
        }
        .form-control:focus {
            border-color: #9b59b6;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(155, 89, 182, 0.1);
        }
        .form-control:focus + i {
            color: #9b59b6;
        }
        .btn-register {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #9b59b6, #8e44ad);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(155, 89, 182, 0.3);
        }
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(155, 89, 182, 0.4);
            background: linear-gradient(135deg, #8e44ad, #732d91);
        }
        .alert {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            text-align: center;
        }
        .alert-error {
            background: #ffeaa7;
            color: #d63031;
            border: 1px solid #fdcb6e;
        }
        .footer {
            text-align: center;
            margin-top: 25px;
            color: #7f8c8d;
            font-size: 14px;
        }
        .footer a {
            color: #9b59b6;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }
        .footer a:hover {
            color: #8e44ad;
        }
        .hospital-icon {
            color: #9b59b6;
            font-size: 40px;
            margin-bottom: 15px;
            display: inline-block;
        }
    </style>
</head>
<body>

    <div class="register-container">
        <div class="header">
            <i class="fas fa-hospital-user hospital-icon"></i>
            <h2>Join Us</h2>
            <p>Create a new account</p>
        </div>

        <c:if test="${param.error != null}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> Username is already taken!
            </div>
        </c:if>

        <form method="post" action="/register">
            <div class="form-group">
                <i class="fas fa-user"></i>
                <input type="text" name="username" class="form-control" placeholder="Choose a Username" required>
            </div>

            <div class="form-group">
                <i class="fas fa-lock"></i>
                <input type="password" name="password" class="form-control" placeholder="Create a Password" required>
            </div>

            <button type="submit" class="btn-register">Register Now</button>
        </form>

        <div class="footer">
            Already have an account? <a href="/login">Login here</a>
        </div>
    </div>

</body>
</html>
