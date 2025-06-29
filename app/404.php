<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>404 Not Found | Todo App</title>
    <style>
    body {
        background: #f4f6fb;
        font-family: 'Segoe UI', Arial, sans-serif;
        margin: 0;
        padding: 0;
    }

    .notfound-container {
        max-width: 420px;
        margin: 80px auto;
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 2px 16px rgba(0, 0, 0, 0.08);
        text-align: center;
        padding: 40px 30px 32px 30px;
    }

    .notfound-title {
        font-size: 3.2rem;
        color: #007bff;
        margin-bottom: 10px;
        font-weight: bold;
        letter-spacing: 2px;
    }

    .notfound-message {
        color: #444;
        font-size: 1.2rem;
        margin-bottom: 18px;
    }

    .notfound-home {
        display: inline-block;
        margin-top: 18px;
        padding: 10px 22px;
        background: #007bff;
        color: #fff;
        border-radius: 6px;
        text-decoration: none;
        font-size: 1.08rem;
        transition: background 0.2s;
    }

    .notfound-home:hover {
        background: #0056b3;
    }

    .notfound-emoji {
        font-size: 2.2rem;
        margin-bottom: 10px;
    }
    </style>
</head>

<body>
    <div class="notfound-container">
        <div class="notfound-emoji">😕</div>
        <div class="notfound-title">404</div>
        <div class="notfound-message">
            Oops! The page you’re looking for doesn’t exist.<br>
            Maybe you mistyped the address or the page has moved.
        </div>
        <a class="notfound-home" href="/home.php">Go to Home</a>
    </div>
</body>

</html>