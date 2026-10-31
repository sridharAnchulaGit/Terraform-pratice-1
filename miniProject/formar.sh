#!/bin/bash

yum install -y httpd

systemctl start httpd

systemctl enable httpd

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Farmer Connect</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #E3F2FD;
            color: #263238;
            text-align: center;
        }

        header {
            background: #1565C0;
            color: white;
            padding: 25px;
        }

        header h1 {
            margin: 0;
            font-size: 38px;
        }

        .hero {
            padding: 70px 20px;
        }

        .hero h2 {
            color: #1565C0;
            font-size: 32px;
        }

        .hero p {
            font-size: 19px;
            max-width: 700px;
            margin: 20px auto;
            line-height: 1.6;
        }

        .button {
            background: #FF8F00;
            color: white;
            padding: 15px 30px;
            border: none;
            border-radius: 25px;
            font-size: 18px;
            cursor: pointer;
        }

        .button:hover {
            background: #EF6C00;
        }

        .cards {
            display: flex;
            justify-content: center;
            gap: 25px;
            padding: 30px;
            flex-wrap: wrap;
        }

        .card {
            background: white;
            width: 220px;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        }

        .card h3 {
            color: #1565C0;
        }

        footer {
            background: #0D47A1;
            color: white;
            padding: 20px;
            margin-top: 50px;
        }

        footer p {
            margin: 0;
        }
    </style>
</head>

<body>

    <header>
        <h1>🌾 Farmer Connect 🌾</h1>
    </header>

    <section class="hero">

        <h2>Welcome Farmers! 👨‍🌾</h2>

        <p>
            Welcome to Farmer Connect, a simple platform created to
            support farmers with useful agricultural information,
            farming techniques, weather updates, and crop guidance.
        </p>

        <button class="button">
            Start Farming
        </button>

    </section>

    <section class="cards">

        <div class="card">
            <h3>🌱 Crops</h3>
            <p>Learn about different crops and better farming methods.</p>
        </div>

        <div class="card">
            <h3>☀️ Weather</h3>
            <p>Stay updated with important weather information.</p>
        </div>

        <div class="card">
            <h3>🚜 Technology</h3>
            <p>Discover modern technologies for agriculture.</p>
        </div>

    </section>

    <footer>
        <p>© 2026 Farmer Connect | Grow Better, Farm Better 🌱</p>
    </footer>

</body>
</html>
EOF