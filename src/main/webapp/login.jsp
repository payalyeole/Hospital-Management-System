<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-4">

            <div class="card shadow">
                <div class="card-header text-center bg-primary text-white">
                    <h5>Login</h5>
                </div>

                <div class="card-body">
                    <form method="post" action="/login">
                        <div class="mb-3">
                            <input type="text" name="username" class="form-control" placeholder="Username" required>
                        </div>

                        <div class="mb-3">
                            <input type="password" name="password" class="form-control" placeholder="Password" required>
                        </div>

                        <button class="btn btn-primary w-100">Login</button>
                    </form>

                    <c:if test="${param.error != null}">
                        <p class="text-danger text-center mt-2">Invalid credentials</p>
                    </c:if>
                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>
